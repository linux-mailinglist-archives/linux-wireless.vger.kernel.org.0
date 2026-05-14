Return-Path: <linux-wireless+bounces-36419-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFsrB98jBmpjfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36419-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:34:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE0546694
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7CE302DB47
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAF122083;
	Thu, 14 May 2026 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="Fdey8ZGO";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="Wq/VWUnq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cvsmtppost102.wmail.worksmobile.com (cvsmtppost102.wmail.worksmobile.com [125.209.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C4330315
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787169; cv=none; b=NCIOZKzV34lyUZJpZ1Bq/FTLJul9cegwF2PVrZIvLn2kMFr3uy2aA2Vo4SDrExsiEFim7dgauOnvufTdXm7VMCkf42VSjHWhzWBqs/oSPrJVOuMiT8Ml0ezqUkFDD25Mcp6mtthsPc1WQW4xOp+I6ItH6nH4mywm3XFRRr7COcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787169; c=relaxed/simple;
	bh=1acIE6332zSbWTuobynlJDelq6HeX8f/lMzTcfmrhZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbtUFs/0w/cdXwA8xa3B+vXVyGRjQBw0MVfEH2Abgl1sFnoq9w1yE6t1ic5Pgab7s6s+UTgBU1LFFqmXqlG3YNn8aC1BoPhygtitwbCAXukpUbBjeoHTpLB3gBsmgeq/DaINUWit85UnhYJl49JfgaToQBATuw4nf42tI1MJ+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=Fdey8ZGO; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=Wq/VWUnq; arc=none smtp.client-ip=125.209.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1778787166;
	bh=1acIE6332zSbWTuobynlJDelq6HeX8f/lMzTcfmrhZI=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Fdey8ZGOSfk104QZnJNMU4NpPN/Fryl3JSkyJe/0ULIMe2o6sGBcy59hp1av1j1DE
	 7ipFZFo00mOoRXvHjy+NsoHJSC2nEaRP4QQZpViNzU2xK7wPORgpkV0oVOogxH6mfF
	 SrZ1J/McYN+GZUMAr1fSIi+VlRuKjfSz2265A1+rgXkEROqzswLbVzsYclfg42vxSD
	 TvaqlGmemJdtJilvWXbCjmw5TmgnhlJz3EGp+K1+vDb90GvHA9G39v/jzyEn7xiDUI
	 FmGwkFKdYMQxGhEjlLXYtYIetv1Hv37LKkoCvuOV0YSlyIiZIDtieerWTlRoARiAsP
	 Z+BRbN3YyqyfA==
Received: from cvsendbo005.wmail ([10.112.11.110])
  by cvsmtppost102.wmail.worksmobile.com with ESMTP id nr6x6qYwRyiDI5gDa3MWIg
  for <linux-wireless@vger.kernel.org>;
  Thu, 14 May 2026 19:32:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1778787166;
	bh=1acIE6332zSbWTuobynlJDelq6HeX8f/lMzTcfmrhZI=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Wq/VWUnqLFTs80y9ME8gB8wdrpn1uyxsi9oYXmwk2JBqiU+0Vvy5CoNUI8FPREA1o
	 i8QkTwOCPoWwsXoIgNnJkVprRrx+2l/msWVIr0rjqXNobmM/p9a81NaheR6CuYl3ET
	 wcZ6Jvni5g/szquJFjFwLE9pG6ws/AzkNU4FLHVs=
X-Session-ID: nGRzE80uSn2UmjmtNUGmRg
X-Works-Send-Opt: 3lYwjAIYjHmXFoEXKBmwaAErKqpYjHmm
X-Works-Smtp-Source: Adn9Fq2XFqJZ+Hm9Fobd+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp401.gwmail.worksmobile.com with ESMTP id nGRzE80uSn2UmjmtNUGmRg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 14 May 2026 19:32:45 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mt76: Use IS_ERR() check for mt76_register_debugfs_fops()
Date: Fri, 15 May 2026 04:32:43 +0900
Message-Id: <20260514193243.2518979-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EDE0546694
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[korea.ac.kr,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[worksmobile.com:s=s20171120,korea.ac.kr:s=naverworks];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36419-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[worksmobile.com:+,korea.ac.kr:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ingyujang25@korea.ac.kr,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[worksmobile.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,korea.ac.kr:email,korea.ac.kr:mid,korea.ac.kr:dkim]
X-Rspamd-Action: no action

mt76_register_debugfs_fops() returns the dentry from
debugfs_create_dir(), which yields an error pointer on failure and
never NULL. The NULL checks in the per-chip *_init_debugfs() helpers
are therefore unreachable, and on a real failure the ERR_PTR would
be returned to callers as a valid pointer.

Use IS_ERR() and propagate the actual error via PTR_ERR() in
mt7615/mt7915/mt7921/mt7925/mt7996.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 0f7b20152279c..5c3646a67e4b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -550,8 +550,8 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
-	if (!dir)
-		return -ENOMEM;
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
 
 	if (is_mt7615(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues", dir,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 26ed3745af43e..f62a17c8958ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1296,8 +1296,8 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
-	if (!dir)
-		return -ENOMEM;
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
 	debugfs_create_file("muru_debug", 0600, dir, dev, &fops_muru_debug);
 	debugfs_create_file("muru_stats", 0400, dir, phy,
 			    &mt7915_muru_stats_fops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 4333005b3ad95..4da339867b6a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -266,8 +266,8 @@ int mt7921_init_debugfs(struct mt792x_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
-	if (!dir)
-		return -ENOMEM;
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
 
 	if (mt76_is_mmio(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
index e2498659c884e..01aa4a1071fdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
@@ -291,8 +291,8 @@ int mt7925_init_debugfs(struct mt792x_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
-	if (!dir)
-		return -ENOMEM;
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
 
 	if (mt76_is_mmio(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 34af800964d11..63cd490977106 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -875,8 +875,8 @@ int mt7996_init_debugfs(struct mt7996_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, NULL);
-	if (!dir)
-		return -ENOMEM;
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
 
 	debugfs_create_file("hw-queues", 0400, dir, dev,
 			    &mt7996_hw_queues_fops);
-- 
2.34.1


