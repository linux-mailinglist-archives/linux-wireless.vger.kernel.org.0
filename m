Return-Path: <linux-wireless+bounces-38535-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MbUvMJ0JR2olSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38535-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 03:00:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767EF6FDABA
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 03:00:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=o1bC3HFj;
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38535-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38535-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49657301CA6D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF822DFA4;
	Fri,  3 Jul 2026 01:00:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B3223708
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 01:00:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040410; cv=none; b=M0sjq2BvS1935SAJYRFfd1MVjfDXAREHlCRRjmn7EaCnr5Cd/K8gdX7mXxlFzIS0DM9TqSM0E9985FEyHnmHks5ZxpPEpKqepbYubm0SYAMb3UnbSZgXJonfa/B+6HbPaXfC4tskdFI2mMKAj+TLrtnc6k9hAb06emRu5owV2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040410; c=relaxed/simple;
	bh=7MFbkA4zkaz0nke1s9QOo514SJJDftz2G2j1aK0m16M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sAAGnlJRNFBaqB2oI7p4/rwOaRt+Ak5x8q1yzGeGWNGI/jfL0buNRpgT0vxZ4FJ3rQyPZGX0WUoW+Qf4dWGEpOR+1TeDSH5uGyqjHkatlo/kTq5L7C3lezdnol8+Lh+5/ej0qUBLpRSIt7sFK6XC90wfhZYHxEqjvNDceKHzHGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=o1bC3HFj; arc=none smtp.client-ip=60.244.123.138
X-UUID: 837043e4767a11f1b1788b6acf885367-20260703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OG+AH5OioDQ5bL6HxNycjtqG2Tg+0W/zAAEWZHSKmng=;
	b=o1bC3HFj0D09cn61QkAUg+9v4gS8yNzlvKafvMRwEkYJR8NcgjW6L9JpNC7idd4556t6EX3JGfREKBPQDHZ3zq8o3yQx6cE9r5ZHCRoa2Iozl+PGCKpzQPDW0oVYJ0RzrjIce47xGOmPIJxiEkqKztbH4XbRe2mVTkJzRdsshH4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:c1b24417-3393-47a8-b81a-b9070bcacc32,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:8b42ad14-ea64-44d4-98db-4e1fb89955a3,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 837043e4767a11f1b1788b6acf885367-20260703
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 369863272; Fri, 03 Jul 2026 08:59:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 3 Jul 2026 08:59:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 3 Jul 2026 08:59:57 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Yf.Luo@mediatek.com>, <kun.wu@mediatek.com>, <deren.wu@mediatek.com>,
	<sean.wang@mediatek.com>, <quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>,
	<leon.yen@mediatek.com>, <litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<eason.lai@mediatek.com>, Eason Lai <Eason.Lai@mediatek.com>
Subject: [PATCH v1 1/1] wifi: mt76: mt792x: Fix memory leak in SDIO TX path
Date: Fri, 3 Jul 2026 08:59:45 +0800
Message-ID: <20260703005945.2244533-1-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-38535-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,m:eason.lai@mediatek.com,m:Eason.Lai@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 767EF6FDABA

From: Eason Lai <Eason.Lai@mediatek.com>

When tx_prepare_skb() returns an error in the SDIO TX path, the
skb is not freed, leading to a memory leak. This can occur when
zero-length frames (such as WNM NULL frames) are dropped to prevent
potential hardware TX hangs.

Fix this by properly releasing the skb with ieee80211_tx_status_ext()
when tx_prepare_skb() fails.

Fixes: b747fa343817 ("mt76: mt7915: drop zero-length packet to avoid Tx hang")
Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/sdio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 8bae77c761be..ba5f123f7e39 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -519,6 +519,10 @@ mt76s_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 		   enum mt76_txq_id qid, struct sk_buff *skb,
 		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
+	struct ieee80211_tx_status status = {
+		.sta = sta,
+	};
+
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
 	};
@@ -531,8 +535,13 @@ mt76s_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 
 	skb->prev = skb->next = NULL;
 	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
-	if (err < 0)
+	if (err < 0) {
+		status.skb = tx_info.skb;
+		spin_lock_bh(&dev->rx_lock);
+		ieee80211_tx_status_ext(dev->hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 		return err;
+	}
 
 	q->entry[q->head].skb = tx_info.skb;
 	q->entry[q->head].buf_sz = len;
-- 
2.45.2


