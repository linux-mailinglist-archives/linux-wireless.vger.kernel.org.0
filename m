Return-Path: <linux-wireless+bounces-12051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C910960655
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55FB1F216B3
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137719B3EC;
	Tue, 27 Aug 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="RozLGpYa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1B18D65C
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752522; cv=none; b=awUGkngzpNguwvg0Z3CAschHUMVFtGsr8ItXVzysULIlFSFTs09vyYKkT8/Y3RI5bk5cs3cD2WGLfIA9jV6w6+Pmn/SWXbq9KWLxEbLU3j9Wdxwr5etcOP8j2XvRFBvSUB+dDO/HrNkLjMBk/xYDEpduYoxp2qUKykSNUnA7GZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752522; c=relaxed/simple;
	bh=oWYshB5zHwkFas9zwU17GXmheB8ZwiQlN5lq1PTrAug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnxTcGPc52llY1/wHkB5L7SzZybZaiRL/m5DXBvata2/NFrWOV2T3o5Urhx+M0Y9RCUBT377SOTs/5jG7ZuvLLL43KOa+TNV0Y0jcwbQB38dVTuUnpjHgJlXg3+LaR0Ipr4xCyDYpXaPQyFVP8DTuL6yyKoXGFjX4IgjXaGOPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=RozLGpYa; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Nz7XITKlEBvPi4mdXojyeI3vBz1xW/fH3E2lNqqsVm8=; b=RozLGpYalcP0rFMe1S5TDkumEE
	/gs0/jIACex9/AXj8nz8EZ4cu508O0xhLqFNdBj3R+ap9Nef9/YHWx8Goob4dtiuItzvtHAyWmM+E
	/mBpeqOafqPEiV/CGZPal06+MtafWkHbsHWGy0duAGWqR8RRwuyG53ywtlLGd3FaWGkc=;
Received: from p57a6f9a5.dip0.t-ipconnect.de ([87.166.249.165] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sisWm-004Ww8-1S
	for linux-wireless@vger.kernel.org;
	Tue, 27 Aug 2024 11:30:16 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 14/24] wifi: mt76: mt7915: retry mcu messages
Date: Tue, 27 Aug 2024 11:30:01 +0200
Message-ID: <20240827093011.18621-14-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827093011.18621-1-nbd@nbd.name>
References: <20240827093011.18621-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases MCU messages can get lost. Instead of failing completely,
attempt to recover by re-sending them.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mcu.c      | 20 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 +++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  7 ++-----
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index a8cafa39a56d..98da82b74094 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -73,6 +73,8 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 				  int cmd, bool wait_resp,
 				  struct sk_buff **ret_skb)
 {
+	unsigned int retry = 0;
+	struct sk_buff *orig_skb = NULL;
 	unsigned long expires;
 	int ret, seq;
 
@@ -81,6 +83,14 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 
 	mutex_lock(&dev->mcu.mutex);
 
+	if (dev->mcu_ops->mcu_skb_prepare_msg) {
+		ret = dev->mcu_ops->mcu_skb_prepare_msg(dev, skb, cmd, &seq);
+		if (ret < 0)
+			goto out;
+	}
+
+retry:
+	orig_skb = skb_get(skb);
 	ret = dev->mcu_ops->mcu_skb_send_msg(dev, skb, cmd, &seq);
 	if (ret < 0)
 		goto out;
@@ -94,6 +104,14 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 
 	do {
 		skb = mt76_mcu_get_response(dev, expires);
+		if (!skb && !test_bit(MT76_MCU_RESET, &dev->phy.state) &&
+		    retry++ < dev->mcu_ops->max_retry) {
+			dev_err(dev->dev, "Retry message %08x (seq %d)\n",
+				cmd, seq);
+			skb = orig_skb;
+			goto retry;
+		}
+
 		ret = dev->mcu_ops->mcu_parse_response(dev, cmd, skb, seq);
 		if (!ret && ret_skb)
 			*ret_skb = skb;
@@ -101,7 +119,9 @@ int mt76_mcu_skb_send_and_get_msg(struct mt76_dev *dev, struct sk_buff *skb,
 			dev_kfree_skb(skb);
 	} while (ret == -EAGAIN);
 
+
 out:
+	dev_kfree_skb(orig_skb);
 	mutex_unlock(&dev->mcu.mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 43e743b510ba..794cd33be68b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -230,11 +230,14 @@ struct mt76_queue {
 };
 
 struct mt76_mcu_ops {
+	unsigned int max_retry;
 	u32 headroom;
 	u32 tailroom;
 
 	int (*mcu_send_msg)(struct mt76_dev *dev, int cmd, const void *data,
 			    int len, bool wait_resp);
+	int (*mcu_skb_prepare_msg)(struct mt76_dev *dev, struct sk_buff *skb,
+				   int cmd, int *seq);
 	int (*mcu_skb_send_msg)(struct mt76_dev *dev, struct sk_buff *skb,
 				int cmd, int *seq);
 	int (*mcu_parse_response)(struct mt76_dev *dev, int cmd,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 2ef8d90132dd..0cde1b3c7d41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -191,11 +191,6 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	enum mt76_mcuq_id qid;
-	int ret;
-
-	ret = mt76_connac2_mcu_fill_message(mdev, skb, cmd, wait_seq);
-	if (ret)
-		return ret;
 
 	if (cmd == MCU_CMD(FW_SCATTER))
 		qid = MT_MCUQ_FWDL;
@@ -2382,7 +2377,9 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
+		.max_retry = 3,
 		.headroom = sizeof(struct mt76_connac2_mcu_txd),
+		.mcu_skb_prepare_msg = mt76_connac2_mcu_fill_message,
 		.mcu_skb_send_msg = mt7915_mcu_send_message,
 		.mcu_parse_response = mt7915_mcu_parse_response,
 	};
-- 
2.46.0


