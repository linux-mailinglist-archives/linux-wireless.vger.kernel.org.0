Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1761C29228B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgJSGjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 02:39:45 -0400
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:43894
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbgJSGjp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 02:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP+x0disJO9I9LM2Ql20Ha5cnjWAKN4E719bXdRfriWxp4cZmJStDZ4DKA23hBuk546Eflh0ud0yFJv2aAadhtf/Q2UcRASw0T8hXjjmXqGcwndcOQF94dvuEe+9QRDOTieP4zyWAVo5rvvj6VmgeGvtvhfiOSSy1q98TDG8lwDaFqVtuDqnlMCO6C6k+YqF0yUcIdbflQNSEeME56nIip+0gwAgNQpXswQPr80YBQCcjFBmIdKZEREyFK1WNiNPXJbPOVVxChOZhAynbW7hf3Aqvel5kaPlVCdh2LdOJh5tetmbu4s7KpmyrzMAUtTkENvEErtbmW6lz+o/TemtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xuKn9LJTMR8JdzvGpEUs41ViEkGzDLcyNeSqmvE0xg=;
 b=Bs1sFrQGOETDY/qNVsOm3av/az69IvHGhHtQRQuSufUW6AGa24lw2zsfwsXPi5KnkElcO2UwTDswYc+cg1voSnWj6R53V9QhO2Y3C7gQIw2G0F//ENvtD4Qur/ZdJBYiv+1LtUfSMOzbBFMmY00bHwCdt3mt5hv8VtZwricOe4efFea29+uNxUA1vk1jfLEKXlOShxxAKuwo7NRy0oCPTYy6FrW5Y4VdsCjCID2D72/JF9J26BzNGQ9XpgDpcpCBciY+AsdRtigtz3zkJUpdMs4AqRTPFEP6LirX1H3fmlGOSOPmjqhT6JDBvPT/X2Gn9VuTecu17VShdC5GTRRSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xuKn9LJTMR8JdzvGpEUs41ViEkGzDLcyNeSqmvE0xg=;
 b=ntc+hXWx2fMYIm1vxvdLnA0xIIjlBfxb//lvHRAJvi88/f8Op7ONkhBO8kgGXXcWKt+zWgAm5DbiAt2WWbnO9zHGDw3s3XWJ+nMN7G6iPDZZ08FgZd2P+EXb3dQiK+ChmDII8S200VJz4ho1znEQsNjkhtVK1Q/P34oABUhluu4=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM8P192MB0964.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 06:39:41 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 06:39:41 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Aviad.Brikman@celeno.com,
        eliav.farber@celeno.com, Aviad Brikman <aviad.brikman@celeno.com>
