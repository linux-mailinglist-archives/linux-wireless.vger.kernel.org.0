Return-Path: <linux-wireless+bounces-2739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C948414F6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 22:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82312B24F16
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 21:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1D8157E72;
	Mon, 29 Jan 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oUFKHV3C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7440159577
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562566; cv=none; b=IzZZdlsqD2mrNNdGPEu1hNSoTjxB8diW9YNwhckFX8gbbzlNpFimZ7BMfdEYboqgrKvMkX0QIEBXJK9OCMJkm1KJNwMUMVbowUL7rg/NaIRLkrajnErOvghXAqJZx8XPqTOUI0tm7GVTwQlI+7XhaE3bVCb/48XK3jU8t3PFZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562566; c=relaxed/simple;
	bh=q0bcsREr6OjUIXSjxqFAI3QnT9j2KZzalROupQVwLEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uavWeUXfwlruJ+QDfLU9bmkmeu5zRakYOwCoQFIa2v4w7l6zC1ajfC9RI2Sz7FqxJGBBTE5ixTJ2SO1SVhcOTgO2jrwpVj/2DIA57g9mVJ4jdD835yjCtz9+d5SSAeA0y7ybDETChvot4pcr8d+wNqqkFGHNU+uytzOOp7fvJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oUFKHV3C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=FP0NqT3+W+0X1h5pCOuHX+eAsUlgPivEe/CK0IfDga4=; t=1706562564; x=1707772164; 
	b=oUFKHV3CXhsug6nZ6SW9Yvu9kNhZ7Rnq8ALWGtq/eFQop8KBlNLR3b56mbz40Agv476QR78zb21
	tRVOCYbVeZuC6M4X54sHX7ovfiBzsAsJECVFKKcAAinL2qSTRwKfXM09YIjLJi89xJj37I7ElrMpJ
	7ueJOmrCm0RlJ7E1HTd71Bd9n1SN54cR0esCQsd7z426iM8fbbiRFKzCuEUKtB5xQopO9iCFO99wc
	rx0RcxajzG5fQyxnVNko5Fs1du3L9P4JYhWk4VLfoz3AhhywwKWu5fDNpV5OoyPqhNlnndVDi/VkZ
	5xY10PDdQSLQ9ldiamCeqhWI5g1m7TNcaicQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUYsa-000000053VO-3Tvn;
	Mon, 29 Jan 2024 22:09:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/2] wifi: cfg80211: add a kunit test for 6 GHz colocated AP parsing
Date: Mon, 29 Jan 2024 22:09:19 +0100
Message-ID: <20240129220918.079dc50ab43b.Ide898d9f1d4c26d7e774d6fd0ec57766967d6572@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Test a few things around parsing of 6 GHz colocated APs to e.g. ensure
that we are not going to scan for a disabled (affiliated) AP.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.h       |  44 ++++++++++
 net/wireless/scan.c       |  49 ++---------
 net/wireless/tests/scan.c | 179 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+), 42 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 30434551b377..debf63e6c61f 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -550,9 +550,53 @@ int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
 				 struct wireless_dev *wdev);
 void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask);
 
