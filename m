Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45106BB4A2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjCONaJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjCON3o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 09:29:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B96A90081
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 06:29:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FB2VXB001524;
        Wed, 15 Mar 2023 13:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=A5cwBDEQQaiZOiOcBwZZI5nDqXSOCEAJP3vBiw7Qijg=;
 b=TJ3GSG4dXfuDDdwvrLA2KhHVEMIPVDmr1qnT5wQwDS9M1/CbWLn7IwwfjM+wr2d4jhnI
 J03VNZWRVOEG6O83y7ukM3ygaesi8F1sCIwn3u2QsP+gHt1ceirpZxvpp3dQ4VmXqNc1
 HvHURGx/V+v5phIHhyxmbrWwiRuxGwA0ZDIecF/la7q+Jb3Leavlrj5iMTpfLI84leA1
 qXH8pnls/i21x4D3sg1am5/NUprRqY3FqXXOKSOupq/1jhbGtps1ClOBrgjLvvkEYhKY
 NS/3Mhx5onf9BTlaGdEUcvCYZxvaYwEKF8IDA8nCnnbhBqwJ4Gr58KQ+MAEe6KGc4zGS 2g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pb2by9n2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FDTbOE023775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:29:38 GMT
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 15 Mar 2023 06:29:36 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 9/9] wifi: mac80211: use proper API to fetch 6 GHz channel
Date:   Wed, 15 Mar 2023 18:59:04 +0530
Message-ID: <20230315132904.31779-10-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230315132904.31779-1-quic_adisi@quicinc.com>
References: <20230315132904.31779-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nxW6RTdx8xFKh_q8xOeMbz6taHjJ8Voj
X-Proofpoint-GUID: nxW6RTdx8xFKh_q8xOeMbz6taHjJ8Voj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit "wifi: mac80211: add support for 6 GHz channels and regulatory" adds
different channel pools for different power modes for 6 GHz channels.

Currently, during MLME and association BSS handling, channel is fetched
from older API ieee80211_get_channel_khz which will not consider the power
mode for 6 GHz. Hence use proper API ieee80211_get_6ghz_channel_khz to fetch
the 6 GHz channel.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 net/mac80211/mlme.c    | 14 ++++++++++++--
 net/mac80211/scan.c    | 15 +++++++++++++--
 net/wireless/nl80211.c | 35 ++++++++++++++++++++++++++---------
 3 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e13a0354c397..7fc3f4af8202 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5361,11 +5361,21 @@ static void ieee80211_rx_bss_info(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
+	u32 rx_freq_khz = ieee80211_rx_status_to_khz(rx_status);
+	enum nl80211_regulatory_power_modes power_mode_6ghz;
 
 	sdata_assert_lock(sdata);
 
-	channel = ieee80211_get_channel_khz(local->hw.wiphy,
-					ieee80211_rx_status_to_khz(rx_status));
+	if (is_6ghz_freq_khz(rx_freq_khz)) {
+		ieee80211_get_6ghz_power_mode(&sdata->wdev, 0,
+					      &power_mode_6ghz);
+		channel = ieee80211_get_6ghz_channel_khz(local->hw.wiphy,
+							 rx_freq_khz,
+							 power_mode_6ghz);
+	} else {
+		channel = ieee80211_get_channel_khz(local->hw.wiphy,
+						    rx_freq_khz);
+	}
 	if (!channel)
 		return;
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 32fa8aca7005..bd5f73b06856 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -261,6 +261,8 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	struct ieee80211_channel *channel;
 	size_t min_hdr_len = offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
+	u32 rx_freq_khz = ieee80211_rx_status_to_khz(rx_status);
+	enum nl80211_regulatory_power_modes power_mode_6ghz;
 
 	if (!ieee80211_is_probe_resp(mgmt->frame_control) &&
 	    !ieee80211_is_beacon(mgmt->frame_control) &&
@@ -319,8 +321,17 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 			return;
 	}
 
-	channel = ieee80211_get_channel_khz(local->hw.wiphy,
-					ieee80211_rx_status_to_khz(rx_status));
+	if (is_6ghz_freq_khz(rx_freq_khz)) {
+		ieee80211_get_6ghz_power_mode(sdata1 ? &sdata1->wdev : &sdata2->wdev,
+					      0, &power_mode_6ghz);
+
+		channel = ieee80211_get_6ghz_channel_khz(local->hw.wiphy,
+							 rx_freq_khz,
+							 power_mode_6ghz);
+	} else {
+		channel = ieee80211_get_channel_khz(local->hw.wiphy,
+						    rx_freq_khz);
+	}
 
 	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
 		return;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index cdb26aac24d1..8d97a3e58015 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1574,12 +1574,26 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 	return 0;
 }
 
