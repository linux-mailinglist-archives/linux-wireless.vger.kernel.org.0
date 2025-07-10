Return-Path: <linux-wireless+bounces-25146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A16BAFF664
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 03:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0227AF6ED
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 01:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3300EA95C;
	Thu, 10 Jul 2025 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EvwgnK17"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731302236F4
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752110358; cv=none; b=UXKvG+leSR+I62nPWnyAEFPmvxdR9eORPKEGNOxE5QoHoh+7MREJD2JF0RbiudV3ebN4FLVT8+5uMsIp0+t04E4lr72DzpkueorYured7Xa6TZ38QEzqcYYhsRxxtrqQrhj4KR11qtDmPRhw/IJB3bFCgC0eU82lZ9snZYElo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752110358; c=relaxed/simple;
	bh=GI/LyULSegnDban8KIjo+S2twFOmIcsf4N6+hc32+Ts=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YVMvyKxlPGIK7odmeX80A+6+0hjP43tQGl6vw3/6XQgMOHgnKahJvHfo/Vmaqf7gGF4yk/9WLNbxFRBDJ1v26e7HySK4sfK0UVxGxo4zJffwOxc74aR42ySkGFP0rFxaZmGgPp/XyscxIxUUJGHOHBnA09TjhFSpLdL/D3QWEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EvwgnK17; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A0uDHv014483
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 01:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=/jDXYe4jNUNS
	VfeCbq0YdJ/kt/3BAyjDi7f8EfK0Ccs=; b=EvwgnK17vOq8xd6BPFE0kJD+/ej9
	vIA4UwjgKY+tfvBxF6bhHubhe2le4tvhG/nOyNpKN0mB1elyP1Y0WQqbAUAqZy06
	6Sm6za6BKF+y+Xrwy3Qi3o0/gy/2o/7XjVONDbcyPhxmpTJUPKcvrlV2TNLH+jpK
	oMrGqomybWXGMFPayiNSJlKz4QD4IBPpcxBLhPfpKQ41lgEscFghQS590r4GgSib
	JlA9/H2sYj2G9wFQu+DbSUCp5apQ7799cc+Chv+U/1xuOkSZE/ED1CEX2irHd3DY
	zyjYWjGvbzDSTuYkZXdXRuSZ44OI8A0b5DRQducMc7uCVlrVMob15YsiHg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b13uw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 01:19:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74ad608d60aso329349b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 18:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752110354; x=1752715154;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jDXYe4jNUNSVfeCbq0YdJ/kt/3BAyjDi7f8EfK0Ccs=;
        b=m0zPVn32WjJm5+Pn3dOo/lGXP4R9A/C0xnPsiiiUcZQsFwWavqvqhGwas4IhmVlc0p
         kIGTH2hyd6ChQ+R9aOflclAcASCEaYSSEB2zRscxh06J6ATv40tGcx4nUe9BKsssq1oB
         M+4HauBHfG+gHnuYYC/3ulTnWR/X4YYG1RoMWgOORJs7Iz1oa+Zn9pZJo6nShE4koXJe
         27U9XhqnHEEfvWZXG8VMWxZSyw0cxZ1x5/M8BfRQ27GlGlnfRzhiY+2ynsmGcXb11nka
         J4nGRbwThDBkGRovdKyn4RqbaA2HJc5O+DMiRQwpv3tmDBQzbcYwnO0Rq4VJyReIMcSV
         edBg==
X-Gm-Message-State: AOJu0YxG+Fu4lsB52O8ABLb0WQANmM5i7W+09DMKc6uCCktlCVkrz64G
	3hxqaU0nxax4kGSBjad4qxC/0osY/n6ZDA4CZmAD7UV8Cg+JkQqumUiVDOsOeL0LxQZmOHQ/J4r
	+La/KX6NJBW/vJzguhcx8ieb0h9y+ObyPIu4DiaFoqhXn0VjJL758MFYaIjzCtUh7PTMZoG2iAU
	dpZA==
X-Gm-Gg: ASbGncsWqYFv4knpcqJowE1o4FffKVamRWVD5Ho9Oj0SXit0jDyKRHAf6dcA/PrtfsZ
	kGPYcfu/56KNYkszm+EwDrhKzj1W/IPDVkTXR5j8tx2sefRaPxgcXJX50onzBfY0nz7cI+NdQxS
	Ry6S65flIqFWBCCXNfUD4/1jQJhndYoHIuAbMgP1fK5duNJ/Qp9/Ef5vmwxA33JzSHaB3KX0vMq
	mOs1dlWX1Z6qEcsOftKwr24dR8e2QipT30LQ0/QHpQ+kopBT3xy++DCAHyJhZZFagUjJf+9UlZR
	FD/Fyn7iYcTrF+PMCqFrrDLSgXnR1WTKP9KM7GxGgL23/2mdOC95n8kCFcUxf04daPiUmOhtfNE
	Bphas0A5VkvsHjlaKBFg7fu4UX+BEEQYd26Q81CK56P3KTdcUkU2kh5jV
