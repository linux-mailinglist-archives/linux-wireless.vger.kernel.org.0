Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EA4682074
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 01:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjAaAMu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 19:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAaAMr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 19:12:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2411ABC1
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 16:12:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UNfqVZ019313;
        Tue, 31 Jan 2023 00:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=wK0V3YwpFP8VwohhJnN9C0esMddpUK/xTkm8WLEyZlE=;
 b=Ig6akcnoKTe3wnshHePRF4Q82R3mcLZOtqHCChJ0XpODRPHeC+EjouZ8Jxe25fF47UPJ
 GIRk/NpHPw/V/L48F8SiGWfR7X/8lUMFETN7nWFvEbd27tkg90ZGf/77HJGD23wpbNco
 cMwPkaoAhElqZlGvloT8PeUwAcked7UQyGPqz1fPanf00W6Ojq6y+5HOIOkRi1Sd7Cid
 c8dXRyjEXZJ7erqn+z/w99/hP7ZgM3oruDvcGpSfBzB8Q2y0tZTVgQiTJ7NEBRr8B2/U
 suGoAujezWrHgBHYYSZ/SeG4Kt2v9PCNKrpDc0MlE9hg9G4Twsxpxpu8GCEyMwgJxl5J kQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncut2n9eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V0CeZI006388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:40 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 16:12:40 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v4 1/4] cfg80211: move puncturing bitmap validation from mac80211
Date:   Mon, 30 Jan 2023 16:12:24 -0800
Message-ID: <20230131001227.25014-2-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131001227.25014-1-quic_alokad@quicinc.com>
References: <20230131001227.25014-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9O78f31G-Z25yfLYYT08XDT5gHfNtxrl
X-Proofpoint-ORIG-GUID: 9O78f31G-Z25yfLYYT08XDT5gHfNtxrl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_18,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Move ieee80211_valid_disable_subchannel_bitmap() from mlme.c to
chan.c, rename it as cfg80211_valid_disable_subchannel_bitmap() and
export it.
- Modify the prototype to include struct cfg80211_chan_def instead of
only bandwidth to support a check which returns false if the primary
channel is punctured.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 include/net/cfg80211.h | 12 +++++++
 net/mac80211/mlme.c    | 73 ++++--------------------------------------
 net/wireless/chan.c    | 69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 67 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 54a77d906b2d..505a1072b5b4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8906,4 +8906,16 @@ static inline int cfg80211_color_change_notify(struct net_device *dev)
 					 0, 0);
 }
 
