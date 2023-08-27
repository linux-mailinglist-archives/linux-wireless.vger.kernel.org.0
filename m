Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72E789D1A
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjH0LGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjH0LFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:05:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3006E139
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134353; x=1724670353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8zXfEqbWqEjKvRtdL9L+U6FklCIe7MW+IBZ4c8VhFtg=;
  b=e0XgDxMbm6dhRfpCxzL6PnmVn/5mz2uaV5eUqrqjuhz0QereXFT48FZb
   CMIHe2EBoNG9dqoJhUAA3u+VRNcZLFf4Em9cO5Dq2OqCkxBNAM/0gtLUL
   8JFn2hrxwg+L8cmiYzKjpNhXXNa7vKQIGxQndm5t2r9VU/sqSemBF7Mbm
   gEZtfgMvJRRxJDgsSPmgHzpeexvvaLDQtvQJGIaWZCeovO00JJDhXjG6r
   sagLtj9fzFrrTmtGyjDC9mThZty0XG6rYdvwuVYJdjv5GKQM+cucd2gH/
   zXySj0bv/m4ZSxt7K0sqSa0T1zxzfd1bjrM+dMedIkpgKTVJjkbDZ1ARe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301541"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301541"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632958"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:56 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: cfg80211: add first kunit tests, for element defrag
Date:   Sun, 27 Aug 2023 14:05:20 +0300
Message-Id: <20230827135854.e2a5cead1816.I09f0edc19d162b54ee330991c728c1e9aa42ebf6@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230827110532.348304-1-gregory.greenman@intel.com>
References: <20230827110532.348304-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a couple of tests for element defragmentation, to
see that the function works correctly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/Kconfig               |  11 ++
 net/wireless/Makefile              |   1 +
 net/wireless/tests/Makefile        |   3 +
 net/wireless/tests/fragmentation.c | 157 +++++++++++++++++++++++++++++
 net/wireless/tests/module.c        |  10 ++
 5 files changed, 182 insertions(+)
 create mode 100644 net/wireless/tests/Makefile
 create mode 100644 net/wireless/tests/fragmentation.c
 create mode 100644 net/wireless/tests/module.c

diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index f620acd2a0f5..a9ac85e09af3 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -201,6 +201,17 @@ config CFG80211_WEXT_EXPORT
 	  Drivers should select this option if they require cfg80211's
 	  wext compatibility symbols to be exported.
 
+config CFG80211_KUNIT_TEST
+	tristate "KUnit tests for cfg80211" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on CFG80211
+	default KUNIT_ALL_TESTS
+	depends on !KERNEL_6_2
+	help
+	  Enable this option to test cfg80211 functions with kunit.
+
+	  If unsure, say N.
+
 endif # CFG80211
 
 config LIB80211
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 527ae669f6f7..089c841528c8 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_LIB80211) += lib80211.o
 obj-$(CONFIG_LIB80211_CRYPT_WEP) += lib80211_crypt_wep.o
 obj-$(CONFIG_LIB80211_CRYPT_CCMP) += lib80211_crypt_ccmp.o
 obj-$(CONFIG_LIB80211_CRYPT_TKIP) += lib80211_crypt_tkip.o
+obj-y += tests/
 
 obj-$(CONFIG_WEXT_CORE) += wext-core.o
 obj-$(CONFIG_WEXT_PROC) += wext-proc.o
