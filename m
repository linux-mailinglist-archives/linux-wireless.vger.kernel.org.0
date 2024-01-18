Return-Path: <linux-wireless+bounces-2214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF5832077
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 21:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE519B20EB5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F612E638;
	Thu, 18 Jan 2024 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="PcmQj4Jr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44C1B96A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705609466; cv=none; b=i5w1lc6oaakAZyXjJ/kn1WHnc1QDfCdhh7PqJ3JFkSrvICrXIMXhwMaJmr4tnpctjMfceHqYV+vGv0YdJw6rvSAUSfwXMwuWX/5ipoTxuZ6u7LQMGNl+tT/i+sPDNOk8U6mjs7h765Bs+Yw2jqGUBXYyOFGOED4vdiSTp0Oa0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705609466; c=relaxed/simple;
	bh=gdx9D6e9HCsQk6lirjvtmenTzWkKtii8/V5ifZHXOK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk8B9WMN7fHEhxqN5gBJ9I/kUd8KgBpDg40pMReLIElUVlNFpPHNdjhWSS9aFMzuapEIqNsf1fv5NsPshBbAne0xZEZ1GfjSbJyyjedyj21wa8KhlmvI2gldeFLwuzq5EG6TWx6+OusqoDKKs0dkTOYoZyHnPQf9uPGnb3cPUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=PcmQj4Jr; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2zaiAQegrb7sxTbZzD9E1p1jA7PFDM4qXDv9SwRT+rU=; b=PcmQj4JrCYpk9mFLJB74h7KS8X
	VHvIpPKTAP1eaOAXxzh7ERfD5Y59P5pLwemO6/oScC3XP57zed1Px8Cd42CxlC1Nqvj/ftq6LWSDN
	FhzA0U2NVWSL0jfmqakGnB/s7xhjGLg5SYIH6HNOZ3svuqQdxbOVBMFVvwLT01OgByDM=;
Received: from p200300daa7090900680536e7cb8d8cd3.dip0.t-ipconnect.de ([2003:da:a709:900:6805:36e7:cb8d:8cd3] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rQYQz-0054tJ-7H; Thu, 18 Jan 2024 20:52:17 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 4/5] wifi: mt76: mt7915: add locking for accessing mapped registers
Date: Thu, 18 Jan 2024 20:52:15 +0100
Message-ID: <20240118195216.80974-4-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118195216.80974-1-nbd@nbd.name>
References: <20240118195216.80974-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shayne Chen <shayne.chen@mediatek.com>

Sicne the mapping is global, mapped register access needs to be protected
against concurrent access, otherwise a race condition might cause the reads
or writes to go towards the wrong register

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 45 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index aff4f21e843d..cea2a31ae138 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -490,6 +490,11 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 		return dev->reg.map[i].maps + ofs;
 	}
 
+	return 0;
+}
+
+static u32 __mt7915_reg_remap_addr(struct mt7915_dev *dev, u32 addr)
+{
 	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
 	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
 	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
@@ -514,15 +519,30 @@ void mt7915_memcpy_fromio(struct mt7915_dev *dev, void *buf, u32 offset,
 {
 	u32 addr = __mt7915_reg_addr(dev, offset);
 
-	memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+	if (addr) {
+		memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+		return;
+	}
+
+	spin_lock_bh(&dev->reg_lock);
+	memcpy_fromio(buf, dev->mt76.mmio.regs +
+			   __mt7915_reg_remap_addr(dev, offset), len);
+	spin_unlock_bh(&dev->reg_lock);
 }
 
 static u32 mt7915_rr(struct mt76_dev *mdev, u32 offset)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	u32 addr = __mt7915_reg_addr(dev, offset);
+	u32 addr = __mt7915_reg_addr(dev, offset), val;
 
-	return dev->bus_ops->rr(mdev, addr);
+	if (addr)
+		return dev->bus_ops->rr(mdev, addr);
+
+	spin_lock_bh(&dev->reg_lock);
+	val = dev->bus_ops->rr(mdev, __mt7915_reg_remap_addr(dev, offset));
+	spin_unlock_bh(&dev->reg_lock);
+
+	return val;
 }
 
 static void mt7915_wr(struct mt76_dev *mdev, u32 offset, u32 val)
@@ -530,7 +550,14 @@ static void mt7915_wr(struct mt76_dev *mdev, u32 offset, u32 val)
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	u32 addr = __mt7915_reg_addr(dev, offset);
 
-	dev->bus_ops->wr(mdev, addr, val);
+	if (addr) {
+		dev->bus_ops->wr(mdev, addr, val);
+		return;
+	}
+
+	spin_lock_bh(&dev->reg_lock);
+	dev->bus_ops->wr(mdev, __mt7915_reg_remap_addr(dev, offset), val);
+	spin_unlock_bh(&dev->reg_lock);
 }
 
 static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
@@ -538,7 +565,14 @@ static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	u32 addr = __mt7915_reg_addr(dev, offset);
 
-	return dev->bus_ops->rmw(mdev, addr, mask, val);
+	if (addr)
+		return dev->bus_ops->rmw(mdev, addr, mask, val);
+
+	spin_lock_bh(&dev->reg_lock);
+	val = dev->bus_ops->rmw(mdev, __mt7915_reg_remap_addr(dev, offset), mask, val);
+	spin_unlock_bh(&dev->reg_lock);
+
+	return val;
 }
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
@@ -707,6 +741,7 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
 
 	dev = container_of(mdev, struct mt7915_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
+	spin_lock_init(&dev->reg_lock);
 
 	switch (device_id) {
 	case 0x7915:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 4727d9c7b11d..6e79bc65f5a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -287,6 +287,7 @@ struct mt7915_dev {
 
 	struct list_head sta_rc_list;
 	struct list_head twt_list;
+	spinlock_t reg_lock;
 
 	u32 hw_pattern;
 
-- 
2.43.0


