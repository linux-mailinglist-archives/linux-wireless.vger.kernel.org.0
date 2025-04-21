Return-Path: <linux-wireless+bounces-21778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C737A94B10
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B2A7A74A3
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C2257434;
	Mon, 21 Apr 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YK0gakk1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347A2571D6
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202945; cv=none; b=rAE6VAxwUZD2RYI3DLBXZMNcTZKhW2piUS1O9WlZd0OCKCSrHUHyxKtcihnSwskNi4u05gdXAnG5rfpkpykK1FV2xLRj+W3FHfpRK9Jybk2GV4kq0OKMOgr6r26Q0nStBsmW5J+5wdE74ANieqmxc8VI0wKwZBK8ZEIQL31SRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202945; c=relaxed/simple;
	bh=1j7oob9b6ws867aNt5GOibXmbmy31uxCeKMAvf9/FMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raHI6adtqh+NtJWIFWv5vRqTNqXElgpw7J8w7xYL46S+QjqEp+1fa85f1Aa1tuqUgVndLbEk0ab7F8b6sMLJZrDcqDrSNZUiCl07V+felbAaorxi8Ja4sbpON+Y4nDrvfpoXVdoF/Wcs5zkJw4sPLcYvjfcSb85/24VPLK/Ehbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YK0gakk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KMmBYJ012844
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=67YGzZ/G2Lv
	do7PXB4Z5mgL6caEumAEWn9q+k5dAI5o=; b=YK0gakk10kLdJ8XWQ5jRLYY8PuG
	wGcmUnsMLGyufAcs1/MD4thooU/KC30D4rGpeKct37NMdV7EQE4Es97hPAHqcK5j
	TOX2FecFTRkxVUD/DTrlN4O5CAMesMKj+tSMDYE4dwTAmkYTnr7dTUHJXsNqxuPG
	H+3pNimQDos++h0RCt75QJEB2/kZq+AIdIa9BaYdVoL4SZFnL5gL8BmLey0sYubU
	MDXZW1xCzhL/d4e11xxpCQUNuHMysAVOxlPrQ3vS7eDi1eQsS9Udz0n562V3uJ5P
	Eh5kykfJK8r2G9bJNYCVc7Y5pIZb/9me8j7ix6R9UmsBbx3eV6SUXqpCF2A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4643wwjstu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af570998077so2798915a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202926; x=1745807726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67YGzZ/G2Lvdo7PXB4Z5mgL6caEumAEWn9q+k5dAI5o=;
        b=bhwpYNHenOuzWmMF2/D9zr1FMUecbLWQI2/7OepDsm7J4MxdBIu0mZ/b4f4esJ9uBd
         ++EOOepFiGTLVC0qd6k/UmbcQvuPTPKrcESuKh5bOg6iaW+MftPcsgkGOeOkVYVhZAYx
         FIPTFizpC6PLvcAa/c9JzrvsslsCSxEng7Il3o9OqPclxt+87NkQAtd+caBQ7mJU5h0z
         /BEwJ5VMDnv6Wl6IBxdlPQlme/wqddO7MUkX1IGDckCne6BXrq4TbKvzujtpBWyTcdBQ
         rmIRvHfuVL7tEzzi94Oxs30LEvAhMz8TySZm+N2tUaOSgXFG0fzlCeZ8UEdQ4D5WcrlT
         5yMg==
X-Gm-Message-State: AOJu0YyO2hzkSu5n/EatEo9FE+HyT0K8xmjhlGEZe4H2n76tP3+96XFB
	6QgqvwCv+jIie581Y7BTyaq3ai6aUw6sMGO3Y6GQtcCxCdsiEPk+zvSKVEnOEkBrqQyVwzE+4SA
	VGWyzgH0XgvGyPNHNo7rBBllADvo848ycSB+2Yn89NJvWXMQ4LgCxMNFQMjyChV0WuA==
X-Gm-Gg: ASbGncuLN7nZEUaCrncpCCxjhMFjGFJHT0uc29IQj5NWLa5h5jl8hCD4NYlljYVoUoD
	pYK1SPBtRifKaGuvwrF9Ze/2FpB5DXxK6MKmLK8ylylHM7wUEHKBiSnPeWcl47osl9FrDW5gol5
	LCVEKa4C8RWMGxSxdjZzOLu9AmQ3X/Y1Cj02Nhe5PzTi6C9NFqS1jE5oygt1pzKFadmKyqQico6
	zmQWVz8FNzFSc5PwUlCZShk6La6Bdm9KSlm7tScKQHjF4r2nJjH/hAnvZxA+gA/n9vCVtHL6O/w
	xhLTdHvbi//UFpnGFXi7mINuksJCicCOGOk4HAyxuAm7FoahZSQbQK5RTsT6T4nAtiU+YiZKVMA
	+/oy6DhHLJ9I=
