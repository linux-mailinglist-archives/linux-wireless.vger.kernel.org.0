Return-Path: <linux-wireless+bounces-11574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D895506B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C121F254EF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC67DA90;
	Fri, 16 Aug 2024 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="nZDiekR8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89511BDAA0
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831047; cv=none; b=OSRGpOAuhmTyfL9oVw+Es2wQTbRsQaGvCGjGV/j5zv6DzvAlseAvn0g0TOKkYLj0wcAp36+XdlxxRDL4sQqnf03YjemNJ/4NqjArsoQPFVx2R+CZHTDbTwxyEzTlbWRjCaaWMBJ++Ub/lp/MHMDu4kUSBCjNAtuXsLXntihs5OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831047; c=relaxed/simple;
	bh=qeAZK7kPRFad3C12WGYG56tQsqD3LSzT93jT92tuUwU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVime7UGMvN7J0cLLsKSkKJzbkmuTFAuUEAaMFQX0BddsDJn7jBTAviUFni9Ii/sVumnV78DfkoKpnQMHvfsTu4GQOw7AvxCwTOI94HCG3icLBipgMbTplcvMiXE/7eQZxgTL194HQQVzAXpCj4RuEuURnLEHhuYJUcGGshWotI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=nZDiekR8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+KpZ5r5j7ZYQZ7/i42+Cokeg2SStyZ4nGCwGAAMoyIc=; b=nZDiekR8JuKzgaM7d4ApMH6V7c
	XgTszgP60UIcbgVeCjDi9/3P5J9TVStOchLKWoNcJps1Dk8BEeGFcgqNmEwx+iVtncVJQpE/tcy52
	iY44VUloN6flJuRGJv4CFfKQwARJ1E2lER9O5l/TjLPRAwkQhnp6mumJqAuDo9t94u/Q=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rT-000ObE-0k
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:39 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 14/16] wifi: mt76: mt7915: retry mcu messages
Date: Fri, 16 Aug 2024 19:35:27 +0200
Message-ID: <20240816173529.17873-14-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
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
index 5dca8f0cd760..a28f1ff71b4d 100644
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
index 7abf6cacdaae..068523561f5e 100644
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
@@ -2380,7 +2375,9 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
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
2.44.0


