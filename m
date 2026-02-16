Return-Path: <linux-wireless+bounces-31877-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDWTLAuNkmkFuwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31877-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 04:20:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F106140BBA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 04:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 287403008515
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14CE7261C;
	Mon, 16 Feb 2026 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pi7p3VkF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chFXvn2Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2A2AE77
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771212039; cv=none; b=B0UWs36oZpBeMgmUay/+uXsLaG5pMrXYazxHWqUo4oiB/dPxcaz/c9SMFunMwMyFWyHCthz1Ugl6wKwVP9PWpyFAOUNdb62/t36deOD7sRvUw89XAga+nNAAM02iIZoxbztmcFkteWu7z4yViU67+PCG0DNpNKaFPmLBPB6Ds6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771212039; c=relaxed/simple;
	bh=FgKimemw8+a/9E0dhykti2jVm3smunmN6wtPTjqJuGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ry//qgxza6lOyCEqCsFl/N6cPiMv4HOz7MsWzw5YUonGUg6OdAOs0FxPgIhXLjLLtAbgM6HgxSNk8DM//mpAt6gSRKBtPnqHlIWC0Q1bisMa7U9e+BxBe0OBEc64gkQyayPjP46OEHEQ6VrGuFM078OuzHTpNmrEqTwzAyazmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pi7p3VkF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chFXvn2Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FGC9Lb1371898
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VOWESpsHeey
	7mbrCBgRzQ1xldweBZnJ1mz89i+Sd51E=; b=pi7p3VkFtvqz0ZBxILAVyHZqvAi
	ylCke04W7CFQeqWTgLDMoI1D1yexBdTHttvsW6CvtifYuIhnbZ+yOGTo1AXJndpw
	eKMH9tyfpPn+CdXwFXE9fBM08CYRCFc20Ml/ZUA4XZGuUgDQAeiJNcwDsSXethA6
	iEjf7clqUrdhAkY7xcNfWfQm9tha99JdJWqvBRTOzYxM3CZ6Qswyhge5pO467aIR
	G8tVxwWy3vEtskVf77rjtOZJXk0GNBRT68KQdDpbGW4VR99TfQLSO3PNGVMbU4h8
	9bdJ2pc72uVYRIdhZyiK+1WHV0VWT/P68xiINVQjI4djdvn5Lp75DkEZjwQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cb6buhh5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a8c273332cso162217295ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Feb 2026 19:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771212037; x=1771816837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOWESpsHeey7mbrCBgRzQ1xldweBZnJ1mz89i+Sd51E=;
        b=chFXvn2YLGe1mu59NmhbtIweOhNtB0KUS4EnhcMQwD2nMnqSSjJxFFm5ecYwvINCxR
         5sZ6qG3SyhexpS1AVZZFWwMcTJKFdHizVfAyUzrIJQotW3zpX+TXAI42FIVQ0l2tMymm
         KRBJk6vRTTDuUZm9wos/cqb1yvZUtS3VAEnZIDXYP2yLXlhW1z55HYC2Ba/smv0X80ka
         MpvGtoubRDtQ9l1oq6YQZe5GP0qkALJnYBqPopPpE1ZEAkIXEttokWsQ00GdObBGjU/T
         P9TuZ1211kiXQFnvVSnZ8eMe+uEDTCv3t8K63CSghqT6N6879E5IiYCRD7Alftq5zYHM
         ONCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771212037; x=1771816837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOWESpsHeey7mbrCBgRzQ1xldweBZnJ1mz89i+Sd51E=;
        b=FgYEBwteg578ueULeWEgM6vHtDqqFTP2tPIHnaQm7H/lmrRVMaAg0fEekyvJn/02DY
         AYdf+bxEdlmMznPBbyy1JnM+up8wlQnBhxacXVkO30ZJndaFvQYiJNqnBhYC5Jmt2diQ
         XkXMAHRF+tKEeoy2VVBnX8YFAYkEHnuOygQlX+bblFFe8lRX//rpqr3vLwOrTQZ2h5/V
         dil7yVnTbdbWB1PkSQg7JBxsiWL4+iBbn3bei/2L702LLPGI/k1xBvvlANRgswdX1+AN
         U7JmtCQWUn6BxebT5BLtNttVdebYx62QIjHRdyI+CHm376S1XwYz1lrk79cg0BDJ0KAi
         e7XQ==
