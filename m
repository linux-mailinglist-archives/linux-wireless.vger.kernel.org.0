Return-Path: <linux-wireless+bounces-26687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A198FB37EC6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C849F7AAFC1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA73451C4;
	Wed, 27 Aug 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="id0ZbjM7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8799D276028
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286758; cv=none; b=Xosjvo449il5+6FP7ZgIiQb51kk/yWegE3veYnjJNZDCImSHGcyaGoiIuLswBy9Zqy72W+BdREBswYHAIMpMb2d1M/XZKGL+7EljNzkbRqtRNb+0lScHBguN2Bd4R4uMB3jaRXrnVsC+/WdUEtaJaPxKMP8IS4yHayP/yHfKusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286758; c=relaxed/simple;
	bh=q3OBwvZXZ0sGR8rmFTPxWtxpY4nEvxrgnadeJq34qTQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gfjR/57YItR4mRCN8f2XfiaHE5jmGoi7h+NuPn4ua+lLeZ03SebIWTwgXjcKn5iQOMKV02xcSMcoJ3lBmAMoAMeIsEuGOpPnYPpuSnNZ39NUChNOVVzMm3zpCYahjYwAX9ro/A7+ITf3MVckZAHL0H1PwaRtu0j/5T85TQS2k0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=id0ZbjM7; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nwl2vQwL6iRyAGTB5+wXVsYHvzHZt3IblRSMMj2aCG4=; b=id0ZbjM7h2cU3cksCmTLQG/7eA
	zxE7U49VmXCKQsGMiZ6GlDJ8UXWxr6qngqLab1X5DWhMrHN5/JS6S5jWT/+hjC0nhzTCU3F2cUef/
	1Zb2vHWvSnzYskt/4vPkdENucbEpaa9vQoLv5kBPFJ9ns/kFzESNhZ792+26qshIf7zg=;
Received: from tmo-087-176.customers.d1-online.com ([80.187.87.176] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urBuk-00Fn6z-2H
	for linux-wireless@vger.kernel.org;
	Wed, 27 Aug 2025 10:53:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 1/6] wifi: mt76: mt7996: fix crash on some tx status reports
Date: Wed, 27 Aug 2025 10:53:47 +0200
Message-ID: <20250827085352.51636-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a wcid can't be found, link_sta can be stale from a previous batch.
The code currently assumes that if link_sta is set, wcid is also non-zero.
Fix wcid NULL pointer dereference by resetting link_sta when a wcid entry
can't be found.

Fixes: 62da647a2b20 ("wifi: mt76: mt7996: Add MLO support to mt7996_tx_check_aggr()")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index d6531b74be1f..837deb41ae13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1247,8 +1247,10 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 			idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
 			wcid = mt76_wcid_ptr(dev, idx);
 			sta = wcid_to_sta(wcid);
-			if (!sta)
+			if (!sta) {
+				link_sta = NULL;
 				goto next;
+			}
 
 			link_sta = rcu_dereference(sta->link[wcid->link_id]);
 			if (!link_sta)
-- 
2.51.0


