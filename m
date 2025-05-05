Return-Path: <linux-wireless+bounces-22567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F953AAAA5E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B77F188CF6D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB1C379427;
	Mon,  5 May 2025 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3uo+kFe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD882D818F;
	Mon,  5 May 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485764; cv=none; b=oKRzOtpX4GJ9jzgNDrv6q4QoVP+uOz0uHk7hDEya0X0T9If9STNhsh1k2KuflBMD9PScuG8le8AS9ZNYP+DQERAP/uxbNVLBR6JjsJTp+dFU+u8YWmvRlqWIYHYZcWXO4HfRW5JXbfAmzJJy+9Wuq/9yu6Ew3zEBkGLhjXB2S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485764; c=relaxed/simple;
	bh=TsQGUHxbunuYlL+5yeNWrYVRKxT6Qrp6Bdsbu5dSO3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3WVT+HxJG9x19Rzek9XL98JH+/PeFdlnyKCOv+ucrz7pTPGx6c8iaHfyoS3M5DPGICoTRYHf4htQL1S6gO4dR39zP4WQygwL33KrpZKtXh1M9kqN6wRXOnRSlKLVTizkwV1a+qaUVm0hP4ZheO/wricnW7WxT+7ecQo1/eK/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3uo+kFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B04C4CEE4;
	Mon,  5 May 2025 22:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485763;
	bh=TsQGUHxbunuYlL+5yeNWrYVRKxT6Qrp6Bdsbu5dSO3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3uo+kFepgFiHXPI60VL/BsSSxSb+GaLhjnC0ctlyw/RyZfxjXcgMCpdpYGFPgcq+
	 luvr7jfiaWLzVc4g3o5Xj76Tclqmx51Xe2kuipg0lFxo/GueSI6HGeFxefqDKA3xP7
	 mGdPynbliGZd5rM+BYcmKEjhtBfPUWDgHNU+4ZFXn8Pdrpf8U0rAG2f7oaUUxHcpWo
	 CBcxND9PBsK1y4q9uhvWVIKxIdU5cJv30qEOuKqoxwwVrMVQRKYKB2hF1bPksSJRdT
	 pg/Vaw47nNY3HHFsMnTD/khU0RthNEDrS3LnHEgq6g8CV//7GqhfwRByHc5+gQ0fmm
	 dTKUAj1qlE30A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 472/486] wifi: ath12k: Fix end offset bit definition in monitor ring descriptor
Date: Mon,  5 May 2025 18:39:08 -0400
Message-Id: <20250505223922.2682012-472-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 6788a666000d600bd8f2e9f991cad9cc805e7f01 ]

End offset for the monitor destination ring descriptor is defined as
16 bits, while the firmware definition specifies only 12 bits.
The remaining bits (bit 12 to bit 15) are reserved and may contain
junk values, leading to invalid information retrieval. Fix this issue
by updating the correct genmask values.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Link: https://patch.msgid.link/20241223060132.3506372-8-quic_ppranees@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hal_desc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index 739f73370015e..4f745cfd7d8e7 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -2966,7 +2966,7 @@ struct hal_mon_buf_ring {
 
 #define HAL_MON_DEST_COOKIE_BUF_ID      GENMASK(17, 0)
 
-#define HAL_MON_DEST_INFO0_END_OFFSET		GENMASK(15, 0)
+#define HAL_MON_DEST_INFO0_END_OFFSET		GENMASK(11, 0)
 #define HAL_MON_DEST_INFO0_FLUSH_DETECTED	BIT(16)
 #define HAL_MON_DEST_INFO0_END_OF_PPDU		BIT(17)
 #define HAL_MON_DEST_INFO0_INITIATOR		BIT(18)
-- 
2.39.5


