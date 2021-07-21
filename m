Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C03D18F1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhGUUkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:20 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59079 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGUUkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902456; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=48LHo3wNgwwVhG80VEPTkY7graAWuPWEySqLrtrRA8Y=; b=Ad1XuNH3oIijDwSDcotalLcHFchgOwMuNyCpZsTaEc9J7icFTSn/LEOXSFJ6B/cnzKkd7Z45
 n1gw/WoDGUaksXmqRd/lK2xLRWXnqzP9taSNNpltMdCoato3AqzeOIQ2he8xkubOVlNiL8yv
 qTnfGsOUd3fa3xlGjRjElKkMKhM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60f88fb74815712f3ad50dce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:20:55
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75ADCC433F1; Wed, 21 Jul 2021 21:20:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD0ECC4323A;
        Wed, 21 Jul 2021 21:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD0ECC4323A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 05/12] ath11k: Add vdev start flag to disable hardware encryption
Date:   Thu, 22 Jul 2021 00:20:22 +0300
Message-Id: <20210721212029.142388-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

Firmware blocks all data traffic until the key is plumbed. But, with
software encryption mode, key is never plumbed to firmware. Due to this,
a traffic failure in software encryption mode has been observed. Hence,
firmware has introduced a flag to differentiate software encryption
mode. This flag can be passed during vdev_start command.

Enable WMI_VDEV_START_HW_ENCRYPTION_DISABLED flag in vdev_start command
to notify firmware to disable hardware encryption for a vdev. This is set
if raw mode software encryption is enabled.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01421-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 ++
 drivers/net/wireless/ath/ath11k/wmi.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 43344e774a31..020b2b7ee3c8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -884,6 +884,8 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	}
 
 	cmd->flags |= WMI_VDEV_START_LDPC_RX_ENABLED;
+	if (test_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags))
+		cmd->flags |= WMI_VDEV_START_HW_ENCRYPTION_DISABLED;
 
 	ptr = skb->data + sizeof(*cmd);
 	chan = ptr;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 1fff74b2b476..16b3f48bb378 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2577,6 +2577,7 @@ struct wmi_vdev_down_cmd {
 #define WMI_VDEV_START_HIDDEN_SSID  BIT(0)
 #define WMI_VDEV_START_PMF_ENABLED  BIT(1)
 #define WMI_VDEV_START_LDPC_RX_ENABLED BIT(3)
+#define WMI_VDEV_START_HW_ENCRYPTION_DISABLED BIT(4)
 
 struct wmi_ssid {
 	u32 ssid_len;
-- 
2.25.1

