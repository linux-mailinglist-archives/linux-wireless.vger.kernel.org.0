Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047636A695A
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 10:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCAJDN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 04:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjCAJDI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 04:03:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4918169
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 01:03:06 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3215GCa1025277;
        Wed, 1 Mar 2023 09:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=05IUkyatxDgyOHt20aKDwtsxSQ/lwu0l7Laau5u7w/M=;
 b=kIIXSTyBLZ0LHGZq/utTIgiqTBRXgttJ+MCDAk6IaHocvwqo3awjSPR5Sp/YxY2LlcqL
 Ef+6X7Qflass0ReukoQe3UTrBK79rHnC5rrGxhPw7dMbU+48MECqtjyfveem3JLAvsvG
 gk0gBFSu3YfTDZ+kdNuT+FEoKZ56dVkpKv/k5kYG5dyb60e00mgiDGpSd8TyjOmaHEWa
 K3wEvGCQez39CUcMM134n48c0an+pN9ZRJLiAIYm76fsyQ3ciehVICojc2bq5nB+X+YA
 xrxjo6YNLnxNGHezU1Dve8OtTuegysJeBfLcHnrgzlncZ50cpSbqLO/Aj0bZFF7qo4yl ww== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1n0tjdt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 09:03:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321932xF012570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 09:03:02 GMT
Received: from xinyling-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 1 Mar 2023 01:03:01 -0800
From:   Xinyue Ling <quic_xinyling@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: nl80211: Add support to specify channel width for scan (option 2)
Date:   Wed, 1 Mar 2023 17:02:42 +0800
Message-ID: <20230301090242.1613672-5-quic_xinyling@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Rln5wfIcmDdph6YpMbafRRH7rEtMZb5v
X-Proofpoint-GUID: Rln5wfIcmDdph6YpMbafRRH7rEtMZb5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce a new NL80211_ATTR_SCAN_CHANNEL_WIDTH attribute
with enum nl80211_bss_scan_width semantics and add support
to parse it for nl80211_commands NL80211_CMD_TRIGGER_SCAN
and NL80211_CMD_START_SCHED_SCAN. Also add a new
scan_width_set flag in the scan request sent to the driver
to indicate whether the scan channel width is passed from
the userspace.

If channel width lower than 20 MHz is specified, it is
expected that only BSSs using this channel width can be
found. If 20 MHz or higher channel width is specified, it
is expected that all the BSSs using 20 MHz or higher channel
width can be found as their management frames can be received
on the primary 20 MHz channel. If this attribute is not passed
from the userspace, the scan channel width will be decided by
the driver.

One example for such use case is connection between drone
and drone controller, userspace may need to specify the
scan channel width, which needs to be passed to the driver
to trigger the scan on this specified channel width.

