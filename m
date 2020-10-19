Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC7F292829
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgJSN3T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 09:29:19 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:24215
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbgJSN3T (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 09:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrMd59NzH+fWvM39n98iZVWJpIQzQu9RH9DxpQgZ0y26U1NE4fr/E9P0XGVyuZvhXjFTWeB9zg2VtRTuK6qzxiP4ND7WyYZGIujKnT0yUJaV2JWcPZJOb6MFWIUMMSyriJQ+P+qDtwb/VO6kzCuyhgTaqt0zD34ZPI5UDuH2aQZ1EWsJY80fWmvzXkvecKb4C2Pf97PN2Ig2/mjZMXSsM/Sg50SStOnajn2KlkvL2stRilKOvBVzx0k0eBjllkQJJUWKURoQLnK6yLWvQAFJX9xLsELjqBawW9wkhs4ugZCDvS3hkwFz0EXZJJDkC0BjdBSSP+R1Yq6AT/hXkHkOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEtTDL6TaMVgoxhWmnDg5+2hJ/etakiR90UjfSQgxKw=;
 b=Pj5goviEWGfOshlh7znQoSYZdkA12NsQ9SFlMFXPqpifxqRGp4i8NFo07/3b5kJyu8no33dCpp+vCNOThCnrcYQdwe/OVxD849Ymy47OqB2WvSVCS4uScBodUeUdslp/h029YiTHmAXZFM4sKUwiHukKSOBwPplzDZ42d+sgjip7UM5etQa4O1wrvmrGWXlPyhynsmGeBiCeDiXbVV1HiNdQXoIxf4DwoyimWvB/o3HOBRF4jVHHTx6AbOhzanJk/yzvl1bJ8VFkJANdy7WMzFPJUlYUeSPsB0ZUDN951CA2XaxkW/F1Sd/M8HcgNzJ0oe+7dOCLbNI38GMm9OfN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEtTDL6TaMVgoxhWmnDg5+2hJ/etakiR90UjfSQgxKw=;
 b=KonvDyW7anV5oT4PDTFKvjsQFbcdZNE9/DF6Axd9wzdWyTZtpAOqGH+RADGssWbU1facIJqCdvnffZjnA97bEoaZBbCAI01PZGtR5gQaGfVcdbdA7/PG/6tVlSTb5JO0db5r+suPANUpGzy00TSeJ8aNpUNuoiXEYUzOgu8r08Y=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM8P192MB1010.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 13:26:34 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 13:26:34 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Subject: [PATCH v3 v3] mac80211: 160MHz support per IEEE802.11ax standard
Date:   Mon, 19 Oct 2020 16:26:16 +0300
Message-Id: <20201019132616.32286-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019063921.4335-1-shay.bar@celeno.com>
References: <20201019063921.4335-1-shay.bar@celeno.com>
Content-Type: text/plain
X-Originating-IP: [77.124.52.93]
X-ClientProxiedBy: LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::35) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (77.124.52.93) by LNXP265CA0047.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Mon, 19 Oct 2020 13:26:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba394a8a-93b7-4eb3-2a06-08d874329946
X-MS-TrafficTypeDiagnostic: AM8P192MB1010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10108D29C8ACFEDA137B49FDE71E0@AM8P192MB1010.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByiZABjNQG+ldsGtLCwx1OpqYAtT6QPRiWGXDn/3jDn3Xz5/B0MSoitIclmtgEtRAgEQYqTDx58hlQk5+CDg63GG8vIRO5oO86mtu8gprwrAWxlHl69NfCl7ctmr60wsMP5FCIlPJnwG5UVMcSrbvJG5CbWzBJez5ZUxVDTakmhUc8dHzcJ56r2CjVc97nQ4kUTxpWAabfOmV5q236JJvltptcTucyjioPCbiJcHcXj9xfi3MB7fnWcue3XMVi5wph2hq840p6kF9FpXfCYUNQvVXxPorfdpALWo8Oz8PJmANvJ5drb2nfPSSXaNDeIqr0GLxfVCyML9MDEcfdM9FBsaxqz0isnSB2ZY2Dw2pZ9mDLlAksFCX91DF0Aqbh9e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(376002)(39850400004)(136003)(396003)(346002)(66556008)(66946007)(316002)(44832011)(66476007)(52116002)(6506007)(6666004)(2906002)(1076003)(5660300002)(956004)(2616005)(8676002)(8936002)(26005)(186003)(16526019)(6916009)(6486002)(4326008)(107886003)(478600001)(6512007)(86362001)(83380400001)(36756003)(69590400008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bxvgFx7nl2qYOz1n07K/o4djngyLuwG7SHXrUPX3BBLNh7TIQPHOwMuZQ0F9TJyJxkttOFuYIDL64jK42u06XS2iivIVajF8/+mJdZU2rRLQ9wLAqhzSLO2gnKbhcwya4s2pN/2VTYN55TYumcQ9IsEBFx6GXWRaqbEYV7Kc/w6sElAIpGqFzP29pT9qDH72bPLAudquCr/b+Pm/KKC/0beZ31swLXcymXTOA4kddQkrOvGYvnYktje/+TB7jTF2SYMFqLBYZAWMw0ZtfcAbBHA4JZlSkL4YJVnQmSHKzHZw208RUFFFUJluJF7ZWyy0D9G4QrHI9lcJN8Z3PGIlNGmjxseuIMB9HoNPEUYRWLQ/cDYxdclhPgX1VqbZDSZoopzgnsejoB8WbYjy3k4FYbRHjMtcBtqsv9chCk6xiESXLm3VKfAGOlVgVvF2TF//BJP0unSeWMIyyR24GziTJiDlboBgtpER2j4enUN4L3q2A+UtbpIWPFhMd2weP8cqITLsQ+Tz5unJhnFrHOCJ72+ayTk3STeLGBU5z66d7kkhwM4vtX+194hGihIOKZhwL6Iemry7VrWDxEsAKzkpwQHlQuqwflBW/z1AebqDlHPt0ByU3bxrblLeBgW3klaU7wvVoBbRQA81CRCNBF51hA==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba394a8a-93b7-4eb3-2a06-08d874329946
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 13:26:34.5352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oj9EIOkFRig+tN6GrfApA0cyb5uQb9N67uIOBtlTdTUjhRuNHLlTUKrnour6s3MCWkN24n/JPtlG6SyTwwF+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1010
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
 net/mac80211/spectmgmt.c  | 99 ++++++++++++++++++++++++++++++++++++---
 net/wireless/nl80211.c    | 15 ++++++
 3 files changed, 123 insertions(+), 6 deletions(-)

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
index ae1cb2c68722..569b9e9d1228 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -19,6 +19,81 @@
 #include "sta_info.h"
 #include "wme.h"
 
+static enum ieee80211_vht_chanwidth
+ieee80211_vht_get_actual_chwidth(u8 vht_oper_bw,
+				 u8 seg0,
+				 u8 seg1)
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
@@ -133,17 +208,29 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (wide_bw_chansw_ie) {
+		u8 new_channel_width = wide_bw_chansw_ie->new_channel_width;
+		u8 new_seg0 = wide_bw_chansw_ie->new_center_freq_seg0;
+		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
+		enum ieee80211_vht_chanwidth act_chanwidth =
+			ieee80211_vht_get_actual_chwidth(new_channel_width,
+							 new_seg0, new_seg1);
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
+			ht_oper.operation_mode = (new_seg1 <<
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

