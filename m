Return-Path: <linux-wireless+bounces-37495-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GoOsOb6IJmo8YQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37495-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:17:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D165482D
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 11:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Ny5ASK4g;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="cAJ6Ol/j";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37495-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37495-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76FC2300809D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6903B42C2;
	Mon,  8 Jun 2026 09:07:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600E3AFD00
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 09:07:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909677; cv=none; b=qbr9q14ucL5gjOmooaR+reMrZltc0bLwI21H/7W5O6nqqS4LHqHM2ckkqXMnhRM9QCxbCPpGkry3dyeyWYO+XUYcp+EncWPW0XpCsLQ9NXjxIEP5oYlsjYudtRfpFS1kAmyhzqp2WaMEAdiAztJ3+JCeYIGOUEkmxHeeLcUte4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909677; c=relaxed/simple;
	bh=8sWn88ooa4mIn48nIW7ZJ/OD177FZVHcKGsnA54AgHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJ6dWyj27WZ0Unx0Pjh8kSxY8F8dt7BfKRlBwuh+kUsQMdvECHFGIuenuEoNGXdLdCglim4/LlnG41OanUzN/cTvtdc+aM8aDHSnpJlgMrZYx5M6rPZT/2+JpoGKLMP6jMAPIcGQ+tgGTiAvWvpi3Z0OV4L0xK0q5rdVwV7OzS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ny5ASK4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cAJ6Ol/j; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PjIX2733091
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 09:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7KSt64Vpr8b
	K+SbQ/+sMLzQuQ+fakcoobSjNbXU5bmk=; b=Ny5ASK4g69ZaCRIrHkgZ60UdSXA
	0bKW7ARiic9BtxePFj2d0f4TL7jDr6VmgX8IJKc0dX74VfE4d1feQjFyadQ4U+1W
	FDLKE7vLPtJabfsvKJurJaZj7ytvW+/g6irnzbzQb5wFIvZ6XSb4M0b7Vm/MVO/m
	x1ENPuGlZPbypGEurpm2kNsOU6Rrvfz3hJr34kizZgBoeoJYVR5AbLV4NLQXXALI
	kN1G5hZ2lBCsyAq320rq7ymCLSxcrAgn2Rkl2JSZE0q+zrMqbx54l5HGq37IsHPJ
	gcK0FX9YQKPuX6LnVYGviVT/sXMiLDLPRImKWF8eZ/49S8Dj63vcKNtTRAw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf73u1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 09:07:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84235f9b91fso3025215b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780909672; x=1781514472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KSt64Vpr8bK+SbQ/+sMLzQuQ+fakcoobSjNbXU5bmk=;
        b=cAJ6Ol/jVYX6+C9jRzWFqqVdZsOTC/aC6L7J8CHIRiNsuowJqeg3x0Gyzbnkn9plr/
         FdkWmF94c7zudtZTA7u8d3lovJrZ+tkhytPFfwaXarxs0UA4lKkxBgGnv4dYndUdSOLu
         YUDTxIf4mQJUcYbIO1Kjsh8MvUJF0VBwBStBJcHahUIot7dTsqPpfHNgvMEe+w/fWqXL
         4xJifKtZAdo/ndDsSltFzbJ2rlEhwVRYP6bgHg/b+FGZf+Jmmlu5iBsqQ/3iZmzEZJDY
         p/hsoBRtk7o4J22rbenTvmj/TG16LwX5Lx7+Q+4SQHj/OD6U2vD+9yPIA7QCqyrUfHR9
         cBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780909672; x=1781514472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KSt64Vpr8bK+SbQ/+sMLzQuQ+fakcoobSjNbXU5bmk=;
        b=NzVr6XpeAQSNDGY/Hfmc5UzO93pHWaVs4euwyL0zr5tBrxqxV/pcUNZ4kPeXIWgj4h
         DQovjKu5fDQuo5O5FNGqbR1ug0InAfl2WCQtsOZoEc5nB+04yRihHEPwlC7+gfO+vPOB
         7AWQ0a7o9QmMJ60QYtcjemhPgflZd3OujynIQVUhrPg0Do056omRjUhQpeceLnrmx7mZ
         AXUYc68TybRILTmONgvdttloMWOyLltF/e2V8O0dzifCzo+EpC8ROrYRgL+9GTUzR716
         hucC/0jfhMoZDOkHPx3ZimtXy2dwMa7arbVuFDvHTHCSEdjGIH35nABLTOdBYUI42HZN
         hmLA==
X-Gm-Message-State: AOJu0YyNw8TGL1NajnI+vuffb33rgeCgTkTZysZomD44japXJSKRyzHS
	wQtpm9XxS7QpuM451ekifZ+nzq34wTl/EZXzlBKweV44H6oQNQVBMv6LoSCzGw0U8xcP7eMz/6z
	EcTRjQ1fqerfCHh3KA4OIlm7R0aU5z/JuEMwqEUQZnuwJBw/lTwVwwzN2pG24PGqSjM6tww==
