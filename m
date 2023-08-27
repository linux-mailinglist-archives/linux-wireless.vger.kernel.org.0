Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C489789D1D
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 13:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjH0LGA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 07:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjH0LF5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 07:05:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC5186
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693134355; x=1724670355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vU5b38Ck1WimHSHzTYUARZfN97FpOsGIAEVzfJxjuBs=;
  b=FQgBn9J7v8e4lPb4la/UG69WsAX+rPBOTQjLOw12hDHZvK5ak+rCvMHC
   w4u4rIGYcJo/DWHgyrxREflzvneVlS0nzlaQ6YHty4zLKZXYGhyaJI+TQ
   Lbg9A7WxsAfZ9NKCdWws1izxZ9zTgBq6o9SmVO4756tO92uwk4MNea+15
   02R03ecWMsxH7lBnEfTih2gLilLEu+qAbBfo8hDJheB/1mVDI9C2EwK4n
   BKtWFVPlihlujBLB3cUwJbEGFwtDgwWsEF6xb+qa9CN7G534LrNtBrosn
   623ZhF3yj+JVO25gOu5ispfE3PPv1rxgiPuGF7TJubqHQHTOaFlpHq1PX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10814"; a="461301543"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="461301543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881632966"
Received: from ishamsi-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.186.7])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 04:05:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: mac80211: add an element parsing unit test
Date:   Sun, 27 Aug 2023 14:05:21 +0300
Message-Id: <20230827135854.333bc75df13f.I0ddfeb6a88a4d89e7c7850e8ef45a4b19b5a061a@changeid>
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

Add a unit test for the parsing of a fragmented sta profile
sub-element inside a fragmented multi-link element.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/Kconfig        |  11 ++++
 net/mac80211/Makefile       |   2 +
 net/mac80211/tests/Makefile |   3 ++
 net/mac80211/tests/elems.c  | 101 ++++++++++++++++++++++++++++++++++++
 net/mac80211/tests/module.c |  10 ++++
 net/mac80211/util.c         |   3 ++
 6 files changed, 130 insertions(+)
 create mode 100644 net/mac80211/tests/Makefile
 create mode 100644 net/mac80211/tests/elems.c
 create mode 100644 net/mac80211/tests/module.c

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 51ec8256b7fa..037ab74f5ade 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -57,6 +57,17 @@ endif
 comment "Some wireless drivers require a rate control algorithm"
 	depends on MAC80211 && MAC80211_HAS_RC=n
 
+config MAC80211_KUNIT_TEST
+	tristate "KUnit tests for mac80211" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on MAC80211
+	default KUNIT_ALL_TESTS
+	depends on !KERNEL_6_2
+	help
+	  Enable this option to test mac80211 internals with kunit.
+
+	  If unsure, say N.
+
 config MAC80211_MESH
 	bool "Enable mac80211 mesh networking support"
 	depends on MAC80211
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index b8de44da1fb8..c9eb52768133 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -65,4 +65,6 @@ rc80211_minstrel-$(CONFIG_MAC80211_DEBUGFS) += \
 
 mac80211-$(CONFIG_MAC80211_RC_MINSTREL) += $(rc80211_minstrel-y)
 
+obj-y += tests/
+
 ccflags-y += -DDEBUG
