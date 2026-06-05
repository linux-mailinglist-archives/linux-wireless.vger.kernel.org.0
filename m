Return-Path: <linux-wireless+bounces-37402-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MhWUBDQ5ImoEUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37402-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 04:49:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365F644BEF
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 04:49:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=E77qREhm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37402-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37402-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F7263078636
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 02:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B12264CA;
	Fri,  5 Jun 2026 02:43:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54C3CDBC4
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 02:42:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780627381; cv=none; b=Zl1Ij4d5+oSQAK/P6ZICg2WOHM5rJTzDBnAV0nkRSY4sJY91wRL8mpORzwnIUXNp3NttmhDFvRWUb0TKSzofQChbbIiOWHdsQoHmeE7fpBCs8tcSEfSRyb0i8BIAhAmmVJH7FOI3YdRqdKJmXnK7CXa3whEDcipIrZDWklgk0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780627381; c=relaxed/simple;
	bh=kIbVhWK2XJsB3c/sAvojIZljZ/rK2GSGdygWFtEtW0k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=US0kv2V5kPpSp9XYh3wcmD0yWOSUkZ2oQJgeJ0Kuvry6ueCUw4+q2nSv56DyXBiw+2bKZQ7J8zh4sMBbkCHvbwgs4IbUqavFAbVfQEwDPceLSNZG++5kb6UPTAkVLqA+lqPpgQHjFH4ep+nXG7j/y9143k7ovBVWjVgKjTC6mrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E77qREhm; arc=none smtp.client-ip=210.61.82.184
X-UUID: 304b0a6c608811f18dc8c9802ae25ab1-20260605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nQRT4mJ1HgdsNx44mOqyA+8emUgDAkQ/qj+2hj+KmJw=;
	b=E77qREhmIwi4yNofggsHQ50S1W1TGgE51v2rQand0j8RgMedlli/OAUXASXZdx5TrvlzJjRyYmssSfiq0Pt5TIK5WZOBhlxLwYVfbo0fHHcLUi7WZujpThK1KtoNF4aAN9B2WDIkiETmRiXz66mWeV7zk+kJLFQfF5FxyNWfWuQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:3ae8fa19-d989-409c-bc10-1cef5f73a952,IP:0,U
	RL:0,TC:0,Content:-32768,EDM:0,RT:0,SF:-32768,FILE:0,BULK:-32768,RULE:Rele
	ase_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:848c84db-80d5-4559-8c71-d44bd75d0023,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:-5,Content:nil,EDM:-3,IP:nil,
	URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 304b0a6c608811f18dc8c9802ae25ab1-20260605
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ryder.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1272822999; Fri, 05 Jun 2026 10:42:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Jun 2026 10:42:25 +0800
Received: from mussdccf250.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 5 Jun 2026 10:42:24 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: <linux-mediatek@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
	Shayne Chen <shayne.chen@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: fix potential tx_retries underflow
Date: Thu, 4 Jun 2026 19:42:22 -0700
Message-ID: <20260605024222.3388222-1-ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37402-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:shayne.chen@mediatek.com,m:ryder.lee@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryder.lee@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2365F644BEF

When FIELD_GET returns 0 for the retry count, subtracting 1 causes
an unsigned integer underflow, resulting in tx_retries becoming a
very large value (0xFFFFFFFF for u32 or 255 for u8).

Fix by checking if count is non-zero before subtracting 1.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 10 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  6 +++---
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cec2c4208..334c19ab2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -912,16 +912,16 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 		}
 
 		if (!mtk_wed_device_active(&mdev->mmio.wed) && wcid) {
-			u32 tx_retries = 0, tx_failed = 0;
+			u32 tx_retries = 0, tx_failed = 0, count;
 
 			if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3)) {
-				tx_retries =
-					FIELD_GET(MT_TX_FREE_COUNT_V3, info) - 1;
+				count = FIELD_GET(MT_TX_FREE_COUNT_V3, info);
+				tx_retries = count ? count - 1 : 0;
 				tx_failed = tx_retries +
 					!!FIELD_GET(MT_TX_FREE_STAT_V3, info);
 			} else if (!v3 && (info & MT_TX_FREE_MPDU_HEADER)) {
-				tx_retries =
-					FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
+				count = FIELD_GET(MT_TX_FREE_COUNT, info);
+				tx_retries = count ? count - 1 : 0;
 				tx_failed = tx_retries +
 					!!FIELD_GET(MT_TX_FREE_STAT, info);
 			}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db..668bfa195 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -530,8 +530,9 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
 
 		if (wcid) {
-			wcid->stats.tx_retries +=
-				FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
+			u32 count = FIELD_GET(MT_TX_FREE_COUNT, info);
+
+			wcid->stats.tx_retries += count ? count - 1 : 0;
 			wcid->stats.tx_failed += !!stat;
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index c47bd812b..c56a9e530 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1141,8 +1141,9 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 
 		if (info & MT_TXFREE_INFO_HEADER) {
 			if (wcid) {
-				wcid->stats.tx_retries +=
-					FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
+				u32 count = FIELD_GET(MT_TXFREE_INFO_COUNT, info);
+
+				wcid->stats.tx_retries += count ? count - 1 : 0;
 				wcid->stats.tx_failed +=
 					!!FIELD_GET(MT_TXFREE_INFO_STAT, info);
 			}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index a59c14c8f..3fad977ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1361,13 +1361,13 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 				cur_info++;
 			continue;
 		} else if (info & MT_TXFREE_INFO_HEADER) {
-			u32 tx_retries = 0, tx_failed = 0;
+			u32 tx_retries = 0, tx_failed = 0, count;
 
 			if (!wcid)
 				continue;
 
-			tx_retries =
-				FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
+			count = FIELD_GET(MT_TXFREE_INFO_COUNT, info);
+			tx_retries = count ? count - 1 : 0;
 			tx_failed = tx_retries +
 				!!FIELD_GET(MT_TXFREE_INFO_STAT, info);
 
-- 
2.45.2


