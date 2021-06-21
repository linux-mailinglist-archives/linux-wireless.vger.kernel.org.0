Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F943AE5F2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 11:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFUJZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 05:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhFUJZp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 05:25:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DFC061002;
        Mon, 21 Jun 2021 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624267412;
        bh=y6LpOKy25x4ZddFZbWED3Htr2KJPuP7g+HDvvjfUNRA=;
        h=From:To:Cc:Subject:Date:From;
        b=R/YPxjKLAhk289GNZ5Xnlvv0GezDaZKHBpqiSd8gAcjbNfeMACmG3DUDFtK7yefbA
         YIAkiwC8GZu2Wluc0M7nSatrTWjRDtJh3rnuuamF1/q4bdju2TrlXp/WiaZDxbEF1U
         Vv/FlnpWIMU9jajgWjMkjzo99pKveWeiErXJNWyyfDU+xpCt/YJzU/ADykLF6at9w2
         bX28mKlJea2xgNyS7XayyYTjEL4ZYMfCP6yUPWFDRbY3u0aek/q3Fj8IBP4whgeh1k
         xtZbXvOruMGfreLk5TOEucjwHlyIl1jQ0ZsNqbWKy0qOb8EOvQBLKsl0xCK0NKq4g0
         HVr0VPsoUQgDQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH v4] mt76: mt7921: introduce testmode support
Date:   Mon, 21 Jun 2021 11:23:26 +0200
Message-Id: <028665ab12ba80ab395ed67dd9902ec26ba839e1.1624267307.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We add the testmode support to access the testmode feature provided
by the MT7921 firmware.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Change since v3:
- remove unused variables

