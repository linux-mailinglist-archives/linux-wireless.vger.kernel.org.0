Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB36A695B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCAJDO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCAJDI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:03:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1E1116E
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:03:05 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3216digh011946;
        Wed, 1 Mar 2023 09:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=CmagkZxfxWP0JvogyCUmJDghC9cVRTC80UqNK/ZHT4U=;
 b=TzuuLaI5QC8MJeqxOdPv1F59OQ6+vW/87bUja06MhmDdKg7CeoicOcgefXw9NeTV1fdz
 D8G7QEvlXRfKwtAJQ6Byl+LNhyFtKh/rNamq+iJbhdBDNX8LiOmLOakzY/jUW3hauYgb
 Tn4P3ReEfV3dnB7jwVirxXveWKO0rbog126W461Qbb7SmaiRlKVbKPCQbGuHPaBcsT1O
 n9m6yysJKpyyA17l65Akj+3mQl8un32K/2JooOhQz93uZfTEAmOx++PB8YnxES0fsj6g
 7JZ/QDSAl2mSPQ79GVZFVy+5DtKCpM8EeUu45Rtz4udxxApBEe2izv8bybNoCh/gs7L3 Sg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1f7n3mm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 09:03:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321931bC019653
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 09:03:01 GMT
Received: from xinyling-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 01:03:00 -0800
From:   Xinyue Ling <quic_xinyling@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] Revert "wifi: nl80211: Add support to specify channel width for scan (option 1)"
Date:   Wed, 1 Mar 2023 17:02:41 +0800
Message-ID: <20230301090242.1613672-4-quic_xinyling@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301090242.1613672-1-quic_xinyling@quicinc.com>
References: <20230301090242.1613672-1-quic_xinyling@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ccxcNQZ-QziuYwU382qFbMLDG8rIxJLQ
X-Proofpoint-ORIG-GUID: ccxcNQZ-QziuYwU382qFbMLDG8rIxJLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303010074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 include/net/cfg80211.h       |  6 -----
 include/uapi/linux/nl80211.h | 19 +--------------
 net/wireless/nl80211.c       | 47 +-----------------------------------
 3 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index bbf566190a87..54a77d906b2d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2400,8 +2400,6 @@ struct cfg80211_scan_6ghz_params {
  * @channels: channels to scan on.
  * @n_channels: total number of channels to scan
  * @scan_width: channel width for scanning
- * @scan_width_set: channel width for scanning is specified from the
- *	userspace
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
  * @duration: how long to listen on each channel, in TUs. If
@@ -2432,7 +2430,6 @@ struct cfg80211_scan_request {
 	int n_ssids;
 	u32 n_channels;
 	enum nl80211_bss_scan_width scan_width;
-	bool scan_width_set;
 	const u8 *ie;
 	size_t ie_len;
 	u16 duration;
@@ -2528,8 +2525,6 @@ struct cfg80211_bss_select_adjust {
  * @n_ssids: number of SSIDs
  * @n_channels: total number of channels to scan
  * @scan_width: channel width for scanning
- * @scan_width_set: channel width for scanning is specified from the
- *	userspace
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
  * @flags: bit field of flags controlling operation
@@ -2578,7 +2573,6 @@ struct cfg80211_sched_scan_request {
 	int n_ssids;
 	u32 n_channels;
 	enum nl80211_bss_scan_width scan_width;
-	bool scan_width_set;
 	const u8 *ie;
 	size_t ie_len;
 	u32 flags;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 03b60d987a1b..3f15ac05f581 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -501,13 +501,7 @@
  *	%NL80211_ATTR_TX_NO_CCK_RATE is used to decide whether to send the
  *	probe requests at CCK rate or not. %NL80211_ATTR_BSSID can be used to
  *	specify a BSSID to scan for; if not included, the wildcard BSSID will
- *	be used. %NL80211_ATTR_CHANNEL_WIDTH can be passed from the userspace
- *	to specify the scan channel bandwidth; if channel bandwidth lower than
- *	20 MHz is specified, it is expected that only BSSs using this channel
- *	bandwidth can be found; if 20 MHz or higher channel bandwidth is
- *	specified, it is expected that all the BSSs using 20 MHz or higher
- *	channel bandwidth can be found; if not included, the scan channel
- *	bandwidth will be decided by the driver.
+ *	be used.
  * @NL80211_CMD_NEW_SCAN_RESULTS: scan notification (as a reply to
  *	NL80211_CMD_GET_SCAN and on the "scan" multicast group)
  * @NL80211_CMD_SCAN_ABORTED: scan was aborted, for unspecified reasons,
@@ -536,13 +530,6 @@
  *	is supplied. If the device supports multiple concurrent scheduled
  *	scans, it will allow such when the caller provides the flag attribute
  *	%NL80211_ATTR_SCHED_SCAN_MULTI to indicate user-space support for it.
- *	%NL80211_ATTR_CHANNEL_WIDTH can be passed from the userspace to specify
- *	the scan channel width; if channel bandwidth lower than 20 MHz is
- *	specified, it is expected that only BSSs using this channel bandwidth
- *	can be found; if 20 MHz or higher channel bandwidth is specified, it is
- *	expected that all the BSSs using 20 MHz or higher channel bandwidth can
- *	be found; if not included, the scan channel bandwidth will be decided by
- *	the driver.
  * @NL80211_CMD_STOP_SCHED_SCAN: stop a scheduled scan. Returns -ENOENT if
  *	scheduled scan is not running. The caller may assume that as soon
  *	as the call returns, it is safe to start a new scheduled scan again.
@@ -4888,8 +4875,6 @@ enum nl80211_key_mode {
  * @NL80211_CHAN_WIDTH_16: 16 MHz OFDM channel
  * @NL80211_CHAN_WIDTH_320: 320 MHz channel, the %NL80211_ATTR_CENTER_FREQ1
  *	attribute must be provided as well
- * @NUM_NL80211_CHAN_WIDTH: number of values, avoid using this in userspace
- *	since newer kernel versions may support more channel widths
  */
 enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_20_NOHT,
@@ -4906,8 +4891,6 @@ enum nl80211_chan_width {
 	NL80211_CHAN_WIDTH_8,
 	NL80211_CHAN_WIDTH_16,
 	NL80211_CHAN_WIDTH_320,
-
-	NUM_NL80211_CHAN_WIDTH
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2048a98c3273..64cf6110ce9d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -478,8 +478,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 						NL80211_EDMG_BW_CONFIG_MIN,
 						NL80211_EDMG_BW_CONFIG_MAX),
 
-	[NL80211_ATTR_CHANNEL_WIDTH] =
-		NLA_POLICY_MAX(NLA_U32, NUM_NL80211_CHAN_WIDTH),
+	[NL80211_ATTR_CHANNEL_WIDTH] = { .type = NLA_U32 },
 	[NL80211_ATTR_CENTER_FREQ1] = { .type = NLA_U32 },
 	[NL80211_ATTR_CENTER_FREQ1_OFFSET] = NLA_POLICY_RANGE(NLA_U32, 0, 999),
 	[NL80211_ATTR_CENTER_FREQ2] = { .type = NLA_U32 },
@@ -8925,34 +8924,6 @@ nl80211_check_scan_flags(struct wiphy *wiphy, struct wireless_dev *wdev,
 	return 0;
 }
 
-static enum nl80211_bss_scan_width
-chan_width_to_scan_width(enum nl80211_chan_width width)
-{
-	switch (width) {
-	case NL80211_CHAN_WIDTH_5:
-		return NL80211_BSS_CHAN_WIDTH_5;
-	case NL80211_CHAN_WIDTH_10:
-		return NL80211_BSS_CHAN_WIDTH_10;
-	case NL80211_CHAN_WIDTH_1:
-		return NL80211_BSS_CHAN_WIDTH_1;
-	case NL80211_CHAN_WIDTH_2:
-		return NL80211_BSS_CHAN_WIDTH_2;
-	case NL80211_CHAN_WIDTH_4:
-		return NL80211_BSS_CHAN_WIDTH_4;
-	case NL80211_CHAN_WIDTH_8:
-		return NL80211_BSS_CHAN_WIDTH_8;
-	case NL80211_CHAN_WIDTH_16:
-		return NL80211_BSS_CHAN_WIDTH_16;
-	default:
-		/* for the rest of channel bandwidth values (20 MHz or higher),
-		 * scan channel bandwidth can be set to NL80211_BSS_CHAN_WIDTH_20
-		 * as management frames of BSSs using 20 MHz or higher channel
-		 * can be received on the primary 20 MHz channel
-		 */
-		return NL80211_BSS_CHAN_WIDTH_20;
-	}
-}
-
 static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -9149,14 +9120,6 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			nla_get_flag(info->attrs[NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY]);
 	}
 
-	if (info->attrs[NL80211_ATTR_CHANNEL_WIDTH]) {
-		enum nl80211_chan_width chan_width;
-
-		chan_width = nla_get_u32(info->attrs[NL80211_ATTR_CHANNEL_WIDTH]);
-		request->scan_width = chan_width_to_scan_width(chan_width);
-		request->scan_width_set = true;
-	}
-
 	err = nl80211_check_scan_flags(wiphy, wdev, request, info->attrs,
 				       false);
 	if (err)
@@ -9648,14 +9611,6 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       request->ie_len);
 	}
 
-	if (attrs[NL80211_ATTR_CHANNEL_WIDTH]) {
-		enum nl80211_chan_width chan_width;
-
-		chan_width = nla_get_u32(attrs[NL80211_ATTR_CHANNEL_WIDTH]);
-		request->scan_width = chan_width_to_scan_width(chan_width);
-		request->scan_width_set = true;
-	}
-
 	err = nl80211_check_scan_flags(wiphy, wdev, request, attrs, true);
 	if (err)
 		goto out_free;
-- 
2.25.1