Subject: [PATCH v2] mac80211: 160MHz support per IEEE802.11ax standard
Date:   Mon, 19 Oct 2020 09:39:21 +0300
Message-Id: <20201019063921.4335-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201012141808.22284-1-shay.bar@celeno.com>
References: <20201012141808.22284-1-shay.bar@celeno.com>
Content-Type: text/plain
X-Originating-IP: [77.124.52.93]
X-ClientProxiedBy: LO2P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::25) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (77.124.52.93) by LO2P265CA0205.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 06:39:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789c8f84-5146-4318-fe54-08d873f9c1fc
X-MS-TrafficTypeDiagnostic: AM8P192MB0964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0964CFA107BAAE564EBF6BB7E71E0@AM8P192MB0964.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9pZSNbvUX2nGyOF4RQYzAL6QRsPZjY/2qIHHej2voNvP5Cr1HuyTHElaBgwv6amZspYOEOUvVHPZeqjNr8tFkVJVQGLLUtORO9HRHCURPoah3srVBALBfPZx9IyDToSroGMyNKPQd81yEw9IcKqTBR5OO0J+nE+OM8xCckz1vb0P2Rk+oQyjYC5/hluqwIMuWkG9M/l9sROuBnaN/qnlIIuTumDj2gHjhXL4MyXhs7newgoKSCDDbh3BruWJjx1qmROHJAiqeaES5sOYMUe/un10FlNEGUs51NpAixjumZmfVxYNPSP94NxKJ6lzu772rr8/9m1lPQL9gamXSYYubzABxn/1pMhDQiCYDc0gJuFuD9gGScscoLdaW08lcRK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39840400004)(396003)(346002)(6486002)(26005)(16526019)(186003)(52116002)(6506007)(66556008)(66476007)(6512007)(8936002)(66946007)(316002)(5660300002)(2616005)(36756003)(8676002)(956004)(6666004)(107886003)(1076003)(83380400001)(4326008)(6916009)(69590400008)(86362001)(478600001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7qaVApoYabqRPzNmWVQ0iHXGn+7N2IEKFRsApjUTrTNlDa2qJ7Ye9I0IrcFW5YPSHA0FIooXHIIqXzOQeOo6jLUqsaTnht8tV9+bF7jBsSb3Idp6EH2iS0dTWaQoaChxvGsgHuqYe78u1MX17T6YFkP9Scc0qpsUDy60iOR8uUD/tPKepk+/AK+asU/uYBCOt3H15KUwmGQY4rzCeb0yu3Pp2Bu6/K3MRH8Al0tDEU22j9hPfUDHizyJ7Qdp90LtndnSxpTdiTQIpiXZW+OgQa81ZGV4yh01fL/wzaTEAEar+PA3WCcl23TShSSMGIrcx3Er5zCKxn8xvlZddzoxVWXUG8YtEiT7WVEurc8MDFPrTdW19obRvehiGHM6KeqRMfVKhru9oS7B6JI0lyDTFuK7nnnx06w/AH4uHTYI1Ezy2fuXCTdt6MgaYUiDyM4wrUaEnQxMriSqQEHV5uWdyCuUQeA+TovwZw5lg3uegR0qEOa/OROuxbcZ8xNbv3DQZtACYuf6HlbdqQ3UJKmJeoCRVfIse+L45S9aoTdFqrVQzvD3dowDNPOtji57NUOeQZGOhbFsg0+wheDrlbpOSSdWMCnPU8NejpMf8QZ4xnlS6Vb0nA/U8NAqnPRu7V8MUXU1oypwPezCyI5x1X21yg==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789c8f84-5146-4318-fe54-08d873f9c1fc
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 06:39:41.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol35ta4CZBNWNwUrWrOg/D29qSZ7FGl+ymM7ndHsPpt08ZqNl16nGBL+dq33OkgjqVVldk2vFwInEI3eL2Vy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0964
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to the new IEEE802.11ax standard center frequency of the 160MHz
should be published in segment2 field of HT operation IE when using EXT NSS
(when supporting smaller number of NSS in VHT in 160MHz BW).
This patch adds the required support to mac80211, cfg80211 to parse it properly
according to the new style as appears in the new standard.

According to the new style, the AP should publish that its bw is 80MHz and not
160MHz.
A STA should conclude that an AP is working in 160MHz if it publishes
the center frequency of the 160MHz bandwidth in seg1 field of VHT operation IE
or seg2 field of HT operation IE.

A little about the old/new style of the channel/bandwidth publish in beacons:

- In the old style bandwidth of 160MHz and center frequency segment 0 are
  published in vht/he operation information element, while the center_freq_seg0
  indicates the center frequency of 160MHz.
- According to the new style, bandwidth of 80MHz is published and also the
  following:
    * If the supported number of VHT NSS in 160MHz is at least max VHT NSS
      support, then center_freq_seg0 indicates the center frequency of 80MHz and
      center_freq_seg1 indicates the center frequency of 160MHz.
    * If the supported number of VHT NSS in 160MHz is less than max VHT NSS
      support, then center_freq_seg0 indicates the center frequency of 80MHz and
      center_freq_seg1 is 0. The center frequency of 160MHz is published in HT
      operation information element instead.

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 include/linux/ieee80211.h |  15 ++++++
 net/mac80211/spectmgmt.c  | 100 +++++++++++++++++++++++++++++++++++---
 net/wireless/nl80211.c    |  15 ++++++
 3 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 770408b2fdaf..768285b143a3 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1748,6 +1748,21 @@ enum ieee80211_vht_chanwidth {
 	IEEE80211_VHT_CHANWIDTH_80P80MHZ	= 3,
 };
 
+/**
+ * enum ieee80211_center_freq_seg1_location - the location of center
+ * frequency segment1
+ * @IEEE80211_CENTER_FREQ_SEG1_NONE: center freq seg1 is located no where
+ * @IEEE80211_CENTER_FREQ_SEG1_VHT_OPER: center freq seg1 is located in VHT
+ * operation IE
+ * @IEEE80211_CENTER_FREQ_SEG1_HT_OPER: center freq seg1 is located in HT
+ * operation IE
+ */
+enum ieee80211_center_freq_seg1 {
+	IEEE80211_CENTER_FREQ_SEG1_NONE		= 0,
+	IEEE80211_CENTER_FREQ_SEG1_VHT_OPER	= 1,
+	IEEE80211_CENTER_FREQ_SEG1_HT_OPER	= 2,
+};
+
 /**
  * struct ieee80211_vht_operation - VHT operation IE
  *
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index ae1cb2c68722..d03763c8b648 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -19,6 +19,81 @@
 #include "sta_info.h"
 #include "wme.h"
 
+static enum ieee80211_vht_chanwidth
+ieee80211_vht_get_actual_chwidth(u8 vht_oper_bw,
+				 u32 seg0,
+				 u32 seg1)
+{
+	enum ieee80211_vht_chanwidth ret = IEEE80211_VHT_CHANWIDTH_USE_HT;
+
+	if (vht_oper_bw != IEEE80211_VHT_CHANWIDTH_80MHZ)
+		return vht_oper_bw;
+
+	if (!seg1) {
+		return IEEE80211_VHT_CHANWIDTH_80MHZ;
+	} else {
+		int diff;
+
+		diff = abs((int) seg0 - (int) seg1);
+
+		if (diff == 8)
+			return IEEE80211_VHT_CHANWIDTH_160MHZ;
+
+		if (diff > 16)
+			return IEEE80211_VHT_CHANWIDTH_80P80MHZ;
+	}
+
+	return ret;
+}
+
+static enum ieee80211_center_freq_seg1
+ieee80211_get_center_freq_seg1_location(struct ieee80211_sub_if_data *sdata,
+					u32 vht_cap_info,
+					u8 actual_chanwidth)
+{
+	u8 ext_nss_bw = (vht_cap_info &
+			      IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
+			      IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT;
+	u8 supp_chwidth = (vht_cap_info &
+			   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) >>
+			   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_SHIFT;
+	enum ieee80211_center_freq_seg1 res =
+					IEEE80211_CENTER_FREQ_SEG1_NONE;
+
+	/* The bandwidth is less than 80+80/160MHz */
+	if (actual_chanwidth < IEEE80211_VHT_CHANWIDTH_160MHZ)
+		return IEEE80211_CENTER_FREQ_SEG1_NONE;
+
+	switch (supp_chwidth) {
+	case 0:
+		if ((ext_nss_bw > 1) ||
+		    ((ext_nss_bw == 1) &&
+		     (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ)))
+			/* CCFS2 */
+			res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER;
+		break;
+	case 1:
+		if ((ext_nss_bw > 2) ||
+		    (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ))
+			/* CCFS1 */
+			res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER;
+		else if (ext_nss_bw > 0)
+			/* CCFS2 */
+			res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER;
+		break;
+	case 2:
+		res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER;
+		if ((ext_nss_bw > 0) && (ext_nss_bw < 3))
+			sdata_info(sdata,
+				   "Invalid ext_nss_bw %u\n", ext_nss_bw);
+		break;
+	default:
+		break;
+	}
+
+	return res;
+}
+
 int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 				 struct ieee802_11_elems *elems,
 				 enum nl80211_band current_band,
