Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC74C1EA2
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 23:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiBWWft (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 17:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244100AbiBWWfk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:40 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F81C106;
        Wed, 23 Feb 2022 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645655710; x=1677191710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8zIgYbGT5NH8oZBjZ5x/iKGoUt3fhuFUIHUbMy9u62c=;
  b=YYlEZUH+rZYpg6oE/hkbKttTRsOls5Tiut3SMMaSY2HpHwF8J/yv9uI2
   BsQ3tyIoTG3ru3zRnvr/I19ud6IUW3JpM764RnHrHoyoHoL1pyGhebKoI
   YlqAyba6oH/yXlTx52O/oXbqUniBw9sWnWe4ol7lE9zZOevcndQ0vbFys
   qc8SwkNmtT2oUcUeZZrnU2vSOGKW9csOONsKLyKiLNqvu8MXR0c2ioMZQ
   6H+liQkhTXBmdzHWyAagd/VFWQASi9S0R1CLo22ZFWjet+3DvvFsnfssK
   geiJSSfDKhPkA0rL0cY13VcUe1tlj+yYYKkpHCyr25p9OWIFIhRZqiBYB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312812428"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="312812428"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="628252234"
Received: from rmarti10-desk.jf.intel.com ([134.134.150.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:35:08 -0800
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
Subject: [PATCH net-next v5 04/13] net: wwan: t7xx: Add port proxy infrastructure
Date:   Wed, 23 Feb 2022 15:33:17 -0700
Message-Id: <20220223223326.28021-5-ricardo.martinez@linux.intel.com>
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

Port-proxy provides a common interface to interact with different types
of ports. Ports export their configuration via `struct t7xx_port` and
operate as defined by `struct port_ops`.

Signed-off-by: Haijun Liu <haijun.liu@mediatek.com>
Co-developed-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Co-developed-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>
Signed-off-by: Ricardo Martinez <ricardo.martinez@linux.intel.com>

From a WWAN framework perspective:
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wwan/t7xx/Makefile             |   1 +
 drivers/net/wwan/t7xx/t7xx_common.h        |  16 +
 drivers/net/wwan/t7xx/t7xx_modem_ops.c     |  14 +-
 drivers/net/wwan/t7xx/t7xx_port.h          | 149 ++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c    | 525 +++++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  69 +++
 drivers/net/wwan/t7xx/t7xx_state_monitor.c |   5 +
 7 files changed, 778 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port.h
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_proxy.c
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_proxy.h

diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 6a49013bc343..99f9ca3b4b51 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -10,3 +10,4 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_modem_ops.o \
 		t7xx_cldma.o \
 		t7xx_hif_cldma.o  \
+		t7xx_port_proxy.o  \
diff --git a/drivers/net/wwan/t7xx/t7xx_common.h b/drivers/net/wwan/t7xx/t7xx_common.h
index b512afb62af8..60d938754119 100644
--- a/drivers/net/wwan/t7xx/t7xx_common.h
+++ b/drivers/net/wwan/t7xx/t7xx_common.h
@@ -18,7 +18,23 @@
 #ifndef __T7XX_COMMON_H__
 #define __T7XX_COMMON_H__
 
+#include <linux/bits.h>
 #include <linux/skbuff.h>
+#include <linux/types.h>
+
+struct ccci_header {
+	__le32 packet_header;
+	__le32 packet_len;
+	__le32 status;
+	__le32 ex_msg;
+};
+
+/* Coupled with HW - indicates if there is data following the CCCI header or not */
+#define CCCI_HEADER_NO_DATA	0xffffffff
+
+#define CCCI_H_AST_BIT		BIT(31)
+#define CCCI_H_SEQ_FLD		GENMASK(30, 16)
+#define CCCI_H_CHN_FLD		GENMASK(15, 0)
 
 enum md_state {
 	MD_STATE_INVALID,
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 49f3907f199f..18e953f35b94 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -34,6 +34,8 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
 
@@ -273,6 +275,7 @@ static void t7xx_md_exception(struct t7xx_modem *md, enum hif_ex_stage stage)
 	if (stage == HIF_EX_CLEARQ_DONE) {
 		/* Give DHL time to flush data */
 		msleep(PORT_RESET_DELAY_MS);
+		t7xx_port_proxy_reset(md->port_prox);
 	}
 
 	t7xx_cldma_exception(md->md_ctrl[CLDMA_ID_MD], stage);
@@ -428,6 +431,7 @@ int t7xx_md_reset(struct t7xx_pci_dev *t7xx_dev)
 	spin_lock_init(&md->exp_lock);
 	t7xx_fsm_reset(md);
 	t7xx_cldma_reset(md->md_ctrl[CLDMA_ID_MD]);
+	t7xx_port_proxy_reset(md->port_prox);
 	md->md_init_finish = true;
 	return 0;
 }
@@ -464,14 +468,21 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev)
 	if (ret)
 		goto err_uninit_fsm;
 
+	ret = t7xx_port_proxy_init(md);
+	if (ret)
+		goto err_uninit_cldma;
+
 	ret = t7xx_fsm_append_cmd(md->fsm_ctl, FSM_CMD_START, 0);
 	if (ret) /* fsm_uninit flushes cmd queue */
-		goto err_uninit_cldma;
+		goto err_uninit_proxy;
 
 	t7xx_md_sys_sw_init(t7xx_dev);
 	md->md_init_finish = true;
 	return 0;
 
+err_uninit_proxy:
+	t7xx_port_proxy_uninit(md->port_prox);
+
 err_uninit_cldma:
 	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_MD]);
 
