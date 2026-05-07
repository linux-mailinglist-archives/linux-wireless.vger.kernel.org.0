Return-Path: <linux-wireless+bounces-36085-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DgqCfbI/Gn1TgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36085-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D064ECC68
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2809C301BA45
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA52E1F02;
	Thu,  7 May 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQpP7Hfe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixof4+Kj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF504508FF
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174191; cv=none; b=YWO6wdf26v6qPzDVUgxVixz3RhLZ0tOqoPd7GTy99YGb3jzQ+7cuoG+C9Dz9Itfcuthbd6899gh+eJm/R1DZlQJ5pOo23WlVBA1DbnLZPtAeVCYZ4Wr8+d77cFjy2P1uEYrzth+zRIKRkaBbx0yyhvJyeiLeO8unyumGJsz3hS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174191; c=relaxed/simple;
	bh=EpqMP4x1KSf4w+RUnT3fqJnPSa1qP4zs3bQHzN0ggUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DtDVDkbMTXMaDYbvW+ueWB8MkigImgbck+Js8GOczQ9M9xnTI2/1teGb1LlywHubRknZjmlijaX0ggNJn0HSdoruFXpr7JlQQ6r/fhZlqGQb6JKc/qlnrQMO2ir84YZYHAesdroB+yuaDCu77MtHTXutTfLb3HmzBaypv3WAWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQpP7Hfe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ixof4+Kj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647FehYC3464037
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 17:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sJeFosapre/
	7AQnohml1ec6YU2LLpQKq/D0sfhMWOcs=; b=TQpP7HfeAVisPpeje2sAzlypT8o
	5W7Lwlzu6+Ues7V9bia3z9knXXB6fjomeNM0iJGrv0Exl0af7B1Fu5ZJ7lmoYobu
	mTBOCZoGX2t/8SoyVxqHphxSU+l0Bb6k91+ch5Qlp5afD8EJng6rZbPucwqFiLCr
	Zq2A3FpVVFkubLI7eOsHcExtW6fqlerxq1MPIHGIA90uFPWMFuHmoFeq34fH7CMC
	hdKjf4sfPyKvCJbmTyGEFcNpYNQDU9UmaiTlOzFaqlxXom995jOFDDY5VuIPPvyW
	xaIBB1ORQaXt4BwoEldHPWLY15blB71q02avuqen/rhdkArU0arSa8tHllA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hvn3bnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 17:16:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3651991d0bcso2237404a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778174188; x=1778778988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJeFosapre/7AQnohml1ec6YU2LLpQKq/D0sfhMWOcs=;
        b=ixof4+KjEA+/sEYU0LATfpNP2wMaUdVzx67B5mvpmuTgSO18S8olKbKfQLoLEqEMMv
         qTFi6WmLYXlqw5XN5cp0iFzm+3396ZeTx04tZvljksnCoa+ZwT3m1+joBmmRrOrxRVPo
         Heb9K3tBgdPZCsygAMYS0cOWD5wyUmZ/OpcT0yavg3A09Mmp42J+H4XnyTe/E4PRRp8B
         zmIgylqIFl2VQSn3bM2ICCXmETt1PCZogt5kRvNFoIWeDUpJhz+3JeKEt1UuAlOoqF/U
         hyLDrmSLUex+/2ID9SSuOiQ74W5cAuMdslALoGGptT14AioZmmSOPtq5qySy4UbeoaIP
         3fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174188; x=1778778988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJeFosapre/7AQnohml1ec6YU2LLpQKq/D0sfhMWOcs=;
        b=YFQrNzc1dFKr7fP0lmqFnqqubt+g3O6R8I+HT8ujDH39DAuLNtpZt7BkzNBeNEYj6P
         QJB0rcpwTwynBIJcVR/qxwg5Rl8RZTjqXlHri+aLDeoJnAlFWrr4Zvt6VtdKvFIneL3B
         PZQOKcl8uM5y0sjM/y35gV2Rcrsxb90hI7inHUng46MNDeuwTb3U3aKHaUr3qw8xIeJt
         GOiU1FsxbRlLr+O3ZvQC15PZZ9PBo8bMCTvuGsXqqUwX+pZknsVCGJxNZf/hEqfWFJ1I
         rj3d+soySzj7nYfUbdlvL0VqVFFVjbphJqfC4wEUp1Kr0uFh7jh1/0PCqfELA8yvLWrj
         WEvg==
