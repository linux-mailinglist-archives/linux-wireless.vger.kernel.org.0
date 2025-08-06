Return-Path: <linux-wireless+bounces-26174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB6B1C4BB
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C04560D58
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753DC25A34D;
	Wed,  6 Aug 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AwAiApTw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ED224293B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479095; cv=none; b=Odb9vRx0qraqpeR76x/6qyJt139U8LNtoroxUgyn6BHcxhVZq1NfXSog56ypxWZUFI0HrIEw/QlscvIqLTiO6Jp97cV3nviDzjTOrbhKPR15S23fkoEfYVw1PBsI+zdDKRoDTfEhch1Lie7CxlAxNyJEXYFZTVxIFYtFS3RTMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479095; c=relaxed/simple;
	bh=7r1wrEE2I3Az4r+/xOp+lkHyb86P8130NHHfCCPawhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Zg6RQ/8iWog7SwnLbUY0bdxuP+nw2rngmsXc+1FOMB51DYmoV66u8+hofa0R4kzdQRBfNHU0lraaX5Bn+uP7se766iV3P2VaJZpqBiAhdVkR+Q3gJFwDwqPz2TstWGQwxcxeP4xPorTP0/9QYB1UgmPqjPKApuWLk5sZ0ncigLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwAiApTw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765fiKF031674
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=39PxoyaGNcy5eV+ox2Gg8nyAQOoUYs7oUQ/EkBnOdmE=; b=Aw
	AiApTwtQ9pKC9iUv+vdFMwEjas2kFe5DRnNhAPaN63oGZKA0QV3794y3PsLhh89i
	2ihixGb5LSkNFeZ3vsWEGcXnhDtSf9t6JQDMvUB8oY3m78pW5AP8hzU6ZgBB9g4E
	1OIq7cTwo0Ifi9lj62ueBH7uAJlUZGmiRMWP9TZrygzpBpFJxduT0S42TrwBA/a3
	/Mu/A4g/i9W34h84o2ErnBazWy1Rcaqjo7Q6VPwAhzYAS1SojesZAKfeIj2yfohz
	dIKvzyTb0TZbVsk6rahKWU1iCqxKfOmqWHqIybHbJMh7EdA9eIcm9WnhhbdI4u1J
	uYo6NzZPGcNxPXW1prMg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybajcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:18:12 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso9953487a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479091; x=1755083891;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39PxoyaGNcy5eV+ox2Gg8nyAQOoUYs7oUQ/EkBnOdmE=;
        b=jFH2Mj4BNOXOgDDvdd03WKF5rt2FYBgFAP5187PULCiZ6L6KZluo24uOzLQyLGwhqs
         LIDC9PqlQk2DxxOTUc3v4bpbrF4biVWAPLftevOc63qsHjn4sWqB0YSCzyaDoNF9xJB9
         nS/7v53h08AzLuaHJJ+FIknUsEnxm/nWb7NzFoy7l96phlbgoLpA16+SZhajZcYCsNzD
         2U6RJ7r3fU5egX4//oEfnYxWYHT+dbg04DN+QRN2Hb9B/I0c9WFQZUeH+eK2tp4jmYQX
         pv7c0997iL/nkJyx9RIaKBsrjSTvO8vBORro/XtVO9R7OvXfhBgXREQuyHpPYlFOp4Gt
         2qyg==
X-Gm-Message-State: AOJu0Ywm/4ngrcZsHjUpanCXW4HSL7ploubHyblNfGg30v9y/BNSoxmf
	1oTgq4klBRqEaHrCFmLChF1eiGsBwWpHCHwjgHwFkPOh/X+G8UPy9t4jedAeUPjHOKXImBpw+/B
	kyxMwT6UCJh1FgfYT68uKms3bu61slokg0OvcZZMpBFb8azHR6lQpnFQt8q7TIm71c9R14ht4ZS
	AC4w==
X-Gm-Gg: ASbGncs8wY24cfGm1zqEfI3vSsiNCMNW9tz2lVsjSc/zVKr2tz0mAowbs4sss8ifRLE
	s755wEnHf+S09kuOS+M02OtgiuJq84Dhm2JCqbVMfhhoZ6XD+JwRdalhK6Wui7x+0IkSY7jM8Pj
	+rflWmoMSW4eFTZyGT0SCmtd7S/jEeCjWvjt4DIIaAcUyo+U/oI6NEIkIxNRtOwwU8afJdd/O/F
	mdN4aF8IAE6wkIRte0pWt2azuxhn5hWo83As6Mg3Pcff/JLHQqjIU3tmQ9Ujvhjpnis630zKn0e
	rJ91Er0CrlP56YfXgyzra1C7mOGmpp+2ymR5yEP428E+JnOm9RXhe3nf0n+pZeM013PVPvSkl8L
	AHUfUfoL5+x7NJfoc3KtKS6AT8Q7HBULIcsJfHu7pmSpuZoCVbmz90seEQ37GDOcHD94FUZUjMg
	==