diff --git a/net/mac80211/tests/Makefile b/net/mac80211/tests/Makefile
new file mode 100644
index 000000000000..4814584f8a14
--- /dev/null
+++ b/net/mac80211/tests/Makefile
@@ -0,0 +1,3 @@
+mac80211-tests-y += module.o elems.o
+
+obj-$(CONFIG_MAC80211_KUNIT_TEST) += mac80211-tests.o
diff --git a/net/mac80211/tests/elems.c b/net/mac80211/tests/elems.c
new file mode 100644
index 000000000000..997d0cd27b2d
--- /dev/null
+++ b/net/mac80211/tests/elems.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for element parsing
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <kunit/test.h>
+#include "../ieee80211_i.h"
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+static void mle_defrag(struct kunit *test)
+{
+	struct ieee80211_elems_parse_params parse_params = {
+		.link_id = 12,
+		.from_ap = true,
+	};
+	struct ieee802_11_elems *parsed;
+	struct sk_buff *skb;
+	u8 *len_mle, *len_prof;
+	int i;
+
+	skb = alloc_skb(1024, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+
+	if (skb_pad(skb, skb_tailroom(skb))) {
+		KUNIT_FAIL(test, "failed to pad skb");
+		return;
+	}
+
+	/* build a multi-link element */
+	skb_put_u8(skb, WLAN_EID_EXTENSION);
+	len_mle = skb_put(skb, 1);
+	skb_put_u8(skb, WLAN_EID_EXT_EHT_MULTI_LINK);
+
+	put_unaligned_le16(IEEE80211_ML_CONTROL_TYPE_BASIC,
+			   skb_put(skb, 2));
+	/* struct ieee80211_mle_basic_common_info */
+	skb_put_u8(skb, 7); /* includes len field */
+	skb_put_data(skb, "\x00\x00\x00\x00\x00\x00", ETH_ALEN); /* MLD addr */
+
+	/* with a STA profile inside */
+	skb_put_u8(skb, IEEE80211_MLE_SUBELEM_PER_STA_PROFILE);
+	len_prof = skb_put(skb, 1);
+	put_unaligned_le16(IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE |
+			   parse_params.link_id,
+			   skb_put(skb, 2));
+	skb_put_u8(skb, 1); /* fake sta_info_len - includes itself */
+	/* put a bunch of useless elements into it */
+	for (i = 0; i < 20; i++) {
+		skb_put_u8(skb, WLAN_EID_SSID);
+		skb_put_u8(skb, 20);
+		skb_put(skb, 20);
+	}
+
+	/* fragment STA profile */
+	ieee80211_fragment_element(skb, len_prof,
+				   IEEE80211_MLE_SUBELEM_FRAGMENT);
+	/* fragment MLE */
+	ieee80211_fragment_element(skb, len_mle, WLAN_EID_FRAGMENT);
+
+	parse_params.start = skb->data;
+	parse_params.len = skb->len;
+	parsed = ieee802_11_parse_elems_full(&parse_params);
+	/* should return ERR_PTR or valid, not NULL */
+	KUNIT_EXPECT_NOT_NULL(test, parsed);
+
+	if (IS_ERR_OR_NULL(parsed))
+		goto free_skb;
+
+	KUNIT_EXPECT_NOT_NULL(test, parsed->ml_basic_elem);
+	KUNIT_EXPECT_EQ(test,
+			parsed->ml_basic_len,
+			2 /* control */ +
+			7 /* common info */ +
+			2 /* sta profile element header */ +
+			3 /* sta profile header */ +
+			20 * 22 /* sta profile data */ +
+			2 /* sta profile fragment element */);
+	KUNIT_EXPECT_NOT_NULL(test, parsed->prof);
+	KUNIT_EXPECT_EQ(test,
+			parsed->sta_prof_len,
+			3 /* sta profile header */ +
+			20 * 22 /* sta profile data */);
+
+	kfree(parsed);
+free_skb:
+	kfree_skb(skb);
+}
+
+static struct kunit_case element_parsing_test_cases[] = {
+	KUNIT_CASE(mle_defrag),
+	{}
+};
+
+static struct kunit_suite element_parsing = {
+	.name = "mac80211-element-parsing",
+	.test_cases = element_parsing_test_cases,
+};
+
+kunit_test_suite(element_parsing);
diff --git a/net/mac80211/tests/module.c b/net/mac80211/tests/module.c
new file mode 100644
index 000000000000..9d05f2943935
--- /dev/null
+++ b/net/mac80211/tests/module.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This is just module boilerplate for the mac80211 kunit module.
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <linux/module.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("tests for mac80211");
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8a6917cf63cf..d430093d14af 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -24,6 +24,7 @@
 #include <net/net_namespace.h>
 #include <net/cfg80211.h>
 #include <net/rtnetlink.h>
+#include <kunit/visibility.h>
 
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -1654,6 +1655,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 
 	return elems;
 }
+EXPORT_SYMBOL_IF_KUNIT(ieee802_11_parse_elems_full);
 
 void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 					   struct ieee80211_tx_queue_params
@@ -5146,3 +5148,4 @@ void ieee80211_fragment_element(struct sk_buff *skb, u8 *len_pos, u8 frag_id)
 
 	*len_pos = elem_len;
 }
+EXPORT_SYMBOL_IF_KUNIT(ieee80211_fragment_element);
-- 
2.38.1

