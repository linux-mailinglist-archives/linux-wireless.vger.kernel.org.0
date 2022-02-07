Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702A24AB7E6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiBGJlB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 04:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiBGJc6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 04:32:58 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 01:32:57 PST
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA2C043181
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 01:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644226377; x=1675762377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CVsIC3nRQpnetqgkbgk0WdGG0QucCEAw8y8k+WeSLHQ=;
  b=Kblffo+a3ZfU8PjQFZBl1mKSwGltj5DIytKFwKy8OGJZCWIVHjGms6e4
   lHb7PGNlBZuQt3jdNv814+lO6CmU7o3XRdc9e6JyZfkaKEC9MorYlaDfa
   baE4a7t2UThBaXqylRq9pW0aPJ/pp1EAI3azMZx1MGPIh7dC0Gi5riCAz
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 07 Feb 2022 01:30:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 01:30:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 01:30:54 -0800
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 01:30:53 -0800
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] ath11k: Reset PCIE_GPIO_CFG_REG register when power on
Date:   Mon, 7 Feb 2022 17:30:23 +0800
Message-ID: <20220207093023.10605-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On some modules, PCIE_GPIO_CFG_REG is not initialized to right value,
this will cause WCN6855 hardware fails to be enumerated.

Fix it by force writing the correct value to this register when power
on.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 11 +++++++++++
 drivers/net/wireless/ath/ath11k/pci.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d73b522a0081..06968ad488b0 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -445,6 +445,16 @@ static void ath11k_pci_force_wake(struct ath11k_base *ab)
 	mdelay(5);
 }
 
+static void ath11k_pci_gpio_reset(struct ath11k_base *ab)
+{
+	int val;
+
+	ath11k_pci_write32(ab, PCIE_GPIO_CFG_REG, PCIE_GPIO_RESET_VAL);
+	mdelay(10);
+	val = ath11k_pci_read32(ab, PCIE_GPIO_CFG_REG);
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "gpio cfg: 0x%x\n", val);
+}
+
 static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 {
 	mdelay(100);
@@ -461,6 +471,7 @@ static void ath11k_pci_sw_reset(struct ath11k_base *ab, bool power_on)
 	ath11k_pci_clear_dbg_registers(ab);
 	ath11k_pci_soc_global_reset(ab);
 	ath11k_mhi_set_mhictrl_reset(ab);
+	ath11k_pci_gpio_reset(ab);
 }
 
 int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 61d67b20a0eb..2716fc7745d6 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -52,6 +52,9 @@
 #define WLAON_QFPROM_PWR_CTRL_REG		0x01f8031c
 #define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
 
+#define PCIE_GPIO_CFG_REG			0x0180e000
+#define PCIE_GPIO_RESET_VAL			0xc5
+
 struct ath11k_msi_user {
 	char *name;
 	int num_vectors;
-- 
2.25.1