X-Received: by 2002:a17:90b:5444:b0:2ff:7b28:a51c with SMTP id 98e67ed59e1d1-3087bccc373mr12935685a91.34.1745202925925;
        Sun, 20 Apr 2025 19:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgFS0J4RkBWI+MsNlSHT4h+Zx/hjaZptW+L4c1bbP5zXBOe0m13Hz0zVqSSOhKTo+K43V7BQ==
X-Received: by 2002:a17:90b:5444:b0:2ff:7b28:a51c with SMTP id 98e67ed59e1d1-3087bccc373mr12935665a91.34.1745202925571;
        Sun, 20 Apr 2025 19:35:25 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:25 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 04/13] wifi: ath12k: add ring config for monitor mode on WCN7850
Date: Mon, 21 Apr 2025 10:34:35 +0800
Message-Id: <20250421023444.1778-5-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IpEecK/g c=1 sm=1 tr=0 ts=6805aefe cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=aGczzSDeKDuVj5iByfEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: itJlOWDBw9Oehkx7DBnyA1B3m53kQVQ0
X-Proofpoint-ORIG-GUID: itJlOWDBw9Oehkx7DBnyA1B3m53kQVQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504210018

For WCN7850, it doesn't have an RX MON component(RX MON dest ring and
RX MON buffer ring). So it can only reuse the mon status ring, RX
refill ring, and error dst ring for monitor mode.

Every time the hardware captures a packet, it will store status
information into the status ring and store the MSDU payload buffer
address into the error dst ring. When host reaps the MSDU payload and
consumes a buffer, it will replenish the RX refill ring to indicate a
new buffer.

The configuration of the error dst/RX ring already exists. But there is
no configuration for mon status ring. So add ring configuration for it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.h     |  9 +++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 88 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/dp_mon.h |  3 +
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 66 +++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp_tx.c  | 38 ++++++++++
 5 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 2ce6f0d7574f..0dd2a981516d 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -193,6 +193,14 @@ struct ath12k_pdev_dp {
 #define DP_RX_BUFFER_SIZE_LITE	1024
 #define DP_RX_BUFFER_ALIGN_SIZE	128
 
+#define RX_MON_STATUS_BASE_BUF_SIZE	2048
+#define RX_MON_STATUS_BUF_ALIGN		128
+#define RX_MON_STATUS_BUF_RESERVATION	128
+#define RX_MON_STATUS_BUF_SIZE		(RX_MON_STATUS_BASE_BUF_SIZE - \
+				 (RX_MON_STATUS_BUF_RESERVATION + \
+				  RX_MON_STATUS_BUF_ALIGN + \
+				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info))))
+
 #define DP_RXDMA_BUF_COOKIE_BUF_ID	GENMASK(17, 0)
 #define DP_RXDMA_BUF_COOKIE_PDEV_ID	GENMASK(19, 18)
 
@@ -392,6 +400,7 @@ struct ath12k_dp {
 	struct dp_srng rxdma_err_dst_ring[MAX_RXDMA_PER_PDEV];
 	struct dp_rxdma_mon_ring rxdma_mon_buf_ring;
 	struct dp_rxdma_mon_ring tx_mon_buf_ring;
+	struct dp_rxdma_mon_ring rx_mon_status_refill_ring[MAX_RXDMA_PER_PDEV];
 	struct ath12k_reo_q_addr_lut reoq_lut;
 	struct ath12k_reo_q_addr_lut ml_reoq_lut;
 };
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 351f52138d39..28fb9d4aa673 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -2493,6 +2493,94 @@ int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 	return -ENOMEM;
 }
 
