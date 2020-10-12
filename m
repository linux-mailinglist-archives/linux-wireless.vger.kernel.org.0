Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44B828BA9B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 16:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgJLOS0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 10:18:26 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:65511
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbgJLOS0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 10:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxJ5EBjREBTDLYh6oCMdf4RAxV/tekA7selSXV6Vu7YwfMkrjbbQYAuPTqollWE6OmhqKxG6NFAm+bSP8Mye0S5KAgh2mKNSYb1N+e08sVZOG1yZ7drFBYHfo+n5y4VHA/Ug6aarcqL+303PkU1ERLERlrpj5bx/L2bDAaAbYn2IBq9Q0jP+equsRER0fZ2CA6xKvv3WjclnihWvUyJjLJDxosdFBdZsabVIuvOVB30DSGTgbd9LzhNSA5CJ1k2AEryV4X6BYtS4HzyMDEJ8o5lfbQt8lakgOHeY9lnkCWWrb1inWk1GSDxXFAP+QPc38io9qIR1wEOREpl7Z/YfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYC/Opvwf6zDVFd0AunlO/R+WNM0HS0Uqb/msdnAiIA=;
 b=BZbOsR+KyPgkOaBdj7pn+fp3u8VWSg64OoEVrpJTQPBYgcJI7IYmKE9/Wn5Qi2FluadyMmeFbsAjIDC3G81spjlszRMITpRVRRCtFJ2PAm8W8NVYUnvDLNjgYy6DBan3bOu11WkwGoChDIHlO7oXlVqnUanlYR9s3hKsVVlj+hRI36AJnG4GHPMgbvWmzUcMzYTVTWSJM1kueagmGwl8SdpePay7AILziFMkb/YBuAjjCpzwbMMQMYG0M7ZUZaskp9fWmRxDAPSBg3PJC0Jcm75ckgOJKYd//DevOFSIkm01egk3uxlvD3GhGah2s4nWyF76T7onba9qTzdtB3//uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYC/Opvwf6zDVFd0AunlO/R+WNM0HS0Uqb/msdnAiIA=;
 b=QrQlvLaLkBou76Jdrog37EDjkCoWP6TkuwyLTD9bWFJCCnFL112eZq7HSEiHyr9LDF7waF0ps4CTKVxHeujXqrY42abXFpaGKqt1rHDDXndZ4a0Vl3/ZOb64XTEIAKEERZZPzTX9tWZW3kyq0eba/9usd9oIXKvjYLrCqoXg/lI=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0292.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 14:18:22 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189%4]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 14:18:22 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, eliav.farber@celeno.com,
        aviad.brikman@celeno.com
