Return-Path: <linux-wireless+bounces-11945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7AE95EA64
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B04B21F5B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17112E1CA;
	Mon, 26 Aug 2024 07:27:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D46129A78
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657243; cv=none; b=CY9uhgYQiH/rS0Yg5LVmjh/8rv3PXQxN+w3vqRftOKwydqz61utWt2e/sdka6yOHhq92Oh1N4cgscEMN8tGeFoGw0cGiZmbWH5xi8LODkxv898ISwc6xdl6AwutbByreSbTpVju/xlHWTU0+nKuBAmLQawwoFXugK8hEql+cBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657243; c=relaxed/simple;
	bh=jHg+VcggDx1nltdMvRdfnVKGEWDdYb+i99lhA80F3qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ONHdJaQeCIe9orLN3JDu+HbXX6wuyBpLMk0mb5jiWhtkx0NPdza/AQDNYuYa8caqSzc6hR+jqFRYvq67puqm/iHQe98R4GpmBFaf7t7RQCjZFChGPiXCclg68JF+B5dPIUfaUKtkRdmVSnYK7qLiP9xmSM0643YK+XvHm6T3J6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0005HR-SJ; Mon, 26 Aug 2024 09:26:53 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0038Es-4c; Mon, 26 Aug 2024 09:26:53 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-000hSF-05;
	Mon, 26 Aug 2024 09:26:53 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/4] wifi: mwifiex: handle VDLL
Date: Mon, 26 Aug 2024 09:26:46 +0200
Message-Id: <20240826072648.167004-3-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826072648.167004-1-s.hauer@pengutronix.de>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Some adapters send events to the Kernel requesting VDLL images. When we
receive such an event we have to upload parts of the firmware image to
the device.

When the firmware requests a VDLL image then we have to bypass the
pending command queue and have to send it immediately. Failing to do
so will cause every other command sent from the queue to timeout.

There is this check currently in mwifiex_download_vdll_block():

	if (adapter->cmd_sent) {
		mwifiex_dbg(adapter, MSG, "%s: adapter is busy\n", __func__);
		return -EBUSY;
	}

The downstream driver has this check as well. However, the downstream
driver tries to defer sending the VDLL command when this happens. It
sets a variable in the private driver struct where the main process
picks it up later.  I am not sure if this can work, because when
adapter->cmd_sent is true then it's already too late, we already missed
to send the VDLL image before the next command. In my tests I never saw
the above trigger, but this surely a place to have a closer look at.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 86 +++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/fw.h     | 16 ++++
 drivers/net/wireless/marvell/mwifiex/main.h   |  4 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  4 +
 .../net/wireless/marvell/mwifiex/uap_event.c  |  4 +
 5 files changed, 114 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 7894102f03eb0..b2535ad458d72 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -1714,3 +1714,89 @@ int mwifiex_ret_wakeup_reason(struct mwifiex_private *priv,
 
 	return 0;
 }
