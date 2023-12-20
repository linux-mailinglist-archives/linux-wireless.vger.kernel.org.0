Return-Path: <linux-wireless+bounces-1100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE85781A244
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 16:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9729728228B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C644776B;
	Wed, 20 Dec 2023 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EgIS4vAj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F246B96;
	Wed, 20 Dec 2023 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vDoi48c6YijWrTJ1H+0Z9OKmNXfSM1XSRKLmr7JopWM=;
	t=1703085605; x=1704295205; b=EgIS4vAjADdfkhLXLUjyu0vysKaOPfijpfTKnHP0RIg1GYp
	OrG4btvDGO+5ZvesFWIaSPrlGHAJhSf+sgYNl9ZMMrsCORQQ4of2Q/7powgjjdMGiQK1nPqT2/53B
	q6m6SKlvUovr2xA4/Ng60AzY8yD5JqtnNh3eVdCwjgK5CyPK8m8O7PrvqDjWUtwpJAUKS2MUIvcVP
	7ibThpLiVHbdarJB0iKCo7BtEXqfRwn03zh5/gfpXtjj/s7Yhyo5eRp9N2hMECZasMx2+dnU3OSG6
	O7gIDl0MAbI3LvIuCXigqLID+fpMGURSorJfjzqeGUmy61UFORBMhRhHwd/YeO/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rFyMc-00000001WFz-3A3Z;
	Wed, 20 Dec 2023 16:20:03 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/6] wifi: cfg80211: tests: add some scanning related tests
Date: Wed, 20 Dec 2023 16:19:52 +0100
Message-ID: <20231220151952.415232-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220151952.415232-1-benjamin@sipsolutions.net>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This adds some scanning related tests, mainly exercising the ML element
parsing and inheritance.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.h         |  13 +-
 net/wireless/scan.c         |   9 +-
 net/wireless/tests/Makefile |   2 +-
 net/wireless/tests/scan.c   | 625 ++++++++++++++++++++++++++++++++++++
 net/wireless/tests/util.c   |  56 ++++
 net/wireless/tests/util.h   |  66 ++++
 6 files changed, 766 insertions(+), 5 deletions(-)
 create mode 100644 net/wireless/tests/scan.c
 create mode 100644 net/wireless/tests/util.c
 create mode 100644 net/wireless/tests/util.h

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 1963958263d2..13657a85cf61 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
@@ -549,4 +549,15 @@ int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
 				 struct wireless_dev *wdev);
 void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask);
 
+#if IS_ENABLED(CONFIG_CFG80211_KUNIT_TEST)
+#define EXPORT_SYMBOL_IF_CFG80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
+#define VISIBLE_IF_CFG80211_KUNIT
+size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
+			   const u8 *subie, size_t subie_len,
+			   u8 *new_ie, size_t new_ie_len);
+#else
+#define EXPORT_SYMBOL_IF_CFG80211_KUNIT(sym)
+#define VISIBLE_IF_CFG80211_KUNIT static
+#endif /* IS_ENABLED(CONFIG_CFG80211_KUNIT_TEST) */
+
 #endif /* __NET_WIRELESS_CORE_H */
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3d260c99c348..f6c0421f4d77 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -20,6 +20,7 @@
 #include <net/cfg80211.h>
 #include <net/cfg80211-wext.h>
 #include <net/iw_handler.h>
+#include <kunit/visibility.h>
 #include "core.h"
 #include "nl80211.h"
 #include "wext-compat.h"
@@ -303,9 +304,10 @@ static size_t cfg80211_copy_elem_with_frags(const struct element *elem,
 	return *pos - buf;
 }
 
-static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
-				  const u8 *subie, size_t subie_len,
-				  u8 *new_ie, size_t new_ie_len)
+VISIBLE_IF_CFG80211_KUNIT size_t
+cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
+		    const u8 *subie, size_t subie_len,
+		    u8 *new_ie, size_t new_ie_len)
 {
 	const struct element *non_inherit_elem, *parent, *sub;
 	u8 *pos = new_ie;
@@ -413,6 +415,7 @@ static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 
 	return pos - new_ie;
 }
+EXPORT_SYMBOL_IF_CFG80211_KUNIT(cfg80211_gen_new_ie);
 
 static bool is_bss(struct cfg80211_bss *a, const u8 *bssid,
 		   const u8 *ssid, size_t ssid_len)
