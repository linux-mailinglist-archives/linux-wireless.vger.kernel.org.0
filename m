Return-Path: <linux-wireless+bounces-32280-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONGpKcJroWkOswQAu9opvQ
	(envelope-from <linux-wireless+bounces-32280-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:02:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EE1B5B5A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BCB431141C7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750D364934;
	Fri, 27 Feb 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzzvFA6n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZFgpAEYF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07236332617
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186179; cv=none; b=HBgpJ+C7ihwv+HPcr3FlApGfovBKz/FOsI/w5OqCoy5pzM5ROhlb9uU0fle4vbKGRSJ4MLn/7OzftZTmaFP56YDLEYkApBMlHcFb2WPzyD4EhpOndLytb5rY1DS5H1pDIaSyOEcjMoLvtmUuoUpKj9hSmvabczeoSucuTyCl228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186179; c=relaxed/simple;
	bh=iwTV57iCFDRxysYfTleGj2mjlC/jEk+VR4HlQ6mHtgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/+JERdwY72crmEzCPmFLUo8C24DSQLc9fxx3CtO2dMF0WRHT1iP2FfTOMpqDKZcIV8cWWRNGtRJkJxwR6b4c01aZOwQDvZ/1Rgf2vrSi4J7VQ/qEOgeZgPt/DrxxFHsuEEAJR22ZAQx+tnz/gCqzWAxyjDkNkG7q5UBC6gvtQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OzzvFA6n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZFgpAEYF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2JvtO2438568
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=yS7Bze/a8ti6qyXbRJ/3YyCXLij4Qdq3uWU
	03KmRiOE=; b=OzzvFA6nvHYDxWAXRsjrFwEz6qdp9Xiwd2DXBWp3bstx6GUP3kX
	BXiBiaZbxW22I0Qdy9AIfiuhwgiZfOztESjD4Du8ZP1mWznGzZM7qja4CkYWLWDX
	A7LuyYOockXxwIixl12JxKoclMX/5Gegvm3ojkmPQmpvC3iOI7FyCNmnCWs27BO1
	ebTwuvUh1Ew9vHn5RN67o6tfR4OnTUxJ+FLY9GvmFlG5BI0TwM9G2J213ptaDDzt
	GFGwLGkfaAUtF5sWrTXNbbe8eCd1PMivXm6etXOTJIw5W+WuAV+U8sluFRPINLQq
	5rECrUO/6Preh/b7C1xr/f1RHInakEGq3VA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cju4r2v7u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:56:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aaf2ce5d81so22030695ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772186175; x=1772790975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yS7Bze/a8ti6qyXbRJ/3YyCXLij4Qdq3uWU03KmRiOE=;
        b=ZFgpAEYFez0A32moBRjXBgLW3qYud8iz/KUUFOQL8EfwvCLKkWso5b455pUMkGNLeX
         MYvwBIQxdDAGyYlWYXJgRObHixSmZvRjvqLVhMMDEoi6IEACgEgOurFuyUDOPRqe60jW
         v0vtsZmZGv6gdcE965AiIm2jBoCYcrXOcYACt0C1pRNURTuRBh0vAWtQ6Eg6A7X2t+NR
         igXGqYo+IroDHH2apd9vnJaekRYw816jMwiKkuyopexd2waeHT5OkMDJGZgFFQzwLCto
         KOtgXJHRTGtWOkywYJlDxM9PuWEzkNYi6YaOIpf/FiGZjbzDPqOOpA2Mx8kz8+Nikfkf
         TloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186175; x=1772790975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS7Bze/a8ti6qyXbRJ/3YyCXLij4Qdq3uWU03KmRiOE=;
        b=djvauyx4FtWnokTk2deiMG4ArTJZjnBTvXbW1k5yci8QLLRXxhggl6c0Ad/hx6Erev
         tvEFbGW7nXWQsugF9CwOJ2hRQceDjW0XwKG0Ek41flFSSHjJYDFkxfihqP0T/7cuq7tL
         LmT0n0H/y5gb8z9xbPXtx5hq45caypsP6Fy3ccQ+BEbyy87GcmOyVHT0Eb4i7zRrEFFR
         C/cTKmcH7mul0jn+gAKoubLjVv1XyT1yPwnbaUXbucECc6hyIRMbw4s13rB/LtmchfIa
         cdjZ7fEPphD8/3BF/K0apfyPF52VcNGxhxFK/yFMK7dAuijWe+6kxJ3WnS/+np8cTMQM
         Co6w==
X-Gm-Message-State: AOJu0YwVJNBZX+zF37PBxkVeRuMnjHeTV16BTT7aFuxtdzeP91jKnfnJ
	OyE3r/opywXL30o46EB/pOk6mhXpzKGMULHQJExJdrXEeR4kv2729+xJ8t0YV5KKTBnR6L8+A++
	H8KkN5u4wurNLEk/Pv6nNjtMS5Pmus4e6ZyMZwZrFvSgWfDZtuOT5oxIAXk2Yyc1h4mtpLw==
X-Gm-Gg: ATEYQzykXIDTY5zRWj1IVuaf3Po0d1E6I9keVNUN1tbFxCX60kpdOkXXTUlV2U9WK/d
	Kr0mG6ZJJLRExpMEW8FdAu7ofRjTWc5Al0bFnrtqBJLHT8MC5aiizcrGpA8Bm2QVYpPEzwOe1Ft
	6UjI99dTL6cO4Er8gaiMb0JcrTNNRCFL+h1Og2XaYgP/FbfxNzxVwo9GIWC/2vW5zftFzObCueB
	SaTZGESUW364SxlMvgrQQpqnwpJmpe1FbMyD7vAKSYv2oqxfrxzizqgu7YkytizY0ER507NHLoQ
	qauPXi3mZ7mFbzX2ed9RNdckGIcWPgpGomHR6iXLnfRQd8j2D4otryky7NuvNDObtwgnKzE+Lz5
	Fm89ZoHQNZf7k0lbtOHN09SKv5FlV3AS7/Kcd3KNAMIhBKTLMZ5/eaitF2k/zKqdzwUTJjLx0Mq
	KRy0kl1W1R8p67zJ1GckT2pGRqOX68R2gmAkLE4D94kE44MQ==
X-Received: by 2002:a17:902:e547:b0:2a7:9ded:9b46 with SMTP id d9443c01a7336-2ae2e40a1e7mr20682865ad.17.1772186175202;
        Fri, 27 Feb 2026 01:56:15 -0800 (PST)
X-Received: by 2002:a17:902:e547:b0:2a7:9ded:9b46 with SMTP id d9443c01a7336-2ae2e40a1e7mr20682745ad.17.1772186174751;
        Fri, 27 Feb 2026 01:56:14 -0800 (PST)
Received: from hu-rrajkuma-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f2495sm74271645ad.85.2026.02.27.01.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 01:56:14 -0800 (PST)
From: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath11k: Pass the correct value of each TID during a stop AMPDU session
Date: Fri, 27 Feb 2026 15:26:09 +0530
Message-Id: <20260227095609.3691546-1-reshma.rajkumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NSBTYWx0ZWRfX1x9ZX6PQHj2q
 wwiihG7EDghByev+uMAl/OCOS4S6tXnc+rGtAgPk2vKXCjlTdFbXqpWuZpj5t8E4T4Ihmq87asd
 RWylzf1izLTjZg45io+pebpmHxy1/Z+CeSLkIkh5pHr2agIOtYGUj4tEXDtdqGp6NMk2/1brEWL
 HO3xpuXgOASODLc1ETIInYU8L+BXlj0QQDoemLyr3rpn1QHRrIQh7kAZ6eEjBrb5/RHvgOnrCox
 Cd6qga3guo9fpys3KMv6ifpGq/jhCnuofPF+LuiHFJQwJhPp6OVMCbfOdOnjIsXgAqNyhljF/Q9
 LUTfwJVlASEVZ7f1LUbyux5ykS/LRVKOibJQ7th2kb7gqbE1MGPMDlIxNigJLEmAguUL4snbRMO
 k8TtWiGzQHdXWM511Xm4tMnHeTdCsUzi5psI3dqcOcnQmI32G+GvU8STx78qooJl2itXJ4APP5E
 pYLhb7GxDArwzh/7LBw==
X-Proofpoint-GUID: 8SY2mTgASGsuiZAiei5JPO0y5uJ7jDlp
X-Authority-Analysis: v=2.4 cv=KZzfcAYD c=1 sm=1 tr=0 ts=69a16a41 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vkfXM0Oplov9zySb:21 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_mytDIUbvz_f-yg6au4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 8SY2mTgASGsuiZAiei5JPO0y5uJ7jDlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32280-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[reshma.rajkumar@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 073EE1B5B5A
X-Rspamd-Action: no action

During ongoing traffic, a request to stop an AMPDU session
for one TID could incorrectly affect other active sessions.
This can happen because an incorrect TID reference would be
passed when updating the BA session state, causing the wrong
session to be stopped. As a result, the affected session would
be reduced to a minimal BA size, leading to a noticeable
throughput degradation.

Fix this issue by passing the correct argument from
ath11k_dp_rx_ampdu_stop() to ath11k_peer_rx_tid_reo_update()
during a stop AMPDU session. Instead of passing peer->tx_tid, which
is the base address of the array, corresponding to TID 0; pass
the value of &peer->rx_tid[params->tid], where the different TID numbers
are accounted for.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f2895 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
---
v2:
* Added QTI yearless copyright
 drivers/net/wireless/ath/ath11k/dp_rx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index b9e976ddcbbf..00d27e0053b2 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/ieee80211.h>
@@ -1110,9 +1111,8 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta = ath11k_sta_to_arsta(params->sta);
+	struct dp_rx_tid *rx_tid;
 	int vdev_id = arsta->arvif->vdev_id;
-	dma_addr_t paddr;
-	bool active;
 	int ret;
 
 	spin_lock_bh(&ab->base_lock);
@@ -1124,15 +1124,14 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 		return -ENOENT;
 	}
 
-	paddr = peer->rx_tid[params->tid].paddr;
-	active = peer->rx_tid[params->tid].active;
+	rx_tid = &peer->rx_tid[params->tid];
 
-	if (!active) {
+	if (!rx_tid->active) {
 		spin_unlock_bh(&ab->base_lock);
 		return 0;
 	}
 
-	ret = ath11k_peer_rx_tid_reo_update(ar, peer, peer->rx_tid, 1, 0, false);
+	ret = ath11k_peer_rx_tid_reo_update(ar, peer, rx_tid, 1, 0, false);
 	spin_unlock_bh(&ab->base_lock);
 	if (ret) {
 		ath11k_warn(ab, "failed to update reo for rx tid %d: %d\n",
@@ -1141,7 +1140,7 @@ int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
 	}
 
 	ret = ath11k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id,
-						     params->sta->addr, paddr,
+						     params->sta->addr, rx_tid->paddr,
 						     params->tid, 1, 1);
 	if (ret)
 		ath11k_warn(ab, "failed to send wmi to delete rx tid %d\n",

base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.34.1


