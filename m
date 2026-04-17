Return-Path: <linux-wireless+bounces-34936-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM+eJr024mm13QAAu9opvQ
	(envelope-from <linux-wireless+bounces-34936-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:33:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD741BB08
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A38A30D8603
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2026 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C753C2DC78C;
	Fri, 17 Apr 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jaUpEjdX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2ZaCWbi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE673A1E66
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432719; cv=none; b=d3EO3k62dn7m0g5c8mMNYN1wqXHAUTYvXo5tVE0DVPCZVS3qUYhdMTJfRfNOJEwI8UGUF2HmTVnjWBGiX5vfD6o2s860llBbzrr73xq+mZCcWCiPT7R9093FiDk6QzMktGKcDB/cAbvct25qdvL6qvuKotP4/0X73icXkoah/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432719; c=relaxed/simple;
	bh=rYTk/lQbSiuUxjzsFpH6ECI4owAZLWCq2rlT5MY0FmY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OB1zKu1G9vHN28d3SXvET6XH732hdyf8nAAFaQp211vJnBS5E3xL8UWt0sw+Uc+Z5WG9cB0yge3DLApry+xL5pgwKnP9RAvZfEahnal7GSZPIUygc+mVPAv+gcz/gcDrygHRdQqZ4HM7eWYsY8WzKLjMBUHvvpqKiwJ8Ia/oJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jaUpEjdX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B2ZaCWbi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H82uUN1872838
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GQJl/KGQSUu
	48Pj055roOYlcIOn5NNs7UgOnD5hB8JU=; b=jaUpEjdXtAOWYmIV79prxNa3Lzp
	f1K41MTpwTNSQo4kPFLGH6dfcMP17BwGsgth9p/ihplX4l7w8hH4m+q4a7JF0/F7
	H1C2n/MKEY4woR1gdsXySesozgqV/FRuCsm8aybnI4EpsdMM8EhKMCOS5HNy/sif
	16FYYuB++kw58cwlTstiN9cxgXyciIHJaRCY0KuoPJIlB8akzOPElYNqsF+1rSvn
	R03bSi4qZCgP4QODrTEaz4W1HrdYadVQDZqzm5uh+JN3uFQK8WQ3D24tTmcbQp0Y
	vZo4hGWlluJl95vu4h+5MD1h23Wktq/fFvBeQbKyaCcBPrfkm4BO9dN9TcQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk2knc64w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 13:31:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35641c14663so876947a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2026 06:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776432715; x=1777037515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQJl/KGQSUu48Pj055roOYlcIOn5NNs7UgOnD5hB8JU=;
        b=B2ZaCWbilGH+6xBR+pcrZmi0Pj6HZsm8Af51A5cpu/zsg3tjyOqRpbeKgHZgfvfBg3
         CaAzX3Hp2ot/PG+EVzbyEKnIeQtZ4QwXDtrzhQ6vyrY88aUbWi3kzbdosxpBqipEIm+1
         OIq/69u/UyFPdwZE6+qJrzpdBYk2Ny2WlsVrBmJN/xKGFIvuRrynNCzJHWO0ry1Oj3O5
         xPwpsLz4PAuU9GGj4/aacVNBP8M1CJgVl8DCl/8uB01v1EEa4SBKsAdzMcCmqAVpEGS3
         j5ftO6Y0vQ5D1sSxeon8KKqGjN6ZOsaBOTdSrNktQpxbc4Rv/gBGVrkRSmYYdIZbOOvy
         4qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432715; x=1777037515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQJl/KGQSUu48Pj055roOYlcIOn5NNs7UgOnD5hB8JU=;
        b=TD5B/KzQipHSd1LH4WdTy67lyruhJl93rlOA953ytuba3zG3x7PY4jFha9y/Tmzygg
         cZ84eo7lXtOe8eLj7K9k+NrR1sOWQjNhnVic41FHP7D83DR9UNlQB32WmAhiRWS8N3q8
         goWeteWsV9+ObsmmKq9xRFVvR02i2OL8g8uamANSjkVxQyvLsftXRVbpoTT2EZ5LhvuO
         G1O1zoLLKkdHe7pMCiTfp5yd+ccqH6pBJ/LFk5HWZMrttDGWMwm9dwZ9OWmDZ+0k/CQ5
         PCFputl+XQxQmHxU6WHb3c1h0A2qi4Ctwd6EnhF3QJZS6VXaPejqYKyfOGmrglmbbPzb
         msMA==
X-Gm-Message-State: AOJu0Yws+tgz7RccJS3yCOvqzzxwJLctp4x2rkBQabDG3xVNpLNlDE8x
	M6yaCDLa5Gse7mKmKNyBOmGhbqiXRYWQ1bplluGgo2+igQiR/MpkzVIzl5uKbnGiI2nHiJh9Ift
	Hm6ZjFf2UUp4WrRGDhmL37jk4WMSlOFD8/Tof6IgR/CoBHyxXCUrZFOTgoBrH1elkBvMo8w==
X-Gm-Gg: AeBDiesRuveWqNDVWAB6jvIyLftfTNrzE9Hr5k+4wSFp+zcdYMPt+NqsoF7xECwPjXG
	rSCM0+VwUhTgJtpxuNGOKWqD6d3puUpPVouI1yehwEN++a3RQ6M6CYXK2oTlTEadGrjOSQZcIUc
	fGhj62OFi0Y4i+xlp1MLTl2GO9hvkCd+8etH1r6zfD2bP7PJ+c0syUoT/11QZrFdPjRfii/kX9p
	naib/i030X8UrZIFuCCpl90J3/nzV/M8p3xaOT9Zr6FSVfTzI+LqHrjMj+BQUxkMtudR/9SwKHV
	cxqysxm2AWsKvElmlVfsWYElyRJBI6MmHRbtmwyNxIbuIebMyiaRxfiIbRJd4sDNwE2L/mik6xv
	Avh+gIjDS5QmyXlGX5fMwkP5t3QI+Yc4EGdt5BSHcuIrAQzxH1Akwh4Tp
X-Received: by 2002:a17:90b:1e0b:b0:35d:a542:2dcb with SMTP id 98e67ed59e1d1-3614048a731mr2867541a91.16.1776432714975;
        Fri, 17 Apr 2026 06:31:54 -0700 (PDT)
X-Received: by 2002:a17:90b:1e0b:b0:35d:a542:2dcb with SMTP id 98e67ed59e1d1-3614048a731mr2867486a91.16.1776432714376;
        Fri, 17 Apr 2026 06:31:54 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361418c3944sm2734438a91.8.2026.04.17.06.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:31:53 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v2 1/4] wifi: nl80211: rename PROBE_CLIENT to PROBE_PEER and add STA-side probing support
