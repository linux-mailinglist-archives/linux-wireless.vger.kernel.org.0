Return-Path: <linux-wireless+bounces-36652-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNlUKywlDGpWXQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36652-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 10:54:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06157A913
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 10:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A291A3038F44
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 08:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA05394474;
	Tue, 19 May 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="pc8gq95E";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="Mz4SsVqe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from cvsmtppost103.wmail.worksmobile.com (cvsmtppost103.wmail.worksmobile.com [125.209.209.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7123EDACE
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180740; cv=none; b=fcPT58r+5VEDX8sgXGSAYjP1jnV2kC+YuENDaTMcHdD1h7TT/7y2zX2L1kiTtHUzCEtw2xswWgpUvumt+lX5B07wtZEQOivwrAOrlmOyM6lSHEPCbMH17gKTAKsUCQjHhkhEr068juhi1eIcvh88m+lNcFBYJaGu/tQP7SAfTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180740; c=relaxed/simple;
	bh=3J3/AwLUzcB/WAmYB4Pu04ubxpDRmRuvWzYDYU6hi4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4tisc19z91/F0DohrOyelL1SZYOgmF5rn23o+BEpCJCmoI5EB6m50Db163hSlHPPkTq/Oe2IjFjNkK+zIXe4oK3q1zrC/MtrQAUhan6pfPpKl12CG/7mJ7a9dzcI/+p/IjwfHsRkDK6Y11KGrkD0cbtVKJB4vtgpA/SRbwTDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=pc8gq95E; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=Mz4SsVqe; arc=none smtp.client-ip=125.209.209.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1779180736;
	bh=3J3/AwLUzcB/WAmYB4Pu04ubxpDRmRuvWzYDYU6hi4w=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=pc8gq95Ei6M/SfaFHM0c1Sclu2nIjeDVDHTG1k/Y6wCzUnFuieCBn2GaqDMuwtDi9
	 rIDv6tjD+EM9hrHWEYx5LkkfCint3eZ7JdUnE9T4wHJzbRrL6X63+pwUG7FFuYPG5x
	 OKLpZbxB78aBk2TDrRcCyBgNUz+3Bq9Etuxsp1Ds9GwFhNFwiU//B9gaWuvoE13cHv
	 Fouv5pzgGxI3MGptXKxPKs8mouIDfIFnmCZgNWJG8glIa1jZea27S2NGHSkD3eQIVt
	 2Mva6yOkDFRzucZFfuUMEl0YlAfQKnm+EkhNpjywo9MFg0sxoF6GIuseYIbIQgP/O4
	 OQ4cxpz6s7o7w==
Received: from cvsendbo001.wmail ([10.113.20.163])
  by cvsmtppost103.wmail.worksmobile.com with ESMTP id IKYuubO2S4eZgNWmnF+P5A
  for <linux-wireless@vger.kernel.org>;
  Tue, 19 May 2026 08:52:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1779180736;
	bh=3J3/AwLUzcB/WAmYB4Pu04ubxpDRmRuvWzYDYU6hi4w=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Mz4SsVqeAC2FlRYWh8KoKesSAjcMuqNldi9mznSvNtKJH6SI68VHfYJoBNnUv8JdT
	 85LHNq4EZ1Y1uDeWqo1neSy1rYMlhJNOl0gvJLAETCiQkOcN+XAAC33cEGUOskZ5gk
	 rz90XUGaJws/7qYtS2+9qNdp5Ox6hW3iMI++ilhM=
X-Session-ID: B92UEe-9TvuyppjR03krVw
X-Works-Send-Opt: 3lYwjAIYjHmXFoEXKBmwaAErKqpYjHmm
X-Works-Smtp-Source: edKdKxvXFqJZ+HmrKqK/+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp403.gwmail.worksmobile.com with ESMTP id B92UEe-9TvuyppjR03krVw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Tue, 19 May 2026 08:52:16 -0000
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
Subject: [PATCH] wifi: mt76: Drop unneeded mt76_register_debugfs_fops() return checks
Date: Tue, 19 May 2026 17:52:14 +0900
Message-Id: <20260519085214.164846-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514193243.2518979-1-ingyujang25@korea.ac.kr>
References: <20260514193243.2518979-1-ingyujang25@korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[korea.ac.kr,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[worksmobile.com:s=s20171120,korea.ac.kr:s=naverworks];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36652-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ingyujang25@korea.ac.kr,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[worksmobile.com:+,korea.ac.kr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,worksmobile.com:dkim,korea.ac.kr:email,korea.ac.kr:mid,korea.ac.kr:dkim]
X-Rspamd-Queue-Id: 0C06157A913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mt76_register_debugfs_fops() returns the dentry from
debugfs_create_dir(), which yields an error pointer on failure
(notably ERR_PTR(-ENODEV) when CONFIG_DEBUG_FS=n), never NULL. Per
commit ff9fb72bc077 ("debugfs: return error values, not NULL"),
callers do not need to check the return value.

Drop the dead !dir checks in mt7615/mt7915/mt7921/mt7925/mt7996
_init_debugfs(). Converting them to IS_ERR() instead would have
exposed a probe abort on CONFIG_DEBUG_FS=n, since each
*_init_debugfs() caller propagates the helper's return value.

This patch supersedes an earlier proposal that converted the checks
to IS_ERR().

Link: https://lore.kernel.org/all/20260514193243.2518979-1-ingyujang25@korea.ac.kr
Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---

 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c | 2 --
 drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c | 2 --
 5 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 0f7b20152279c..6a1475e3c8999 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -550,8 +550,6 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
-	if (!dir)
-		return -ENOMEM;
 
 	if (is_mt7615(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues", dir,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 26ed3745af43e..4d0854fe785bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -1296,8 +1296,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(phy->mt76, NULL);
-	if (!dir)
-		return -ENOMEM;
+
 	debugfs_create_file("muru_debug", 0600, dir, dev, &fops_muru_debug);
 	debugfs_create_file("muru_stats", 0400, dir, phy,
 			    &mt7915_muru_stats_fops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 4333005b3ad95..a5a70d8e8544a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -266,8 +266,6 @@ int mt7921_init_debugfs(struct mt792x_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
-	if (!dir)
-		return -ENOMEM;
 
 	if (mt76_is_mmio(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
index e2498659c884e..d01ff49de47af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
@@ -291,8 +291,6 @@ int mt7925_init_debugfs(struct mt792x_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, &fops_regval);
-	if (!dir)
-		return -ENOMEM;
 
 	if (mt76_is_mmio(&dev->mt76))
 		debugfs_create_devm_seqfile(dev->mt76.dev, "xmit-queues",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
index 76d623b2cafb4..327fc2032c8da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c
@@ -856,8 +856,6 @@ int mt7996_init_debugfs(struct mt7996_dev *dev)
 	struct dentry *dir;
 
 	dir = mt76_register_debugfs_fops(&dev->mphy, NULL);
-	if (!dir)
-		return -ENOMEM;
 
 	debugfs_create_file("hw-queues", 0400, dir, dev,
 			    &mt7996_hw_queues_fops);
-- 
2.34.1


