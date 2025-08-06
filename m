Return-Path: <linux-wireless+bounces-26170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FAB1C4B7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30843BD7A0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849C21CA0E;
	Wed,  6 Aug 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eTwlgHt6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFB267AF6
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479086; cv=none; b=Qgh0fAN+xGsK1JeAggcr82+Wz1AsDUfnWt5VT2yzYxkq9PiS5PlQkY67ai10nFwntRme42esEGU8dWglPhOxB090817sW5vzKvbNTmtExuRVRRfjCUHiTk7yKoXtMLwKj0SU1u3Fpm7RuPPNWmHnYcXKvFqgcgDKQb4Qodl3DwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479086; c=relaxed/simple;
	bh=LfAlGQHr31ka3cc/4XZdHc5UJROcfE4FpJ/JugWWehg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pv8V3lgYql0TFBnPMt3q9nXJaudKy0uQQvPOuwwEfolUbXtK/w65iBJyRpAjmsY79SFB8VDtPLNMvHi/LoDTnTxrZR28Wh4jMKAM1aXVtBipEFilPAtx7WdFAMf6nsVCbU9D+GY7Px3hNd2FhtsNOcqLstdck6O3lkifekVlw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eTwlgHt6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5769emB5032275
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=Y05UIg546tJB5TyXI8H/T1k9acjQE3Skbb07u+v6VgY=; b=eT
	wlgHt6bIECMxkDmhK6ZXHLgq9nQx9z3cvl/OaaHUHruUelx0HF5ranX3ClHR6zlw
	Z5A/Co9HeQ4RSMkmnQn4IOB7YtI5/qDY/W21GckxcsA9N0CxK6aMoyHk3gx7H3Di
	XxhJRFLjjcXYcuyLMAALd320wPVkC2sv34fvydNLD2Fjyslul9OUAojkEELiMmUz
	BWFeRkPGj1tdKT9mpnoXNUvLISqrYD/pDvqxmSjw1jfdgh6CYT5j1TIatYqwWAxO
	T59IXSnaF3e62FS92IrT/5DZTDC2JpNqdhrF7FoZNfwRy34J8cVRTQ1BONihjlGj
	5GWST4MULzigBxMDVWew==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2tjx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:18:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38ec062983so4446945a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479082; x=1755083882;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y05UIg546tJB5TyXI8H/T1k9acjQE3Skbb07u+v6VgY=;
        b=hHXaRX0T2E8I2tQ79oSSJOuzur7PuliUuSeRW1WrjCR9Ml2eTUZcnN5YRHjb+rckFL
         8ROVvOBAeWWL7dEYlgfDVMvKyl2i3q/ajW/pL+e9LnPOhaSRVTEbi/irrot83Jm7OyeS
         V5L93lkEVIfi0XhlnjMl/0FvT2l55/Kx99rlpf0iFrkEXZ3t9+eO6PAe7ZBPFGj6dlp+
         T4AkmGqZDATcrnVJ3QAR3wHaQp7UO+uCJmYzKaC+h57yNTkgWaIL2ht7oBph4qi+kkye
         fTFcDyzw6l1WkWzHBHW6eYqHj+6K1H7/4E5O4ZKsjS7tqyDzkcZRuerrhvvK2N05ty6G
         TSLg==
X-Gm-Message-State: AOJu0YzMMViKc8L2RNl85wcBjfIQx+emsmc2AVI+wFKZzTAniV8vevUZ
	JNq/yl2kIIO0oKvA323oQi0R/zko8pu8jj85GWc28AP696371qswcuRuUJiRmGQITG6UotigIYa
	FxALsH/mHQLt2s2rFbQSSJNdnYOI9W8jQDp6DW0Pva99TIowhRprsQJPJZj2JQ8Dg6xGDGqOtp3
	cfsg==
X-Gm-Gg: ASbGncsHeAxXmqVWQArctrPjA93t3rYBJEf5fpzs3yRxkjfS96oKDDbjbR5s6FAfbs4
	XcK8hxHzTdGTpOaxvcI0WZF4xL8UbODlBTI1xsoDeaU1ZhO1xsldkOHx7yT9KPqGOCniaqnm98E
	StvTE+uND0DtPp7AnBW0m2doF6GR/5/T+IbWVWFTsRAcuJHKWAYycewG8j4N2llAES+q6SG5F2s
	ofdFs4yz9xgUKhwx3jMs0zAw8mUi6tpTkVHdfkUXahAKeU6S0VOmWbzeP880HD/saO5uwLjc8QM
	dY3MrWSnONJdPnKIezdnH2Qazn0NegVxDsac2aGIluSOz0VbzP2GDCmQDOQQzkMo6CXv4bIrZp1
	GQBlKHomEP+ayew8BOdZr0+dgBEgcqKiKtO1tYxMh8qkon/M3ALtPq/wzc4PyzrWcsdY5/Tljsg
	==
X-Received: by 2002:a05:6a20:3d06:b0:240:1f14:f6a0 with SMTP id adf61e73a8af0-240314b552amr3978256637.25.1754479082491;
        Wed, 06 Aug 2025 04:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrGy4fikHZlg8qjirjIl3JMQ759ohE9+tbqYgrSa8dpEtBtc5PXbO7CHA0IOQA6IWPkWfg6w==
X-Received: by 2002:a05:6a20:3d06:b0:240:1f14:f6a0 with SMTP id adf61e73a8af0-240314b552amr3978207637.25.1754479082008;
        Wed, 06 Aug 2025 04:18:02 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:18:01 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 3/7] wifi: ath12k: Refactor RX TID buffer cleanup into helper function
