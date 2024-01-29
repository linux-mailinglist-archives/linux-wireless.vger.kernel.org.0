Return-Path: <linux-wireless+bounces-2740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE90F8414F7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 22:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4744289D18
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9115159586;
	Mon, 29 Jan 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j4e4zGbE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F9159568
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562567; cv=none; b=J4DfYKkW6TYmg3JXEFz/eYiHHuKeVkLEFbc90WHifGNCvrifFGpdZQY3O3UF9apiSJFuLziflQiBBiMqmZBn4xjwGqnteni6z9OUolo5bsWYoxxfT4QCzAlaTkMWdnLwjBxEaJCcuUcLHG4NI03W+CVkO/ufe3uWj1dU4WMCTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562567; c=relaxed/simple;
	bh=baD8kuusKxsgsGrB5q68kfHwge9skytTEJXbQMMtTFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqMk7Wzw2l4xSwz4KfH/oLbSzPFdYlITTr0sBv1zgORvp+bDKPpPl1neOcu+Vo3DV26T1E47/SrqgOcIPSqp+k2FSrxGvg4YJ8IaeZzRjs0OUAw+ry9PzumriVn/xcPyRLfKFwiS/XYuCOPMEonLftZ8NiC2y8Xo22AiY2m9/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j4e4zGbE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bduEHGCJ0ws+OwxYuwIXruEHFXZao1AdmQdt4m63hBE=;
	t=1706562564; x=1707772164; b=j4e4zGbEDIzz0vzL98dTqjo8vEXXgn73PxIeSz62bdypttG
	gBteTuattgT7RBHmHfKaXwYMHnuVXndA8tGgT6X6q7NSi8jK1TFAxnJYX9Sx151dvYgnwc6BiP1gC
	+H9pkc9Ijqfhom7B9PsrGMhxzPZyWBW9b86OVbE7dm9ZGHwfkT0txLjKUhENy4dGnPf3yFcIvhPWw
	4BaTExvdtmxwUKK8YV/qCCSNfB63ak43makcVCLO+6HPSHUc+qctrW88I1BdyzZMIZE+VlDVO6m2D
	uJZ70FOvovSmKulQq1Hu7MLwa02B4tvRXjwWQfCIJsFyIO9wQOYkrvMZMWbqDOgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUYsb-000000053VO-22Ns;
	Mon, 29 Jan 2024 22:09:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 2/2] wifi: cfg80211: tests: verify BSS use flags of NSTR links
Date: Mon, 29 Jan 2024 22:09:20 +0100
Message-ID: <20240129220918.b00aee4c4c9f.I942fddf51cabaab761de3865b4e06cce831a46ef@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129220918.079dc50ab43b.Ide898d9f1d4c26d7e774d6fd0ec57766967d6572@changeid>
References: <20240129220918.079dc50ab43b.Ide898d9f1d4c26d7e774d6fd0ec57766967d6572@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Extend the test to pass an RNR appropriate for an NSTR and verify that
use_for as well as cannot_use_reasons are set correctly.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/tests/scan.c | 68 ++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/net/wireless/tests/scan.c b/net/wireless/tests/scan.c
index b40a0c06a6bb..9f458be71659 100644
--- a/net/wireless/tests/scan.c
+++ b/net/wireless/tests/scan.c
@@ -407,6 +407,7 @@ static struct inform_bss_ml_sta_case {
 	int mld_id;
 	bool sta_prof_vendor_elems;
 	bool include_oper_class;
+	bool nstr;
 } inform_bss_ml_sta_cases[] = {
 	{
 		.desc = "zero_mld_id",
@@ -426,6 +427,10 @@ static struct inform_bss_ml_sta_case {
 		.mld_id = 1,
 		.sta_prof_vendor_elems = true,
 		.include_oper_class = true,
+	}, {
+		.desc = "nstr",
+		.mld_id = 0,
+		.nstr = true,
 	},
 };
 KUNIT_ARRAY_PARAM_DESC(inform_bss_ml_sta, inform_bss_ml_sta_cases, desc)
@@ -458,7 +463,7 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	struct {
 		struct ieee80211_neighbor_ap_info info;
 		struct ieee80211_tbtt_info_ge_11 ap;
-	} __packed rnr = {
+	} __packed rnr_normal = {
 		.info = {
 			.tbtt_info_hdr = u8_encode_bits(0, IEEE80211_AP_INFO_TBTT_HDR_COUNT),
 			.tbtt_info_len = sizeof(struct ieee80211_tbtt_info_ge_11),
@@ -477,6 +482,28 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 						 IEEE80211_RNR_MLD_PARAMS_LINK_ID),
 		}
 	};
