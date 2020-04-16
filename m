Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233541AC034
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506678AbgDPLvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 07:51:20 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:14078 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2506666AbgDPLvN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 07:51:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587037872; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=miETs94i4blhgkGVoh5R5ywNSQzqvf7HXbvSF7NJ0NU=; b=m9iSADAQuRQv58cH+10OlUkRgpHwXQmTMsNDG4wcyDwtAaU2issjIewpMuHptfmCZZBAuJfp
 mA15MN3EeR8SFO3x3Rg2ot8dKU9tJwkgeTbOEQaPuyNIfarrf60WxeTuzq16nPjLG0xrRkXl
 CmrIlvApwOU5IAzOQ3XwbLQVkBU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9846ad.7f33307f5420-smtp-out-n01;
 Thu, 16 Apr 2020 11:51:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D877C432C2; Thu, 16 Apr 2020 11:51:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B62DC433BA;
        Thu, 16 Apr 2020 11:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B62DC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 4/4] ath10k: hif: make send_complete_check op optional
Date:   Thu, 16 Apr 2020 14:50:59 +0300
Message-Id: <1587037859-28873-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587037859-28873-1-git-send-email-kvalo@codeaurora.org>
References: <1587037859-28873-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

That way we don't need to have an empty function in sdio.c.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/hif.h  |  3 ++-
 drivers/net/wireless/ath/ath10k/sdio.c | 12 ------------
 drivers/net/wireless/ath/ath10k/usb.c  | 12 ------------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/hif.h b/drivers/net/wireless/ath/ath10k/hif.h
index 2c5d61d98337..9e45fd9073a6 100644
--- a/drivers/net/wireless/ath/ath10k/hif.h
+++ b/drivers/net/wireless/ath/ath10k/hif.h
@@ -170,7 +170,8 @@ static inline void ath10k_hif_get_default_pipe(struct ath10k *ar,
 static inline void ath10k_hif_send_complete_check(struct ath10k *ar,
 						  u8 pipe_id, int force)
 {
-	ar->hif.ops->send_complete_check(ar, pipe_id, force);
+	if (ar->hif.ops->send_complete_check)
+		ar->hif.ops->send_complete_check(ar, pipe_id, force);
 }
 
 static inline u16 ath10k_hif_get_free_queue_number(struct ath10k *ar,
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 884e1a85e29f..e2aff2254a40 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -2101,17 +2101,6 @@ static void ath10k_sdio_hif_get_default_pipe(struct ath10k *ar,
 	*dl_pipe = 0;
 }
 
-/* This op is currently only used by htc_wait_target if the HTC ready
- * message times out. It is not applicable for SDIO since there is nothing
- * we can do if the HTC ready message does not arrive in time.
- * TODO: Make this op non mandatory by introducing a NULL check in the
- * hif op wrapper.
- */
-static void ath10k_sdio_hif_send_complete_check(struct ath10k *ar,
-						u8 pipe, int force)
-{
-}
-
 static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
 	.tx_sg			= ath10k_sdio_hif_tx_sg,
 	.diag_read		= ath10k_sdio_hif_diag_read,
@@ -2123,7 +2112,6 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
 	.get_htt_tx_complete	= ath10k_sdio_get_htt_tx_complete,
 	.map_service_to_pipe	= ath10k_sdio_hif_map_service_to_pipe,
 	.get_default_pipe	= ath10k_sdio_hif_get_default_pipe,
-	.send_complete_check	= ath10k_sdio_hif_send_complete_check,
 	.power_up		= ath10k_sdio_hif_power_up,
 	.power_down		= ath10k_sdio_hif_power_down,
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/ath/ath10k/usb.c b/drivers/net/wireless/ath/ath10k/usb.c
index 1e0343081be9..b7daf344d012 100644
--- a/drivers/net/wireless/ath/ath10k/usb.c
+++ b/drivers/net/wireless/ath/ath10k/usb.c
@@ -693,17 +693,6 @@ static int ath10k_usb_hif_map_service_to_pipe(struct ath10k *ar, u16 svc_id,
 	return 0;
 }
 
-/* This op is currently only used by htc_wait_target if the HTC ready
- * message times out. It is not applicable for USB since there is nothing
- * we can do if the HTC ready message does not arrive in time.
- * TODO: Make this op non mandatory by introducing a NULL check in the
- * hif op wrapper.
- */
-static void ath10k_usb_hif_send_complete_check(struct ath10k *ar,
-					       u8 pipe, int force)
-{
-}
-
 static int ath10k_usb_hif_power_up(struct ath10k *ar,
 				   enum ath10k_firmware_mode fw_mode)
 {
@@ -737,7 +726,6 @@ static const struct ath10k_hif_ops ath10k_usb_hif_ops = {
 	.stop			= ath10k_usb_hif_stop,
 	.map_service_to_pipe	= ath10k_usb_hif_map_service_to_pipe,
 	.get_default_pipe	= ath10k_usb_hif_get_default_pipe,
-	.send_complete_check	= ath10k_usb_hif_send_complete_check,
 	.get_free_queue_number	= ath10k_usb_hif_get_free_queue_number,
 	.power_up		= ath10k_usb_hif_power_up,
 	.power_down		= ath10k_usb_hif_power_down,
-- 
2.7.4
