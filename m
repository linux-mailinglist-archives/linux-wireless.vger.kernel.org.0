Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69571244542
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgHNHKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:10:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29707 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNHKo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389043; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=a9v10HiPtGDV3zC4GDnuaMdBcfTmnynAeS608UjP4Kk=; b=GGnuo8gG6uGxEo4RDEuXqFUCcfHWLBnZsT+O4KomMjISiHZhGeG7XoJmpHRKmKkgPP0HOqe9
 WtS4SJ2J81stX/l8tke2rPC2uqgYvqAZznbhUY6WWPyvqahKqkmLm19ZcT3flgUaqZZu6aDz
 90qoEZZ/epbzeTLEkAMJ73CBWLo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f3638f23f2ce110208a33e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95BACC433CA; Fri, 14 Aug 2020 07:10:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A63E3C433CB;
        Fri, 14 Aug 2020 07:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A63E3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/11] ath11k: configure copy engine msi address in CE srng
Date:   Fri, 14 Aug 2020 10:10:24 +0300
Message-Id: <1597389030-13887-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

Fill msi base address and msi data to be programmed in CE srang.
This is used by the srng to generate the msi interrupt.

Needed for PCI support.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c  | 30 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hal.h |  2 ++
 drivers/net/wireless/ath/ath11k/hif.h | 26 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.c | 25 +++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 2fff171b35f8..a457fe7f7049 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -5,6 +5,7 @@
 
 #include "dp_rx.h"
 #include "debug.h"
+#include "hif.h"
 
 static const struct ce_attr host_ce_config_wlan[] = {
 	/* CE0: host->target HTC control and raw streams */
@@ -352,6 +353,31 @@ static void ath11k_ce_send_done_cb(struct ath11k_ce_pipe *pipe)
 	}
 }
 
+static void ath11k_ce_srng_msi_ring_params_setup(struct ath11k_base *ab, u32 ce_id,
+						 struct hal_srng_params *ring_params)
+{
+	u32 msi_data_start;
+	u32 msi_data_count;
+	u32 msi_irq_start;
+	u32 addr_lo;
+	u32 addr_hi;
+	int ret;
+
+	ret = ath11k_get_user_msi_vector(ab, "CE",
+					 &msi_data_count, &msi_data_start,
+					 &msi_irq_start);
+
+	if (ret)
+		return;
+
+	ath11k_get_msi_address(ab, &addr_lo, &addr_hi);
+
+	ring_params->msi_addr = addr_lo;
+	ring_params->msi_addr |= (dma_addr_t)(((uint64_t)addr_hi) << 32);
+	ring_params->msi_data = (ce_id % msi_data_count) + msi_data_start;
+	ring_params->flags |= HAL_SRNG_FLAGS_MSI_INTR;
+}
+
 static int ath11k_ce_init_ring(struct ath11k_base *ab,
 			       struct ath11k_ce_ring *ce_ring,
 			       int ce_id, enum hal_ring_type type)
@@ -395,6 +421,10 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 			    ret, ce_id);
 		return ret;
 	}
+
+	if (!(CE_ATTR_DIS_INTR & host_ce_config_wlan[ce_id].flags))
+		ath11k_ce_srng_msi_ring_params_setup(ab, ce_id, &params);
+
 	ce_ring->hal_ring_id = ret;
 
 	return 0;
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 780a3e11b609..6d9a6938870c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -458,6 +458,8 @@ struct hal_srng_params {
 	u32 flags;
 	u32 max_buffer_len;
 	u32 low_threshold;
+	dma_addr_t msi_addr;
+	u32 msi_data;
 
 	/* Add more params as needed */
 };
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index 48ee55cebc81..dbe5568916e8 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -19,6 +19,11 @@ struct ath11k_hif_ops {
 	void (*power_down)(struct ath11k_base *sc);
 	int (*map_service_to_pipe)(struct ath11k_base *sc, u16 service_id,
 				   u8 *ul_pipe, u8 *dl_pipe);
+	int (*get_user_msi_vector)(struct ath11k_base *ab, char *user_name,
+				   int *num_vectors, u32 *user_base_data,
+				   u32 *base_vector);
+	void (*get_msi_address)(struct ath11k_base *ab, u32 *msi_addr_lo,
+				u32 *msi_addr_hi);
 };
 
 static inline int ath11k_hif_start(struct ath11k_base *sc)
@@ -66,4 +71,25 @@ static inline int ath11k_hif_map_service_to_pipe(struct ath11k_base *sc, u16 ser
 {
 	return sc->hif.ops->map_service_to_pipe(sc, service_id, ul_pipe, dl_pipe);
 }
+
+static inline int ath11k_get_user_msi_vector(struct ath11k_base *ab, char *user_name,
+					     int *num_vectors, u32 *user_base_data,
+					     u32 *base_vector)
+{
+	if (!ab->hif.ops->get_user_msi_vector)
+		return -EOPNOTSUPP;
+
+	return ab->hif.ops->get_user_msi_vector(ab, user_name, num_vectors,
+						user_base_data,
+						base_vector);
+}
+
+static inline void ath11k_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+					  u32 *msi_addr_hi)
+{
+	if (!ab->hif.ops->get_msi_address)
+		return;
+
+	ab->hif.ops->get_msi_address(ab, msi_addr_lo, msi_addr_hi);
+}
 #endif /* _HIF_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 10c281ece3d4..af08f0542867 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -339,6 +339,18 @@ int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
 	return pci_irq_vector(pci_dev, vector);
 }
 
+static void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
+				       u32 *msi_addr_hi)
+{
+	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
+
+	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
+			      msi_addr_lo);
+
+	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
+			      msi_addr_hi);
+}
+
 int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
 				       int *num_vectors, u32 *user_base_data,
 				       u32 *base_vector)
@@ -366,6 +378,17 @@ int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_nam
 	return -EINVAL;
 }
 
+static int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
+					  int *num_vectors, u32 *user_base_data,
+					  u32 *base_vector)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+
+	return ath11k_pci_get_user_msi_assignment(ab_pci, user_name,
+						  num_vectors, user_base_data,
+						  base_vector);
+}
+
 static void ath11k_pci_free_irq(struct ath11k_base *ab)
 {
 	int i, irq_idx;
@@ -634,6 +657,8 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.write32 = ath11k_pci_write32,
 	.power_down = ath11k_pci_power_down,
 	.power_up = ath11k_pci_power_up,
+	.get_msi_address =  ath11k_pci_get_msi_address,
+	.get_user_msi_vector = ath11k_get_user_msi_assignment,
 };
 
 static int ath11k_pci_probe(struct pci_dev *pdev,
-- 
2.7.4

