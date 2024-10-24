Return-Path: <linux-wireless+bounces-14460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AE9AE3AA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 13:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF301C2295F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7411A1CDA3A;
	Thu, 24 Oct 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="boWAUI2Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CD1CEE8D;
	Thu, 24 Oct 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768789; cv=none; b=ZZY8ThFeQ2H90y8ezCUdwfk5jfho6Ocq5Zs1qREb+NIESvVywBLZyD6T5hNZBZ9WmlcrpCERRmgTiAoWOzpBCUlkce22MnP261ciUCVJfS0FYiLZNyy9I+NWpSDju8PbGrlL05P70E+Tp707eJb/Yse/twmfgbK+uFXzwgS7uRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768789; c=relaxed/simple;
	bh=5tTrRmjoVHELp3KDuPicsvggP5XzB9cTyoDk2y8EL/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXbVeMiMRFGLfRVoKyYZrMFW7P3nGJWLAfwVhY9gAcQxdzATQ1zFAhyStgbrAFH4RQZdvoyxuxmo6haE5fmJHIhUueBSipfb9BIztkGVcWVYEaAlFqNk8yD7La11u3qkH/NRuC69PeV65bLfPfwLQGk3kZiqNny9AvxMqNeOApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=boWAUI2Z; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4c80:0:640:a0f:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id AE48560B17;
	Thu, 24 Oct 2024 14:19:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SJSJZc7btmI0-rxIvdZYl;
	Thu, 24 Oct 2024 14:19:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729768777; bh=SLwG2Ba8NCmx37QYsKgUA9oUytCJNj/QnHeAbCi4bbQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=boWAUI2ZfV8B4ZNsnH53GhFnWDvi3xwvwsLr1YZX+1hSxdJB7JSy3arxfo/GFPJAK
	 lCc4STJHQ0Gdmv1q5tZz4lirkAHkcYpQt6Ji4tqpGwJM2W8R4c4PbY8aqbu5YjK8Fy
	 OcY3cRIopcbNbyblRbH8mee2a/silTIeJcWR3+UI=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2 3/3] wifi: ath11k: miscellaneous spelling fixes
Date: Thu, 24 Oct 2024 14:19:21 +0300
Message-ID: <20241024111921.93105-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024111921.93105-1-dmantipov@yandex.ru>
References: <20241024111921.93105-1-dmantipov@yandex.ru>
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
v2: join the series
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
index e6acbff06749..7a75de8aec2b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2230,7 +2230,7 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 		__le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map), vht_mcs_mask);
 
 	/* In IPQ8074 platform, VHT mcs rate 10 and 11 is enabled by default.
-	 * VHT mcs rate 10 and 11 is not suppoerted in 11ac standard.
+	 * VHT mcs rate 10 and 11 is not supported in 11ac standard.
 	 * so explicitly disable the VHT MCS rate 10 and 11 in 11ac mode.
 	 */
 	arg->tx_mcs_set &= ~IEEE80211_VHT_MCS_SUPPORT_0_11_MASK;
@@ -6952,7 +6952,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	/* Recalc txpower for remaining vdev */
 	ath11k_mac_txpower_recalc(ar);
 
-	/* TODO: recal traffic pause state based on the available vdevs */
+	/* TODO: recalc traffic pause state based on the available vdevs */
 
 	mutex_unlock(&ar->conf_mutex);
 }
-- 
2.47.0


