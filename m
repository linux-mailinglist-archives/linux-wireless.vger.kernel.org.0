Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A33409BD7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 20:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346578AbhIMSKl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 14:10:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29745 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346562AbhIMSKl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 14:10:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631556565; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IVXJisfKkO+ojMe7txf1Qnyporkoe2DhbAz2JfqYtz0=; b=SuHljFb5D37tGFLi8XRX4bMkt+88xWOECbvv6ZZTlZy76/7uXBRQfXdSMBVnrbfRhzTE6Eea
 xP0H48ZirOSacf5DeEzaKfXCsPEN4Nyr5znGpz08AnysZa1mTHzVub92QzLkQSprKC5xgymE
 526w2DTgwYbzqnaw5USF3D+vckQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 613f93d2d914b05182723f66 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 18:09:22
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 302FEC43616; Mon, 13 Sep 2021 18:09:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0022FC4360D;
        Mon, 13 Sep 2021 18:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0022FC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/3] ath11k: Implement sram dump interface
Date:   Mon, 13 Sep 2021 21:09:02 +0300
Message-Id: <20210913180902.193874-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913180902.193874-1-jouni@codeaurora.org>
References: <20210913180902.193874-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

Currently this feature is enabled for QCA6390/WCN6855.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c    |  8 +++
 drivers/net/wireless/ath/ath11k/debugfs.c | 64 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debugfs.h |  5 ++
 drivers/net/wireless/ath/ath11k/hif.h     | 10 ++++
 drivers/net/wireless/ath/ath11k/hw.c      | 10 ++++
 drivers/net/wireless/ath/ath11k/hw.h      |  8 +++
 drivers/net/wireless/ath/ath11k/pci.c     | 30 +++++++++++
 7 files changed, 135 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 59fa0ff06dff..8f09ae827170 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -81,6 +81,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.sram_dump = NULL,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -129,6 +130,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.sram_dump = NULL,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -176,6 +178,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
+		.sram_dump = &sram_dump_qca6390,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -223,6 +226,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_mem_mode = 2,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.fix_l1ss = true,
+		.sram_dump = NULL,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -269,6 +273,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.fw_mem_mode = 0,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
+		.sram_dump = &sram_dump_wcn6855,
 	},
 };
 
@@ -707,6 +712,9 @@ static int ath11k_core_soc_create(struct ath11k_base *ab)
 		goto err_debugfs_reg;
 	}
 
+	if (ab->hw_params.sram_dump)
+		ath11k_debugfs_sram_dump_create(ab);
+
 	ret = ath11k_hif_power_up(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to power up :%d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index cdc492421807..871445f4e96a 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -12,6 +12,7 @@
 #include "dp_tx.h"
 #include "debugfs_htt_stats.h"
 #include "peer.h"
+#include "hif.h"
 
 static const char *htt_bp_umac_ring[HTT_SW_UMAC_RING_IDX_MAX] = {
 	"REO2SW1_RING",
@@ -1122,3 +1123,66 @@ int ath11k_debugfs_register(struct ath11k *ar)
 void ath11k_debugfs_unregister(struct ath11k *ar)
 {
 }
+
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
+void ath11k_debugfs_sram_dump_create(struct ath11k_base *ab)
+{
+	debugfs_create_file("sram", 0400, ab->debugfs_soc, ab,
+			    &fops_sram_dump);
+}
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 47b96848cf0a..7b9c5e465208 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -147,6 +147,7 @@ static inline int ath11k_debugfs_rx_filter(struct ath11k *ar)
 
 void ath11k_debugfs_crash_trigger_create(struct ath11k_base *ab);
 void ath11k_debugfs_dp_stats_create(struct ath11k_base *ab);
+void ath11k_debugfs_sram_dump_create(struct ath11k_base *ab);
 #else
 static inline int ath11k_debugfs_soc_create(struct ath11k_base *ab)
 {
@@ -221,6 +222,10 @@ static inline void ath11k_debugfs_crash_trigger_create(struct ath11k_base *ab)
 static inline void ath11k_debugfs_dp_stats_create(struct ath11k_base *ab)
 {
 }
+
+static inline void ath11k_debugfs_sram_dump_create(struct ath11k_base *ab)
+{
+}
 #endif /* CONFIG_MAC80211_DEBUGFS*/
 
 #endif /* _ATH11K_DEBUGFS_H_ */
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
index e54b02fd2cc3..57fab9d085d0 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2124,3 +2124,13 @@ const struct ath11k_hw_regs wcn6855_regs = {
 	.pcie_qserdes_sysclk_en_sel = 0x01e0c0ac,
 	.pcie_pcs_osc_dtct_config_base = 0x01e0c628,
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
index a1be4f79acb4..484c0bcec86d 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -120,6 +120,11 @@ struct ath11k_hw_ring_mask {
 	u8 host2rxdma[ATH11K_EXT_IRQ_GRP_NUM_MAX];
 };
 
+struct ath11k_hw_sram_dump {
+	u32 start;
+	u32 end;
+};
+
 struct ath11k_hw_params {
 	const char *name;
 	u16 hw_rev;
@@ -173,6 +178,7 @@ struct ath11k_hw_params {
 	bool supports_suspend;
 	u32 hal_desc_sz;
 	bool fix_l1ss;
+	const struct ath11k_hw_sram_dump *sram_dump;
 };
 
 struct ath11k_hw_ops {
@@ -336,4 +342,6 @@ extern const struct ath11k_hw_regs qca6390_regs;
 extern const struct ath11k_hw_regs qcn9074_regs;
 extern const struct ath11k_hw_regs wcn6855_regs;
 
+extern const struct ath11k_hw_sram_dump sram_dump_qca6390;
+extern const struct ath11k_hw_sram_dump sram_dump_wcn6855;
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5c3ec3e7be89..c6540d562c42 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -273,6 +273,35 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 	return val;
 }
 
+static int ath11k_pci_dump_sram(struct ath11k_base *ab, u8 *buf,
+				u32 start, u32 end)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 i;
+	int ret;
+	bool wakeup_required;
+	u32 *data = (u32 *)buf;
+
+	/* for offset beyond BAR + 4K - 32, may
+	 * need to wakeup MHI to access.
+	 */
+	wakeup_required = test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
+			  end >= ACCESS_ALWAYS_OFF;
+	if (wakeup_required) {
+		ret = mhi_device_get_sync(ab_pci->mhi_ctrl->mhi_dev);
+		if (ret)
+			ath11k_warn(ab, "%s: failed to wakeup MHI: %d\n", __func__, ret);
+	}
+
+	for (i = start; i < end + 1; i += 4)
+		*data++ = ath11k_pci_do_read32(ab, i);
+
+	if (wakeup_required && !ret)
+		mhi_device_put(ab_pci->mhi_ctrl->mhi_dev);
+
+	return 0;
+}
+
 static void ath11k_pci_soc_global_reset(struct ath11k_base *ab)
 {
 	u32 val, delay;
@@ -1213,6 +1242,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
 	.get_ce_msi_idx = ath11k_pci_get_ce_msi_idx,
+	.dump_sram = ath11k_pci_dump_sram,
 };
 
 static void ath11k_pci_read_hw_version(struct ath11k_base *ab, u32 *major, u32 *minor)
-- 
2.25.1

