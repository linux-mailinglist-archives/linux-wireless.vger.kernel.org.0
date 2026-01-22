Return-Path: <linux-wireless+bounces-31073-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK5GBKoAcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31073-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:49:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD5657CB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 525B55890B4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8B41B362;
	Thu, 22 Jan 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRWJy0pj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27741B354
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078436; cv=none; b=P+FZgkC2H5iITSj0dw4clHZlxgICtwqhdFqCTtwTA4kRAzRcvvSwHEeg0saj6m9jp8gIKeA5Lqc7y6xlh79P1RCHuvbVGhtShvmyqZ4oFmek3tBhlzuQ7/SMgl8GadZyfvSGiad4H9gvN8imyph3cCX9H+x+11ZyD2AiwsKqmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078436; c=relaxed/simple;
	bh=KDBMeimDOqIPWA+AlFv7vKWaNXKeitCrK7nYonb6SUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H1f2PElUGg68G0mCSOTPU3nMs8tq9/tfpvFeAGJ8B+nENZ8RgJPju+sUc4bx05x/unCdkrDOWzYUCdkBiBmGUq0+vHfOiScMf6HhTpjryyNw+Lp1X9Uyz+I6M3/KYH8DXrdzbpgK3U8BXJVC2HwW19wWMF5uQ2RCTGEuOSZ83V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRWJy0pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0796FC16AAE;
	Thu, 22 Jan 2026 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078436;
	bh=KDBMeimDOqIPWA+AlFv7vKWaNXKeitCrK7nYonb6SUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mRWJy0pjF9QJLR0IMnhus9dD9uY4hexqwBs2PQOnyVIZVxadMyI+EWYL66Wu6gt3a
	 Al3MgeusAdmfWGSozvZ4g+PUaDUAQ8GDwxhZ9/fjHrxqk9xohYdy9vngUaIn9M44fL
	 BokApxfzcYHRKTjESvtjPRQdVBG4+acIWfHDLcE4KY1DYwHuviN5IGM0m0ihKPy/xL
	 2h5ixOtbc+SdIIWCancWFfIQLh6QkicxT6vjnDTtX1xuZqnXnkVk1oHNAhr4oGqKlg
	 TFUMaWFM6vK7uL3IpBVgz1Wr/vGyPoh8Cr7UBcIMDyiU1Yo0D4hLNMF4tocFyq5hZf
	 sUHqUnybuOVBQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:56 +0100
Subject: [PATCH mt76 v2 12/17] wifi: mt76: mt7996: Add __mt7996_npu_hw_init
 routine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-12-2374614c0de6@kernel.org>
References: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
In-Reply-To: <20260122-mt76-npu-eagle-offload-v2-0-2374614c0de6@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Kang Yang <kang.yang@airoha.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31073-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 9FBD5657CB
X-Rspamd-Action: no action

Introduce __mt7996_npu_hw_init utility routine in order to run it
holding mt76 mutex and move NPU hw re-initialization before restarting
the NAPIs during device reset.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  4 +--
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  6 +++++
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c    | 31 +++++++++++++---------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index db2eda2f1c4c097aafc55245e523e39c7bc71e34..ebce6b080886896be746c37690ef38713fe2cbc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2607,6 +2607,8 @@ void mt7996_mac_reset_work(struct work_struct *work)
 				     MT_INT_TX_RX_DONE_EXT);
 	}
 
+	__mt7996_npu_hw_init(dev);
+
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	mt7996_for_each_phy(dev, phy)
 		clear_bit(MT76_RESET, &phy->mt76->state);
@@ -2636,8 +2638,6 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt7996_npu_hw_init(dev);
-
 	mt7996_for_each_phy(dev, phy)
 		ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
 					     MT7996_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index de31385aa966116b34e545de92623a214bddc8f8..3928e059fd2a41aa7d4aa41b0d303b0763384523 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -881,10 +881,16 @@ int mt7996_mtk_init_debugfs(struct mt7996_phy *phy, struct dentry *dir);
 int mt7996_dma_rro_init(struct mt7996_dev *dev);
 
 #ifdef CONFIG_MT7996_NPU
+int __mt7996_npu_hw_init(struct mt7996_dev *dev);
 int mt7996_npu_hw_init(struct mt7996_dev *dev);
 int mt7996_npu_hw_stop(struct mt7996_dev *dev);
 int mt7996_npu_rx_queues_init(struct mt7996_dev *dev);
 #else
+static inline int __mt7996_npu_hw_init(struct mt7996_dev *dev)
+{
+	return 0;
+}
+
 static inline int mt7996_npu_hw_init(struct mt7996_dev *dev)
 {
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
index 1a77a7dc103762c8cc998508348e418858c30029..7941996891c88333d121e4c739001ea19bff94c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/npu.c
@@ -525,20 +525,18 @@ int mt7996_npu_rx_queues_init(struct mt7996_dev *dev)
 				      &dev->mt76.q_rx[MT_RXQ_NPU1]);
 }
 
-int mt7996_npu_hw_init(struct mt7996_dev *dev)
+int __mt7996_npu_hw_init(struct mt7996_dev *dev)
 {
 	struct airoha_npu *npu;
-	int i, err = 0;
-
-	mutex_lock(&dev->mt76.mutex);
+	int i, err;
 
 	npu = rcu_dereference_protected(dev->mt76.mmio.npu, &dev->mt76.mutex);
 	if (!npu)
-		goto unlock;
+		return 0;
 
 	err = mt7996_npu_offload_init(dev, npu);
 	if (err)
-		goto unlock;
+		return err;
 
 	if (is_mt7996(&dev->mt76))
 		err = mt7996_npu_rxd_init(dev, npu);
@@ -546,27 +544,36 @@ int mt7996_npu_hw_init(struct mt7996_dev *dev)
 		err = mt7992_npu_rxd_init(dev, npu);
 
 	if (err)
-		goto unlock;
+		return err;
 
 	err = mt7996_npu_txd_init(dev, npu);
 	if (err)
-		goto unlock;
+		return err;
 
 	err = mt7996_npu_rx_event_init(dev, npu);
 	if (err)
-		goto unlock;
+		return err;
 
 	err = mt7996_npu_set_pcie_addr(dev, npu);
 	if (err)
-		goto unlock;
+		return err;
 
 	err = mt7996_npu_tx_done_init(dev, npu);
 	if (err)
-		goto unlock;
+		return err;
 
 	for (i = MT_RXQ_NPU0; i <= MT_RXQ_NPU1; i++)
 		airoha_npu_wlan_enable_irq(npu, i - MT_RXQ_NPU0);
-unlock:
+
+	return 0;
+}
+
+int mt7996_npu_hw_init(struct mt7996_dev *dev)
+{
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+	err = __mt7996_npu_hw_init(dev);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return err;

-- 
2.52.0


