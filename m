Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29E629AC38
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 13:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900069AbgJ0MiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 08:38:15 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:24295 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900053AbgJ0MiO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 08:38:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603802293; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=V3B2/w4nojW/BIyrD+yw3GxeP7TNfmN9cjVnPpHBmfI=; b=RmPX+xjy5fOOlVl930UnoAfymaGCcWRTWLuId0//MFXAXyY5lE/9rzG91Cp1NhvH6APbdvlw
 Xye72ezrOnr/u7mTUuQHFC1FKhiVhNsDoDKYjU2M2Bw0uy3vj+IfwJAogho0ae4lLGtz6R4W
 UaYyv83cjwcU58UlhsU57WAkEM4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f9814b4856acb9b0944aa0c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 12:38:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6DEAEC433CB; Tue, 27 Oct 2020 12:38:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 097B7C433FE;
        Tue, 27 Oct 2020 12:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 097B7C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] ath10k: remove repeated words in comments
Date:   Tue, 27 Oct 2020 14:38:07 +0200
Message-Id: <1603802288-21158-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Found by latest checkpatch.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c    | 2 +-
 drivers/net/wireless/ath/ath10k/debug.c   | 2 +-
 drivers/net/wireless/ath/ath10k/mac.c     | 2 +-
 drivers/net/wireless/ath/ath10k/rx_desc.h | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c    | 2 +-
 drivers/net/wireless/ath/ath10k/wmi.h     | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index d73ad60b571c..419b06b974c5 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2636,7 +2636,7 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		if (status)
 			goto err;
 
-		/* Some of of qca988x solutions are having global reset issue
+		/* Some of qca988x solutions are having global reset issue
 		 * during target initialization. Bypassing PLL setting before
 		 * downloading firmware and letting the SoC run on REF_CLK is
 		 * fixing the problem. Corresponding firmware change is also
diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index e8250a665433..b72cd81fdc79 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1764,7 +1764,7 @@ static ssize_t ath10k_write_simulate_radar(struct file *file,
 	struct ath10k *ar = file->private_data;
 	struct ath10k_vif *arvif;
 
-	/* Just check for for the first vif alone, as all the vifs will be
+	/* Just check for the first vif alone, as all the vifs will be
 	 * sharing the same channel and if the channel is disabled, all the
 	 * vifs will share the same 'is_started' state.
 	 */
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 2e3eb5bbe49c..c857cf46832d 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5457,7 +5457,7 @@ static int ath10k_add_interface(struct ieee80211_hw *hw,
 	/* Some firmware revisions don't wait for beacon tx completion before
 	 * sending another SWBA event. This could lead to hardware using old
 	 * (freed) beacon data in some cases, e.g. tx credit starvation
-	 * combined with missed TBTT. This is very very rare.
+	 * combined with missed TBTT. This is very rare.
 	 *
 	 * On non-IOMMU-enabled hosts this could be a possible security issue
 	 * because hw could beacon some random data on the air.  On
diff --git a/drivers/net/wireless/ath/ath10k/rx_desc.h b/drivers/net/wireless/ath/ath10k/rx_desc.h
index dec1582005b9..f2b6bf8f0d60 100644
--- a/drivers/net/wireless/ath/ath10k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath10k/rx_desc.h
@@ -68,7 +68,7 @@ struct rx_attention {
  *		first_msdu is set.
  *
  * peer_idx_invalid
- *		Indicates no matching entries within the the max search
+ *		Indicates no matching entries within the max search
  *		count.  Only set when first_msdu is set.
  *
  * peer_idx_timeout
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 81ddaafb6721..59043ec44ca3 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1248,7 +1248,7 @@ static int ath10k_sdio_bmi_exchange_msg(struct ath10k *ar,
 	 *        Wait for first 4 bytes to be in FIFO
 	 *        If CONSERVATIVE_BMI_READ is enabled, also wait for
 	 *        a BMI command credit, which indicates that the ENTIRE
-	 *        response is available in the the FIFO
+	 *        response is available in the FIFO
 	 *
 	 *  CASE 3: length > 128
 	 *        Wait for the first 4 bytes to be in FIFO
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 4898e19b0af6..11300b1320a9 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3832,7 +3832,7 @@ enum wmi_pdev_param {
 	WMI_PDEV_PARAM_BEACON_TX_MODE,
 	/*
 	 * Resource manager off chan mode .
-	 * 0: turn off off chan mode. 1: turn on offchan mode
+	 * 0: turn off offchan mode. 1: turn on offchan mode
 	 */
 	WMI_PDEV_PARAM_RESMGR_OFFCHAN_MODE,
 	/*
@@ -3936,7 +3936,7 @@ enum wmi_10x_pdev_param {
 	WMI_10X_PDEV_PARAM_BEACON_TX_MODE,
 	/*
 	 * Resource manager off chan mode .
-	 * 0: turn off off chan mode. 1: turn on offchan mode
+	 * 0: turn off offchan mode. 1: turn on offchan mode
 	 */
 	WMI_10X_PDEV_PARAM_RESMGR_OFFCHAN_MODE,
 	/*
-- 
2.7.4

