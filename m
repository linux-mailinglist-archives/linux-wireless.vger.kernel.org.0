Return-Path: <linux-wireless+bounces-15167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277509C38CD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 08:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22A41F2148F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD7132132;
	Mon, 11 Nov 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YpYAXLt/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5191BC4E
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308535; cv=none; b=GABjJzu9RHvS6HQ9uqiOgoczuw/jzwtru30X0/SWeF/cRVF1CTCjidjLvNFcGdl4oxAGzYS6hl3qPrIpAnllHPULTz7BA3U9+dW5WrfPUnSMXd73m4P3El0L2ZL1pVmAwznmrJ14nLlaZOyLFVYiWflh8w1cCMsyOxwtx4YndLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308535; c=relaxed/simple;
	bh=nxyoG981Gmuih536+IZOPYUaveR9vCPCYd0oMAtBrT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XF2cabSIx3QrYQsqLQzNzzBaeys4xYyojagRjLrjJFrLsXbcVV8aJ97lXVFbqKp8InPbiVOFvgfSWJSABG+vbLoPRgZYc5jnV3W3IcqQn3QUP0Y0NYfo0kuUtsBVJlOIlU0sGuhFOMY4hko2EIqnD9Bux1a6KS9P/Tk0Sn5SlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YpYAXLt/; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 5677960B2A;
	Mon, 11 Nov 2024 10:02:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 22g22h1xFKo0-G8Rhr3gT;
	Mon, 11 Nov 2024 10:02:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731308524; bh=sKoUBbuQqLVKV9vnsO4RkxC7AjCQWLEZH1h5/aLHAaU=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=YpYAXLt/nQGSIQz7EHnNrxUWdf656ouPKWyIOkCzoWh7ArlLY8LKGUU4+e+5nFnpe
	 nbQteS9wYoHBHOJdxBTzhpR/TKJptg2nU30RZlXrmPOhxoXGNs9/Wjct3W2nl+3qsp
	 DtbGOn50ntDNzAoo66LT6a2SsXACB29JihoydXpk=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 4/4] wifi: ath11k: miscellaneous spelling fixes
Date: Mon, 11 Nov 2024 10:01:52 +0300
Message-ID: <20241111070152.85140-4-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111070152.85140-1-dmantipov@yandex.ru>
References: <20241111070152.85140-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling here and there as suggested by codespell.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: join the series but unchanged otherwise
---
 drivers/net/wireless/ath/ath11k/hal.h | 6 +++---
 drivers/net/wireless/ath/ath11k/mac.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index dc8bbe073017..601542410c75 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -700,7 +700,7 @@ enum hal_rx_buf_return_buf_manager {
 #define HAL_REO_CMD_FLG_UNBLK_RESOURCE		BIT(7)
 #define HAL_REO_CMD_FLG_UNBLK_CACHE		BIT(8)
 
-/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO0_UPD_* feilds */
+/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO0_UPD_* fields */
 #define HAL_REO_CMD_UPD0_RX_QUEUE_NUM		BIT(8)
 #define HAL_REO_CMD_UPD0_VLD			BIT(9)
 #define HAL_REO_CMD_UPD0_ALDC			BIT(10)
@@ -725,7 +725,7 @@ enum hal_rx_buf_return_buf_manager {
 #define HAL_REO_CMD_UPD0_PN_VALID		BIT(29)
 #define HAL_REO_CMD_UPD0_PN			BIT(30)
 
-/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO1_* feilds */
+/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO1_* fields */
 #define HAL_REO_CMD_UPD1_VLD			BIT(16)
 #define HAL_REO_CMD_UPD1_ALDC			GENMASK(18, 17)
 #define HAL_REO_CMD_UPD1_DIS_DUP_DETECTION	BIT(19)
@@ -741,7 +741,7 @@ enum hal_rx_buf_return_buf_manager {
 #define HAL_REO_CMD_UPD1_PN_HANDLE_ENABLE	BIT(30)
 #define HAL_REO_CMD_UPD1_IGNORE_AMPDU_FLG	BIT(31)
 
-/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO2_* feilds */
+/* Should be matching with HAL_REO_UPD_RX_QUEUE_INFO2_* fields */
 #define HAL_REO_CMD_UPD2_SVLD			BIT(10)
 #define HAL_REO_CMD_UPD2_SSN			GENMASK(22, 11)
 #define HAL_REO_CMD_UPD2_SEQ_2K_ERR		BIT(23)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9757ac4aae50..31ae9b384a29 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2228,7 +2228,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 		__le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map), vht_mcs_mask);
 
 	/* In IPQ8074 platform, VHT mcs rate 10 and 11 is enabled by default.
-	 * VHT mcs rate 10 and 11 is not suppoerted in 11ac standard.
+	 * VHT mcs rate 10 and 11 is not supported in 11ac standard.
 	 * so explicitly disable the VHT MCS rate 10 and 11 in 11ac mode.
 	 */
 	arg->tx_mcs_set &= ~IEEE80211_VHT_MCS_SUPPORT_0_11_MASK;
@@ -6950,7 +6950,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	/* Recalc txpower for remaining vdev */
 	ath11k_mac_txpower_recalc(ar);
 
-	/* TODO: recal traffic pause state based on the available vdevs */
+	/* TODO: recalc traffic pause state based on the available vdevs */
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.47.0