diff --git a/net/wireless/tests/Makefile b/net/wireless/tests/Makefile
new file mode 100644
index 000000000000..fa8e297bbc5e
--- /dev/null
+++ b/net/wireless/tests/Makefile
@@ -0,0 +1,3 @@
+cfg80211-tests-y += module.o fragmentation.o
+
+obj-$(CONFIG_CFG80211_KUNIT_TEST) += cfg80211-tests.o
diff --git a/net/wireless/tests/fragmentation.c b/net/wireless/tests/fragmentation.c
new file mode 100644
index 000000000000..49a339ca8880
--- /dev/null
+++ b/net/wireless/tests/fragmentation.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for element fragmentation
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <linux/ieee80211.h>
+#include <net/cfg80211.h>
+#include <kunit/test.h>
+
+static void defragment_0(struct kunit *test)
+{
+	ssize_t ret;
+	static const u8 input[] = {
+		[0] = WLAN_EID_EXTENSION,
+		[1] = 254,
+		[2] = WLAN_EID_EXT_EHT_MULTI_LINK,
+		[27] = 27,
+		[123] = 123,
+		[254 + 2] = WLAN_EID_FRAGMENT,
+		[254 + 3] = 7,
+		[254 + 3 + 7] = 0, /* for size */
+	};
+	u8 *data = kunit_kzalloc(test, sizeof(input), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, data);
+
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, sizeof(input),
+					  WLAN_EID_FRAGMENT);
+	KUNIT_EXPECT_EQ(test, ret, 253);
+	KUNIT_EXPECT_MEMEQ(test, data, input + 3, 253);
+}
+
+static void defragment_1(struct kunit *test)
+{
+	ssize_t ret;
+	static const u8 input[] = {
+		[0] = WLAN_EID_EXTENSION,
+		[1] = 255,
+		[2] = WLAN_EID_EXT_EHT_MULTI_LINK,
+		[27] = 27,
+		[123] = 123,
+		[255 + 2] = WLAN_EID_FRAGMENT,
+		[255 + 3] = 7,
+		[255 + 3 + 1] = 0xaa,
+		[255 + 3 + 8] = WLAN_EID_FRAGMENT, /* not used */
+		[255 + 3 + 9] = 1,
+		[255 + 3 + 10] = 0, /* for size */
+	};
+	u8 *data = kunit_kzalloc(test, sizeof(input), GFP_KERNEL);
+	const struct element *elem;
+	int count = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, data);
+
+	for_each_element(elem, input, sizeof(input))
+		count++;
+
+	/* check the elements are right */
+	KUNIT_ASSERT_EQ(test, count, 3);
+
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, sizeof(input),
+					  WLAN_EID_FRAGMENT);
+	/* this means the last fragment was not used */
+	KUNIT_EXPECT_EQ(test, ret, 254 + 7);
+	KUNIT_EXPECT_MEMEQ(test, data, input + 3, 254);
+	KUNIT_EXPECT_MEMEQ(test, data + 254, input + 255 + 4, 7);
+}
+
+static void defragment_2(struct kunit *test)
+{
+	ssize_t ret;
+	static const u8 input[] = {
+		[0] = WLAN_EID_EXTENSION,
+		[1] = 255,
+		[2] = WLAN_EID_EXT_EHT_MULTI_LINK,
+		[27] = 27,
+		[123] = 123,
+
+		[257 + 0] = WLAN_EID_FRAGMENT,
+		[257 + 1] = 255,
+		[257 + 20] = 0xaa,
+
+		[2 * 257 + 0] = WLAN_EID_FRAGMENT,
+		[2 * 257 + 1] = 1,
+		[2 * 257 + 2] = 0xcc,
+		[2 * 257 + 3] = WLAN_EID_FRAGMENT, /* not used */
+		[2 * 257 + 4] = 1,
+		[2 * 257 + 5] = 0, /* for size */
+	};
+	u8 *data = kunit_kzalloc(test, sizeof(input), GFP_KERNEL);
+	const struct element *elem;
+	int count = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, data);
+
+	for_each_element(elem, input, sizeof(input))
+		count++;
+
+	/* check the elements are right */
+	KUNIT_ASSERT_EQ(test, count, 4);
+
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, sizeof(input),
+					  WLAN_EID_FRAGMENT);
+	/* this means the last fragment was not used */
+	KUNIT_EXPECT_EQ(test, ret, 254 + 255 + 1);
+	KUNIT_EXPECT_MEMEQ(test, data, input + 3, 254);
+	KUNIT_EXPECT_MEMEQ(test, data + 254, input + 257 + 2, 255);
+	KUNIT_EXPECT_MEMEQ(test, data + 254 + 255, input + 2 * 257 + 2, 1);
+}
+
+static void defragment_at_end(struct kunit *test)
+{
+	ssize_t ret;
+	static const u8 input[] = {
+		[0] = WLAN_EID_EXTENSION,
+		[1] = 255,
+		[2] = WLAN_EID_EXT_EHT_MULTI_LINK,
+		[27] = 27,
+		[123] = 123,
+		[255 + 2] = WLAN_EID_FRAGMENT,
+		[255 + 3] = 7,
+		[255 + 3 + 7] = 0, /* for size */
+	};
+	u8 *data = kunit_kzalloc(test, sizeof(input), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, data);
+
+	ret = cfg80211_defragment_element((void *)input,
+					  input, sizeof(input),
+					  data, sizeof(input),
+					  WLAN_EID_FRAGMENT);
+	KUNIT_EXPECT_EQ(test, ret, 254 + 7);
+	KUNIT_EXPECT_MEMEQ(test, data, input + 3, 254);
+	KUNIT_EXPECT_MEMEQ(test, data + 254, input + 255 + 4, 7);
+}
+
+static struct kunit_case element_fragmentation_test_cases[] = {
+	KUNIT_CASE(defragment_0),
+	KUNIT_CASE(defragment_1),
+	KUNIT_CASE(defragment_2),
+	KUNIT_CASE(defragment_at_end),
+	{}
+};
+
+static struct kunit_suite element_fragmentation = {
+	.name = "cfg80211-element-defragmentation",
+	.test_cases = element_fragmentation_test_cases,
+};
+
+kunit_test_suite(element_fragmentation);
diff --git a/net/wireless/tests/module.c b/net/wireless/tests/module.c
new file mode 100644
index 000000000000..9ff7b2c12312
--- /dev/null
+++ b/net/wireless/tests/module.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This is just module boilerplate for the cfg80211 kunit module.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <linux/module.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("tests for cfg80211");
-- 
2.38.1

