Return-Path: <linux-wireless+bounces-31065-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOkuMZECcmmvZwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31065-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:57:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F965960
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 11:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4C2D86A774
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0383F23B6;
	Thu, 22 Jan 2026 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r75Aiu/o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E073EDAB3
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078416; cv=none; b=TFeP9hUSoFPulbE1uMX3UdzspkWTykEUTzpl/nxSLfjkq6DF20WjomkO6h4J6zH6Khgl3uSpagLjYkWuBU3i+DqdlSrxvol94x8eGDNwkK88P1PUWx0gaTD6NmAIbmC2OEeUtleaBBItql042hAHuVFI8rvsL3E8iuzcRVt+w+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078416; c=relaxed/simple;
	bh=xuRORZfdR4M/WSRo7T9uton7f222LTTNyUa0f+wJB9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqN2v1ZHuNis8lVZrhEedWja38iqzhtJbdaVNQPg6kAaE9N122ErtNpDoAzH6WWlAY3AhQ4K8a9XTe3AQE6zVDS+xx7MpbKs+qMG5ntMy0F/ciYJ0RI60LHnbw0pm8wEJTzyyDajQHv5+cFI1BmOfdAbAIWuvNWLl1CBxUyJVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r75Aiu/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEED7C19425;
	Thu, 22 Jan 2026 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078416;
	bh=xuRORZfdR4M/WSRo7T9uton7f222LTTNyUa0f+wJB9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r75Aiu/oTgroTQdJ5/sxArYiRrJnTihEnqAemmnTGkD1OTn0yS6eAq+cjtHaPmw0w
	 84mwjVHKQAHjYuJXtLNhbCpx4oJKUg0mduadNlizKNR4Nb5ryLlCVMzve248wpp6yM
	 1fUrJqbbQDnYy9JIQKjltvCXqQV1NfsVDxVdRtHpI3z9ttyKscGJiNcauQaigbrxGk
	 N8tkiGxR6ZRvu+3/gPjJt+iAVyNzR3lQ4zRUaThwb+EQEUn6NwcOEdR6v1ofnC77Md
	 kmzumdTkXnxv9r5iLRnie/DoRKJBHhnwuut8SGFeVmvB5ueXep/r99b9bUFIp6sPyJ
	 OBWzkQejoxVlg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 22 Jan 2026 11:39:48 +0100
Subject: [PATCH mt76 v2 04/17] wifi: mt76: mt7996: Fix BAND2 tx queues
 initialization when NPU is enabled
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mt76-npu-eagle-offload-v2-4-2374614c0de6@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-31065-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 383F965960
X-Rspamd-Action: no action

Fix BAND2 tx queues initialization for MT7990 chipset when NPU is
enabled. This is a preliminary patch to enable NPU offload for MT7996
(Eagle) chipset.

Tested-by: Kang Yang <kang.yang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   | 18 ++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  1 +
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 00a8286bd136862d756706d6ad8098a2ddc3ca4e..9fbe4235de0d0d42776d5661fa1c297e431b8d27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -668,8 +668,9 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 		return 0;
 
 	if (dev->hif2 &&
-	    ((is_mt7996(&dev->mt76) && band == MT_BAND2) ||
-	     (is_mt7992(&dev->mt76) && band == MT_BAND1))) {
+	    ((is_mt7992(&dev->mt76) && band == MT_BAND1) ||
+	     (is_mt7996(&dev->mt76) && band == MT_BAND2 &&
+	      !mt76_npu_device_active(&dev->mt76)))) {
 		hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
 		wed = &dev->mt76.mmio.wed_hif2;
 	}
@@ -709,14 +710,19 @@ static int mt7996_register_phy(struct mt7996_dev *dev, enum mt76_band_id band)
 	/* init wiphy according to mphy and phy */
 	mt7996_init_wiphy_band(mphy->hw, phy);
 
-	if (is_mt7996(&dev->mt76) && !dev->hif2 && band == MT_BAND1) {
+	if (is_mt7996(&dev->mt76) &&
+	    ((band == MT_BAND1 && !dev->hif2) ||
+	     (band == MT_BAND2 && mt76_npu_device_active(&dev->mt76)))) {
 		int i;
 
 		for (i = 0; i <= MT_TXQ_PSD; i++)
-			mphy->q_tx[i] = dev->mt76.phys[MT_BAND0]->q_tx[0];
+			mphy->q_tx[i] = dev->mt76.phys[band - 1]->q_tx[0];
 	} else {
-		ret = mt7996_init_tx_queues(mphy->priv, MT_TXQ_ID(band),
-					    MT7996_TX_RING_SIZE,
+		int size = is_mt7996(&dev->mt76) &&
+			   mt76_npu_device_active(&dev->mt76)
+			   ? MT7996_NPU_TX_RING_SIZE / 2 : MT7996_TX_RING_SIZE;
+
+		ret = mt7996_init_tx_queues(mphy->priv, MT_TXQ_ID(band), size,
 					    MT_TXQ_RING_BASE(band) + hif1_ofs,
 					    wed);
 		if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7a884311800ea8cfc0e302b2a140a4072ce18b69..29a77d75099033727f5df5a487216c043fd04f85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -29,6 +29,7 @@
 #define MT7996_RX_RING_SIZE		1536
 #define MT7996_RX_MCU_RING_SIZE		512
 #define MT7996_RX_MCU_RING_SIZE_WA	1024
+#define MT7996_NPU_TX_RING_SIZE		1024
 /* scatter-gather of mcu event is not supported in connac3 */
 #define MT7996_RX_MCU_BUF_SIZE		(2048 + \
 					 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

-- 
2.52.0