Signed-off-by: Xinyue Ling <quic_xinyling@quicinc.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h | 28 ++++++++++++++++++++++++++--
 net/wireless/nl80211.c       | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 54a77d906b2d..bbf566190a87 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2400,6 +2400,8 @@ struct cfg80211_scan_6ghz_params {
  * @channels: channels to scan on.
  * @n_channels: total number of channels to scan
  * @scan_width: channel width for scanning
+ * @scan_width_set: channel width for scanning is specified from the
+ *	userspace
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
  * @duration: how long to listen on each channel, in TUs. If
@@ -2430,6 +2432,7 @@ struct cfg80211_scan_request {
 	int n_ssids;
 	u32 n_channels;
 	enum nl80211_bss_scan_width scan_width;
+	bool scan_width_set;
 	const u8 *ie;
 	size_t ie_len;
 	u16 duration;
@@ -2525,6 +2528,8 @@ struct cfg80211_bss_select_adjust {
  * @n_ssids: number of SSIDs
  * @n_channels: total number of channels to scan
  * @scan_width: channel width for scanning
+ * @scan_width_set: channel width for scanning is specified from the
+ *	userspace
  * @ie: optional information element(s) to add into Probe Request or %NULL
  * @ie_len: length of ie in octets
  * @flags: bit field of flags controlling operation
@@ -2573,6 +2578,7 @@ struct cfg80211_sched_scan_request {
 	int n_ssids;
 	u32 n_channels;
 	enum nl80211_bss_scan_width scan_width;
+	bool scan_width_set;
 	const u8 *ie;
 	size_t ie_len;
 	u32 flags;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3f15ac05f581..6d78185bb728 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -501,7 +501,13 @@
  *	%NL80211_ATTR_TX_NO_CCK_RATE is used to decide whether to send the
  *	probe requests at CCK rate or not. %NL80211_ATTR_BSSID can be used to
  *	specify a BSSID to scan for; if not included, the wildcard BSSID will
- *	be used.
+ *	be used. %NL80211_ATTR_SCAN_CHANNEL_WIDTH can be passed from the
+ *	userspace to specify the scan channel width; if channel bandwidth lower
+ *	than 20 MHz is specified, it is expected that only BSSs using this channel
+ *	bandwidth can be found; if 20 MHz or higher channel bandwidth channel
+ *	bandwidth is specified, it is expected that all the BSSs using 20 MHz or
+ *	higher channel bandwidth can be found; if not included, the scan channel
+ *	bandwidth will be decided by the driver.
  * @NL80211_CMD_NEW_SCAN_RESULTS: scan notification (as a reply to
  *	NL80211_CMD_GET_SCAN and on the "scan" multicast group)
  * @NL80211_CMD_SCAN_ABORTED: scan was aborted, for unspecified reasons,
@@ -530,6 +536,13 @@
  *	is supplied. If the device supports multiple concurrent scheduled
  *	scans, it will allow such when the caller provides the flag attribute
  *	%NL80211_ATTR_SCHED_SCAN_MULTI to indicate user-space support for it.
+ *	%NL80211_ATTR_SCAN_CHANNEL_WIDTH can be passed from the userspace to
+ *	specify the scan channel width; if channel bandwidth lower than 20 MHz
+ *	is specified, it is expected that only BSSs using this channel bandwidth
+ *	can be found; if 20 MHz or higher channel bandwidth channel bandwidth is
+ *	specified, it is expected that all the BSSs using 20 MHz or higher channel
+ *	bandwidth can be found; if not included, the scan channel bandwidth will
+ *	be decided by the driver.
  * @NL80211_CMD_STOP_SCHED_SCAN: stop a scheduled scan. Returns -ENOENT if
  *	scheduled scan is not running. The caller may assume that as soon
  *	as the call returns, it is safe to start a new scheduled scan again.
@@ -2752,6 +2765,9 @@ enum nl80211_commands {
  *	the incoming frame RX timestamp.
  * @NL80211_ATTR_TD_BITMAP: Transition Disable bitmap, for subsequent
  *	(re)associations.
+ * @NL80211_ATTR_SCAN_CHANNEL_WIDTH: u32 attribute containing one of the
+ *	values of &enum nl80211_bss_scan_width, describing the scan channel
+ *	width. See the documentation of the enum for more information.
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3281,6 +3297,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_RX_HW_TIMESTAMP,
 	NL80211_ATTR_TD_BITMAP,
 
+	NL80211_ATTR_SCAN_CHANNEL_WIDTH,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -4896,7 +4914,8 @@ enum nl80211_chan_width {
 /**
  * enum nl80211_bss_scan_width - control channel width for a BSS
  *
- * These values are used with the %NL80211_BSS_CHAN_WIDTH attribute.
+ * These values are used with the %NL80211_BSS_CHAN_WIDTH attribute
+ * and the %NL80211_ATTR_SCAN_CHANNEL_WIDTH attribute.
  *
  * @NL80211_BSS_CHAN_WIDTH_20: control channel is 20 MHz wide or compatible
  * @NL80211_BSS_CHAN_WIDTH_10: control channel is 10 MHz wide
@@ -4906,6 +4925,9 @@ enum nl80211_chan_width {
  * @NL80211_BSS_CHAN_WIDTH_4: control channel is 4 MHz wide
  * @NL80211_BSS_CHAN_WIDTH_8: control channel is 8 MHz wide
  * @NL80211_BSS_CHAN_WIDTH_16: control channel is 16 MHz wide
+ * @NUM_NL80211_BSS_CHAN_WIDTH: number of values, avoid using this in
+ *	userspace since newer kernel versions may support more channel
+ *	widths
  */
 enum nl80211_bss_scan_width {
 	NL80211_BSS_CHAN_WIDTH_20,
@@ -4916,6 +4938,8 @@ enum nl80211_bss_scan_width {
 	NL80211_BSS_CHAN_WIDTH_4,
 	NL80211_BSS_CHAN_WIDTH_8,
 	NL80211_BSS_CHAN_WIDTH_16,
+
+	NUM_NL80211_BSS_CHAN_WIDTH
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 64cf6110ce9d..bcafeb0691d0 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+	[NL80211_ATTR_SCAN_CHANNEL_WIDTH] =
+		NLA_POLICY_MAX(NLA_U32, NUM_NL80211_BSS_CHAN_WIDTH),
 };
 
 /* policy for the key attributes */
@@ -9120,6 +9122,12 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			nla_get_flag(info->attrs[NL80211_ATTR_MEASUREMENT_DURATION_MANDATORY]);
 	}
 
+	if (info->attrs[NL80211_ATTR_SCAN_CHANNEL_WIDTH]) {
+		request->scan_width =
+			nla_get_u32(info->attrs[NL80211_ATTR_SCAN_CHANNEL_WIDTH]);
+		request->scan_width_set = true;
+	}
+
 	err = nl80211_check_scan_flags(wiphy, wdev, request, info->attrs,
 				       false);
 	if (err)
@@ -9611,6 +9619,12 @@ nl80211_parse_sched_scan(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       request->ie_len);
 	}
 
+	if (attrs[NL80211_ATTR_SCAN_CHANNEL_WIDTH]) {
+		request->scan_width =
+			nla_get_u32(attrs[NL80211_ATTR_SCAN_CHANNEL_WIDTH]);
+		request->scan_width_set = true;
+	}
+
 	err = nl80211_check_scan_flags(wiphy, wdev, request, attrs, true);
 	if (err)
 		goto out_free;
-- 
2.25.1

