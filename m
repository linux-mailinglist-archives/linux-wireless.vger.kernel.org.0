Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7003F5013
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhHWSEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 14:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231686AbhHWSEC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 14:04:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1A6361262;
        Mon, 23 Aug 2021 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629741799;
        bh=xB9O+7/Kz33ftJ2L7VPw5geOzKMbgUhDo+AX/xW9N1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7yfT1yPVylJQBqs3HguLFraaEoW/dEfgjmrLbRpGLhIFwlSsBRfQtLMGmqkLtpQ6
         6LtWaHPVbptJ0FGRXKTvH6Ixy6womH0XEl+HQuPiIoJDYFOxTWYvx4eovfktWX5FYA
         EbJsl/ttS6SZQGdkPfcZM92vKeJ7RDE9mB5/yaPAXErxtAya1dk/oXskAF78dPqRtr
         GiYJI/XJlqS/PnNMu0pQGf0N4lRSC5wuJ7c8wtU/ub7slYHN/nsNO2de3wScQ6bVFz
         VjfWgrv/0cFfz3euHRDAjtCHfXtDsWZTCZnItubPZ8+AC/u229Psf6q+UpPywOeym0
         Fn+Y9AlYj8P/g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, chui-hao.chiu@mediatek.com
Subject: [PATCH v4 mac80211-next 5/7] mt76: mt7915: introduce mt7915_mac_add_twt_setup routine
Date:   Mon, 23 Aug 2021 20:02:42 +0200
Message-Id: <08660783c221d9ccd716d0ea8905504eb4bd537a.1629741512.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629741512.git.lorenzo@kernel.org>
References: <cover.1629741512.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce individual TWT support to mt7915 in AP mode.
Implement the two following mac80211 callbacks:
- add_twt_setup
- twt_teardown_request

Tested-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 180 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  19 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  17 ++
 4 files changed, 217 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ba41ed38a4c5..ca9d0380d42b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -823,6 +823,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7915_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
+	INIT_LIST_HEAD(&dev->twt_list);
 	spin_lock_init(&dev->sta_poll_lock);
 
 	init_waitqueue_head(&dev->reset_wait);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 667ccb2dab78..be45b0e34048 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -6,6 +6,7 @@
 #include "mt7915.h"
 #include "../dma.h"
 #include "mac.h"
+#include "mcu.h"
 
 #define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
 
@@ -2104,3 +2105,182 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
 	mt7915_dfs_stop_radar_detector(phy);
 	return 0;
 }
