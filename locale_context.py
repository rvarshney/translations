# -*- coding: utf-8 -*-
from django.utils.translation import activate, get_language


"""
Locale Context, context manager used when you would like to temporarily
switch outside of the currently defined language. This is most useful
for translation tests.

For example,

    def test_translation(self):
        # Activate translation to test French locale
        with locale_context("translation_test", "fr"):
            french_text = _("English")
            self.assertTrue(u'Ḗƞɠŀīşħ' in french_text)
"""
class locale_context(object):

    def __init__(self, context_name, locale):
        self.context_name = context_name
        self.locale = locale

    def __enter__(self):
        # Save the original locale
        self.original_locale = get_language()
        print "Switching locale from %s to %s" % (self.original_locale, self.locale)
        try:
            activate(self.locale)
        except Exception as e:
            print "Trying to activate unknown language %s" % self.locale

    def __exit__(self, type, value, traceback):
        # Restore the original locale
        activate(self.original_locale)
        print "Switching locale from %s to %s" % (self.locale, self.original_locale)

