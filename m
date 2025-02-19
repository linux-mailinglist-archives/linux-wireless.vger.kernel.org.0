Return-Path: <linux-wireless+bounces-19113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF82A3B010
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 04:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A879216BD4D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0300A19D8A9;
	Wed, 19 Feb 2025 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BzC9sW61"
X-Original-To: linux-wireless@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3A2136A;
	Wed, 19 Feb 2025 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936246; cv=none; b=YIAhWyWsphervgGTYHLBWJzqxNPRRvcHOCDwni2O/DKHD4KLJjhpMzLl7thMw3ZhQUGCRNrxJZnmKgmWBSCkCWoMHgqORPyielHBrRQGxL6scg062wvpC3gIz2dhM08ZvS00tFuWw8OSajspFGs7eKBeZqc035CUrRD7S7jYbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936246; c=relaxed/simple;
	bh=yXzzcVaNALwy7igFxnJgJRax5d7CA1EwhIEuqRCTu3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rdrc6cl9tylDFqX+x0uF4TjBkSSRuen+ZJ0ICXe9HWJsoknNPX0FE9q96zvQPkodkvFhJdfmOxNMKWZYZSIjWiNpOexkddUy929fv5ZE+Ynj+RBe4VPUVN6QtzeE2qFQAROBKOYcxV1umCoJa7fdQvZv8htff0DxkdZP/T1RZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BzC9sW61; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Kl7u8
	bFLHAjtaElzFILg5UyTJziKGgGFb4LO1YSKTug=; b=BzC9sW61lpYTYF70UeYs9
	3pgGYPYcyNd+RXZb8SFZXSlWn62tp14ZoF4276oyxRjo2W+I+4D9lztbuUmIfwPb
	RvskGq2T5hB18evYkfulaO0P0ep5Xmu23lqP8Dg8NlVatDlPCAn3CeawzhBYOwZ7
	qP1ZyhP2IssKpgsKsjmobA=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCH0CvPUbVnWpNgNA--.30420S4;
	Wed, 19 Feb 2025 11:36:49 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	johannes@sipsolutions.net,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: Add check for devm_kstrdup()
Date: Wed, 19 Feb 2025 11:36:45 +0800
Message-Id: <20250219033645.2594753-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH0CvPUbVnWpNgNA--.30420S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4DCr48uF45Cw18ZFyUGFg_yoWDGrc_uF
	s7Zrn3Xry7Gr1Ykr4jyFsIv34Yk3y8JF1kZrySqrySqrZIgrWkGr9xZrn5XrWDuwnxZr9r
	ua1DJ3WrZ39IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNtxhDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAv4bme1R0DC6QABsK

Add check for the return value of devm_kstrdup() in
mt76_get_of_data_from_mtd() to catch potential exception.

Fixes: e7a6a044f9b9 ("mt76: testmode: move mtd part to mt76_dev")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/wireless/mediatek/mt76/eeprom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 0bc66cc19acd..443517d06c9f 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -95,6 +95,10 @@ int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int offset, int l
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->test_mtd.name = devm_kstrdup(dev->dev, part, GFP_KERNEL);
+	if (!dev->test_mtd.name) {
+		ret = -ENOMEM;
+		goto out_put_node;
+	}
 	dev->test_mtd.offset = offset;
 #endif
 
-- 
2.25.1