+/**
+ * cfg80211_valid_disable_subchannel_bitmap - validate puncturing bitmap
+ * @bitmap: bitmap to be validated
+ * @chandef: channel definition
+ *
+ * Validate the puncturing bitmap.
+ *
+ * Return: %true if the bitmap is valid. %false otherwise.
+ */
+bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
+					      const struct cfg80211_chan_def *chandef);
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a14a5ea2bffd..09703cae2fbb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -88,67 +88,6 @@ MODULE_PARM_DESC(probe_wait_ms,
  */
 #define IEEE80211_SIGNAL_AVE_MIN_COUNT	4
 
-struct ieee80211_per_bw_puncturing_values {
-	u8 len;
-	const u16 *valid_values;
-};
-
-static const u16 puncturing_values_80mhz[] = {
-	0x8, 0x4, 0x2, 0x1
-};
-
-static const u16 puncturing_values_160mhz[] = {
-	 0x80, 0x40, 0x20, 0x10, 0x8, 0x4, 0x2, 0x1, 0xc0, 0x30, 0xc, 0x3
-};
-
-static const u16 puncturing_values_320mhz[] = {
-	0xc000, 0x3000, 0xc00, 0x300, 0xc0, 0x30, 0xc, 0x3, 0xf000, 0xf00,
-	0xf0, 0xf, 0xfc00, 0xf300, 0xf0c0, 0xf030, 0xf00c, 0xf003, 0xc00f,
-	0x300f, 0xc0f, 0x30f, 0xcf, 0x3f
-};
-
-#define IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(_bw) \
-	{ \
-		.len = ARRAY_SIZE(puncturing_values_ ## _bw ## mhz), \
-		.valid_values = puncturing_values_ ## _bw ## mhz \
-	}
-
-static const struct ieee80211_per_bw_puncturing_values per_bw_puncturing[] = {
-	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(80),
-	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(160),
-	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(320)
-};
-
-static bool ieee80211_valid_disable_subchannel_bitmap(u16 *bitmap,
-						      enum nl80211_chan_width bw)
-{
-	u32 idx, i;
-
-	switch (bw) {
-	case NL80211_CHAN_WIDTH_80:
-		idx = 0;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		idx = 1;
-		break;
-	case NL80211_CHAN_WIDTH_320:
-		idx = 2;
-		break;
-	default:
-		*bitmap = 0;
-		break;
-	}
-
-	if (!*bitmap)
-		return true;
-
-	for (i = 0; i < per_bw_puncturing[idx].len; i++)
-		if (per_bw_puncturing[idx].valid_values[i] == *bitmap)
-			return true;
-
-	return false;
-}
-
 /*
  * Extract from the given disabled subchannel bitmap (raw format
  * from the EHT Operation Element) the bits for the subchannel
@@ -206,8 +145,8 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
 							 bitmap);
 
-		if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
-							      chandef->width))
+		if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
+							     chandef))
 			break;
 		link->u.mgd.conn_flags |=
 			ieee80211_chandef_downgrade(chandef);
@@ -5638,8 +5577,8 @@ static bool ieee80211_config_puncturing(struct ieee80211_link_data *link,
 	    extracted == link->conf->eht_puncturing)
 		return true;
 
-	if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap,
-						       link->conf->chandef.width)) {
+	if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
+						      &link->conf->chandef)) {
 		link_info(link,
 			  "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
 			  link->u.mgd.bssid,
@@ -7132,8 +7071,8 @@ ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
 			u16 bitmap;
 
 			bitmap = get_unaligned_le16(disable_subchannel_bitmap);
-			if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
-								      link->conf->chandef.width))
+			if (cfg80211_valid_disable_subchannel_bitmap(&bitmap,
+								     &link->conf->chandef))
 				ieee80211_handle_puncturing_bitmap(link,
 								   eht_oper,
 								   bitmap,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0e5835cd8c61..0b7e81db383d 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1460,3 +1460,72 @@ struct cfg80211_chan_def *wdev_chandef(struct wireless_dev *wdev,
 	}
 }
 EXPORT_SYMBOL(wdev_chandef);
+
+struct cfg80211_per_bw_puncturing_values {
+	u8 len;
+	const u16 *valid_values;
+};
+
+static const u16 puncturing_values_80mhz[] = {
+	0x8, 0x4, 0x2, 0x1
+};
+
+static const u16 puncturing_values_160mhz[] = {
+	 0x80, 0x40, 0x20, 0x10, 0x8, 0x4, 0x2, 0x1, 0xc0, 0x30, 0xc, 0x3
+};
+
+static const u16 puncturing_values_320mhz[] = {
+	0xc000, 0x3000, 0xc00, 0x300, 0xc0, 0x30, 0xc, 0x3, 0xf000, 0xf00,
+	0xf0, 0xf, 0xfc00, 0xf300, 0xf0c0, 0xf030, 0xf00c, 0xf003, 0xc00f,
+	0x300f, 0xc0f, 0x30f, 0xcf, 0x3f
+};
+
+#define CFG80211_PER_BW_VALID_PUNCTURING_VALUES(_bw) \
+	{ \
+		.len = ARRAY_SIZE(puncturing_values_ ## _bw ## mhz), \
+		.valid_values = puncturing_values_ ## _bw ## mhz \
+	}
+
+static const struct cfg80211_per_bw_puncturing_values per_bw_puncturing[] = {
+	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(80),
+	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(160),
+	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(320)
+};
+
+bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
+					      const struct cfg80211_chan_def *chandef)
+{
+	u32 idx, i, start_freq;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_80:
+		idx = 0;
+		start_freq = chandef->center_freq1 - 40;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		idx = 1;
+		start_freq = chandef->center_freq1 - 80;
+		break;
+	case NL80211_CHAN_WIDTH_320:
+		idx = 2;
+		start_freq = chandef->center_freq1 - 160;
+		break;
+	default:
+		*bitmap = 0;
+		break;
+	}
+
+	if (!*bitmap)
+		return true;
+
+	/* check if primary channel is punctured */
+	if (*bitmap & (u16)BIT((chandef->chan->center_freq - start_freq) / 20))
+		return false;
+
+	for (i = 0; i < per_bw_puncturing[idx].len; i++)
+		if (per_bw_puncturing[idx].valid_values[i] == *bitmap)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(cfg80211_valid_disable_subchannel_bitmap);
-- 
2.39.0

