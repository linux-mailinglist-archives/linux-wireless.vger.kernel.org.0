Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A193A8A99
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 23:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhFOVIt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 17:08:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39449 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229898AbhFOVIt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 17:08:49 -0400
X-UUID: 5d13d84c3307459da5e667e90257dbbb-20210616
X-UUID: 5d13d84c3307459da5e667e90257dbbb-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2078427880; Wed, 16 Jun 2021 05:06:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 05:06:39 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 05:06:33 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2] mt76: mt7921: introduce testmode support
Date:   Wed, 16 Jun 2021 05:06:32 +0800
Message-ID: <4ca37075cd3f53ea5f999c3d7fd7f35dd8d5dcb8.1623789594.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

We add the testmode support to access the testmode feature provided
by the MT7921 firmware.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
v2: write MT_WF_RFCR when driver must be in drv_own state
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |   1 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |   1 +
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  26 +++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   4 +
 .../wireless/mediatek/mt76/mt7921/testmode.c  | 172 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/testmode.h |   2 +
 8 files changed, 210 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index bb0d7b28fe24..70c3b4b4acc6 100644
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
index e531666f9fb4..8361f9558ea1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_MT7921E) += mt7921e.o
 CFLAGS_trace.o := -I$(src)

 mt7921e-y := pci.o mac.o mcu.o dma.o eeprom.o main.o init.o debugfs.o trace.o
+mt7921e-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 2caa5096a419..c37084796525 100644
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
index f062088780c2..1cdd093559bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1196,6 +1196,8 @@ const struct ieee80211_ops mt7921_ops = {
 	.sta_statistics = mt7921_sta_statistics,
 	.sched_scan_start = mt7921_start_sched_scan,
 	.sched_scan_stop = mt7921_stop_sched_scan,
+	CFG80211_TESTMODE_CMD(mt7921_testmode_cmd)
+	CFG80211_TESTMODE_DUMP(mt7921_testmode_dump)
 #ifdef CONFIG_PM
 	.suspend = mt7921_suspend,
 	.resume = mt7921_resume,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 89fed2f71161..e964a06359d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -320,4 +320,30 @@ struct mt7921_mcu_tx_done_event {

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
index 087067e7ea5b..b191350dfc69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -384,4 +384,8 @@ void mt7921_pm_interface_iter(void *priv, u8 *mac, struct ieee80211_vif *vif);
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
index 000000000000..0ff69164c3e7
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -0,0 +1,172 @@
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
+	bool to_testmode = false, to_normal = false;
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_phy *phy = &dev->mphy;
+	int ret = -ENOTCONN;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (req->action == TM_SWITCH_MODE) {
+		if (req->param0 != MT7921_TM_NORMAL)
+			to_testmode = true;
+		else
+			to_normal = true;
+	}
+
+	if (to_testmode) {
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
+
+	if (to_normal) {
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
+		struct mt7921_tm_evt *resp)
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
+	mutex_lock(&dev->mt76.mutex);
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_TEST_CTRL,
+					&cmd, sizeof(cmd), true, &skb);
+	mutex_unlock(&dev->mt76.mutex);
+
+	if (ret)
+		goto out;
+
+	evt = (struct mt7921_rftest_evt *)(skb->data);
+	resp->param0 = le32_to_cpu(evt->param0);
+	resp->param1 = le32_to_cpu(evt->param1);
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
+int mt7921_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len)
+{
+	struct nlattr *tb[NUM_MT7921_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt7921_phy *phy = mphy->priv;
+	struct mt7921_dev *dev = phy->dev;
+	int err;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
+	    !(hw->conf.flags & IEEE80211_CONF_MONITOR))
+		return -ENOTCONN;
+
+	err = nla_parse_deprecated(tb, MT7921_TM_ATTR_MAX, data, len,
+				   mt7921_tm_policy, NULL);
+	if (err)
+		return err;
+
+	err = -EINVAL;
+	if (tb[MT7921_TM_ATTR_SET])
+		err = mt7921_tm_set(dev, nla_data(tb[MT7921_TM_ATTR_SET]));
+
+	return err;
+}
+
+int mt7921_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len)
+{
+	struct nlattr *tb[NUM_MT7921_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt7921_phy *phy = mphy->priv;
+	struct mt7921_dev *dev = phy->dev;
+	struct mt7921_tm_evt resp;
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
+	err = nla_parse_deprecated(tb, MT7921_TM_ATTR_MAX, data, len,
+				   mt7921_tm_policy, NULL);
+	if (err)
+		return err;
+
+	err = -EINVAL;
+	if (tb[MT7921_TM_ATTR_QUERY]) {
+		err = mt7921_tm_query(dev, nla_data(tb[MT7921_TM_ATTR_QUERY]), &resp);
+		if (err)
+			goto out;
+
+		err = nla_put(msg, MT7921_TM_ATTR_RSP, sizeof(resp), &resp);
+	}
+out:
+	return err;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.h b/drivers/net/wireless/mediatek/mt76/testmode.h
index d32a7654c47e..127c13105ee9 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.h
+++ b/drivers/net/wireless/mediatek/mt76/testmode.h
@@ -140,6 +140,7 @@ enum mt76_testmode_rx_attr {
  * enum mt76_testmode_state - phy test state
  *
  * @MT76_TM_STATE_OFF: test mode disabled (normal operation)
+ * @MT76_TM_STATE_ON: test mode enabled used in offload firmware
  * @MT76_TM_STATE_IDLE: test mode enabled, but idle
  * @MT76_TM_STATE_TX_FRAMES: send a fixed number of test frames
  * @MT76_TM_STATE_RX_FRAMES: receive packets and keep statistics
@@ -147,6 +148,7 @@ enum mt76_testmode_rx_attr {
  */
 enum mt76_testmode_state {
 	MT76_TM_STATE_OFF,
+	MT76_TM_STATE_ON,
 	MT76_TM_STATE_IDLE,
 	MT76_TM_STATE_TX_FRAMES,
 	MT76_TM_STATE_RX_FRAMES,
--
2.25.1