Change since v2:
- move mt7921_testmode_attr in MT76_TM_ATTR_DRV_DATA as nested
  attributes
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |   1 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  26 +++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   4 +
 .../wireless/mediatek/mt76/mt7921/testmode.c  | 197 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/testmode.c |   4 +-
 drivers/net/wireless/mediatek/mt76/testmode.h |   7 +
 9 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 1c73beb22677..a37090cac019 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -548,6 +548,7 @@ enum {
 
 /* offload mcu commands */
 enum {
+	MCU_CMD_TEST_CTRL = MCU_CE_PREFIX | 0x01,
 	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
 	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
 	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 0ebb59966a08..3471d82fc265 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_MT7921E) += mt7921e.o
 CFLAGS_trace.o := -I$(src)
 
 mt7921e-y := pci.o mac.o mcu.o dma.o eeprom.o main.o init.o debugfs.o trace.o
+mt7921e-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index a9ce10b98827..08d85c6a7bc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -127,6 +127,8 @@ int mt7921_mac_init(struct mt7921_dev *dev)
 	for (i = 0; i < 2; i++)
 		mt7921_mac_init_band(dev, i);
 
+	dev->mt76.rxfilter = mt76_rr(dev, MT_WF_RFCR(0));
+
 	return mt76_connac_mcu_set_rts_thresh(&dev->mt76, 0x92b, 0);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7fd21049ff5a..a25d6009003b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1202,6 +1202,8 @@ const struct ieee80211_ops mt7921_ops = {
 	.sta_statistics = mt7921_sta_statistics,
 	.sched_scan_start = mt7921_start_sched_scan,
 	.sched_scan_stop = mt7921_stop_sched_scan,
+	CFG80211_TESTMODE_CMD(mt7921_testmode_cmd)
+	CFG80211_TESTMODE_DUMP(mt7921_testmode_dump)
 #ifdef CONFIG_PM
 	.suspend = mt7921_suspend,
 	.resume = mt7921_resume,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index d142c50c1a3d..49e6653b6548 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -319,4 +319,30 @@ struct mt7921_mcu_tx_done_event {
 
 	u8 rsv1[32];
 } __packed;
+
+enum {
+	TM_SWITCH_MODE,
+	TM_SET_AT_CMD,
+	TM_QUERY_AT_CMD,
+};
+
+enum {
+	MT7921_TM_NORMAL,
+	MT7921_TM_TESTMODE,
+	MT7921_TM_ICAP,
+	MT7921_TM_ICAP_OVERLAP,
+	MT7921_TM_WIFISPECTRUM,
+};
+
+struct mt7921_rftest_cmd {
+	u8 action;
+	u8 rsv[3];
+	__le32 param0;
+	__le32 param1;
+} __packed;
+
+struct mt7921_rftest_evt {
+	__le32 param0;
+	__le32 param1;
+} __packed;
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 2d8bd6bfc820..ac0b414ccd92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -388,4 +388,8 @@ void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
 void mt7921_coredump_work(struct work_struct *work);
 int mt7921_wfsys_reset(struct mt7921_dev *dev);
 int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr);
+int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len);
+int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
new file mode 100644
index 000000000000..8bd43879dd6f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: ISC
+
+#include "mt7921.h"
+#include "mcu.h"
+
+enum mt7921_testmode_attr {
+	MT7921_TM_ATTR_UNSPEC,
+	MT7921_TM_ATTR_SET,
+	MT7921_TM_ATTR_QUERY,
+	MT7921_TM_ATTR_RSP,
+
+	/* keep last */
+	NUM_MT7921_TM_ATTRS,
+	MT7921_TM_ATTR_MAX = NUM_MT7921_TM_ATTRS - 1,
+};
+
+struct mt7921_tm_cmd {
+	u8 action;
+	u32 param0;
+	u32 param1;
+};
+
+struct mt7921_tm_evt {
+	u32 param0;
+	u32 param1;
+};
+
+static const struct nla_policy mt7921_tm_policy[NUM_MT7921_TM_ATTRS] = {
+	[MT7921_TM_ATTR_SET] = NLA_POLICY_EXACT_LEN(sizeof(struct mt7921_tm_cmd)),
+	[MT7921_TM_ATTR_QUERY] = NLA_POLICY_EXACT_LEN(sizeof(struct mt7921_tm_cmd)),
+};
+
+static int
+mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_cmd *req)
+{
+	struct mt7921_rftest_cmd cmd = {
+		.action = req->action,
+		.param0 = cpu_to_le32(req->param0),
+		.param1 = cpu_to_le32(req->param1),
+	};
+	bool testmode = false, normal = false;
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_phy *phy = &dev->mphy;
+	int ret = -ENOTCONN;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (req->action == TM_SWITCH_MODE) {
+		if (req->param0 == MT7921_TM_NORMAL)
+			normal = true;
+		else
+			testmode = true;
+	}
+
+	if (testmode) {
+		/* Make sure testmode running on full power mode */
+		pm->enable = false;
+		cancel_delayed_work_sync(&pm->ps_work);
+		cancel_work_sync(&pm->wake_work);
+		__mt7921_mcu_drv_pmctrl(dev);
+
+		mt76_wr(dev, MT_WF_RFCR(0), dev->mt76.rxfilter);
+		phy->test.state = MT76_TM_STATE_ON;
+	}
+
+	if (!mt76_testmode_enabled(phy))
+		goto out;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_TEST_CTRL, &cmd,
+				sizeof(cmd), false);
+	if (ret)
+		goto out;
+
+	if (normal) {
+		/* Switch back to the normal world */
+		phy->test.state = MT76_TM_STATE_OFF;
+		pm->enable = true;
+	}
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7921_tm_query(struct mt7921_dev *dev, struct mt7921_tm_cmd *req,
+		struct mt7921_tm_evt *evt_resp)
+{
+	struct mt7921_rftest_cmd cmd = {
+		.action = req->action,
+		.param0 = cpu_to_le32(req->param0),
+		.param1 = cpu_to_le32(req->param1),
+	};
+	struct mt7921_rftest_evt *evt;
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_TEST_CTRL,
+					&cmd, sizeof(cmd), true, &skb);
+	if (ret)
+		goto out;
+
+	evt = (struct mt7921_rftest_evt *)skb->data;
+	evt_resp->param0 = le32_to_cpu(evt->param0);
+	evt_resp->param1 = le32_to_cpu(evt->param1);
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
+int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len)
+{
+	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt7921_phy *phy = mphy->priv;
+	int err;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
+	    !(hw->conf.flags & IEEE80211_CONF_MONITOR))
+		return -ENOTCONN;
+
+	err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+				   mt76_tm_policy, NULL);
+	if (err)
+		return err;
+
+	if (tb[MT76_TM_ATTR_DRV_DATA]) {
+		struct nlattr *drv_tb[NUM_MT7921_TM_ATTRS], *data;
+		int ret;
+
+		data = tb[MT76_TM_ATTR_DRV_DATA];
+		ret = nla_parse_nested_deprecated(drv_tb,
+						  MT7921_TM_ATTR_MAX,
+						  data, mt7921_tm_policy,
+						  NULL);
+		if (ret)
+			return ret;
+
+		data = drv_tb[MT7921_TM_ATTR_SET];
+		if (data)
+			return mt7921_tm_set(phy->dev, nla_data(data));
+	}
+
+	return -EINVAL;
+}
+
+int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len)
+{
+	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt7921_phy *phy = mphy->priv;
+	int err;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
+	    !(hw->conf.flags & IEEE80211_CONF_MONITOR) ||
+	    !mt76_testmode_enabled(mphy))
+		return -ENOTCONN;
+
+	if (cb->args[2]++ > 0)
+		return -ENOENT;
+
+	err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+				   mt76_tm_policy, NULL);
+	if (err)
+		return err;
+
+	if (tb[MT76_TM_ATTR_DRV_DATA]) {
+		struct nlattr *drv_tb[NUM_MT7921_TM_ATTRS], *data;
+		int ret;
+
+		data = tb[MT76_TM_ATTR_DRV_DATA];
+		ret = nla_parse_nested_deprecated(drv_tb,
+						  MT7921_TM_ATTR_MAX,
+						  data, mt7921_tm_policy,
+						  NULL);
+		if (ret)
+			return ret;
+
+		data = drv_tb[MT7921_TM_ATTR_QUERY];
+		if (data) {
+			struct mt7921_tm_evt evt_resp;
+
+			err = mt7921_tm_query(phy->dev, nla_data(data),
+					      &evt_resp);
+			if (err)
+				return err;
+
+			return nla_put(msg, MT7921_TM_ATTR_RSP,
+				       sizeof(evt_resp), &evt_resp);
+		}
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index f73ffbd6e622..66afc2b0a935 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -2,7 +2,7 @@
 /* Copyright (C) 2020 Felix Fietkau <nbd@nbd.name> */
 #include "mt76.h"
 
-static const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
+const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
 	[MT76_TM_ATTR_RESET] = { .type = NLA_FLAG },
 	[MT76_TM_ATTR_STATE] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_COUNT] = { .type = NLA_U32 },