X-Gm-Gg: Acq92OFplSuYnX5+J+PSLux3QivCmB2IKTGf9fXFDNEVR1oA++B1maFPHzz5DvgXuaM
	hKx+joQNdOauX+MJlIBCRGSsxO/W99T9h9/of0lah6XmAbWji8/SmFSqvbPv1AWe5MoFSX3QLP0
	jqcQ2Ss7AId5cPUoQPlaqISQY9+Ts0jcWSVUwfVhvuMvwjyk/w+Fmc6IhDWFVZVXygtZgE2fKVl
	b1PUcx1piMu8pSiqFqlrc4zRkUdbgTzxOWZQjfGSaHJE/bgC6EruPfxTL+1pPczQpsLHP8CThFG
	AZeskmASMhPAhRYGcMNfEUgHeqbOmvJVe+zjIbmHu+ZyMjcbbQgMUllVPs1zUOb8NBONHPjYpMZ
	ec1gub7puN5Ca/09Sdg/iiECjcsQTarW8CEsiVHrAw2QJJ8EyzbahLhH3
X-Received: by 2002:a05:6a00:9083:b0:842:2f05:ea64 with SMTP id d2e1a72fcca58-842b0fb8c06mr14981693b3a.36.1780909672443;
        Mon, 08 Jun 2026 02:07:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:9083:b0:842:2f05:ea64 with SMTP id d2e1a72fcca58-842b0fb8c06mr14981654b3a.36.1780909671900;
        Mon, 08 Jun 2026 02:07:51 -0700 (PDT)
Received: from hu-pritiwa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282379db0sm16512603b3a.24.2026.06.08.02.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:07:51 -0700 (PDT)
From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
X-Google-Original-From: Priyansha Tiwari <pritiwa@qti.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com,
        veerendranath.jakkam@oss.qualcomm.com
Subject: [PATCH wireless-next v4 2/4] wifi: cfg80211/nl80211: add STA-mode peer probing
Date: Mon,  8 Jun 2026 14:37:25 +0530
Message-Id: <20260608090727.2389161-3-pritiwa@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
References: <20260608090727.2389161-1-pritiwa@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a268669 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=_MN9sPK_sje123sSk38A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Ogp-IUZH0baxDnPIXMTTPTN7bnz5XzFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXyUug3IqOOz2m
 fNcSiu65a4d5tgqZLoffUSwO6B0ut2nXAvP9d00MoD/EgSpI/G5H72F7tD5cwmn9sdSPsYgEK38
 N9WP6b5CnynilwGbN4Ge7czASNV5fAZFJ5RGI+5RwFMUk+gfWu5hWdKiuiozQq/f3RKhxy6BZ9J
 ZCQvAmYgdI4n/O8VPCABNn9/ArKcF/E++4gEzBd/vmoCmS2OYO4Oo7XcVAJj1DL9KB5T6xW2sQN
 Rkh7n5kgM+qki3dpIL19niuVGqxQzt7JofCWNgzU1q10JI2WDQ7jgCk4hxbjP1E8U9uoCm01qv8
 BZ97l29G86TWBAPg7Fl7MNXtpj4uNxjF32+m8pDzfGq3Z3XTxuAVbJCMXpZCsMuU2+OcKQC454k
 M490SC35GgQlhqRdeK96ntMRVcXwDCoq2EQsrVddQZTvbBuhXvR7R4amKwXPYzC/vzwLo/7gkLj
 9ILfD6JHBatxQkZ4j0w==
X-Proofpoint-GUID: Ogp-IUZH0baxDnPIXMTTPTN7bnz5XzFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37495-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:quic_drohan@quicinc.com,m:veerendranath.jakkam@oss.qualcomm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[priyansha.tiwari@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,qti.qualcomm.com:mid];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E71D165482D

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
 net/wireless/nl80211.c                      | 52 ++++++++++++++-------
 5 files changed, 59 insertions(+), 31 deletions(-)

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
index 7f30588ff52a..73cdedfdb9ad 100644
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
+ *	applicable (e.g. for STA/P2P-client)
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
index 5d51dc8c09a2..bb03ecace4a8 100644
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
@@ -16146,8 +16162,6 @@ static int nl80211_probe_peer(struct sk_buff *skb, struct genl_info *info)
 		goto free_msg;
 	}
 
-	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
-
 	err = rdev_probe_peer(rdev, dev, addr, &cookie);
 	if (err)
 		goto free_msg;
@@ -22550,8 +22564,8 @@ void cfg80211_sta_opmode_change_notify(struct net_device *dev, const u8 *mac,
 }
 EXPORT_SYMBOL(cfg80211_sta_opmode_change_notify);
 
-void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
-			   u64 cookie, bool acked, s32 ack_signal,
+void cfg80211_probe_status(struct net_device *dev, const u8 *peer, u64 cookie,
+			   int link_id, bool acked, s32 ack_signal,
 			   bool is_valid_ack_signal, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -22559,7 +22573,7 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 	struct sk_buff *msg;
 	void *hdr;
 
-	trace_cfg80211_probe_status(dev, addr, cookie, acked);
+	trace_cfg80211_probe_status(dev, peer, cookie, acked);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 
@@ -22574,12 +22588,18 @@ void cfg80211_probe_status(struct net_device *dev, const u8 *addr,
 
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