X-Received: by 2002:a05:6a00:6d56:20b0:748:ed51:1300 with SMTP id d2e1a72fcca58-74eb5453bdbmr1515536b3a.9.1752110354290;
        Wed, 09 Jul 2025 18:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEuYYjd8vj33kOZ8Ud/o/aPFfBOH5+ENwfi6X5/1d4bydiZcoA3aNmQbv0/jWJV9AdXdprOw==
X-Received: by 2002:a05:6a00:6d56:20b0:748:ed51:1300 with SMTP id d2e1a72fcca58-74eb5453bdbmr1515517b3a.9.1752110353823;
        Wed, 09 Jul 2025 18:19:13 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4caa9sm359580b3a.111.2025.07.09.18.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 18:19:13 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, tanguy@squaremind.io,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Fix packets received in WBM error ring with REO LUT enabled
Date: Thu, 10 Jul 2025 06:47:54 +0530
Message-Id: <20250710011754.559817-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686f1513 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6JxCxXzoczi57qTM8cEA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDAwOSBTYWx0ZWRfX9AiO26GdmCp3
 VtRqRez3JWwLqnRULTPpr/+S1ASMLW0mIs06QTxFwjqSbjWZYPP8+26zHyAgMIT2kNYewbOQ72+
 RRXSE9d4B0l3XDqlITbiBeqVPyx7OYUI2tSiKEj4Koddsrl8IJx/dVKkW27gd+45Da4x9lsBGya
 PJwwauhP3/I4ZnmUatcdhqAqD9JFbm7ij7czeVZlIGnK+ExypAqoh9j5vihDh6EVqqtaVx4l55M
 EzAT6Cdf1x13gc33dA8xqlBZZ52IPUrIqRvz6v7sf0Q3Y4eoM9jxm+esFJZkLMzkAdwpo175R0d
 mhsp1fEp4ZaZj5pCJlV5Tvc2nnlBMx+NfN6XKci0iJ09IO8ExJK2zf0A9UkDm+pfDM9unqevAWF
 vENleT+0Q0WhLt+2VD+Bb07qjou921yF3Z5sHdRp64CQvS+T5w1M7I8Eju3MdHGckxVJ/xfJ
X-Proofpoint-GUID: gDtSNhrb-4pwcHaSwyQKH30vyD7GUcDG
X-Proofpoint-ORIG-GUID: gDtSNhrb-4pwcHaSwyQKH30vyD7GUcDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100009
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, packets are being received into the WBM error ring when
REO queue lookup is enabled, resulting in degraded RX performance.
The issue arises because the REO queue LUT TID memory reference is
set to zero-it's being assigned before the memory is allocated.
Fix this by assigning the REO queue TID memory reference in the LUT
immediately after memory allocation to ensure correct packet
processing.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Reported-by: Tanguy Serrat <tanguy@squaremind.io>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220282
Fixes: 3b9cbce6fdd3 ("wifi: ath12k: alloc REO queue per station")
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index ed325aa6322d..65b4c91e4fe5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1060,7 +1060,6 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 	}
 
 	rx_tid = &peer->rx_tid[tid];
-	paddr_aligned = rx_tid->qbuf.paddr_aligned;
 	/* Update the tid queue if it is already setup */
 	if (rx_tid->active) {
 		ret = ath12k_peer_rx_tid_reo_update(ar, peer, rx_tid,
@@ -1072,6 +1071,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		}
 
 		if (!ab->hw_params->reoq_lut_support) {
+			paddr_aligned = rx_tid->qbuf.paddr_aligned;
 			ret = ath12k_wmi_peer_rx_reorder_queue_setup(ar, vdev_id,
 								     peer_mac,
 								     paddr_aligned, tid,
@@ -1098,6 +1098,7 @@ int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_
 		return ret;
 	}
 
+	paddr_aligned = rx_tid->qbuf.paddr_aligned;
 	if (ab->hw_params->reoq_lut_support) {
 		/* Update the REO queue LUT at the corresponding peer id
 		 * and tid with qaddr.

base-commit: 45bbd91fc41b7cb6319e45e6fd732c5c8a0c44e3
-- 
2.17.1