+
+static int mwifiex_download_vdll_block(struct mwifiex_adapter *adapter, u32 offset,
+				       u16 block_len)
+{
+	int ret;
+	struct host_cmd_ds_gen *cmd_hdr = NULL;
+	u16 msg_len = block_len + sizeof(*cmd_hdr);
+	struct sk_buff *skb;
+	u32 fw_offset;
+
+	block_len = min(block_len, adapter->vdll_len - offset);
+
+	if (offset > adapter->vdll_len)
+		return -EINVAL;
+
+	if (adapter->cmd_sent) {
+		mwifiex_dbg(adapter, MSG, "%s: adapter is busy\n", __func__);
+		return -EBUSY;
+	}
+
+	skb = dev_alloc_skb(msg_len + MWIFIEX_TYPE_LEN);
+	if (!skb) {
+		mwifiex_dbg(adapter, ERROR,
+				"SLEEP_CFM: dev_alloc_skb failed\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, msg_len);
+
+	cmd_hdr = (void *)skb->data;
+	cmd_hdr->command = cpu_to_le16(HostCmd_CMD_VDLL);
+	cmd_hdr->seq_num = cpu_to_le16(0xFF00);
+	cmd_hdr->size = cpu_to_le16(msg_len);
+
+	fw_offset = adapter->firmware->size - adapter->vdll_len + offset;
+	memcpy(skb->data + sizeof(*cmd_hdr), adapter->firmware->data + fw_offset, block_len);
+
+	skb_push(skb, adapter->intf_hdr_len);
+
+	ret = adapter->if_ops.host_to_card(adapter, MWIFIEX_TYPE_VDLL, skb, NULL);
+	if (ret < 0)
+		mwifiex_dbg(adapter, MSG, "DNLD_VDLL: Host to Card Failed\n");
+
+	dev_kfree_skb_any(skb);
+
+	return ret;
+
+}
+
+int mwifiex_process_vdll_event(struct mwifiex_private *priv, struct sk_buff *event_skb)
+{
+	int status = 0;
+	struct mwifiex_vdll_ind *ind;
+	struct mwifiex_adapter *adapter = priv->adapter;
+
+	ind = (struct mwifiex_vdll_ind *)(event_skb->data + sizeof(u32));
+
+	switch (le16_to_cpu(ind->type)) {
+	case VDLL_IND_TYPE_REQ:
+		mwifiex_download_vdll_block(adapter, le32_to_cpu(ind->offset),
+					    le16_to_cpu(ind->block_len));
+		break;
+	case VDLL_IND_TYPE_OFFSET:
+		adapter->vdll_len = le32_to_cpu(ind->offset);
+		mwifiex_dbg(adapter, MSG, "VDLL_IND (OFFSET): offset=0x%x\n",
+			    adapter->vdll_len);
+		break;
+	case VDLL_IND_TYPE_ERR_SIG:
+		mwifiex_dbg(adapter, MSG, "VDLL_IND (SIG ERR).\n");
+		break;
+	case VDLL_IND_TYPE_ERR_ID:
+		mwifiex_dbg(adapter, MSG, "VDLL_IND (ID ERR).\n");
+		break;
+	case VDLL_IND_TYPE_SEC_ERR_ID:
+		mwifiex_dbg(adapter, MSG, "VDLL_IND (SECURE ERR).\n");
+		break;
+	case VDLL_IND_TYPE_INTF_RESET:
+		mwifiex_dbg(adapter, MSG, "VDLL_IND (INTF_RESET)\n");
+		break;
+	default:
+		mwifiex_dbg(adapter, MSG, "unknown vdll ind type=%d\n", ind->type);
+		break;
+	}
+
+	return status;
+}
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index e91def0afa14d..f8312f7ba9ac9 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -406,6 +406,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
 #define HostCmd_CMD_FW_DUMP_EVENT		      0x0125
 #define HostCmd_CMD_SDIO_SP_RX_AGGR_CFG               0x0223
 #define HostCmd_CMD_STA_CONFIGURE		      0x023f
+#define HostCmd_CMD_VDLL			      0x0240
 #define HostCmd_CMD_CHAN_REGION_CFG		      0x0242
 #define HostCmd_CMD_PACKET_AGGR_CTRL		      0x0251
 #define HostCmd_CMD_ADD_NEW_STATION		      0x025f
@@ -584,6 +585,7 @@ enum mwifiex_channel_flags {
 #define EVENT_FW_DUMP_INFO		0x00000073
 #define EVENT_TX_STATUS_REPORT		0x00000074
 #define EVENT_BT_COEX_WLAN_PARA_CHANGE	0X00000076
+#define EVENT_VDLL_IND			0x00000081
 
 #define EVENT_ID_MASK                   0xffff
 #define BSS_NUM_MASK                    0xf
@@ -2449,4 +2451,18 @@ struct hw_spec_max_conn {
 	u8 max_sta_conn;
 } __packed;
 
+#define VDLL_IND_TYPE_REQ		0 /* req host side download vdll block */
+#define VDLL_IND_TYPE_OFFSET		1 /* notify vdll start offset in firmware image */
+#define VDLL_IND_TYPE_ERR_SIG		2 /* notify vdll download error: signature error */
+#define VDLL_IND_TYPE_ERR_ID		3 /* notify vdll download error: ID error */
+#define VDLL_IND_TYPE_SEC_ERR_ID	4 /* notify vdll download error: Secure error */
+#define VDLL_IND_TYPE_INTF_RESET	5 /* req host side interface reset */
+
+struct mwifiex_vdll_ind {
+	__le16 type;
+	__le16 vdllId;
+	__le32 offset;
+	__le16 block_len;
+} __packed;
+
 #endif /* !_MWIFIEX_FW_H_ */
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 529863edd7a25..8b7edde32bb5d 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -132,6 +132,7 @@ enum {
 #define MWIFIEX_TYPE_DATA				0
 #define MWIFIEX_TYPE_AGGR_DATA				10
 #define MWIFIEX_TYPE_EVENT				3
+#define MWIFIEX_TYPE_VDLL				4
 
 #define MAX_BITMAP_RATES_SIZE			18
 
@@ -1045,6 +1046,8 @@ struct mwifiex_adapter {
 	struct delayed_work devdump_work;
 
 	bool ignore_btcoex_events;
+
+	u32 vdll_len;
 };
 
 void mwifiex_process_tx_queue(struct mwifiex_adapter *adapter);
@@ -1256,6 +1259,7 @@ int mwifiex_cmd_802_11_bg_scan_config(struct mwifiex_private *priv,
 				      struct host_cmd_ds_command *cmd,
 				      void *data_buf);
 int mwifiex_stop_bg_scan(struct mwifiex_private *priv);
+int mwifiex_process_vdll_event(struct mwifiex_private *priv, struct sk_buff *event_skb);
 
 /*
  * This function checks if the queuing is RA based or not.
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
index b5f3821a6a8f2..d142e70a7f0e1 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
@@ -1088,6 +1088,10 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
 		mwifiex_dbg(adapter, EVENT, "event: firmware debug info\n");
 		mwifiex_fw_dump_info_event(priv, adapter->event_skb);
 		break;
+	case EVENT_VDLL_IND:
+		mwifiex_dbg(adapter, EVENT, "event: VDLL event\n");
+		mwifiex_process_vdll_event(priv, adapter->event_skb);
+		break;
 	/* Debugging event; not used, but let's not print an ERROR for it. */
 	case EVENT_UNKNOWN_DEBUG:
 		mwifiex_dbg(adapter, EVENT, "event: debug\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 58ef5020a46a7..80a9c433db64a 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -317,6 +317,10 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 		memset(&priv->roc_cfg, 0x00, sizeof(struct mwifiex_roc_cfg));
 		break;
 
+	case EVENT_VDLL_IND:
+		mwifiex_dbg(adapter, EVENT, "event: handle VDLL event...\n");
+		mwifiex_process_vdll_event(priv, adapter->event_skb);
+		break;
 	default:
 		mwifiex_dbg(adapter, EVENT,
 			    "event: unknown event id: %#x\n", eventcause);
-- 
2.39.2


