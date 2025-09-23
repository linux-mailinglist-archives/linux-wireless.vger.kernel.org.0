Return-Path: <linux-wireless+bounces-27598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B13B94CB9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55017189EBE4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE597315D32;
	Tue, 23 Sep 2025 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IUpbo0cV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B292E92BC
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612984; cv=none; b=VN7XE2CZpy6ubDyGKOV8ULaJGbL4hSOdE0BCBglCn+rvyFhqjRqKqZMCK172qffWt31N349pLco2rDCRA8oF+LUdXQ8DhTL+zEcmHXU/TueF2KYc0FoljVrMkhpzn73fednxUbOHp6DVRwVGh4iekmIMz8p4mt+vw7sSwMRiueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612984; c=relaxed/simple;
	bh=bG8/W+naING9mIRXdQM0hsfbEm5IX3i3clZFcSgVl0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpW9PxfwX817YbJWtbdFxPrhZTtI7rgUth81KlaJxvNKucHT7Y+jGMGaP8a2jwwgR8E5I6I7CW3irx8LQtP11TmuVfYMxu0KPLEEyY/+HSSUIRQ62NsWIulyixxSXB27V0uUxrvzp7KD0SUFW0hZ3XQZ/GUsuLBcwlj31pER4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IUpbo0cV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6a86P012222;
	Tue, 23 Sep 2025 07:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EpJftpVX9fpdyn3OtWXepo4XQol8cdVjxYQQrvcCPBw=; b=IUpbo0cVfWhulGau
	OZe1Jr4eeFEsKShz4ybrEho9akErxtAUFdqn0vYR0tJ6xMFCg09sknnpmGOGJrS+
	YnVu648Xp6AD7OalPlSALbClVYngx+5LHO17S9L5hF5jVmVHCrdhp/4X/WBM0hSH
	rQpRCb5n3QEJdpx2NwEA7OtriCf63y0Ak62dLNB0sluzCpstEeODnemHtT2TMxQ6
	4CgFcvMMk33vYn80qQ4g6u4CdWsh5sXyrizISMYR4LTlURW+1sKHzJXoR4/L9+/D
	lsYK4xC106CR36eWkig2XSZYSjfO2oNrsyoBMhTekrjggJUWopkb0lK49dAL27X4
	YRjkkg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjrx3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58N7aHvQ002174
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:17 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 23 Sep 2025 00:36:15 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Hari
 Chandrakanthan" <quic_haric@quicinc.com>
Subject: [PATCH wireless-next v3 1/3] wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver
Date: Tue, 23 Sep 2025 13:05:52 +0530
Message-ID: <20250923073554.3438429-2-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GaMV7EbhoInHgey7iuqD7UU__OCNBksu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX92di21eeF7HV
 +BPsDmc+9VgkzrvYzIf4vKkGB71Dke8s4dRVASMSzJyV9v+2Fc/ioU2k4QEzk6Jt6zcpMEfU8P2
 YUFAiRoFDBbjxy4FIDYKygbkv1EysSAB1tngAlBWVP5hGKJFO5Ri1LCe53akII6ddVP993muyNy
 mGDpu5HDk4asoMNCH3UpEWZO2Lq+hVkiknoJQPJsQ01587oocDh87Esw9xG6tpdUrTVYLmaXNTO
 D7/yCJWX/NRohTOIFCbYUcEXsJcZbIOsU15CEonu1Owrno3txUGGPk9eZlnBFdd3hFdyUhx6W8e
 Ba9jIjVZW+gLDDdJM0M5TAjYnj+AJsikDsch+nJY5zk0TpBFDMgpQLTUy029Lw4BKmJAtvLH/DQ
 Z3c8sK9J
X-Proofpoint-GUID: GaMV7EbhoInHgey7iuqD7UU__OCNBksu
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d24df2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=doUQZJtgAAAA:8 a=COk6AnOGAAAA:8
 a=zeEa-8Huppf60NMm8tgA:9 a=3mapU_QI-1QA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

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
 include/net/cfg80211.h       | 19 ++++++++++++++++++
 include/uapi/linux/nl80211.h | 19 ++++++++++++++++++
 net/wireless/nl80211.c       | 39 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 19 ++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..821f96353189 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10052,4 +10052,23 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
 				   void *data);
 #endif
 
+
+/**
+ * cfg80211_incumbent_signal_notify - Notify userspace of incumbent signal detection
+ * @wiphy: the wiphy to use
+ * @chandef: channel definition in which the interference was detected
+ * @signal_interference_bitmap: bitmap indicating interference across 20 MHz segments
+ *
+ * Use this function to notify userspace when an incumbent signal is detected on
+ * the operating channel in the 6 GHz band. The notification includes the
+ * current channel definition and a bitmap representing interference across
+ * the operating bandwidth. Each bit in the bitmap corresponds to a 20 MHz
+ * segment, with the lowest bit representing the lowest frequency segment.
+ * Punctured sub-channels are included in the bitmap structure but are always
+ * set to zero since interference detection is not performed on them.
+ */
+void cfg80211_incumbent_signal_notify(struct wiphy *wiphy,
+				      struct cfg80211_chan_def *chandef,
+				      u32 signal_interference_bitmap);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index aed0b4c5d5e8..5970357eae32 100644
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
@@ -2936,6 +2944,15 @@ enum nl80211_commands {
  *	indicate that it wants strict checking on the BSS parameters to be
  *	modified.
  *
+ * @NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP: u32 attribute specifying
+ *	the signal interference bitmap detected on the operating bandwidth for
+ *	%NL80211_CMD_INCUMBENT_SIGNAL_DETECT. Each bit represents a 20 MHz
+ *	segment, lowest bit corresponds to the lowest 20 MHz segment, in the
+ *	operating bandwidth where the interference is detected. Punctured
+ *	sub-channels are included in the bitmap structure; however, since
+ *	interference detection is not performed on these sub-channels, their
+ *	corresponding bits are consistently set to zero.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3499,6 +3516,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_S1G_SHORT_BEACON,
 	NL80211_ATTR_BSS_PARAM,
 
+	NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 99e2aadc65f7..1cd93292cf17 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20714,6 +20714,45 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
+void cfg80211_incumbent_signal_notify(struct wiphy *wiphy,
+				      struct cfg80211_chan_def *chandef,
+				      u32 signal_interference_bitmap)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_incumbent_signal_notify(wiphy, chandef, signal_interference_bitmap);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
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
+				NL80211_MCGRP_MLME, GFP_KERNEL);
+	return;
+
+nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL(cfg80211_incumbent_signal_notify);
+
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 9b6074155d59..eaf1a489e9c4 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4166,6 +4166,25 @@ TRACE_EVENT(cfg80211_epcs_changed,
 		  WDEV_PR_ARG, __entry->enabled)
 );
 
+TRACE_EVENT(cfg80211_incumbent_signal_notify,
+	TP_PROTO(struct wiphy *wiphy,
+		 struct cfg80211_chan_def *chandef,
+		 u32 signal_interference_bitmap),
+	TP_ARGS(wiphy, chandef, signal_interference_bitmap),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		CHAN_DEF_ENTRY
+		__field(u32, signal_interference_bitmap)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		CHAN_DEF_ASSIGN(chandef);
+		__entry->signal_interference_bitmap = signal_interference_bitmap;
+	),
+	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT ", signal_interference_bitmap=0x%x",
+		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG, __entry->signal_interference_bitmap)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


