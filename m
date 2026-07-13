Return-Path: <linux-wireless+bounces-38953-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LkU8OAeWVGqpnwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38953-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:38:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C2748412
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:38:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TSW8i1I6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=O3Szi43e;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38953-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38953-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CDED3048561
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B55390610;
	Mon, 13 Jul 2026 07:33:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A438F95E
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928022; cv=none; b=XgF9x8SjAVSAZuXVFiUjhitfVCnwFhz0ARSbC/MI0+Gveolq7IwdPLSDqVdEKXi14qjRSUnNYk/1bFywDWLfvpk6xllo07uzz/Q4UBxh0IKb1dzhNl17pTJ/QnEouZZSJf4MNHjmlCPuDaebzOm+CF3SfQ78q4nN0FxJZ8kQZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928022; c=relaxed/simple;
	bh=c/WbPPv4RkwxRzYF4uWmRJreh5iKXZqoFKs7He5VVbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iACxzhTKZ/Z2AoohJFbypV4i0aj0o2YtcQQolyf7KL/wQQ022BuvAp1rHgf9LVwK46fxXQtJtsyfPZ4r6DeAJzf0ALgEIu7iggQH/zAKLVNOJ2f4y1jhXEej3j5Uu9zVLrPl6G0UhMeGKY7x+kxC2MG+u5SdKmsOM7zaZe/YPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TSW8i1I6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O3Szi43e; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6OgqR605817
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iXbx79m4mELfQ+yxJXteo5
	YQs+iJo6r0y6/Vp4M+W0c=; b=TSW8i1I6ARfFGFi3Ft/bBA2C3HqZKa/w8xnFo+
	gtMKILCheg7Om+m1wv+ooDxCfgQNuyvw9erEowkYasPwAyKTMvoLK9Z0rRy0QOmh
	0bDyXNQHGhadH4hFPqhplI79nPIRoCKKgNMoyrxRSbezmvmR0m5H2vocEsBNoYqn
	toWylCbsge49JF2OT00l1nNv3ObVYN3OjP8rTIMN9vYxav5p2pAITNqcNrKO6LnD
	IQIRzm5mu2I47L9Mhadg+rWFQBmpt6bQ2yn0n4Cu5aRLIwAtrFVWQEdaC58xlbxs
	2YoK+/6hP+d8i+piMiNWwFWj/y9BapnyTUbPv45qIgrTLmIw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeehn0f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:33:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cce406883eso27316355ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783928019; x=1784532819; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iXbx79m4mELfQ+yxJXteo5YQs+iJo6r0y6/Vp4M+W0c=;
        b=O3Szi43eYlJtGN8sb1Boc4lJ296b+bNT8Ul5kXQApMdnHav/wFRWWFuq/BPpY0ocXL
         N/5bmTzW3dZJjSsrAVFWAjLnU23b+iL5R3HBMbjLRPMJp3NhYmMPStAo0m6CmETgt1cU
         D/OqT/LSaOjQIrZow1JbNmizZGwxRNbF7QHm6x2n+9J3iA67WBCk/AFQEk4cKlQJRKjW
         rEWI1/v4tZ4LXXtclKdX0JsxO/qSSivGe8j5M+Qk+rDoOxmp7NeMOGYEFTjrG4Tb0zrW
         AWt3ETHr2QFMewKPuJNWSpBSVj2UWijLxJQFdTfHzAcdjx8SPveq5jI4zFIbJ4pfN9b4
         8Lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783928019; x=1784532819;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iXbx79m4mELfQ+yxJXteo5YQs+iJo6r0y6/Vp4M+W0c=;
        b=Rl0+04HmXw3rCXKUBJMufZb6u2gHp6qRfsHYXuT1NyFFBh80+X21HhvPl12cEVNmha
         yVrk1URso/tVe0kSmWwMFUKlOziijzuhhPTEZObxGwWNnSjpaLLT05EEjudADw8ib/cp
         TITb9yz99C83ETatfV9ftcps3s1mY6k3QL3K1ChwC1OVFJwDsk+voNAVcS/5SPFyZ/Mp
         r6JhyqsKcwWsiCOpP8Y4bKxj8mJ7NwRrFFKz3Q/z31Ug3O+Ku/306cxBhksb38HmTar8
         7TQuXtOgPgdOkUaWNPe18TZmpSg0DJ3bnaQ9HpSfser5DcRgwnm08i1wfl6lcnYvcoBl
         EKog==
