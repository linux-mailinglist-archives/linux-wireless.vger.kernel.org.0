Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911C8587876
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Aug 2022 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiHBH4D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Aug 2022 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbiHBH4C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Aug 2022 03:56:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7FB2E6BF
        for <linux-wireless@vger.kernel.org>; Tue,  2 Aug 2022 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659426961; x=1690962961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L7wehxwo2U4THl3vfC1UiBBQ5QlZao47W91wbvTcau0=;
  b=FXIFbpHcNvCayH4LwbFUt5BXIMQckevXe++7OWWkBn6YrdBeIbx3ANfW
   K4HnnLwcMaj7P7UcKIzfki6R9wOOHbliwN+EtHeTmZDRtzbAAeZOkWMzO
   UG3c78I18db4O5dTZcFJIT5zQMLl6cMZ3Ygzky1tM9yVQk6rJ3UmYSxjy
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 02 Aug 2022 00:56:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 00:56:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 00:56:00 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 2 Aug 2022 00:55:58 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/2] wifi: ath11k: Implement sram dump interface
Date:   Tue, 2 Aug 2022 15:55:33 +0800
Message-ID: <20220802075533.1744-3-quic_bqiang@quicinc.com>
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

Currently this feature is enabled for QCA6390/WCN6855.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
  1: rebased on latest ath.git

 drivers/net/wireless/ath/ath11k/core.c    |  7 +++
 drivers/net/wireless/ath/ath11k/debugfs.c | 62 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hif.h     | 10 ++++
 drivers/net/wireless/ath/ath11k/hw.c      | 10 ++++
 drivers/net/wireless/ath/ath11k/hw.h      |  9 ++++
 drivers/net/wireless/ath/ath11k/pci.c     |  1 +
 drivers/net/wireless/ath/ath11k/pcic.c    | 29 +++++++++++
 drivers/net/wireless/ath/ath11k/pcic.h    |  1 +
 8 files changed, 129 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c3e9e4f7bc24..44003d39ff7b 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -106,6 +106,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.sram_dump = NULL,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -177,6 +178,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.sram_dump = NULL,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -247,6 +249,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.sram_dump = &sram_dump_qca6390,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -317,6 +320,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = false,
+		.sram_dump = NULL,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -387,6 +391,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.sram_dump = &sram_dump_wcn6855,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -456,6 +461,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = false,
 		.fixed_fw_mem = false,
 		.support_off_channel_tx = true,
+		.sram_dump = &sram_dump_wcn6855,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -525,6 +531,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.hybrid_bus_type = true,
 		.fixed_fw_mem = true,
 		.support_off_channel_tx = false,
+		.sram_dump = NULL,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 9648e0017393..ff7b35ac4154 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -14,6 +14,7 @@
 #include "dp_tx.h"
 #include "debugfs_htt_stats.h"
 #include "peer.h"
+#include "hif.h"
 
 static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
 	"REO2SW1_RING",
@@ -982,6 +983,63 @@ static const struct file_operations fops_fw_dbglog = {
 	.llseek = default_llseek,
 };
 