@@ -21,7 +21,9 @@ static const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
 	[MT76_TM_ATTR_TX_IPG] = { .type = NLA_U32 },
 	[MT76_TM_ATTR_TX_TIME] = { .type = NLA_U32 },
 	[MT76_TM_ATTR_FREQ_OFFSET] = { .type = NLA_U32 },
+	[MT76_TM_ATTR_DRV_DATA] = { .type = NLA_NESTED },
 };
+EXPORT_SYMBOL_GPL(mt76_tm_policy);
 
 void mt76_testmode_tx_pending(struct mt76_phy *phy)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index d32a7654c47e..d1f9c036dd1f 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -44,6 +44,7 @@
  * @MT76_TM_ATTR_TX_IPG: tx inter-packet gap, in unit of us (u32)
  * @MT76_TM_ATTR_TX_TIME: packet transmission time, in unit of us (u32)
  *
+ * @MT76_TM_ATTR_DRV_DATA: driver specific netlink attrs (nested)
  */
 enum mt76_testmode_attr {
 	MT76_TM_ATTR_UNSPEC,
@@ -78,6 +79,8 @@ enum mt76_testmode_attr {
 	MT76_TM_ATTR_TX_IPG,
 	MT76_TM_ATTR_TX_TIME,
 
+	MT76_TM_ATTR_DRV_DATA,
+
 	/* keep last */
 	NUM_MT76_TM_ATTRS,
 	MT76_TM_ATTR_MAX = NUM_MT76_TM_ATTRS - 1,
@@ -144,6 +147,7 @@ enum mt76_testmode_rx_attr {
  * @MT76_TM_STATE_TX_FRAMES: send a fixed number of test frames
  * @MT76_TM_STATE_RX_FRAMES: receive packets and keep statistics
  * @MT76_TM_STATE_TX_CONT: waveform tx without time gap
+ * @MT76_TM_STATE_ON: test mode enabled used in offload firmware
  */
 enum mt76_testmode_state {
 	MT76_TM_STATE_OFF,
@@ -151,6 +155,7 @@ enum mt76_testmode_state {
 	MT76_TM_STATE_TX_FRAMES,
 	MT76_TM_STATE_RX_FRAMES,
 	MT76_TM_STATE_TX_CONT,
+	MT76_TM_STATE_ON,
 
 	/* keep last */
 	NUM_MT76_TM_STATES,
@@ -184,4 +189,6 @@ enum mt76_testmode_tx_mode {
 	MT76_TM_TX_MODE_MAX = NUM_MT76_TM_TX_MODES - 1,
 };
 
+extern const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS];
+
 #endif
-- 
2.31.1

