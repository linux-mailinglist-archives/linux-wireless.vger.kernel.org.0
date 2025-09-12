Return-Path: <linux-wireless+bounces-27253-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C15B540D1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 05:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71641BC3F5B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C91FDA61;
	Fri, 12 Sep 2025 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JknB0gQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340F136351
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647294; cv=none; b=tLF1JFj+0uLThrUcehFlaDjSO5DBF6Q4x/N5bQEgRWvMUeQeisiZPAq/cRQognbTlYukQ1hQd1PwBgE+xrlGFKvJAU3pgcXcA1rEAZGxUdKvg7jC8jHbGwYkioidgcuf+8wCjZf3NcV66ga+Q0gu3T8MFrDaGSVoNikkw+8ykwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647294; c=relaxed/simple;
	bh=/vhPSd9ieQJkvqk+Vq6Ql/61LswhY7HU9D1xPldeakQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVd5b5+RfyevAzGFXyaXhQm9ITMgLq/fZdfvm9k5aWbjf1MOC0GE0ruekK9LSPg75rUI9ftRKyU0OM0nggEBA5COGMp4BTu6vNwjcLW3stMN1ozVVfQIzt/QR/Z0Aphvb4VymTuQ093QReoQoQMNaW5I7/dD6Y9kx+5woY+lHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JknB0gQP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BItCvl016853;
	Fri, 12 Sep 2025 03:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I0+bmtLjj0MA39dIawtJm3oPn9eUSSkHCZc2e36xgkk=; b=JknB0gQP3+av9vke
	jMfR9tNN4WuZD5ZuM++wSLqC8NOl2vO12JDcHPoyj0LfKN+XNMvFZMVlyfsdhV7T
	JxmmfMxF8aeqL26mMGwZZruEcqG8TD9Kdl2+6p45Gvokpmh05rIc82nTqIO9MEBN
	axsMvEz4bzB53OlLWqDTGMYSmNrlCO2gzlByqNsD8BjaRm+U8zbAkZMFr7ja6wCj
	iVOY0VUqSzyn0qA3/zatqVQKOvMzGeVrYh2WQWdv2s83BEQJLhc04m9UKxTGggK1
	vW4Kx+EzOMBVBMYSrmif9D5t1pVGfLM+vGHCc1D7FJCCi0LIdTn4QjIs+66wCE4C
	sS9RWQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t386fmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:27 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58C3LQd0005331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:27 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 11 Sep 2025 20:21:25 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>,
        "Hari
 Chandrakanthan" <quic_haric@quicinc.com>
Subject: [PATCH wireless-next v2 1/3] wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver
Date: Fri, 12 Sep 2025 08:51:03 +0530
Message-ID: <20250912032105.714949-2-quic_amitajit@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912032105.714949-1-quic_amitajit@quicinc.com>
References: <20250912032105.714949-1-quic_amitajit@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -3BEExkS74XKmn5kxl3D9QjyBOk5JxMG
X-Proofpoint-GUID: -3BEExkS74XKmn5kxl3D9QjyBOk5JxMG
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c391b7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=doUQZJtgAAAA:8 a=COk6AnOGAAAA:8
 a=lp4xQSiNCajjZvSbqEMA:9 a=3mapU_QI-1QA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX2ebOhb7V/gF9
 v4kMklFNqc5wKykNPJdqB6xnSlhxH78u4zmlJ3WAxX7mB7R8UfBq0UpGaMtPF3taFPjF66bNCGY
 bEOncmabPA6EaTILKVwjUHUUlXrU4xc8+ff7nqZ5cTotnBJtfGfFR26OnyrFEhekFbK5Mi337CC
 7IukBuFmVrcHf2BM6iKddMLYwGg3BPCa1H6fFMJ5WrRRhEgFi6RLTFG9tqcz9QGxamN8g5Qeq0t
 e9UxMUdLGkxrdefR5hWuclcWZbBSe9M08+j9UtTIjTugWK6BQZESBSbIi20/gbnAxoMvZzEwN0y
 nFNwMhRbZ+YgNU7DEp8ORUbokclHAonG4fFDFkHaRFHR2e5D/aM1FvMdSs3vx5luRJRCX03bJ+2
 Pjso11lH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

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
 include/uapi/linux/nl80211.h | 19 +++++++++++++++++++
 net/wireless/mlme.c          | 12 ++++++++++++
 net/wireless/nl80211.c       | 35 +++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.h       |  4 ++++
 5 files changed, 87 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..b566e295a0d0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9016,6 +9016,23 @@ cfg80211_background_radar_event(struct wiphy *wiphy,
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
index 99e2aadc65f7..a2c68dff3081 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -20714,6 +20714,41 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
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


