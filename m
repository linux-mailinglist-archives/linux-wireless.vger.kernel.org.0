Return-Path: <linux-wireless+bounces-26433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD0BB29EEE
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 12:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79F5D4E143D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Aug 2025 10:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E62701C3;
	Mon, 18 Aug 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aYFBDi7e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6C221DAD
	for <linux-wireless@vger.kernel.org>; Mon, 18 Aug 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512423; cv=none; b=K+C05FNyOPPyeS4xPrEm5yP75zeq6qt/NyXC+8yphFN9yZpG2mNKqdNTdLh+RVZ00i7z+ts6d97tvABoohptqYbl6bzqY/tyOFVzIYfbdf2100nQ9PQXqOMJcdNQcgzobRfhDlGW00vsbLzeHr2dSFlDFFFz21TKpdgAsPV9bkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512423; c=relaxed/simple;
	bh=eMqqOq7vUb+aFUihdmForlEWbTGDWQjjNy7nomjRrxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dblqgBmepk4R92W0KlXGCWEZWTa7VqTgRPQWjnONrb+5vaKbB3JWpBXjOOoNkK8koYrNp6S9pqosskZznPhXVLETk2mQYTWYeHGxQPWxTkHi6ZjP1esjkEwIH9laeeijQjyZlzP4fIpJ9ePAPBRl7ziwP/PnxWM/8vdQVrLjs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aYFBDi7e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7V4D4026361;
	Mon, 18 Aug 2025 10:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RYHKw3olx98r5IBkxinZI8/iXIDZ29Rqk8uV+aBXW5I=; b=aYFBDi7eaTrOp05i
	VthPl3Rfx82+YKvpLmQnmVPN7u78OoFUZkJkSMEhm3Drcl5dCZjONBzFwvU/8nJV
	IcZFMCfxmSmMeP3SxlwIunzfmXjOqnmbdau2iot3CBLxcPCD/1Tgtqt064t3eGR8
	IVdSLPQqz5BxKVptqLGYv2htyQLCzvg6tJdz80AChzDeLcJPOlLMdEiv6H8nba/X
	8G/u+h0y47AWjR8Y+4iFzmkH62rhFH0KvuIYu7KaEVpzONKGDFocGWyz68EZabNd
	xkI7UBuIY8DjUZLT5YWyUX4QrEb19q+wpSmaXUTv5orExi2ynW/6iDz2i/3KrdW+
	fJzyPA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunrgj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57IAK7j9007055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:20:07 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 18 Aug 2025 03:20:05 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Hari
 Chandrakanthan" <quic_haric@quicinc.com>
Subject: [PATCH wireless-next 1/3] wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver
Date: Mon, 18 Aug 2025 15:49:45 +0530
Message-ID: <20250818101947.2464612-2-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
References: <20250818101947.2464612-1-quic_amitajit@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 79jIn-f84-LQO8sEUgC6Gc71D5FWvE6D
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a2fe60 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=doUQZJtgAAAA:8 a=COk6AnOGAAAA:8
 a=fqCjweuz0g9awfRUYlMA:9 a=3mapU_QI-1QA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfXxdFLyDitYWtJ
 aFN2Pq/5RJ5tPkFKueQadJXSoQze25LG9fD63YjNaI6xaaS+ipCIRlqhXh3pboyK4KZP6qsfKoa
 djuAcfDMU/HqLKi8fTRnEfbZWGYtfBxavdfQ6gik4qCHbKaqYwR3e4G4B/VCj+kd6RTHxR4OWcM
 1IAAbVCyoiaL2gLl+dzoa9pY3UxQGcGAYChS7VXXcV+WbWUz/gC77fVIZVkvTclmJEZ7hMDCjpZ
 E7uTr6lDd+BXoLDfrDmBNbRehXTiXwRFD/rCh88G32DAmy5bwH43yVzDDnrI1Qjir8vG+C5lvGv
 oUdg8VCynId48wJIhhrllxwF6X92G0hnfUsf3XV8+UrRGVnfAU9vxR17L3X17OPt2OCR7CJyKCw
 8aPzrmhq
X-Proofpoint-ORIG-GUID: 79jIn-f84-LQO8sEUgC6Gc71D5FWvE6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

From: Hari Chandrakanthan <quic_haric@quicinc.com>

When any incumbent signal is detected by an AP/mesh interface operating
in 6 GHz band, FCC mandates the AP/mesh to vacate the channels affected
by it [1].

Add a new API cfg80211_incumbent_signal_detect_event() that can be used
by mac80211 (or full mac drivers) to notify the higher layers about the
signal interference event with the interference bitmap in which each bit
denotes the affected 20 MHz in the operating channel.

Add support for the new nl80211 event and nl80211 attribute as well to
notify userspace on the details about the interference event. Userspace is
expected to process it and take further action - vacate the channel, or
reduce the bandwidth.

