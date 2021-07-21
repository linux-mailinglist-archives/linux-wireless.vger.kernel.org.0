Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85593D18F4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGUUkc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:59079 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhGUUkb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902467; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=rv28mMf7EAoTf+QMmrPQVfxSE7SmZkAx/KPPUeILmv8=; b=vSvmVWC/s87T4HSwEVC2hZPk39LNKqw017+PDAnCjRqkatNRXbCNJN3rggTCLzZWZFEHkLT8
 mTLmp7lRtECSEegvG5sR4IesR/T4bNDPttU/a+GSockKubJ/ppxSdU5NiyW3LefTAdhTbD0h
 bIESymq6KblUC9K2zBtQtBC1V70=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f88fb91dd16c8788c375a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:20:57
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40DA3C43460; Wed, 21 Jul 2021 21:20:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3650AC43460;
        Wed, 21 Jul 2021 21:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3650AC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 06/12] ath11k: Assign free_vdev_map value before ieee80211_register_hw
Date:   Thu, 22 Jul 2021 00:20:23 +0300
Message-Id: <20210721212029.142388-6-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

Firmware crash is seen randomly, because of sending wrong vdev_id
in vdev_create command. This is due to free_vdev_map value being 0.
free_vdev_map is getting assigned after ieee80211_register_hw. In
some race conditions, add_interface api is getting called before
assigning value to free_vdev_map. Fix this by assigning free_vdev_map
before ieee80211_register_hw.

Also, moved ar->cc_freq_hz and ar->txmgmt_idr initialization before
ieee80211_register_hw to avoid such race conditions.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00948-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7751ecb2ad81..20121479af6e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -7599,6 +7599,10 @@ int ath11k_mac_register(struct ath11k_base *ab)
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
 		return 0;
 
+	/* Initialize channel counters frequency value in hertz */
+	ab->cc_freq_hz = IPQ8074_CC_FREQ_HERTZ;
+	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
+
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
@@ -7609,18 +7613,14 @@ int ath11k_mac_register(struct ath11k_base *ab)
 			ar->mac_addr[4] += i;
 		}
 
+		idr_init(&ar->txmgmt_idr);
+		spin_lock_init(&ar->txmgmt_idr_lock);
+
 		ret = __ath11k_mac_register(ar);
 		if (ret)
 			goto err_cleanup;
-
-		idr_init(&ar->txmgmt_idr);
-		spin_lock_init(&ar->txmgmt_idr_lock);
 	}
 
-	/* Initialize channel counters frequency value in hertz */
-	ab->cc_freq_hz = IPQ8074_CC_FREQ_HERTZ;
-	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
-
 	return 0;
 
 err_cleanup:
-- 
2.25.1

