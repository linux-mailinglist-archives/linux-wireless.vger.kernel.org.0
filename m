Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D04C1E9E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 23:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbiBWWgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 17:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244161AbiBWWfq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628A50E0B;
        Wed, 23 Feb 2022 14:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645655713; x=1677191713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ofpirCKzafh0ApWklMAaLACbNMC1R7IgeMrHKdXK+F4=;
  b=GT8413DSp0mx5YMHg1oHYlpnwCzpZXg+yLkyWRVAAqcT2eqNg6uqfUdJ
   vZsT9z28OZ/g/4ubrGqrOX4fu6AHg+3hGbiJB5XioG8Zr6/wNahNBk6PW
   JKC7ECQiI1o7TXygeH2TDevFOxu6/Lcye+SmRd8t4tVA0/SEfA1tl0fqX
   kKMYUcKzNdBP8m0qPgdr4rYYJnxRffeKabDMN1on5SDb5K39+FbcSo1h5
   8xpHmMJrvA+y2iHdggG/0XlzYTSnKKPCLGgDKGEZX6PoSyrA4NIbqXBJJ
   eud5wPzOM/wnWlsq4ugtcyHWq9SISBcx//r+WLoVrunrxLsXwGP6vAjzL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232718016"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="232718016"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="628252267"
Received: from rmarti10-desk.jf.intel.com ([134.134.150.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:12 -0800
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
Subject: [PATCH net-next v5 09/13] net: wwan: t7xx: Add WWAN network interface
Date:   Wed, 23 Feb 2022 15:33:22 -0700
Message-Id: <20220223223326.28021-10-ricardo.martinez@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223223326.28021-1-ricardo.martinez@linux.intel.com>
References: <20220223223326.28021-1-ricardo.martinez@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haijun Liu <haijun.liu@mediatek.com>

Creates the Cross Core Modem Network Interface (CCMNI) which implements
the wwan_ops for registration with the WWAN framework, CCMNI also
implements the net_device_ops functions used by the network device.
Network device operations include open, close, start transmission, TX
timeout, change MTU, and select queue.

Signed-off-by: Haijun Liu <haijun.liu@mediatek.com>
Co-developed-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>

From a WWAN framework perspective:
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wwan/t7xx/Makefile         |   1 +
 drivers/net/wwan/t7xx/t7xx_modem_ops.c |  11 +-
 drivers/net/wwan/t7xx/t7xx_netdev.c    | 430 +++++++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_netdev.h    |  56 ++++
 4 files changed, 497 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_netdev.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_netdev.h

diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 04a9ba50dc14..dc6a7d682c15 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -17,3 +17,4 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
 		t7xx_dpmaif.o \
+		t7xx_netdev.o
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 156eeaa907bc..412838525208 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -35,6 +35,7 @@
 #include "t7xx_hif_cldma.h"
 #include "t7xx_mhccif.h"
 #include "t7xx_modem_ops.h"
+#include "t7xx_netdev.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
 #include "t7xx_port.h"
@@ -707,10 +708,14 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev)
 	if (ret)
 		goto err_destroy_hswq;
 
-	ret = t7xx_cldma_init(md->md_ctrl[CLDMA_ID_MD]);
+	ret = t7xx_ccmni_init(t7xx_dev);
 	if (ret)
 		goto err_uninit_fsm;
 
+	ret = t7xx_cldma_init(md->md_ctrl[CLDMA_ID_MD]);
+	if (ret)
+		goto err_uninit_ccmni;
+
 	ret = t7xx_port_proxy_init(md);
 	if (ret)
 		goto err_uninit_cldma;
@@ -729,6 +734,9 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev)
 err_uninit_cldma:
 	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_MD]);
 
+err_uninit_ccmni:
+	t7xx_ccmni_exit(t7xx_dev);
+
 err_uninit_fsm:
 	t7xx_fsm_uninit(md);
 
@@ -750,6 +758,7 @@ void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev)
 	t7xx_fsm_append_cmd(md->fsm_ctl, FSM_CMD_PRE_STOP, FSM_CMD_FLAG_WAIT_FOR_COMPLETION);
 	t7xx_port_proxy_uninit(md->port_prox);
 	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_MD]);
+	t7xx_ccmni_exit(t7xx_dev);
 	t7xx_fsm_uninit(md);
 	destroy_workqueue(md->handshake_wq);
 }
diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.c b/drivers/net/wwan/t7xx/t7xx_netdev.c
new file mode 100644
index 000000000000..3cd3cc3e5718
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Ricardo Martinez<ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/gfp.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/netdev_features.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <linux/wwan.h>
+#include <net/pkt_sched.h>
+
+#include "t7xx_common.h"
+#include "t7xx_hif_dpmaif_rx.h"
+#include "t7xx_hif_dpmaif_tx.h"
+#include "t7xx_netdev.h"
+#include "t7xx_pci.h"
+#include "t7xx_state_monitor.h"
+
+#define IP_MUX_SESSION_DEFAULT	0
+
+static u16 t7xx_ccmni_select_queue(struct net_device *dev, struct sk_buff *skb,
+				   struct net_device *sb_dev)
+{
+	return DPMAIF_TX_DEFAULT_QUEUE;
+}
+
+static int t7xx_ccmni_open(struct net_device *dev)
+{
+	struct t7xx_ccmni *ccmni = wwan_netdev_drvpriv(dev);
+
+	netif_carrier_on(dev);
+	netif_tx_start_all_queues(dev);
+	atomic_inc(&ccmni->usage);
+	return 0;
+}
+
+static int t7xx_ccmni_close(struct net_device *dev)
+{
+	struct t7xx_ccmni *ccmni = wwan_netdev_drvpriv(dev);
+
+	atomic_dec(&ccmni->usage);
+	netif_carrier_off(dev);
+	netif_tx_disable(dev);
+	return 0;
+}
+
+static int t7xx_ccmni_send_packet(struct t7xx_ccmni *ccmni, struct sk_buff *skb,
+				  unsigned int txq_number)
+{
+	struct t7xx_ccmni_ctrl *ctlb = ccmni->ctlb;
+	struct t7xx_skb_cb *skb_cb = T7XX_SKB_CB(skb);
+
+	skb_cb->netif_idx = ccmni->index;
+
+	if (t7xx_dpmaif_tx_send_skb(ctlb->hif_ctrl, txq_number, skb))
+		return NETDEV_TX_BUSY;
+
+	return 0;
+}
+
+static int t7xx_ccmni_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct t7xx_ccmni *ccmni = wwan_netdev_drvpriv(dev);
+	int skb_len = skb->len;
+
+	/* If MTU is changed or there is no headroom, drop the packet */
+	if (skb->len > dev->mtu || skb_headroom(skb) < sizeof(struct ccci_header)) {
+		dev_kfree_skb(skb);
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	if (t7xx_ccmni_send_packet(ccmni, skb, DPMAIF_TX_DEFAULT_QUEUE))
+		return NETDEV_TX_BUSY;
+
+	dev->stats.tx_packets++;
+	dev->stats.tx_bytes += skb_len;
+
+	return NETDEV_TX_OK;
+}
+
+static void t7xx_ccmni_tx_timeout(struct net_device *dev, unsigned int __always_unused txqueue)
+{
+	struct t7xx_ccmni *ccmni = netdev_priv(dev);
+
+	dev->stats.tx_errors++;
+
+	if (atomic_read(&ccmni->usage) > 0)
+		netif_tx_wake_all_queues(dev);
+}
+
+static const struct net_device_ops ccmni_netdev_ops = {
+	.ndo_open	  = t7xx_ccmni_open,
+	.ndo_stop	  = t7xx_ccmni_close,
+	.ndo_start_xmit   = t7xx_ccmni_start_xmit,
+	.ndo_tx_timeout   = t7xx_ccmni_tx_timeout,
+	.ndo_select_queue = t7xx_ccmni_select_queue,
+};
+
+static void t7xx_ccmni_start(struct t7xx_ccmni_ctrl *ctlb)
+{
+	struct t7xx_ccmni *ccmni;
+	int i;
+
+	for (i = 0; i < ctlb->nic_dev_num; i++) {
+		ccmni = ctlb->ccmni_inst[i];
+		if (!ccmni)
+			continue;
+
+		if (atomic_read(&ccmni->usage) > 0) {
+			netif_tx_start_all_queues(ccmni->dev);
+			netif_carrier_on(ccmni->dev);
+		}
+	}
+}
+
+static void t7xx_ccmni_pre_stop(struct t7xx_ccmni_ctrl *ctlb)
+{
+	struct t7xx_ccmni *ccmni;
+	int i;
+
+	for (i = 0; i < ctlb->nic_dev_num; i++) {
+		ccmni = ctlb->ccmni_inst[i];
+		if (!ccmni)
+			continue;
+
+		if (atomic_read(&ccmni->usage) > 0)
+			netif_tx_disable(ccmni->dev);
+	}
+}
+
+static void t7xx_ccmni_post_stop(struct t7xx_ccmni_ctrl *ctlb)
+{
+	struct t7xx_ccmni *ccmni;
+	int i;
+
+	for (i = 0; i < ctlb->nic_dev_num; i++) {
+		ccmni = ctlb->ccmni_inst[i];
+		if (!ccmni)
+			continue;
+
+		if (atomic_read(&ccmni->usage) > 0)
+			netif_carrier_off(ccmni->dev);
+	}
+}
+
+static void t7xx_ccmni_wwan_setup(struct net_device *dev)
+{
+	dev->hard_header_len += sizeof(struct ccci_header);
+
+	dev->mtu = ETH_DATA_LEN;
+	dev->max_mtu = CCMNI_MTU_MAX;
+	BUILD_BUG_ON(CCMNI_MTU_MAX > DPMAIF_HW_MTU_SIZE);
+
+	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	dev->watchdog_timeo = CCMNI_NETDEV_WDT_TO;
+
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+
+	dev->features = NETIF_F_VLAN_CHALLENGED;
+
+	dev->features |= NETIF_F_SG;
+	dev->hw_features |= NETIF_F_SG;
+
+	dev->features |= NETIF_F_HW_CSUM;
+	dev->hw_features |= NETIF_F_HW_CSUM;
+
+	dev->features |= NETIF_F_RXCSUM;
+	dev->hw_features |= NETIF_F_RXCSUM;
+
+	dev->needs_free_netdev = true;
+
+	dev->type = ARPHRD_NONE;
+
+	dev->netdev_ops = &ccmni_netdev_ops;
+}
+
+static int t7xx_ccmni_wwan_newlink(void *ctxt, struct net_device *dev, u32 if_id,
+				   struct netlink_ext_ack *extack)
+{
+	struct t7xx_ccmni_ctrl *ctlb = ctxt;
+	struct t7xx_ccmni *ccmni;
+	int ret;
+
+	if (if_id >= ARRAY_SIZE(ctlb->ccmni_inst))
+		return -EINVAL;
+
+	ccmni = wwan_netdev_drvpriv(dev);
+	ccmni->index = if_id;
+	ccmni->ctlb = ctlb;
+	ccmni->dev = dev;
+	atomic_set(&ccmni->usage, 0);
+	ctlb->ccmni_inst[if_id] = ccmni;
+
+	ret = register_netdevice(dev);
+	if (ret)
+		return ret;
+
+	netif_device_attach(dev);
+	return 0;
+}
+
+static void t7xx_ccmni_wwan_dellink(void *ctxt, struct net_device *dev, struct list_head *head)
+{
+	struct t7xx_ccmni *ccmni = wwan_netdev_drvpriv(dev);
+	struct t7xx_ccmni_ctrl *ctlb = ctxt;
+	u8 if_id = ccmni->index;
+
+	if (if_id >= ARRAY_SIZE(ctlb->ccmni_inst))
+		return;
+
+	if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
+		return;
+
+	unregister_netdevice(dev);
+}
+
+static const struct wwan_ops ccmni_wwan_ops = {
+	.priv_size = sizeof(struct t7xx_ccmni),
+	.setup     = t7xx_ccmni_wwan_setup,
+	.newlink   = t7xx_ccmni_wwan_newlink,
+	.dellink   = t7xx_ccmni_wwan_dellink,
+};
+
+static int t7xx_ccmni_register_wwan(struct t7xx_ccmni_ctrl *ctlb)
+{
+	struct device *dev = ctlb->hif_ctrl->dev;
+	int ret;
+
+	if (ctlb->wwan_is_registered)
+		return 0;
+
+	/* WWAN core will create a netdev for the default IP MUX channel */
+	ret = wwan_register_ops(dev, &ccmni_wwan_ops, ctlb, IP_MUX_SESSION_DEFAULT);
+	if (ret < 0) {
+		dev_err(dev, "Unable to register WWAN ops, %d\n", ret);
+		return ret;
+	}
+
+	ctlb->wwan_is_registered = true;
+	return 0;
+}
+
+static int t7xx_ccmni_md_state_callback(enum md_state state, void *para)
+{
+	struct t7xx_ccmni_ctrl *ctlb = para;
+	struct device *dev;
+	int ret = 0;
+
+	dev = ctlb->hif_ctrl->dev;
+	ctlb->md_sta = state;
+
+	switch (state) {
+	case MD_STATE_READY:
+		ret = t7xx_ccmni_register_wwan(ctlb);
+		if (!ret)
+			t7xx_ccmni_start(ctlb);
+		break;
+
+	case MD_STATE_EXCEPTION:
+	case MD_STATE_STOPPED:
+		t7xx_ccmni_pre_stop(ctlb);
+
+		ret = t7xx_dpmaif_md_state_callback(ctlb->hif_ctrl, state);
+		if (ret < 0)
+			dev_err(dev, "DPMAIF md state callback err, state=%d\n", state);
+
+		t7xx_ccmni_post_stop(ctlb);
+		break;
+
+	case MD_STATE_WAITING_FOR_HS1:
+	case MD_STATE_WAITING_TO_STOP:
+		ret = t7xx_dpmaif_md_state_callback(ctlb->hif_ctrl, state);
+		if (ret < 0)
+			dev_err(dev, "DPMAIF md state callback err, state=%d\n", state);
+
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void init_md_status_notifier(struct t7xx_pci_dev *t7xx_dev)
+{
+	struct t7xx_ccmni_ctrl	*ctlb = t7xx_dev->ccmni_ctlb;
+	struct t7xx_fsm_notifier *md_status_notifier;
+
+	md_status_notifier = &ctlb->md_status_notify;
+	INIT_LIST_HEAD(&md_status_notifier->entry);
+	md_status_notifier->notifier_fn = t7xx_ccmni_md_state_callback;
+	md_status_notifier->data = ctlb;
+
+	t7xx_fsm_notifier_register(t7xx_dev->md, md_status_notifier);
+}
+
+static void t7xx_ccmni_recv_skb(struct t7xx_pci_dev *t7xx_dev, struct sk_buff *skb)
+{
+	struct t7xx_skb_cb *skb_cb;
+	struct net_device *net_dev;
+	struct t7xx_ccmni *ccmni;
+	int pkt_type, skb_len;
+	u8 netif_id;
+
+	skb_cb = T7XX_SKB_CB(skb);
+	netif_id = skb_cb->netif_idx;
+	ccmni = t7xx_dev->ccmni_ctlb->ccmni_inst[netif_id];
+	if (!ccmni) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
+	net_dev = ccmni->dev;
+	skb->dev = net_dev;
+
+	pkt_type = skb_cb->rx_pkt_type;
+	if (pkt_type == PKT_TYPE_IP6)
+		skb->protocol = htons(ETH_P_IPV6);
+	else
+		skb->protocol = htons(ETH_P_IP);
+
+	skb_len = skb->len;
+	netif_rx_any_context(skb);
+	net_dev->stats.rx_packets++;
+	net_dev->stats.rx_bytes += skb_len;
+}
+
+static void t7xx_ccmni_queue_tx_irq_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
+{
+	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct netdev_queue *net_queue;
+
+	if (netif_running(ccmni->dev) && atomic_read(&ccmni->usage) > 0) {
+		net_queue = netdev_get_tx_queue(ccmni->dev, qno);
+		if (netif_tx_queue_stopped(net_queue))
+			netif_tx_wake_queue(net_queue);
+	}
+}
+
+static void t7xx_ccmni_queue_tx_full_notify(struct t7xx_ccmni_ctrl *ctlb, int qno)
+{
+	struct t7xx_ccmni *ccmni = ctlb->ccmni_inst[0];
+	struct netdev_queue *net_queue;
+
+	if (atomic_read(&ccmni->usage) > 0) {
+		netdev_err(ccmni->dev, "TX queue %d is full\n", qno);
+		net_queue = netdev_get_tx_queue(ccmni->dev, qno);
+		netif_tx_stop_queue(net_queue);
+	}
+}
+
+static void t7xx_ccmni_queue_state_notify(struct t7xx_pci_dev *t7xx_dev,
+					  enum dpmaif_txq_state state, int qno)
+{
+	struct t7xx_ccmni_ctrl *ctlb = t7xx_dev->ccmni_ctlb;
+
+	if (ctlb->md_sta != MD_STATE_READY)
+		return;
+
+	if (!ctlb->ccmni_inst[0]) {
+		dev_warn(&t7xx_dev->pdev->dev, "No netdev registered yet\n");
+		return;
+	}
+
+	if (state == DMPAIF_TXQ_STATE_IRQ)
+		t7xx_ccmni_queue_tx_irq_notify(ctlb, qno);
+	else if (state == DMPAIF_TXQ_STATE_FULL)
+		t7xx_ccmni_queue_tx_full_notify(ctlb, qno);
+}
+
+int t7xx_ccmni_init(struct t7xx_pci_dev *t7xx_dev)
+{
+	struct device *dev = &t7xx_dev->pdev->dev;
+	struct t7xx_ccmni_ctrl *ctlb;
+
+	ctlb = devm_kzalloc(dev, sizeof(*ctlb), GFP_KERNEL);
+	if (!ctlb)
+		return -ENOMEM;
+
+	t7xx_dev->ccmni_ctlb = ctlb;
+	ctlb->t7xx_dev = t7xx_dev;
+	ctlb->callbacks.state_notify = t7xx_ccmni_queue_state_notify;
+	ctlb->callbacks.recv_skb = t7xx_ccmni_recv_skb;
+	ctlb->nic_dev_num = NIC_DEV_DEFAULT;
+
+	ctlb->hif_ctrl = t7xx_dpmaif_hif_init(t7xx_dev, &ctlb->callbacks);
+	if (!ctlb->hif_ctrl)
+		return -ENOMEM;
+
+	init_md_status_notifier(t7xx_dev);
+	return 0;
+}
+
+void t7xx_ccmni_exit(struct t7xx_pci_dev *t7xx_dev)
+{
+	struct t7xx_ccmni_ctrl *ctlb = t7xx_dev->ccmni_ctlb;
+
+	t7xx_fsm_notifier_unregister(t7xx_dev->md, &ctlb->md_status_notify);
+
+	if (ctlb->wwan_is_registered) {
+		wwan_unregister_ops(&t7xx_dev->pdev->dev);
+		ctlb->wwan_is_registered = false;
+	}
+
+	t7xx_dpmaif_hif_exit(ctlb->hif_ctrl);
+}
diff --git a/drivers/net/wwan/t7xx/t7xx_netdev.h b/drivers/net/wwan/t7xx/t7xx_netdev.h
new file mode 100644
index 000000000000..279e15607ac7
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_netdev.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *
+ * Contributors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Ricardo Martinez<ricardo.martinez@linux.intel.com>
+ */
+
+#ifndef __T7XX_NETDEV_H__
+#define __T7XX_NETDEV_H__
+
+#include <linux/bits.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+
+#include "t7xx_common.h"
+#include "t7xx_hif_dpmaif.h"
+#include "t7xx_pci.h"
+#include "t7xx_state_monitor.h"
+
+#define RXQ_NUM				DPMAIF_RXQ_NUM
+#define NIC_DEV_MAX			21
+#define NIC_DEV_DEFAULT			2
+
+#define CCMNI_NETDEV_WDT_TO		(1 * HZ)
+#define CCMNI_MTU_MAX			3000
+
+struct t7xx_ccmni {
+	u8				index;
+	atomic_t			usage;
+	struct net_device		*dev;
+	struct t7xx_ccmni_ctrl		*ctlb;
+};
+
+struct t7xx_ccmni_ctrl {
+	struct t7xx_pci_dev		*t7xx_dev;
+	struct dpmaif_ctrl		*hif_ctrl;
+	struct t7xx_ccmni		*ccmni_inst[NIC_DEV_MAX];
+	struct dpmaif_callbacks		callbacks;
+	unsigned int			nic_dev_num;
+	unsigned int			md_sta;
+	struct t7xx_fsm_notifier	md_status_notify;
+	bool				wwan_is_registered;
+};
+
+int t7xx_ccmni_init(struct t7xx_pci_dev *t7xx_dev);
+void t7xx_ccmni_exit(struct t7xx_pci_dev *t7xx_dev);
+
+#endif /* __T7XX_NETDEV_H__ */
-- 
2.17.1