X-Gm-Message-State: AOJu0YwXH85h+EmEweHnc0IB/7kkaLfGXjmFrtKOmrlfBHAFis022X0C
	7aVdToXVLYvGqhMXSpD3zfMHuzdTkJLYrOU7EkhhuY322GaYebpjlz9hSqJSaVDLZv4zEHWBpzX
	vUI9kklnVMotqQKiEUDYQ8/e7wUjWgqc2uyB7OG9EXm1IFCLrE5LE1sg/WUxOpZoDwXmkZQ==
X-Gm-Gg: AeBDietpdnWM2ClrXhWIF0glAKSjt8Ut8X6kaq0lV0Xf4qHTdWy80v0Keiq98wPZmMS
	wSBKf3y2t7cd18x8BSOnWx3hFO9Uo3OReyrq9UKym4kz47EyYJeVoM8NXlSgprlNUZDFs+vsrOo
	vdUYcXuIUJ5cZMvH1Vq7SsgurgBPlCLjYAurpqk7FFcoQDK7MIFLLh2QdCsgq1S3m3yw+8L4XoS
	6pDI2mwiumlpGVHyT1MzMs5xRgwPl4kKkB40FbY1au/73nqNGQFzW/FoVyLZvfjnTey5TUgDfil
	y8fCnY9pJ3xdSgdSXpWpkPPOQpxc/R2dxSBQhpk2RNVvsMk/eC/fpzjAuqjrbGIEe/lWM5UCdwb
	unizPX94jWdhP7iDWddRSeuQl4VvrtZuI8iBhTIplRbJ6qw==
X-Received: by 2002:a05:6a20:1582:b0:3a3:a6fd:7fc1 with SMTP id adf61e73a8af0-3aa5a8fc80dmr10279470637.14.1778174188368;
        Thu, 07 May 2026 10:16:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:1582:b0:3a3:a6fd:7fc1 with SMTP id adf61e73a8af0-3aa5a8fc80dmr10279428637.14.1778174187744;
        Thu, 07 May 2026 10:16:27 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640f7838sm121457a12.32.2026.05.07.10.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:16:27 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 2/4] wifi: cfg80211/nl80211: add STA-mode peer probing
Date: Thu,  7 May 2026 22:46:01 +0530
Message-Id: <20260507171603.1007812-3-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
References: <20260507171603.1007812-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3NCBTYWx0ZWRfX6UHS16tUX+E5
 owLr52x+yuR5YS8JTpicSJwMzMx623C531RkeCzZYdm7k7pGBln6lUiaznPRghk/Pc77ghHO1UB
 9L32LmBmuHp0VOCesFSBGGlKfybYhn+wDzZquPQzd6GIqu8E5z/BWk1iwW0s12e/iEcPBe0fi5x
 e8tnAGIyYx3VYw+EkSGdXxlMLIzvicJdDI4pCYsqobHKuakPUxYYRH4HFw6H1lHMB612XwH8wr/
 S64Kwjgj/4ODSavEI4jQdEv6Cv1E0dATu/WatWhtsiiG+pzWaxZYuQDASuYvgTEYYDYhMyRYqS7
 FJ79a7Dgz6d3+QFSr5+6NmrG1PXJMChF8U0ydfdeasGHbruKt5A8dbm/HUlj6M7CJo6o8HEl/3u
 tiSkT1cVWwrdRqLstYmW39iNzxKvELl7d8RDlL+WYlwmhtqAzJvj5H7PUa0OH0ZkxS8H7m/XUTp
 Bdd2AcLGviJjKYLuClA==
X-Proofpoint-ORIG-GUID: SZfEdMIasNCBb93D9NXsHzJ9X1ALP4D_
X-Proofpoint-GUID: SZfEdMIasNCBb93D9NXsHzJ9X1ALP4D_
X-Authority-Analysis: v=2.4 cv=ZZ4t8MVA c=1 sm=1 tr=0 ts=69fcc8ed cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=_MN9sPK_sje123sSk38A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070174
X-Rspamd-Queue-Id: 89D064ECC68
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36085-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qti.qualcomm.com:mid];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>

Add NL80211_EXT_FEATURE_PROBE_AP to allow drivers to advertise
support for probing the associated AP from STA/P2P-client mode.