Subject: [PATCH] mac80211: 160MHz support per IEEE802.11ax standard
Date:   Mon, 12 Oct 2020 17:18:08 +0300
Message-Id: <20201012141808.22284-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [77.124.52.93]
X-ClientProxiedBy: AM4PR0501CA0064.eurprd05.prod.outlook.com
 (2603:10a6:200:68::32) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (77.124.52.93) by AM4PR0501CA0064.eurprd05.prod.outlook.com (2603:10a6:200:68::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 14:18:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35a3832f-08f4-4a72-64a8-08d86eb9acf1
X-MS-TrafficTypeDiagnostic: AM0P192MB0292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0292380AC20FA3ECA6748FEEE7070@AM0P192MB0292.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29Ug9/3FECc37qbWWrEMXAPwkoGbi+6HYsL5A2OJyVJcX1xrcbwM1aXH2G+x0VynOmkttK5eMxXo13H/3pLeFVINsQHaA1CwMAVI3+KuJOclFwSnAQIn1zOze+RG2JOAKrSCGm+BTq15utJUt5DX82LqRpErXaH5mDWCljZ2mvQD8Jl9Dag28EjUVZ1fw7nPQVj03ZNsZQ915SjlxEUjyegLhhA38F4LceNEghWkSiDIGoY2rmw1fUtjLQnOGGKX3m0mEcbWrk+4bf1iw4ix2OPW0v8oTC4bXgHSytbzDqKLI9TP3DnvgmclvsjBgz7w3RVvyu1J/2PAG9+gRDLFYROfH4xaFIPv5zCHCANwjqFrZndiZyXfyCsWLXb/lu7n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(396003)(39840400004)(366004)(136003)(376002)(83380400001)(69590400008)(86362001)(2616005)(16526019)(186003)(26005)(6486002)(478600001)(956004)(66946007)(66556008)(66476007)(36756003)(6666004)(6512007)(6506007)(4326008)(6916009)(316002)(52116002)(107886003)(1076003)(44832011)(5660300002)(8936002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ASJI8hdOA5SIVHa4je1rVm9icSaJHGzjx9k85JCPKlZ+MlGWxe2xpC/pO81v9BPUWVMEiMuHt2hw7nRjPRyGTqLkjSPXIaPbdDQVXquWocxgiBm6TAOSVtIrgpNun5C14vMjEgz8C3nGVTOjtzcVmQOeEmyJIUpEVVZkghCcSm5HGa6L+XwugseHbeFlsb/PhdjQnPYjT5y+/hCrJTIx7owhywQVVZYHMgwZ4MxThzyaVj86z8y926U3ZuIakT7PP4zkmdUp72ZGnGEIsRRkhEMN7NswbjTPL+GbqsqfzCnLQkqeQM4Wbtyt9EA02Y8zf1uLkTomH+r12N2PO1lraWzbN630UsUv1mty06GhEs4KgIrc4ppKdLOa6wfhZDjzwGzD6P6WlvpAwAyfmNCeIw1BXDEMLbubyK0w7oIT0PGNyV8G4WJJZBTwOwdVxwvyLTP2/9M4aN9caMrzxYSejrrmKF9iQ9SCmhRrrkJSnZwIiag7CPJoeYEF/GgA9/+n24PSu1eJ83K0Z0EosePVArMoxB2yT+2+O52IWcqk6SGEBPnyXSRGmaEEIIx6MvcOlclBSRrW1+Yuak+lcAyH3cKL5Qd1VRe5MrMlm7dUDeujrx17WxJLHoFzWuP8Q4iRsVXaBfcfD4PQdhQb5Zjxcg==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a3832f-08f4-4a72-64a8-08d86eb9acf1
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 14:18:22.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnoyyeqvepGKMHxjEy3FH+l9saHgBxaW9ZXV2/1+S+IhrTqOss0X7i/iclc5Tnkn77KtaBrr+P/1VIQvniJb7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0292
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
 include/linux/ieee80211.h | 15 ++++++
 net/mac80211/spectmgmt.c  | 97 ++++++++++++++++++++++++++++++++++++---
 net/wireless/nl80211.c    | 15 ++++++
 3 files changed, 121 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c47f43e65a2f..884b71a96084 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1692,6 +1692,21 @@ enum ieee80211_vht_chanwidth {
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
+enum ieee80211_center_freq_seg1_location {
+	IEEE80211_CENTER_FREQ_SEG1_NONE         = 0,
+	IEEE80211_CENTER_FREQ_SEG1_VHT_OPER     = 1,
+	IEEE80211_CENTER_FREQ_SEG1_HT_OPER      = 2,
+};
+
 /**
  * struct ieee80211_vht_operation - VHT operation IE
  *
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index ae1cb2c68722..6600e78e2bde 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -19,6 +19,78 @@
 #include "sta_info.h"
 #include "wme.h"
 
+enum ieee80211_vht_chanwidth ieee80211_vht_get_actual_chwidth(u8 vht_oper_bw,
+							      u32 seg0,
+							      u32 seg1)
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
+enum ieee80211_center_freq_seg1_location
+ieee80211_get_center_freq_seg1_location(struct ieee80211_sub_if_data *sdata,
+					u32 vht_cap_info,
+					u8 actual_chanwidth)
+{
+	u8 ext_nss_bw_supp = (vht_cap_info &
+			      IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
+			      IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT;
+	u8 supp_chwidth = (vht_cap_info &
+			   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) >>
+			   IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_SHIFT;
+	enum ieee80211_center_freq_seg1_location res =
+					IEEE80211_CENTER_FREQ_SEG1_NONE;
+
+	/* The bandwidth is less than 80+80/160MHz */
+	if (actual_chanwidth < IEEE80211_VHT_CHANWIDTH_160MHZ)
+		return IEEE80211_CENTER_FREQ_SEG1_NONE;
+
+	switch (supp_chwidth) {
+	case 0:
+		if ((ext_nss_bw_supp > 1) ||
+		    ((ext_nss_bw_supp == 1) &&
+		     (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ)))
+			res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER; /* CCFS2 */
+		break;
+	case 1:
+		if ((ext_nss_bw_supp > 2) ||
+		    (actual_chanwidth == IEEE80211_VHT_CHANWIDTH_160MHZ))
+			res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER; /* CCFS1 */
+		else if (ext_nss_bw_supp > 0)
+			res = IEEE80211_CENTER_FREQ_SEG1_HT_OPER; /* CCFS2 */
+		break;
+	case 2:
+		res = IEEE80211_CENTER_FREQ_SEG1_VHT_OPER;
+		if ((ext_nss_bw_supp > 0) && (ext_nss_bw_supp < 3))
+			sdata_info(sdata,
+				   "Invalid ext_nss_bw_supp %u for chwidth 2",
+				   ext_nss_bw_supp);
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
@@ -133,17 +205,30 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (wide_bw_chansw_ie) {
+		u8 new_channel_width = wide_bw_chansw_ie->new_channel_width;
+		u8 new_seg0 = wide_bw_chansw_ie->new_center_freq_seg0;
+		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
+		enum ieee80211_vht_chanwidth act_chanwidth =
+			ieee80211_vht_get_actual_chwidth(
+			 new_channel_width, new_seg0, new_seg1);
+		enum ieee80211_center_freq_seg1_location seg1_location =
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
index 5940acbe761c..9644d00cfd2f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2889,6 +2889,21 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
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

