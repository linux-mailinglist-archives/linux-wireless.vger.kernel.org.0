Return-Path: <linux-wireless+bounces-31437-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MduKTJYgGkd6gIAu9opvQ
	(envelope-from <linux-wireless+bounces-31437-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 08:54:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57AC95FA
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 08:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33BE630022D1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 07:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F4289824;
	Mon,  2 Feb 2026 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jfBoHWis"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C072BF00D
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018863; cv=none; b=ANBItHFS5rHwDGFmSRWmjp5eQC8NJrxd4Gt5vaFkQiVsz2BdlacE89AraPCLolrR1VNIhyj9LstYsPOT1aZ9i8sOjHVoHyXofwWu6raGEQenpFpM4BB1Nfzk8FmUbxHyyRu5fLQGSL0i7QILT9x4ce9rmZhoIlqoyQXdnuFFPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018863; c=relaxed/simple;
	bh=xY3gIEDtbUKVWyqHCKB8z609xPAyMeNSP70oEhxUrVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nOaNLINjJvhxoJFquL2N3VdjTPFfRr+CsihMSciayJCftqQZpRfHiQEzLZ5JMN8Hy1VCWlkr21Zm/5pZJu21UOK2XeHFHx/E6lnbQPvColnYGtjqTj7gCZKx4BAWHdFXZ/nrFvESulIl4PUWdzf4d/yi6zJGd+0QWRX6R/7tjlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jfBoHWis; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5f52a626000c11f1b7fc4fdb8733b2bc-20260202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XAiHFASdcnSj6/esay44eO8OXUn72eajlw6VRifcypY=;
	b=jfBoHWisZCHbXpClPxAt7xg2rEJBEiVT/6ch+3f0ZN+8N3f9rdewimA+EFsV20374Df+/iNcNQtU8w4xl3rxGCZcuOgXoOrKOANjZSnniZ0IWtiEKh3nwGpIhEmpCIA9zUtxoBaBws5bGCLooDnso2IN8CSOScn4GmdLc2/0KOs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:78c52cb0-5046-4ef2-b75f-1019c590ff9d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:b7d839f0-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5f52a626000c11f1b7fc4fdb8733b2bc-20260202
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1985799148; Mon, 02 Feb 2026 15:54:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Feb 2026 15:54:15 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Feb 2026 15:54:15 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Money Wang <money.wang@mediatek.com>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Shayne Chen
	<shayne.chen@mediatek.com>
Subject: [PATCH 1/5] wifi: mt76: fix potential deadlock caused by rx_lock
Date: Mon, 2 Feb 2026 15:53:06 +0800
Message-ID: <20260202075311.365673-1-shayne.chen@mediatek.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-31437-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayne.chen@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[mediatek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]
X-Rspamd-Queue-Id: BC57AC95FA
X-Rspamd-Action: no action

A deadlock will occur if both of the following conditions are met,
because they each attempt to acquire the rx_lock:
- mac80211 receives an unexpected BAR control frame, which triggers
  a BA deletion
- A transmission failure happens due to an abnormality in DMA

Since ieee80211_tx_status_ext() is primarily used to address AQL issues,
avoid potential deadlocks by restricting calls to ieee80211_tx_status_ext
only for data frames.

Fixes: 94e4f5794627 ("mt76: dma: use ieee80211_tx_status_ext to free packets when tx fails")
Reviewed-by: Money Wang <money.wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 2d133ace7c33..928709f4a206 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -648,6 +648,8 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 		.skb = skb,
 	};
 	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_hdr *hdr;
 	struct ieee80211_hw *hw;
 	int len, n = 0, ret = -ENOMEM;
 	struct mt76_txwi_cache *t;
@@ -736,9 +738,16 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 free_skb:
 	status.skb = tx_info.skb;
 	hw = mt76_tx_status_get_hw(dev, tx_info.skb);
-	spin_lock_bh(&dev->rx_lock);
-	ieee80211_tx_status_ext(hw, &status);
-	spin_unlock_bh(&dev->rx_lock);
+	hdr = (struct ieee80211_hdr *)tx_info.skb->data;
+	info = IEEE80211_SKB_CB(tx_info.skb);
+	if ((info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
+	    ieee80211_is_data(hdr->frame_control)) {
+		spin_lock_bh(&dev->rx_lock);
+		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
+	} else {
+		ieee80211_free_txskb(hw, tx_info.skb);
+	}
 
 	return ret;
 }
-- 
2.51.0