+int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
+					struct dp_rxdma_mon_ring *rx_ring,
+					int req_entries)
+{
+	enum hal_rx_buf_return_buf_manager mgr =
+		ab->hw_params->hal_params->rx_buf_rbm;
+	int num_free, num_remain, buf_id;
+	struct ath12k_buffer_addr *desc;
+	struct hal_srng *srng;
+	struct sk_buff *skb;
+	dma_addr_t paddr;
+	u32 cookie;
+
+	req_entries = min(req_entries, rx_ring->bufs_max);
+
+	srng = &ab->hal.srng_list[rx_ring->refill_buf_ring.ring_id];
+
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	num_free = ath12k_hal_srng_src_num_free(ab, srng, true);
+	if (!req_entries && (num_free > (rx_ring->bufs_max * 3) / 4))
+		req_entries = num_free;
+
+	req_entries = min(num_free, req_entries);
+	num_remain = req_entries;
+
+	while (num_remain > 0) {
+		skb = dev_alloc_skb(RX_MON_STATUS_BUF_SIZE);
+		if (!skb)
+			break;
+
+		if (!IS_ALIGNED((unsigned long)skb->data,
+				RX_MON_STATUS_BUF_ALIGN)) {
+			skb_pull(skb,
+				 PTR_ALIGN(skb->data, RX_MON_STATUS_BUF_ALIGN) -
+				 skb->data);
+		}
+
+		paddr = dma_map_single(ab->dev, skb->data,
+				       skb->len + skb_tailroom(skb),
+				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(ab->dev, paddr))
+			goto fail_free_skb;
+
+		spin_lock_bh(&rx_ring->idr_lock);
+		buf_id = idr_alloc(&rx_ring->bufs_idr, skb, 0,
+				   rx_ring->bufs_max * 3, GFP_ATOMIC);
+		spin_unlock_bh(&rx_ring->idr_lock);
+		if (buf_id < 0)
+			goto fail_dma_unmap;
+		cookie = u32_encode_bits(buf_id, DP_RXDMA_BUF_COOKIE_BUF_ID);
+
+		desc = ath12k_hal_srng_src_get_next_entry(ab, srng);
+		if (!desc)
+			goto fail_buf_unassign;
+
+		ATH12K_SKB_RXCB(skb)->paddr = paddr;
+
+		num_remain--;
+
+		ath12k_hal_rx_buf_addr_info_set(desc, paddr, cookie, mgr);
+	}
+
+	ath12k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	return req_entries - num_remain;
+
+fail_buf_unassign:
+	spin_lock_bh(&rx_ring->idr_lock);
+	idr_remove(&rx_ring->bufs_idr, buf_id);
+	spin_unlock_bh(&rx_ring->idr_lock);
+fail_dma_unmap:
+	dma_unmap_single(ab->dev, paddr, skb->len + skb_tailroom(skb),
+			 DMA_FROM_DEVICE);
+fail_free_skb:
+	dev_kfree_skb_any(skb);
+
+	ath12k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	return req_entries - num_remain;
+}
+
 static struct dp_mon_tx_ppdu_info *
 ath12k_dp_mon_tx_get_ppdu_info(struct ath12k_mon_data *pmon,
 			       unsigned int ppdu_id,
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
index 9f3adee51cb2..e25595cbdcf3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.h
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -85,6 +85,9 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
 				struct dp_rxdma_mon_ring *buf_ring,
 				int req_entries);
+int ath12k_dp_mon_status_bufs_replenish(struct ath12k_base *ab,
+					struct dp_rxdma_mon_ring *rx_ring,
+					int req_entries);
 int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
 			       struct napi_struct *napi, int budget,
 			       enum dp_monitor_mode monitor_mode);
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1abfbd15f13c..6bbae10f7389 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -414,9 +414,17 @@ static int ath12k_dp_rxdma_mon_buf_ring_free(struct ath12k_base *ab,
 static int ath12k_dp_rxdma_buf_free(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
+	int i;
 
 	ath12k_dp_rxdma_mon_buf_ring_free(ab, &dp->rxdma_mon_buf_ring);
 
+	if (ab->hw_params->rxdma1_enable)
+		return 0;
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++)
+		ath12k_dp_rxdma_mon_buf_ring_free(ab,
+						  &dp->rx_mon_status_refill_ring[i]);
+
 	return 0;
 }
 
@@ -430,7 +438,12 @@ static int ath12k_dp_rxdma_mon_ring_buf_setup(struct ath12k_base *ab,
 		ath12k_hal_srng_get_entrysize(ab, ringtype);
 
 	rx_ring->bufs_max = num_entries;
-	ath12k_dp_mon_buf_replenish(ab, rx_ring, num_entries);
+
+	if (ringtype == HAL_RXDMA_MONITOR_STATUS)
+		ath12k_dp_mon_status_bufs_replenish(ab, rx_ring,
+						    num_entries);
+	else
+		ath12k_dp_mon_buf_replenish(ab, rx_ring, num_entries);
 
 	return 0;
 }
