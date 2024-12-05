Return-Path: <linux-wireless+bounces-15940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC89E5F77
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 21:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A2C285E65
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 20:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D01CB518;
	Thu,  5 Dec 2024 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGRqz3yS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC01B87C7;
	Thu,  5 Dec 2024 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430658; cv=none; b=hfygAe2nRnzDZe6Dt5fBOIo1Gv0NH1zWlwsHS03BIWHmidFWj8VyC3dJwo/41rgF3POG8caorNc6lxG3mcBGYxlZra7ownO6rKJ3/U+rxCYEjw37zh1cyjc/4RLsmNlUSptcTLAZb13CIiedUxXOB/COuxCiPXBnszk+k7X2KqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430658; c=relaxed/simple;
	bh=ZM8zjJkGa/qRK0XshDVNYNacIug+9Bt5JFORjs69WfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sCZbzlfgUEvy6/EkWF42PXP0bCpZDGm53t5zuCVnGmQ3xGqJNGf8oAc1GQRnvVBZHZZWzZuG8gDYJQxToM/64Djeo+4g/NZ40T29hCoXhx1xsI/YsDKM2kEHzRUl2bXv7UkXwAmDtqJC6TIerrDCqOGu/0xZqkjUxQxdY1SNca4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGRqz3yS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD5AC4CED1;
	Thu,  5 Dec 2024 20:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733430657;
	bh=ZM8zjJkGa/qRK0XshDVNYNacIug+9Bt5JFORjs69WfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGRqz3ySDoEV2GM/Qt4WdcJP39s3fzt1XzMcXp+vk6xbyUFJyOypzjZ58AwsEGyN0
	 i0a+savx4tURdAIcBOnmQObAgMaz3CiErLpO5Mg0WK90uNaxfNi2sR6hbIitPYaDtt
	 6Jsi3OZ/17bPZYYP6/dAgGViftYI5W+t9BaZQdq5zciDz9yE8krKAzQ/Dvj9j/NPHJ
	 RaV3TWottPbqTTCsxrzi6QoEwFQy8RGfCt0tFSnWA0hdICbVU2j2nKzuuFEZqTGjY1
	 RDuXmiNbs+U448V0iyq2+D8T8ICV8165Q8woIskZnpjrE60hiC+GxEYZnahC6LteRP
	 tFKMOUVAs1Z3w==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 8/8] wifi: ath12k: avoid redundant code in DP Rx error process
Date: Thu,  5 Dec 2024 22:30:44 +0200
Message-Id: <20241205203044.589499-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205203044.589499-1-kvalo@kernel.org>
References: <20241205203044.589499-1-kvalo@kernel.org>
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


