Return-Path: <linux-wireless+bounces-22582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0513AAABA6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8060018935D1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31928541F;
	Mon,  5 May 2025 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8Xsg/JF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36D3745BA;
	Mon,  5 May 2025 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486368; cv=none; b=RxcfTj/Zy392IwD+2UVNNq3/5yUwUfH6cVPCCrZgupfdMX4ji/Z5aTWVqutaWEkne5WjVAqlhLoZNiX8B3LbaQhd9wrjuERMtvHI9805Ndr1EofzFRxU2kQ1myPLwe4+7t1H8I+jIEmL5jOV0w2BIV3sofQjc9k00hZQtcmkyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486368; c=relaxed/simple;
	bh=1KuU1cq5++A1+lXLHU5Be7SugZDxVeCdiTW24JTYsk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAIKOU2h0lrQHqyzYM72Rwt83hPNziLLWEO6ceWP05OYi5sN5IPEm3XcawtXseax779KQiMw3rG7kVpzMzYuuxw6pTD7m/Fqsgn6Pc0sIoLwxyjDrVuV9dXaZQI6KEEbFBecnOqmnXHjYmYYdALANXpaA77yu3nsCdbLvluycH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8Xsg/JF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A337CC4CEED;
	Mon,  5 May 2025 23:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486367;
	bh=1KuU1cq5++A1+lXLHU5Be7SugZDxVeCdiTW24JTYsk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8Xsg/JFdMIXbCId0ovt0fK5hngFM3y94siw5Jj43q9GTDsUgVV3aAWHUlySDthim
	 6KqvsO0V+yTuDDOJC1Yx3hv813JM0tRn/fVfTECpf3MnHT0kDiCm3QjxS41UMOitIw
	 FovB8o3p09UTKt21ux27cYXbI0uMmrzP9c6EkD2BvWrl/5MiuDYdKSjbr9rqIotFQL
	 7w6zS//+CCzT/mSHH65leURC47n9xhUG/LH3O8k9Nqd54F0hgn3daqQtjemh1MbbZ+
	 oy/EjdqoW/T8G6uUyVoan3KW7kc/WAE8E5SeJtZwFYLTemrFc3oYK66hHh8n+oqptD
	 iVQBcjjt32iBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Escande <nico.escande@gmail.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 286/294] wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
Date: Mon,  5 May 2025 18:56:26 -0400
Message-Id: <20250505225634.2688578-286-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Nicolas Escande <nico.escande@gmail.com>

[ Upstream commit df11edfba49e5fb69f4c9e7cb76082b89c417f78 ]

Since inception there is an obvious typo laying around in
ath12k_hal_tx_cmd_ext_desc_setup(). Instead of initializing + adding
flags to tcl_ext_cmd->info1, we initialize + override. This will be needed
in the future to make broadcast frames work with ethernet encapsulation.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250127071306.1454699-1-nico.escande@gmail.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 25a9d4c4fae76..474e0d4d406ea 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -118,7 +118,7 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab, void *cmd,
 			       le32_encode_bits(ti->data_len,
 						HAL_TX_MSDU_EXT_INFO1_BUF_LEN);
 
-	tcl_ext_cmd->info1 = le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
+	tcl_ext_cmd->info1 |= le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
 				le32_encode_bits(ti->encap_type,
 						 HAL_TX_MSDU_EXT_INFO1_ENCAP_TYPE) |
 				le32_encode_bits(ti->encrypt_type,
-- 
2.39.5


