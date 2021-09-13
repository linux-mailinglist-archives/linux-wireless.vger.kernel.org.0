Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E288409BD9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbhIMSKx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 14:10:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:60966 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbhIMSKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 14:10:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631556576; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UDyTXV2qIFPeqGGM5DT0KdVaxQKpk0kdL/OeV+VHVSo=; b=UtVTH6qkvpWKzPOaTtjQ80ifBF6mMCAgr2Pn4CM6nxL3yxSrqJNyghVgxe1CE9Odi+pIIu+s
 N/BwADf3PY1fyUob0ootyZWnWiVeDKjftm9gy/1/tC5G+CF50VPZ5clJ+Jz5fBJW8UkAxjz4
 gogEalt1+Wh3CRr0SWdQWSaSHcY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 613f93ce8b04ef85890d0fde (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 18:09:18
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E355C4360D; Mon, 13 Sep 2021 18:09:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48BDEC43460;
        Mon, 13 Sep 2021 18:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 48BDEC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/3] ath11k: Split PCI write/read functions
Date:   Mon, 13 Sep 2021 21:09:00 +0300
Message-Id: <20210913180902.193874-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913180902.193874-1-jouni@codeaurora.org>
References: <20210913180902.193874-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

ath11k_pci_write32/read32 tries to wake up MHI before doing actual
write/read work, which means each time a u32 is written/read, MHI
wake up is performed. This is not necessary in case where we do a
large amount of write/read, cause only one time of wake up is needed.
So split each one into two parts, the first part does MHI get/put
and the second one does actual write/read work.

Also avoid the put operation if the previous get operation fails.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 61 ++++++++++++++++++---------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 1094b53465bc..5c3ec3e7be89 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -174,18 +174,11 @@ static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
 	return window_start;
 }
 
-void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
+void ath11k_pci_do_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	u32 window_start;
 
-	/* for offset beyond BAR + 4K - 32, may
-	 * need to wakeup MHI to access.
-	 */
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
-
 	if (offset < WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
 	} else {
@@ -205,23 +198,33 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 				  (offset & WINDOW_RANGE_MASK));
 		}
 	}
-
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 }
 
-u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
+void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 val, window_start;
+	bool wakeup_required;
+	int ret;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
 	 */
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
-		mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+	wakeup_required = test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+			  offset >= ACCESS_ALWAYS_OFF;
+
+	if (wakeup_required)
+		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
+	ath11k_pci_do_write32(ab, offset, value);
+
+	if (wakeup_required && !ret)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+}
+
+u32 ath11k_pci_do_read32(struct ath11k_base *ab, u32 offset)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 val, window_start;
 
 	if (offset < WINDOW_START) {
 		val = ioread32(ab->mem + offset);
@@ -243,8 +246,28 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 		}
 	}
 
-	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
-	    offset >= ACCESS_ALWAYS_OFF)
+	return val;
+}
+
+u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 val;
+	bool wakeup_required;
+	int ret;
+
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	wakeup_required = test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+			  offset >= ACCESS_ALWAYS_OFF;
+
+	if (wakeup_required)
+		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+
+	val = ath11k_pci_do_read32(ab, offset);
+
+	if (wakeup_required && !ret)
 		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
 
 	return val;
-- 
2.25.1

