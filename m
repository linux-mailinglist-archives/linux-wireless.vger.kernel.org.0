Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECE8682073
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 01:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjAaAMt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 19:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjAaAMr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 19:12:47 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA2F1A968
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 16:12:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UM5Uro016606;
        Tue, 31 Jan 2023 00:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=c6E17MzJxjRAuZpweRFJvv/+dP5OLfuVgQrTt+/EdWY=;
 b=j/86ixHGCToxVG0yFIyEX48bez0gdMinMNq4z+juzn/x6qhShs05ka9cyx9I5RPeco7g
 RrskNiSx//gOB1DBx7Y0mp2Ns4imP7bWprv/A+I5/h85TbWpv8U2hiz18DR3bNWARml4
 KLOi7ZllFYbewZTYjsVZXlFd5v59/Oc99pj8uN+FE5lBATVBeZcs+Is3oDoDFve5q1Mg
 Fap2menFg526iJRAdEjSHm20vs/CHi/lvHMbeSNObO/uGTD9CIVsbR8LLSodioERwS/X
 iLSjhA7p5mMMe/RZMPV9pbRUEgg8RyN/NBuRzDQh+NM3gs7Z7EHIaK9oFIp37AFqnZwU Vw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncut2n9ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V0CebG006391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 00:12:40 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 16:12:40 -0800
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH v4 2/4] wifi: nl80211: validate and configure puncturing bitmap
Date:   Mon, 30 Jan 2023 16:12:25 -0800
Message-ID: <20230131001227.25014-3-quic_alokad@quicinc.com>
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
X-Proofpoint-GUID: QBAqzpSIulMvRhplJ4dzuAXAZrb-EV9u
X-Proofpoint-ORIG-GUID: QBAqzpSIulMvRhplJ4dzuAXAZrb-EV9u
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

- New feature flag, NL80211_EXT_FEATURE_PUNCTURING, to advertise
driver support for preamble puncturing.
- New attribute, NL80211_ATTR_PUNCT_BITMAP, to receive a puncturing
bitmap from the userspace during AP bring up (NL80211_CMD_START_AP)
and channel switch (NL80211_CMD_CHANNEL_SWITCH) operations. Each bit
corresponds to a 20 MHz channel in the operating bandwidth, lowest bit
for the lowest channel. Bit set to 1 indicates that the channel is
punctured. Higher 16 bits are reserved.
- New members added to structures cfg80211_ap_settings and
cfg80211_csa_settings to propagate the bitmap to MAC80211 after
validation.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 include/net/cfg80211.h       |  8 ++++++++
 include/uapi/linux/nl80211.h | 12 ++++++++++++
 net/wireless/nl80211.c       | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 505a1072b5b4..f70f28776dc0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1316,6 +1316,9 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @fils_discovery: FILS discovery transmission parameters
  * @unsol_bcast_probe_resp: Unsolicited broadcast probe response parameters
  * @mbssid_config: AP settings for multiple bssid
+ * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
+ *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
+ *	Bit set to 1 indicates that the channel is punctured.
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1350,6 +1353,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_fils_discovery fils_discovery;
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
+	u16 punct_bitmap;
 };
 
 /**
@@ -1367,6 +1371,9 @@ struct cfg80211_ap_settings {
  * @radar_required: whether radar detection is required on the new channel
  * @block_tx: whether transmissions should be blocked while changing
  * @count: number of beacons until switch
+ * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
+ *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
+ *	Bit set to 1 indicates that the channel is punctured.
  */
 struct cfg80211_csa_settings {
 	struct cfg80211_chan_def chandef;
@@ -1379,6 +1386,7 @@ struct cfg80211_csa_settings {
 	bool radar_required;
 	bool block_tx;
 	u8 count;
+	u16 punct_bitmap;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8ecb0fbee721..4dfd6990fa97 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2752,6 +2752,12 @@ enum nl80211_commands {
  *	the incoming frame RX timestamp.
  * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
  *	(re)associations.
+ *
+ * @NL80211_ATTR_PUNCT_BITMAP: (u32) Preamble puncturing bitmap, lowest
+ *	bit corresponds to the lowest 20 MHz channel. Each bit set to 1
+ *	indicates that the sub-channel is punctured. Higher 16 bits are
+ *	reserved.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3281,6 +3287,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 	NL80211_ATTR_TD_BITMAP,
 
+	NL80211_ATTR_PUNCT_BITMAP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6296,6 +6304,8 @@ enum nl80211_feature_flags {
  *	might apply, e.g. no scans in progress, no offchannel operations
  *	in progress, and no active connections.
  *
+ * @NL80211_EXT_FEATURE_PUNCT: Driver supports preamble puncturing in AP mode.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6365,6 +6375,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
 	NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE,
 
+	NL80211_EXT_FEATURE_PUNCT,
+
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
 	MAX_NL80211_EXT_FEATURES = NUM_NL80211_EXT_FEATURES - 1
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 64cf6110ce9d..d2219f43a2ea 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_PUNCT_BITMAP] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -3173,6 +3174,27 @@ static bool nl80211_can_set_dev_channel(struct wireless_dev *wdev)
 		wdev->iftype == NL80211_IFTYPE_P2P_GO;
 }
 
+static int nl80211_parse_punct_bitmap(struct cfg80211_registered_device *rdev,
+				      struct genl_info *info,
+				      const struct cfg80211_chan_def *chandef,
+				      u16 *punct_bitmap)
+{
+	u32 bitmap;
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_PUNCT))
+		return -EINVAL;
+
+	bitmap = nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]);
+	if (bitmap & 0xFFFF0000)
+		return -EINVAL;
+
+	*punct_bitmap = bitmap;
+	if (!cfg80211_valid_disable_subchannel_bitmap(punct_bitmap, chandef))
+		return -EINVAL;
+
+	return 0;
+}
+
 int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 			  struct genl_info *info,
 			  struct cfg80211_chan_def *chandef)
@@ -5918,6 +5940,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
+		err = nl80211_parse_punct_bitmap(rdev, info,
+						 &params->chandef,
+						 &params->punct_bitmap);
+		if (err)
+			goto out;
+	}
+
 	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params->chandef,
 					   wdev->iftype)) {
 		err = -EINVAL;
@@ -10057,6 +10087,14 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CH_SWITCH_BLOCK_TX])
 		params.block_tx = true;
 
+	if (info->attrs[NL80211_ATTR_PUNCT_BITMAP]) {
+		err = nl80211_parse_punct_bitmap(rdev, info,
+						 &params.chandef,
+						 &params.punct_bitmap);
+		if (err)
+			goto free;
+	}
+
 	wdev_lock(wdev);
 	err = rdev_channel_switch(rdev, dev, &params);
 	wdev_unlock(wdev);
-- 
2.39.0

