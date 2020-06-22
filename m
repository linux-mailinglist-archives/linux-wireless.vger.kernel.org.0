Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258E32041B1
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFVUNm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgFVUNk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 16:13:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DBBC061573
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=an/23ENPQHQ5MoIhBFTuyr5vYXPHodf5fjmL5PMd9Ec=; b=sb1FDCaLGF3YCjnrLZ8BpevMR3
        d+OL2qROTErdhmzYVCx8p1xrDmWT1StEsX1wdW4+EMm/WDJXYCWxF9Qba0905ZxnB0RJvjPupgzLF
        GD12lTwtCIAs2wmuNpfKsJiVkfPOzjLb1fKlvMPpVvILJBpI1gJ1lDuohjkDMTKo6Wyo=;
Received: from p54ae948c.dip0.t-ipconnect.de ([84.174.148.140] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jnSp0-0000qE-Ju
        for linux-wireless@vger.kernel.org; Mon, 22 Jun 2020 22:13:38 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/7] mt76: add API for testmode support
Date:   Mon, 22 Jun 2020 22:13:26 +0200
Message-Id: <20200622201327.94414-6-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622201327.94414-1-nbd@nbd.name>
References: <20200622201327.94414-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This can be used for calibration in the manufacturing process.
It supports sending a configurable number of packets with a specific rate
and configurable tx power levels / antenna settings.
It also supports receiving packets and showing some statistics, including
packet counters and detailed RSSI information.
It will only be compiled in if CONFIG_NL80211_TESTMODE is enabled

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   1 +
 drivers/net/wireless/mediatek/mt76/eeprom.c   |   5 +
 drivers/net/wireless/mediatek/mt76/mac80211.c |   7 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  75 +++
 drivers/net/wireless/mediatek/mt76/testmode.c | 497 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/testmode.h | 156 ++++++
 drivers/net/wireless/mediatek/mt76/tx.c       |  18 +
 7 files changed, 759 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/testmode.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/testmode.h

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index ef663b873b0b..949b3c8ffa1b 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -9,6 +9,7 @@ mt76-y := \
 	tx.o agg-rx.o mcu.o
 
 mt76-$(CONFIG_PCI) += pci.o
+mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
 
 mt76-usb-y := usb.o usb_trace.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index c236e303ccfd..3044e0069991 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -74,6 +74,11 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 					   &data[i]);
 	}
 
+#ifdef CONFIG_NL80211_TESTMODE
+	dev->test.mtd_name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
+	dev->test.mtd_offset = offset;
+#endif
+
 out_put_node:
 	of_node_put(np);
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index d8533d0c6e81..10e6dbb64996 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -505,6 +505,13 @@ void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 		return;
 	}
 
+#ifdef CONFIG_NL80211_TESTMODE
+	if (dev->test.state == MT76_TM_STATE_RX_FRAMES) {
+		dev->test.rx_stats.packets[q]++;
+		if (status->flag & RX_FLAG_FAILED_FCS_CRC)
+			dev->test.rx_stats.fcs_error[q]++;
+	}
+#endif
 	__skb_queue_tail(&dev->rx_skb[q], skb);
 }
 EXPORT_SYMBOL_GPL(mt76_rx);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ece462e9c9ab..14b3a39cd55a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -15,6 +15,7 @@
 #include <linux/average.h>
 #include <net/mac80211.h>
 #include "util.h"
+#include "testmode.h"
 
 #define MT_TX_RING_SIZE     256
 #define MT_MCU_RING_SIZE    32
@@ -475,6 +476,47 @@ struct mt76_rx_status {
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 };
 