-static struct ieee80211_channel *nl80211_get_valid_chan(struct wiphy *wiphy,
+static struct ieee80211_channel *nl80211_get_valid_chan(struct wireless_dev *wdev,
+							unsigned int link_id,
 							u32 freq)
 {
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct ieee80211_channel *chan;
+	enum nl80211_regulatory_power_modes power_mode_6ghz;
+
+	if (is_6ghz_freq_khz(freq)) {
+		power_mode_6ghz = rdev_get_6ghz_power_mode(rdev, wdev, link_id);
+
+		if (power_mode_6ghz >= NL80211_REG_PWR_MODE_MAX)
+			return NULL;
+
+		chan = ieee80211_get_6ghz_channel_khz(wiphy, freq, power_mode_6ghz);
+	} else {
+		chan = ieee80211_get_channel_khz(wiphy, freq);
+	}
 
-	chan = ieee80211_get_channel_khz(wiphy, freq);
 	if (!chan || chan->flags & IEEE80211_CHAN_DISABLED)
 		return NULL;
 	return chan;
@@ -10652,7 +10666,7 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		freq +=
 		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
-	chan = nl80211_get_valid_chan(&rdev->wiphy, freq);
+	chan = nl80211_get_valid_chan(dev->ieee80211_ptr, 0, freq);
 	if (!chan)
 		return -EINVAL;
 
@@ -10861,6 +10875,8 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 }
 
 static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device *rdev,
+					      struct net_device *dev,
+					      unsigned int link_id,
 					      const u8 *ssid, int ssid_len,
 					      struct nlattr **attrs,
 					      const u8 **bssid_out)
@@ -10879,7 +10895,7 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 	if (attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
 		freq += nla_get_u32(attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
-	chan = nl80211_get_valid_chan(&rdev->wiphy, freq);
+	chan = nl80211_get_valid_chan(dev->ieee80211_ptr, link_id, freq);
 	if (!chan)
 		return ERR_PTR(-EINVAL);
 
@@ -11062,8 +11078,8 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 				goto free;
 			}
 			req.links[link_id].bss =
-				nl80211_assoc_bss(rdev, ssid, ssid_len, attrs,
-						  &bssid);
+				nl80211_assoc_bss(rdev, dev, link_id, ssid, ssid_len,
+						  attrs, &bssid);
 			if (IS_ERR(req.links[link_id].bss)) {
 				err = PTR_ERR(req.links[link_id].bss);
 				req.links[link_id].bss = NULL;
@@ -11114,7 +11130,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		if (req.link_id >= 0)
 			return -EINVAL;
 
-		req.bss = nl80211_assoc_bss(rdev, ssid, ssid_len, info->attrs,
+		req.bss = nl80211_assoc_bss(rdev, dev, 0, ssid, ssid_len, info->attrs,
 					    &bssid);
 		if (IS_ERR(req.bss))
 			return PTR_ERR(req.bss);
@@ -11813,13 +11829,14 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
 	if (freq) {
-		connect.channel = nl80211_get_valid_chan(wiphy, freq);
+		connect.channel = nl80211_get_valid_chan(dev->ieee80211_ptr, 0, freq);
 		if (!connect.channel)
 			return -EINVAL;
 	} else if (info->attrs[NL80211_ATTR_WIPHY_FREQ_HINT]) {
 		freq = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_HINT]);
 		freq = MHZ_TO_KHZ(freq);
-		connect.channel_hint = nl80211_get_valid_chan(wiphy, freq);
+		connect.channel_hint = nl80211_get_valid_chan(dev->ieee80211_ptr, 0,
+							      freq);
 		if (!connect.channel_hint)
 			return -EINVAL;
 	}
-- 
2.17.1

