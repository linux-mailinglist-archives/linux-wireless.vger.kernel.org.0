Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65104F8AAB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Apr 2022 02:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiDGWjy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiDGWjj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 18:39:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE4129844;
        Thu,  7 Apr 2022 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649371040; x=1680907040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=U4Lw15joKPNjm9Bi9jYAKUyHR5/8ES7cpfCVIgN4ut0=;
  b=aPNB564hfKGk2TVfuThBtUvKhotdPB3qenE1Vi/LyKU75SL45eAyPIxZ
   hT3p5ZV55eRN9HBz4dVUw/e8HeuzOZ+ItndJHbR/HA2ILMWyNx0V93gBT
   HcVjK+L8gn05E0UzdS4jUuOKkilMWaYSG2aPKdI5jyF6pbiqjaGj7fgRz
   DRTco81zbG3FtnRpp1jt+2Z/VEL+P4qIsBKcK23a2MBOEhcdaX6LpSqGd
   uUgSbhi/1OdzFuKMrevACkb8K/D+Lep/gpr9OgBzs5+sRXANG4LmsQU/m
   Ss6UtMGZ5QfjLs2dYMDMMovunkg2RaUj47qY16kchdFru1OZVAWh5Hc3e
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261449319"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="261449319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 15:37:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659242894"
Received: from rmarti10-desk.jf.intel.com ([134.134.150.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 15:37:11 -0700
From:   Ricardo Martinez <ricardo.martinez@linux.intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     kuba@kernel.org, davem@davemloft.net, johannes@sipsolutions.net,
        ryazanov.s.a@gmail.com, loic.poulain@linaro.org,
        m.chetan.kumar@intel.com, chandrashekar.devegowda@intel.com,
        linuxwwan@intel.com, chiranjeevi.rapolu@linux.intel.com,
        haijun.liu@mediatek.com, amir.hanania@intel.com,
        andriy.shevchenko@linux.intel.com, dinesh.sharma@intel.com,
        eliot.lee@intel.com, ilpo.johannes.jarvinen@intel.com,
        moises.veleta@intel.com, pierre-louis.bossart@intel.com,
        muralidharan.sethuraman@intel.com, Soumya.Prakash.Mishra@intel.com,
        sreehari.kancharla@intel.com, madhusmita.sahu@intel.com,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>
Subject: [PATCH net-next v6 08/13] net: wwan: t7xx: Add data path interface
Date:   Thu,  7 Apr 2022 15:36:24 -0700
Message-Id: <20220407223629.21487-9-ricardo.martinez@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407223629.21487-1-ricardo.martinez@linux.intel.com>
References: <20220407223629.21487-1-ricardo.martinez@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haijun Liu <haijun.liu@mediatek.com>

Data Path Modem AP Interface (DPMAIF) HIF layer provides methods
for initialization, ISR, control and event handling of TX/RX flows.

DPMAIF TX
Exposes the 'dmpaif_tx_send_skb' function which can be used by the
network device to transmit packets.
The uplink data management uses a Descriptor Ring Buffer (DRB).
First DRB entry is a message type that will be followed by 1 or more
normal DRB entries. Message type DRB will hold the skb information
and each normal DRB entry holds a pointer to the skb payload.

DPMAIF RX
The downlink buffer management uses Buffer Address Table (BAT) and
Packet Information Table (PIT) rings.
The BAT ring holds the address of skb data buffer for the HW to use,
while the PIT contains metadata about a whole network packet including
a reference to the BAT entry holding the data buffer address.
The driver reads the PIT and BAT entries written by the modem, when
reaching a threshold, the driver will reload the PIT and BAT rings.

Signed-off-by: Haijun Liu <haijun.liu@mediatek.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>

From a WWAN framework perspective:
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wwan/t7xx/Makefile             |    4 +
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c    |  484 ++++++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h    |  207 ++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 1221 ++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h |  116 ++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c |  659 +++++++++++
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.h |   79 ++
 7 files changed, 2770 insertions(+)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.h

diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 9eec2e2472fb..04a9ba50dc14 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -13,3 +13,7 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_port_proxy.o  \
 		t7xx_port_ctrl_msg.o \
 		t7xx_port_wwan.o \
+		t7xx_hif_dpmaif.o  \
+		t7xx_hif_dpmaif_tx.o \
+		t7xx_hif_dpmaif_rx.o  \
+		t7xx_dpmaif.o \
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
new file mode 100644
index 000000000000..2e9a8d7ba693
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Ricardo Martinez <ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/gfp.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/string.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include "t7xx_dpmaif.h"
+#include "t7xx_hif_dpmaif.h"
+#include "t7xx_hif_dpmaif_rx.h"
+#include "t7xx_hif_dpmaif_tx.h"
+#include "t7xx_pci.h"
+#include "t7xx_pcie_mac.h"
+#include "t7xx_state_monitor.h"
+
+unsigned int t7xx_ring_buf_get_next_wr_idx(unsigned int buf_len, unsigned int buf_idx)
+{
+	buf_idx++;
+
+	return buf_idx < buf_len ? buf_idx : 0;
+}
+
+unsigned int t7xx_ring_buf_rd_wr_count(unsigned int total_cnt, unsigned int rd_idx,
+				       unsigned int wr_idx, enum dpmaif_rdwr rd_wr)
+{
+	int pkt_cnt;
+
+	if (rd_wr == DPMAIF_READ)
+		pkt_cnt = wr_idx - rd_idx;
+	else
+		pkt_cnt = rd_idx - wr_idx - 1;
+
+	if (pkt_cnt < 0)
+		pkt_cnt += total_cnt;
+
+	return (unsigned int)pkt_cnt;
+}
+
+static void t7xx_dpmaif_enable_irq(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_isr_para *isr_para;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dpmaif_ctrl->isr_para); i++) {
+		isr_para = &dpmaif_ctrl->isr_para[i];
+		t7xx_pcie_mac_set_int(dpmaif_ctrl->t7xx_dev, isr_para->pcie_int);
+	}
+}
+
+static void t7xx_dpmaif_disable_irq(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_isr_para *isr_para;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dpmaif_ctrl->isr_para); i++) {
+		isr_para = &dpmaif_ctrl->isr_para[i];
+		t7xx_pcie_mac_clear_int(dpmaif_ctrl->t7xx_dev, isr_para->pcie_int);
+	}
+}
+
+static void t7xx_dpmaif_irq_cb(struct dpmaif_isr_para *isr_para)
+{
+	struct dpmaif_ctrl *dpmaif_ctrl = isr_para->dpmaif_ctrl;
+	struct dpmaif_hw_intr_st_para intr_status;
+	struct device *dev = dpmaif_ctrl->dev;
+	struct dpmaif_hw_info *hw_info;
+	int i;
+
+	memset(&intr_status, 0, sizeof(intr_status));
+	hw_info = &dpmaif_ctrl->hw_info;
+
+	if (t7xx_dpmaif_hw_get_intr_cnt(hw_info, &intr_status, isr_para->dlq_id) < 0) {
+		dev_err(dev, "Failed to get HW interrupt count\n");
+		return;
+	}
+
+	t7xx_pcie_mac_clear_int_status(dpmaif_ctrl->t7xx_dev, isr_para->pcie_int);
+
+	for (i = 0; i < intr_status.intr_cnt; i++) {
+		switch (intr_status.intr_types[i]) {
+		case DPF_INTR_UL_DONE:
+			t7xx_dpmaif_irq_tx_done(dpmaif_ctrl, intr_status.intr_queues[i]);
+			break;
+
+		case DPF_INTR_UL_DRB_EMPTY:
+		case DPF_INTR_UL_MD_NOTREADY:
+		case DPF_INTR_UL_MD_PWR_NOTREADY:
+			/* No need to log an error for these */
+			break;
+
+		case DPF_INTR_DL_BATCNT_LEN_ERR:
+			dev_err_ratelimited(dev, "DL interrupt: packet BAT count length error\n");
+			t7xx_dpmaif_dl_unmask_batcnt_len_err_intr(hw_info);
+			break;
+
+		case DPF_INTR_DL_PITCNT_LEN_ERR:
+			dev_err_ratelimited(dev, "DL interrupt: PIT count length error\n");
+			t7xx_dpmaif_dl_unmask_pitcnt_len_err_intr(hw_info);
+			break;
+
+		case DPF_INTR_DL_Q0_PITCNT_LEN_ERR:
+			dev_err_ratelimited(dev, "DL interrupt: DLQ0 PIT count length error\n");
+			t7xx_dpmaif_dlq_unmask_pitcnt_len_err_intr(hw_info, DPF_RX_QNO_DFT);
+			break;
+
+		case DPF_INTR_DL_Q1_PITCNT_LEN_ERR:
+			dev_err_ratelimited(dev, "DL interrupt: DLQ1 PIT count length error\n");
+			t7xx_dpmaif_dlq_unmask_pitcnt_len_err_intr(hw_info, DPF_RX_QNO1);
+			break;
+
+		case DPF_INTR_DL_DONE:
+		case DPF_INTR_DL_Q0_DONE:
+		case DPF_INTR_DL_Q1_DONE:
+			t7xx_dpmaif_irq_rx_done(dpmaif_ctrl, intr_status.intr_queues[i]);
+			break;
+
+		default:
+			dev_err_ratelimited(dev, "DL interrupt error: unknown type : %d\n",
+					    intr_status.intr_types[i]);
+		}
+	}
+}
+
+static irqreturn_t t7xx_dpmaif_isr_handler(int irq, void *data)
+{
+	struct dpmaif_isr_para *isr_para = data;
+	struct dpmaif_ctrl *dpmaif_ctrl;
+
+	dpmaif_ctrl = isr_para->dpmaif_ctrl;
+	if (dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
+		dev_err(dpmaif_ctrl->dev, "Interrupt received before initializing DPMAIF\n");
+		return IRQ_HANDLED;
+	}
+
+	t7xx_pcie_mac_clear_int(dpmaif_ctrl->t7xx_dev, isr_para->pcie_int);
+	t7xx_dpmaif_irq_cb(isr_para);
+	t7xx_pcie_mac_set_int(dpmaif_ctrl->t7xx_dev, isr_para->pcie_int);
+	return IRQ_HANDLED;
+}
+
+static void t7xx_dpmaif_isr_parameter_init(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_isr_para *isr_para;
+	unsigned char i;
+
+	dpmaif_ctrl->rxq_int_mapping[DPF_RX_QNO0] = DPMAIF_INT;
+	dpmaif_ctrl->rxq_int_mapping[DPF_RX_QNO1] = DPMAIF2_INT;
+
+	for (i = 0; i < DPMAIF_RXQ_NUM; i++) {
+		isr_para = &dpmaif_ctrl->isr_para[i];
+		isr_para->dpmaif_ctrl = dpmaif_ctrl;
+		isr_para->dlq_id = i;
+		isr_para->pcie_int = dpmaif_ctrl->rxq_int_mapping[i];
+	}
+}
+
+static void t7xx_dpmaif_register_pcie_irq(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct t7xx_pci_dev *t7xx_dev = dpmaif_ctrl->t7xx_dev;
+	struct dpmaif_isr_para *isr_para;
+	enum t7xx_int int_type;
+	int i;
+
+	t7xx_dpmaif_isr_parameter_init(dpmaif_ctrl);
+
+	for (i = 0; i < DPMAIF_RXQ_NUM; i++) {
+		isr_para = &dpmaif_ctrl->isr_para[i];
+		int_type = isr_para->pcie_int;
+		t7xx_pcie_mac_clear_int(t7xx_dev, int_type);
+
+		t7xx_dev->intr_handler[int_type] = t7xx_dpmaif_isr_handler;
+		t7xx_dev->intr_thread[int_type] = NULL;
+		t7xx_dev->callback_param[int_type] = isr_para;
+
+		t7xx_pcie_mac_clear_int_status(t7xx_dev, int_type);
+		t7xx_pcie_mac_set_int(t7xx_dev, int_type);
+	}
+}
+
+static int t7xx_dpmaif_rxtx_sw_allocs(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_rx_queue *rx_q;
+	struct dpmaif_tx_queue *tx_q;
+	int ret, rx_idx, tx_idx, i;
+
+	ret = t7xx_dpmaif_bat_alloc(dpmaif_ctrl, &dpmaif_ctrl->bat_req, BAT_TYPE_NORMAL);
+	if (ret) {
+		dev_err(dpmaif_ctrl->dev, "Failed to allocate normal BAT table: %d\n", ret);
+		return ret;
+	}
+
+	ret = t7xx_dpmaif_bat_alloc(dpmaif_ctrl, &dpmaif_ctrl->bat_frag, BAT_TYPE_FRAG);
+	if (ret) {
+		dev_err(dpmaif_ctrl->dev, "Failed to allocate frag BAT table: %d\n", ret);
+		goto err_free_normal_bat;
+	}
+
+	for (rx_idx = 0; rx_idx < DPMAIF_RXQ_NUM; rx_idx++) {
+		rx_q = &dpmaif_ctrl->rxq[rx_idx];
+		rx_q->index = rx_idx;
+		rx_q->dpmaif_ctrl = dpmaif_ctrl;
+		ret = t7xx_dpmaif_rxq_init(rx_q);
+		if (ret)
+			goto err_free_rxq;
+	}
+
+	for (tx_idx = 0; tx_idx < DPMAIF_TXQ_NUM; tx_idx++) {
+		tx_q = &dpmaif_ctrl->txq[tx_idx];
+		tx_q->index = tx_idx;
+		tx_q->dpmaif_ctrl = dpmaif_ctrl;
+		ret = t7xx_dpmaif_txq_init(tx_q);
+		if (ret)
+			goto err_free_txq;
+	}
+
+	ret = t7xx_dpmaif_tx_thread_init(dpmaif_ctrl);
+	if (ret) {
+		dev_err(dpmaif_ctrl->dev, "Failed to start TX thread\n");
+		goto err_free_txq;
+	}
+
+	ret = t7xx_dpmaif_bat_rel_wq_alloc(dpmaif_ctrl);
+	if (ret)
+		goto err_thread_rel;
+
+	return 0;
+
+err_thread_rel:
+	t7xx_dpmaif_tx_thread_rel(dpmaif_ctrl);
+
+err_free_txq:
+	for (i = 0; i < tx_idx; i++) {
+		tx_q = &dpmaif_ctrl->txq[i];
+		t7xx_dpmaif_txq_free(tx_q);
+	}
+
+err_free_rxq:
+	for (i = 0; i < rx_idx; i++) {
+		rx_q = &dpmaif_ctrl->rxq[i];
+		t7xx_dpmaif_rxq_free(rx_q);
+	}
+
+	t7xx_dpmaif_bat_free(dpmaif_ctrl, &dpmaif_ctrl->bat_frag);
+
+err_free_normal_bat:
+	t7xx_dpmaif_bat_free(dpmaif_ctrl, &dpmaif_ctrl->bat_req);
+
+	return ret;
+}
+
+static void t7xx_dpmaif_sw_release(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_rx_queue *rx_q;
+	struct dpmaif_tx_queue *tx_q;
+	int i;
+
+	t7xx_dpmaif_tx_thread_rel(dpmaif_ctrl);
+	t7xx_dpmaif_bat_wq_rel(dpmaif_ctrl);
+
+	for (i = 0; i < DPMAIF_TXQ_NUM; i++) {
+		tx_q = &dpmaif_ctrl->txq[i];
+		t7xx_dpmaif_txq_free(tx_q);
+	}
+
+	for (i = 0; i < DPMAIF_RXQ_NUM; i++) {
+		rx_q = &dpmaif_ctrl->rxq[i];
+		t7xx_dpmaif_rxq_free(rx_q);
+	}
+}
+
+static int t7xx_dpmaif_start(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_hw_info *hw_info = &dpmaif_ctrl->hw_info;
+	struct dpmaif_hw_params hw_init_para;
+	struct dpmaif_rx_queue *rxq;
+	struct dpmaif_tx_queue *txq;
+	unsigned int buf_cnt;
+	int i, ret = 0;
+
+	if (dpmaif_ctrl->state == DPMAIF_STATE_PWRON)
+		return -EFAULT;
+
+	memset(&hw_init_para, 0, sizeof(hw_init_para));
+
+	for (i = 0; i < DPMAIF_RXQ_NUM; i++) {
+		rxq = &dpmaif_ctrl->rxq[i];
+		rxq->que_started = true;
+		rxq->index = i;
+		rxq->budget = rxq->bat_req->bat_size_cnt - 1;
+
+		hw_init_para.pkt_bat_base_addr[i] = rxq->bat_req->bat_bus_addr;
+		hw_init_para.pkt_bat_size_cnt[i] = rxq->bat_req->bat_size_cnt;
+		hw_init_para.pit_base_addr[i] = rxq->pit_bus_addr;
+		hw_init_para.pit_size_cnt[i] = rxq->pit_size_cnt;
+		hw_init_para.frg_bat_base_addr[i] = rxq->bat_frag->bat_bus_addr;
+		hw_init_para.frg_bat_size_cnt[i] = rxq->bat_frag->bat_size_cnt;
+	}
+
+	bitmap_zero(dpmaif_ctrl->bat_req.bat_bitmap, dpmaif_ctrl->bat_req.bat_size_cnt);
+	buf_cnt = dpmaif_ctrl->bat_req.bat_size_cnt - 1;
+	ret = t7xx_dpmaif_rx_buf_alloc(dpmaif_ctrl, &dpmaif_ctrl->bat_req, 0, buf_cnt, true);
+	if (ret) {
+		dev_err(dpmaif_ctrl->dev, "Failed to allocate RX buffer: %d\n", ret);
+		return ret;
+	}
+
+	buf_cnt = dpmaif_ctrl->bat_frag.bat_size_cnt - 1;
+	ret = t7xx_dpmaif_rx_frag_alloc(dpmaif_ctrl, &dpmaif_ctrl->bat_frag, buf_cnt, true);
+	if (ret) {
+		dev_err(dpmaif_ctrl->dev, "Failed to allocate frag RX buffer: %d\n", ret);
+		goto err_free_normal_bat;
+	}
+
+	for (i = 0; i < DPMAIF_TXQ_NUM; i++) {
+		txq = &dpmaif_ctrl->txq[i];
+		txq->que_started = true;
+
+		hw_init_para.drb_base_addr[i] = txq->drb_bus_addr;
+		hw_init_para.drb_size_cnt[i] = txq->drb_size_cnt;
+	}
+
+	ret = t7xx_dpmaif_hw_init(hw_info, &hw_init_para);
+	if (ret) {
+		dev_err(dpmaif_ctrl->dev, "Failed to initialize DPMAIF HW: %d\n", ret);
+		goto err_free_frag_bat;
+	}
+
+	ret = t7xx_dpmaif_dl_snd_hw_bat_cnt(hw_info, rxq->bat_req->bat_size_cnt - 1);
+	if (ret)
+		goto err_free_frag_bat;
+
+	ret = t7xx_dpmaif_dl_snd_hw_frg_cnt(hw_info, rxq->bat_frag->bat_size_cnt - 1);
+	if (ret)
+		goto err_free_frag_bat;
+
+	t7xx_dpmaif_ul_clr_all_intr(hw_info);
+	t7xx_dpmaif_dl_clr_all_intr(hw_info);
+	dpmaif_ctrl->state = DPMAIF_STATE_PWRON;
+	t7xx_dpmaif_enable_irq(dpmaif_ctrl);
+	wake_up(&dpmaif_ctrl->tx_wq);
+	return 0;
+
+err_free_frag_bat:
+	t7xx_dpmaif_bat_free(rxq->dpmaif_ctrl, rxq->bat_frag);
+
+err_free_normal_bat:
+	t7xx_dpmaif_bat_free(rxq->dpmaif_ctrl, rxq->bat_req);
+
+	return ret;
+}
+
+static void t7xx_dpmaif_stop_sw(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	t7xx_dpmaif_tx_stop(dpmaif_ctrl);
+	t7xx_dpmaif_rx_stop(dpmaif_ctrl);
+}
+
+static void t7xx_dpmaif_stop_hw(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	t7xx_dpmaif_hw_stop_all_txq(&dpmaif_ctrl->hw_info);
+	t7xx_dpmaif_hw_stop_all_rxq(&dpmaif_ctrl->hw_info);
+}
+
+static int t7xx_dpmaif_stop(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	if (!dpmaif_ctrl->dpmaif_sw_init_done) {
+		dev_err(dpmaif_ctrl->dev, "dpmaif SW init fail\n");
+		return -EFAULT;
+	}
+
+	if (dpmaif_ctrl->state == DPMAIF_STATE_PWROFF)
+		return -EFAULT;
+
+	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
+	dpmaif_ctrl->state = DPMAIF_STATE_PWROFF;
+	t7xx_dpmaif_stop_sw(dpmaif_ctrl);
+	t7xx_dpmaif_tx_clear(dpmaif_ctrl);
+	t7xx_dpmaif_rx_clear(dpmaif_ctrl);
+	return 0;
+}
+
+int t7xx_dpmaif_md_state_callback(struct dpmaif_ctrl *dpmaif_ctrl, enum md_state state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case MD_STATE_WAITING_FOR_HS1:
+		ret = t7xx_dpmaif_start(dpmaif_ctrl);
+		break;
+
+	case MD_STATE_EXCEPTION:
+		ret = t7xx_dpmaif_stop(dpmaif_ctrl);
+		break;
+
+	case MD_STATE_STOPPED:
+		ret = t7xx_dpmaif_stop(dpmaif_ctrl);
+		break;
+
+	case MD_STATE_WAITING_TO_STOP:
+		t7xx_dpmaif_stop_hw(dpmaif_ctrl);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * t7xx_dpmaif_hif_init() - Initialize data path.
+ * @t7xx_dev: MTK context structure.
+ * @callbacks: Callbacks implemented by the network layer to handle RX skb and
+ *	       event notifications.
+ *
+ * Allocate and initialize datapath control block.
+ * Register datapath ISR, TX and RX resources.
+ *
+ * Return:
+ * * dpmaif_ctrl pointer - Pointer to DPMAIF context structure.
+ * * NULL		 - In case of error.
+ */
+struct dpmaif_ctrl *t7xx_dpmaif_hif_init(struct t7xx_pci_dev *t7xx_dev,
+					 struct dpmaif_callbacks *callbacks)
+{
+	struct device *dev = &t7xx_dev->pdev->dev;
+	struct dpmaif_ctrl *dpmaif_ctrl;
+	int ret;
+
+	if (!callbacks)
+		return NULL;
+
+	dpmaif_ctrl = devm_kzalloc(dev, sizeof(*dpmaif_ctrl), GFP_KERNEL);
+	if (!dpmaif_ctrl)
+		return NULL;
+
+	dpmaif_ctrl->t7xx_dev = t7xx_dev;
+	dpmaif_ctrl->callbacks = callbacks;
+	dpmaif_ctrl->dev = dev;
+	dpmaif_ctrl->dpmaif_sw_init_done = false;
+	dpmaif_ctrl->hw_info.dev = dev;
+	dpmaif_ctrl->hw_info.pcie_base = t7xx_dev->base_addr.pcie_ext_reg_base -
+					 t7xx_dev->base_addr.pcie_dev_reg_trsl_addr;
+
+	t7xx_dpmaif_register_pcie_irq(dpmaif_ctrl);
+	t7xx_dpmaif_disable_irq(dpmaif_ctrl);
+
+	ret = t7xx_dpmaif_rxtx_sw_allocs(dpmaif_ctrl);
+	if (ret) {
+		dev_err(dev, "Failed to allocate RX/TX SW resources: %d\n", ret);
+		return NULL;
+	}
+
+	dpmaif_ctrl->dpmaif_sw_init_done = true;
+	return dpmaif_ctrl;
+}
+
+void t7xx_dpmaif_hif_exit(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	if (dpmaif_ctrl->dpmaif_sw_init_done) {
+		t7xx_dpmaif_stop(dpmaif_ctrl);
+		t7xx_dpmaif_sw_release(dpmaif_ctrl);
+		dpmaif_ctrl->dpmaif_sw_init_done = false;
+	}
+}
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
new file mode 100644
index 000000000000..adebbcf3bb01
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Ricardo Martinez <ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#ifndef __T7XX_HIF_DPMAIF_H__
+#define __T7XX_HIF_DPMAIF_H__
+
+#include <linux/bitmap.h>
+#include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include "t7xx_dpmaif.h"
+#include "t7xx_pci.h"
+#include "t7xx_state_monitor.h"
+
+/* SKB control buffer */
+struct t7xx_skb_cb {
+	u8	netif_idx;
+	u8	txq_number;
+	u8	rx_pkt_type;
+};
+
+#define T7XX_SKB_CB(__skb)	((struct t7xx_skb_cb *)(__skb)->cb)
+
+enum dpmaif_rdwr {
+	DPMAIF_READ,
+	DPMAIF_WRITE,
+};
+
+/* Structure of DL BAT */
+struct dpmaif_cur_rx_skb_info {
+	bool			msg_pit_received;
+	struct sk_buff		*cur_skb;
+	unsigned int		cur_chn_idx;
+	unsigned int		check_sum;
+	unsigned int		pit_dp;
+	unsigned int		pkt_type;
+	int			err_payload;
+};
+
+struct dpmaif_bat {
+	unsigned int		p_buffer_addr;
+	unsigned int		buffer_addr_ext;
+};
+
+struct dpmaif_bat_skb {
+	struct sk_buff		*skb;
+	dma_addr_t		data_bus_addr;
+	unsigned int		data_len;
+};
+
+struct dpmaif_bat_page {
+	struct page		*page;
+	dma_addr_t		data_bus_addr;
+	unsigned int		offset;
+	unsigned int		data_len;
+};
+
+enum bat_type {
+	BAT_TYPE_NORMAL,
+	BAT_TYPE_FRAG,
+};
+
+struct dpmaif_bat_request {
+	void			*bat_base;
+	dma_addr_t		bat_bus_addr;
+	unsigned int		bat_size_cnt;
+	unsigned int		bat_wr_idx;
+	unsigned int		bat_release_rd_idx;
+	void			*bat_skb;
+	unsigned int		pkt_buf_sz;
+	unsigned long		*bat_bitmap;
+	atomic_t		refcnt;
+	spinlock_t		mask_lock; /* Protects BAT mask */
+	enum bat_type		type;
+};
+
+struct dpmaif_rx_queue {
+	unsigned int		index;
+	bool			que_started;
+	unsigned int		budget;
+
+	void			*pit_base;
+	dma_addr_t		pit_bus_addr;
+	unsigned int		pit_size_cnt;
+
+	unsigned int		pit_rd_idx;
+	unsigned int		pit_wr_idx;
+	unsigned int		pit_release_rd_idx;
+
+	struct dpmaif_bat_request *bat_req;
+	struct dpmaif_bat_request *bat_frag;
+
+	wait_queue_head_t	rx_wq;
+	struct task_struct	*rx_thread;
+	struct sk_buff_head	skb_list;
+	unsigned int		skb_list_max_len;
+
+	struct workqueue_struct	*worker;
+	struct work_struct	dpmaif_rxq_work;
+
+	atomic_t		rx_processing;
+
+	struct dpmaif_ctrl	*dpmaif_ctrl;
+	unsigned int		expect_pit_seq;
+	unsigned int		pit_remain_release_cnt;
+	struct dpmaif_cur_rx_skb_info rx_data_info;
+};
+
+struct dpmaif_tx_queue {
+	unsigned int		index;
+	bool			que_started;
+	atomic_t		tx_budget;
+	void			*drb_base;
+	dma_addr_t		drb_bus_addr;
+	unsigned int		drb_size_cnt;
+	unsigned int		drb_wr_idx;
+	unsigned int		drb_rd_idx;
+	unsigned int		drb_release_rd_idx;
+	void			*drb_skb_base;
+	wait_queue_head_t	req_wq;
+	struct workqueue_struct	*worker;
+	struct work_struct	dpmaif_tx_work;
+	spinlock_t		tx_lock; /* Protects txq DRB */
+	atomic_t		tx_processing;
+
+	struct dpmaif_ctrl	*dpmaif_ctrl;
+	struct sk_buff_head	tx_skb_head;
+	unsigned int		tx_list_max_len;
+	unsigned int		tx_skb_stat;
+};
+
+struct dpmaif_isr_para {
+	struct dpmaif_ctrl	*dpmaif_ctrl;
+	unsigned char		pcie_int;
+	unsigned char		dlq_id;
+};
+
+enum dpmaif_state {
+	DPMAIF_STATE_MIN,
+	DPMAIF_STATE_PWROFF,
+	DPMAIF_STATE_PWRON,
+	DPMAIF_STATE_EXCEPTION,
+	DPMAIF_STATE_MAX
+};
+
+enum dpmaif_txq_state {
+	DMPAIF_TXQ_STATE_IRQ,
+	DMPAIF_TXQ_STATE_FULL,
+};
+
+struct dpmaif_callbacks {
+	void (*state_notify)(struct t7xx_pci_dev *t7xx_dev,
+			     enum dpmaif_txq_state state, int txq_number);
+	void (*recv_skb)(struct t7xx_pci_dev *t7xx_dev, struct sk_buff *skb);
+};
+
+struct dpmaif_ctrl {
+	struct device			*dev;
+	struct t7xx_pci_dev		*t7xx_dev;
+	enum dpmaif_state		state;
+	bool				dpmaif_sw_init_done;
+	struct dpmaif_hw_info		hw_info;
+	struct dpmaif_tx_queue		txq[DPMAIF_TXQ_NUM];
+	struct dpmaif_rx_queue		rxq[DPMAIF_RXQ_NUM];
+
+	unsigned char			rxq_int_mapping[DPMAIF_RXQ_NUM];
+	struct dpmaif_isr_para		isr_para[DPMAIF_RXQ_NUM];
+
+	struct dpmaif_bat_request	bat_req;
+	struct dpmaif_bat_request	bat_frag;
+	struct workqueue_struct		*bat_release_wq;
+	struct work_struct		bat_release_work;
+
+	wait_queue_head_t		tx_wq;
+	struct task_struct		*tx_thread;
+
+	struct dpmaif_callbacks		*callbacks;
+};
+
+struct dpmaif_ctrl *t7xx_dpmaif_hif_init(struct t7xx_pci_dev *t7xx_dev,
+					 struct dpmaif_callbacks *callbacks);
+void t7xx_dpmaif_hif_exit(struct dpmaif_ctrl *dpmaif_ctrl);
+int t7xx_dpmaif_md_state_callback(struct dpmaif_ctrl *dpmaif_ctrl, enum md_state state);
+unsigned int t7xx_ring_buf_get_next_wr_idx(unsigned int buf_len, unsigned int buf_idx);
+unsigned int t7xx_ring_buf_rd_wr_count(unsigned int total_cnt, unsigned int rd_idx,
+				       unsigned int wr_idx, enum dpmaif_rdwr);
+
+#endif /* __T7XX_HIF_DPMAIF_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
new file mode 100644
index 000000000000..6aa10536dd9c
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -0,0 +1,1221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Ricardo Martinez <ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/gfp.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
+#include <linux/netdevice.h>
+#include <linux/sched.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include "t7xx_dpmaif.h"
+#include "t7xx_hif_dpmaif.h"
+#include "t7xx_hif_dpmaif_rx.h"
+#include "t7xx_pci.h"
+
+#define DPMAIF_BAT_COUNT		8192
+#define DPMAIF_FRG_COUNT		4814
+#define DPMAIF_PIT_COUNT		(DPMAIF_BAT_COUNT * 2)
+
+#define DPMAIF_BAT_CNT_THRESHOLD	30
+#define DPMAIF_PIT_CNT_THRESHOLD	60
+#define DPMAIF_RX_PUSH_THRESHOLD_MASK	GENMASK(2, 0)
+#define DPMAIF_NOTIFY_RELEASE_COUNT	128
+#define DPMAIF_POLL_PIT_TIME_US		20
+#define DPMAIF_POLL_PIT_MAX_TIME_US	2000
+#define DPMAIF_WQ_TIME_LIMIT_MS		2
+#define DPMAIF_CS_RESULT_PASS		0
+
+/* Packet type */
+#define DES_PT_PD			0
+#define DES_PT_MSG			1
+/* Buffer type */
+#define PKT_BUF_FRAG			1
+
+static unsigned int t7xx_normal_pit_bid(const struct dpmaif_pit *pit_info)
+{
+	u32 value;
+
+	value = FIELD_GET(PD_PIT_H_BID, le32_to_cpu(pit_info->pd.footer));
+	value <<= 13;
+	value += FIELD_GET(PD_PIT_BUFFER_ID, le32_to_cpu(pit_info->header));
+	return value;
+}
+
+static int t7xx_dpmaif_net_rx_push_thread(void *arg)
+{
+	struct dpmaif_rx_queue *q = arg;
+	struct dpmaif_ctrl *hif_ctrl;
+	struct dpmaif_callbacks *cb;
+
+	hif_ctrl = q->dpmaif_ctrl;
+	cb = hif_ctrl->callbacks;
+
+	while (!kthread_should_stop()) {
+		struct sk_buff *skb;
+		unsigned long flags;
+
+		if (skb_queue_empty(&q->skb_list)) {
+			if (wait_event_interruptible(q->rx_wq,
+						     !skb_queue_empty(&q->skb_list) ||
+						     kthread_should_stop()))
+				continue;
+
+			if (kthread_should_stop())
+				break;
+		}
+
+		spin_lock_irqsave(&q->skb_list.lock, flags);
+		skb = __skb_dequeue(&q->skb_list);
+		spin_unlock_irqrestore(&q->skb_list.lock, flags);
+
+		if (!skb)
+			continue;
+
+		cb->recv_skb(hif_ctrl->t7xx_dev, skb);
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static int t7xx_dpmaif_update_bat_wr_idx(struct dpmaif_ctrl *dpmaif_ctrl,
+					 const unsigned int q_num, const unsigned int bat_cnt)
+{
+	struct dpmaif_rx_queue *rxq = &dpmaif_ctrl->rxq[q_num];
+	struct dpmaif_bat_request *bat_req = rxq->bat_req;
+	unsigned int old_rl_idx, new_wr_idx, old_wr_idx;
+
+	if (!rxq->que_started) {
+		dev_err(dpmaif_ctrl->dev, "RX queue %d has not been started\n", rxq->index);
+		return -EINVAL;
+	}
+
+	old_rl_idx = bat_req->bat_release_rd_idx;
+	old_wr_idx = bat_req->bat_wr_idx;
+	new_wr_idx = old_wr_idx + bat_cnt;
+
+	if (old_rl_idx > old_wr_idx && new_wr_idx >= old_rl_idx)
+		goto err_flow;
+
+	if (new_wr_idx >= bat_req->bat_size_cnt) {
+		new_wr_idx -= bat_req->bat_size_cnt;
+		if (new_wr_idx >= old_rl_idx)
+			goto err_flow;
+	}
+
+	bat_req->bat_wr_idx = new_wr_idx;
+	return 0;
+
+err_flow:
+	dev_err(dpmaif_ctrl->dev, "RX BAT flow check fail\n");
+	return -EINVAL;
+}
+
+static bool t7xx_alloc_and_map_skb_info(const struct dpmaif_ctrl *dpmaif_ctrl,
+					const unsigned int size, struct dpmaif_bat_skb *cur_skb)
+{
+	dma_addr_t data_bus_addr;
+	struct sk_buff *skb;
+	size_t data_len;
+
+	skb = __dev_alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return false;
+
+	data_len = skb_end_pointer(skb) - skb->data;
+
+	data_bus_addr = dma_map_single(dpmaif_ctrl->dev, skb->data, data_len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dpmaif_ctrl->dev, data_bus_addr)) {
+		dev_err_ratelimited(dpmaif_ctrl->dev, "DMA mapping error\n");
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cur_skb->skb = skb;
+	cur_skb->data_bus_addr = data_bus_addr;
+	cur_skb->data_len = data_len;
+
+	return true;
+}
+
+static void t7xx_unmap_bat_skb(struct device *dev, struct dpmaif_bat_skb *bat_skb_base,
+			       unsigned int index)
+{
+	struct dpmaif_bat_skb *bat_skb = bat_skb_base + index;
+
+	if (bat_skb->skb) {
+		dma_unmap_single(dev, bat_skb->data_bus_addr, bat_skb->data_len, DMA_FROM_DEVICE);
+		dev_kfree_skb(bat_skb->skb);
+		bat_skb->skb = NULL;
+	}
+}
+
+/**
+ * t7xx_dpmaif_rx_buf_alloc() - Allocate buffers for the BAT ring.
+ * @dpmaif_ctrl: Pointer to DPMAIF context structure.
+ * @bat_req: Pointer to BAT request structure.
+ * @q_num: Queue number.
+ * @buf_cnt: Number of buffers to allocate.
+ * @initial: Indicates if the ring is being populated for the first time.
+ *
+ * Allocate skb and store the start address of the data buffer into the BAT ring.
+ * If this is not the initial call, notify the HW about the new entries.
+ *
+ * Return:
+ * * 0		- Success.
+ * * -ERROR	- Error code.
+ */
+int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpmaif_ctrl,
+			     const struct dpmaif_bat_request *bat_req,
+			     const unsigned int q_num, const unsigned int buf_cnt,
+			     const bool initial)
+{
+	unsigned int i, bat_cnt, bat_max_cnt, bat_start_idx;
+	int ret;
+
+	if (!buf_cnt || buf_cnt > bat_req->bat_size_cnt)
+		return -EINVAL;
+
+	/* Check BAT buffer space */
+	bat_max_cnt = bat_req->bat_size_cnt;
+
+	bat_cnt = t7xx_ring_buf_rd_wr_count(bat_max_cnt, bat_req->bat_release_rd_idx,
+					    bat_req->bat_wr_idx, DPMAIF_WRITE);
+	if (buf_cnt > bat_cnt)
+		return -ENOMEM;
+
+	bat_start_idx = bat_req->bat_wr_idx;
+
+	for (i = 0; i < buf_cnt; i++) {
+		unsigned int cur_bat_idx = bat_start_idx + i;
+		struct dpmaif_bat_skb *cur_skb;
+		struct dpmaif_bat *cur_bat;
+
+		if (cur_bat_idx >= bat_max_cnt)
+			cur_bat_idx -= bat_max_cnt;
+
+		cur_skb = (struct dpmaif_bat_skb *)bat_req->bat_skb + cur_bat_idx;
+		if (!cur_skb->skb &&
+		    !t7xx_alloc_and_map_skb_info(dpmaif_ctrl, bat_req->pkt_buf_sz, cur_skb))
+			break;
+
+		cur_bat = (struct dpmaif_bat *)bat_req->bat_base + cur_bat_idx;
+		cur_bat->buffer_addr_ext = upper_32_bits(cur_skb->data_bus_addr);
+		cur_bat->p_buffer_addr = lower_32_bits(cur_skb->data_bus_addr);
+	}
+
+	if (!i)
+		return -ENOMEM;
+
+	ret = t7xx_dpmaif_update_bat_wr_idx(dpmaif_ctrl, q_num, i);
+	if (ret)
+		goto err_unmap_skbs;
+
+	if (!initial) {
+		unsigned int hw_wr_idx;
+
+		ret = t7xx_dpmaif_dl_snd_hw_bat_cnt(&dpmaif_ctrl->hw_info, i);
+		if (ret)
+			goto err_unmap_skbs;
+
+		hw_wr_idx = t7xx_dpmaif_dl_get_bat_wr_idx(&dpmaif_ctrl->hw_info,
+							  DPF_RX_QNO_DFT);
+		if (hw_wr_idx != bat_req->bat_wr_idx) {
+			ret = -EFAULT;
+			dev_err(dpmaif_ctrl->dev, "Write index mismatch in RX ring\n");
+			goto err_unmap_skbs;
+		}
+	}
+
+	return 0;
+
+err_unmap_skbs:
+	while (--i > 0)
+		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
+
+	return ret;
+}
+
+static int t7xx_dpmaifq_release_pit_entry(struct dpmaif_rx_queue *rxq,
+					  const unsigned int rel_entry_num)
+{
+	struct dpmaif_hw_info *hw_info = &rxq->dpmaif_ctrl->hw_info;
+	unsigned int old_rel_idx, new_rel_idx, hw_wr_idx;
+	int ret;
+
+	if (!rxq->que_started)
+		return 0;
+
+	if (rel_entry_num >= rxq->pit_size_cnt) {
+		dev_err(rxq->dpmaif_ctrl->dev, "Invalid PIT release index\n");
+		return -EINVAL;
+	}
+
+	old_rel_idx = rxq->pit_release_rd_idx;
+	new_rel_idx = old_rel_idx + rel_entry_num;
+	hw_wr_idx = rxq->pit_wr_idx;
+	if (hw_wr_idx < old_rel_idx && new_rel_idx >= rxq->pit_size_cnt)
+		new_rel_idx -= rxq->pit_size_cnt;
+
+	ret = t7xx_dpmaif_dlq_add_pit_remain_cnt(hw_info, rxq->index, rel_entry_num);
+	if (ret) {
+		dev_err(rxq->dpmaif_ctrl->dev, "PIT release failure: %d\n", ret);
+		return ret;
+	}
+
+	rxq->pit_release_rd_idx = new_rel_idx;
+	return 0;
+}
+
+static void t7xx_dpmaif_set_bat_mask(struct dpmaif_bat_request *bat_req, unsigned int idx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bat_req->mask_lock, flags);
+	set_bit(idx, bat_req->bat_bitmap);
+	spin_unlock_irqrestore(&bat_req->mask_lock, flags);
+}
+
+static int t7xx_frag_bat_cur_bid_check(struct dpmaif_rx_queue *rxq,
+				       const unsigned int cur_bid)
+{
+	struct dpmaif_bat_request *bat_frag = rxq->bat_frag;
+	struct dpmaif_bat_page *bat_page;
+
+	if (cur_bid >= DPMAIF_FRG_COUNT)
+		return -EINVAL;
+
+	bat_page = bat_frag->bat_skb + cur_bid;
+	if (!bat_page->page)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void t7xx_unmap_bat_page(struct device *dev, struct dpmaif_bat_page *bat_page_base,
+				unsigned int index)
+{
+	struct dpmaif_bat_page *bat_page = bat_page_base + index;
+
+	if (bat_page->page) {
+		dma_unmap_page(dev, bat_page->data_bus_addr, bat_page->data_len, DMA_FROM_DEVICE);
+		put_page(bat_page->page);
+		bat_page->page = NULL;
+	}
+}
+
+/**
+ * t7xx_dpmaif_rx_frag_alloc() - Allocates buffers for the Fragment BAT ring.
+ * @dpmaif_ctrl: Pointer to DPMAIF context structure.
+ * @bat_req: Pointer to BAT request structure.
+ * @buf_cnt: Number of buffers to allocate.
+ * @initial: Indicates if the ring is being populated for the first time.
+ *
+ * Fragment BAT is used when the received packet does not fit in a normal BAT entry.
+ * This function allocates a page fragment and stores the start address of the page
+ * into the Fragment BAT ring.
+ * If this is not the initial call, notify the HW about the new entries.
+ *
+ * Return:
+ * * 0		- Success.
+ * * -ERROR	- Error code.
+ */
+int t7xx_dpmaif_rx_frag_alloc(struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_bat_request *bat_req,
+			      const unsigned int buf_cnt, const bool initial)
+{
+	unsigned int buf_space, cur_bat_idx = bat_req->bat_wr_idx;
+	struct dpmaif_bat_page *bat_skb = bat_req->bat_skb;
+	int ret = 0, i;
+
+	if (!buf_cnt || buf_cnt > bat_req->bat_size_cnt)
+		return -EINVAL;
+
+	buf_space = t7xx_ring_buf_rd_wr_count(bat_req->bat_size_cnt,
+					      bat_req->bat_release_rd_idx, bat_req->bat_wr_idx,
+					      DPMAIF_WRITE);
+	if (buf_cnt > buf_space) {
+		dev_err(dpmaif_ctrl->dev,
+			"Requested more buffers than the space available in RX frag ring\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < buf_cnt; i++) {
+		struct dpmaif_bat_page *cur_page = bat_skb + cur_bat_idx;
+		struct dpmaif_bat *cur_bat;
+		dma_addr_t data_base_addr;
+
+		if (!cur_page->page) {
+			unsigned long offset;
+			struct page *page;
+			void *data;
+
+			data = netdev_alloc_frag(bat_req->pkt_buf_sz);
+			if (!data)
+				break;
+
+			page = virt_to_head_page(data);
+			offset = data - page_address(page);
+
+			data_base_addr = dma_map_page(dpmaif_ctrl->dev, page, offset,
+						      bat_req->pkt_buf_sz, DMA_FROM_DEVICE);
+			if (dma_mapping_error(dpmaif_ctrl->dev, data_base_addr)) {
+				put_page(virt_to_head_page(data));
+				dev_err(dpmaif_ctrl->dev, "DMA mapping fail\n");
+				break;
+			}
+
+			cur_page->page = page;
+			cur_page->data_bus_addr = data_base_addr;
+			cur_page->offset = offset;
+			cur_page->data_len = bat_req->pkt_buf_sz;
+		}
+
+		data_base_addr = cur_page->data_bus_addr;
+		cur_bat = (struct dpmaif_bat *)bat_req->bat_base + cur_bat_idx;
+		cur_bat->buffer_addr_ext = upper_32_bits(data_base_addr);
+		cur_bat->p_buffer_addr = lower_32_bits(data_base_addr);
+		cur_bat_idx = t7xx_ring_buf_get_next_wr_idx(bat_req->bat_size_cnt, cur_bat_idx);
+	}
+
+	bat_req->bat_wr_idx = cur_bat_idx;
+
+	if (!initial)
+		t7xx_dpmaif_dl_snd_hw_frg_cnt(&dpmaif_ctrl->hw_info, i);
+
+	if (i < buf_cnt) {
+		ret = -ENOMEM;
+		if (initial) {
+			while (--i > 0)
+				t7xx_unmap_bat_page(dpmaif_ctrl->dev, bat_req->bat_skb, i);
+		}
+	}
+
+	return ret;
+}
+
+static int t7xx_dpmaif_set_frag_to_skb(const struct dpmaif_rx_queue *rxq,
+				       const struct dpmaif_pit *pkt_info,
+				       struct sk_buff *skb)
+{
+	unsigned long long data_bus_addr, data_base_addr;
+	struct device *dev = rxq->dpmaif_ctrl->dev;
+	struct dpmaif_bat_page *page_info;
+	unsigned int data_len;
+	int data_offset;
+
+	page_info = rxq->bat_frag->bat_skb;
+	page_info += t7xx_normal_pit_bid(pkt_info);
+	dma_unmap_page(dev, page_info->data_bus_addr, page_info->data_len, DMA_FROM_DEVICE);
+
+	if (!page_info->page)
+		return -EINVAL;
+
+	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);
+	data_bus_addr = (data_bus_addr << 32) + le32_to_cpu(pkt_info->pd.data_addr_l);
+	data_base_addr = page_info->data_bus_addr;
+	data_offset = data_bus_addr - data_base_addr;
+	data_offset += page_info->offset;
+	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page_info->page,
+			data_offset, data_len, page_info->data_len);
+
+	page_info->page = NULL;
+	page_info->offset = 0;
+	page_info->data_len = 0;
+	return 0;
+}
+
+static int t7xx_dpmaif_get_frag(struct dpmaif_rx_queue *rxq,
+				const struct dpmaif_pit *pkt_info,
+				const struct dpmaif_cur_rx_skb_info *skb_info)
+{
+	unsigned int cur_bid = t7xx_normal_pit_bid(pkt_info);
+	int ret;
+
+	ret = t7xx_frag_bat_cur_bid_check(rxq, cur_bid);
+	if (ret < 0)
+		return ret;
+
+	ret = t7xx_dpmaif_set_frag_to_skb(rxq, pkt_info, skb_info->cur_skb);
+	if (ret < 0) {
+		dev_err(rxq->dpmaif_ctrl->dev, "Failed to set frag data to skb: %d\n", ret);
+		return ret;
+	}
+
+	t7xx_dpmaif_set_bat_mask(rxq->bat_frag, cur_bid);
+	return 0;
+}
+
+static int t7xx_bat_cur_bid_check(struct dpmaif_rx_queue *rxq, const unsigned int cur_bid)
+{
+	struct dpmaif_bat_skb *bat_skb = rxq->bat_req->bat_skb;
+
+	bat_skb += cur_bid;
+	if (cur_bid >= DPMAIF_BAT_COUNT || !bat_skb->skb)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int t7xx_dpmaif_read_pit_seq(const struct dpmaif_pit *pit)
+{
+	return FIELD_GET(PD_PIT_PIT_SEQ, le32_to_cpu(pit->pd.footer));
+}
+
+static int t7xx_dpmaif_check_pit_seq(struct dpmaif_rx_queue *rxq,
+				     const struct dpmaif_pit *pit)
+{
+	unsigned int cur_pit_seq, expect_pit_seq = rxq->expect_pit_seq;
+
+	if (read_poll_timeout_atomic(t7xx_dpmaif_read_pit_seq, cur_pit_seq,
+				     cur_pit_seq == expect_pit_seq, DPMAIF_POLL_PIT_TIME_US,
+				     DPMAIF_POLL_PIT_MAX_TIME_US, false, pit))
+		return -EFAULT;
+
+	rxq->expect_pit_seq++;
+	if (rxq->expect_pit_seq >= DPMAIF_DL_PIT_SEQ_VALUE)
+		rxq->expect_pit_seq = 0;
+
+	return 0;
+}
+
+static unsigned int t7xx_dpmaif_avail_pkt_bat_cnt(struct dpmaif_bat_request *bat_req)
+{
+	unsigned int zero_index;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bat_req->mask_lock, flags);
+
+	zero_index = find_next_zero_bit(bat_req->bat_bitmap, bat_req->bat_size_cnt,
+					bat_req->bat_release_rd_idx);
+
+	if (zero_index < bat_req->bat_size_cnt) {
+		spin_unlock_irqrestore(&bat_req->mask_lock, flags);
+		return zero_index - bat_req->bat_release_rd_idx;
+	}
+
+	/* limiting the search till bat_release_rd_idx */
+	zero_index = find_first_zero_bit(bat_req->bat_bitmap, bat_req->bat_release_rd_idx);
+	spin_unlock_irqrestore(&bat_req->mask_lock, flags);
+	return bat_req->bat_size_cnt - bat_req->bat_release_rd_idx + zero_index;
+}
+
+static int t7xx_dpmaif_release_bat_entry(const struct dpmaif_rx_queue *rxq,
+					 const unsigned int rel_entry_num,
+					 const enum bat_type buf_type)
+{
+	struct dpmaif_hw_info *hw_info = &rxq->dpmaif_ctrl->hw_info;
+	unsigned int old_rel_idx, new_rel_idx, hw_rd_idx, i;
+	struct dpmaif_bat_request *bat;
+	unsigned long flags;
+
+	if (!rxq->que_started || !rel_entry_num)
+		return -EINVAL;
+
+	if (buf_type == BAT_TYPE_FRAG) {
+		bat = rxq->bat_frag;
+		hw_rd_idx = t7xx_dpmaif_dl_get_frg_rd_idx(hw_info, rxq->index);
+	} else {
+		bat = rxq->bat_req;
+		hw_rd_idx = t7xx_dpmaif_dl_get_bat_rd_idx(hw_info, rxq->index);
+	}
+
+	if (rel_entry_num >= bat->bat_size_cnt)
+		return -EINVAL;
+
+	old_rel_idx = bat->bat_release_rd_idx;
+	new_rel_idx = old_rel_idx + rel_entry_num;
+
+	/* Do not need to release if the queue is empty */
+	if (bat->bat_wr_idx == old_rel_idx)
+		return 0;
+
+	if (hw_rd_idx >= old_rel_idx) {
+		if (new_rel_idx > hw_rd_idx)
+			return -EINVAL;
+	}
+
+	if (new_rel_idx >= bat->bat_size_cnt) {
+		new_rel_idx -= bat->bat_size_cnt;
+		if (new_rel_idx > hw_rd_idx)
+			return -EINVAL;
+	}
+
+	spin_lock_irqsave(&bat->mask_lock, flags);
+	for (i = 0; i < rel_entry_num; i++) {
+		unsigned int index = bat->bat_release_rd_idx + i;
+
+		if (index >= bat->bat_size_cnt)
+			index -= bat->bat_size_cnt;
+
+		clear_bit(index, bat->bat_bitmap);
+	}
+	spin_unlock_irqrestore(&bat->mask_lock, flags);
+
+	bat->bat_release_rd_idx = new_rel_idx;
+	return rel_entry_num;
+}
+
+static int t7xx_dpmaif_pit_release_and_add(struct dpmaif_rx_queue *rxq)
+{
+	int ret;
+
+	if (rxq->pit_remain_release_cnt < DPMAIF_PIT_CNT_THRESHOLD)
+		return 0;
+
+	ret = t7xx_dpmaifq_release_pit_entry(rxq, rxq->pit_remain_release_cnt);
+	if (ret)
+		return ret;
+
+	rxq->pit_remain_release_cnt = 0;
+	return 0;
+}
+
+static int t7xx_dpmaif_bat_release_and_add(const struct dpmaif_rx_queue *rxq)
+{
+	unsigned int bid_cnt;
+	int ret;
+
+	bid_cnt = t7xx_dpmaif_avail_pkt_bat_cnt(rxq->bat_req);
+	if (bid_cnt < DPMAIF_BAT_CNT_THRESHOLD)
+		return 0;
+
+	ret = t7xx_dpmaif_release_bat_entry(rxq, bid_cnt, BAT_TYPE_NORMAL);
+	if (ret <= 0) {
+		dev_err(rxq->dpmaif_ctrl->dev, "Release PKT BAT failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = t7xx_dpmaif_rx_buf_alloc(rxq->dpmaif_ctrl, rxq->bat_req, rxq->index, bid_cnt, false);
+	if (ret < 0)
+		dev_err(rxq->dpmaif_ctrl->dev, "Allocate new RX buffer failed: %d\n", ret);
+
+	return ret;
+}
+
+static int t7xx_dpmaif_frag_bat_release_and_add(const struct dpmaif_rx_queue *rxq)
+{
+	unsigned int bid_cnt;
+	int ret;
+
+	bid_cnt = t7xx_dpmaif_avail_pkt_bat_cnt(rxq->bat_frag);
+	if (bid_cnt < DPMAIF_BAT_CNT_THRESHOLD)
+		return 0;
+
+	ret = t7xx_dpmaif_release_bat_entry(rxq, bid_cnt, BAT_TYPE_FRAG);
+	if (ret <= 0) {
+		dev_err(rxq->dpmaif_ctrl->dev, "Release BAT entry failed: %d\n", ret);
+		return ret;
+	}
+
+	return t7xx_dpmaif_rx_frag_alloc(rxq->dpmaif_ctrl, rxq->bat_frag, bid_cnt, false);
+}
+
+static void t7xx_dpmaif_parse_msg_pit(const struct dpmaif_rx_queue *rxq,
+				      const struct dpmaif_pit *msg_pit,
+				      struct dpmaif_cur_rx_skb_info *skb_info)
+{
+	int header = le32_to_cpu(msg_pit->header);
+
+	skb_info->cur_chn_idx = FIELD_GET(MSG_PIT_CHANNEL_ID, header);
+	skb_info->check_sum = FIELD_GET(MSG_PIT_CHECKSUM, header);
+	skb_info->pit_dp = FIELD_GET(MSG_PIT_DP, header);
+	skb_info->pkt_type = FIELD_GET(MSG_PIT_IP, le32_to_cpu(msg_pit->msg.params_3));
+}
+
+static int t7xx_dpmaif_set_data_to_skb(const struct dpmaif_rx_queue *rxq,
+				       const struct dpmaif_pit *pkt_info,
+				       struct dpmaif_cur_rx_skb_info *skb_info)
+{
+	unsigned long long data_bus_addr, data_base_addr;
+	struct device *dev = rxq->dpmaif_ctrl->dev;
+	struct dpmaif_bat_skb *bat_skb;
+	unsigned int data_len;
+	struct sk_buff *skb;
+	int data_offset;
+
+	bat_skb = rxq->bat_req->bat_skb;
+	bat_skb += t7xx_normal_pit_bid(pkt_info);
+	dma_unmap_single(dev, bat_skb->data_bus_addr, bat_skb->data_len, DMA_FROM_DEVICE);
+
+	data_bus_addr = le32_to_cpu(pkt_info->pd.data_addr_h);
+	data_bus_addr = (data_bus_addr << 32) + le32_to_cpu(pkt_info->pd.data_addr_l);
+	data_base_addr = bat_skb->data_bus_addr;
+	data_offset = data_bus_addr - data_base_addr;
+	data_len = FIELD_GET(PD_PIT_DATA_LEN, le32_to_cpu(pkt_info->header));
+	skb = bat_skb->skb;
+	skb->len = 0;
+	skb_reset_tail_pointer(skb);
+	skb_reserve(skb, data_offset);
+
+	if (skb->tail + data_len > skb->end) {
+		dev_err(dev, "No buffer space available\n");
+		return -ENOBUFS;
+	}
+
+	skb_put(skb, data_len);
+	skb_info->cur_skb = skb;
+	bat_skb->skb = NULL;
+	return 0;
+}
+
+static int t7xx_dpmaif_get_rx_pkt(struct dpmaif_rx_queue *rxq,
+				  const struct dpmaif_pit *pkt_info,
+				  struct dpmaif_cur_rx_skb_info *skb_info)
+{
+	unsigned int cur_bid = t7xx_normal_pit_bid(pkt_info);
+	int ret;
+
+	ret = t7xx_bat_cur_bid_check(rxq, cur_bid);
+	if (ret < 0)
+		return ret;
+
+	ret = t7xx_dpmaif_set_data_to_skb(rxq, pkt_info, skb_info);
+	if (ret < 0) {
+		dev_err(rxq->dpmaif_ctrl->dev, "RX set data to skb failed: %d\n", ret);
+		return ret;
+	}
+
+	t7xx_dpmaif_set_bat_mask(rxq->bat_req, cur_bid);
+	return 0;
+}
+
+static int t7xx_dpmaifq_rx_notify_hw(struct dpmaif_rx_queue *rxq)
+{
+	struct dpmaif_ctrl *dpmaif_ctrl = rxq->dpmaif_ctrl;
+	int ret;
+
+	queue_work(dpmaif_ctrl->bat_release_wq, &dpmaif_ctrl->bat_release_work);
+
+	ret = t7xx_dpmaif_pit_release_and_add(rxq);
+	if (ret < 0)
+		dev_err(dpmaif_ctrl->dev, "RXQ%u update PIT failed: %d\n", rxq->index, ret);
+
+	return ret;
+}
+
+static void t7xx_dpmaif_rx_skb_enqueue(struct dpmaif_rx_queue *rxq, struct sk_buff *skb)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&rxq->skb_list.lock, flags);
+	if (rxq->skb_list.qlen < rxq->skb_list_max_len)
+		__skb_queue_tail(&rxq->skb_list, skb);
+	else
+		dev_kfree_skb_any(skb);
+	spin_unlock_irqrestore(&rxq->skb_list.lock, flags);
+}
+
+static void t7xx_dpmaif_rx_skb(struct dpmaif_rx_queue *rxq,
+			       struct dpmaif_cur_rx_skb_info *skb_info)
+{
+	struct sk_buff *skb = skb_info->cur_skb;
+	struct t7xx_skb_cb *skb_cb;
+	u8 netif_id;
+
+	skb_info->cur_skb = NULL;
+
+	if (skb_info->pit_dp) {
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	skb->ip_summed = skb_info->check_sum == DPMAIF_CS_RESULT_PASS ? CHECKSUM_UNNECESSARY :
+									CHECKSUM_NONE;
+	netif_id = FIELD_GET(NETIF_MASK, skb_info->cur_chn_idx);
+	skb_cb = T7XX_SKB_CB(skb);
+	skb_cb->netif_idx = netif_id;
+	skb_cb->rx_pkt_type = skb_info->pkt_type;
+	t7xx_dpmaif_rx_skb_enqueue(rxq, skb);
+}
+
+static int t7xx_dpmaif_rx_start(struct dpmaif_rx_queue *rxq, const unsigned int pit_cnt,
+				const unsigned long timeout)
+{
+	unsigned int cur_pit, pit_len, rx_cnt, recv_skb_cnt = 0;
+	struct device *dev = rxq->dpmaif_ctrl->dev;
+	struct dpmaif_cur_rx_skb_info *skb_info;
+	int ret = 0;
+
+	pit_len = rxq->pit_size_cnt;
+	skb_info = &rxq->rx_data_info;
+	cur_pit = rxq->pit_rd_idx;
+
+	for (rx_cnt = 0; rx_cnt < pit_cnt; rx_cnt++) {
+		struct dpmaif_pit *pkt_info;
+		u32 val;
+
+		if (!skb_info->msg_pit_received && time_after_eq(jiffies, timeout))
+			break;
+
+		pkt_info = (struct dpmaif_pit *)rxq->pit_base + cur_pit;
+		if (t7xx_dpmaif_check_pit_seq(rxq, pkt_info)) {
+			dev_err_ratelimited(dev, "RXQ%u checks PIT SEQ fail\n", rxq->index);
+			return -EAGAIN;
+		}
+
+		val = FIELD_GET(PD_PIT_PACKET_TYPE, le32_to_cpu(pkt_info->header));
+		if (val == DES_PT_MSG) {
+			if (skb_info->msg_pit_received)
+				dev_err(dev, "RXQ%u received repeated PIT\n", rxq->index);
+
+			skb_info->msg_pit_received = true;
+			t7xx_dpmaif_parse_msg_pit(rxq, pkt_info, skb_info);
+		} else { /* DES_PT_PD */
+			val = FIELD_GET(PD_PIT_BUFFER_TYPE, le32_to_cpu(pkt_info->header));
+			if (val != PKT_BUF_FRAG)
+				ret = t7xx_dpmaif_get_rx_pkt(rxq, pkt_info, skb_info);
+			else if (!skb_info->cur_skb)
+				ret = -EINVAL;
+			else
+				ret = t7xx_dpmaif_get_frag(rxq, pkt_info, skb_info);
+
+			if (ret < 0) {
+				skb_info->err_payload = 1;
+				dev_err_ratelimited(dev, "RXQ%u error payload\n", rxq->index);
+			}
+
+			val = FIELD_GET(PD_PIT_CONT, le32_to_cpu(pkt_info->header));
+			if (!val) {
+				if (!skb_info->err_payload) {
+					t7xx_dpmaif_rx_skb(rxq, skb_info);
+				} else if (skb_info->cur_skb) {
+					dev_kfree_skb_any(skb_info->cur_skb);
+					skb_info->cur_skb = NULL;
+				}
+
+				memset(skb_info, 0, sizeof(*skb_info));
+
+				recv_skb_cnt++;
+				if (!(recv_skb_cnt & DPMAIF_RX_PUSH_THRESHOLD_MASK)) {
+					wake_up_all(&rxq->rx_wq);
+					recv_skb_cnt = 0;
+				}
+			}
+		}
+
+		cur_pit = t7xx_ring_buf_get_next_wr_idx(pit_len, cur_pit);
+		rxq->pit_rd_idx = cur_pit;
+		rxq->pit_remain_release_cnt++;
+
+		if (rx_cnt > 0 && !(rx_cnt % DPMAIF_NOTIFY_RELEASE_COUNT)) {
+			ret = t7xx_dpmaifq_rx_notify_hw(rxq);
+			if (ret < 0)
+				break;
+		}
+	}
+
+	if (recv_skb_cnt)
+		wake_up_all(&rxq->rx_wq);
+
+	if (!ret)
+		ret = t7xx_dpmaifq_rx_notify_hw(rxq);
+
+	if (ret)
+		return ret;
+
+	return rx_cnt;
+}
+
+static unsigned int t7xx_dpmaifq_poll_pit(struct dpmaif_rx_queue *rxq)
+{
+	unsigned int hw_wr_idx, pit_cnt;
+
+	if (!rxq->que_started)
+		return 0;
+
+	hw_wr_idx = t7xx_dpmaif_dl_dlq_pit_get_wr_idx(&rxq->dpmaif_ctrl->hw_info, rxq->index);
+	pit_cnt = t7xx_ring_buf_rd_wr_count(rxq->pit_size_cnt, rxq->pit_rd_idx, hw_wr_idx,
+					    DPMAIF_READ);
+	rxq->pit_wr_idx = hw_wr_idx;
+	return pit_cnt;
+}
+
+static int t7xx_dpmaif_rx_data_collect(struct dpmaif_ctrl *dpmaif_ctrl,
+				       const unsigned int q_num, const unsigned int budget)
+{
+	struct dpmaif_rx_queue *rxq = &dpmaif_ctrl->rxq[q_num];
+	unsigned long time_limit;
+	unsigned int cnt;
+
+	time_limit = jiffies + msecs_to_jiffies(DPMAIF_WQ_TIME_LIMIT_MS);
+
+	while ((cnt = t7xx_dpmaifq_poll_pit(rxq))) {
+		unsigned int rd_cnt;
+		int real_cnt;
+
+		rd_cnt = min(cnt, budget);
+
+		real_cnt = t7xx_dpmaif_rx_start(rxq, rd_cnt, time_limit);
+		if (real_cnt < 0)
+			return real_cnt;
+
+		if (real_cnt < cnt)
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static void t7xx_dpmaif_do_rx(struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_rx_queue *rxq)
+{
+	struct dpmaif_hw_info *hw_info = &dpmaif_ctrl->hw_info;
+	int ret;
+
+	ret = t7xx_dpmaif_rx_data_collect(dpmaif_ctrl, rxq->index, rxq->budget);
+	if (ret < 0) {
+		/* Try one more time */
+		queue_work(rxq->worker, &rxq->dpmaif_rxq_work);
+		t7xx_dpmaif_clr_ip_busy_sts(hw_info);
+	} else {
+		t7xx_dpmaif_clr_ip_busy_sts(hw_info);
+		t7xx_dpmaif_dlq_unmask_rx_done(hw_info, rxq->index);
+	}
+}
+
+static void t7xx_dpmaif_rxq_work(struct work_struct *work)
+{
+	struct dpmaif_rx_queue *rxq = container_of(work, struct dpmaif_rx_queue, dpmaif_rxq_work);
+	struct dpmaif_ctrl *dpmaif_ctrl = rxq->dpmaif_ctrl;
+
+	atomic_set(&rxq->rx_processing, 1);
+	/* Ensure rx_processing is changed to 1 before actually begin RX flow */
+	smp_mb();
+
+	if (!rxq->que_started) {
+		atomic_set(&rxq->rx_processing, 0);
+		dev_err(dpmaif_ctrl->dev, "Work RXQ: %d has not been started\n", rxq->index);
+		return;
+	}
+
+	t7xx_dpmaif_do_rx(dpmaif_ctrl, rxq);
+	atomic_set(&rxq->rx_processing, 0);
+}
+
+void t7xx_dpmaif_irq_rx_done(struct dpmaif_ctrl *dpmaif_ctrl, const unsigned int que_mask)
+{
+	struct dpmaif_rx_queue *rxq;
+	int qno;
+
+	qno = ffs(que_mask) - 1;
+	if (qno < 0 || qno > DPMAIF_RXQ_NUM - 1) {
+		dev_err(dpmaif_ctrl->dev, "Invalid RXQ number: %u\n", qno);
+		return;
+	}
+
+	rxq = &dpmaif_ctrl->rxq[qno];
+	queue_work(rxq->worker, &rxq->dpmaif_rxq_work);
+}
+
+static void t7xx_dpmaif_base_free(const struct dpmaif_ctrl *dpmaif_ctrl,
+				  const struct dpmaif_bat_request *bat_req)
+{
+	if (bat_req->bat_base)
+		dma_free_coherent(dpmaif_ctrl->dev,
+				  bat_req->bat_size_cnt * sizeof(struct dpmaif_bat),
+				  bat_req->bat_base, bat_req->bat_bus_addr);
+}
+
+/**
+ * t7xx_dpmaif_bat_alloc() - Allocate the BAT ring buffer.
+ * @dpmaif_ctrl: Pointer to DPMAIF context structure.
+ * @bat_req: Pointer to BAT request structure.
+ * @buf_type: BAT ring type.
+ *
+ * This function allocates the BAT ring buffer shared with the HW device, also allocates
+ * a buffer used to store information about the BAT skbs for further release.
+ *
+ * Return:
+ * * 0		- Success.
+ * * -ERROR	- Error code.
+ */
+int t7xx_dpmaif_bat_alloc(const struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_bat_request *bat_req,
+			  const enum bat_type buf_type)
+{
+	int sw_buf_size;
+
+	if (buf_type == BAT_TYPE_FRAG) {
+		sw_buf_size = sizeof(struct dpmaif_bat_page);
+		bat_req->bat_size_cnt = DPMAIF_FRG_COUNT;
+		bat_req->pkt_buf_sz = DPMAIF_HW_FRG_PKTBUF;
+	} else {
+		sw_buf_size = sizeof(struct dpmaif_bat_skb);
+		bat_req->bat_size_cnt = DPMAIF_BAT_COUNT;
+		bat_req->pkt_buf_sz = DPMAIF_HW_BAT_PKTBUF;
+	}
+
+	bat_req->type = buf_type;
+	bat_req->bat_wr_idx = 0;
+	bat_req->bat_release_rd_idx = 0;
+
+	bat_req->bat_base = dma_alloc_coherent(dpmaif_ctrl->dev,
+					       bat_req->bat_size_cnt * sizeof(struct dpmaif_bat),
+					       &bat_req->bat_bus_addr, GFP_KERNEL | __GFP_ZERO);
+	if (!bat_req->bat_base)
+		return -ENOMEM;
+
+	/* For AP SW to record skb information */
+	bat_req->bat_skb = devm_kzalloc(dpmaif_ctrl->dev, bat_req->bat_size_cnt * sw_buf_size,
+					GFP_KERNEL);
+	if (!bat_req->bat_skb)
+		goto err_free_dma_mem;
+
+	bat_req->bat_bitmap = bitmap_zalloc(bat_req->bat_size_cnt, GFP_KERNEL);
+	if (!bat_req->bat_bitmap)
+		goto err_free_dma_mem;
+
+	spin_lock_init(&bat_req->mask_lock);
+	atomic_set(&bat_req->refcnt, 0);
+	return 0;
+
+err_free_dma_mem:
+	t7xx_dpmaif_base_free(dpmaif_ctrl, bat_req);
+
+	return -ENOMEM;
+}
+
+void t7xx_dpmaif_bat_free(const struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_bat_request *bat_req)
+{
+	if (!bat_req || !atomic_dec_and_test(&bat_req->refcnt))
+		return;
+
+	bitmap_free(bat_req->bat_bitmap);
+	bat_req->bat_bitmap = NULL;
+
+	if (bat_req->bat_skb) {
+		unsigned int i;
+
+		for (i = 0; i < bat_req->bat_size_cnt; i++) {
+			if (bat_req->type == BAT_TYPE_FRAG)
+				t7xx_unmap_bat_page(dpmaif_ctrl->dev, bat_req->bat_skb, i);
+			else
+				t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
+		}
+	}
+
+	t7xx_dpmaif_base_free(dpmaif_ctrl, bat_req);
+}
+
+static int t7xx_dpmaif_rx_alloc(struct dpmaif_rx_queue *rxq)
+{
+	rxq->pit_size_cnt = DPMAIF_PIT_COUNT;
+	rxq->pit_rd_idx = 0;
+	rxq->pit_wr_idx = 0;
+	rxq->pit_release_rd_idx = 0;
+	rxq->expect_pit_seq = 0;
+	rxq->pit_remain_release_cnt = 0;
+	memset(&rxq->rx_data_info, 0, sizeof(rxq->rx_data_info));
+
+	rxq->pit_base = dma_alloc_coherent(rxq->dpmaif_ctrl->dev,
+					   rxq->pit_size_cnt * sizeof(struct dpmaif_pit),
+					   &rxq->pit_bus_addr, GFP_KERNEL | __GFP_ZERO);
+	if (!rxq->pit_base)
+		return -ENOMEM;
+
+	rxq->bat_req = &rxq->dpmaif_ctrl->bat_req;
+	atomic_inc(&rxq->bat_req->refcnt);
+
+	rxq->bat_frag = &rxq->dpmaif_ctrl->bat_frag;
+	atomic_inc(&rxq->bat_frag->refcnt);
+	return 0;
+}
+
+static void t7xx_dpmaif_rx_buf_free(const struct dpmaif_rx_queue *rxq)
+{
+	if (!rxq->dpmaif_ctrl)
+		return;
+
+	t7xx_dpmaif_bat_free(rxq->dpmaif_ctrl, rxq->bat_req);
+	t7xx_dpmaif_bat_free(rxq->dpmaif_ctrl, rxq->bat_frag);
+
+	if (rxq->pit_base)
+		dma_free_coherent(rxq->dpmaif_ctrl->dev,
+				  rxq->pit_size_cnt * sizeof(struct dpmaif_pit),
+				  rxq->pit_base, rxq->pit_bus_addr);
+}
+
+int t7xx_dpmaif_rxq_init(struct dpmaif_rx_queue *queue)
+{
+	int ret;
+
+	ret = t7xx_dpmaif_rx_alloc(queue);
+	if (ret < 0) {
+		dev_err(queue->dpmaif_ctrl->dev, "Failed to allocate RX buffers: %d\n", ret);
+		return ret;
+	}
+
+	INIT_WORK(&queue->dpmaif_rxq_work, t7xx_dpmaif_rxq_work);
+
+	queue->worker = alloc_workqueue("dpmaif_rx%d_worker",
+					WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI, 1, queue->index);
+	if (!queue->worker) {
+		ret = -ENOMEM;
+		goto err_free_rx_buffer;
+	}
+
+	init_waitqueue_head(&queue->rx_wq);
+	skb_queue_head_init(&queue->skb_list);
+	queue->skb_list_max_len = queue->bat_req->pkt_buf_sz;
+	queue->rx_thread = kthread_run(t7xx_dpmaif_net_rx_push_thread,
+				       queue, "dpmaif_rx%d_push", queue->index);
+
+	ret = PTR_ERR_OR_ZERO(queue->rx_thread);
+	if (ret)
+		goto err_free_workqueue;
+
+	return 0;
+
+err_free_workqueue:
+	destroy_workqueue(queue->worker);
+
+err_free_rx_buffer:
+	t7xx_dpmaif_rx_buf_free(queue);
+
+	return ret;
+}
+
+void t7xx_dpmaif_rxq_free(struct dpmaif_rx_queue *queue)
+{
+	if (queue->worker)
+		destroy_workqueue(queue->worker);
+
+	if (queue->rx_thread)
+		kthread_stop(queue->rx_thread);
+
+	skb_queue_purge(&queue->skb_list);
+	t7xx_dpmaif_rx_buf_free(queue);
+}
+
+static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
+{
+	struct dpmaif_ctrl *dpmaif_ctrl = container_of(work, struct dpmaif_ctrl, bat_release_work);
+	struct dpmaif_rx_queue *rxq;
+
+	/* ALL RXQ use one BAT table, so choose DPF_RX_QNO_DFT */
+	rxq = &dpmaif_ctrl->rxq[DPF_RX_QNO_DFT];
+	t7xx_dpmaif_bat_release_and_add(rxq);
+	t7xx_dpmaif_frag_bat_release_and_add(rxq);
+}
+
+int t7xx_dpmaif_bat_rel_wq_alloc(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	dpmaif_ctrl->bat_release_wq = alloc_workqueue("dpmaif_bat_release_work_queue",
+						      WQ_MEM_RECLAIM, 1);
+	if (!dpmaif_ctrl->bat_release_wq)
+		return -ENOMEM;
+
+	INIT_WORK(&dpmaif_ctrl->bat_release_work, t7xx_dpmaif_bat_release_work);
+	return 0;
+}
+
+void t7xx_dpmaif_bat_wq_rel(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	flush_work(&dpmaif_ctrl->bat_release_work);
+
+	if (dpmaif_ctrl->bat_release_wq) {
+		destroy_workqueue(dpmaif_ctrl->bat_release_wq);
+		dpmaif_ctrl->bat_release_wq = NULL;
+	}
+}
+
+/**
+ * t7xx_dpmaif_rx_stop() - Suspend RX flow.
+ * @dpmaif_ctrl: Pointer to data path control struct dpmaif_ctrl.
+ *
+ * Wait for all the RX work to finish executing and mark the RX queue as paused.
+ */
+void t7xx_dpmaif_rx_stop(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	unsigned int i;
+
+	for (i = 0; i < DPMAIF_RXQ_NUM; i++) {
+		struct dpmaif_rx_queue *rxq = &dpmaif_ctrl->rxq[i];
+		int timeout, value;
+
+		flush_work(&rxq->dpmaif_rxq_work);
+
+		timeout = readx_poll_timeout_atomic(atomic_read, &rxq->rx_processing, value,
+						    !value, 0, DPMAIF_CHECK_INIT_TIMEOUT_US);
+		if (timeout)
+			dev_err(dpmaif_ctrl->dev, "Stop RX SW failed\n");
+
+		/* Ensure RX processing has stopped before we set rxq->que_started to false */
+		smp_mb();
+		rxq->que_started = false;
+	}
+}
+
+static void t7xx_dpmaif_stop_rxq(struct dpmaif_rx_queue *rxq)
+{
+	int cnt, j = 0;
+
+	flush_work(&rxq->dpmaif_rxq_work);
+	rxq->que_started = false;
+
+	do {
+		cnt = t7xx_ring_buf_rd_wr_count(rxq->pit_size_cnt, rxq->pit_rd_idx,
+						rxq->pit_wr_idx, DPMAIF_READ);
+
+		if (++j >= DPMAIF_MAX_CHECK_COUNT) {
+			dev_err(rxq->dpmaif_ctrl->dev, "Stop RX SW failed, %d\n", cnt);
+			break;
+		}
+	} while (cnt);
+
+	memset(rxq->pit_base, 0, rxq->pit_size_cnt * sizeof(struct dpmaif_pit));
+	memset(rxq->bat_req->bat_base, 0, rxq->bat_req->bat_size_cnt * sizeof(struct dpmaif_bat));
+	bitmap_zero(rxq->bat_req->bat_bitmap, rxq->bat_req->bat_size_cnt);
+	memset(&rxq->rx_data_info, 0, sizeof(rxq->rx_data_info));
+
+	rxq->pit_rd_idx = 0;
+	rxq->pit_wr_idx = 0;
+	rxq->pit_release_rd_idx = 0;
+	rxq->expect_pit_seq = 0;
+	rxq->pit_remain_release_cnt = 0;
+	rxq->bat_req->bat_release_rd_idx = 0;
+	rxq->bat_req->bat_wr_idx = 0;
+	rxq->bat_frag->bat_release_rd_idx = 0;
+	rxq->bat_frag->bat_wr_idx = 0;
+}
+
+void t7xx_dpmaif_rx_clear(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	int i;
+
+	for (i = 0; i < DPMAIF_RXQ_NUM; i++)
+		t7xx_dpmaif_stop_rxq(&dpmaif_ctrl->rxq[i]);
+}
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h
new file mode 100644
index 000000000000..182f62dfe398
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Ricardo Martinez <ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#ifndef __T7XX_HIF_DPMA_RX_H__
+#define __T7XX_HIF_DPMA_RX_H__
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#include "t7xx_hif_dpmaif.h"
+
+#define NETIF_MASK		GENMASK(4, 0)
+
+#define PKT_TYPE_IP4		0
+#define PKT_TYPE_IP6		1
+
+/* Structure of DL PIT */
+struct dpmaif_pit {
+	__le32 header;
+	union {
+		struct {
+			__le32 data_addr_l;
+			__le32 data_addr_h;
+			__le32 footer;
+		} pd;
+		struct {
+			__le32 params_1;
+			__le32 params_2;
+			__le32 params_3;
+		} msg;
+	};
+};
+
+/* PIT header fields */
+#define PD_PIT_DATA_LEN		GENMASK(31, 16)
+#define PD_PIT_BUFFER_ID	GENMASK(15, 3)
+#define PD_PIT_BUFFER_TYPE	BIT(2)
+#define PD_PIT_CONT		BIT(1)
+#define PD_PIT_PACKET_TYPE	BIT(0)
+/* PIT footer fields */
+#define PD_PIT_DLQ_DONE		GENMASK(31, 30)
+#define PD_PIT_ULQ_DONE		GENMASK(29, 24)
+#define PD_PIT_HEADER_OFFSET	GENMASK(23, 19)
+#define PD_PIT_BI_F		GENMASK(18, 17)
+#define PD_PIT_IG		BIT(16)
+#define PD_PIT_RES		GENMASK(15, 11)
+#define PD_PIT_H_BID		GENMASK(10, 8)
+#define PD_PIT_PIT_SEQ		GENMASK(7, 0)
+
+#define MSG_PIT_DP		BIT(31)
+#define MSG_PIT_RES		GENMASK(30, 27)
+#define MSG_PIT_NETWORK_TYPE	GENMASK(26, 24)
+#define MSG_PIT_CHANNEL_ID	GENMASK(23, 16)
+#define MSG_PIT_RES2		GENMASK(15, 12)
+#define MSG_PIT_HPC_IDX		GENMASK(11, 8)
+#define MSG_PIT_SRC_QID		GENMASK(7, 5)
+#define MSG_PIT_ERROR_BIT	BIT(4)
+#define MSG_PIT_CHECKSUM	GENMASK(3, 2)
+#define MSG_PIT_CONT		BIT(1)
+#define MSG_PIT_PACKET_TYPE	BIT(0)
+
+#define MSG_PIT_HP_IDX		GENMASK(31, 27)
+#define MSG_PIT_CMD		GENMASK(26, 24)
+#define MSG_PIT_RES3		GENMASK(23, 21)
+#define MSG_PIT_FLOW		GENMASK(20, 16)
+#define MSG_PIT_COUNT		GENMASK(15, 0)
+
+#define MSG_PIT_HASH		GENMASK(31, 24)
+#define MSG_PIT_RES4		GENMASK(23, 18)
+#define MSG_PIT_PRO		GENMASK(17, 16)
+#define MSG_PIT_VBID		GENMASK(15, 3)
+#define MSG_PIT_RES5		GENMASK(2, 0)
+
+#define MSG_PIT_DLQ_DONE	GENMASK(31, 30)
+#define MSG_PIT_ULQ_DONE	GENMASK(29, 24)
+#define MSG_PIT_IP		BIT(23)
+#define MSG_PIT_RES6		BIT(22)
+#define MSG_PIT_MR		GENMASK(21, 20)
+#define MSG_PIT_RES7		GENMASK(19, 17)
+#define MSG_PIT_IG		BIT(16)
+#define MSG_PIT_RES8		GENMASK(15, 11)
+#define MSG_PIT_H_BID		GENMASK(10, 8)
+#define MSG_PIT_PIT_SEQ		GENMASK(7, 0)
+
+int t7xx_dpmaif_rxq_init(struct dpmaif_rx_queue *queue);
+void t7xx_dpmaif_rx_clear(struct dpmaif_ctrl *dpmaif_ctrl);
+int t7xx_dpmaif_bat_rel_wq_alloc(struct dpmaif_ctrl *dpmaif_ctrl);
+int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpmaif_ctrl,
+			     const struct dpmaif_bat_request *bat_req,
+			     const unsigned int q_num, const unsigned int buf_cnt,
+			     const bool initial);
+int t7xx_dpmaif_rx_frag_alloc(struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_bat_request *bat_req,
+			      const unsigned int buf_cnt, const bool first_time);
+void t7xx_dpmaif_rx_stop(struct dpmaif_ctrl *dpmaif_ctrl);
+void t7xx_dpmaif_irq_rx_done(struct dpmaif_ctrl *dpmaif_ctrl, const unsigned int que_mask);
+void t7xx_dpmaif_rxq_free(struct dpmaif_rx_queue *queue);
+void t7xx_dpmaif_bat_wq_rel(struct dpmaif_ctrl *dpmaif_ctrl);
+int t7xx_dpmaif_bat_alloc(const struct dpmaif_ctrl *dpmaif_ctrl, struct dpmaif_bat_request *bat_req,
+			  const enum bat_type buf_type);
+void t7xx_dpmaif_bat_free(const struct dpmaif_ctrl *dpmaif_ctrl,
+			  struct dpmaif_bat_request *bat_req);
+
+#endif /* __T7XX_HIF_DPMA_RX_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
new file mode 100644
index 000000000000..b6c43c538a10
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Ricardo Martinez <ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/minmax.h>
+#include <linux/netdevice.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+
+#include "t7xx_dpmaif.h"
+#include "t7xx_hif_dpmaif.h"
+#include "t7xx_hif_dpmaif_tx.h"
+#include "t7xx_pci.h"
+
+#define DPMAIF_SKB_TX_BURST_CNT	5
+#define DPMAIF_DRB_LIST_LEN	6144
+
+/* DRB dtype */
+#define DES_DTYP_PD		0
+#define DES_DTYP_MSG		1
+
+static unsigned int t7xx_dpmaif_update_drb_rd_idx(struct dpmaif_ctrl *dpmaif_ctrl,
+						  unsigned int q_num)
+{
+	struct dpmaif_tx_queue *txq = &dpmaif_ctrl->txq[q_num];
+	unsigned int old_sw_rd_idx, new_hw_rd_idx, drb_cnt;
+	unsigned long flags;
+
+	if (!txq->que_started)
+		return 0;
+
+	old_sw_rd_idx = txq->drb_rd_idx;
+	new_hw_rd_idx = t7xx_dpmaif_ul_get_rd_idx(&dpmaif_ctrl->hw_info, q_num);
+	if (new_hw_rd_idx >= DPMAIF_DRB_LIST_LEN) {
+		dev_err(dpmaif_ctrl->dev, "Out of range read index: %u\n", new_hw_rd_idx);
+		return 0;
+	}
+
+	if (old_sw_rd_idx <= new_hw_rd_idx)
+		drb_cnt = new_hw_rd_idx - old_sw_rd_idx;
+	else
+		drb_cnt = txq->drb_size_cnt - old_sw_rd_idx + new_hw_rd_idx;
+
+	spin_lock_irqsave(&txq->tx_lock, flags);
+	txq->drb_rd_idx = new_hw_rd_idx;
+	spin_unlock_irqrestore(&txq->tx_lock, flags);
+
+	return drb_cnt;
+}
+
+static unsigned int t7xx_dpmaif_release_tx_buffer(struct dpmaif_ctrl *dpmaif_ctrl,
+						  unsigned int q_num, unsigned int release_cnt)
+{
+	struct dpmaif_tx_queue *txq = &dpmaif_ctrl->txq[q_num];
+	struct dpmaif_callbacks *cb = dpmaif_ctrl->callbacks;
+	struct dpmaif_drb_skb *cur_drb_skb, *drb_skb_base;
+	struct dpmaif_drb *cur_drb, *drb_base;
+	unsigned int drb_cnt, i, cur_idx;
+	unsigned long flags;
+
+	drb_skb_base = txq->drb_skb_base;
+	drb_base = txq->drb_base;
+
+	spin_lock_irqsave(&txq->tx_lock, flags);
+	drb_cnt = txq->drb_size_cnt;
+	cur_idx = txq->drb_release_rd_idx;
+	spin_unlock_irqrestore(&txq->tx_lock, flags);
+
+	for (i = 0; i < release_cnt; i++) {
+		cur_drb = drb_base + cur_idx;
+		if (FIELD_GET(DRB_HDR_DTYP, le32_to_cpu(cur_drb->header)) == DES_DTYP_PD) {
+			cur_drb_skb = drb_skb_base + cur_idx;
+			if (!cur_drb_skb->is_msg)
+				dma_unmap_single(dpmaif_ctrl->dev, cur_drb_skb->bus_addr,
+						 cur_drb_skb->data_len, DMA_TO_DEVICE);
+
+			if (!FIELD_GET(DRB_HDR_CONT, le32_to_cpu(cur_drb->header))) {
+				if (!cur_drb_skb->skb) {
+					dev_err(dpmaif_ctrl->dev,
+						"txq%u: DRB check fail, invalid skb\n", q_num);
+					continue;
+				}
+
+				dev_kfree_skb_any(cur_drb_skb->skb);
+			}
+
+			cur_drb_skb->skb = NULL;
+		}
+
+		spin_lock_irqsave(&txq->tx_lock, flags);
+		cur_idx = t7xx_ring_buf_get_next_wr_idx(drb_cnt, cur_idx);
+		txq->drb_release_rd_idx = cur_idx;
+		spin_unlock_irqrestore(&txq->tx_lock, flags);
+
+		if (atomic_inc_return(&txq->tx_budget) > txq->drb_size_cnt / 8)
+			cb->state_notify(dpmaif_ctrl->t7xx_dev, DMPAIF_TXQ_STATE_IRQ, txq->index);
+	}
+
+	if (FIELD_GET(DRB_HDR_CONT, le32_to_cpu(cur_drb->header)))
+		dev_err(dpmaif_ctrl->dev, "txq%u: DRB not marked as the last one\n", q_num);
+
+	return i;
+}
+
+static int t7xx_dpmaif_tx_release(struct dpmaif_ctrl *dpmaif_ctrl,
+				  unsigned int q_num, unsigned int budget)
+{
+	struct dpmaif_tx_queue *txq = &dpmaif_ctrl->txq[q_num];
+	unsigned int rel_cnt, real_rel_cnt;
+
+	/* Update read index from HW */
+	t7xx_dpmaif_update_drb_rd_idx(dpmaif_ctrl, q_num);
+
+	rel_cnt = t7xx_ring_buf_rd_wr_count(txq->drb_size_cnt, txq->drb_release_rd_idx,
+					    txq->drb_rd_idx, DPMAIF_READ);
+
+	real_rel_cnt = min_not_zero(budget, rel_cnt);
+	if (real_rel_cnt)
+		real_rel_cnt = t7xx_dpmaif_release_tx_buffer(dpmaif_ctrl, q_num, real_rel_cnt);
+
+	return real_rel_cnt < rel_cnt ? -EAGAIN : 0;
+}
+
+static bool t7xx_dpmaif_drb_ring_not_empty(struct dpmaif_tx_queue *txq)
+{
+	return !!t7xx_dpmaif_update_drb_rd_idx(txq->dpmaif_ctrl, txq->index);
+}
+
+static void t7xx_dpmaif_tx_done(struct work_struct *work)
+{
+	struct dpmaif_tx_queue *txq = container_of(work, struct dpmaif_tx_queue, dpmaif_tx_work);
+	struct dpmaif_ctrl *dpmaif_ctrl = txq->dpmaif_ctrl;
+	struct dpmaif_hw_info *hw_info;
+	int ret;
+
+	hw_info = &dpmaif_ctrl->hw_info;
+	ret = t7xx_dpmaif_tx_release(dpmaif_ctrl, txq->index, txq->drb_size_cnt);
+	if (ret == -EAGAIN ||
+	    (t7xx_dpmaif_ul_clr_done(hw_info, txq->index) &&
+	     t7xx_dpmaif_drb_ring_not_empty(txq))) {
+		queue_work(dpmaif_ctrl->txq[txq->index].worker,
+			   &dpmaif_ctrl->txq[txq->index].dpmaif_tx_work);
+		/* Give the device time to enter the low power state */
+		t7xx_dpmaif_clr_ip_busy_sts(hw_info);
+	} else {
+		t7xx_dpmaif_clr_ip_busy_sts(hw_info);
+		t7xx_dpmaif_unmask_ulq_intr(hw_info, txq->index);
+	}
+}
+
+static void t7xx_setup_msg_drb(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int q_num,
+			       unsigned int cur_idx, unsigned int pkt_len, unsigned int count_l,
+			       unsigned int channel_id)
+{
+	struct dpmaif_drb *drb_base = dpmaif_ctrl->txq[q_num].drb_base;
+	struct dpmaif_drb *drb = drb_base + cur_idx;
+
+	drb->header = cpu_to_le32(FIELD_PREP(DRB_HDR_DTYP, DES_DTYP_MSG) |
+				  FIELD_PREP(DRB_HDR_CONT, 1) |
+				  FIELD_PREP(DRB_HDR_DATA_LEN, pkt_len));
+
+	drb->msg.msg_hdr = cpu_to_le32(FIELD_PREP(DRB_MSG_COUNT_L, count_l) |
+				       FIELD_PREP(DRB_MSG_CHANNEL_ID, channel_id) |
+				       FIELD_PREP(DRB_MSG_L4_CHK, 1));
+}
+
+static void t7xx_setup_payload_drb(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int q_num,
+				   unsigned int cur_idx, dma_addr_t data_addr,
+				   unsigned int pkt_size, bool last_one)
+{
+	struct dpmaif_drb *drb_base = dpmaif_ctrl->txq[q_num].drb_base;
+	struct dpmaif_drb *drb = drb_base + cur_idx;
+	u32 header;
+
+	header = FIELD_PREP(DRB_HDR_DTYP, DES_DTYP_PD) | FIELD_PREP(DRB_HDR_DATA_LEN, pkt_size);
+	if (!last_one)
+		header |= FIELD_PREP(DRB_HDR_CONT, 1);
+
+	drb->header = cpu_to_le32(header);
+	drb->pd.data_addr_l = cpu_to_le32(lower_32_bits(data_addr));
+	drb->pd.data_addr_h = cpu_to_le32(upper_32_bits(data_addr));
+}
+
+static void t7xx_record_drb_skb(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int q_num,
+				unsigned int cur_idx, struct sk_buff *skb, bool is_msg,
+				bool is_frag, bool is_last_one, dma_addr_t bus_addr,
+				unsigned int data_len)
+{
+	struct dpmaif_drb_skb *drb_skb_base = dpmaif_ctrl->txq[q_num].drb_skb_base;
+	struct dpmaif_drb_skb *drb_skb = drb_skb_base + cur_idx;
+
+	drb_skb->skb = skb;
+	drb_skb->bus_addr = bus_addr;
+	drb_skb->data_len = data_len;
+	drb_skb->index = cur_idx;
+	drb_skb->is_msg = is_msg;
+	drb_skb->is_frag = is_frag;
+	drb_skb->is_last = is_last_one;
+}
+
+static int t7xx_dpmaif_add_skb_to_ring(struct dpmaif_ctrl *dpmaif_ctrl, struct sk_buff *skb)
+{
+	unsigned int wr_cnt, send_cnt, payload_cnt;
+	unsigned int cur_idx, drb_wr_idx_backup;
+	struct skb_shared_info *shinfo;
+	struct dpmaif_tx_queue *txq;
+	struct t7xx_skb_cb *skb_cb;
+	unsigned long flags;
+
+	skb_cb = T7XX_SKB_CB(skb);
+	txq = &dpmaif_ctrl->txq[skb_cb->txq_number];
+	if (!txq->que_started || dpmaif_ctrl->state != DPMAIF_STATE_PWRON)
+		return -ENODEV;
+
+	atomic_set(&txq->tx_processing, 1);
+	 /* Ensure tx_processing is changed to 1 before actually begin TX flow */
+	smp_mb();
+
+	shinfo = skb_shinfo(skb);
+	if (shinfo->frag_list)
+		dev_warn_ratelimited(dpmaif_ctrl->dev, "frag_list not supported\n");
+
+	payload_cnt = shinfo->nr_frags + 1;
+	/* nr_frags: frag cnt, 1: skb->data, 1: msg DRB */
+	send_cnt = payload_cnt + 1;
+
+	spin_lock_irqsave(&txq->tx_lock, flags);
+	cur_idx = txq->drb_wr_idx;
+	drb_wr_idx_backup = cur_idx;
+	txq->drb_wr_idx += send_cnt;
+	if (txq->drb_wr_idx >= txq->drb_size_cnt)
+		txq->drb_wr_idx -= txq->drb_size_cnt;
+	t7xx_setup_msg_drb(dpmaif_ctrl, txq->index, cur_idx, skb->len, 0, skb_cb->netif_idx);
+	t7xx_record_drb_skb(dpmaif_ctrl, txq->index, cur_idx, skb, true, 0, 0, 0, 0);
+	spin_unlock_irqrestore(&txq->tx_lock, flags);
+
+	for (wr_cnt = 0; wr_cnt < payload_cnt; wr_cnt++) {
+		bool is_frag, is_last_one = wr_cnt == payload_cnt - 1;
+		unsigned int data_len;
+		dma_addr_t bus_addr;
+		void *data_addr;
+
+		if (!wr_cnt) {
+			data_len = skb_headlen(skb);
+			data_addr = skb->data;
+			is_frag = false;
+		} else {
+			skb_frag_t *frag = shinfo->frags + wr_cnt - 1;
+
+			data_len = skb_frag_size(frag);
+			data_addr = skb_frag_address(frag);
+			is_frag = true;
+		}
+
+		bus_addr = dma_map_single(dpmaif_ctrl->dev, data_addr, data_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(dpmaif_ctrl->dev, bus_addr))
+			goto unmap_buffers;
+
+		cur_idx = t7xx_ring_buf_get_next_wr_idx(txq->drb_size_cnt, cur_idx);
+
+		spin_lock_irqsave(&txq->tx_lock, flags);
+		t7xx_setup_payload_drb(dpmaif_ctrl, txq->index, cur_idx, bus_addr, data_len,
+				       is_last_one);
+		t7xx_record_drb_skb(dpmaif_ctrl, txq->index, cur_idx, skb, false, is_frag,
+				    is_last_one, bus_addr, data_len);
+		spin_unlock_irqrestore(&txq->tx_lock, flags);
+	}
+
+	atomic_sub(send_cnt, &txq->tx_budget);
+	atomic_set(&txq->tx_processing, 0);
+
+	return 0;
+
+unmap_buffers:
+	while (wr_cnt--) {
+		struct dpmaif_drb_skb *drb_skb = txq->drb_skb_base;
+
+		cur_idx = cur_idx ? cur_idx - 1 : txq->drb_size_cnt - 1;
+		drb_skb += cur_idx;
+		dma_unmap_single(dpmaif_ctrl->dev, drb_skb->bus_addr,
+				 drb_skb->data_len, DMA_TO_DEVICE);
+	}
+
+	txq->drb_wr_idx = drb_wr_idx_backup;
+	atomic_set(&txq->tx_processing, 0);
+
+	return -ENOMEM;
+}
+
+static bool t7xx_tx_lists_are_all_empty(const struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	int i;
+
+	for (i = 0; i < DPMAIF_TXQ_NUM; i++) {
+		if (!skb_queue_empty(&dpmaif_ctrl->txq[i].tx_skb_head))
+			return false;
+	}
+
+	return true;
+}
+
+/* Currently, only the default TX queue is used */
+static struct dpmaif_tx_queue *t7xx_select_tx_queue(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	struct dpmaif_tx_queue *txq;
+
+	txq = &dpmaif_ctrl->txq[DPMAIF_TX_DEFAULT_QUEUE];
+	if (!txq->que_started)
+		return NULL;
+
+	return txq;
+}
+
+static unsigned int t7xx_txq_drb_wr_available(struct dpmaif_tx_queue *txq)
+{
+	return t7xx_ring_buf_rd_wr_count(txq->drb_size_cnt, txq->drb_release_rd_idx,
+					 txq->drb_wr_idx, DPMAIF_WRITE);
+}
+
+static unsigned int t7xx_skb_drb_cnt(struct sk_buff *skb)
+{
+	/* Normal DRB (frags data + skb linear data) + msg DRB */
+	return skb_shinfo(skb)->nr_frags + 2;
+}
+
+static int t7xx_txq_burst_send_skb(struct dpmaif_tx_queue *txq)
+{
+	unsigned int drb_remain_cnt, i;
+	unsigned int send_drb_cnt;
+	int drb_cnt = 0;
+	int ret = 0;
+
+	drb_remain_cnt = t7xx_txq_drb_wr_available(txq);
+
+	for (i = 0; i < DPMAIF_SKB_TX_BURST_CNT; i++) {
+		struct sk_buff *skb;
+
+		skb = skb_peek(&txq->tx_skb_head);
+		if (!skb)
+			break;
+
+		send_drb_cnt = t7xx_skb_drb_cnt(skb);
+		if (drb_remain_cnt < send_drb_cnt) {
+			drb_remain_cnt = t7xx_txq_drb_wr_available(txq);
+			continue;
+		}
+
+		drb_remain_cnt -= send_drb_cnt;
+
+		ret = t7xx_dpmaif_add_skb_to_ring(txq->dpmaif_ctrl, skb);
+		if (ret < 0) {
+			dev_err(txq->dpmaif_ctrl->dev,
+				"Failed to add skb to device's ring: %d\n", ret);
+			break;
+		}
+
+		drb_cnt += send_drb_cnt;
+		skb_unlink(skb, &txq->tx_skb_head);
+	}
+
+	if (drb_cnt > 0)
+		return drb_cnt;
+
+	return ret;
+}
+
+static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	do {
+		struct dpmaif_tx_queue *txq;
+		int drb_send_cnt;
+
+		txq = t7xx_select_tx_queue(dpmaif_ctrl);
+		if (!txq)
+			return;
+
+		drb_send_cnt = t7xx_txq_burst_send_skb(txq);
+		if (drb_send_cnt <= 0) {
+			usleep_range(10, 20);
+			cond_resched();
+			continue;
+		}
+
+		t7xx_dpmaif_ul_update_hw_drb_cnt(&dpmaif_ctrl->hw_info, txq->index,
+						 drb_send_cnt * DPMAIF_UL_DRB_SIZE_WORD);
+
+		cond_resched();
+	} while (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) && !kthread_should_stop() &&
+		 (dpmaif_ctrl->state == DPMAIF_STATE_PWRON));
+}
+
+static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
+{
+	struct dpmaif_ctrl *dpmaif_ctrl = arg;
+
+	while (!kthread_should_stop()) {
+		if (t7xx_tx_lists_are_all_empty(dpmaif_ctrl) ||
+		    dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
+			if (wait_event_interruptible(dpmaif_ctrl->tx_wq,
+						     (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
+						     dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
+						     kthread_should_stop()))
+				continue;
+
+			if (kthread_should_stop())
+				break;
+		}
+
+		t7xx_do_tx_hw_push(dpmaif_ctrl);
+	}
+
+	return 0;
+}
+
+int t7xx_dpmaif_tx_thread_init(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	init_waitqueue_head(&dpmaif_ctrl->tx_wq);
+	dpmaif_ctrl->tx_thread = kthread_run(t7xx_dpmaif_tx_hw_push_thread,
+					     dpmaif_ctrl, "dpmaif_tx_hw_push");
+	return PTR_ERR_OR_ZERO(dpmaif_ctrl->tx_thread);
+}
+
+void t7xx_dpmaif_tx_thread_rel(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	if (dpmaif_ctrl->tx_thread)
+		kthread_stop(dpmaif_ctrl->tx_thread);
+}
+
+/**
+ * t7xx_dpmaif_tx_send_skb() - Add skb to the transmit queue.
+ * @dpmaif_ctrl: Pointer to struct dpmaif_ctrl.
+ * @txq_number: Queue number to xmit on.
+ * @skb: Pointer to the skb to transmit.
+ *
+ * Add the skb to the queue of the skbs to be transmit.
+ * Wake up the thread that push the skbs from the queue to the HW.
+ *
+ * Return:
+ * * 0		- Success.
+ * * -ERROR	- Error code from failure sub-initializations.
+ */
+int t7xx_dpmaif_tx_send_skb(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int txq_number,
+			    struct sk_buff *skb)
+{
+	struct dpmaif_tx_queue *txq = &dpmaif_ctrl->txq[txq_number];
+	struct dpmaif_callbacks *callbacks;
+	struct t7xx_skb_cb *skb_cb;
+
+	if (!(txq->tx_skb_stat++ % DPMAIF_SKB_TX_BURST_CNT)) {
+		unsigned int send_drb_cnt, drb_available_cnt;
+
+		send_drb_cnt = t7xx_skb_drb_cnt(skb);
+		drb_available_cnt = t7xx_txq_drb_wr_available(txq);
+		if (drb_available_cnt < send_drb_cnt)
+			goto report_full_state;
+	}
+
+	if (txq->tx_skb_head.qlen >= txq->tx_list_max_len)
+		goto report_full_state;
+
+	skb_cb = T7XX_SKB_CB(skb);
+	skb_cb->txq_number = txq_number;
+	skb_queue_tail(&txq->tx_skb_head, skb);
+	wake_up(&dpmaif_ctrl->tx_wq);
+	return 0;
+
+report_full_state:
+	callbacks = dpmaif_ctrl->callbacks;
+	callbacks->state_notify(dpmaif_ctrl->t7xx_dev, DMPAIF_TXQ_STATE_FULL, txq_number);
+	return -EBUSY;
+}
+
+void t7xx_dpmaif_irq_tx_done(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int que_mask)
+{
+	int i;
+
+	for (i = 0; i < DPMAIF_TXQ_NUM; i++) {
+		if (que_mask & BIT(i))
+			queue_work(dpmaif_ctrl->txq[i].worker, &dpmaif_ctrl->txq[i].dpmaif_tx_work);
+	}
+}
+
+static int t7xx_dpmaif_tx_drb_buf_init(struct dpmaif_tx_queue *txq)
+{
+	size_t brb_skb_size, brb_pd_size;
+
+	brb_pd_size = DPMAIF_DRB_LIST_LEN * sizeof(struct dpmaif_drb);
+	brb_skb_size = DPMAIF_DRB_LIST_LEN * sizeof(struct dpmaif_drb_skb);
+
+	txq->drb_size_cnt = DPMAIF_DRB_LIST_LEN;
+
+	/* For HW && AP SW */
+	txq->drb_base = dma_alloc_coherent(txq->dpmaif_ctrl->dev, brb_pd_size,
+					   &txq->drb_bus_addr, GFP_KERNEL | __GFP_ZERO);
+	if (!txq->drb_base)
+		return -ENOMEM;
+
+	/* For AP SW to record the skb information */
+	txq->drb_skb_base = devm_kzalloc(txq->dpmaif_ctrl->dev, brb_skb_size, GFP_KERNEL);
+	if (!txq->drb_skb_base) {
+		dma_free_coherent(txq->dpmaif_ctrl->dev, brb_pd_size,
+				  txq->drb_base, txq->drb_bus_addr);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void t7xx_dpmaif_tx_free_drb_skb(struct dpmaif_tx_queue *txq)
+{
+	struct dpmaif_drb_skb *drb_skb, *drb_skb_base = txq->drb_skb_base;
+	unsigned int i;
+
+	if (!drb_skb_base)
+		return;
+
+	for (i = 0; i < txq->drb_size_cnt; i++) {
+		drb_skb = drb_skb_base + i;
+		if (!drb_skb->skb)
+			continue;
+
+		if (!drb_skb->is_msg)
+			dma_unmap_single(txq->dpmaif_ctrl->dev, drb_skb->bus_addr,
+					 drb_skb->data_len, DMA_TO_DEVICE);
+
+		if (drb_skb->is_last) {
+			dev_kfree_skb(drb_skb->skb);
+			drb_skb->skb = NULL;
+		}
+	}
+}
+
+static void t7xx_dpmaif_tx_drb_buf_rel(struct dpmaif_tx_queue *txq)
+{
+	if (txq->drb_base)
+		dma_free_coherent(txq->dpmaif_ctrl->dev,
+				  txq->drb_size_cnt * sizeof(struct dpmaif_drb),
+				  txq->drb_base, txq->drb_bus_addr);
+
+	t7xx_dpmaif_tx_free_drb_skb(txq);
+}
+
+/**
+ * t7xx_dpmaif_txq_init() - Initialize TX queue.
+ * @txq: Pointer to struct dpmaif_tx_queue.
+ *
+ * Initialize the TX queue data structure and allocate memory for it to use.
+ *
+ * Return:
+ * * 0		- Success.
+ * * -ERROR	- Error code from failure sub-initializations.
+ */
+int t7xx_dpmaif_txq_init(struct dpmaif_tx_queue *txq)
+{
+	int ret;
+
+	skb_queue_head_init(&txq->tx_skb_head);
+	txq->tx_skb_stat = 0;
+	txq->tx_list_max_len = DPMAIF_DRB_LIST_LEN / 2;
+	init_waitqueue_head(&txq->req_wq);
+	atomic_set(&txq->tx_budget, DPMAIF_DRB_LIST_LEN);
+
+	ret = t7xx_dpmaif_tx_drb_buf_init(txq);
+	if (ret) {
+		dev_err(txq->dpmaif_ctrl->dev, "Failed to initialize DRB buffers: %d\n", ret);
+		return ret;
+	}
+
+	txq->worker = alloc_workqueue("md_dpmaif_tx%d_worker", WQ_UNBOUND | WQ_MEM_RECLAIM |
+				      (txq->index ? 0 : WQ_HIGHPRI), 1, txq->index);
+	if (!txq->worker)
+		return -ENOMEM;
+
+	INIT_WORK(&txq->dpmaif_tx_work, t7xx_dpmaif_tx_done);
+	spin_lock_init(&txq->tx_lock);
+
+	return 0;
+}
+
+void t7xx_dpmaif_txq_free(struct dpmaif_tx_queue *txq)
+{
+	if (txq->worker)
+		destroy_workqueue(txq->worker);
+
+	skb_queue_purge(&txq->tx_skb_head);
+	t7xx_dpmaif_tx_drb_buf_rel(txq);
+}
+
+void t7xx_dpmaif_tx_stop(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	int i;
+
+	for (i = 0; i < DPMAIF_TXQ_NUM; i++) {
+		struct dpmaif_tx_queue *txq;
+		int count = 0;
+
+		txq = &dpmaif_ctrl->txq[i];
+		txq->que_started = false;
+		/* Make sure TXQ is disabled */
+		smp_mb();
+
+		/* Wait for active Tx to be doneg */
+		while (atomic_read(&txq->tx_processing)) {
+			if (++count >= DPMAIF_MAX_CHECK_COUNT) {
+				dev_err(dpmaif_ctrl->dev, "TX queue stop failed\n");
+				break;
+			}
+		}
+	}
+}
+
+static void t7xx_dpmaif_txq_flush_rel(struct dpmaif_tx_queue *txq)
+{
+	txq->que_started = false;
+
+	cancel_work_sync(&txq->dpmaif_tx_work);
+	flush_work(&txq->dpmaif_tx_work);
+	t7xx_dpmaif_tx_free_drb_skb(txq);
+
+	txq->drb_rd_idx = 0;
+	txq->drb_wr_idx = 0;
+	txq->drb_release_rd_idx = 0;
+}
+
+void t7xx_dpmaif_tx_clear(struct dpmaif_ctrl *dpmaif_ctrl)
+{
+	int i;
+
+	for (i = 0; i < DPMAIF_TXQ_NUM; i++)
+		t7xx_dpmaif_txq_flush_rel(&dpmaif_ctrl->txq[i]);
+}
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.h b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.h
new file mode 100644
index 000000000000..dfb33b8f4224
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Ricardo Martinez <ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#ifndef __T7XX_HIF_DPMA_TX_H__
+#define __T7XX_HIF_DPMA_TX_H__
+
+#include <linux/bits.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "t7xx_hif_dpmaif.h"
+
+#define DPMAIF_TX_DEFAULT_QUEUE	0
+
+struct dpmaif_drb {
+	__le32 header;
+	union {
+		struct {
+			__le32 data_addr_l;
+			__le32 data_addr_h;
+			__le32 reserved;
+		} pd;
+		struct {
+			__le32 msg_hdr;
+			__le32 reserved1;
+			__le32 reserved2;
+		} msg;
+	};
+};
+
+/* Header fields */
+#define DRB_HDR_DATA_LEN	GENMASK(31, 16)
+#define DRB_HDR_RESERVED	GENMASK(15, 3)
+#define DRB_HDR_CONT		BIT(2)
+#define DRB_HDR_DTYP		GENMASK(1, 0)
+
+#define DRB_MSG_DW2_RES		GENMASK(31, 30)
+#define DRB_MSG_L4_CHK		BIT(29)
+#define DRB_MSG_IP_CHK		BIT(28)
+#define DRB_MSG_RESERVED	BIT(27)
+#define DRB_MSG_NETWORK_TYPE	GENMASK(26, 24)
+#define DRB_MSG_CHANNEL_ID	GENMASK(23, 16)
+#define DRB_MSG_COUNT_L		GENMASK(15, 0)
+
+struct dpmaif_drb_skb {
+	struct sk_buff		*skb;
+	dma_addr_t		bus_addr;
+	unsigned int		data_len;
+	u16			index:13;
+	u16			is_msg:1;
+	u16			is_frag:1;
+	u16			is_last:1;
+};
+
+int t7xx_dpmaif_tx_send_skb(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int txq_number,
+			    struct sk_buff *skb);
+void t7xx_dpmaif_tx_thread_rel(struct dpmaif_ctrl *dpmaif_ctrl);
+int t7xx_dpmaif_tx_thread_init(struct dpmaif_ctrl *dpmaif_ctrl);
+void t7xx_dpmaif_txq_free(struct dpmaif_tx_queue *txq);
+void t7xx_dpmaif_irq_tx_done(struct dpmaif_ctrl *dpmaif_ctrl, unsigned int que_mask);
+int t7xx_dpmaif_txq_init(struct dpmaif_tx_queue *txq);
+void t7xx_dpmaif_tx_stop(struct dpmaif_ctrl *dpmaif_ctrl);
+void t7xx_dpmaif_tx_clear(struct dpmaif_ctrl *dpmaif_ctrl);
+
+#endif /* __T7XX_HIF_DPMA_TX_H__ */
-- 
2.17.1