X-Received: by 2002:a05:6a20:7f8d:b0:23f:f9c7:f47d with SMTP id adf61e73a8af0-2403129257cmr3909728637.17.1754479090500;
        Wed, 06 Aug 2025 04:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVKfeY8aoYbQjn0GTzpcAW0M7lH3I9YFDLGxDthQ2fQBAozf4xB5iClyFOBidfEheT33uRMQ==
X-Received: by 2002:a05:6a20:7f8d:b0:23f:f9c7:f47d with SMTP id adf61e73a8af0-2403129257cmr3909670637.17.1754479089904;
        Wed, 06 Aug 2025 04:18:09 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:18:09 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 7/7] wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors
Date: Wed,  6 Aug 2025 16:47:50 +0530
Message-Id: <20250806111750.3214584-8-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX4aFybKTBE1qU
 SW3RM6DzDBiOEgBgRMhHqOv3ZYEntd9pXLQr6lKEv3eQIVNIZqwdWQ9pmiaFyBXESXHg+2kT2zM
 DypF57h2JTZGyj98QydZIMPfpMGDtd47h95VnOdNnvlv7FJd4/oTRVkeaNqFWmNMHlW7k95ziWW
 awbd3sD3DV2gTtwYNM0xP8IVh48EqruB1rtEODiN1QM5odBllVrPKfe3Pq8D51dSCmRi+CRGzpr
 YppSBSO9YMCchNxG8INe3zi+VGMsNH5qSFaZ9lInMynfsd3pBs0/5Mv86GdvhXhRoV+aj59ZN3s
 JYM1gUJF5zIcpN1q+E4bzXmkWX22HslHGmLxOV30AHdmefCoXoZjCZwqWppAg9+FHlOu2IQRDwL
 q7+6vn5m
X-Proofpoint-GUID: s0Da0O-L6vzPaOiDyTmfvubU5T_qjYLP
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=689339f4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=U3mdeq3A4Ipmt2oGaEUA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: s0Da0O-L6vzPaOiDyTmfvubU5T_qjYLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>

Currently, if the descriptor size exceeds 128 bytes, the total
descriptor is split into multiple 128-byte segments, each
requiring a separate flush cache queue command. This results in
multiple commands being issued to flush a single TID, which
negatively impacts performance. To optimize this, use the
_FLUSH_QUEUE_1K_DESC REO command to flush a 1KB descriptor in a single
operation to optimize performance.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c    | 59 +++++++++++-----------
 drivers/net/wireless/ath/ath12k/hal.h      |  1 +
 drivers/net/wireless/ath/ath12k/hal_desc.h |  1 +
 drivers/net/wireless/ath/ath12k/hal_rx.c   |  3 ++
 4 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9cdb7cb03e23..8c5238c3a5db 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -693,44 +693,33 @@ static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab,
 	return 0;
 }
 
-static void ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
-				      struct ath12k_dp_rx_tid_rxq *rx_tid)
+static int ath12k_dp_reo_cache_flush(struct ath12k_base *ab,
+				     struct ath12k_dp_rx_tid_rxq *rx_tid)
 {
 	struct ath12k_hal_reo_cmd cmd = {};
-	unsigned long tot_desc_sz, desc_sz;
 	int ret;
 
-	tot_desc_sz = rx_tid->qbuf.size;
-	desc_sz = ath12k_hal_reo_qdesc_size(0, HAL_DESC_REO_NON_QOS_TID);
-
-	while (tot_desc_sz > desc_sz) {
-		tot_desc_sz -= desc_sz;
-		cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned + tot_desc_sz);
-		cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-		ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
-					     HAL_REO_CMD_FLUSH_CACHE, &cmd,
-					     NULL);
-		if (ret)
-			ath12k_warn(ab,
-				    "failed to send HAL_REO_CMD_FLUSH_CACHE, tid %d (%d)\n",
-				    rx_tid->tid, ret);
-	}
-
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
+	/* HAL_REO_CMD_FLG_FLUSH_FWD_ALL_MPDUS - all pending MPDUs
+	 *in the bitmap will be forwarded/flushed to REO output rings
+	 */
+	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS |
+		   HAL_REO_CMD_FLG_FLUSH_FWD_ALL_MPDUS;
+
+	/* For all QoS TIDs (except NON_QOS), the driver allocates a maximum
+	 * window size of 1024. In such cases, the driver can issue a single
+	 * 1KB descriptor flush command instead of sending multiple 128-byte
+	 * flush commands for each QoS TID, improving efficiency.
+	 */
+
+	if (rx_tid->tid != HAL_DESC_REO_NON_QOS_TID)
+		cmd.flag |= HAL_REO_CMD_FLG_FLUSH_QUEUE_1K_DESC;
+
 	ret = ath12k_dp_reo_cmd_send(ab, rx_tid,
 				     HAL_REO_CMD_FLUSH_CACHE,
 				     &cmd, ath12k_dp_reo_cmd_free);
