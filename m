Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C086C1CDF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 17:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjCTQxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjCTQwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 12:52:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B65B976C
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 09:44:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KBtOV7010971;
        Mon, 20 Mar 2023 16:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=GG4Ybmu1C7BBmuwaP1cJXzofotPFLEMeN99cRVZF2n4=;
 b=NzuXtIo+2D5IQIHjNvBMsB4CgWq6Qz6ejfQPuEDNyfeYykS1/KE7qkCu50BNxvXza6Nl
 LtltCUQedwwpm1j0XqdCW/aXfwrMJzRM1qXEO3xzj+LNsD2lLdmCYJt69zIEoFmesogM
 dKZfqBSNDwTzL6LO6N+g5zywgT+w+HtUeWpyKb0jgqBTbw1MPf+NAi2OMU9p5Y1sDGOq
 9/KZFczke7yXsHl318qDE1qz/m4PeuSW7Xev2Pu3K59j7m8L8KYHrCliXf86u2k16d8V
 /wRdsAsB9WWX7wxopTwVzcxVlrmdW1F1sxDw01cSDizqmSLiFv62AapVLpQD6u2SEEpD Sw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pene1h17h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:06 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KGi5X6019290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:44:05 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 09:44:03 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH v2 2/4] wifi: nl80211: add configuration support for ap power save
Date:   Mon, 20 Mar 2023 22:13:32 +0530
Message-ID: <20230320164334.3325886-3-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
References: <20230320164334.3325886-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NyNheG7GpddR2tW_wWBm-NjA7DPgbaqp
X-Proofpoint-GUID: NyNheG7GpddR2tW_wWBm-NjA7DPgbaqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_14,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Add support to configure AP power save mode from the
user space using a new nl80211 attribute
NL80211_ATTR_AP_PS through the NL80211_CMD_UPDATE_AP
command.

This feature will be enabled when the driver advertise
the flag SUPPORTS_AP_PS to mac80211.

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 11 ++++++++++-
 net/wireless/nl80211.c       | 11 ++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0d62b5853929..31ef11700bad 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1331,6 +1331,7 @@ struct cfg80211_unsol_bcast_probe_resp {
  * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
  *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
  *	Bit set to 1 indicates that the channel is punctured.
+ * @ap_ps_enable: enable/disable ap power save.
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1366,6 +1367,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_unsol_bcast_probe_resp unsol_bcast_probe_resp;
 	struct cfg80211_mbssid_config mbssid_config;
 	u16 punct_bitmap;
+	bool ap_ps_enable;
 };
 
 /**
@@ -1376,9 +1378,13 @@ validation flags
  * to indicate the valid settings in struct cfg80211_ap_settings.
  *
  * @BEACON_VALID: beacon setting is valid.
+ * @AP_PS_VALID: AP PS setting is valid.
  */
 enum cfg80211_ap_settings_valid {
 	BEACON_VALID,
+	AP_PS_VALID,
+
+	/* keep last */
 	LAST_VALID,
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e7b7d8031582..e2b1e40d3f57 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -401,7 +401,8 @@
  *	attributes. For drivers that generate the beacon and probe responses
  *	internally, the following attributes must be provided for the
  *	beacon update: %NL80211_ATTR_IE, %NL80211_ATTR_IE_PROBE_RESP and
- *	%NL80211_ATTR_IE_ASSOC_RESP.
+ *	%NL80211_ATTR_IE_ASSOC_RESP. This following attribute must be
+ *	provided for the ap power save: %NL80211_ATTR_AP_PS.
  * @NL80211_CMD_START_AP: Start AP operation on an AP interface, parameters
  *	are like for %NL80211_CMD_UPDATE_AP, and additionally parameters that
  *	do not change are used, these include %NL80211_ATTR_BEACON_INTERVAL,
@@ -2745,6 +2746,12 @@ enum nl80211_commands {
  *	enumerated in &enum nl80211_ap_settings_flags. This attribute shall be
  *	used with %NL80211_CMD_START_AP request.
  *
+ * @NL80211_ATTR_AP_PS: enable/disable AP power save.
+ *	This attribute type is NLA_FLAG and valid input is 0 or 1.
+ *	0 for disable AP power save mode.
+ *	1 for enable AP power save mode.
+ *	This attribute shall be used with %%NL80211_CMD_UPDATE_AP.
+ *
  * @NL80211_ATTR_EHT_CAPABILITY: EHT Capability information element (from
  *	association request when used with NL80211_CMD_NEW_STATION). Can be set
  *	only if %NL80211_STA_FLAG_WME is set.
@@ -3331,6 +3338,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS,
 	NL80211_ATTR_HW_TIMESTAMP_ENABLED,
 
+	NL80211_ATTR_AP_PS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a45bda39d8ab..b3f6dc8e1543 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -809,6 +809,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_MAX_HW_TIMESTAMP_PEERS] = { .type = NLA_U16 },
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_AP_PS] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -6150,6 +6151,7 @@ static int nl80211_update_ap(struct sk_buff *skb, struct genl_info *info)
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_ap_update params;
 	int err;
+	bool haveinfo = false;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
@@ -6163,9 +6165,16 @@ static int nl80211_update_ap(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
+	if (info->attrs[NL80211_ATTR_AP_PS]) {
+		params.settings.ap_ps_enable =
+			!!nla_get_flag(info->attrs[NL80211_ATTR_AP_PS]);
+		set_bit(AP_PS_VALID, params.valid);
+		haveinfo = true;
+	}
+
 	err = nl80211_parse_beacon(rdev, info->attrs,
 				   &params.settings.beacon);
-	if (err)
+	if (err && !haveinfo)
 		goto out;
 
 	set_bit(BEACON_VALID, params.valid);
-- 
2.25.1

