import polib


class TranslationChecker(object):

    def __init__(self, locale, filename, translation_threshold=100):
        self.locale = locale
        self.filename = filename
        self.po = polib.pofile('locale/%s/LC_MESSAGES/%s' % (self.locale, self.filename))
        self.translation_threshold = translation_threshold

    def percent_translated(self):
        return self.po.percent_translated()

    def percent_untranslated(self):
        return self.po.percent_untranslated()

    def fuzzy_entries(self):
        return self.po.fuzzy_entries()

    def obsolete_entries(self):
        return self.po.obsolete_entries()
	
    def flags(self):
        return self.po.flags

    def success(self):
        return (self.percent_translated() >= self.translation_threshold and 
        		len(self.fuzzy_entries()) == 0)
