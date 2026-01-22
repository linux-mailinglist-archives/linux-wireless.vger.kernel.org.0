Return-Path: <linux-wireless+bounces-31062-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PjnHm4BcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31062-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:52:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 062DE6589A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E08137613E6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EA73A9D80;
	Thu, 22 Jan 2026 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbxBPy+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8243E9F83
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078411; cv=none; b=K5BL1gaKLTdRKYLzgAvZ4B11X/rX3gyT7WDBhtkL5x8X4+612hJsTBYr9Jp1M1PEe3zw8uG4Zdhox2VYAvYehJlO7+U0Yo8hWaxnqeHyFgnYP2DKOCv96yTbB5FG5UNxSUhyRXvxapiW768tkOaI9GRV2LDdpx6GOx5w8aCkMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078411; c=relaxed/simple;
	bh=KU+ZJPPqLdFxTIM95Q/9Ua16kgbz6avWzKANiuJatAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A54xLucRrwtgp8G1qDrj2H7XlNejZZxoqJLu1xIdi6/6Bn4hlVr+CAKbQkXOtX5qFcXQ7msx7aV6eHBSaQREDtWpDe8mJdWakVvttFylsVbBG4574J+vPfYOBiW1EuaLdLKkGNSP2A3Cu2BjW4YkYu12GTU6aJu0B2aTNWmrvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbxBPy+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DA0C116C6;
	Thu, 22 Jan 2026 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078408;
	bh=KU+ZJPPqLdFxTIM95Q/9Ua16kgbz6avWzKANiuJatAI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gbxBPy+7yiFsK69XpDfOh35vTKAC0wfohEib4CcWHaIFBZrnOh3bzc+4xJVEbXroP
	 I2FI1y3x/SXqkMw/oD9KM9GIz20OZCXYHumsr/kk3gS/PtcXVedycRVf2yMZqdU+OD
	 btfGebhcWuQlkhDb0zUdBQtIaOtIHBTr3AwRYOm3axdzn218Hqk01etJ768CJD14Vq
	 ihOusZjjekyxRBWv1hwuNJ5YCZ8TO6x6wfLNRcN/obVZI8kw0rfZjiyuJ/66lYUuOF
	 ++4PkCO5qbCb80lJkh/pixHmL5iK73VvyZ/v6cxjseAFiMtgXLvponmTL3JwoQb5qB
	 ZeQ3MkiZvvZwA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:45 +0100
Subject: [PATCH mt76 v2 01/17] wifi: mt76: mt7996: Fix NPU stop procedure
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-1-2374614c0de6@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31062-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 062DE6589A
X-Rspamd-Action: no action

Move mt7996_npu_hw_stop routine before disabling rx NAPIs in order to
fix NPU stop procedure used during device L1 SER recovery.
Add missing usleep_range in mt7996_npu_hw_stop().

Fixes: 377aa17d2aedc ("wifi: mt76: mt7996: Add NPU offload support to MT7996 driver")
Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7996/npu.c | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index aab79c042b52fbc67e14352665e0905397e4a301..db2eda2f1c4c097aafc55245e523e39c7bc71e34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2542,6 +2542,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed))
 		mtk_wed_device_stop(&dev->mt76.mmio.wed);
 
+	mt7996_npu_hw_stop(dev);
 	ieee80211_stop_queues(mt76_hw(dev));
 
 	set_bit(MT76_RESET, &dev->mphy.state);
@@ -2568,8 +2569,6 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
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


