Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7BAC23E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 23:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404397AbfIFVy1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 17:54:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404236AbfIFVy1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 17:54:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id q14so7988109wrm.9
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2019 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leeQnibrGjVek5bG1abJ4jTx9dAaPgO2nMR8X0LXbwQ=;
        b=trE7xY9GPQv2iuCLVqox8AQq0Lsf5NU9QJTAcp2BC6+wmFEmDTXcTLyfGbivZ3e7+6
         d0BaDWT5Sqzicra5tIq0l2BkBpN32JKRwWbenNGwSK7wtXpafDd3vu/qHD80rgglhW3B
         obcgHje2W9Sqa0wzhjRvlEW9I7ycFc670oSoMhKb/FjSzNOC8/gCJbl/vItZl+KoE7wZ
         pra5UZJMvNQj+hE2EL8eLh4EysMCWds3zebIwIrWi4/4Ohz7SM6RUBKMS6H187ETnNtF
         6GNkIY0t61sSw+fUGl9Pwl2I3dUSrJn2H15VR1R2pmAPypjrB+4N4SLMevHTisyaBBP9
         +HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=leeQnibrGjVek5bG1abJ4jTx9dAaPgO2nMR8X0LXbwQ=;
        b=L4A3zpGrWVFl9DTjfaTckMNiHY1orihjxIZHaIG36TI/H1wEppSlfFLEVQ4TBtkDLF
         L6c4IbZ66SP5RKKgxZ2yY34MM6QjFkkhNNG+d76ctb3/fljikI9lGGhFqjtIzSkfJhVH
         yUp2VQydDpV6iD0z9t9/UK5spXxAYk4R8LWb6GMzMo7WceAeah+Dm/eoCvlKvqPyZsiK
         iUL+hgdrQ84vrFW7WGbVs1zE1rR6Y0Wa6fD3dTNkOlOtC/uHlSex6oru4Gp9gt92yVqH
         nSeamZ+1Sag7X+qX/GsGIYoJgmyJCWAkISvEXcyqaivEvDwSQdGaNekVGH31oUSttQi1
         NoAw==
X-Gm-Message-State: APjAAAUyoNAfWAZZlqxMP3oZ1qp/Qoy8xpzVfs+Dj/VMqZyDaHAf4wXN
        MMK5AXUVeU6a6ksss9xj5Xv9lWbd
X-Google-Smtp-Source: APXvYqwjNxT0UzdDs3WrSxxQ0dcEXEjQWUW6TZQ0dwyL2czZEE5cLl/61EiChq7S+Pz/h3UJxmpidQ==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr8799749wrx.91.1567806865330;
        Fri, 06 Sep 2019 14:54:25 -0700 (PDT)
Received: from debian64.daheim (p5B0D72DC.dip0.t-ipconnect.de. [91.13.114.220])
        by smtp.gmail.com with ESMTPSA id a15sm1923314wmj.25.2019.09.06.14.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 14:54:24 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.92.1)
        (envelope-from <chunkeey@gmail.com>)
        id 1i6MBT-00069E-Uy; Fri, 06 Sep 2019 23:54:23 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
Date:   Fri,  6 Sep 2019 23:54:23 +0200
Message-Id: <20190906215423.23589-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch restores the old behavior that read
the chip_id on the QCA988x before resetting the
chip. This needs to be done in this order since
the unsupported QCA988x AR1A chips fall off the
bus when resetted. Otherwise the next MMIO Op
after the reset causes a BUS ERROR and panic.

Cc: stable@vger.kernel.org
Fixes: 1a7fecb766c8 ("ath10k: reset chip before reading chip_id in probe")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/wireless/ath/ath10k/pci.c | 36 +++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index a0b4d265c6eb..347bb92e4130 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -3490,7 +3490,7 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
 	struct ath10k_pci *ar_pci;
 	enum ath10k_hw_rev hw_rev;
 	struct ath10k_bus_params bus_params = {};
-	bool pci_ps;
+	bool pci_ps, is_qca988x = false;
 	int (*pci_soft_reset)(struct ath10k *ar);
 	int (*pci_hard_reset)(struct ath10k *ar);
 	u32 (*targ_cpu_to_ce_addr)(struct ath10k *ar, u32 addr);
@@ -3500,6 +3500,7 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
 	case QCA988X_2_0_DEVICE_ID:
 		hw_rev = ATH10K_HW_QCA988X;
 		pci_ps = false;
+		is_qca988x = true;
 		pci_soft_reset = ath10k_pci_warm_reset;
 		pci_hard_reset = ath10k_pci_qca988x_chip_reset;
 		targ_cpu_to_ce_addr = ath10k_pci_qca988x_targ_cpu_to_ce_addr;
@@ -3619,25 +3620,34 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
 		goto err_deinit_irq;
 	}
 
+	bus_params.dev_type = ATH10K_DEV_TYPE_LL;
+	bus_params.link_can_suspend = true;
+	/* Read CHIP_ID before reset to catch QCA9880-AR1A v1 devices that
+	 * fall off the bus during chip_reset. These chips have the same pci
+	 * device id as the QCA9880 BR4A or 2R4E. So that's why the check.
+	 */
+	if (is_qca988x) {
+		bus_params.chip_id =
+			ath10k_pci_soc_read32(ar, SOC_CHIP_ID_ADDRESS);
+		if (bus_params.chip_id != 0xffffffff) {
+			if (!ath10k_pci_chip_is_supported(pdev->device,
+							  bus_params.chip_id))
+				goto err_unsupported;
+		}
+	}
+
 	ret = ath10k_pci_chip_reset(ar);
 	if (ret) {
 		ath10k_err(ar, "failed to reset chip: %d\n", ret);
 		goto err_free_irq;
 	}
 
-	bus_params.dev_type = ATH10K_DEV_TYPE_LL;
-	bus_params.link_can_suspend = true;
 	bus_params.chip_id = ath10k_pci_soc_read32(ar, SOC_CHIP_ID_ADDRESS);
-	if (bus_params.chip_id == 0xffffffff) {
-		ath10k_err(ar, "failed to get chip id\n");
-		goto err_free_irq;
-	}
+	if (bus_params.chip_id == 0xffffffff)
+		goto err_unsupported;
 
-	if (!ath10k_pci_chip_is_supported(pdev->device, bus_params.chip_id)) {
-		ath10k_err(ar, "device %04x with chip_id %08x isn't supported\n",
-			   pdev->device, bus_params.chip_id);
+	if (!ath10k_pci_chip_is_supported(pdev->device, bus_params.chip_id))
 		goto err_free_irq;
-	}
 
 	ret = ath10k_core_register(ar, &bus_params);
 	if (ret) {
@@ -3647,6 +3657,10 @@ static int ath10k_pci_probe(struct pci_dev *pdev,
 
 	return 0;
 
+err_unsupported:
+	ath10k_err(ar, "device %04x with chip_id %08x isn't supported\n",
+		   pdev->device, bus_params.chip_id);
+
 err_free_irq:
 	ath10k_pci_free_irq(ar);
 	ath10k_pci_rx_retry_sync(ar);
-- 
2.23.0

