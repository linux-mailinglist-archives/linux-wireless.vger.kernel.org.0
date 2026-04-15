Return-Path: <linux-wireless+bounces-34758-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGLoHmVf32m5SAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34758-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:50:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1248402DB2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE5E231A24BB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC233AD82;
	Wed, 15 Apr 2026 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZCb75v9Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AIGwj/vt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACB33C195
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246211; cv=none; b=eQsCP1E7uopWagnfJnH71x9FTqAaVz48x9E0VF6TfiTq+OYBAJi24C9HlDY811/vYLpR2kggtxyhoucMfyVyb+SuEQXlrUuCPua2HRT4x3Ag+yWErEaI300BGp8BeV8OHUZDoFySXDqOkaf1NIXCp56QTCxAgSdDbq56bi8E//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246211; c=relaxed/simple;
	bh=rYTk/lQbSiuUxjzsFpH6ECI4owAZLWCq2rlT5MY0FmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HACcpGVWfoGyP2xuxj6K6+5SLv6pQMTKGdsjEuDKymXEi4y9HLDbSRZpzS54wzxwQcsjCX21n+VHpX5jciLfHivM57LJ9DgBv2vvbswwuMn9rQcGSWsOCbBbUmsT6VEx1DC7o5Jw2ZTNEiG9JPx9Mcv+8ty608qdqY68Sc5eybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZCb75v9Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AIGwj/vt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F5xKO42772744
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GQJl/KGQSUu
	48Pj055roOYlcIOn5NNs7UgOnD5hB8JU=; b=ZCb75v9ZRgtsBSsK4JjLeWYkXba
	jbyan7wHjzq2Z0u9iJA/8VkoFGV7NPB6cdgbbW/JDN3JBr1QEAdxMG8eJHpozFVA
	ATxZd6X60rn84U5P7QmolXoIaGo7pZWwFdDjzamAqJbdJm4bqJ55mhlVjoPY5S3n
	wSJMdcWJvEzNeLi7JRqW8e+vWcjQ62TgTcpj3OHayq5o1Y2k8l3kJq+KEiMD70A/
	rUOojIW+DOXApfupkirZm8OYC9LQL04lp9/35r4zdNA9SwYJPq5bMqINAkvDkvRT
	S0hwQvSRofAdNwPBKlPlh3B+V7gkzzB+JziiSOARfSw2Y77mmAZYbZVbcLA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj50v0tpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:43:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso3251355a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246209; x=1776851009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQJl/KGQSUu48Pj055roOYlcIOn5NNs7UgOnD5hB8JU=;
        b=AIGwj/vt387M/mjpr4RKGotnv33nRFCuY8Sho12MGDh/i/E77seTSU1gA22PwmaA/Q
         Mt4mVHQcW9eGz+H9CroHeOvXlEKsNmsEObR59kzflit+p1DJBDcIErFBb3TFrjzMzWNQ
         wbT133Z/UklBxBaqAX/w9wOFyHgUlU+sGCcD0A4D6x84bvHETntADdkI5s8cJbkPviYq
         Md7dxskX00/7l1E1lL/RGpXuj9z2ZrIqKezTgTuK7L9CBZTMZqSo43RyKGTyHxVK+KBs
         fEUmmdK1xDLjUJzaaOn5gdvWgH4cljxGCV+Ti5tKzODVTpr6BBBNfDJaRq/QjLib3ERp
         nfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246209; x=1776851009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQJl/KGQSUu48Pj055roOYlcIOn5NNs7UgOnD5hB8JU=;
        b=OjASJX3nG1hPJzr7NN6BhOTc+r2IWrspwp2I3utARbc03loWYFjnXtrHdJmGwNq3U3
         fmI61D0E8KjphVjLBGsBnCezAfKTSy+bbJmP5BxZmwn9o404BID4Rnw+w1kW1B2i3YnF
         MtzjlsCy15AEfpBXVtUXS5qw8DQMp7NihJYyti0lqNf88Gm7nCzuZrSQAGBkz5FFOTIt
         fWAmFMTDoMZea2F9smp4uw9Hnj3u09IQju904xRVPXZJSWqm9Ps6Sp1qWQhsGRX1QSTB
         XsNyr82AtuD/8ANVWXrK9wBqQdQZ0+IliNOxcmxjNcKlrYTrwoALteJDs2W6EQpLdfY7
         dWCA==