X-Gm-Message-State: AOJu0Yw7QaHLjrl7OIP4c1f5XZb+bpfZyfarfLJzXqQNzIRQ3YmSvRaa
	J6pCiAwTLlbRxIWnNeNgR2vMxTybYqaAR8n68fFWaOv1W7HSNp8398Kq6ncUZj1h2oNsbFtKS2e
	M0DQuB76b2qD3Tg2H1M5GXXirQ9YTbytMaF/7Bw3BoK9AhiO1288zJDfUG5gUqTngLOxh/9nS81
	SU1+5F
X-Gm-Gg: AfdE7cnUjW0sob8TYDv+bu1D7MEAcMK66AHoyUIGn+WsfoukO6X5z3yTVVIO1BiaxXG
	V7uCbf8z3hDB3K4zE5grAsxKa+12iKbxQc/Z0WX2WH3gyYCFg4rJeGFrlSQ99zBppdVvz7J1mma
	4jcHkcNM3ys1zpyXqseQl3am37g6XpHGhR+aYFpBSfywZG9+zq2/fJB+WPTg4Fe6uJl7JVBBmS7
	LU82NGaRPEsRH/xHUFuUrk1dw0bXoabWTDVEg99Lja6v7PlymxWQPV7Q/YP3Y129TTtQz9NkcLO
	uvGQULmBlnxQnA0ZPyhOOb1CKRgdazBcN3CHL4Vx1Av4014umX1AcK0WbSj81Ef8iVSidqsTWpl
	olYH78mGSnKnFOLX2PP25Q+hcRSQEKeXB3XRsyfXXRNTxcyQMkQxPPxnqF3HX7QB4
X-Received: by 2002:a17:902:d48f:b0:2ce:d34a:5963 with SMTP id d9443c01a7336-2ced34a5b80mr19507725ad.24.1783928018625;
        Mon, 13 Jul 2026 00:33:38 -0700 (PDT)
X-Received: by 2002:a17:902:d48f:b0:2ce:d34a:5963 with SMTP id d9443c01a7336-2ced34a5b80mr19507475ad.24.1783928017996;
        Mon, 13 Jul 2026 00:33:37 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb72fsm95073615ad.6.2026.07.13.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:33:37 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-current 0/8] wifi: ath12k: support firmware-allocated
 MLD peer ID
Date: Mon, 13 Jul 2026 15:33:15 +0800
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v1-0-d0a2a1a519eb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALuUVGoC/5XQzWrDMAwH8FcpPs/Flr+SnvYeYwfHkRezJO7sN
 Nsoefe5YdAeFsIuAiHp9wddScYUMJPT4UoSziGHOJaGPx2I6+z4hjS0pSfAQDMFhtqp4/BO/Se
 1fR+dnbClQ0/PiKmsUmik0lXNuTKeFOSc0IevNeCFlFvqLinhOJHXMuxCnmL6XsNnvq785lR7O
 TOnjBojmRBVaxHlc8z5+HGxvYvDcCxlTZjhrmpW76pQVJDG6doKDcZvqOJ/qigqSu0apxgX0Gy
 o8kHl+x+QRa21Yb5tAQq8oaoHFWBXVTfVW4ZGGga23lD1XTVc7Kr69lfmtQcOKLn4Q12W5QeJc
 bQSjgIAAA==
X-Change-ID: 20260527-ath12k-fw-allocated-ml-peer-id-2b456891157f
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfXxvSTOZm+uFzK
 1fePL1MnromROFBWatoXkvQ8DsB8H692Ga6sr9eMwpDueVTrzqWhc0YKHJGKQhK1Yorg0CgInI3
 724J4WZ3aSb7yh2xVAvpKmXACIwpZ6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NyBTYWx0ZWRfX8ffphr1eSLhL
 pao3xWjBpMWOOty2BR/5nvh2MDKs66/fcXr5A/8D1jbxjD0WHVIXBmEBNHIl7o4a2jI9Lhc/o0o
 AFo9sdJreL7L1TsFwBf3MNymKqPso7IHlsk6xsr7etteTF3wP0zYFoTbel9PpBLBF5SbrerZEoW
 vaQFb8o56jaKvSUEH4k44jhQo0hUIpanp+ZGHfT08Md1Uw1sqsTeG7sssFdnN+iM4vir2XuLfGj
 fAPq1QJ87oxBCiGB/scyh0utpR8PHt/voToCz1+Ym0P3n6/qQZ1eeQArw1IynN1yPQYxzp2U6Oh
 0j8ajpUfihjv/nsGO7P02CuXDQQ+8wx3W88EAA4QPJ63GEcHwkABwJP9C6yAVqxBm/xWf5ZmJcs
 fJE4WCrHi65h9FdC6v587D0L8k/kI9WW/rNmWJg1pX/5Pwk7W0H4flr9YVAtTQzv8ndZhyBAzCD
 zuBhbG8LxVkTV0xX78g==