@@ -494,6 +505,7 @@ void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev)
 		return;
 
 	t7xx_fsm_append_cmd(md->fsm_ctl, FSM_CMD_PRE_STOP, FSM_CMD_FLAG_WAIT_FOR_COMPLETION);
+	t7xx_port_proxy_uninit(md->port_prox);
 	t7xx_cldma_exit(md->md_ctrl[CLDMA_ID_MD]);
 	t7xx_fsm_uninit(md);
 	destroy_workqueue(md->handshake_wq);
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
new file mode 100644
index 000000000000..d65d8d79f976
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Ricardo Martinez<ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *  Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ */
+
+#ifndef __T7XX_PORT_H__
+#define __T7XX_PORT_H__
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/sched.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/wwan.h>
+
+#include "t7xx_hif_cldma.h"
+#include "t7xx_pci.h"
+
+#define PORT_F_RX_ALLOW_DROP	BIT(0)	/* Packet will be dropped if port's RX buffer full */
+#define PORT_F_RX_FULLED	BIT(1)	/* RX buffer has been detected to be full */
+#define PORT_F_USER_HEADER	BIT(2)	/* CCCI header will be provided by user, but not by CCCI */
+#define PORT_F_RX_EXCLUSIVE	BIT(3)	/* RX queue only has this one port */
+#define PORT_F_RX_ADJUST_HEADER	BIT(4)	/* Check whether need remove CCCI header while recv skb */
+#define PORT_F_RX_CH_TRAFFIC	BIT(5)	/* Enable port channel traffic */
+#define PORT_F_RX_CHAR_NODE	BIT(7)	/* Requires exporting char dev node to userspace */
+#define PORT_F_CHAR_NODE_SHOW	BIT(10)	/* The char dev node is shown to userspace by default */
+
+/* Reused for net TX, Data queue, same bit as RX_FULLED */
+#define PORT_F_TX_DATA_FULLED	BIT(1)
+#define PORT_F_TX_ACK_FULLED	BIT(8)
+
+#define PORT_CH_ID_MASK		GENMASK(7, 0)
+#define	PORT_INVALID_CH_ID	GENMASK(15, 0)
+
+/* Channel ID and Message ID definitions.
+ * The channel number consists of peer_id(15:12) , channel_id(11:0)
+ * peer_id:
+ * 0:reserved, 1: to sAP, 2: to MD
+ */
+enum port_ch {
+	/* to MD */
+	PORT_CH_CONTROL_RX = 0x2000,
+	PORT_CH_CONTROL_TX = 0x2001,
+	PORT_CH_UART1_RX = 0x2006,	/* META */
+	PORT_CH_UART1_TX = 0x2008,
+	PORT_CH_UART2_RX = 0x200a,	/* AT */
+	PORT_CH_UART2_TX = 0x200c,
+	PORT_CH_MD_LOG_RX = 0x202a,	/* MD logging */
+	PORT_CH_MD_LOG_TX = 0x202b,
+	PORT_CH_LB_IT_RX = 0x203e,	/* Loop back test */
+	PORT_CH_LB_IT_TX = 0x203f,
+	PORT_CH_STATUS_RX = 0x2043,	/* Status polling */
+	PORT_CH_MIPC_RX = 0x20ce,	/* MIPC */
+	PORT_CH_MIPC_TX = 0x20cf,
+	PORT_CH_MBIM_RX = 0x20d0,
+	PORT_CH_MBIM_TX = 0x20d1,
+	PORT_CH_DSS0_RX = 0x20d2,
+	PORT_CH_DSS0_TX = 0x20d3,
+	PORT_CH_DSS1_RX = 0x20d4,
+	PORT_CH_DSS1_TX = 0x20d5,
+	PORT_CH_DSS2_RX = 0x20d6,
+	PORT_CH_DSS2_TX = 0x20d7,
+	PORT_CH_DSS3_RX = 0x20d8,
+	PORT_CH_DSS3_TX = 0x20d9,
+	PORT_CH_DSS4_RX = 0x20da,
+	PORT_CH_DSS4_TX = 0x20db,
+	PORT_CH_DSS5_RX = 0x20dc,
+	PORT_CH_DSS5_TX = 0x20dd,
+	PORT_CH_DSS6_RX = 0x20de,
+	PORT_CH_DSS6_TX = 0x20df,
+	PORT_CH_DSS7_RX = 0x20e0,
+	PORT_CH_DSS7_TX = 0x20e1,
+};
+
+struct t7xx_port;
+struct port_ops {
+	int (*init)(struct t7xx_port *port);
+	int (*recv_skb)(struct t7xx_port *port, struct sk_buff *skb);
+	void (*md_state_notify)(struct t7xx_port *port, unsigned int md_state);
+	void (*uninit)(struct t7xx_port *port);
+	int (*enable_chl)(struct t7xx_port *port);
+	int (*disable_chl)(struct t7xx_port *port);
+};
+
+typedef int (*port_skb_handler)(struct t7xx_port *port, struct sk_buff *skb);
+
+struct t7xx_port_static {
+	enum port_ch		tx_ch;
+	enum port_ch		rx_ch;
+	unsigned char		txq_index;
+	unsigned char		rxq_index;
+	unsigned char		txq_exp_index;
+	unsigned char		rxq_exp_index;
+	enum cldma_id		path_id;
+	unsigned int		flags;
+	struct port_ops		*ops;
+	char			*name;
+	enum wwan_port_type	port_type;
+};
+
+struct t7xx_port {
+	/* Members not initialized in definition */
+	struct t7xx_port_static *port_static;
+	struct wwan_port	*wwan_port;
+	struct t7xx_pci_dev	*t7xx_dev;
+	struct device		*dev;
+	u16			seq_nums[2];	/* TX/RX sequence numbers */
+	atomic_t		usage_cnt;
+	struct			list_head entry;
+	struct			list_head queue_entry;
+	/* TX and RX flows are asymmetric since ports are multiplexed on
+	 * queues.
+	 *
+	 * TX: data blocks are sent directly to a queue. Each port
+	 * does not maintain a TX list; instead, they only provide
+	 * a wait_queue_head for blocking writes.
+	 *
+	 * RX: Each port uses a RX list to hold packets,
+	 * allowing the modem to dispatch RX packet as quickly as possible.
+	 */
+	struct sk_buff_head	rx_skb_list;
+	spinlock_t		port_update_lock; /* Protects port configuration */
+	wait_queue_head_t	rx_wq;
+	int			rx_length_th;
+	port_skb_handler	skb_handler;
+	bool			chan_enable;
+	struct task_struct	*thread;
+	unsigned int		flags;
+};
+
+int t7xx_port_recv_skb(struct t7xx_port *port, struct sk_buff *skb);
+int t7xx_port_send_skb_to_md(struct t7xx_port *port, struct sk_buff *skb);
+
+#endif /* __T7XX_PORT_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
new file mode 100644
index 000000000000..69c702473c4c
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Ricardo Martinez<ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ *  Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/wwan.h>
+
+#include "t7xx_common.h"
+#include "t7xx_hif_cldma.h"
+#include "t7xx_modem_ops.h"
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+#include "t7xx_state_monitor.h"
+
+#define Q_IDX_CTRL			0
+#define Q_IDX_MBIM			2
+#define Q_IDX_AT_CMD			5
+
+#define INVALID_SEQ_NUM			GENMASK(15, 0)
+
+#define for_each_proxy_port(i, p, proxy)	\
+	for (i = 0, (p) = &(proxy)->ports_private[i];	\
+	     i < (proxy)->port_number;		\
+	     i++, (p) = &(proxy)->ports_private[i])
+
+static struct t7xx_port_static t7xx_md_ports[1];
+
+static struct t7xx_port *t7xx_proxy_get_port_by_ch(struct port_proxy *port_prox, enum port_ch ch)
+{
+	struct t7xx_port_static *port_static;
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		port_static = port->port_static;
+		if (port_static->rx_ch == ch || port_static->tx_ch == ch)
+			return port;
+	}
+
+	return NULL;
+}
+
+void t7xx_port_proxy_set_tx_seq_num(struct t7xx_port *port, struct ccci_header *ccci_h)
+{
+	ccci_h->status &= cpu_to_le32(~CCCI_H_SEQ_FLD);
+	ccci_h->status |= cpu_to_le32(FIELD_PREP(CCCI_H_SEQ_FLD, port->seq_nums[MTK_TX]));
+	ccci_h->status |= cpu_to_le32(CCCI_H_AST_BIT);
+}
+
+static u16 t7xx_port_next_rx_seq_num(struct t7xx_port *port, struct ccci_header *ccci_h)
+{
+	u16 seq_num, next_seq_num, assert_bit;
+
+	seq_num = FIELD_GET(CCCI_H_SEQ_FLD, le32_to_cpu(ccci_h->status));
+	next_seq_num = (seq_num + 1) & FIELD_MAX(CCCI_H_SEQ_FLD);
+	assert_bit = !!(le32_to_cpu(ccci_h->status) & CCCI_H_AST_BIT);
+	if (!assert_bit || port->seq_nums[MTK_RX] > FIELD_MAX(CCCI_H_SEQ_FLD))
+		return next_seq_num;
+
+	if (seq_num != port->seq_nums[MTK_RX]) {
+		dev_warn_ratelimited(port->dev,
+				     "seq num out-of-order %u != %u (header %X, len %X)\n",
+				     seq_num, port->seq_nums[MTK_RX],
+				     le32_to_cpu(ccci_h->packet_header),
+				     le32_to_cpu(ccci_h->packet_len));
+	}
+
+	return next_seq_num;
+}
+
+void t7xx_port_proxy_reset(struct port_proxy *port_prox)
+{
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		port->seq_nums[MTK_RX] = INVALID_SEQ_NUM;
+		port->seq_nums[MTK_TX] = 0;
+	}
+}
+
+static int t7xx_port_get_queue_no(struct t7xx_port *port)
+{
+	struct t7xx_port_static *port_static = port->port_static;
+	struct t7xx_fsm_ctl *ctl = port->t7xx_dev->md->fsm_ctl;
+
+	return t7xx_fsm_get_md_state(ctl) == MD_STATE_EXCEPTION ?
+		port_static->txq_exp_index : port_static->txq_index;
+}
+
+static void t7xx_port_struct_init(struct t7xx_port *port)
+{
+	INIT_LIST_HEAD(&port->entry);
+	INIT_LIST_HEAD(&port->queue_entry);
+	skb_queue_head_init(&port->rx_skb_list);
+	init_waitqueue_head(&port->rx_wq);
+	port->seq_nums[MTK_RX] = INVALID_SEQ_NUM;
+	port->seq_nums[MTK_TX] = 0;
+	atomic_set(&port->usage_cnt, 0);
+}
+
+static void t7xx_port_adjust_skb(struct t7xx_port *port, struct sk_buff *skb)
+{
+	struct ccci_header *ccci_h = (struct ccci_header *)skb->data;
+	struct t7xx_port_static *port_static = port->port_static;
+
+	if (port->flags & PORT_F_USER_HEADER) {
+		if (le32_to_cpu(ccci_h->packet_header) == CCCI_HEADER_NO_DATA) {
+			if (skb->len > sizeof(*ccci_h)) {
+				dev_err_ratelimited(port->dev,
+						    "Recv unexpected data for %s, skb->len=%d\n",
+						    port_static->name, skb->len);
+				skb_trim(skb, sizeof(*ccci_h));
+			}
+		}
+	} else {
+		skb_pull(skb, sizeof(*ccci_h));
+	}
+}
+
+/**
+ * t7xx_port_recv_skb() - receive skb from modem or HIF.
+ * @port: port to use.
+ * @skb: skb to use.
+ *
+ * Used to receive native HIF RX data, which has same the RX receive flow.
+ *
+ * Return:
+ * * 0		- Success.
+ * * ERROR	- Error code.
+ */
+int t7xx_port_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
+{
+	struct ccci_header *ccci_h;
+	unsigned long flags;
+	u32 channel;
+	int ret = 0;
+
+	spin_lock_irqsave(&port->rx_wq.lock, flags);
+	if (port->rx_skb_list.qlen >= port->rx_length_th) {
+		port->flags |= PORT_F_RX_FULLED;
+		spin_unlock_irqrestore(&port->rx_wq.lock, flags);
+
+		return -ENOBUFS;
+	}
+	ccci_h = (struct ccci_header *)skb->data;
+	port->flags &= ~PORT_F_RX_FULLED;
+	if (port->flags & PORT_F_RX_ADJUST_HEADER)
+		t7xx_port_adjust_skb(port, skb);
+	channel = FIELD_GET(CCCI_H_CHN_FLD, le32_to_cpu(ccci_h->status));
+	if (channel == PORT_CH_STATUS_RX) {
+		ret = port->skb_handler(port, skb);
+	} else {
+		if (port->wwan_port)
+			wwan_port_rx(port->wwan_port, skb);
+		else
+			__skb_queue_tail(&port->rx_skb_list, skb);
+	}
+	spin_unlock_irqrestore(&port->rx_wq.lock, flags);
+
+	wake_up_all(&port->rx_wq);
+	return ret;
+}
+
+static struct cldma_ctrl *get_md_ctrl(struct t7xx_port *port)
+{
+	enum cldma_id id = port->port_static->path_id;
+
+	return port->t7xx_dev->md->md_ctrl[id];
+}
+
+int t7xx_port_proxy_send_skb(struct t7xx_port *port, struct sk_buff *skb)
+{
+	struct ccci_header *ccci_h = (struct ccci_header *)(skb->data);
+	struct cldma_ctrl *md_ctrl;
+	unsigned char tx_qno;
+	int ret;
+
+	tx_qno = t7xx_port_get_queue_no(port);
+	t7xx_port_proxy_set_tx_seq_num(port, ccci_h);
+
+	md_ctrl = get_md_ctrl(port);
+	ret = t7xx_cldma_send_skb(md_ctrl, tx_qno, skb);
+	if (ret) {
+		dev_err(port->dev, "Failed to send skb: %d\n", ret);
+		return ret;
+	}
+
+	port->seq_nums[MTK_TX]++;
+
+	return 0;
+}
+
+int t7xx_port_send_skb_to_md(struct t7xx_port *port, struct sk_buff *skb)
+{
+	struct t7xx_port_static *port_static = port->port_static;
+	struct t7xx_fsm_ctl *ctl = port->t7xx_dev->md->fsm_ctl;
+	struct cldma_ctrl *md_ctrl;
+	enum md_state md_state;
+	unsigned int fsm_state;
+
+	md_state = t7xx_fsm_get_md_state(ctl);
+
+	fsm_state = t7xx_fsm_get_ctl_state(ctl);
+	if (fsm_state != FSM_STATE_PRE_START) {
+		if (md_state == MD_STATE_WAITING_FOR_HS1 || md_state == MD_STATE_WAITING_FOR_HS2)
+			return -ENODEV;
+
+		if (md_state == MD_STATE_EXCEPTION && port_static->tx_ch != PORT_CH_MD_LOG_TX &&
+		    port_static->tx_ch != PORT_CH_UART1_TX)
+			return -EBUSY;
+
+		if (md_state == MD_STATE_STOPPED || md_state == MD_STATE_WAITING_TO_STOP ||
+		    md_state == MD_STATE_INVALID)
+			return -ENODEV;
+	}
+
+	md_ctrl = get_md_ctrl(port);
+	return t7xx_cldma_send_skb(md_ctrl, t7xx_port_get_queue_no(port), skb);
+}
+
+static void t7xx_proxy_setup_ch_mapping(struct port_proxy *port_prox)
+{
+	struct t7xx_port *port;
+
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(port_prox->rx_ch_ports); i++)
+		INIT_LIST_HEAD(&port_prox->rx_ch_ports[i]);
+
+	for (j = 0; j < ARRAY_SIZE(port_prox->queue_ports); j++) {
+		for (i = 0; i < ARRAY_SIZE(port_prox->queue_ports[j]); i++)
+			INIT_LIST_HEAD(&port_prox->queue_ports[j][i]);
+	}
+
+	for_each_proxy_port(i, port, port_prox) {
+		struct t7xx_port_static *port_static = port->port_static;
+		enum cldma_id path_id = port_static->path_id;
+		u8 ch_id;
+
+		ch_id = FIELD_GET(PORT_CH_ID_MASK, port_static->rx_ch);
+		list_add_tail(&port->entry, &port_prox->rx_ch_ports[ch_id]);
+		list_add_tail(&port->queue_entry,
+			      &port_prox->queue_ports[path_id][port_static->rxq_index]);
+	}
+}
+
+static struct t7xx_port *t7xx_port_proxy_find_port(struct t7xx_pci_dev *t7xx_dev,
+						   struct cldma_queue *queue, u16 channel)
+{
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	struct list_head *port_list;
+	struct t7xx_port *port;
+	u8 ch_id;
+
+	ch_id = FIELD_GET(PORT_CH_ID_MASK, channel);
+	port_list = &port_prox->rx_ch_ports[ch_id];
+	list_for_each_entry(port, port_list, entry) {
+		struct t7xx_port_static *port_static = port->port_static;
+
+		if (queue->md_ctrl->hif_id == port_static->path_id &&
+		    channel == port_static->rx_ch)
+			return port;
+	}
+
+	return NULL;
+}
+
+/**
+ * t7xx_port_proxy_recv_skb() - Dispatch received skb.
+ * @queue: CLDMA queue.
+ * @skb: Socket buffer.
+ *
+ * Return:
+ ** 0		- Packet consumed.
+ ** -ERROR	- Failed to process skb.
+ */
+static int t7xx_port_proxy_recv_skb(struct cldma_queue *queue, struct sk_buff *skb)
+{
+	struct ccci_header *ccci_h = (struct ccci_header *)skb->data;
+	struct t7xx_pci_dev *t7xx_dev = queue->md_ctrl->t7xx_dev;
+	struct t7xx_fsm_ctl *ctl = t7xx_dev->md->fsm_ctl;
+	struct device *dev = queue->md_ctrl->dev;
+	struct t7xx_port_static *port_static;
+	struct t7xx_port *port;
+	u16 seq_num, channel;
+	int ret;
+
+	if (!skb)
+		return -EINVAL;
+
+	channel = FIELD_GET(CCCI_H_CHN_FLD, le32_to_cpu(ccci_h->status));
+	if (t7xx_fsm_get_md_state(ctl) == MD_STATE_INVALID) {
+		dev_err_ratelimited(dev, "Packet drop on channel 0x%x, modem not ready\n", channel);
+		goto drop_skb;
+	}
+
+	port = t7xx_port_proxy_find_port(t7xx_dev, queue, channel);
+	if (!port) {
+		dev_err_ratelimited(dev, "Packet drop on channel 0x%x, port not found\n", channel);
+		goto drop_skb;
+	}
+
+	seq_num = t7xx_port_next_rx_seq_num(port, ccci_h);
+	port_static = port->port_static;
+	ret = port_static->ops->recv_skb(port, skb);
+	if (ret && port->flags & PORT_F_RX_ALLOW_DROP) {
+		port->seq_nums[MTK_RX] = seq_num;
+		dev_err_ratelimited(dev, "Packed drop on port %s, error %d\n",
+				    port_static->name, ret);
+		goto drop_skb;
+	}
+
+	if (ret)
+		return ret;
+
+	port->seq_nums[MTK_RX] = seq_num;
+	return 0;
+
+drop_skb:
+	dev_kfree_skb_any(skb);
+	return 0;
+}
+
+/**
+ * t7xx_port_proxy_md_status_notify() - Notify all ports of state.
+ *@port_prox: The port_proxy pointer.
+ *@state: State.
+ *
+ * Called by t7xx_fsm. Used to dispatch modem status for all ports,
+ * which want to know MD state transition.
+ */
+void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int state)
+{
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		struct t7xx_port_static *port_static = port->port_static;
+
+		if (port_static->ops->md_state_notify)
+			port_static->ops->md_state_notify(port, state);
+	}
+}
+
+static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
+{
+	struct port_proxy *port_prox = md->port_prox;
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		struct t7xx_port_static *port_static = port->port_static;
+
+		t7xx_port_struct_init(port);
+
+		port->t7xx_dev = md->t7xx_dev;
+		port->dev = &md->t7xx_dev->pdev->dev;
+		spin_lock_init(&port->port_update_lock);
+
+		if (port->flags & PORT_F_CHAR_NODE_SHOW)
+			port->chan_enable = true;
+		else
+			port->chan_enable = false;
+
+		if (port_static->ops->init)
+			port_static->ops->init(port);
+	}
+
+	t7xx_proxy_setup_ch_mapping(port_prox);
+}
+
+static int t7xx_proxy_alloc(struct t7xx_modem *md)
+{
+	unsigned int port_number = ARRAY_SIZE(t7xx_md_ports);
+	struct device *dev = &md->t7xx_dev->pdev->dev;
+	struct t7xx_port *ports_private;
+	struct port_proxy *port_prox;
+	int i;
+
+	port_prox = devm_kzalloc(dev, sizeof(*port_prox), GFP_KERNEL);
+	if (!port_prox)
+		return -ENOMEM;
+
+	md->port_prox = port_prox;
+	port_prox->dev = dev;
+	port_prox->ports_shared = t7xx_md_ports;
+
+	ports_private = devm_kzalloc(dev, sizeof(*ports_private) * port_number, GFP_KERNEL);
+	if (!ports_private)
+		return -ENOMEM;
+
+	for (i = 0; i < port_number; i++) {
+		ports_private[i].port_static = &port_prox->ports_shared[i];
+		ports_private[i].flags = port_prox->ports_shared[i].flags;
+	}
+
+	port_prox->ports_private = ports_private;
+	port_prox->port_number = port_number;
+	t7xx_proxy_init_all_ports(md);
+	return 0;
+};
+
+/**
+ * t7xx_port_proxy_init() - Initialize ports.
+ * @md: Modem.
+ *
+ * Create all port instances.
+ *
+ * Return:
+ * * 0		- Success.
+ * * -ERROR	- Error code from failure sub-initializations.
+ */
+int t7xx_port_proxy_init(struct t7xx_modem *md)
+{
+	int ret;
+
+	ret = t7xx_proxy_alloc(md);
+	if (ret)
+		return ret;
+
+	t7xx_cldma_set_recv_skb(md->md_ctrl[CLDMA_ID_MD], t7xx_port_proxy_recv_skb);
+	return 0;
+}
+
+void t7xx_port_proxy_uninit(struct port_proxy *port_prox)
+{
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		struct t7xx_port_static *port_static = port->port_static;
+
+		if (port_static->ops->uninit)
+			port_static->ops->uninit(port);
+	}
+}
+
+/**
+ * t7xx_port_proxy_node_control() - Create/remove node.
+ * @md: Modem.
+ * @port_msg: Message.
+ *
+ * Used to control create/remove device node.
+ *
+ * Return:
+ * * 0		- Success.
+ * * -EFAULT	- Message check failure.
+ */
+int t7xx_port_proxy_node_control(struct t7xx_modem *md, struct port_msg *port_msg)
+{
+	u32 *port_info_base = (void *)port_msg + sizeof(*port_msg);
+	struct device *dev = &md->t7xx_dev->pdev->dev;
+	unsigned int version, ports, i;
+
+	version = FIELD_GET(PORT_MSG_VERSION, le32_to_cpu(port_msg->info));
+	if (version != PORT_ENUM_VER ||
+	    le32_to_cpu(port_msg->head_pattern) != PORT_ENUM_HEAD_PATTERN ||
+	    le32_to_cpu(port_msg->tail_pattern) != PORT_ENUM_TAIL_PATTERN) {
+		dev_err(dev, "Invalid port control message %x:%x:%x\n",
+			version, le32_to_cpu(port_msg->head_pattern),
+			le32_to_cpu(port_msg->tail_pattern));
+		return -EFAULT;
+	}
+
+	ports = FIELD_GET(PORT_MSG_PRT_CNT, le32_to_cpu(port_msg->info));
+	for (i = 0; i < ports; i++) {
+		struct t7xx_port_static *port_static;
+		u32 *port_info = port_info_base + i;
+		struct t7xx_port *port;
+		unsigned int ch_id;
+		bool en_flag;
+
+		ch_id = FIELD_GET(PORT_INFO_CH_ID, *port_info);
+		port = t7xx_proxy_get_port_by_ch(md->port_prox, ch_id);
+		if (!port) {
+			dev_dbg(dev, "Port:%x not found\n", ch_id);
+			continue;
+		}
+
+		en_flag = !!(PORT_INFO_ENFLG & *port_info);
+
+		if (t7xx_fsm_get_md_state(md->fsm_ctl) == MD_STATE_READY) {
+			port_static = port->port_static;
+
+			if (en_flag) {
+				if (port_static->ops->enable_chl)
+					port_static->ops->enable_chl(port);
+			} else {
+				if (port_static->ops->disable_chl)
+					port_static->ops->disable_chl(port);
+			}
+		} else {
+			port->chan_enable = en_flag;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
new file mode 100644
index 000000000000..59ceb2828aab
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2021, MediaTek Inc.
+ * Copyright (c) 2021-2022, Intel Corporation.
+ *
+ * Authors:
+ *  Amir Hanania <amir.hanania@intel.com>
+ *  Haijun Liu <haijun.liu@mediatek.com>
+ *  Moises Veleta <moises.veleta@intel.com>
+ *  Ricardo Martinez<ricardo.martinez@linux.intel.com>
+ *
+ * Contributors:
+ *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
+ *  Eliot Lee <eliot.lee@intel.com>
+ *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ */
+
+#ifndef __T7XX_PORT_PROXY_H__
+#define __T7XX_PORT_PROXY_H__
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include "t7xx_hif_cldma.h"
+#include "t7xx_modem_ops.h"
+#include "t7xx_port.h"
+
+#define MTK_QUEUES		16
+#define RX_QUEUE_MAXLEN		32
+#define CTRL_QUEUE_MAXLEN	16
+
+struct port_proxy {
+	int				port_number;
+	struct t7xx_port_static		*ports_shared;
+	struct t7xx_port		*ports_private;
+	struct list_head		rx_ch_ports[PORT_CH_ID_MASK + 1];
+	struct list_head		queue_ports[CLDMA_NUM][MTK_QUEUES];
+	struct device			*dev;
+};
+
+struct port_msg {
+	__le32	head_pattern;
+	__le32	info;
+	__le32	tail_pattern;
+};
+
+#define PORT_INFO_RSRVD		GENMASK(31, 16)
+#define PORT_INFO_ENFLG		BIT(15)
+#define PORT_INFO_CH_ID		GENMASK(14, 0)
+
+#define PORT_MSG_VERSION	GENMASK(31, 16)
+#define PORT_MSG_PRT_CNT	GENMASK(15, 0)
+
+#define PORT_ENUM_VER		0
+#define PORT_ENUM_HEAD_PATTERN	0x5a5a5a5a
+#define PORT_ENUM_TAIL_PATTERN	0xa5a5a5a5
+#define PORT_ENUM_VER_MISMATCH	0x00657272
+
+int t7xx_port_proxy_send_skb(struct t7xx_port *port, struct sk_buff *skb);
+void t7xx_port_proxy_set_tx_seq_num(struct t7xx_port *port, struct ccci_header *ccci_h);
+int t7xx_port_proxy_node_control(struct t7xx_modem *md, struct port_msg *port_msg);
+void t7xx_port_proxy_reset(struct port_proxy *port_prox);
+void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
+int t7xx_port_proxy_init(struct t7xx_modem *md);
+void t7xx_port_proxy_md_status_notify(struct port_proxy *port_prox, unsigned int state);
+
+#endif /* __T7XX_PORT_PROXY_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 5c18b0798a1c..cd0d03d8ecb4 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -37,6 +37,7 @@
 #include "t7xx_modem_ops.h"
 #include "t7xx_pci.h"
 #include "t7xx_pcie_mac.h"
+#include "t7xx_port_proxy.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
 
@@ -90,6 +91,9 @@ static void fsm_state_notify(struct t7xx_modem *md, enum md_state state)
 void t7xx_fsm_broadcast_state(struct t7xx_fsm_ctl *ctl, enum md_state state)
 {
 	ctl->md_state = state;
+
+	/* Update to port first, otherwise sending message on HS2 may fail */
+	t7xx_port_proxy_md_status_notify(ctl->md->port_prox, state);
 	fsm_state_notify(ctl->md, state);
 }
 
@@ -258,6 +262,7 @@ static void t7xx_fsm_broadcast_ready_state(struct t7xx_fsm_ctl *ctl)
 	ctl->md_state = MD_STATE_READY;
 
 	fsm_state_notify(ctl->md, MD_STATE_READY);
+	t7xx_port_proxy_md_status_notify(ctl->md->port_prox, MD_STATE_READY);
 }
 
 static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
-- 
2.17.1