X-Gm-Message-State: AOJu0Ywo7714n4ukBDvvdDQapEf87cDHcPFRqykZ25O6uAYSszO5vOAK
	zUy2D7CVmIl52tEz/8OtMA1Mni17+tEDMDN3o8B9J2412fmqmZZqHTQw51gIdXDxHHelZX+bWM6
	uYugd5yh9witAn2Gc3iMiB1ggoqjTYneBjPZtkUuK9XvIrpEVo6HdoKHWomTeuHMqa8RhMQ==
X-Gm-Gg: AeBDieuNOuIenhdmK1i0ngPxyBc0s/rTxMM7AbMiV00aEd9h4aLcmJkZL//tgIapbeg
	JyPeST3aVqp8NNd36SyhnxA6DSKSZP0oq4hb3eoFGrRzhBUzrL839kCikkpuiUw4c1tj/NknfgO
	xBVhMYWREZQ+m5zoK5+RQBoiIKB75kcYlvjfPAyDDxXxRnBhkngfC51sSfj62bzEmXU6OQlro0m
	uRgDUScEdMpLKlzRloyyrXGRKmKv4ZiI8MpljsXWSw304V8ULauUnXrnRVP5bza29aFm4HrZ90I
	2XpoLRrzb/YqjBUTge7E6XqZ8LUK1AIIBbaboVnwkIh7tz2sXWFBLCyEi4oqmOvkWhrCulfxYb3
	ZkKmTn1DrZRcqur653NkL7hSA7fb9++bVBCAKetEMopxM8jHWOFQRctLS
X-Received: by 2002:a17:90a:1089:b0:35f:b1ad:fdfc with SMTP id 98e67ed59e1d1-35fb1ae003fmr8753997a91.27.1776246208725;
        Wed, 15 Apr 2026 02:43:28 -0700 (PDT)
X-Received: by 2002:a17:90a:1089:b0:35f:b1ad:fdfc with SMTP id 98e67ed59e1d1-35fb1ae003fmr8753983a91.27.1776246208180;
        Wed, 15 Apr 2026 02:43:28 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd2101cf1sm2391200a91.15.2026.04.15.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:43:27 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v1 1/4] wifi: nl80211: rename PROBE_CLIENT to PROBE_PEER and add STA-side probing support
Date: Wed, 15 Apr 2026 15:13:01 +0530
Message-Id: <20260415094304.1731390-2-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
References: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0aMjsZxRR5BQzypAczxN_Mzf9sKEp1D2
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=69df5dc1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=oK2hf64o7dNcOFFRMSMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OCBTYWx0ZWRfX51mTQ1GxBbZX
 3NMNReVFpEQLU5ojJQMKGZ3nGUVNjW0vnb5hmmq3geRkLPXT5zZef2nu9dQWwKQ1yIRd6YmLwnx
 y7J1wmamK9jlnNhku4/zv2bwy88GHlNhZZdiQgQ1I/2eNffgjEAN67GtK7Sm5REX19uhtVQ3vU2
 eSxfqKAKPs6IQs2BeG/DF40AkQUA9N2NkCpJrFmuFfYj3WM1ReBJVXxYt1J3hDWBJSA9rujIHcR
 W8xoH3T53uJgklseF0f1akZoacyStJmqnez279U/bAvstkOg9ao3b8g39obiAn2dsV8aRcDhVjo
 LpHhL5MOPu49PwMP19V9FMplhodp3X3Ezuy1X3MOP32PAVlv+2ks4BrNiR7Hsnz/zbpeWo52Wkl
 Uif3abAOjMDxVQTCKZNHddzhgGJYUfgejRO3k1VxA6xyrrUkzGAwcjva0lPxFFPJWQ4nYuIrxph
 tjluWFRDqZCut8S9cdw==
X-Proofpoint-ORIG-GUID: 0aMjsZxRR5BQzypAczxN_Mzf9sKEp1D2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150088
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34758-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qti.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D1248402DB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Rename NL80211_CMD_PROBE_CLIENT to NL80211_CMD_PROBE_PEER to generalize
peer probing, AP/GO continue to probe associated STAs (legacy PROBE_CLIENT
behavior) while, when the driver advertises NL80211_EXT_FEATURE_PROBE_AP,
a STA/P2P-client may probe its currently associated AP to quickly verify link
responsiveness without waiting for traffic or long timeouts.

Userspace and cfg80211 rely on this feature flag to determine whether
STA-mode probing is supported. The command returns a cookie in the direct
reply and delivers an event that indicates ACK (and, if available,
signed-dBm ACK_SIGNAL).

