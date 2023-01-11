Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D6666152
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jan 2023 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbjAKRDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Jan 2023 12:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbjAKRC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Jan 2023 12:02:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FE93AB1B
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 09:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C0561D7C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jan 2023 17:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948DFC433D2;
        Wed, 11 Jan 2023 17:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673456439;
        bh=+WGS0zAXr4cfgNQ2br+L+VpGr671h299i+2KiODXD84=;
        h=From:To:Cc:Subject:Date:From;
        b=OoaiHJo7DZYX69G4dcLJkszLQ8f0PfidmSAwa+PwRgncEPuNtz2kvJpH8wEYYyZhZ
         GZEY4MeK3+bWVZHPj23Kv62jDEPEGXxfDdSm7yXGvz3Ke3pw7nVJQ0YyasH97KAOjN
         mfQDVzQ3yKO+zT9aGjhKh8pH1/H0e2dahRiW8a9RI2uv2QmnZfOZA9XD7d8Eg4PYDE
         sr7oIdfekMqL8AIBNipBPYn1McuNxdRcvO+thfmOl0dCF4FTv6zcq+Zeh8dKAfqTRZ
         xOQs81nZ2/BniWXf1GEqjkm0lBI8mNyBxYv3r88amJKDK6sM5UgTEKlrK+LnQfznib
         9sebg4SRvHfvQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath11k@lists.infradead.org
Cc:     mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        robert.marko@sartura.hr
Subject: [PATCH RFC] ath11k: Add multiple QCN9074 devices support
Date:   Wed, 11 Jan 2023 19:00:33 +0200
Message-Id: <20230111170033.32454-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <quic_ppranees@quicinc.com>

On platforms with two or more QCN9074 devices, the QMI service will run with
identical QRTR ids. qmi_add_lookup() is called with same qmi.service_ins_id.
Because of this identical id, the QMI .new_server is received on all ath11k QMI
clients and the QMI state machine fails.

To solve this generate a unique instance id from PCIe domain number and bus
number, write to the register ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0 before
power up. It is available for firmware when the QMI service is spawned. As not
all firmware releases support this feature add a new firmware feature flag
ATH11K_FW_FEATURE_MULTI_QRTR_ID to detect if it's supported.

With this change, qrtr-lookup is shown in below example.

Example:
root@OpenWrt:/# qrtr-lookup
Service Version Instance Node Port
15 1 0 23 1 Test service
69 1 23 23 2 ATH10k WLAN firmware service
15 1 0 24 1 Test service
69 1 24 24 2 ATH10k WLAN firmware service

Here 23 and 24 on column 3 (QMI Instance ID) and column 4 (Node ID) are the
node IDs that is unique per ath11k device.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.6.0.1-00760-QCAHKSWPL_SILICONZ-1

Co-developed-by: Anilkumar Kolli <quic_akolli@quicinc.com>
Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---

Kalle's comments:

Depends on: https://patchwork.kernel.org/project/linux-wireless/list/?series=710862&order=date

It's also possible to do a simple test by just changing the test
"test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)" to true, no
extra patches should be needed.

I don't have a test setup for this so compile tested only. But I assume Praneesh has tested this.

This is alternative approach to Robert's patchset:

https://patchwork.kernel.org/project/linux-wireless/list/?series=692423&state=*&order=date

 drivers/net/wireless/ath/ath11k/fw.h  |  5 +++++
 drivers/net/wireless/ath/ath11k/pci.c | 31 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci.h |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/fw.h b/drivers/net/wireless/ath/ath11k/fw.h
index e33b0f78b571..94f50d675f8d 100644
--- a/drivers/net/wireless/ath/ath11k/fw.h
+++ b/drivers/net/wireless/ath/ath11k/fw.h
@@ -17,6 +17,11 @@ enum ath11k_fw_ie_type {
 };
 
 enum ath11k_fw_features {
+	/* The firmware supports setting the QRTR id via register
+	 * ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0.
+	 */
+	ATH11K_FW_FEATURE_MULTI_QRTR_ID = 0,
+
 	/* keep last */
 	ATH11K_FW_FEATURE_COUNT,
 };
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 776362d151cb..c42e1e8da624 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -27,6 +27,8 @@
 #define QCN9074_DEVICE_ID		0x1104
 #define WCN6855_DEVICE_ID		0x1103
 
+#define ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0  0x1E03164
+
 static const struct pci_device_id ath11k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
@@ -367,9 +369,14 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	ath11k_mhi_set_mhictrl_reset(ab);
 }
 
+#define ATH11K_QRTR_INSTANCE_PCI_DOMAIN		GENMASK(3, 0)
+#define ATH11K_QRTR_INSTANCE_PCI_BUS_NUM	GENMASK(7, 4)
+
 static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 {
 	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	struct pci_bus *bus = ab_pci->pdev->bus;
 
 	cfg->tgt_ce = ab->hw_params.target_ce_config;
 	cfg->tgt_ce_len = ab->hw_params.target_ce_count;
@@ -380,6 +387,15 @@ static void ath11k_pci_init_qmi_ce_config(struct ath11k_base *ab)
 
 	ath11k_ce_get_shadow_config(ab, &cfg->shadow_reg_v2,
 				    &cfg->shadow_reg_v2_len);
+
+	if (test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features)) {
+		ab_pci->instance_id =
+			FIELD_PREP(ATH11K_QRTR_INSTANCE_PCI_DOMAIN,
+				   pci_domain_nr(bus)) |
+			FIELD_PREP(ATH11K_QRTR_INSTANCE_PCI_BUS_NUM,
+				   bus->number);
+		ab->qmi.service_ins_id += ab_pci->instance_id;
+	}
 }
 
 static void ath11k_pci_msi_config(struct ath11k_pci *ab_pci, bool enable)
@@ -597,6 +613,18 @@ static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 					   ab_pci->link_ctl);
 }
 
+static void ath11k_pci_update_qrtr_node_id(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 reg;
+
+	reg = ATH11K_PCIE_LOCAL_REG_PCIE_LOCAL_RSV0 & ATH11K_PCI_WINDOW_RANGE_MASK;
+	ath11k_pcic_write32(ab, reg, ab_pci->instance_id);
+
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "pci reg 0x%x instance_id 0x%x read val 0x%x\n",
+		   reg, ab_pci->instance_id, ath11k_pcic_read32(ab, reg));
+}
+
 static int ath11k_pci_power_up(struct ath11k_base *ab)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
@@ -613,6 +641,9 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 
 	ath11k_pci_msi_enable(ab_pci);
 
+	if (test_bit(ATH11K_FW_FEATURE_MULTI_QRTR_ID, ab->fw.fw_features))
+		ath11k_pci_update_qrtr_node_id(ab);
+
 	ret = ath11k_mhi_start(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to start mhi: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index e9a01f344ec6..b9d4018d53c6 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -72,6 +72,7 @@ struct ath11k_pci {
 	/* enum ath11k_pci_flags */
 	unsigned long flags;
 	u16 link_ctl;
+	u32 instance_id;
 };
 
 static inline struct ath11k_pci *ath11k_pci_priv(struct ath11k_base *ab)
-- 
2.30.2

