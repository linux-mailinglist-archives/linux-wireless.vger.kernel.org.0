Return-Path: <linux-wireless+bounces-11573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79795506A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E2D1C226C4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE891C2316;
	Fri, 16 Aug 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="PQnQgXC6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F21C0DE8
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831036; cv=none; b=T83HaKW4p1mhF5POxnuxHyNTcyl9PpNvBOLYPa7JrqWua9fu6Yq+T61oDGpvmj8Qzf9vqc82xuPUJHkjvTlwH/j+qwoxqknXhCRvBKZNz2gKSpV8bNvRrQiIuqf/S82fS7GZh6YWMcUgxRGSpUpFhymzm1o3ZHk0jTnVQ2/8A/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831036; c=relaxed/simple;
	bh=AyOBEAecCBb6I5Rxe4hS5HUTsohZ5q7mkxpHnwdzjTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELiXHSy3h9YB3Kvmgft8Z2EHLRajA4AvB0D/Tkm13W+oGM7n51PpyXS5sVQNV44aeW/HcJJIK/YrB9x6kCc7FzhSwfG0HhZBXt8Vanz4ukF4kVbOorX4/vnCaa0aoPEu2M493nHmg5spDi3hRgZxAZX7okhnbWjv9P4yjFxmrjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=PQnQgXC6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GIJuSqEO+lXks9fRYnEnlEiYdYqWUM0bFSdVi6KutEk=; b=PQnQgXC6WxQmJKH23LsTxDKAsk
	as4nts5b3WOxKbDHq1fTATN4IPnu3zhuz6LBSZHxC4mxWTxj9TPgoPKS7/h6OVuZpx6buQVYm5Fq0
	FKRFmnqGuO5Yl2K07wiOHhsp6Rq5+so3i5qm46ZROiipsFrcHYTEKRntWyi92uV0lurM=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rT-000ObE-1Y
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:39 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 15/16] wifi: mt76: mt7915: reset the device after MCU timeout
Date: Fri, 16 Aug 2024 19:35:28 +0200
Message-ID: <20240816173529.17873-15-nbd@nbd.name>
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

On MT7915, MCU hangs do not trigger watchdog interrupts, so they can only
be detected through MCU message timeouts. Ensure that the hardware gets
restarted when that happens in order to prevent a permanent stuck state.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 068523561f5e..7c98d9ba9152 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -157,12 +157,19 @@ static int
 mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			  struct sk_buff *skb, int seq)
 {
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	struct mt76_connac2_mcu_rxd *rxd;
 	int ret = 0;
 
 	if (!skb) {
 		dev_err(mdev->dev, "Message %08x (seq %d) timeout\n",
 			cmd, seq);
+		dev->recovery.restart = true;
+		set_bit(MT76_MCU_RESET, &dev->mphy.state);
+		wake_up(&dev->mt76.mcu.wait);
+		queue_work(dev->mt76.wq, &dev->reset_work);
+		wake_up(&dev->reset_wait);
+
 		return -ETIMEDOUT;
 	}
 
-- 
2.44.0


