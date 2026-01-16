Return-Path: <linux-wireless+bounces-30910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD23D330B4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D29B3118B04
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64A22798EA;
	Fri, 16 Jan 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="J0k1J7rV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A72274FC1;
	Fri, 16 Jan 2026 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574971; cv=none; b=qo5ofkTmOQSiM2bvjrehOxYYGLR9K2s8dF6qYvZnTV64qQHJZJYhxliFZKLuDKhkOnUx1jUWQeJq6N3XnL02QXsoGdhyKq8/zGJY3NC7+RPAi99lcj4R1HIEeygZ7CgFfytELcoq59DNR3QV0vs1eQPE4MYz4TtMd5XTbhIQvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574971; c=relaxed/simple;
	bh=+OfTrpNJgL1LThO9LijBSI7mmRpPZgrljzsp3svnemA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JR37sDKi4ifuZjqv/Y6XD2C+XlGxPoekyiGs4Wpq9KlKe+0sDNlzE/byf6zdm+cvB2zGwRyXriVI8Hp5riWXaw4Xj3H2+aeF7+FpCsSVP6obFxw4rEPLOMB1NO8t9DYva+fVWWfKmJ8Uy3mXFvFD4YV+5fDD5UOKh2CyqY7KsLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=J0k1J7rV; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.215.202.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30efad814;
	Fri, 16 Jan 2026 22:49:23 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: nbd@nbd.name
Cc: lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] wifi: mt76: Fix memory leak after mt76_connac_mcu_alloc_sta_req()
Date: Fri, 16 Jan 2026 14:49:19 +0000
Message-Id: <20260116144919.1482558-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc7484e7103a1kunm413733d011af07
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHUwaVhhOGUhPT0IaTUsZSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJSk5VSUtJVUlLSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=J0k1J7rVit3PgK1qJkp3af2rkPN7XylXEfAzG3YYI5+rFwCZnnJZgw8Ev6mVNw+FXbCeXGAcLkUlEwycVhKpJwuqtP/4yEitFk7cAlBTitNMm69VzzyXZ3x10R/eJmijfJDcciYuK+0tECK62jkV1fLSC87ZHN3E+YaxfaTQxws=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=j9K7rmAdqbPTPIWValz7hEgAqYgNsN11V7ednlfrUjo=;
	h=date:mime-version:subject:message-id:from;

mt76_connac_mcu_alloc_sta_req() allocates an skb which is expected to
be freed eventually by mt76_mcu_skb_send_msg(). However, currently if
an intermediate function fails before sending, the allocated skb is
leaked.

Specifically, mt76_connac_mcu_sta_wed_update() and
mt76_connac_mcu_sta_key_tlv() may fail, leading to an immediate memory
leak in the error path.

Fix this by explicitly freeing the skb in these error paths.
Commit 7c0f63fe37a5 ("wifi: mt76: mt7996: fix memory leak on
mt7996_mcu_sta_key_tlv error") made a similar change.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: d1369e515efe ("wifi: mt76: connac: introduce mt76_connac_mcu_sta_wed_update utility routine")
Fixes: 6683d988089c ("mt76: connac: move mt76_connac_mcu_add_key in connac module")
Fixes: 4f831d18d12d ("wifi: mt76: mt7915: enable WED RX support")
Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c | 16 ++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  4 +++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 0457712286d5..3f583e2a1dc1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1295,8 +1295,10 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 				    wtbl_hdr);
 
 	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	ret = mt76_mcu_skb_send_msg(dev, skb, cmd, true);
 	if (ret)
@@ -1309,8 +1311,10 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
 
 	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
 }
@@ -2764,12 +2768,16 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	ret = mt76_connac_mcu_sta_key_tlv(sta_key_conf, skb, key, cmd);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	ret = mt76_connac_mcu_sta_wed_update(dev, skb);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 00bff4d3aab8..04ec821225eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1765,8 +1765,10 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	}
 out:
 	ret = mt76_connac_mcu_sta_wed_update(&dev->mt76, skb);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..3bddd357cd0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1288,8 +1288,10 @@ int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	ret = mt7925_mcu_sta_key_tlv(wcid, sta_key_conf, skb, key, cmd, msta);
-	if (ret)
+	if (ret) {
+		dev_kfree_skb(skb);
 		return ret;
+	}
 
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
-- 
2.34.1


