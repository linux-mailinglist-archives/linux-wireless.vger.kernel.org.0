Return-Path: <linux-wireless+bounces-16254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC019ECFDC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E53E2865FD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFD61D934B;
	Wed, 11 Dec 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6mjK6FM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88511D8E10;
	Wed, 11 Dec 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931286; cv=none; b=C55vvKSnoZndYMwHJ4KW5tF17Wty4MgDXJK5ZZMQaLzY1DQ0F/4nNHqQd0wGFkl2YAF1mT71oAOyfrT/ZbxqBHJklpy0xyvYgh5R0Q6GBlucqeOC2QkAvkywS9sgrxU1NT6EvbXCWdsdmZ9VGXzjwna49UfDpqq7I73ONWD0wCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931286; c=relaxed/simple;
	bh=ZM8zjJkGa/qRK0XshDVNYNacIug+9Bt5JFORjs69WfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=loEHkWG95F/wWC9qOwkGs68czQ8NrCy9TexkGoxJhkdclxrUOIkqqxVsQOtbp+tSLgHrqWfRgtZlNlvYX6XGpMxOrv8CYlJHqsRW/sss6uyLJxC8D8wD4B8uNEFm6qBnkCLgufA0QZc++H1km08UQPq7TGqBAnZTdzmQCTvN75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6mjK6FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC62C4CED2;
	Wed, 11 Dec 2024 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931286;
	bh=ZM8zjJkGa/qRK0XshDVNYNacIug+9Bt5JFORjs69WfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6mjK6FMSKMZXybSt4Zs22OiBDMQjrE1GgwA1U/ErLdDFx21KA5c1g11JwdmWl5d/
	 tm2i314NohBkrjYcZ6sQMS7YGqYNbQ3d7iuOWqfxYomeSolXNxYOvGu/zTHtP4ORxP
	 do/gWnr18Cx04LRzkmr/5G0z3yG13CSZSYzKrBHlHDFv4Gcb/Eypqpn1rLfOqwnybn
	 iKquvS+euEG87PWhqs1CYH1AuENSPu+cgCcT74G2DKwzJHH0F4AFm0bfoCsROY7KEa
	 UQwGUF82EmtvuC1Qm2nhZ04JTSVj16vJpJ2AQRpxzLBTyDbOeByr84z01nHuf64izJ
	 qL7AUk97DnA2A==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 8/8] wifi: ath12k: avoid redundant code in DP Rx error process
Date: Wed, 11 Dec 2024 17:34:32 +0200
Message-Id: <20241211153432.775335-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211153432.775335-1-kvalo@kernel.org>
References: <20241211153432.775335-1-kvalo@kernel.org>
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