Extend nl80211_probe_peer() to accept STA/P2P-client interfaces
when the driver advertises NL80211_EXT_FEATURE_PROBE_AP; in that
case the MAC attribute must be omitted (the peer is implied by
the association).

Update cfg80211_probe_status() to accept an optional peer address
and a link_id parameter (-1 for non-MLO), and include
NL80211_ATTR_MLO_LINK_ID in the event when link_id >= 0.
Update all callers.

Signed-off-by: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c |  2 +-
 include/net/cfg80211.h                      | 14 +++---
 include/uapi/linux/nl80211.h                | 20 +++++---
 net/mac80211/status.c                       |  2 +-
 net/wireless/nl80211.c                      | 51 +++++++++++++++------
 5 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index a85ff2a4316b..5f2bd9a31faf 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2326,7 +2326,7 @@ static void wil_probe_client_handle(struct wil6210_priv *wil,
 	 */
 	bool alive = (sta->status == wil_sta_connected);
 
-	cfg80211_probe_status(ndev, sta->addr, req->cookie, alive,
+	cfg80211_probe_status(ndev, sta->addr, req->cookie, -1, alive,
 			      0, false, GFP_KERNEL);
 }
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7f30588ff52a..9f0989f2ee12 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5076,8 +5076,8 @@ struct mgmt_frame_regs {
  * @tdls_mgmt: Transmit a TDLS management frame.
  * @tdls_oper: Perform a high-level TDLS operation (e.g. TDLS link setup).
  *
- * @probe_peer: probe an associated client, must return a cookie that it
- *	later passes to cfg80211_probe_status().
+ * @probe_peer: probe a connected peer (AP: STA MAC required; STA: no MAC),
+ *	must return a cookie that is later passed to cfg80211_probe_status().
  *
  * @set_noack_map: Set the NoAck Map for the TIDs.
  *
@@ -9838,15 +9838,17 @@ bool cfg80211_rx_unexpected_4addr_frame(struct net_device *dev, const u8 *addr,
 /**
  * cfg80211_probe_status - notify userspace about probe status
  * @dev: the device the probe was sent on
- * @addr: the address of the peer
- * @cookie: the cookie filled in @probe_client previously
+ * @peer: The peer MAC address (or MLD address for MLO) or %NULL if not
+ * applicable (e.g. for STA/P2P-client)
+ * @cookie: the cookie filled in @probe_peer previously
+ * @link_id: The link ID on which the probe was sent (or -1 for non-MLO)
  * @acked: indicates whether probe was acked or not
  * @ack_signal: signal strength (in dBm) of the ACK frame.
  * @is_valid_ack_signal: indicates the ack_signal is valid or not.
  * @gfp: allocation flags
  */
-void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
-			   u64 cookie, bool acked, s32 ack_signal,
+void cfg80211_probe_status(struct net_device *dev, const u8 *peer, u64 cookie,
+			   int link_id, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp);
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d1907dd12a80..6b8071606e6f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -922,13 +922,15 @@
  *	and wasn't already in a 4-addr VLAN. The event will be sent similarly
  *	to the %NL80211_CMD_UNEXPECTED_FRAME event, to the same listener.
  *
- * @NL80211_CMD_PROBE_PEER: Probe an associated station on an AP interface
- *	by sending a null data frame to it and reporting when the frame is
- *	acknowledged. This is used to allow timing out inactive clients. Uses
- *	%NL80211_ATTR_IFINDEX and %NL80211_ATTR_MAC. The command returns a
- *	direct reply with an %NL80211_ATTR_COOKIE that is later used to match
- *	up the event with the request. The event includes the same data and
- *	has %NL80211_ATTR_ACK set if the frame was ACKed.
+ * @NL80211_CMD_PROBE_PEER: Probe a connected peer by sending a null data
+ *	frame and reporting when the frame is acknowledged.
+ *	In AP/GO mode, %NL80211_ATTR_MAC is required to identify the client.
+ *	In STA/P2P-client mode, %NL80211_ATTR_MAC must be omitted (the AP is
+ *	implied); the driver must advertise %NL80211_EXT_FEATURE_PROBE_AP.
+ *	The command returns a direct reply with an %NL80211_ATTR_COOKIE that
+ *	is later used to match up the event with the request. The event
+ *	includes the same data and has %NL80211_ATTR_ACK set if the frame
+ *	was ACKed.
  *
  * @NL80211_CMD_REGISTER_BEACONS: Register this socket to receive beacons from
  *	other BSSes when any interfaces are in AP mode. This helps implement
@@ -7086,6 +7088,9 @@ enum nl80211_feature_flags {
  *	LTF key seed via %NL80211_KEY_LTF_SEED. The seed is used to generate
  *	secure LTF keys for secure LTF measurement sessions.
  *
+ * @NL80211_EXT_FEATURE_PROBE_AP: Driver supports probing the associated AP
+ *	in STA mode using @NL80211_CMD_PROBE_PEER.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -7167,6 +7172,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_IEEE8021X_AUTH,
 	NL80211_EXT_FEATURE_ROC_ADDR_FILTER,
 	NL80211_EXT_FEATURE_SET_KEY_LTF_SEED,
+	NL80211_EXT_FEATURE_PROBE_AP,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 8716eda8317d..1bb622d06acf 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -655,7 +655,7 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 								GFP_ATOMIC);
 			else if (ieee80211_is_any_nullfunc(hdr->frame_control))
 				cfg80211_probe_status(sdata->dev, hdr->addr1,
-						      cookie, acked,
+						      cookie, -1, acked,
 						      info->status.ack_signal,
 						      is_valid_ack_signal,
 						      GFP_ATOMIC);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5d51dc8c09a2..4fb3b2e41963 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16121,16 +16121,32 @@ static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct sk_buff *msg;
 	void *hdr;
-	const u8 *addr;
+	const u8 *addr = NULL;
 	u64 cookie;
 	int err;
 
-	if (wdev->iftype != NL80211_IFTYPE_AP &&
-	    wdev->iftype != NL80211_IFTYPE_P2P_GO)
+	/* Allow in AP, STA, and their P2P counterparts */
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		if (!info->attrs[NL80211_ATTR_MAC])
+			return -EINVAL;
+		addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_PROBE_AP))
+			return -EOPNOTSUPP;
+		if (!wdev->connected)
+			return -ENOLINK;
+		/* STA/P2P-client probes the currently associated AP/GO. */
+		if (info->attrs[NL80211_ATTR_MAC])
+			return -EINVAL;
+		break;
+	default:
 		return -EOPNOTSUPP;
-
-	if (!info->attrs[NL80211_ATTR_MAC])
-		return -EINVAL;
+	}
 
 	if (!rdev->ops->probe_peer)
 		return -EOPNOTSUPP;
