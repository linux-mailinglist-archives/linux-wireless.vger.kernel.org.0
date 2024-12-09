Return-Path: <linux-wireless+bounces-16069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477B59E9A9B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28D51886BE7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC91F2C31;
	Mon,  9 Dec 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/YLjG8g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC561C5CD3;
	Mon,  9 Dec 2024 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758248; cv=none; b=D+sJ28s6Wk+LOyNmkeyJmQhMx3wYwAJzYv9jidCNKx9ptkEvJMjKWLdCYCjnMs/OInjucjJRlXAWRQwboObNJfM/o5lcvAAiUjGCEHDDnPyMDdoVEC4BdX1KQLsaMeq9dG5wfV9Pjxwu64u996NYGDqX1YYbeseyEllLnaxDT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758248; c=relaxed/simple;
	bh=ZM8zjJkGa/qRK0XshDVNYNacIug+9Bt5JFORjs69WfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbNnFwCxPnDQ3I3T5wfHfJsQG8ysiUA5qwNn7ZPdIY4q0EPQXEfP0Z8JFzlycCKWaTSCZaPYaaurVlOzCwekjerOlQgs67NCVKKHk4rFCEBQI1p35/KNHWyv0suTKaZc4qwJ0kmgp0wEqXyBjM2oshohn30wsn1v6YEHY5I/vuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/YLjG8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02D9C4CEDE;
	Mon,  9 Dec 2024 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758247;
	bh=ZM8zjJkGa/qRK0XshDVNYNacIug+9Bt5JFORjs69WfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/YLjG8gDfJDCtwG4CBrKcWh6Kj7ygTPW5SMuHRBqD0GhoOTxAsKhl0vhh7wWRFVh
	 i0iZNztMBs4k7obkf5OTylNn+KLnKXhx+fBt3kh8kW8VfbBOpSZSLRh4/f9xu+H0f4
	 i0TATrxKnzjL1i0XfSXsSdnhTxkzPzNepDj0d9Znb8IlA0S5+DG7AYHik/lcC9aba+
	 AaOUf5cLQdt7Gz6tjyxBBTWOknMjnJ6udcKrHi5h3anHH4Wouh6Qz1e7iQah7bZQDx
	 ayiTJl4ctYkhfuACNdMKwL+x5EuD0Cp3fmyrLIIYxU/QRJFAvJzjiBjHY+o+vUiJ9Q
	 EojWZFQoa9bwA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 8/8] wifi: ath12k: avoid redundant code in DP Rx error process
Date: Mon,  9 Dec 2024 17:30:34 +0200
Message-Id: <20241209153034.50558-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209153034.50558-1-kvalo@kernel.org>
References: <20241209153034.50558-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, in DP rx error processing, the MAC id is fetched redundantly from
the same descriptor for each MSDU. To avoid this redundancy, move the fetch
handling before the iteration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index b24d1de4aabb..2c919503ddef 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3516,6 +3516,13 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 				    ret);
 			continue;
 		}
+
+		mac_id = le32_get_bits(reo_desc->info0,
+				       HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
+
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		ar = ab->pdevs[pdev_id].ar;
+
 		link_desc_va = link_desc_banks[desc_bank].vaddr +
 			       (paddr - link_desc_banks[desc_bank].paddr);
 		ath12k_hal_rx_msdu_link_info_get(link_desc_va, &num_msdus, msdu_cookies,
@@ -3544,12 +3551,6 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		}
 
 		for (i = 0; i < num_msdus; i++) {
-			mac_id = le32_get_bits(reo_desc->info0,
-					       HAL_REO_DEST_RING_INFO0_SRC_LINK_ID);
-
-			pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
-			ar = ab->pdevs[pdev_id].ar;
-
 			if (!ath12k_dp_process_rx_err_buf(ar, reo_desc,
 							  &rx_desc_used_list,
 							  drop,
-- 
2.39.5


