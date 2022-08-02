Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9547D587874
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiHBH4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiHBHz7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 03:55:59 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB132F039
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 00:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659426958; x=1690962958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2OVORaTVItjsSXwRIf9omLMX8UTzvsqWk2fA5aAbF5g=;
  b=zgx4MlO5zLhOLauVPD2XDj08uD8C1lBVTcVPkgQrV/OfWDIl64SuyVvu
   J/5qlDaQRugaHFYbrE3deXK/H2ZArtx/xKTmR2WxZ+ydGdfTMj4uwUcvd
   NnS8NOrUMNtRBicQi8ij0v7ZB3NiqjYmCbX1wZXweYWc9uTxqkGF6gUli
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Aug 2022 00:55:58 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:55:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 00:55:58 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 00:55:57 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/2] wifi: ath11k: Split PCI write/read functions
Date:   Tue, 2 Aug 2022 15:55:32 +0800
Message-ID: <20220802075533.1744-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802075533.1744-1-quic_bqiang@quicinc.com>
References: <20220802075533.1744-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k_pcic_write32/read32 tries to do wake up before doing actual
write/read work, which means each time a u32 is written/read, wake
up is performed. This is not necessary in case where we do a
large amount of write/read, because only one time of wake up is needed.
So split each one into two parts, the first part does wake up and
release, and the second one does actual write/read work.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
  1: rebased on latest ath.git

 drivers/net/wireless/ath/ath11k/pcic.c | 50 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 1adf20ebef27..15ca069e501f 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -140,49 +140,63 @@ int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
 }
 EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
 
+static void ath11k_pcic_do_write32(struct ath11k_base *ab, u32 offset, u32 value)
+{
+	if (offset < ATH11K_PCI_WINDOW_START)
+		iowrite32(value, ab->mem  + offset);
+	else
+		ab->pci.ops->window_write32(ab, offset, value);
+}
+
 void ath11k_pcic_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
 	int ret = 0;
+	bool wakeup_required;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup the device to access.
 	 */
-	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->wakeup)
+	wakeup_required = test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
+			  offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF;
+	if (wakeup_required && ab->pci.ops->wakeup)
 		ret = ab->pci.ops->wakeup(ab);
 
-	if (offset < ATH11K_PCI_WINDOW_START)
-		iowrite32(value, ab->mem  + offset);
-	else
-		ab->pci.ops->window_write32(ab, offset, value);
+	ath11k_pcic_do_write32(ab, offset, value);
 
-	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->release &&
-	    !ret)
+	if (wakeup_required && !ret && ab->pci.ops->release)
 		ab->pci.ops->release(ab);
 }
 EXPORT_SYMBOL(ath11k_pcic_write32);
 
+static u32 ath11k_pcic_do_read32(struct ath11k_base *ab, u32 offset)
+{
+	u32 val;
+
+	if (offset < ATH11K_PCI_WINDOW_START)
+		val = ioread32(ab->mem + offset);
+	else
+		val = ab->pci.ops->window_read32(ab, offset);
+
+	return val;
+}
+
 u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 {
 	int ret = 0;
 	u32 val;
+	bool wakeup_required;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup the device to access.
 	 */
-	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->wakeup)
+	wakeup_required = test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
+			  offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF;
+	if (wakeup_required && ab->pci.ops->wakeup)
 		ret = ab->pci.ops->wakeup(ab);
 
-	if (offset < ATH11K_PCI_WINDOW_START)
-		val = ioread32(ab->mem + offset);
-	else
-		val = ab->pci.ops->window_read32(ab, offset);
+	val = ath11k_pcic_do_read32(ab, offset);
 
-	if (test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
-	    offset >= ATH11K_PCI_ACCESS_ALWAYS_OFF && ab->pci.ops->release &&
-	    !ret)
+	if (wakeup_required && !ret && ab->pci.ops->release)
 		ab->pci.ops->release(ab);
 
 	return val;
-- 
2.25.1

