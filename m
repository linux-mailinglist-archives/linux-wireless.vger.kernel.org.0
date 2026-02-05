Return-Path: <linux-wireless+bounces-31588-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F5IOGB9hGl/3AMAu9opvQ
	(envelope-from <linux-wireless+bounces-31588-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:22:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4192EF1CE1
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 12:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B3DD300A52F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225E35581F;
	Thu,  5 Feb 2026 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WnFrfmsg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BywEZT/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B892DECBA
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290524; cv=none; b=ucwTacDMoB80om4eT2JnDcWX11m7MqsCTMiDP7+GA8NI/5zHtzLmfdVL/iueBTxa8LC2aksbzF9OkN1NWPLFJoUK7yHTSsqU8ymsLyBmHgrUdEabP8kRovKlWFv5Lxdj2K1cjNMSdfG/HzzFmXMRcPcgsh9ygKknvlPTcrcUguI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290524; c=relaxed/simple;
	bh=igohYAEVpxdLg2U91wVbOsm8bxQi6X4QG3jT1cGRkQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIBucsM+DQSM687kMkVCRlKNgfdqXhzdS/efUvOHLoTWNMhsYbv8wZdY/9aiyF8aa86qlmqOxGdUURgvgrFx9KpDWVCxgcygDTJnpNwTHEstiI9jhXwcFYviTiDCOzumiq2N1a2Yd2M1SqiK2IBZQhAZDPgBkuPfVYf3KXMZ//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WnFrfmsg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BywEZT/h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615B40I6176910
	for <linux-wireless@vger.kernel.org>; Thu, 5 Feb 2026 11:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=miuEY/23jr4
	KDJH+QmFukMtElw+kL/8MBDn5kQ4IhM8=; b=WnFrfmsg2xOgueNim6tgKimwuMW
	+gJZbCsFTtIYwK50JUuqBmQzRqEtHlTg/nkPSip3SYUQsAz0VukKS9tq3nhnvnPo
	4x35nmqAqxv52XjBgDAYFSaelv0lTrz1ZZ4ItJTrYUyWMvhZZ+2u1fnjqyr0XKik
	NbhXcCnlyT5h2VNTChE+E2/U8yPEqjOVDC6BzlzASrOmrIbXzAlnccj0w88KsIc8
	a8CMiJ/Sg4m0A2wmvAkyR/O5rJd9Sv5g3aUgw7lyOTM91thLmjO9C+WWrvoBdkj8
	m/H8HdNcqLBckgc/OL9+MCRfWCAEdfUqn1jixyyOF1yUEKo6gij37LLEi6w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4t0p01nq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 11:22:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-352ec74a925so1580970a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 03:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770290522; x=1770895322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miuEY/23jr4KDJH+QmFukMtElw+kL/8MBDn5kQ4IhM8=;
        b=BywEZT/hMSmwqdlMaKYJxjIgp6CJ0pUgQnJF+hnsK0cLgjblVf1cmDx/zmgC6FNNsu
         wM1hvk8tuVmYMPhMfpL5iu4mj9/UsTGtJkF8nxdiF2+n16aR3Pwl5YjDqneIDwTw6hV7
         roFvNGeVqldceUVi91cQhPsxmZg6o2AC80wRsQ8lzAKIfUHm+stVeGpbqpaXVgqMqjvZ
         TbFfJ6rRlacfeUJbOtIio5elusHu/K0VT98YMzBXjLZ522+iwrLYoLuaF+xKGxsubaQT
         He1zyvW5zVVeVzsCDsksvcJdnjud7BtgiKQYxAUoIhxX9ZzclCtcdq0gA4ba9QgkNsPG
         psqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290522; x=1770895322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miuEY/23jr4KDJH+QmFukMtElw+kL/8MBDn5kQ4IhM8=;
        b=p0JF8Dycr+mSzWflVaY0eTFy6P4jRrxv8OTYUN4G17jeOtXSpv2mPgWVQTBq0dEWjE
         Qb69wNYlAD0WR/Viw0o79U30vsq78OxJQdzAsbU4horHD56044IIO9e8G3nA7etzURbN
         3IO3yR3oP9Os8VwqgOY/xAqdVrCBRGB7llfqMqQ/S+gdBb6Qe3v8Tjw1xVH+N2o0VyfR
         zb9ktsbzev52FB439scdpacWwtox/Pql96h4xgazqcwdT7p54C8wp3YdOTrosLBN/vlM
         QywYIFad5STtasthLtFr4au/oqsx3+hnpQT23NcY91EBfLj2t6BI8gcfbLZlNFrqOuAO
         DiDA==
X-Gm-Message-State: AOJu0YzY6w8PxWJALwimwHO+OgZTomrEc8wB+0rsDMsgn4hIXo6CQvVn
	Gxn2MhxaXY7KxM6mzqk4ruKOV53Iasle8iyO6cXh+eP4/YrQ5VglRXBaoroT8jr6bmEZmDseeTB
	9QeGo21QPjI6E5Kf3YoaorsI+MuAJb/8oQYfDICz3N6WsSx/UsEPE3Ph7cG4cGwCfjYnmgw==
X-Gm-Gg: AZuq6aKydJVFrDAc8U6ouO3OvYRA1VoBhYIKrEBjPX39iDlIEGifLYRDgLJHrTD5Z29
	WgFtS4gHrfFM2DyoQGiiOKSEo67VVnWlLHotjAyT7+GJojc5oRKvhEWEWu4PTMueFimD7rPmSgG
	cxlRX8hKpXpjhlLRRlMQLsX6pkKk4u2YIhfufsK9B8TByHvJs4wl0XK//DYKGJF2hMEUvoe+mj2
	KlNfPBQycNNG4TZhHKgywodVgvxigqw2h9piWW9Tp/aEylW7Rpsi9yLxOjpA/hmCJ+a2UNbBp/Z
	/YleykoFTkXp+I8dF51mqp1DyiN2GfpDXX1FYUejdzxy1C73VRbp3VhXrKnK2Vb2KEnBxhGW9FM
	BPE/Yv9GztvEYNOHF6tRF+/QfjXqr7RiMgQb8gisB8iZlca9Mx9UWYUePgRdc+b8lVTKe+adq8q
	4aAznLEVCvOqUIFDQfXrmKepA=
X-Received: by 2002:a17:90b:4f87:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-354870aadc4mr5268832a91.2.1770290521891;
        Thu, 05 Feb 2026 03:22:01 -0800 (PST)
X-Received: by 2002:a17:90b:4f87:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-354870aadc4mr5268817a91.2.1770290521412;
        Thu, 05 Feb 2026 03:22:01 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d16401esm5651998b3a.4.2026.02.05.03.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:22:01 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Hari Chandrakanthan <quic_haric@quicinc.com>
Subject: [PATCH wireless-next v4 1/3] wifi: cfg80211: add support to handle incumbent signal detected event from mac80211/driver
Date: Thu,  5 Feb 2026 16:51:44 +0530
Message-Id: <20260205112146.3997044-2-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
References: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ItITsb/g c=1 sm=1 tr=0 ts=69847d5b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=doUQZJtgAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zeEa-8Huppf60NMm8tgA:9
 a=3mapU_QI-1QA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: n4tX5JKf__M28qY0qVOliApKrVXsCdvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4NCBTYWx0ZWRfX5X2+kpgItKvR
 D2UPlaDg++m1nX5wx5vBP1u089ZsatuTSaMvBiucDaxiuickkMEixuG+yEUq8iwqKh8BFRZmtkw
 GBpSiFO2nv0KtM1DF/5tDRfnNo4AwTokbsqXMlWuUFQTq+kympQN14jc6o8M9EFHrhPJz+N8980
 ovyXvwNCImEMz1JQBM8aEO9Sr4Uk2b2fOJ3HhIpIVxq96uzeZcmQNaUsY6mEyXVDxe5g2ruqT0K
 Hy/mMGi/QHWfiVYoq7lGcP0s1fYpDMu2rwr7aPacb8EJiho4aislJp2gXL8Pp+Lyc1nOQ+7aDW/
 hVNccWX+wvuQ2CbaEe8/TRPKNeAmRUednWXBSR5MgLfc2IEJF1MW6+buEr4J+XIvlnnUtpvqyvv
 8/2YT9eJ9+aTzqHEWBiJLg0espo81ZEJKNGa40TBgcEFymown795SRX+8+TjFXm1B7XIkBPwhdX
 behhjpmtvrXdyu1NkyQ==
X-Proofpoint-GUID: n4tX5JKf__M28qY0qVOliApKrVXsCdvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31588-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quicinc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,fcc.gov:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4192EF1CE1
X-Rspamd-Action: no action

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
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 23 +++++++++++++++++++++
 include/uapi/linux/nl80211.h | 19 +++++++++++++++++
 net/wireless/nl80211.c       | 40 ++++++++++++++++++++++++++++++++++++
 net/wireless/trace.h         | 19 +++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0ae0aa7594a3..91c85a896fd6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10423,4 +10423,27 @@ cfg80211_s1g_get_primary_sibling(struct wiphy *wiphy,
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
+				      struct cfg80211_chan_def *chandef,
+				      u32 signal_interference_bitmap,
+				      gfp_t gfp);
+
 #endif /* __NET_CFG80211_H */
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 54ddbd9a5459..0bda5c05b47a 100644
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
@@ -2976,6 +2984,15 @@ enum nl80211_commands {
  * @NL80211_ATTR_EPP_PEER: A flag attribute to indicate if the peer is an EPP
  *	STA. Used with %NL80211_CMD_NEW_STA and %NL80211_CMD_ADD_LINK_STA
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
@@ -3546,6 +3563,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_EPP_PEER,
 
+	NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 85e30fda4c46..2b4a84794f8e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -21045,6 +21045,46 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
+void cfg80211_incumbent_signal_notify(struct wiphy *wiphy,
+				      struct cfg80211_chan_def *chandef,
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
index 643ccf4f0227..deb283d9e017 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4225,6 +4225,25 @@ TRACE_EVENT(cfg80211_nan_cluster_joined,
 		  WDEV_PR_ARG, __entry->cluster_id,
 		  __entry->new_cluster ? " [new]" : "")
 );
+
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
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