For MLO connections the event carries MLO_LINK_ID identifying the link on
which the probe was ACKed. In AP/GO mode the peer MAC is required, while in
STA/P2P-client mode the MAC is omitted (AP implied).
NL80211_CMD_PROBE_CLIENT is retained as a compatibility alias.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 27 +++++++++++++++++++++------
 net/wireless/nl80211.c       |  6 +++---
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3d55bf4be36f..5c1b00bf8161 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -920,13 +920,23 @@
  *	and wasn't already in a 4-addr VLAN. The event will be sent similarly
  *	to the %NL80211_CMD_UNEXPECTED_FRAME event, to the same listener.
  *
- * @NL80211_CMD_PROBE_CLIENT: Probe an associated station on an AP interface
+ * @NL80211_CMD_PROBE_PEER: Probe an associated station on an AP interface
  *	by sending a null data frame to it and reporting when the frame is
  *	acknowledged. This is used to allow timing out inactive clients. Uses
- *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_MAC. The command returns a
- *	direct reply with an %NL80211_ATTR_COOKIE that is later used to match
- *	up the event with the request. The event includes the same data and
- *	has %NL80211_ATTR_ACK set if the frame was ACKed.
+ *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_MAC (required in AP/GO mode).
+ *	This command can also be used on a STA/P2P-client interface to probe
+ *	the currently associated AP/GO, when the driver indicates
+ *	%NL80211_EXT_FEATURE_PROBE_AP; in that case %NL80211_ATTR_MAC must
+ *	be omitted (the peer is implied by the association).
+ *
+ *	The command returns a direct reply with an %NL80211_ATTR_COOKIE
+ *	that is later used to match up the event with the request. The
+ *	event includes the same data and has %NL80211_ATTR_ACK set if the
+ *	frame was ACKed.
+ *
+ *	In case of an MLO connection, the event includes
+ *	%NL80211_ATTR_MLO_LINK_ID to indicate the link on which the null data
+ *	frame was transmitted and ACKed.
  *
  * @NL80211_CMD_REGISTER_BEACONS: Register this socket to receive beacons from
  *	other BSSes when any interfaces are in AP mode. This helps implement
@@ -1548,7 +1558,7 @@ enum nl80211_commands {
 
 	NL80211_CMD_UNEXPECTED_FRAME,
 
-	NL80211_CMD_PROBE_CLIENT,
+	NL80211_CMD_PROBE_PEER,
 
 	NL80211_CMD_REGISTER_BEACONS,
 
@@ -1716,6 +1726,7 @@ enum nl80211_commands {
 #define NL80211_CMD_GET_MESH_PARAMS NL80211_CMD_GET_MESH_CONFIG
 #define NL80211_CMD_SET_MESH_PARAMS NL80211_CMD_SET_MESH_CONFIG
 #define NL80211_MESH_SETUP_VENDOR_PATH_SEL_IE NL80211_MESH_SETUP_IE
+#define NL80211_CMD_PROBE_CLIENT NL80211_CMD_PROBE_PEER
 
 /**
  * enum nl80211_attrs - nl80211 netlink attributes
@@ -7029,6 +7040,9 @@ enum nl80211_feature_flags {
  *	(NL80211_CMD_AUTHENTICATE) in non-AP STA mode, as specified in
  *	"IEEE P802.11bi/D4.0, 12.16.5".
  *
+ * @NL80211_EXT_FEATURE_PROBE_AP: Driver supports probing the associated AP
+ *	in STA mode using @NL80211_CMD_PROBE_PEER.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -7108,6 +7122,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EPPKE,
 	NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION,
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
+	NL80211_EXT_FEATURE_PROBE_AP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..e7be43f023b6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15817,7 +15817,7 @@ static int nl80211_probe_client(struct sk_buff *skb,
 		return -ENOMEM;
 
 	hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
-			     NL80211_CMD_PROBE_CLIENT);
+			     NL80211_CMD_PROBE_PEER);
 	if (!hdr) {
 		err = -ENOBUFS;
 		goto free_msg;
@@ -19627,7 +19627,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
 	},
 	{
-		.cmd = NL80211_CMD_PROBE_CLIENT,
+		.cmd = NL80211_CMD_PROBE_PEER,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_probe_client,
 		.flags = GENL_UNS_ADMIN_PERM,
@@ -22181,7 +22181,7 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 	if (!msg)
 		return;
 
-	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_PROBE_CLIENT);
+	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_PROBE_PEER);
 	if (!hdr) {
 		nlmsg_free(msg);
 		return;
-- 
2.34.1