@@ -133,17 +208,30 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (wide_bw_chansw_ie) {
+		u8 new_channel_width = wide_bw_chansw_ie->new_channel_width;
+		u8 new_seg0 = wide_bw_chansw_ie->new_center_freq_seg0;
+		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
+		enum ieee80211_vht_chanwidth act_chanwidth =
+			ieee80211_vht_get_actual_chwidth(
+			 new_channel_width, new_seg0, new_seg1);
+		enum ieee80211_center_freq_seg1 seg1_location =
+			ieee80211_get_center_freq_seg1_location(sdata,
+								vht_cap_info,
+								act_chanwidth);
 		struct ieee80211_vht_operation vht_oper = {
-			.chan_width =
-				wide_bw_chansw_ie->new_channel_width,
-			.center_freq_seg0_idx =
-				wide_bw_chansw_ie->new_center_freq_seg0,
-			.center_freq_seg1_idx =
-				wide_bw_chansw_ie->new_center_freq_seg1,
+			.chan_width = new_channel_width,
+			.center_freq_seg0_idx = new_seg0,
 			/* .basic_mcs_set doesn't matter */
 		};
 		struct ieee80211_ht_operation ht_oper = {};
 
+		if (seg1_location == IEEE80211_CENTER_FREQ_SEG1_VHT_OPER)
+			vht_oper.center_freq_seg1_idx = new_seg1;
+		else if (seg1_location == IEEE80211_CENTER_FREQ_SEG1_HT_OPER)
+			ht_oper.operation_mode =
+					(le16_to_cpu(new_seg1) <<
+					 IEEE80211_HT_OP_MODE_CCFS2_SHIFT);
+
 		/* default, for the case of IEEE80211_VHT_CHANWIDTH_USE_HT,
 		 * to the previously parsed chandef
 		 */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 554796a6c6fe..690a5a382d94 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2976,6 +2976,21 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		chandef->edmg.channels = 0;
 	}
 
+	if (chandef->width == NL80211_CHAN_WIDTH_80) {
+		if (chandef->center_freq2) {
+			int diff = abs(chandef->center_freq1 -
+				       chandef->center_freq2);
+
+			if (diff == 40)
+				chandef->width = NL80211_CHAN_WIDTH_160;
+			else if (diff > 80)
+				chandef->width = NL80211_CHAN_WIDTH_80P80;
+
+			chandef->center_freq1 = chandef->center_freq2;
+			chandef->center_freq2 = 0;
+		}
+	}
+
 	if (!cfg80211_chandef_valid(chandef)) {
 		NL_SET_ERR_MSG(extack, "invalid channel definition");
 		return -EINVAL;
-- 
2.17.1