+struct mt76_testmode_ops {
+	int (*set_state)(struct mt76_dev *dev, enum mt76_testmode_state state);
+	int (*set_params)(struct mt76_dev *dev, struct nlattr **tb,
+			  enum mt76_testmode_state new_state);
+	int (*dump_stats)(struct mt76_dev *dev, struct sk_buff *msg);
+};
+
+struct mt76_testmode_data {
+	enum mt76_testmode_state state;
+
+	u32 param_set[DIV_ROUND_UP(NUM_MT76_TM_ATTRS, 32)];
+	struct sk_buff *tx_skb;
+
+	u32 tx_count;
+	u16 tx_msdu_len;
+
+	u8 tx_rate_mode;
+	u8 tx_rate_idx;
+	u8 tx_rate_nss;
+	u8 tx_rate_sgi;
+	u8 tx_rate_ldpc;
+
+	u8 tx_antenna_mask;
+
+	u32 freq_offset;
+
+	u8 tx_power[4];
+	u8 tx_power_control;
+
+	const char *mtd_name;
+	u32 mtd_offset;
+
+	u32 tx_pending;
+	u32 tx_queued;
+	u32 tx_done;
+	struct {
+		u64 packets[__MT_RXQ_MAX];
+		u64 fcs_error[__MT_RXQ_MAX];
+	} rx_stats;
+};
+
 struct mt76_phy {
 	struct ieee80211_hw *hw;
 	struct mt76_dev *dev;
@@ -574,6 +616,11 @@ struct mt76_dev {
 
 	u32 rxfilter;
 
+#ifdef CONFIG_NL80211_TESTMODE
+	const struct mt76_testmode_ops *test_ops;
+	struct mt76_testmode_data test;
+#endif
+
 	union {
 		struct mt76_mmio mmio;
 		struct mt76_usb usb;
@@ -807,6 +854,15 @@ static inline u8 mt76_tx_power_nss_delta(u8 nss)
 	return nss_delta[nss - 1];
 }
 
+static inline bool mt76_testmode_enabled(struct mt76_dev *dev)
+{
+#ifdef CONFIG_NL80211_TESTMODE
+	return dev->test.state != MT76_TM_STATE_OFF;
+#else
+	return false;
+#endif
+}
+
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb);
 void mt76_tx(struct mt76_phy *dev, struct ieee80211_sta *sta,
 	     struct mt76_wcid *wcid, struct sk_buff *skb);
@@ -879,6 +935,24 @@ void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
+int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      void *data, int len);
+int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
+		       struct netlink_callback *cb, void *data, int len);
+int mt76_testmode_set_state(struct mt76_dev *dev, enum mt76_testmode_state state);
+
+static inline void mt76_testmode_reset(struct mt76_dev *dev, bool disable)
+{
+#ifdef CONFIG_NL80211_TESTMODE
+	enum mt76_testmode_state state = MT76_TM_STATE_IDLE;
+
+	if (disable || dev->test.state == MT76_TM_STATE_OFF)
+		state = MT76_TM_STATE_OFF;
+
+	mt76_testmode_set_state(dev, state);
+#endif
+}
+
 
 /* internal */
 static inline struct ieee80211_hw *