X-Proofpoint-GUID: U_HWMRulVo4XJlvpGVN9H1FtKgT9Uxje
X-Proofpoint-ORIG-GUID: U_HWMRulVo4XJlvpGVN9H1FtKgT9Uxje
X-Authority-Analysis: v=2.4 cv=aPvAb79m c=1 sm=1 tr=0 ts=6a5494d3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Iq4hiD-WU0-YEpfp37cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38953-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E7C2748412

ath12k currently assumes the host allocates the MLD peer ID and passes
it down to firmware via WMI_PEER_ASSOC_CMDID. This works on QCN9274
but breaks WCN7850/QCC2072, whose firmware always picks the ID itself
and reports it back through HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP. As a
result dp_hw->dp_peers[] is never populated for MLO peers and the data
path lookup fails. On QCC2072 the firmware additionally crashes on MLO
disconnect when ATH12K_WMI_FLAG_MLO_PEER_ID_VALID was set in the peer
assoc command.

Add a host_alloc_ml_id hw_param to branch behavior, defer the
dp_peers[] publish to the HTT event for firmware-allocated chips, and
propagate the firmware-assigned ID through the existing host
bookkeeping when it arrives.

Patch summary:

1: fix for an out-of-bounds clear_bit() in
     ath12k_mac_dp_peer_cleanup().
  2: group peer assoc send-and-wait into a helper
  3: refactor, keep ATH12K_PEER_ML_ID_VALID set in ahsta->ml_peer_id
     so later patches do not have to OR or mask it at every call site;
  4: parse the HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP message;
  5: introduce hw_param host_alloc_ml_id, set true on QCN9274 family
     and false on WCN7850/QCC2072;
  6: on host_alloc_ml_id == false, leave peer_id_valid unset and send
     ml_peer_id == 0 in WMI_PEER_ASSOC_CMDID;
  7: on host_alloc_ml_id == false, mark ahsta->ml_peer_id and
     dp_peer->peer_id as ATH12K_MLO_PEER_ID_PENDING and skip the
     dp_hw->dp_peers[] publish until the firmware reports the ID;
  8: in the MLO_RX_PEER_MAP handler, propagate the firmware-assigned
     ID into dp_peer->peer_id, every dp_link_peer in
     dp_peer->link_peers[], and ahsta->ml_peer_id, all under
     dp_hw->peer_lock.

---
Baochen Qiang (8):
      wifi: ath12k: fix out-of-bounds clear_bit in ath12k_mac_dp_peer_cleanup()
      wifi: ath12k: factor out peer assoc send-and-wait into a helper
      wifi: ath12k: keep ATH12K_PEER_ML_ID_VALID set in ath12k_sta::ml_peer_id
      wifi: ath12k: add support for HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP
      wifi: ath12k: introduce host_alloc_ml_id hardware parameter
      wifi: ath12k: do not advertise MLD peer ID for firmware-allocate devices
      wifi: ath12k: defer dp_peer registration when firmware allocates MLD peer ID
      wifi: ath12k: resolve PENDING ML peer ID from MLO_PEER_MAP HTT event

 drivers/net/wireless/ath/ath12k/core.c     |   2 +
 drivers/net/wireless/ath/ath12k/core.h     |   3 +
 drivers/net/wireless/ath/ath12k/dp_htt.c   |  49 +++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h   |  12 +++
 drivers/net/wireless/ath/ath12k/dp_peer.c  |  75 +++++++++++--
 drivers/net/wireless/ath/ath12k/dp_peer.h  |   2 +
 drivers/net/wireless/ath/ath12k/hw.h       |   2 +
 drivers/net/wireless/ath/ath12k/mac.c      | 164 ++++++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/peer.c     |  31 +++++-
 drivers/net/wireless/ath/ath12k/peer.h     |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c |  12 +++
 11 files changed, 292 insertions(+), 61 deletions(-)
---
base-commit: 951dc0a744e4dc8490935316d3b76e23990bde3c
change-id: 20260527-ath12k-fw-allocated-ml-peer-id-2b456891157f

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


