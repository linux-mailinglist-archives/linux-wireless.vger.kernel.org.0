Return-Path: <linux-wireless+bounces-29497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F22CA2C4B
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264FE301CEA6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0A325716;
	Thu,  4 Dec 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpMc+SGj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD82D47E0
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835907; cv=none; b=esxfgHMJObGBLFmf+i+LlJL7muLISPzhFfr9dGoOtRHqxC1R6VrGfsWx89FYL+B+YqEN6fUtBCYaLChkjfBvxLvp45wxCCGHmdK3z82Ld7zSkTknv2mszS2mDgdJ2IKXG5J55vpaSrvDGJ/H//W+l8Y1ZHlmFoJF3gCO54Cw3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835907; c=relaxed/simple;
	bh=P02Ao9um/R2CSnpT6eBTPLH8B+BW/5legTNkQbYQkRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYe6evF7RZSvvjB/ujFII6MwTjdrzHNSyVjzLIiQFyWmYF8CxQO/0BZQypvcGmLU1ZdHn+zX4KpO+xZaDi4jd8ocDFzxbsHvWb1cAipfc+eP6KQJCNO2ipkMF39y6s56oGnM05qjDmgk0ssjiw7fTQSCYx91WopUgwY161rgvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpMc+SGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6D8C113D0;
	Thu,  4 Dec 2025 08:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835907;
	bh=P02Ao9um/R2CSnpT6eBTPLH8B+BW/5legTNkQbYQkRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mpMc+SGjPOjTJ2ffUbTQP3vAudRhCfLr3oawSX8JJ0H9z9Wt9qvpnn8w33fagO1o5
	 AdeqMaWKUrIYLpIfmouD3Z7jijHPXw3IxvYHqsNviJK4BY5893jfMIIfNwK5YaafB4
	 PHL9MWG6Z4ia9ZqbWJwI8B+SIh9uTXIk42YQfJ/D+jXNkDYN6NVHg8s+LrkSbkpOd8
	 21xwLxL1NeSl7xVqvk/ImGltLvXVqYOximczFFEQAXpSlspZJcCVar1P6ODI5nh6HY
	 CxEh4PkacAs7hc8sZ30MnaqVMi/teEfFoLb/UU81Ncur8eYD/EyMSMMFS16/YJzBJA
	 qLoneGhik8yIQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:51 +0100
Subject: [PATCH mt76 09/11] wifi: mt76: mt7996: Integrate NPU in RRO
 session management
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-9-7819c52c0893@kernel.org>
References: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
In-Reply-To: <20251204-mt76-npu-eagle-offload-v1-0-7819c52c0893@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hui Ma <hui.ma@airoha.com>
X-Mailer: b4 0.14.2

Add NPU integration in RRO 3.0 session management.
This is a preliminary patch to enable NPU offload for MT7996
(7990-Eagle) chipset.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h        | 10 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 16 ++++++++++++-
 drivers/net/wireless/mediatek/mt76/npu.c         | 30 ++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d05e83ea1cacc43512f37743e1708390c3cb2f35..eefc3f555f8afea2af67517683d522b657e20b7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1649,6 +1649,9 @@ void mt76_npu_txdesc_cleanup(struct mt76_queue *q, int index);
 int mt76_npu_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct net_device *dev, enum tc_setup_type type,
 			  void *type_data);
+int mt76_npu_send_txrx_addr(struct mt76_dev *dev, int ifindex,
+			    u32 direction, u32 i_count_addr,
+			    u32 o_status_addr, u32 o_count_addr);
 #else
 static inline void mt76_npu_check_ppe(struct mt76_dev *dev,
 				      struct sk_buff *skb, u32 info)
@@ -1707,6 +1710,13 @@ static inline int mt76_npu_net_setup_tc(struct ieee80211_hw *hw,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int mt76_npu_send_txrx_addr(struct mt76_dev *dev, int ifindex,
+					  u32 direction, u32 i_count_addr,
+					  u32 o_status_addr, u32 o_count_addr)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_MT76_NPU */
 
 static inline bool mt76_npu_device_active(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 9fbe4235de0d0d42776d5661fa1c297e431b8d27..03c1ccb49ef02ebe9c2ae91db836593e680ee2c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -941,6 +941,12 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 			addr++;
 		}
 
+		if (is_mt7996(&dev->mt76) &&
+		    mt76_npu_device_active(&dev->mt76))
+			mt76_npu_send_txrx_addr(&dev->mt76, 0, i,
+					dev->wed_rro.addr_elem[i].phy_addr,
+					0, 0);
+
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
 		    mtk_wed_get_rx_capa(&dev->mt76.mmio.wed)) {
@@ -1001,6 +1007,10 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 		addr++;
 	}
 
+	if (is_mt7996(&dev->mt76) && mt76_npu_device_active(&dev->mt76))
+		mt76_npu_send_txrx_addr(&dev->mt76, 1, 0,
+					dev->wed_rro.session.phy_addr, 0, 0);
+
 	mt7996_rro_hw_init(dev);
 
 	return mt7996_dma_rro_init(dev);
@@ -1087,8 +1097,12 @@ static void mt7996_wed_rro_work(struct work_struct *work)
 				     list);
 		list_del_init(&e->list);
 
-		if (mt76_npu_device_active(&dev->mt76))
+		if (mt76_npu_device_active(&dev->mt76)) {
+			if (is_mt7996(&dev->mt76))
+				mt76_npu_send_txrx_addr(&dev->mt76, 3, e->id,
+							0, 0, 0);
 			goto reset_session;
+		}
 
 		for (i = 0; i < MT7996_RRO_WINDOW_MAX_LEN; i++) {
 			void *ptr = dev->wed_rro.session.ptr;
diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index 9679237f739842bd44497e0b1022a868cb3a0d6c..bc8f2012be9dbe2c7fc1fc885b6135d796d8c0d6 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -390,6 +390,36 @@ int mt76_npu_net_setup_tc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_npu_net_setup_tc);
 
+int mt76_npu_send_txrx_addr(struct mt76_dev *dev, int ifindex,
+			    u32 direction, u32 i_count_addr,
+			    u32 o_status_addr, u32 o_count_addr)
+{
+	struct {
+		__le32 dir;
+		__le32 in_count_addr;
+		__le32 out_status_addr;
+		__le32 out_count_addr;
+	} info = {
+		.dir = cpu_to_le32(direction),
+		.in_count_addr = cpu_to_le32(i_count_addr),
+		.out_status_addr = cpu_to_le32(o_status_addr),
+		.out_count_addr = cpu_to_le32(o_count_addr),
+	};
+	struct airoha_npu *npu;
+	int err = -ENODEV;
+
+	rcu_read_lock();
+	npu = rcu_dereference(dev->mmio.npu);
+	if (npu)
+		err = airoha_npu_wlan_send_msg(npu, ifindex,
+				WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+				&info, sizeof(info), GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mt76_npu_send_txrx_addr);
+
 void mt76_npu_disable_irqs(struct mt76_dev *dev)
 {
 	struct airoha_npu *npu;

-- 
2.52.0