X-Gm-Message-State: AOJu0YyF2m42wjV2seJsN13/c31rnDgCowa3edVckEUeh1aVHwxnHsg6
	KqIL4HZs/w+5BU3GpdRFVI+YtyLoQ7s8YoM8S2hnxOxqFMHJ4NdXSpufkaDEiPNmhrTk83Wc8ZE
	m2L7a4loOv/3gRdB+K+fdbUZaO3EqN9v7kLBo/T0LRNEGBXy3ENQQhPxEXGNWfWflRvMIqQ==
X-Gm-Gg: AZuq6aJBCxoYIQ5/5ct2J4CmOvoP3jHTh/rdCGOXa5CGR2G7aksbJ8xcQCGPbpExbdu
	skiH1gbPjbxD3Xd0WgKaVk9dlnDMSrbGVRJECH36teB2YHCqemCyYRm0zCAy78RK7gBfNad7mTp
	WK7ALK2cHf/tpbFrgUthKg6p+MI8DBW3wOf0tkAeLMlNKiZNuvJUTXW8aBoEJHvRqVsuCS7IYXl
	s7FQlNK5+7hJTSKLQ+b0tmF2p4uhddEsqAvKAuDf2OGE5SgmCf/SRzZnMTXyMKdSVbsZHs2ryf9
	2SF7qfLaVKdLZsTOGsvvMGN+VZECQKJVIY7uLxKJAStp+y3sqORxucCSL1DyZtIqKb/xQlu5+dp
	9bdc9LaEKmLu2txC+1eWDklme7rquOamlydBc/wsXscTiRZccbUKpqnMgaZXrNu17JWoDDn7c4E
	S1U58Qnq+Fs819hiY7wb36Iw6nxUsOIkyZVu8=
X-Received: by 2002:a17:903:1248:b0:2aa:dee9:1ad3 with SMTP id d9443c01a7336-2ad174337aemr75249195ad.11.1771212036650;
        Sun, 15 Feb 2026 19:20:36 -0800 (PST)
X-Received: by 2002:a17:903:1248:b0:2aa:dee9:1ad3 with SMTP id d9443c01a7336-2ad174337aemr75249035ad.11.1771212036136;
        Sun, 15 Feb 2026 19:20:36 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5e1asm54637485ad.92.2026.02.15.19.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 19:20:35 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH wireless-next v5 1/2] wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver
Date: Mon, 16 Feb 2026 08:50:26 +0530
Message-Id: <20260216032027.2310956-2-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216032027.2310956-1-amith.a@oss.qualcomm.com>
References: <20260216032027.2310956-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DvsAuD_-dZUxweTYLnF4gAk2oYjrOOuW
X-Proofpoint-ORIG-GUID: DvsAuD_-dZUxweTYLnF4gAk2oYjrOOuW
X-Authority-Analysis: v=2.4 cv=M8dA6iws c=1 sm=1 tr=0 ts=69928d05 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=doUQZJtgAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zeEa-8Huppf60NMm8tgA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDAyNSBTYWx0ZWRfX58J2rCHYuM7T
 OqFJwCMXZe0JdwkD5XKvG4veGBaS4JDZy9H0HiQLldWAubyW3LCZ8zDRe+cNCs8YjoHxhxuROB0
 mu4gpCmOE8wSpeGCn92yRNXChP1fGCf5CdoWklqkbhY4imB8dq6g9CYxAReAxwcwQu+djaIwTET
 BUDeYod0uD1e50ZlrLpNbEDyJkWnxPjamT0UFtN+KgGQi9YG2yLrFkI2AB+ataIJifQ40lHDVEu
 +rh+bLbvV1o3rJw/0F68DxNqcbw11ROCXmnwoQuiiHzm3FfluTI15cZ27qJCe9IB+NV/QnQsg5c
 nRR91P9kHBO576wHsVyoBwMax9dbHM2Ifqt+wUKeNatRIm34TKxxvwp6ZWZUmZg6yCrKJ2hH+fU
 nkMgPyuvlwIhJPOXAwVA53mhq2S56VDyS70k07sEk6ugXkuGG/0ajRYwUZRDiCNPoy9cjvV8Wmh
 v3egdUURBMIOJL63Giw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_01,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160025
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31877-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,fcc.gov:url];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F106140BBA
X-Rspamd-Action: no action