+/**
+ * struct cfg80211_colocated_ap - colocated AP information
+ *
+ * @list: linked list to all colocated APs
+ * @bssid: BSSID of the reported AP
+ * @ssid: SSID of the reported AP
+ * @ssid_len: length of the ssid
+ * @center_freq: frequency the reported AP is on
+ * @unsolicited_probe: the reported AP is part of an ESS, where all the APs
+ *	that operate in the same channel as the reported AP and that might be
+ *	detected by a STA receiving this frame, are transmitting unsolicited
+ *	Probe Response frames every 20 TUs
+ * @oct_recommended: OCT is recommended to exchange MMPDUs with the reported AP
+ * @same_ssid: the reported AP has the same SSID as the reporting AP
+ * @multi_bss: the reported AP is part of a multiple BSSID set
+ * @transmitted_bssid: the reported AP is the transmitting BSSID
+ * @colocated_ess: all the APs that share the same ESS as the reported AP are
+ *	colocated and can be discovered via legacy bands.
+ * @short_ssid_valid: short_ssid is valid and can be used
+ * @short_ssid: the short SSID for this SSID
+ * @psd_20: The 20MHz PSD EIRP of the primary 20MHz channel for the reported AP
+ */
+struct cfg80211_colocated_ap {
+	struct list_head list;
+	u8 bssid[ETH_ALEN];
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	size_t ssid_len;
+	u32 short_ssid;
+	u32 center_freq;
+	u8 unsolicited_probe:1,
+	   oct_recommended:1,
+	   same_ssid:1,
+	   multi_bss:1,
+	   transmitted_bssid:1,
+	   colocated_ess:1,
+	   short_ssid_valid:1;
+	s8 psd_20;
+};
+
 #if IS_ENABLED(CONFIG_CFG80211_KUNIT_TEST)
 #define EXPORT_SYMBOL_IF_CFG80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
 #define VISIBLE_IF_CFG80211_KUNIT
+void cfg80211_free_coloc_ap_list(struct list_head *coloc_ap_list);
+
+int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
+				struct list_head *list);
+
 size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
 			   const u8 *subie, size_t subie_len,
 			   u8 *new_ie, size_t new_ie_len);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 01618c4059f4..c78b10e1a167 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -77,45 +77,6 @@ MODULE_PARM_DESC(bss_entries_limit,
 
 #define IEEE80211_SCAN_RESULT_EXPIRE	(30 * HZ)
 
-/**
- * struct cfg80211_colocated_ap - colocated AP information
- *
- * @list: linked list to all colocated aPS
- * @bssid: BSSID of the reported AP
- * @ssid: SSID of the reported AP
- * @ssid_len: length of the ssid
- * @center_freq: frequency the reported AP is on
- * @unsolicited_probe: the reported AP is part of an ESS, where all the APs
- *	that operate in the same channel as the reported AP and that might be
- *	detected by a STA receiving this frame, are transmitting unsolicited
- *	Probe Response frames every 20 TUs
- * @oct_recommended: OCT is recommended to exchange MMPDUs with the reported AP
- * @same_ssid: the reported AP has the same SSID as the reporting AP
- * @multi_bss: the reported AP is part of a multiple BSSID set
- * @transmitted_bssid: the reported AP is the transmitting BSSID
- * @colocated_ess: all the APs that share the same ESS as the reported AP are
- *	colocated and can be discovered via legacy bands.
- * @short_ssid_valid: short_ssid is valid and can be used
- * @short_ssid: the short SSID for this SSID
- * @psd_20: The 20MHz PSD EIRP of the primary 20MHz channel for the reported AP
- */
-struct cfg80211_colocated_ap {
-	struct list_head list;
-	u8 bssid[ETH_ALEN];
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-	size_t ssid_len;
-	u32 short_ssid;
-	u32 center_freq;
-	u8 unsolicited_probe:1,
-	   oct_recommended:1,
-	   same_ssid:1,
-	   multi_bss:1,
-	   transmitted_bssid:1,
-	   colocated_ess:1,
-	   short_ssid_valid:1;
-	s8 psd_20;
-};
-
 static void bss_free(struct cfg80211_internal_bss *bss)
 {
 	struct cfg80211_bss_ies *ies;
@@ -566,7 +527,8 @@ static int cfg80211_calc_short_ssid(const struct cfg80211_bss_ies *ies,
 	return 0;
 }
 
-static void cfg80211_free_coloc_ap_list(struct list_head *coloc_ap_list)
+VISIBLE_IF_CFG80211_KUNIT void
+cfg80211_free_coloc_ap_list(struct list_head *coloc_ap_list)
 {
 	struct cfg80211_colocated_ap *ap, *tmp_ap;
 
@@ -575,6 +537,7 @@ static void cfg80211_free_coloc_ap_list(struct list_head *coloc_ap_list)
 		kfree(ap);
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(cfg80211_free_coloc_ap_list);
 
 static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 				  const u8 *pos, u8 length,
@@ -648,8 +611,9 @@ static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
 	return 0;
 }
 
-static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
-				       struct list_head *list)
+VISIBLE_IF_CFG80211_KUNIT int
+cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
+			    struct list_head *list)
 {
 	struct ieee80211_neighbor_ap_info *ap_info;
 	const struct element *elem, *ssid_elem;
@@ -746,6 +710,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
 	list_splice_tail(&ap_list, list);
 	return n_coloc;
 }