Date: Wed,  6 Aug 2025 16:47:46 +0530
Message-Id: <20250806111750.3214584-4-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=689339ec cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=f9pqRqKp9ZjM8ooqtKoA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 7YrlcQBFjNU4_txSYs_6LR-JiZCUIBhZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX+EjkTUXN0zEZ
 2pTQOFWEkCyqR4VtW05T79nOZmF/vsFFONJOt9mRL2lCfjFoClbGC0XnHgd+ygztWo1GmG5DEMX
 KQaJMwUObd3L4uWV1+OipZ76AdNIJL/jb+2bpoT4uzk9qPyWZhxRJ07y3bXy3JEG6Kar701ocRH
 FhpnrmBc8m6qRpLyu6+CD4dAJNvwN7z+9L+yfNPz5PTNqvVZ+7HISyxmXNZce7+yx/Iq3P1mGiF
 UHS0YsFES0t6e+HSdTKo6G0p/5P6WuRU+D3pig3PcN/C3VsFU68NxvEwr/UQXBItW+1AjCexlPm
 n9spEnmBEnMB4JYKaKxkBhr/wGHGhq888TtIhZxsAy9kdNdY04qjMFW6Xibq67po7zu+48+fW64
 XkHlqUMW
X-Proofpoint-GUID: 7YrlcQBFjNU4_txSYs_6LR-JiZCUIBhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Introduce ath12k_dp_rx_tid_cleanup() to handle RX TID buffer
unmapping and freeing. This replaces duplicated cleanup logic
across multiple code paths.

This improves code maintainability and avoids redundancy in
buffer cleanup operations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 34 ++++++++++++-------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 15097fe9e35e..0337355262f2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -584,6 +584,17 @@ static int ath12k_dp_rx_pdev_srng_alloc(struct ath12k *ar)
 	return 0;
 }
 
+static void ath12k_dp_rx_tid_cleanup(struct ath12k_base *ab,
+				     struct ath12k_reoq_buf *tid_qbuf)
+{
+	if (tid_qbuf->vaddr) {
+		dma_unmap_single(ab->dev, tid_qbuf->paddr_aligned,
+				 tid_qbuf->size, DMA_BIDIRECTIONAL);
+		kfree(tid_qbuf->vaddr);
+		tid_qbuf->vaddr = NULL;
+	}
+}
+
 void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
@@ -593,9 +604,7 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 	spin_lock_bh(&dp->reo_cmd_lock);
 	list_for_each_entry_safe(cmd, tmp, &dp->reo_cmd_list, list) {
 		list_del(&cmd->list);
-		dma_unmap_single(ab->dev, cmd->data.qbuf.paddr_aligned,
-				 cmd->data.qbuf.size, DMA_BIDIRECTIONAL);
-		kfree(cmd->data.qbuf.vaddr);
+		ath12k_dp_rx_tid_cleanup(ab, &cmd->data.qbuf);
 		kfree(cmd);
 	}
 
@@ -603,9 +612,7 @@ void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab)
 				 &dp->reo_cmd_cache_flush_list, list) {
 		list_del(&cmd_cache->list);
 		dp->reo_cmd_cache_flush_count--;
-		dma_unmap_single(ab->dev, cmd_cache->data.qbuf.paddr_aligned,
-				 cmd_cache->data.qbuf.size, DMA_BIDIRECTIONAL);
-		kfree(cmd_cache->data.qbuf.vaddr);
+		ath12k_dp_rx_tid_cleanup(ab, &cmd_cache->data.qbuf);
 		kfree(cmd_cache);
 	}
 	spin_unlock_bh(&dp->reo_cmd_lock);
@@ -620,10 +627,7 @@ static void ath12k_dp_reo_cmd_free(struct ath12k_dp *dp, void *ctx,
 		ath12k_warn(dp->ab, "failed to flush rx tid hw desc, tid %d status %d\n",
 			    rx_tid->tid, status);
 
-	dma_unmap_single(dp->ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
-			 DMA_BIDIRECTIONAL);
-	kfree(rx_tid->qbuf.vaddr);
-	rx_tid->qbuf.vaddr = NULL;
+	ath12k_dp_rx_tid_cleanup(dp->ab, &rx_tid->qbuf);
 }
 
 static int ath12k_dp_reo_cmd_send(struct ath12k_base *ab, struct ath12k_dp_rx_tid *rx_tid,
@@ -766,10 +770,7 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 
 	return;
 free_desc:
-	dma_unmap_single(ab->dev, rx_tid->qbuf.paddr_aligned, rx_tid->qbuf.size,
-			 DMA_BIDIRECTIONAL);
-	kfree(rx_tid->qbuf.vaddr);
-	rx_tid->qbuf.vaddr = NULL;
+	ath12k_dp_rx_tid_cleanup(ab, &rx_tid->qbuf);
 }
 
 static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
@@ -856,10 +857,7 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 	if (ret) {
 		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
 			   tid, ret);
-		dma_unmap_single(ar->ab->dev, rx_tid->qbuf.paddr_aligned,
-				 rx_tid->qbuf.size, DMA_BIDIRECTIONAL);
-		kfree(rx_tid->qbuf.vaddr);
-		rx_tid->qbuf.vaddr = NULL;
+		ath12k_dp_rx_tid_cleanup(ar->ab, &rx_tid->qbuf);
 	}
 
 	if (peer->mlo)
-- 
2.17.1