-	if (ret) {
-		ath12k_err(ab, "failed to send HAL_REO_CMD_FLUSH_CACHE cmd, tid %d (%d)\n",
-			   rx_tid->tid, ret);
-		dma_unmap_single(ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
-				 DMA_BIDIRECTIONAL);
-		kfree(rx_tid->qbuf.vaddr);
-		rx_tid->qbuf.vaddr = NULL;
-	}
+	return ret;
 }
 
 static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u16 tid)
@@ -828,9 +817,19 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 		if (dp->reo_cmd_cache_flush_count > ATH12K_DP_RX_REO_DESC_FREE_THRES ||
 		    time_after(jiffies, elem->ts +
 			       msecs_to_jiffies(ATH12K_DP_RX_REO_DESC_FREE_TIMEOUT_MS))) {
+			/* The reo_cmd_cache_flush_list is used in only two contexts,
+			 * one is in this function called from napi and the
+			 * other in ath12k_dp_free during core destroy.
+			 * If cache command sent is success, delete the element in
+			 * the cache list. ath12k_dp_rx_reo_cmd_list_cleanup
+			 * will be called during core destroy.
+			 */
+
+			if (ath12k_dp_reo_cache_flush(ab, &elem->data))
+				break;
+
 			list_del(&elem->list);
 			dp->reo_cmd_cache_flush_count--;
-			ath12k_dp_reo_cache_flush(ab, &elem->data);
 			kfree(elem);
 		}
 	}
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index c1750b5dc03c..efe00e167998 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -832,6 +832,7 @@ enum hal_rx_buf_return_buf_manager {
 #define HAL_REO_CMD_FLG_FLUSH_ALL		BIT(6)
 #define HAL_REO_CMD_FLG_UNBLK_RESOURCE		BIT(7)
 #define HAL_REO_CMD_FLG_UNBLK_CACHE		BIT(8)
+#define HAL_REO_CMD_FLG_FLUSH_QUEUE_1K_DESC	BIT(9)
 
 /* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO0_UPD_* fields */
 #define HAL_REO_CMD_UPD0_RX_QUEUE_NUM		BIT(8)
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 0173f731bfef..13ddac4a9412 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -1225,6 +1225,7 @@ struct hal_reo_flush_queue {
 #define HAL_REO_FLUSH_CACHE_INFO0_FLUSH_WO_INVALIDATE	BIT(12)
 #define HAL_REO_FLUSH_CACHE_INFO0_BLOCK_CACHE_USAGE	BIT(13)
 #define HAL_REO_FLUSH_CACHE_INFO0_FLUSH_ALL		BIT(14)
+#define HAL_REO_FLUSH_CACHE_INFO0_FLUSH_QUEUE_1K_DESC	BIT(15)
 
 struct hal_reo_flush_cache {
 	struct hal_reo_cmd_hdr cmd;
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index 48aa48c48606..669096278fdd 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -89,6 +89,9 @@ static int ath12k_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
 	if (cmd->flag & HAL_REO_CMD_FLG_FLUSH_ALL)
 		desc->info0 |= cpu_to_le32(HAL_REO_FLUSH_CACHE_INFO0_FLUSH_ALL);
 
+	if (cmd->flag & HAL_REO_CMD_FLG_FLUSH_QUEUE_1K_DESC)
+		desc->info0 |= cpu_to_le32(HAL_REO_FLUSH_CACHE_INFO0_FLUSH_QUEUE_1K_DESC);
+
 	return le32_get_bits(desc->cmd.info0, HAL_REO_CMD_HDR_INFO0_CMD_NUMBER);
 }
 
-- 
2.17.1