+EXPORT_SYMBOL_IF_KUNIT(cfg80211_parse_colocated_ap);
 
 static  void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
 					struct ieee80211_channel *chan,
diff --git a/net/wireless/tests/scan.c b/net/wireless/tests/scan.c
index f9ea44aee995..b40a0c06a6bb 100644
--- a/net/wireless/tests/scan.c
+++ b/net/wireless/tests/scan.c
@@ -628,6 +628,172 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	cfg80211_put_bss(wiphy, link_bss);
 }
 
+static struct cfg80211_parse_colocated_ap_case {
+	const char *desc;
+	u8 op_class;
+	u8 channel;
+	struct ieee80211_neighbor_ap_info info;
+	union {
+		struct ieee80211_tbtt_info_ge_11 tbtt_long;
+		struct ieee80211_tbtt_info_7_8_9 tbtt_short;
+	};
+	bool add_junk;
+	bool same_ssid;
+	bool valid;
+} cfg80211_parse_colocated_ap_cases[] = {
+	{
+		.desc = "wrong_band",
+		.info.op_class = 81,
+		.info.channel = 11,
+		.tbtt_long = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP,
+		},
+		.valid = false,
+	},
+	{
+		.desc = "wrong_type",
+		/* IEEE80211_AP_INFO_TBTT_HDR_TYPE is in the least significant bits */
+		.info.tbtt_info_hdr = IEEE80211_TBTT_INFO_TYPE_MLD,
+		.tbtt_long = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP,
+		},
+		.valid = false,
+	},
+	{
+		.desc = "colocated_invalid_len_short",
+		.info.tbtt_info_len = 6,
+		.tbtt_short = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP |
+				      IEEE80211_RNR_TBTT_PARAMS_SAME_SSID,
+		},
+		.valid = false,
+	},
+	{
+		.desc = "colocated_invalid_len_short_mld",
+		.info.tbtt_info_len = 10,
+		.tbtt_long = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP,
+		},
+		.valid = false,
+	},
+	{
+		.desc = "colocated_non_mld",
+		.info.tbtt_info_len = sizeof(struct ieee80211_tbtt_info_7_8_9),
+		.tbtt_short = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP |
+				      IEEE80211_RNR_TBTT_PARAMS_SAME_SSID,
+		},
+		.same_ssid = true,
+		.valid = true,
+	},
+	{
+		.desc = "colocated_non_mld_invalid_bssid",
+		.info.tbtt_info_len = sizeof(struct ieee80211_tbtt_info_7_8_9),
+		.tbtt_short = {
+			.bssid = { 0xff, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP |
+				      IEEE80211_RNR_TBTT_PARAMS_SAME_SSID,
+		},
+		.same_ssid = true,
+		.valid = false,
+	},
+	{
+		.desc = "colocated_mld",
+		.tbtt_long = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP,
+		},
+		.valid = true,
+	},
+	{
+		.desc = "colocated_mld",
+		.tbtt_long = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP,
+		},
+		.add_junk = true,
+		.valid = false,
+	},
+	{
+		.desc = "colocated_disabled_mld",
+		.tbtt_long = {
+			.bssid = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55 },
+			.bss_params = IEEE80211_RNR_TBTT_PARAMS_COLOC_AP,
+			.mld_params.params = cpu_to_le16(IEEE80211_RNR_MLD_PARAMS_DISABLED_LINK),
+		},
+		.valid = false,
+	},
+};
+KUNIT_ARRAY_PARAM_DESC(cfg80211_parse_colocated_ap, cfg80211_parse_colocated_ap_cases, desc)
+
+static void test_cfg80211_parse_colocated_ap(struct kunit *test)
+{
+	const struct cfg80211_parse_colocated_ap_case *params = test->param_value;
+	struct sk_buff *input = kunit_zalloc_skb(test, 1024, GFP_KERNEL);
+	struct cfg80211_bss_ies *ies;
+	struct ieee80211_neighbor_ap_info info;
+	LIST_HEAD(coloc_ap_list);
+	int count;
+
+	KUNIT_ASSERT_NOT_NULL(test, input);
+
+	info = params->info;
+
+	/* Reasonable values for a colocated AP */
+	if (!info.tbtt_info_len)
+		info.tbtt_info_len = sizeof(params->tbtt_long);
+	if (!info.op_class)
+		info.op_class = 131;
+	if (!info.channel)
+		info.channel = 33;
+	/* Zero is the correct default for .btt_info_hdr (one entry, TBTT type) */
+
+	skb_put_u8(input, WLAN_EID_SSID);
+	skb_put_u8(input, 4);
+	skb_put_data(input, "TEST", 4);
+
+	skb_put_u8(input, WLAN_EID_REDUCED_NEIGHBOR_REPORT);
+	skb_put_u8(input, sizeof(info) + info.tbtt_info_len + (params->add_junk ? 3 : 0));
+	skb_put_data(input, &info, sizeof(info));
+	skb_put_data(input, &params->tbtt_long, info.tbtt_info_len);
+
+	if (params->add_junk)
+		skb_put_data(input, "123", 3);
+
+	ies = kunit_kzalloc(test, struct_size(ies, data, input->len), GFP_KERNEL);
+	ies->len = input->len;
+	memcpy(ies->data, input->data, input->len);
+
+	count = cfg80211_parse_colocated_ap(ies, &coloc_ap_list);
+
+	KUNIT_EXPECT_EQ(test, count, params->valid);
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&coloc_ap_list), params->valid);
+
+	if (params->valid && !list_empty(&coloc_ap_list)) {
+		struct cfg80211_colocated_ap *ap;
+
+		ap = list_first_entry(&coloc_ap_list, typeof(*ap), list);
+		if (info.tbtt_info_len <= sizeof(params->tbtt_short))
+			KUNIT_EXPECT_MEMEQ(test, ap->bssid, params->tbtt_short.bssid, ETH_ALEN);
+		else
+			KUNIT_EXPECT_MEMEQ(test, ap->bssid, params->tbtt_long.bssid, ETH_ALEN);
+
+		if (params->same_ssid) {
+			KUNIT_EXPECT_EQ(test, ap->ssid_len, 4);
+			KUNIT_EXPECT_MEMEQ(test, ap->ssid, "TEST", 4);
+		} else {
+			KUNIT_EXPECT_EQ(test, ap->ssid_len, 0);
+		}
+	}
+
+	cfg80211_free_coloc_ap_list(&coloc_ap_list);
+}
+
 static struct kunit_case gen_new_ie_test_cases[] = {
 	KUNIT_CASE_PARAM(test_gen_new_ie, gen_new_ie_gen_params),
 	KUNIT_CASE(test_gen_new_ie_malformed),
@@ -653,3 +819,16 @@ static struct kunit_suite inform_bss = {
 };
 
 kunit_test_suite(inform_bss);
+
+static struct kunit_case scan_6ghz_cases[] = {
+	KUNIT_CASE_PARAM(test_cfg80211_parse_colocated_ap,
+			 cfg80211_parse_colocated_ap_gen_params),
+	{}
+};
+
+static struct kunit_suite scan_6ghz = {
+	.name = "cfg80211-scan-6ghz",
+	.test_cases = scan_6ghz_cases,
+};
+
+kunit_test_suite(scan_6ghz);
-- 
2.43.0