@@ -16146,7 +16162,6 @@ static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 		goto free_msg;
 	}
 
-	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
 	err = rdev_probe_peer(rdev, dev, addr, &cookie);
 	if (err)
@@ -22550,8 +22565,8 @@ void cfg80211_sta_opmode_change_notify(struct net_device *dev, const u8 *mac,
 }
 EXPORT_SYMBOL(cfg80211_sta_opmode_change_notify);
 
-void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
-			   u64 cookie, bool acked, s32 ack_signal,
+void cfg80211_probe_status(struct net_device *dev, const u8 *peer, u64 cookie,
+			   int link_id, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -22559,7 +22574,7 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 	struct sk_buff *msg;
 	void *hdr;
 
-	trace_cfg80211_probe_status(dev, addr, cookie, acked);
+	trace_cfg80211_probe_status(dev, peer, cookie, acked);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 
@@ -22574,12 +22589,18 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
+	    (peer && nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, peer)) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_COOKIE, cookie,
-			      NL80211_ATTR_PAD) ||
-	    (acked && nla_put_flag(msg, NL80211_ATTR_ACK)) ||
-	    (is_valid_ack_signal && nla_put_s32(msg, NL80211_ATTR_ACK_SIGNAL,
-						ack_signal)))
+			      NL80211_ATTR_PAD))
+		goto nla_put_failure;
+
+	if (link_id >= 0 &&
+	    nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
+		goto nla_put_failure;
+
+	if ((acked && nla_put_flag(msg, NL80211_ATTR_ACK)) ||
+	    (is_valid_ack_signal &&
+	     nla_put_s32(msg, NL80211_ATTR_ACK_SIGNAL, ack_signal)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
-- 
2.34.1


