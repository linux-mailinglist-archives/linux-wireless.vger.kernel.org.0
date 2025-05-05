Return-Path: <linux-wireless+bounces-22541-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B69EDAAA7B3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66881886FEC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8733E443;
	Mon,  5 May 2025 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvLg+OtB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28033E43C;
	Mon,  5 May 2025 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484663; cv=none; b=QmQfahcxPhuOS3TMdVZUh6PMTVi0b+Cq+8/VsFVm2/iprw02aoslBgIT7S/tYoiv4kxpVMoPjQOwwY5ChHffPTKWc/aH82ZOOYez+5hpBwg6ff96KMnQSxN4V+3cgCjVzlhMP+RrBvfwBDdR+dlOzEOzn0BtA9rflzF1UIZ2mVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484663; c=relaxed/simple;
	bh=PtKmNWhYuxw+9m13WySu1j15Y14gKpgGSQvph/hqweo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZS6BiRuZST5TcHYElYKulGp9D0erR9hwAsiAHsdE5ZSQ4+v7s9xobwnBShuNB/YazPKJvKlNNbNRpe33g8hql8/CcVTkGujfYsxQjYhqee/3WRpC9Ax6BNqZUx9AeBaUwC8LLwoFc9Q/OBMlJb4cMHa3X46ZAZ+tcaoQzJgjGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvLg+OtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0828C4CEEF;
	Mon,  5 May 2025 22:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484661;
	bh=PtKmNWhYuxw+9m13WySu1j15Y14gKpgGSQvph/hqweo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvLg+OtBRPypsZNGYSEFYmNG2fmwNhpPca2KQ23Xhqno6Y586V8rBrBHrplg4YZpZ
	 +Rg+yyNQyHDE/7OuLS2b01zTpSZIp76BBOOaxWYNwfzis3uxVltEr2djv3fUsrvJxK
	 cUyL0MBWoOfjBQNrrDElPHq8JK17gYrTA9qdjucTivS04qcvyjsreXDg9TJI2TT0qQ
	 TTWRdYpPMGw3w+/jSc3BcTWX+Yqhui+rr5IeH7hZcYFn29/2bQlWXDKlUSmp538E05
	 SDf0JqZCgZnPoEPShCF3Mlw6lwaSr3z0w552elkw0VgovRSDMTTqaLTSwYn5Al8+aB
	 WI4B5nO10l9xQ==
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
Subject: [PATCH AUTOSEL 6.14 592/642] wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
Date: Mon,  5 May 2025 18:13:28 -0400
Message-Id: <20250505221419.2672473-592-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 75608ae027afe..a39bfb959797a 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -117,7 +117,7 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
 			       le32_encode_bits(ti->data_len,
 						HAL_TX_MSDU_EXT_INFO1_BUF_LEN);
 
-	tcl_ext_cmd->info1 = le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
+	tcl_ext_cmd->info1 |= le32_encode_bits(1, HAL_TX_MSDU_EXT_INFO1_EXTN_OVERRIDE) |
 				le32_encode_bits(ti->encap_type,
 						 HAL_TX_MSDU_EXT_INFO1_ENCAP_TYPE) |
 				le32_encode_bits(ti->encrypt_type,
-- 
2.39.5