diff --git a/net/wireless/tests/Makefile b/net/wireless/tests/Makefile
index fa8e297bbc5e..1f6622fcb758 100644
--- a/net/wireless/tests/Makefile
+++ b/net/wireless/tests/Makefile
@@ -1,3 +1,3 @@
-cfg80211-tests-y += module.o fragmentation.o
+cfg80211-tests-y += module.o fragmentation.o scan.o util.o
 
 obj-$(CONFIG_CFG80211_KUNIT_TEST) += cfg80211-tests.o
diff --git a/net/wireless/tests/scan.c b/net/wireless/tests/scan.c
new file mode 100644
index 000000000000..77854161cd22
--- /dev/null
+++ b/net/wireless/tests/scan.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for inform_bss functions
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <linux/ieee80211.h>
+#include <net/cfg80211.h>
+#include <kunit/test.h>
+#include <kunit/skbuff.h>
+#include "../core.h"
+#include "util.h"
+
+/* mac80211 helpers for element building */
+#include "../../mac80211/ieee80211_i.h"
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+struct test_elem {
+	u8 id;
+	u8 len;
+	union {
+		u8 data[255];
+		struct {
+			u8 eid;
+			u8 edata[254];
+		};
+	};
+};
+
+static struct gen_new_ie_case {
+	const char *desc;
+	struct test_elem parent_ies[16];
+	struct test_elem child_ies[16];
+	struct test_elem result_ies[16];
+} gen_new_ie_cases[] = {
+	{
+		.desc = "ML not inherited",
+		.parent_ies = {
+			{ .id = WLAN_EID_EXTENSION, .len = 255,
+			  .eid = WLAN_EID_EXT_EHT_MULTI_LINK },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+	},
+	{
+		.desc = "fragments are ignored if previous len not 255",
+		.parent_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 254, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_SSID, .len = 2 },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 254, },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+	},
+	{
+		.desc = "fragments inherited",
+		.parent_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 255, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 255, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+	},
+	{
+		.desc = "fragments copied",
+		.parent_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 255, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 255, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+	},
+	{
+		.desc = "multiple elements inherit",
+		.parent_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 255, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 123, },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 255, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 123, },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+	},
+	{
+		.desc = "one child element overrides",
+		.parent_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 255, },
+			{ .id = WLAN_EID_FRAGMENT, .len = 125, },
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 123, },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 127, },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_REDUCED_NEIGHBOR_REPORT, .len = 127, },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+	},
+	{
+		.desc = "empty elements from parent",
+		.parent_ies = {
+			{ .id = 0x1, .len = 0, },
+			{ .id = WLAN_EID_EXTENSION, .len = 1, .eid = 0x10 },
+		},
+		.child_ies = {
+		},
+		.result_ies = {
+			{ .id = 0x1, .len = 0, },
+			{ .id = WLAN_EID_EXTENSION, .len = 1, .eid = 0x10 },
+		},
+	},
+	{
+		.desc = "empty elements from child",
+		.parent_ies = {
+		},
+		.child_ies = {
+			{ .id = 0x1, .len = 0, },
+			{ .id = WLAN_EID_EXTENSION, .len = 1, .eid = 0x10 },
+		},
+		.result_ies = {
+			{ .id = 0x1, .len = 0, },
+			{ .id = WLAN_EID_EXTENSION, .len = 1, .eid = 0x10 },
+		},
+	},
+	{
+		.desc = "invalid extended elements ignored",
+		.parent_ies = {
+			{ .id = WLAN_EID_EXTENSION, .len = 0 },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_EXTENSION, .len = 0 },
+		},
+		.result_ies = {
+		},
+	},
+	{
+		.desc = "multiple extended elements",
+		.parent_ies = {
+			{ .id = WLAN_EID_EXTENSION, .len = 3,
+			  .eid = WLAN_EID_EXT_HE_CAPABILITY },
+			{ .id = WLAN_EID_EXTENSION, .len = 5,
+			  .eid = WLAN_EID_EXT_ASSOC_DELAY_INFO },
+			{ .id = WLAN_EID_EXTENSION, .len = 7,
+			  .eid = WLAN_EID_EXT_HE_OPERATION },
+			{ .id = WLAN_EID_EXTENSION, .len = 11,
+			  .eid = WLAN_EID_EXT_FILS_REQ_PARAMS },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_SSID, .len = 13 },
+			{ .id = WLAN_EID_EXTENSION, .len = 17,
+			  .eid = WLAN_EID_EXT_HE_CAPABILITY },
+			{ .id = WLAN_EID_EXTENSION, .len = 11,
+			  .eid = WLAN_EID_EXT_FILS_KEY_CONFIRM },
+			{ .id = WLAN_EID_EXTENSION, .len = 19,
+			  .eid = WLAN_EID_EXT_HE_OPERATION },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_EXTENSION, .len = 17,
+			  .eid = WLAN_EID_EXT_HE_CAPABILITY },
+			{ .id = WLAN_EID_EXTENSION, .len = 5,
+			  .eid = WLAN_EID_EXT_ASSOC_DELAY_INFO },
+			{ .id = WLAN_EID_EXTENSION, .len = 19,
+			  .eid = WLAN_EID_EXT_HE_OPERATION },
+			{ .id = WLAN_EID_EXTENSION, .len = 11,
+			  .eid = WLAN_EID_EXT_FILS_REQ_PARAMS },
+			{ .id = WLAN_EID_SSID, .len = 13 },
+			{ .id = WLAN_EID_EXTENSION, .len = 11,
+			  .eid = WLAN_EID_EXT_FILS_KEY_CONFIRM },
+		},
+	},
+	{
+		.desc = "non-inherit element",
+		.parent_ies = {
+			{ .id = 0x1, .len = 7, },
+			{ .id = 0x2, .len = 11, },
+			{ .id = 0x3, .len = 13, },
+			{ .id = WLAN_EID_EXTENSION, .len = 17, .eid = 0x10 },
+			{ .id = WLAN_EID_EXTENSION, .len = 19, .eid = 0x11 },
+			{ .id = WLAN_EID_EXTENSION, .len = 23, .eid = 0x12 },
+			{ .id = WLAN_EID_EXTENSION, .len = 29, .eid = 0x14 },
+		},
+		.child_ies = {
+			{ .id = WLAN_EID_EXTENSION,
+			  .eid = WLAN_EID_EXT_NON_INHERITANCE,
+			  .len = 10,
+			  .edata = { 0x3, 0x1, 0x2, 0x3,
+				     0x4, 0x10, 0x11, 0x13, 0x14 } },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+		.result_ies = {
+			{ .id = WLAN_EID_EXTENSION, .len = 23, .eid = 0x12 },
+			{ .id = WLAN_EID_SSID, .len = 2 },
+		},
+	},
+};
+KUNIT_ARRAY_PARAM_DESC(gen_new_ie, gen_new_ie_cases, desc)
+
+static void test_gen_new_ie(struct kunit *test)
+{
+	const struct gen_new_ie_case *params = test->param_value;
+	struct sk_buff *parent = kunit_zalloc_skb(test, 1024, GFP_KERNEL);
+	struct sk_buff *child = kunit_zalloc_skb(test, 1024, GFP_KERNEL);
+	struct sk_buff *reference = kunit_zalloc_skb(test, 1024, GFP_KERNEL);
+	u8 *out = kunit_kzalloc(test, IEEE80211_MAX_DATA_LEN, GFP_KERNEL);
+	size_t len;
+	int i;
+
+	KUNIT_ASSERT_NOT_NULL(test, parent);
+	KUNIT_ASSERT_NOT_NULL(test, child);
+	KUNIT_ASSERT_NOT_NULL(test, reference);
+	KUNIT_ASSERT_NOT_NULL(test, out);
+
+	for (i = 0; i < ARRAY_SIZE(params->parent_ies); i++) {
+		if (params->parent_ies[i].len != 0) {
+			skb_put_u8(parent, params->parent_ies[i].id);
+			skb_put_u8(parent, params->parent_ies[i].len);
+			skb_put_data(parent, params->parent_ies[i].data,
+				     params->parent_ies[i].len);
+		}
+
+		if (params->child_ies[i].len != 0) {
+			skb_put_u8(child, params->child_ies[i].id);
+			skb_put_u8(child, params->child_ies[i].len);
+			skb_put_data(child, params->child_ies[i].data,
+				     params->child_ies[i].len);
+		}
+
+		if (params->result_ies[i].len != 0) {
+			skb_put_u8(reference, params->result_ies[i].id);
+			skb_put_u8(reference, params->result_ies[i].len);
+			skb_put_data(reference, params->result_ies[i].data,
+				     params->result_ies[i].len);
+		}
+	}
+
+	len = cfg80211_gen_new_ie(parent->data, parent->len,
+				  child->data, child->len,
+				  out, IEEE80211_MAX_DATA_LEN);
+	KUNIT_EXPECT_EQ(test, len, reference->len);
+	KUNIT_EXPECT_MEMEQ(test, out, reference->data, reference->len);
+	memset(out, 0, IEEE80211_MAX_DATA_LEN);
+
+	/* Exactly enough space */
+	len = cfg80211_gen_new_ie(parent->data, parent->len,
+				  child->data, child->len,
+				  out, reference->len);
+	KUNIT_EXPECT_EQ(test, len, reference->len);
+	KUNIT_EXPECT_MEMEQ(test, out, reference->data, reference->len);
+	memset(out, 0, IEEE80211_MAX_DATA_LEN);
+
+	/* Not enough space (or expected zero length) */
+	len = cfg80211_gen_new_ie(parent->data, parent->len,
+				  child->data, child->len,
+				  out, reference->len - 1);
+	KUNIT_EXPECT_EQ(test, len, 0);
+}
+
+static void test_gen_new_ie_malformed(struct kunit *test)
+{
+	struct sk_buff *malformed = kunit_zalloc_skb(test, 1024, GFP_KERNEL);
+	u8 *out = kunit_kzalloc(test, IEEE80211_MAX_DATA_LEN, GFP_KERNEL);
+	size_t len;
+
+	KUNIT_ASSERT_NOT_NULL(test, malformed);
+	KUNIT_ASSERT_NOT_NULL(test, out);
+
+	skb_put_u8(malformed, WLAN_EID_SSID);
+	skb_put_u8(malformed, 3);
+	skb_put(malformed, 3);
+	skb_put_u8(malformed, WLAN_EID_REDUCED_NEIGHBOR_REPORT);
+	skb_put_u8(malformed, 10);
+	skb_put(malformed, 9);
+
+	len = cfg80211_gen_new_ie(malformed->data, malformed->len,
+				  out, 0,
+				  out, IEEE80211_MAX_DATA_LEN);
+	KUNIT_EXPECT_EQ(test, len, 5);
+
+	len = cfg80211_gen_new_ie(out, 0,
+				  malformed->data, malformed->len,
+				  out, IEEE80211_MAX_DATA_LEN);
+	KUNIT_EXPECT_EQ(test, len, 5);
+}
+
+struct inform_bss {
+	struct kunit *test;
+
+	int inform_bss_count;
+};
+
+static void inform_bss_inc_counter(struct wiphy *wiphy,
+				   struct cfg80211_bss *bss,
+				   const struct cfg80211_bss_ies *ies,
+				   void *drv_data)
+{
+	struct inform_bss *ctx = t_wiphy_ctx(wiphy);
+
+	ctx->inform_bss_count++;
+
+	rcu_read_lock();
+	KUNIT_EXPECT_PTR_EQ(ctx->test, drv_data, ctx);
+	KUNIT_EXPECT_PTR_EQ(ctx->test, ies, rcu_dereference(bss->ies));
+	rcu_read_unlock();
+}
+
+static void test_inform_bss_ssid_only(struct kunit *test)
+{
+	struct inform_bss ctx = {
+		.test = test,
+	};
+	struct wiphy *wiphy = T_WIPHY(test, ctx);
+	struct t_wiphy_priv *w_priv = wiphy_priv(wiphy);
+	struct cfg80211_inform_bss inform_bss = {
+		.signal = 50,
+		.drv_data = &ctx,
+	};
+	const u8 bssid[ETH_ALEN] = { 0x10, 0x22, 0x33, 0x44, 0x55, 0x66 };
+	u64 tsf = 0x1000000000000000ULL;
+	int beacon_int = 100;
+	u16 capability = 0x1234;
+	static const u8 input[] = {
+		[0] = WLAN_EID_SSID,
+		[1] = 4,
+		[2] = 'T', 'E', 'S', 'T'
+	};
+	struct cfg80211_bss *bss, *other;
+	const struct cfg80211_bss_ies *ies;
+
+	w_priv->ops->inform_bss = inform_bss_inc_counter;
+
+	inform_bss.chan = ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(2412));
+	KUNIT_ASSERT_NOT_NULL(test, inform_bss.chan);
+
+	bss = cfg80211_inform_bss_data(wiphy, &inform_bss,
+				       CFG80211_BSS_FTYPE_PRESP, bssid, tsf,
+				       capability, beacon_int,
+				       input, sizeof(input),
+				       GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, bss);
+	KUNIT_EXPECT_EQ(test, ctx.inform_bss_count, 1);
+
+	/* Check values in returned bss are correct */
+	KUNIT_EXPECT_EQ(test, bss->signal, inform_bss.signal);
+	KUNIT_EXPECT_EQ(test, bss->beacon_interval, beacon_int);
+	KUNIT_EXPECT_EQ(test, bss->capability, capability);
+	KUNIT_EXPECT_EQ(test, bss->bssid_index, 0);
+	KUNIT_EXPECT_PTR_EQ(test, bss->channel, inform_bss.chan);
+	KUNIT_EXPECT_MEMEQ(test, bssid, bss->bssid, sizeof(bssid));
+
+	/* Check the IEs have the expected value */
+	rcu_read_lock();
+	ies = rcu_dereference(bss->ies);
+	KUNIT_EXPECT_NOT_NULL(test, ies);
+	KUNIT_EXPECT_EQ(test, ies->tsf, tsf);
+	KUNIT_EXPECT_EQ(test, ies->len, sizeof(input));
+	KUNIT_EXPECT_MEMEQ(test, ies->data, input, sizeof(input));
+	rcu_read_unlock();
+
+	/* Check we can look up the BSS - by SSID */
+	other = cfg80211_get_bss(wiphy, NULL, NULL, "TEST", 4,
+				 IEEE80211_BSS_TYPE_ANY,
+				 IEEE80211_PRIVACY_ANY);
+	KUNIT_EXPECT_PTR_EQ(test, bss, other);
+	cfg80211_put_bss(wiphy, other);
+
+	/* Check we can look up the BSS - by BSSID */
+	other = cfg80211_get_bss(wiphy, NULL, bssid, NULL, 0,
+				 IEEE80211_BSS_TYPE_ANY,
+				 IEEE80211_PRIVACY_ANY);
+	KUNIT_EXPECT_PTR_EQ(test, bss, other);
+	cfg80211_put_bss(wiphy, other);
+
+	cfg80211_put_bss(wiphy, bss);
+}
+
+static struct inform_bss_ml_sta_case {
+	const char *desc;
+	int mld_id;
+	bool sta_prof_vendor_elems;
+} inform_bss_ml_sta_cases[] = {
+	{ .desc = "no_mld_id", .mld_id = 0, .sta_prof_vendor_elems = false },
+	{ .desc = "mld_id_eq_1", .mld_id = 1, .sta_prof_vendor_elems = true },
+};
+KUNIT_ARRAY_PARAM_DESC(inform_bss_ml_sta, inform_bss_ml_sta_cases, desc)
+
+static void test_inform_bss_ml_sta(struct kunit *test)
+{
+	const struct inform_bss_ml_sta_case *params = test->param_value;
+	struct inform_bss ctx = {
+		.test = test,
+	};
+	struct wiphy *wiphy = T_WIPHY(test, ctx);
+	struct t_wiphy_priv *w_priv = wiphy_priv(wiphy);
+	struct cfg80211_inform_bss inform_bss = {
+		.signal = 50,
+		.drv_data = &ctx,
+	};
+	struct cfg80211_bss *bss, *link_bss;
+	const struct cfg80211_bss_ies *ies;
+
+	/* sending station */
+	const u8 bssid[ETH_ALEN] = { 0x10, 0x22, 0x33, 0x44, 0x55, 0x66 };
+	u64 tsf = 0x1000000000000000ULL;
+	int beacon_int = 100;
+	u16 capability = 0x1234;
+
+	/* Building the frame *************************************************/
+	struct sk_buff *input = kunit_zalloc_skb(test, 1024, GFP_KERNEL);
+	u8 *len_mle, *len_prof;
+	u8 link_id = 2;
+	struct {
+		struct ieee80211_neighbor_ap_info info;
+		struct ieee80211_tbtt_info_ge_11 ap;
+	} __packed rnr = {
+		.info = {
+			.tbtt_info_hdr = u8_encode_bits(0, IEEE80211_AP_INFO_TBTT_HDR_COUNT),
+			.tbtt_info_len = sizeof(struct ieee80211_tbtt_info_ge_11),
+			.op_class = 81,
+			.channel = 11,
+		},
+		.ap = {
+			.tbtt_offset = 0xff,
+			.bssid = { 0x10, 0x22, 0x33, 0x44, 0x55, 0x67 },
+			.short_ssid = 0, /* unused */
+			.bss_params = 0,
+			.psd_20 = 0,
+			.mld_params.mld_id = params->mld_id,
+			.mld_params.params =
+				le16_encode_bits(link_id,
+						 IEEE80211_RNR_MLD_PARAMS_LINK_ID),
+		}
+	};
+	struct {
+		__le16 control;
+		u8 var_len;
+		u8 mld_mac_addr[ETH_ALEN];
+		u8 link_id_info;
+		u8 params_change_count;
+		__le16 mld_caps_and_ops;
+		u8 mld_id;
+		__le16 ext_mld_caps_and_ops;
+	} __packed mle_basic_common_info = {
+		.control =
+			cpu_to_le16(IEEE80211_ML_CONTROL_TYPE_BASIC |
+				    IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT |
+				    IEEE80211_MLC_BASIC_PRES_LINK_ID |
+				    (params->mld_id ? IEEE80211_MLC_BASIC_PRES_MLD_ID : 0) |
+				    IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP),
+		.mld_id = params->mld_id,
+		.mld_caps_and_ops = cpu_to_le16(0x0102),
+		.ext_mld_caps_and_ops = cpu_to_le16(0x0304),
+		.var_len = sizeof(mle_basic_common_info) - 2 -
+			   (params->mld_id ? 0 : 1),
+		.mld_mac_addr = { 0x10, 0x22, 0x33, 0x44, 0x55, 0x60 },
+	};
+	struct {
+		__le16 control;
+		u8 var_len;
+		u8 bssid[ETH_ALEN];
+		__le16 beacon_int;
+		__le64 tsf_offset;
+		__le16 capabilities; /* already part of payload */
+	} __packed sta_prof = {
+		.control =
+			cpu_to_le16(IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE |
+				    IEEE80211_MLE_STA_CONTROL_STA_MAC_ADDR_PRESENT |
+				    IEEE80211_MLE_STA_CONTROL_BEACON_INT_PRESENT |
+				    IEEE80211_MLE_STA_CONTROL_TSF_OFFS_PRESENT |
+				    u16_encode_bits(link_id,
+						    IEEE80211_MLE_STA_CONTROL_LINK_ID)),
+		.var_len = sizeof(sta_prof) - 2 - 2,
+		.bssid = { *rnr.ap.bssid },
+		.beacon_int = cpu_to_le16(101),
+		.tsf_offset = cpu_to_le64(-123ll),
+		.capabilities = cpu_to_le16(0xdead),
+	};
+
+	KUNIT_ASSERT_NOT_NULL(test, input);
+
+	w_priv->ops->inform_bss = inform_bss_inc_counter;
+
+	inform_bss.chan = ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(2412));
+	KUNIT_ASSERT_NOT_NULL(test, inform_bss.chan);
+
+	skb_put_u8(input, WLAN_EID_SSID);
+	skb_put_u8(input, 4);
+	skb_put_data(input, "TEST", 4);
+
+	skb_put_u8(input, WLAN_EID_REDUCED_NEIGHBOR_REPORT);
+	skb_put_u8(input, sizeof(rnr));
+	skb_put_data(input, &rnr, sizeof(rnr));
+
+	/* build a multi-link element */
+	skb_put_u8(input, WLAN_EID_EXTENSION);
+	len_mle = skb_put(input, 1);
+	skb_put_u8(input, WLAN_EID_EXT_EHT_MULTI_LINK);
+	skb_put_data(input, &mle_basic_common_info, sizeof(mle_basic_common_info));
+	if (!params->mld_id)
+		t_skb_remove_member(input, typeof(mle_basic_common_info), mld_id);
+	/* with a STA profile inside */
+	skb_put_u8(input, IEEE80211_MLE_SUBELEM_PER_STA_PROFILE);
+	len_prof = skb_put(input, 1);
+	skb_put_data(input, &sta_prof, sizeof(sta_prof));
+
+	if (params->sta_prof_vendor_elems) {
+		/* Put two (vendor) element into sta_prof */
+		skb_put_u8(input, WLAN_EID_VENDOR_SPECIFIC);
+		skb_put_u8(input, 160);
+		skb_put(input, 160);
+
+		skb_put_u8(input, WLAN_EID_VENDOR_SPECIFIC);
+		skb_put_u8(input, 165);
+		skb_put(input, 165);
+	}
+
+	/* fragment STA profile */
+	ieee80211_fragment_element(input, len_prof,
+				   IEEE80211_MLE_SUBELEM_FRAGMENT);
+	/* fragment MLE */
+	ieee80211_fragment_element(input, len_mle, WLAN_EID_FRAGMENT);
+
+	/* Put a (vendor) element after the ML element */
+	skb_put_u8(input, WLAN_EID_VENDOR_SPECIFIC);
+	skb_put_u8(input, 155);
+	skb_put(input, 155);
+
+	/* Submit *************************************************************/
+	bss = cfg80211_inform_bss_data(wiphy, &inform_bss,
+				       CFG80211_BSS_FTYPE_PRESP, bssid, tsf,
+				       capability, beacon_int,
+				       input->data, input->len,
+				       GFP_KERNEL);
+	KUNIT_EXPECT_NOT_NULL(test, bss);
+	KUNIT_EXPECT_EQ(test, ctx.inform_bss_count, 2);
+
+	/* Check link_bss *****************************************************/
+	link_bss = cfg80211_get_bss(wiphy, NULL, sta_prof.bssid, NULL, 0,
+				    IEEE80211_BSS_TYPE_ANY,
+				    IEEE80211_PRIVACY_ANY);
+	KUNIT_ASSERT_NOT_NULL(test, link_bss);
+	KUNIT_EXPECT_EQ(test, link_bss->signal, 0);
+	KUNIT_EXPECT_EQ(test, link_bss->beacon_interval,
+			      le16_to_cpu(sta_prof.beacon_int));
+	KUNIT_EXPECT_EQ(test, link_bss->capability,
+			      le16_to_cpu(sta_prof.capabilities));
+	KUNIT_EXPECT_EQ(test, link_bss->bssid_index, 0);
+	KUNIT_EXPECT_PTR_EQ(test, link_bss->channel,
+			    ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(2462)));
+
+	rcu_read_lock();
+	ies = rcu_dereference(link_bss->ies);
+	KUNIT_EXPECT_NOT_NULL(test, ies);
+	KUNIT_EXPECT_EQ(test, ies->tsf, tsf + le64_to_cpu(sta_prof.tsf_offset));
+	/* Resulting length should be:
+	 * SSID (inherited) + RNR (inherited) + vendor element(s) +
+	 * MLE common info + MLE header and control
+	 */
+	if (params->sta_prof_vendor_elems)
+		KUNIT_EXPECT_EQ(test, ies->len,
+				6 + 2 + sizeof(rnr) + 2 + 160 + 2 + 165 +
+				mle_basic_common_info.var_len + 5);
+	else
+		KUNIT_EXPECT_EQ(test, ies->len,
+				6 + 2 + sizeof(rnr) + 2 + 155 +
+				mle_basic_common_info.var_len + 5);
+	rcu_read_unlock();
+
+	cfg80211_put_bss(wiphy, bss);
+	cfg80211_put_bss(wiphy, link_bss);
+}
+
+static struct kunit_case gen_new_ie_test_cases[] = {
+	KUNIT_CASE_PARAM(test_gen_new_ie, gen_new_ie_gen_params),
+	KUNIT_CASE(test_gen_new_ie_malformed),
+	{}
+};
+
+static struct kunit_suite gen_new_ie = {
+	.name = "cfg80211-ie-generation",
+	.test_cases = gen_new_ie_test_cases,
+};
+
+kunit_test_suite(gen_new_ie);
+
+static struct kunit_case inform_bss_test_cases[] = {
+	KUNIT_CASE(test_inform_bss_ssid_only),
+	KUNIT_CASE_PARAM(test_inform_bss_ml_sta, inform_bss_ml_sta_gen_params),
+	{}
+};
+
+static struct kunit_suite inform_bss = {
+	.name = "cfg80211-inform-bss",
+	.test_cases = inform_bss_test_cases,
+};
+
+kunit_test_suite(inform_bss);
diff --git a/net/wireless/tests/util.c b/net/wireless/tests/util.c
new file mode 100644
index 000000000000..8abdaeb820ce
--- /dev/null
+++ b/net/wireless/tests/util.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit fixture to have a (configurable) wiphy
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <linux/ieee80211.h>
+#include <net/cfg80211.h>
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include "util.h"
+
+int t_wiphy_init(struct kunit_resource *resource, void *ctx)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cfg80211_ops *ops;
+	struct wiphy *wiphy;
+	struct t_wiphy_priv *priv;
+
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ops);
+
+	wiphy = wiphy_new_nm(ops, sizeof(*priv), "kunit");
+	KUNIT_ASSERT_NOT_NULL(test, wiphy);
+
+	priv = wiphy_priv(wiphy);
+	priv->ctx = ctx;
+	priv->ops = ops;
+
+	/* Initialize channels, feel free to add more here channels/bands */
+	memcpy(priv->channels_2ghz, channels_2ghz, sizeof(channels_2ghz));
+	wiphy->bands[NL80211_BAND_2GHZ] = &priv->band_2ghz;
+	priv->band_2ghz.channels = priv->channels_2ghz;
+	priv->band_2ghz.n_channels = ARRAY_SIZE(channels_2ghz);
+
+	resource->data = wiphy;
+	resource->name = "wiphy";
+
+	return 0;
+}
+
+void t_wiphy_exit(struct kunit_resource *resource)
+{
+	struct t_wiphy_priv *priv;
+	struct cfg80211_ops *ops;
+
+	priv = wiphy_priv(resource->data);
+	ops = priv->ops;
+
+	/* Should we ensure anything about the state here?
+	 * e.g. full destruction or no calls to any ops on destruction?
+	 */
+
+	wiphy_free(resource->data);
+	kfree(ops);
+}
diff --git a/net/wireless/tests/util.h b/net/wireless/tests/util.h
new file mode 100644
index 000000000000..6de712e0d432
--- /dev/null
+++ b/net/wireless/tests/util.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Utilities for cfg80211 unit testing
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#ifndef __CFG80211_UTILS_H
+#define __CFG80211_UTILS_H
+
+#define CHAN2G(_freq)  { \
+	.band = NL80211_BAND_2GHZ, \
+	.center_freq = (_freq), \
+	.hw_value = (_freq), \
+}
+
+static const struct ieee80211_channel channels_2ghz[] = {
+	CHAN2G(2412), /* Channel 1 */
+	CHAN2G(2417), /* Channel 2 */
+	CHAN2G(2422), /* Channel 3 */
+	CHAN2G(2427), /* Channel 4 */
+	CHAN2G(2432), /* Channel 5 */
+	CHAN2G(2437), /* Channel 6 */
+	CHAN2G(2442), /* Channel 7 */
+	CHAN2G(2447), /* Channel 8 */
+	CHAN2G(2452), /* Channel 9 */
+	CHAN2G(2457), /* Channel 10 */
+	CHAN2G(2462), /* Channel 11 */
+	CHAN2G(2467), /* Channel 12 */
+	CHAN2G(2472), /* Channel 13 */
+	CHAN2G(2484), /* Channel 14 */
+};
+
+struct t_wiphy_priv {
+	struct kunit *test;
+	struct cfg80211_ops *ops;
+
+	void *ctx;
+
+	struct ieee80211_supported_band band_2ghz;
+	struct ieee80211_channel channels_2ghz[ARRAY_SIZE(channels_2ghz)];
+};
+
+#define T_WIPHY(test, ctx) ({						\
+		struct wiphy *__wiphy =					\
+			kunit_alloc_resource(test, t_wiphy_init,	\
+					     t_wiphy_exit,		\
+					     GFP_KERNEL, &(ctx));	\
+									\
+		KUNIT_ASSERT_NOT_NULL(test, __wiphy);			\
+		__wiphy;						\
+	})
+#define t_wiphy_ctx(wiphy) (((struct t_wiphy_priv *)wiphy_priv(wiphy))->ctx)
+
+int t_wiphy_init(struct kunit_resource *resource, void *data);
+void t_wiphy_exit(struct kunit_resource *resource);
+
+#define t_skb_remove_member(skb, type, member)	do {				\
+		memmove((skb)->data + (skb)->len - sizeof(type) +		\
+			offsetof(type, member),					\
+			(skb)->data + (skb)->len - sizeof(type) +		\
+			offsetofend(type, member),				\
+			offsetofend(type, member));				\
+		skb_trim(skb, (skb)->len - sizeof_field(type, member));		\
+	} while (0)
+
+#endif /* __CFG80211_UTILS_H */
-- 
2.43.0