Date: Fri, 17 Apr 2026 19:01:20 +0530
Message-Id: <20260417133124.3412752-2-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
References: <20260417133124.3412752-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8UAJtgN9Sdy_5wuWUK-bkmeob2AY7-lw
X-Authority-Analysis: v=2.4 cv=XNoAjwhE c=1 sm=1 tr=0 ts=69e2364c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=oK2hf64o7dNcOFFRMSMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 8UAJtgN9Sdy_5wuWUK-bkmeob2AY7-lw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEzNiBTYWx0ZWRfX3w4zIJTznzT5
 jejH63w/7Ib9NHLEH8JzzYZdZxlXZ50e6tbZh0YCOua+Rwqc4O1cHlVzydByHc/7R27GpWmHNEQ
 Ax/bX8AP9xOl+XzJ6dH8rSCNjcYZQXEEqh3mYmjN+1nLdQ1pWSLrAH3e7J76TsYWoyV9DtmIBK1
 PUAjiIx1K3NhuU2sBBomrwg1X6AW4Psfqk7Dw0N1hppXJv6SiSicy4MJPe7apAYbQAh7e1vgR5H
 1lf432JACib3zzby0o5hnAoVN+V88zznThTFmBV+Rhw0VoYKFCrCgu63DJFL7wkt2JBxBJsPxCq
 0jYe3gHNAEwH6U5CZ84H5YSxBsdWlhsWG2/kYB+hpgzfivwRg216nVquhWh6dFW9ea4yziCiAl2
 eYrgsH0unm2gBZI/EhLvVkmdssepH9g48V+ppHZJK8YHFKxRzF2NurpjZ/iV3zg5Z0VfN0K2JIG
 T0Bb7JVt1wok+BCFw4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170136
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34936-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8AD741BB08
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


