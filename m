Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3B2C4E7E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 06:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgKZFoU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Nov 2020 00:44:20 -0500
Received: from z5.mailgun.us ([104.130.96.5]:25140 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730615AbgKZFoT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Nov 2020 00:44:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606369459; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=iU4cGrL0wyqT1L58w05ObFYpTDM5QzwfhxQ4GGiyrsA=; b=i2KqD5yV5HUwOxCYu9/AuajcQi6Ru3DncatyMhf3Ns15GyQvYnQyH+bMcU7sVbw1mQJ1pVp4
 0AQH8OZ0YRjoc5BINOl4WVpOdAIXiJUB8FeunwTqiU23BjM/JYJEWIzuJIBcx3SYELbKO7Pp
 LQAJ+9JIMr09KpxQFAY/d/g1Lrs=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fbf40b29e87e1635268533d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Nov 2020 05:44:18
 GMT
Sender: seevalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0C3CC433ED; Thu, 26 Nov 2020 05:44:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from CHECSTLC0020039-LIN.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B239EC433C6;
        Thu, 26 Nov 2020 05:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B239EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=seevalam@codeaurora.org
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH] ath11k: Ignore resetting peer auth flag in peer assoc cmd
Date:   Thu, 26 Nov 2020 11:13:34 +0530
Message-Id: <1606369414-25211-1-git-send-email-seevalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Incase of hardware encryption, WMI_PEER_AUTH flag will be set by firmware
during install key. Since install key wont be done for software encryption
mode, firmware will not set this flag. Due to this, seeing traffic failure
in software encryption. Hence, avoid resetting peer auth flag if hardware
encryption disabled.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01421-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index bca66c1..9bd4284 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1686,7 +1686,8 @@ int ath11k_wmi_vdev_install_key(struct ath11k *ar,
 
 static inline void
 ath11k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
-			   struct peer_assoc_params *param)
+			   struct peer_assoc_params *param,
+			   bool hw_crypto_disabled)
 {
 	cmd->peer_flags = 0;
 
@@ -1740,7 +1741,8 @@ ath11k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 		cmd->peer_flags |= WMI_PEER_AUTH;
 	if (param->need_ptk_4_way) {
 		cmd->peer_flags |= WMI_PEER_NEED_PTK_4_WAY;
-		cmd->peer_flags &= ~WMI_PEER_AUTH;
+		if (!hw_crypto_disabled)
+			cmd->peer_flags &= ~WMI_PEER_AUTH;
 	}
 	if (param->need_gtk_2_way)
 		cmd->peer_flags |= WMI_PEER_NEED_GTK_2_WAY;
@@ -1807,7 +1809,9 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	cmd->peer_new_assoc = param->peer_new_assoc;
 	cmd->peer_associd = param->peer_associd;
 
-	ath11k_wmi_copy_peer_flags(cmd, param);
+	ath11k_wmi_copy_peer_flags(cmd, param,
+				   test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED,
+					    &ar->ab->dev_flags));
 
 	ether_addr_copy(cmd->peer_macaddr.addr, param->peer_mac);
 
-- 
2.7.4