+
+static int
+mt7915_mac_twt_duration_align(int duration)
+{
+	return duration << 8;
+}
+
+static u64
+mt7915_mac_twt_sched_list_add(struct mt7915_dev *dev,
+			      struct mt7915_twt_flow *flow)
+{
+	struct mt7915_twt_flow *iter, *iter_next;
+	u32 duration = flow->duration << 8;
+	u64 start_tsf;
+
+	iter = list_first_entry_or_null(&dev->twt_list,
+					struct mt7915_twt_flow, list);
+	if (!iter || !iter->sched || iter->start_tsf > duration) {
+		/* add flow as first entry in the list */
+		list_add(&flow->list, &dev->twt_list);
+		return 0;
+	}
+
+	list_for_each_entry_safe(iter, iter_next, &dev->twt_list, list) {
+		start_tsf = iter->start_tsf +
+			    mt7915_mac_twt_duration_align(iter->duration);
+		if (list_is_last(&iter->list, &dev->twt_list))
+			break;
+
+		if (!iter_next->sched ||
+		    iter_next->start_tsf > start_tsf + duration) {
+			list_add(&flow->list, &iter->list);
+			goto out;
+		}
+	}
+
+	/* add flow as last entry in the list */
+	list_add_tail(&flow->list, &dev->twt_list);
+out:
+	return start_tsf;
+}
+
+static int mt7915_mac_check_twt_req(struct ieee80211_twt_setup *twt)
+{
+	struct ieee80211_twt_params *twt_agrt;
+	u64 interval, duration;
+	u16 mantissa;
+	u8 exp;
+
+	/* only individual agreement supported */
+	if (twt->control & IEEE80211_TWT_CONTROL_NEG_TYPE_BROADCAST)
+		return -EOPNOTSUPP;
+
+	/* only 256us unit supported */
+	if (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT)
+		return -EOPNOTSUPP;
+
+	twt_agrt = (struct ieee80211_twt_params *)twt->params;
+
+	/* explicit agreement not supported */
+	if (!(twt_agrt->req_type & cpu_to_le16(IEEE80211_TWT_REQTYPE_IMPLICIT)))
+		return -EOPNOTSUPP;
+
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP,
+			le16_to_cpu(twt_agrt->req_type));
+	mantissa = le16_to_cpu(twt_agrt->mantissa);
+	duration = twt_agrt->min_twt_dur << 8;
+
+	interval = (u64)mantissa << exp;
+	if (interval < duration)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_setup *twt)
+{
+	enum ieee80211_twt_setup_cmd setup_cmd = TWT_SETUP_CMD_REJECT;
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	enum ieee80211_twt_setup_cmd sta_setup_cmd;
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct ieee80211_twt_params *twt_agrt;
+	struct mt7915_twt_flow *flow;
+	u16 req_type;
+	int flowid;
+	u8 exp;
+
+	twt_agrt = (struct ieee80211_twt_params *)twt->params;
+	if (mt7915_mac_check_twt_req(twt))
+		goto out;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (dev->n_twt_agrt == MT7915_MAX_TWT_AGRT)
+		goto unlock;
+
+	if (hweight8(msta->twt.flowid_mask) == ARRAY_SIZE(msta->twt.flow))
+		goto unlock;
+
+	flowid = ffs(~msta->twt.flowid_mask) - 1;
+
+	req_type = le16_to_cpu(twt_agrt->req_type);
+	req_type &= ~IEEE80211_TWT_REQTYPE_FLOWID;
+	req_type |= FIELD_PREP(IEEE80211_TWT_REQTYPE_FLOWID, flowid);
+
+	exp = FIELD_GET(IEEE80211_TWT_REQTYPE_WAKE_INT_EXP, req_type);
+	sta_setup_cmd = FIELD_GET(IEEE80211_TWT_REQTYPE_SETUP_CMD, req_type);
+
+	flow = &msta->twt.flow[flowid];
+	memset(flow, 0, sizeof(*flow));
+	INIT_LIST_HEAD(&flow->list);
+	flow->wcid = msta->wcid.idx;
+	flow->id = flowid;
+	flow->duration = twt_agrt->min_twt_dur;
+	flow->mantissa = twt_agrt->mantissa;
+	flow->exp = exp;
+	flow->protection = !!(req_type & IEEE80211_TWT_REQTYPE_PROTECTION);
+	flow->flowtype = !!(req_type & IEEE80211_TWT_REQTYPE_FLOWTYPE);
+	flow->trigger = !!(req_type & IEEE80211_TWT_REQTYPE_TRIGGER);
+
+	if (sta_setup_cmd == TWT_SETUP_CMD_REQUEST ||
+	    sta_setup_cmd == TWT_SETUP_CMD_SUGGEST) {
+		u64 interval = (u64)le16_to_cpu(twt_agrt->mantissa) << exp;
+		u64 flow_tsf, curr_tsf;
+
+		flow->sched = true;
+		flow->start_tsf = mt7915_mac_twt_sched_list_add(dev, flow);
+		curr_tsf = __mt7915_get_tsf(hw, msta->vif);
+		flow_tsf = curr_tsf + interval -
+			   (curr_tsf - flow->start_tsf) % interval;
+		twt_agrt->twt = cpu_to_le64(flow_tsf);
+	} else {
+		list_add_tail(&flow->list, &dev->twt_list);
+	}
+	flow->tsf = le64_to_cpu(twt_agrt->twt);
+
+	if (mt7915_mcu_twt_agrt_update(dev, msta->vif, flow, MCU_TWT_AGRT_ADD))
+		goto unlock;
+
+	setup_cmd = TWT_SETUP_CMD_ACCEPT;
+	msta->twt.flowid_mask |= BIT(flowid);
+	dev->n_twt_agrt++;
+
+unlock:
+	mutex_unlock(&dev->mt76.mutex);
+out:
+	req_type &= ~IEEE80211_TWT_REQTYPE_SETUP_CMD;
+	req_type |= FIELD_PREP(IEEE80211_TWT_REQTYPE_SETUP_CMD, setup_cmd);
+	twt_agrt->req_type = cpu_to_le16(req_type);
+
+	twt->control = (twt->control & IEEE80211_TWT_CONTROL_WAKE_DUR_UNIT) |
+		       (twt->control & IEEE80211_TWT_CONTROL_RX_DISABLED);
+}
+
+void mt7915_mac_twt_teardown_flow(struct mt7915_dev *dev,
+				  struct mt7915_sta *msta,
+				  u8 flowid)
+{
+	struct mt7915_twt_flow *flow;
+
+	lockdep_assert_held(&dev->mt76.mutex);
+
+	if (flowid >= ARRAY_SIZE(msta->twt.flow))
+		return;
+
+	if (!(msta->twt.flowid_mask & BIT(flowid)))
+		return;
+
+	flow = &msta->twt.flow[flowid];
+	if (mt7915_mcu_twt_agrt_update(dev, msta->vif, flow,
+				       MCU_TWT_AGRT_DELETE))
+		return;
+
+	list_del_init(&flow->list);
+	msta->twt.flowid_mask &= ~BIT(flowid);
+	dev->n_twt_agrt--;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 795d36122398..b317b9781b5a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -640,6 +640,7 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	int i;
 
 	mt7915_mcu_add_sta_adv(dev, vif, sta, false);
 	mt7915_mcu_add_sta(dev, vif, sta, false);
@@ -647,6 +648,9 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7915_mac_wtbl_update(dev, msta->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
+	for (i = 0; i < ARRAY_SIZE(msta->twt.flow); i++)
+		mt7915_mac_twt_teardown_flow(dev, msta, i);
+
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
@@ -1038,6 +1042,19 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
 }
 
+static void
+mt7915_twt_teardown_request(struct ieee80211_hw *hw,
+			    struct ieee80211_sta *sta,
+			    u8 flowid)
+{
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7915_mac_twt_teardown_flow(dev, msta, flowid);
+	mutex_unlock(&dev->mt76.mutex);
+}
+
 const struct ieee80211_ops mt7915_ops = {
 	.tx = mt7915_tx,
 	.start = mt7915_start,
@@ -1073,6 +1090,8 @@ const struct ieee80211_ops mt7915_ops = {
 	.sta_statistics = mt7915_sta_statistics,
 	.sta_set_4addr = mt7915_sta_set_4addr,
 	.sta_set_decap_offload = mt7915_sta_set_decap_offload,
+	.add_twt_setup = mt7915_mac_add_twt_setup,
+	.twt_teardown_request = mt7915_twt_teardown_request,
 	CFG80211_TESTMODE_CMD(mt76_testmode_cmd)
 	CFG80211_TESTMODE_DUMP(mt76_testmode_dump)
 #ifdef CONFIG_MAC80211_DEBUGFS
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 8129f54c2f3f..7f9200d00b65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -41,6 +41,9 @@
 
 #define MT7915_SKU_RATE_NUM		161
 
+#define MT7915_MAX_TWT_AGRT		16
+#define MT7915_MAX_STA_TWT_AGRT		8
+
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
@@ -96,6 +99,11 @@ struct mt7915_sta {
 	unsigned long ampdu_state;
 
 	struct mt7915_sta_key_conf bip;
+
+	struct {
+		u8 flowid_mask;
+		struct mt7915_twt_flow flow[MT7915_MAX_STA_TWT_AGRT];
+	} twt;
 };
 
 struct mt7915_vif {
@@ -194,6 +202,7 @@ struct mt7915_dev {
 
 	struct list_head sta_rc_list;
 	struct list_head sta_poll_list;
+	struct list_head twt_list;
 	spinlock_t sta_poll_lock;
 
 	u32 hw_pattern;
@@ -204,6 +213,8 @@ struct mt7915_dev {
 	bool ibf;
 
 	void *cal;
+
+	u8 n_twt_agrt;
 };
 
 enum {
@@ -416,6 +427,12 @@ void mt7915_mac_work(struct work_struct *work);
 void mt7915_mac_reset_work(struct work_struct *work);
 void mt7915_mac_sta_rc_work(struct work_struct *work);
 int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq);
+void mt7915_mac_twt_teardown_flow(struct mt7915_dev *dev,
+				  struct mt7915_sta *msta,
+				  u8 flowid);
+void mt7915_mac_add_twt_setup(struct ieee80211_hw *hw,
+			      struct ieee80211_sta *sta,
+			      struct ieee80211_twt_setup *twt);
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
-- 
2.31.1