+	struct {
+		struct ieee80211_neighbor_ap_info info;
+		struct ieee80211_rnr_mld_params mld_params;
+	} __packed rnr_nstr = {
+		.info = {
+			.tbtt_info_hdr =
+				u8_encode_bits(0, IEEE80211_AP_INFO_TBTT_HDR_COUNT) |
+				u8_encode_bits(IEEE80211_TBTT_INFO_TYPE_MLD,
+					       IEEE80211_AP_INFO_TBTT_HDR_TYPE),
+			.tbtt_info_len = sizeof(struct ieee80211_rnr_mld_params),
+			.op_class = 81,
+			.channel = 11,
+		},
+		.mld_params = {
+			.mld_id = params->mld_id,
+			.params =
+				le16_encode_bits(link_id,
+						 IEEE80211_RNR_MLD_PARAMS_LINK_ID),
+		}
+	};
+	size_t rnr_len = params->nstr ? sizeof(rnr_nstr) : sizeof(rnr_normal);
+	void *rnr = params->nstr ? (void *)&rnr_nstr : (void *)&rnr_normal;
 	struct {
 		__le16 control;
 		u8 var_len;
@@ -516,7 +543,7 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 				    u16_encode_bits(link_id,
 						    IEEE80211_MLE_STA_CONTROL_LINK_ID)),
 		.var_len = sizeof(sta_prof) - 2 - 2,
-		.bssid = { *rnr.ap.bssid },
+		.bssid = { *rnr_normal.ap.bssid },
 		.beacon_int = cpu_to_le16(101),
 		.tsf_offset = cpu_to_le64(-123ll),
 		.capabilities = cpu_to_le16(0xdead),
@@ -540,8 +567,8 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	}
 
 	skb_put_u8(input, WLAN_EID_REDUCED_NEIGHBOR_REPORT);
-	skb_put_u8(input, sizeof(rnr));
-	skb_put_data(input, &rnr, sizeof(rnr));
+	skb_put_u8(input, rnr_len);
+	skb_put_data(input, rnr, rnr_len);
 
 	/* build a multi-link element */
 	skb_put_u8(input, WLAN_EID_EXTENSION);
@@ -587,9 +614,10 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx.inform_bss_count, 2);
 
 	/* Check link_bss *****************************************************/
-	link_bss = cfg80211_get_bss(wiphy, NULL, sta_prof.bssid, NULL, 0,
-				    IEEE80211_BSS_TYPE_ANY,
-				    IEEE80211_PRIVACY_ANY);
+	link_bss = __cfg80211_get_bss(wiphy, NULL, sta_prof.bssid, NULL, 0,
+				      IEEE80211_BSS_TYPE_ANY,
+				      IEEE80211_PRIVACY_ANY,
+				      0);
 	KUNIT_ASSERT_NOT_NULL(test, link_bss);
 	KUNIT_EXPECT_EQ(test, link_bss->signal, 0);
 	KUNIT_EXPECT_EQ(test, link_bss->beacon_interval,
@@ -600,6 +628,22 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, link_bss->channel,
 			    ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(2462)));
 
+	/* Test wiphy does not set WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY */
+	if (params->nstr) {
+		KUNIT_EXPECT_EQ(test, link_bss->use_for, 0);
+		KUNIT_EXPECT_EQ(test, link_bss->cannot_use_reasons,
+				NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY);
+		KUNIT_EXPECT_NULL(test,
+				  cfg80211_get_bss(wiphy, NULL, sta_prof.bssid,
+						   NULL, 0,
+						   IEEE80211_BSS_TYPE_ANY,
+						   IEEE80211_PRIVACY_ANY));
+	} else {
+		KUNIT_EXPECT_EQ(test, link_bss->use_for,
+				NL80211_BSS_USE_FOR_ALL);
+		KUNIT_EXPECT_EQ(test, link_bss->cannot_use_reasons, 0);
+	}
+
 	rcu_read_lock();
 	ies = rcu_dereference(link_bss->ies);
 	KUNIT_EXPECT_NOT_NULL(test, ies);
@@ -607,20 +651,20 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	/* Resulting length should be:
 	 * SSID (inherited) + RNR (inherited) + vendor element(s) +
 	 * operating class (if requested) +
-	 * generated RNR (if MLD ID == 0) +
+	 * generated RNR (if MLD ID == 0 and not NSTR) +
 	 * MLE common info + MLE header and control
 	 */
 	if (params->sta_prof_vendor_elems)
 		KUNIT_EXPECT_EQ(test, ies->len,
-				6 + 2 + sizeof(rnr) + 2 + 160 + 2 + 165 +
+				6 + 2 + rnr_len + 2 + 160 + 2 + 165 +
 				(params->include_oper_class ? 3 : 0) +
-				(!params->mld_id ? 22 : 0) +
+				(!params->mld_id && !params->nstr ? 22 : 0) +
 				mle_basic_common_info.var_len + 5);
 	else
 		KUNIT_EXPECT_EQ(test, ies->len,
-				6 + 2 + sizeof(rnr) + 2 + 155 +
+				6 + 2 + rnr_len + 2 + 155 +
 				(params->include_oper_class ? 3 : 0) +
-				(!params->mld_id ? 22 : 0) +
+				(!params->mld_id && !params->nstr ? 22 : 0) +
 				mle_basic_common_info.var_len + 5);
 	rcu_read_unlock();
 
-- 
2.43.0