@@ -903,6 +977,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 			   struct napi_struct *napi);
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
+void mt76_testmode_tx_pending(struct mt76_dev *dev);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
new file mode 100644
index 000000000000..a78388fb35eb
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
+#include "mt76.h"
+
+static const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
+	[MT76_TM_ATTR_RESET] = { .type = NLA_FLAG },
+	[MT76_TM_ATTR_STATE] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_COUNT] = { .type = NLA_U32 },
+	[MT76_TM_ATTR_TX_RATE_MODE] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_RATE_NSS] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_RATE_IDX] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_RATE_SGI] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_RATE_LDPC] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_ANTENNA] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_POWER_CONTROL] = { .type = NLA_U8 },
+	[MT76_TM_ATTR_TX_POWER] = { .type = NLA_NESTED },
+	[MT76_TM_ATTR_FREQ_OFFSET] = { .type = NLA_U32 },
+};
+
+void mt76_testmode_tx_pending(struct mt76_dev *dev)
+{
+	struct mt76_testmode_data *td = &dev->test;
+	struct mt76_wcid *wcid = &dev->global_wcid;
+	struct sk_buff *skb = td->tx_skb;
+	struct mt76_queue *q;
+	int qid;
+
+	if (!skb || !td->tx_pending)
+		return;
+
+	qid = skb_get_queue_mapping(skb);
+	q = dev->q_tx[qid].q;
+
+	spin_lock_bh(&q->lock);
+
+	while (td->tx_pending > 0 && q->queued < q->ndesc / 2) {
+		int ret;
+
+		ret = dev->queue_ops->tx_queue_skb(dev, qid, skb_get(skb), wcid, NULL);
+		if (ret < 0)
+			break;
+
+		td->tx_pending--;
+		td->tx_queued++;
+	}
+
+	dev->queue_ops->kick(dev, q);
+
+	spin_unlock_bh(&q->lock);
+}
+
+
+static int
+mt76_testmode_tx_init(struct mt76_dev *dev)
+{
+	struct mt76_testmode_data *td = &dev->test;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_hdr *hdr;
+	struct sk_buff *skb;
+	u16 fc = IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA |
+		 IEEE80211_FCTL_FROMDS;
+	struct ieee80211_tx_rate *rate;
+	u8 max_nss = hweight8(dev->phy.antenna_mask);
+
+	if (td->tx_antenna_mask)
+		max_nss = min_t(u8, max_nss, hweight8(td->tx_antenna_mask));
+
+	skb = alloc_skb(td->tx_msdu_len, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	dev_kfree_skb(td->tx_skb);
+	td->tx_skb = skb;
+	hdr = __skb_put_zero(skb, td->tx_msdu_len);
+	hdr->frame_control = cpu_to_le16(fc);
+	memcpy(hdr->addr1, dev->macaddr, sizeof(dev->macaddr));
+	memcpy(hdr->addr2, dev->macaddr, sizeof(dev->macaddr));
+	memcpy(hdr->addr3, dev->macaddr, sizeof(dev->macaddr));
+
+	info = IEEE80211_SKB_CB(skb);
+	info->flags = IEEE80211_TX_CTL_INJECTED |
+		      IEEE80211_TX_CTL_NO_ACK |
+		      IEEE80211_TX_CTL_NO_PS_BUFFER;
+	rate = &info->control.rates[0];
+	rate->count = 1;
+	rate->idx = td->tx_rate_idx;
+
+	switch (td->tx_rate_mode) {
+	case MT76_TM_TX_MODE_CCK:
+		if (dev->phy.chandef.chan->band != NL80211_BAND_2GHZ)
+			return -EINVAL;
+
+		if (rate->idx > 4)
+			return -EINVAL;
+		break;
+	case MT76_TM_TX_MODE_OFDM:
+		if (dev->phy.chandef.chan->band != NL80211_BAND_2GHZ)
+			break;
+
+		if (rate->idx > 8)
+			return -EINVAL;
+
+		rate->idx += 4;
+		break;
+	case MT76_TM_TX_MODE_HT:
+		if (rate->idx > 8 * max_nss &&
+			!(rate->idx == 32 &&
+			  dev->phy.chandef.width >= NL80211_CHAN_WIDTH_40))
+			return -EINVAL;
+
+		rate->flags |= IEEE80211_TX_RC_MCS;
+		break;
+	case MT76_TM_TX_MODE_VHT:
+		if (rate->idx > 9)
+			return -EINVAL;
+
+		if (td->tx_rate_nss > max_nss)
+			return -EINVAL;
+
+		ieee80211_rate_set_vht(rate, td->tx_rate_idx, td->tx_rate_nss);
+		rate->flags |= IEEE80211_TX_RC_VHT_MCS;
+		break;
+	default:
+		break;
+	}
+
+	if (td->tx_rate_sgi)
+		rate->flags |= IEEE80211_TX_RC_SHORT_GI;
+
+	if (td->tx_rate_ldpc)
+		info->flags |= IEEE80211_TX_CTL_LDPC;
+
+	if (td->tx_rate_mode >= MT76_TM_TX_MODE_HT) {
+		switch (dev->phy.chandef.width) {
+		case NL80211_CHAN_WIDTH_40:
+			rate->flags |= IEEE80211_TX_RC_40_MHZ_WIDTH;
+			break;
+		case NL80211_CHAN_WIDTH_80:
+			rate->flags |= IEEE80211_TX_RC_80_MHZ_WIDTH;
+			break;
+		case NL80211_CHAN_WIDTH_80P80:
+		case NL80211_CHAN_WIDTH_160:
+			rate->flags |= IEEE80211_TX_RC_160_MHZ_WIDTH;
+			break;
+		default:
+			break;
+		}
+	}
+
+	skb_set_queue_mapping(skb, IEEE80211_AC_BE);
+
+	return 0;
+}
+
+static void
+mt76_testmode_tx_start(struct mt76_dev *dev)
+{
+	struct mt76_testmode_data *td = &dev->test;
+
+	td->tx_queued = 0;
+	td->tx_done = 0;
+	td->tx_pending = td->tx_count;
+	tasklet_schedule(&dev->tx_tasklet);
+}
+
+static void
+mt76_testmode_tx_stop(struct mt76_dev *dev)
+{
+	struct mt76_testmode_data *td = &dev->test;
+
+	tasklet_disable(&dev->tx_tasklet);
+
+	td->tx_pending = 0;
+
+	tasklet_enable(&dev->tx_tasklet);
+
+	wait_event_timeout(dev->tx_wait, td->tx_done == td->tx_queued, 10 * HZ);
+
+	dev_kfree_skb(td->tx_skb);
+	td->tx_skb = NULL;
+}
+
+static inline void
+mt76_testmode_param_set(struct mt76_testmode_data *td, u16 idx)
+{
+	td->param_set[idx / 32] |= BIT(idx % 32);
+}
+
+static inline bool
+mt76_testmode_param_present(struct mt76_testmode_data *td, u16 idx)
+{
+	return td->param_set[idx / 32] & BIT(idx % 32);
+}
+
+static void
+mt76_testmode_init_defaults(struct mt76_dev *dev)
+{
+	struct mt76_testmode_data *td = &dev->test;
+
+	if (td->tx_msdu_len > 0)
+		return;
+
+	td->tx_msdu_len = 1024;
+	td->tx_count = 1;
+	td->tx_rate_mode = MT76_TM_TX_MODE_OFDM;
+	td->tx_rate_nss = 1;
+}
+
+static int
+__mt76_testmode_set_state(struct mt76_dev *dev, enum mt76_testmode_state state)
+{
+	enum mt76_testmode_state prev_state = dev->test.state;
+	int err;
+
+	if (prev_state == MT76_TM_STATE_TX_FRAMES)
+		mt76_testmode_tx_stop(dev);
+
+	if (state == MT76_TM_STATE_TX_FRAMES) {
+		err = mt76_testmode_tx_init(dev);
+		if (err)
+			return err;
+	}
+
+	err = dev->test_ops->set_state(dev, state);
+	if (err) {
+		if (state == MT76_TM_STATE_TX_FRAMES)
+			mt76_testmode_tx_stop(dev);
+
+		return err;
+	}
+
+	if (state == MT76_TM_STATE_TX_FRAMES)
+		mt76_testmode_tx_start(dev);
+	else if (state == MT76_TM_STATE_RX_FRAMES) {
+		memset(&dev->test.rx_stats, 0, sizeof(dev->test.rx_stats));
+	}
+
+	dev->test.state = state;
+
+	return 0;
+}
+
+int mt76_testmode_set_state(struct mt76_dev *dev, enum mt76_testmode_state state)
+{
+	struct mt76_testmode_data *td = &dev->test;
+	struct ieee80211_hw *hw = dev->phy.hw;
+
+	if (state == td->state && state == MT76_TM_STATE_OFF)
+		return 0;
+
+	if (state > MT76_TM_STATE_OFF &&
+	    (!test_bit(MT76_STATE_RUNNING, &dev->phy.state) ||
+	     !(hw->conf.flags & IEEE80211_CONF_MONITOR)))
+		return -ENOTCONN;
+
+	if (state != MT76_TM_STATE_IDLE &&
+	    td->state != MT76_TM_STATE_IDLE) {
+		int ret;
+
+		ret = __mt76_testmode_set_state(dev, MT76_TM_STATE_IDLE);
+		if (ret)
+			return ret;
+	}
+
+	return __mt76_testmode_set_state(dev, state);
+
+}
+EXPORT_SYMBOL(mt76_testmode_set_state);
+
+static int
+mt76_tm_get_u8(struct nlattr *attr, u8 *dest, u8 min, u8 max)
+{
+	u8 val;
+
+	if (!attr)
+		return 0;
+
+	val = nla_get_u8(attr);
+	if (val < min || val > max)
+		return -EINVAL;
+
+	*dest = val;
+	return 0;
+}
+
+int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      void *data, int len)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_testmode_data *td = &dev->test;
+	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	u32 state;
+	int err;
+	int i;
+
+	if (!dev->test_ops)
+		return -EOPNOTSUPP;
+
+	err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+				   mt76_tm_policy, NULL);
+	if (err)
+		return err;
+
+	err = -EINVAL;
+
+	mutex_lock(&dev->mutex);
+
+	if (tb[MT76_TM_ATTR_RESET]) {
+		mt76_testmode_set_state(dev, MT76_TM_STATE_OFF);
+		memset(td, 0, sizeof(*td));
+	}
+
+	mt76_testmode_init_defaults(dev);
+
+	if (tb[MT76_TM_ATTR_TX_COUNT])
+		td->tx_count = nla_get_u32(tb[MT76_TM_ATTR_TX_COUNT]);
+
+	if (tb[MT76_TM_ATTR_TX_LENGTH]) {
+		u32 val = nla_get_u32(tb[MT76_TM_ATTR_TX_COUNT]);
+
+		if (val > IEEE80211_MAX_FRAME_LEN ||
+		    val < sizeof(struct ieee80211_hdr))
+			goto out;
+
+		td->tx_msdu_len = val;
+	}
+
+	if (tb[MT76_TM_ATTR_TX_RATE_IDX])
+		td->tx_rate_idx = nla_get_u8(tb[MT76_TM_ATTR_TX_RATE_IDX]);
+
+	if (mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_MODE], &td->tx_rate_mode,
+			   0, MT76_TM_TX_MODE_MAX) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_NSS], &td->tx_rate_nss,
+			   1, hweight8(phy->antenna_mask)) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_SGI], &td->tx_rate_sgi, 0, 1) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_RATE_LDPC], &td->tx_rate_ldpc, 0, 1) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_ANTENNA], &td->tx_antenna_mask, 1,
+			   phy->antenna_mask) ||
+	    mt76_tm_get_u8(tb[MT76_TM_ATTR_TX_POWER_CONTROL],
+			   &td->tx_power_control, 0, 1))
+		goto out;
+
+	if (tb[MT76_TM_ATTR_FREQ_OFFSET])
+		td->freq_offset = nla_get_u32(tb[MT76_TM_ATTR_FREQ_OFFSET]);
+
+	if (tb[MT76_TM_ATTR_STATE]) {
+		state = nla_get_u32(tb[MT76_TM_ATTR_STATE]);
+		if (state > MT76_TM_STATE_MAX)
+			goto out;
+	} else {
+		state = td->state;
+	}
+
+	if (tb[MT76_TM_ATTR_TX_POWER]) {
+		struct nlattr *cur;
+		int idx = 0;
+		int rem;
+
+		nla_for_each_nested(cur, tb[MT76_TM_ATTR_TX_POWER], rem) {
+			if (nla_len(cur) != 1 ||
+			    idx >= ARRAY_SIZE(td->tx_power))
+				goto out;
+
+			td->tx_power[idx++] = nla_get_u8(cur);
+		}
+	}
+
+	if (dev->test_ops->set_params) {
+		err = dev->test_ops->set_params(dev, tb, state);
+		if (err)
+			goto out;
+	}
+
+	for (i = MT76_TM_ATTR_STATE; i < ARRAY_SIZE(tb); i++)
+		if (tb[i])
+			mt76_testmode_param_set(td, i);
+
+	err = 0;
+	if (tb[MT76_TM_ATTR_STATE])
+		err = mt76_testmode_set_state(dev, state);
+
+out:
+	mutex_unlock(&dev->mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(mt76_testmode_cmd);
+
+static int
+mt76_testmode_dump_stats(struct mt76_dev *dev, struct sk_buff *msg)
+{
+	struct mt76_testmode_data *td = &dev->test;
+	u64 rx_packets = 0;
+	u64 rx_fcs_error = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(td->rx_stats.packets); i++) {
+		rx_packets += td->rx_stats.packets[i];
+		rx_fcs_error += td->rx_stats.fcs_error[i];
+	}
+
+	if (nla_put_u32(msg, MT76_TM_STATS_ATTR_TX_PENDING, td->tx_pending) ||
+	    nla_put_u32(msg, MT76_TM_STATS_ATTR_TX_QUEUED, td->tx_queued) ||
+	    nla_put_u32(msg, MT76_TM_STATS_ATTR_TX_DONE, td->tx_done) ||
+	    nla_put_u64_64bit(msg, MT76_TM_STATS_ATTR_RX_PACKETS, rx_packets,
+			      MT76_TM_STATS_ATTR_PAD) ||
+	    nla_put_u64_64bit(msg, MT76_TM_STATS_ATTR_RX_FCS_ERROR, rx_fcs_error,
+			      MT76_TM_STATS_ATTR_PAD))
+		return -EMSGSIZE;
+
+	if (dev->test_ops->dump_stats)
+		return dev->test_ops->dump_stats(dev, msg);
+
+	return 0;
+}
+
+int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+		       struct netlink_callback *cb, void *data, int len)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_testmode_data *td = &dev->test;
+	struct nlattr *tb[NUM_MT76_TM_ATTRS] = {};
+	int err = 0;
+	void *a;
+	int i;
+
+	if (!dev->test_ops)
+		return -EOPNOTSUPP;
+
+	if (cb->args[2]++ > 0)
+		return -ENOENT;
+
+	if (data) {
+		err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+					   mt76_tm_policy, NULL);
+		if (err)
+			return err;
+	}
+
+	mutex_lock(&dev->mutex);
+
+	if (tb[MT76_TM_ATTR_STATS]) {
+		a = nla_nest_start(msg, MT76_TM_ATTR_STATS);
+		err = mt76_testmode_dump_stats(dev, msg);
+		nla_nest_end(msg, a);
+
+		goto out;
+	}
+
+	mt76_testmode_init_defaults(dev);
+
+	err = -EMSGSIZE;
+	if (nla_put_u32(msg, MT76_TM_ATTR_STATE, td->state))
+		goto out;
+
+	if (td->mtd_name &&
+	    (nla_put_string(msg, MT76_TM_ATTR_MTD_PART, td->mtd_name) ||
+	     nla_put_u32(msg, MT76_TM_ATTR_MTD_OFFSET, td->mtd_offset)))
+		goto out;
+
+	if (nla_put_u32(msg, MT76_TM_ATTR_TX_COUNT, td->tx_count) ||
+	    nla_put_u32(msg, MT76_TM_ATTR_TX_LENGTH, td->tx_msdu_len) ||
+	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_MODE, td->tx_rate_mode) ||
+	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_NSS, td->tx_rate_nss) ||
+	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_IDX, td->tx_rate_idx) ||
+	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_SGI, td->tx_rate_sgi) ||
+	    nla_put_u8(msg, MT76_TM_ATTR_TX_RATE_LDPC, td->tx_rate_ldpc) ||
+	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_ANTENNA) &&
+	     nla_put_u8(msg, MT76_TM_ATTR_TX_ANTENNA, td->tx_antenna_mask)) ||
+	    (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_POWER_CONTROL) &&
+	     nla_put_u8(msg, MT76_TM_ATTR_TX_POWER_CONTROL, td->tx_power_control)) ||
+	    (mt76_testmode_param_present(td, MT76_TM_ATTR_FREQ_OFFSET) &&
+	     nla_put_u8(msg, MT76_TM_ATTR_FREQ_OFFSET, td->freq_offset)))
+		goto out;
+
+	if (mt76_testmode_param_present(td, MT76_TM_ATTR_TX_POWER)) {
+		a = nla_nest_start(msg, MT76_TM_ATTR_TX_POWER);
+		if (!a)
+			goto out;
+
+		for (i = 0; i < ARRAY_SIZE(td->tx_power); i++)
+			if (nla_put_u8(msg, i, td->tx_power[i]))
+				goto out;
+
+		nla_nest_end(msg, a);
+	}
+
+	err = 0;
+
+out:
+	mutex_unlock(&dev->mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(mt76_testmode_dump);
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
new file mode 100644
index 000000000000..691fe5773244
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (C) 2020 Felix Fietkau <nbd@nbd.name>
+ */
+#ifndef __MT76_TESTMODE_H
+#define __MT76_TESTMODE_H
+
+/**
+ * enum mt76_testmode_attr - testmode attributes inside NL80211_ATTR_TESTDATA
+ *
+ * @MT76_TM_ATTR_UNSPEC: (invalid attribute)
+ *
+ * @MT76_TM_ATTR_RESET: reset parameters to default (flag)
+ * @MT76_TM_ATTR_STATE: test state (u32), see &enum mt76_testmode_state
+ *
+ * @MT76_TM_ATTR_MTD_PART: mtd partition used for eeprom data (string)
+ * @MT76_TM_ATTR_MTD_OFFSET: offset of eeprom data within the partition (u32)
+ *
+ * @MT76_TM_ATTR_TX_COUNT: configured number of frames to send when setting
+ *	state to MT76_TM_STATE_TX_FRAMES (u32)
+ * @MT76_TM_ATTR_TX_PENDING: pending frames during MT76_TM_STATE_TX_FRAMES (u32)
+ * @MT76_TM_ATTR_TX_LENGTH: packet tx msdu length (u32)
+ * @MT76_TM_ATTR_TX_RATE_MODE: packet tx mode (u8, see &enum mt76_testmode_tx_mode)
+ * @MT76_TM_ATTR_TX_RATE_NSS: packet tx number of spatial streams (u8)
+ * @MT76_TM_ATTR_TX_RATE_IDX: packet tx rate/MCS index (u8)
+ * @MT76_TM_ATTR_TX_RATE_SGI: packet tx use short guard interval (u8)
+ * @MT76_TM_ATTR_TX_RATE_LDPC: packet tx enable LDPC (u8)
+ *
+ * @MT76_TM_ATTR_TX_ANTENNA: tx antenna mask (u8)
+ * @MT76_TM_ATTR_TX_POWER_CONTROL: enable tx power control (u8)
+ * @MT76_TM_ATTR_TX_POWER: per-antenna tx power array (nested, u8 attrs)
+ *
+ * @MT76_TM_ATTR_FREQ_OFFSET: RF frequency offset (u32)
+ *
+ * @MT76_TM_ATTR_STATS: statistics (nested, see &enum mt76_testmode_stats_attr)
+ */
+enum mt76_testmode_attr {
+	MT76_TM_ATTR_UNSPEC,
+
+	MT76_TM_ATTR_RESET,
+	MT76_TM_ATTR_STATE,
+
+	MT76_TM_ATTR_MTD_PART,
+	MT76_TM_ATTR_MTD_OFFSET,
+
+	MT76_TM_ATTR_TX_COUNT,
+	MT76_TM_ATTR_TX_LENGTH,
+	MT76_TM_ATTR_TX_RATE_MODE,
+	MT76_TM_ATTR_TX_RATE_NSS,
+	MT76_TM_ATTR_TX_RATE_IDX,
+	MT76_TM_ATTR_TX_RATE_SGI,
+	MT76_TM_ATTR_TX_RATE_LDPC,
+
+	MT76_TM_ATTR_TX_ANTENNA,
+	MT76_TM_ATTR_TX_POWER_CONTROL,
+	MT76_TM_ATTR_TX_POWER,
+
+	MT76_TM_ATTR_FREQ_OFFSET,
+
+	MT76_TM_ATTR_STATS,
+
+	/* keep last */
+	NUM_MT76_TM_ATTRS,
+	MT76_TM_ATTR_MAX = NUM_MT76_TM_ATTRS - 1,
+};
+
+/**
+ * enum mt76_testmode_state - statistics attributes
+ *
+ * @MT76_TM_STATS_ATTR_TX_PENDING: pending tx frames (u32)
+ * @MT76_TM_STATS_ATTR_TX_QUEUED: queued tx frames (u32)
+ * @MT76_TM_STATS_ATTR_TX_QUEUED: completed tx frames (u32)
+ *
+ * @MT76_TM_STATS_ATTR_RX_PACKETS: number of rx packets (u64)
+ * @MT76_TM_STATS_ATTR_RX_FCS_ERROR: number of rx packets with FCS error (u64)
+ * @MT76_TM_STATS_ATTR_LAST_RX: information about the last received packet
+ *	see &enum mt76_testmode_rx_attr
+ */
+enum mt76_testmode_stats_attr {
+	MT76_TM_STATS_ATTR_UNSPEC,
+	MT76_TM_STATS_ATTR_PAD,
+
+	MT76_TM_STATS_ATTR_TX_PENDING,
+	MT76_TM_STATS_ATTR_TX_QUEUED,
+	MT76_TM_STATS_ATTR_TX_DONE,
+
+	MT76_TM_STATS_ATTR_RX_PACKETS,
+	MT76_TM_STATS_ATTR_RX_FCS_ERROR,
+	MT76_TM_STATS_ATTR_LAST_RX,
+
+	/* keep last */
+	NUM_MT76_TM_STATS_ATTRS,
+	MT76_TM_STATS_ATTR_MAX = NUM_MT76_TM_STATS_ATTRS - 1,
+};
+
+
+/**
+ * enum mt76_testmode_rx_attr - packet rx information
+ *
+ * @MT76_TM_RX_ATTR_FREQ_OFFSET: frequency offset (s32)
+ * @MT76_TM_RX_ATTR_RCPI: received channel power indicator (array, u8)
+ * @MT76_TM_RX_ATTR_IB_RSSI: internal inband RSSI (s8)
+ * @MT76_TM_RX_ATTR_WB_RSSI: internal wideband RSSI (s8)
+ */
+enum mt76_testmode_rx_attr {
+	MT76_TM_RX_ATTR_UNSPEC,
+
+	MT76_TM_RX_ATTR_FREQ_OFFSET,
+	MT76_TM_RX_ATTR_RCPI,
+	MT76_TM_RX_ATTR_IB_RSSI,
+	MT76_TM_RX_ATTR_WB_RSSI,
+
+	/* keep last */
+	NUM_MT76_TM_RX_ATTRS,
+	MT76_TM_RX_ATTR_MAX = NUM_MT76_TM_RX_ATTRS - 1,
+};
+
+/**
+ * enum mt76_testmode_state - phy test state
+ *
+ * @MT76_TM_STATE_OFF: test mode disabled (normal operation)
+ * @MT76_TM_STATE_IDLE: test mode enabled, but idle
+ * @MT76_TM_STATE_TX_FRAMES: send a fixed number of test frames
+ * @MT76_TM_STATE_RX_FRAMES: receive packets and keep statistics
+ */
+enum mt76_testmode_state {
+	MT76_TM_STATE_OFF,
+	MT76_TM_STATE_IDLE,
+	MT76_TM_STATE_TX_FRAMES,
+	MT76_TM_STATE_RX_FRAMES,
+
+	/* keep last */
+	NUM_MT76_TM_STATES,
+	MT76_TM_STATE_MAX = NUM_MT76_TM_STATES - 1,
+};
+
+/**
+ * enum mt76_testmode_tx_mode - packet tx phy mode
+ *
+ * @MT76_TM_TX_MODE_CCK: legacy CCK mode
+ * @MT76_TM_TX_MODE_OFDM: legacy OFDM mode
+ * @MT76_TM_TX_MODE_HT: 802.11n MCS
+ * @MT76_TM_TX_MODE_VHT: 802.11ac MCS
+ */
+enum mt76_testmode_tx_mode {
+	MT76_TM_TX_MODE_CCK,
+	MT76_TM_TX_MODE_OFDM,
+	MT76_TM_TX_MODE_HT,
+	MT76_TM_TX_MODE_VHT,
+
+	/* keep last */
+	NUM_MT76_TM_TX_MODES,
+	MT76_TM_TX_MODE_MAX = NUM_MT76_TM_TX_MODES - 1,
+};
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index f10c98aa883c..5adf92d7a9f3 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -236,6 +236,14 @@ void mt76_tx_complete_skb(struct mt76_dev *dev, struct sk_buff *skb)
 	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
 
+#ifdef CONFIG_NL80211_TESTMODE
+	if (skb == dev->test.tx_skb) {
+		dev->test.tx_done++;
+		if (dev->test.tx_queued == dev->test.tx_done)
+			wake_up(&dev->tx_wait);
+	}
+#endif
+
 	if (!skb->prev) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		ieee80211_free_txskb(hw, skb);
@@ -259,6 +267,11 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	int qid = skb_get_queue_mapping(skb);
 	bool ext_phy = phy != &dev->phy;
 
+	if (mt76_testmode_enabled(dev)) {
+		ieee80211_free_txskb(phy->hw, skb);
+		return;
+	}
+
 	if (WARN_ON(qid >= MT_TXQ_PSD)) {
 		qid = MT_TXQ_BE;
 		skb_set_queue_mapping(skb, qid);
@@ -579,6 +592,11 @@ void mt76_tx_tasklet(unsigned long data)
 	mt76_txq_schedule_all(&dev->phy);
 	if (dev->phy2)
 		mt76_txq_schedule_all(dev->phy2);
+
+#ifdef CONFIG_NL80211_TESTMODE
+	if (dev->test.tx_pending)
+		mt76_testmode_tx_pending(dev);
+#endif
 }
 
 void mt76_stop_tx_queues(struct mt76_dev *dev, struct ieee80211_sta *sta,
-- 
2.24.0