@@ -451,7 +464,8 @@ static int ath12k_dp_rxdma_ring_buf_setup(struct ath12k_base *ab,
 static int ath12k_dp_rxdma_buf_setup(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
-	int ret;
+	struct dp_rxdma_mon_ring *mon_ring;
+	int ret, i;
 
 	ret = ath12k_dp_rxdma_ring_buf_setup(ab, &dp->rx_refill_buf_ring);
 	if (ret) {
@@ -464,9 +478,19 @@ static int ath12k_dp_rxdma_buf_setup(struct ath12k_base *ab)
 		ret = ath12k_dp_rxdma_mon_ring_buf_setup(ab,
 							 &dp->rxdma_mon_buf_ring,
 							 HAL_RXDMA_MONITOR_BUF);
-		if (ret) {
+		if (ret)
 			ath12k_warn(ab,
 				    "failed to setup HAL_RXDMA_MONITOR_BUF\n");
+		return ret;
+	}
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+		mon_ring = &dp->rx_mon_status_refill_ring[i];
+		ret = ath12k_dp_rxdma_mon_ring_buf_setup(ab, mon_ring,
+							 HAL_RXDMA_MONITOR_STATUS);
+		if (ret) {
+			ath12k_warn(ab,
+				    "failed to setup HAL_RXDMA_MONITOR_STATUS\n");
 			return ret;
 		}
 	}
@@ -4244,6 +4268,7 @@ void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
 void ath12k_dp_rx_free(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
+	struct dp_srng *srng;
 	int i;
 
 	ath12k_dp_srng_cleanup(ab, &dp->rx_refill_buf_ring.refill_buf_ring);
@@ -4251,6 +4276,10 @@ void ath12k_dp_rx_free(struct ath12k_base *ab)
 	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
 		if (ab->hw_params->rx_mac_buf_ring)
 			ath12k_dp_srng_cleanup(ab, &dp->rx_mac_buf_ring[i]);
+		if (!ab->hw_params->rxdma1_enable) {
+			srng = &dp->rx_mon_status_refill_ring[i].refill_buf_ring;
+			ath12k_dp_srng_cleanup(ab, srng);
+		}
 	}
 
 	for (i = 0; i < ab->hw_params->num_rxdma_dst_ring; i++)
@@ -4399,6 +4428,19 @@ int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 				    ret);
 			return ret;
 		}
+	} else {
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+			ring_id =
+				dp->rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+			ret = ath12k_dp_tx_htt_srng_setup(ab, ring_id, i,
+							  HAL_RXDMA_MONITOR_STATUS);
+			if (ret) {
+				ath12k_warn(ab,
+					    "failed to configure mon_status_refill_ring%d %d\n",
+					    i, ret);
+				return ret;
+			}
+		}
 	}
 
 	ret = ab->hw_params->hw_ops->rxdma_ring_sel_config(ab);
@@ -4413,6 +4455,7 @@ int ath12k_dp_rx_htt_setup(struct ath12k_base *ab)
 int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
+	struct dp_srng *srng;
 	int i, ret;
 
 	idr_init(&dp->rxdma_mon_buf_ring.bufs_idr);
@@ -4460,6 +4503,23 @@ int ath12k_dp_rx_alloc(struct ath12k_base *ab)
 			ath12k_warn(ab, "failed to setup HAL_RXDMA_MONITOR_BUF\n");
 			return ret;
 		}
+	} else {
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+			idr_init(&dp->rx_mon_status_refill_ring[i].bufs_idr);
+			spin_lock_init(&dp->rx_mon_status_refill_ring[i].idr_lock);
+		}
+
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+			srng = &dp->rx_mon_status_refill_ring[i].refill_buf_ring;
+			ret = ath12k_dp_srng_setup(ab, srng,
+						   HAL_RXDMA_MONITOR_STATUS, 0, i,
+						   DP_RXDMA_MON_STATUS_RING_SIZE);
+			if (ret) {
+				ath12k_warn(ab, "failed to setup mon status ring %d\n",
+					    i);
+				return ret;
+			}
+		}
 	}
 
 	ret = ath12k_dp_rxdma_buf_setup(ab);
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 2136eeb278af..f6b02c1c035a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -1511,6 +1511,44 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
 				return ret;
 			}
 		}
+		return 0;
+	}
+
+	if (!reset) {
+		for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+			ring_id = ab->dp.rx_mac_buf_ring[i].ring_id;
+			ret = ath12k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id,
+							       i,
+							       HAL_RXDMA_BUF,
+							       DP_RXDMA_REFILL_RING_SIZE,
+							       &tlv_filter);
+			if (ret) {
+				ath12k_err(ab,
+					   "failed to setup filter for mon rx buf %d\n",
+					   ret);
+				return ret;
+			}
+		}
+	}
+
+	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++) {
+		ring_id = ab->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		if (!reset) {
+			tlv_filter.rx_filter =
+				HTT_RX_MON_FILTER_TLV_FLAGS_MON_STATUS_RING;
+		}
+
+		ret = ath12k_dp_tx_htt_rx_filter_setup(ab, ring_id,
+						       i,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       RX_MON_STATUS_BUF_SIZE,
+						       &tlv_filter);
+		if (ret) {
+			ath12k_err(ab,
+				   "failed to setup filter for mon status buf %d\n",
+				   ret);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.34.1