[1] - https://apps.fcc.gov/kdb/GetAttachment.html?id=nXQiRC%2B4mfiA54Zha%2BrW4Q%3D%3D&desc=987594%20D02%20U-NII%206%20GHz%20EMC%20Measurement%20v03&tracking_number=277034

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Amith A <quic_amitajit@quicinc.com>
---
 include/net/cfg80211.h       | 17 +++++++++++++++++
 include/uapi/linux/nl80211.h | 16 ++++++++++++++++
 net/wireless/mlme.c          | 12 ++++++++++++
 net/wireless/nl80211.c       | 35 +++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.h       |  4 ++++
 5 files changed, 84 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 406626ff6cc8..8d51ff648c46 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8984,6 +8984,23 @@ cfg80211_background_radar_event(struct wiphy *wiphy,
 	__cfg80211_radar_event(wiphy, chandef, true, gfp);
 }
 
+/**
+ * cfg80211_incumbent_signal_detect_event - Incumbent signal detection event
+ * @wiphy: the wiphy
+ * @chandef: chandef for the current channel
+ * @signal_interference_bitmap: Incumbent signal interference bitmap.
+ *	See %NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP description for
+ *	the usage.
+ * @gfp: context flags
+ *
+ * This function is called when any incumbent signal is detected on the
+ * current channel in the 6 GHz band.
+ */
+void cfg80211_incumbent_signal_detect_event(struct wiphy *wiphy,
+					    struct cfg80211_chan_def *chandef,
+					    u32 signal_interference_bitmap,
+					    gfp_t gfp);
+
 /**
  * cfg80211_sta_opmode_change_notify - STA's ht/vht operation mode change event
  * @dev: network device
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d1a14f2892d9..ec1220579e3d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1344,6 +1344,12 @@
  *	control EPCS configuration. Used to notify userland on the current state
  *	of EPCS.
  *
+ * @NL80211_CMD_INCUMBENT_SIGNAL_DETECT: Once any incumbent signal is detected
+ *	on the operating channel in 6 GHz band, userspace is notified with the
+ *	signal interference bitmap using
+ *	%NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP. The current channel
+ *	definition is also sent.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1604,6 +1610,8 @@ enum nl80211_commands {
 	NL80211_CMD_ASSOC_MLO_RECONF,
 	NL80211_CMD_EPCS_CFG,
 
+	NL80211_CMD_INCUMBENT_SIGNAL_DETECT,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2928,6 +2936,12 @@ enum nl80211_commands {
  *	required alongside this attribute. Refer to
  *	@enum nl80211_s1g_short_beacon_attrs for the attribute definitions.
  *
+ * @NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP: u32 attribute specifying
+ *	the signal interference bitmap detected on the operating bandwidth for
+ *	%NL80211_CMD_INCUMBENT_SIGNAL_DETECT. Each bit represents a 20 MHz
+ *	segment, lowest bit corresponds to the lowest 20 MHz segment, in the
+ *	operating bandwidth where the interference is detected.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3490,6 +3504,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_LONG_BEACON_PERIOD,
 	NL80211_ATTR_S1G_SHORT_BEACON,
 
+	NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 46394eb2086f..619d51a37b81 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1127,6 +1127,18 @@ void __cfg80211_radar_event(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(__cfg80211_radar_event);
 
+void cfg80211_incumbent_signal_detect_event(struct wiphy *wiphy,
+					    struct cfg80211_chan_def *chandef,
+					    u32 signal_interference_bitmap,
+					    gfp_t gfp)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	nl80211_incumbent_signal_notify(rdev, chandef,
+					signal_interference_bitmap, gfp);
+}
+EXPORT_SYMBOL(cfg80211_incumbent_signal_detect_event);
+
 void cfg80211_cac_event(struct net_device *netdev,
 			const struct cfg80211_chan_def *chandef,
 			enum nl80211_radar_event event, gfp_t gfp,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 89519aa52893..f26749c4499e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20422,6 +20422,41 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
+void nl80211_incumbent_signal_notify(struct cfg80211_registered_device *rdev,
+				     struct cfg80211_chan_def *chandef,
+				     u32 signal_interference_bitmap, gfp_t gfp)
+{
+	struct sk_buff *msg;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_INCUMBENT_SIGNAL_DETECT);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx))
+		goto nla_put_failure;
+
+	if (nl80211_send_chandef(msg, chandef))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP,
+			signal_interference_bitmap))
+		goto nla_put_failure;
+
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, gfp);
+	return;
+
+nla_put_failure:
+	nlmsg_free(msg);
+}
+
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index 5e25782af1e0..4a40eda33989 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -117,6 +117,10 @@ nl80211_radar_notify(struct cfg80211_registered_device *rdev,
 		     enum nl80211_radar_event event,
 		     struct net_device *netdev, gfp_t gfp);
 
+void nl80211_incumbent_signal_notify(struct cfg80211_registered_device *rdev,
+				     struct cfg80211_chan_def *chandef,
+				     u32 signal_interference_bitmap, gfp_t gfp);
+
 void nl80211_send_ap_stopped(struct wireless_dev *wdev, unsigned int link_id);
 
 void cfg80211_free_coalesce(struct cfg80211_coalesce *coalesce);
-- 
2.34.1


