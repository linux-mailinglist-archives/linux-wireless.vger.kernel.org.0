Return-Path: <linux-wireless+bounces-29489-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A95CA2C21
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Dec 2025 09:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECD1C300776C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Dec 2025 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3BD2F7ADF;
	Thu,  4 Dec 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgs2pLyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1F2E7631
	for <linux-wireless@vger.kernel.org>; Thu,  4 Dec 2025 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835887; cv=none; b=M7lJAReF8AoBZePv2TtUmP0HnC9Udlram5wu62hlsJ1atwqeLuo544AlP0c4xtS4mniOru4BIZFDS+3CO5znxjEoB9EiGywEasdm+tbSikGmQeBhTkfw2b7AZFqCb6l+Ee57xckNDNuEk3JW6fg9H9X/+6eDDnSq/ymQMpXjtHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835887; c=relaxed/simple;
	bh=7v99+YloqcQ2DSrbUWR7Bl7ivv5eftsO7JmXAB1Ntj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E+Eo9aTnksflJSku59rg/K5N7zcLB+BUKO9aPSe254qaWB9xTyb/MZuMW0CmJDz+9/fc1ZCt7f+aexbBsT8LATzTeMxzRVuVmaYyCKjleGIqOAcQFOHhgubL/vrfrVpW/S5IdBnacFtdA8Qn7ncE3p25CgqhgkK9d50YfkjazGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgs2pLyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E46C4CEFB;
	Thu,  4 Dec 2025 08:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764835886;
	bh=7v99+YloqcQ2DSrbUWR7Bl7ivv5eftsO7JmXAB1Ntj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bgs2pLypU/S2VtAFMHb5Y3yebF1BoUoFaGb4PVIbMhJ0bllSw/atSVmnlRbkbGNqO
	 6TTHDzCjmGMKEijAZ1oZ28VPZyD5UGlIi109HWQsY/SR6Xw0zB3OafK12A716VREsJ
	 PfVT1T8TbBw2C0BAvW8DmppGBivS5iBMHp1jFECav2fjCIqwJFZiraVY4TU12KD5ah
	 Tk8Kn/OaJSRE4xeMD6hi3MDa65wpYEN1BKJosVdgE0sMZhMFzL9dh8X3X550dUITaC
	 IIewn1hPJCo95AEHfN+tpYVEX/Dnf5Tfj6xAg0oWZKCl2Rn7Ri1D73S8fCwYpH/3mq
	 GoMd9vQ3K1r2w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 04 Dec 2025 09:10:43 +0100
Subject: [PATCH mt76 01/11] wifi: mt76: mt7996: Fix NPU stop procedure
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-mt76-npu-eagle-offload-v1-1-7819c52c0893@kernel.org>
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

Fix NPU stop procedure used during device L1 SER recovery moving
mt7996_npu_hw_stop routine before disabling rx NAPIs.
Add missing usleep_range in mt7996_npu_hw_stop().

Tested-by: Hui Ma <hui.ma@airoha.com>
Fixes: 377aa17d2aedc ("wifi: mt76: mt7996: Add NPU offload support to MT7996 driver")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2560e2f46e89a4bc46e21d796fca80b7decefa5c..2a8e91f59b0cafd46c97a9ac73b78f1ba087b5d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2543,6 +2543,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mtk_wed_device_stop(&dev->mt76.mmio.wed);
 
+	mt7996_npu_hw_stop(dev);
 	ieee80211_stop_queues(mt76_hw(dev));
 
 	set_bit(MT76_RESET, &dev->mphy.state);
@@ -2569,8 +2570,6 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt7996_npu_hw_stop(dev);
-
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
 	if (mt7996_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
index 29bb735da4cb8f5998c9483567c65f3e3530c771..067ef647e404073173833aad3a2800d6591a5188 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -320,33 +320,38 @@ int mt7996_npu_hw_init(struct mt7996_dev *dev)
 int mt7996_npu_hw_stop(struct mt7996_dev *dev)
 {
 	struct airoha_npu *npu;
-	int i, err;
+	int i, err = 0;
 	u32 info;
 
+	mutex_lock(&dev->mt76.mutex);
+
 	npu = rcu_dereference_protected(dev->mt76.mmio.npu, &dev->mt76.mutex);
 	if (!npu)
-		return 0;
+		goto unlock;
 
 	err = mt76_npu_send_msg(npu, 4, WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
 				0, GFP_KERNEL);
 	if (err)
-		return err;
+		goto unlock;
 
 	for (i = 0; i < 10; i++) {
 		err = mt76_npu_get_msg(npu, 3, WLAN_FUNC_GET_WAIT_NPU_INFO,
 				       &info, GFP_KERNEL);
-		if (err)
-			continue;
+		if (!err && !info)
+			break;
 
-		if (info) {
-			err = -ETIMEDOUT;
-			continue;
-		}
+		err = -ETIMEDOUT;
+		usleep_range(10000, 15000);
 	}
 
 	if (!err)
 		err = mt76_npu_send_msg(npu, 6,
 					WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
 					0, GFP_KERNEL);
+	else
+		dev_err(dev->mt76.dev, "npu stop failed\n");
+unlock:
+	mutex_unlock(&dev->mt76.mutex);
+
 	return err;
 }

-- 
2.52.0