+static int ath11k_open_sram_dump(struct inode *inode, struct file *file)
+{
+	struct ath11k_base *ab = inode->i_private;
+	u8 *buf;
+	u32 start, end;
+	int ret;
+
+	start = ab->hw_params.sram_dump->start;
+	end = ab->hw_params.sram_dump->end;
+
+	buf = vmalloc(end - start + 1);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = ath11k_hif_dump_sram(ab, buf, start, end);
+	if (ret) {
+		ath11k_err(ab, "failed to dump sram: %d\n", ret);
+		vfree(buf);
+		return ret;
+	}
+
+	file->private_data = buf;
+	return 0;
+}
+
+static ssize_t ath11k_read_sram_dump(struct file *file,
+				     char __user *user_buf,
+				     size_t count, loff_t *ppos)
+{
+	struct ath11k_base *ab = file->f_inode->i_private;
+	const char *buf = file->private_data;
+	int len;
+	u32 start, end;
+
+	start = ab->hw_params.sram_dump->start;
+	end = ab->hw_params.sram_dump->end;
+	len = end - start + 1;
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static int ath11k_release_sram_dump(struct inode *inode, struct file *file)
+{
+	vfree(file->private_data);
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static const struct file_operations fops_sram_dump = {
+	.open = ath11k_open_sram_dump,
+	.read = ath11k_read_sram_dump,
+	.release = ath11k_release_sram_dump,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 {
 	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
@@ -997,6 +1055,10 @@ int ath11k_debugfs_pdev_create(struct ath11k_base *ab)
 	debugfs_create_file("soc_dp_stats", 0600, ab->debugfs_soc, ab,
 			    &fops_soc_dp_stats);
 
+	if (ab->hw_params.sram_dump)
+		debugfs_create_file("sram", 0400, ab->debugfs_soc, ab,
+				    &fops_sram_dump);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index e9366f786fbb..8fcf7500e5c6 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -29,6 +29,7 @@ struct ath11k_hif_ops {
 	void (*ce_irq_enable)(struct ath11k_base *ab);
 	void (*ce_irq_disable)(struct ath11k_base *ab);
 	void (*get_ce_msi_idx)(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
+	int (*dump_sram)(struct ath11k_base *ab, u8 *buf, u32 start, u32 end);
 };
 
 static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
@@ -134,4 +135,13 @@ static inline void ath11k_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id,
 	else
 		*msi_data_idx = ce_id;
 }
+
+static inline int ath11k_hif_dump_sram(struct ath11k_base *ab, u8 *buf,
+				       u32 start, u32 end)
+{
+	if (!ab->hif.ops->dump_sram)
+		return -EOPNOTSUPP;
+
+	return ab->hif.ops->dump_sram(ab, buf, start, end);
+}
 #endif /* _HIF_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 96db85c55585..ff30ba852200 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2359,3 +2359,13 @@ const struct cfg80211_sar_capa ath11k_hw_sar_capa_wcn6855 = {
 	.num_freq_ranges = (ARRAY_SIZE(ath11k_hw_sar_freq_ranges_wcn6855)),
 	.freq_ranges = ath11k_hw_sar_freq_ranges_wcn6855,
 };
+
+const struct ath11k_hw_sram_dump sram_dump_qca6390 = {
+	.start = 0x01400000,
+	.end = 0x0171ffff,
+};
+
+const struct ath11k_hw_sram_dump sram_dump_wcn6855 = {
+	.start = 0x01400000,
+	.end = 0x0177ffff,
+};
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index bb5ac940e470..2c3988e03aae 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -126,6 +126,11 @@ struct ath11k_hw_hal_params {
 	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
 };
 
+struct ath11k_hw_sram_dump {
+	u32 start;
+	u32 end;
+};
+
 struct ath11k_hw_params {
 	const char *name;
 	u16 hw_rev;
@@ -200,6 +205,7 @@ struct ath11k_hw_params {
 	bool hybrid_bus_type;
 	bool fixed_fw_mem;
 	bool support_off_channel_tx;
+	const struct ath11k_hw_sram_dump *sram_dump;
 };
 
 struct ath11k_hw_ops {
@@ -397,4 +403,7 @@ static inline const char *ath11k_bd_ie_type_str(enum ath11k_bd_ie_type type)
 }
 
 extern const struct cfg80211_sar_capa ath11k_hw_sar_capa_wcn6855;
+
+extern const struct ath11k_hw_sram_dump sram_dump_qca6390;
+extern const struct ath11k_hw_sram_dump sram_dump_wcn6855;
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5bd34a6273d9..f853bf4a12c7 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -697,6 +697,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pcic_get_ce_msi_idx,
+	.dump_sram = ath11k_pcic_dump_sram,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 15ca069e501f..c9027eafe65b 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -203,6 +203,35 @@ u32 ath11k_pcic_read32(struct ath11k_base *ab, u32 offset)
 }
 EXPORT_SYMBOL(ath11k_pcic_read32);
 
+int ath11k_pcic_dump_sram(struct ath11k_base *ab, u8 *buf,
+			  u32 start, u32 end)
+{
+	int ret = 0;
+	bool wakeup_required;
+	u32 *data = (u32 *)buf;
+	u32 i;
+
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup the device to access.
+	 */
+	wakeup_required = test_bit(ATH11K_FLAG_DEVICE_INIT_DONE, &ab->dev_flags) &&
+			  end >= ATH11K_PCI_ACCESS_ALWAYS_OFF;
+	if (wakeup_required && ab->pci.ops->wakeup) {
+		ret = ab->pci.ops->wakeup(ab);
+		if (ret)
+			ath11k_warn(ab, "%s: failed to do wakeup: %d\n", __func__, ret);
+	}
+
+	for (i = start; i < end + 1; i += 4)
+		*data++ = ath11k_pcic_do_read32(ab, i);
+
+	if (wakeup_required && !ret && ab->pci.ops->release)
+		ab->pci.ops->release(ab);
+
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_pcic_dump_sram);
+
 void ath11k_pcic_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
 				 u32 *msi_addr_hi)
 {
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
index 0afbb34510db..40353246ab0b 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.h
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -45,4 +45,5 @@ void ath11k_pcic_ce_irq_disable_sync(struct ath11k_base *ab);
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab);
 int ath11k_pcic_register_pci_ops(struct ath11k_base *ab,
 				 const struct ath11k_pci_ops *pci_ops);
+int ath11k_pcic_dump_sram(struct ath11k_base *ab, u8 *buf, u32 start, u32 end);
 #endif
-- 
2.25.1