From: Hari Chandrakanthan <quic_haric@quicinc.com>

When any incumbent signal is detected by an AP/mesh interface operating
in 6 GHz band, FCC mandates the AP/mesh to vacate the channels affected
by it [1].

Add a new API cfg80211_incumbent_signal_notify() that can be used
by mac80211 or drivers to notify the higher layers about the signal
interference event with the interference bitmap in which each bit
denotes the affected 20 MHz in the operating channel.

Add support for the new nl80211 event and nl80211 attribute as well to
notify userspace on the details about the interference event. Userspace is
expected to process it and take further action - vacate the channel, or
reduce the bandwidth.

[1] - https://apps.fcc.gov/kdb/GetAttachment.html?id=nXQiRC%2B4mfiA54Zha%2BrW4Q%3D%3D&desc=987594%20D02%20U-NII%206%20GHz%20EMC%20Measurement%20v03&tracking_number=277034

Signed-off-by: Hari Chandrakanthan <quic_haric@quicinc.com>
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 23 +++++++++++++++++++++
 include/uapi/linux/nl80211.h | 19 +++++++++++++++++
 net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 19 +++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc01de19c798..2311d852e19e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10472,4 +10472,27 @@ cfg80211_s1g_get_primary_sibling(struct wiphy *wiphy,
 	return ieee80211_get_channel_khz(wiphy, sibling_1mhz_khz);
 }
 
+
+/**
+ * cfg80211_incumbent_signal_notify - Notify userspace of incumbent signal detection
+ * @wiphy: the wiphy to use
+ * @chandef: channel definition in which the interference was detected
+ * @signal_interference_bitmap: bitmap indicating interference across 20 MHz segments
+ * @gfp: allocation context for message creation and multicast; pass GFP_ATOMIC
+ *	if called from atomic context (e.g. firmware event handler), otherwise
+ *	GFP_KERNEL
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
+				      const struct cfg80211_chan_def *chandef,
+				      u32 signal_interference_bitmap,
+				      gfp_t gfp);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b63f71850906..b53e2d78c7bb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1361,6 +1361,12 @@
  *	user space that the NAN new cluster has been joined. The cluster ID is
  *	indicated by %NL80211_ATTR_MAC.
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
@@ -1624,6 +1630,8 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
 	NL80211_CMD_NAN_CLUSTER_JOINED,
 
+	NL80211_CMD_INCUMBENT_SIGNAL_DETECT,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2984,6 +2992,15 @@ enum nl80211_commands {
  *	this feature during association. This is a flag attribute.
  *	Currently only supported in mac80211 drivers.
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
@@ -3557,6 +3574,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_UHR_CAPABILITY,
 	NL80211_ATTR_DISABLE_UHR,
 
+	NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6e58b238a1f8..6de846ae087f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21129,6 +21129,46 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
+void cfg80211_incumbent_signal_notify(struct wiphy *wiphy,
+				      const struct cfg80211_chan_def *chandef,
+				      u32 signal_interference_bitmap,
+				      gfp_t gfp)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct sk_buff *msg;
+	void *hdr;
+
+	trace_cfg80211_incumbent_signal_notify(wiphy, chandef, signal_interference_bitmap);
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
+EXPORT_SYMBOL(cfg80211_incumbent_signal_notify);
+
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 643ccf4f0227..352a57d8b968 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4225,6 +4225,25 @@ TRACE_EVENT(cfg80211_nan_cluster_joined,
 		  WDEV_PR_ARG, __entry->cluster_id,
 		  __entry->new_cluster ? " [new]" : "")
 );
+
+TRACE_EVENT(cfg80211_incumbent_signal_notify,
+	TP_PROTO(struct wiphy *wiphy,
+		 const struct cfg80211_chan_def *chandef,
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
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


