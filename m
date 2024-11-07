Return-Path: <linux-wireless+bounces-15034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117C59BFDA4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 06:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9637283263
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 05:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF316F84F;
	Thu,  7 Nov 2024 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EoDJf+AS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E910F9
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730957417; cv=none; b=rlzuiNa7peV2PVE/m/W9WKLviR/NevPC+kB6yWgJPs45UsHfMvVAyNakTQX19EucrLK9JMYmM/e/bnc3XUm0vrBsELDhdGuUAbWDfQZO0bqprQtE464qkBrHuiKyFDutUWMKxe3v+JpKci0h2tlNOwzdHcaBbOG5DM5z8ehc3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730957417; c=relaxed/simple;
	bh=3QwnO590J+LStJa5O/E2Kpj3bpyahm2ewLGhbnxqe4w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ITtXC2vzNo8yUnDC7EjzwH+gcV7SoQS17Wh2N224AZJ/fHgl7gjUyQiPSZExr9qr4EXo/LepVUxuj3L3h0N7+USbAk4Lh2bXPwyOs0wiZ4YNSkqS4QNHIb0slv+LK/6pJ/vAJX0qcb5l4ccDnN4YZkqyQkTeHUkdyWspCLcRsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EoDJf+AS; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5ac1e4709cc911efbd192953cf12861f-20241107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BmwFuwWjNPLPNCJb3pEwS6rU69b498swzwDmiyKrQjU=;
	b=EoDJf+AS0qC+LbU/T8X/zYUu0Z2F4/YPsGlIF6sHJVnrGYVZDKQhpd+C5ukJcroDxMb8EtBJlJTWETm9m7+AN3MtWEoQw3ApJwuUIp7KhNSEkFYSHnudR3UxuHA5n2YNtl1G0v/8T3Y3W14Wok749jlvp/rMx/UrLf1CNtQ4+HM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1e0241e1-167d-45bc-860f-76b1595191f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:013cb006-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5ac1e4709cc911efbd192953cf12861f-20241107
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 331188844; Thu, 07 Nov 2024 13:30:09 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 7 Nov 2024 13:30:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 7 Nov 2024 13:30:08 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: fix the invalid ip address for arp offload
Date: Thu, 7 Nov 2024 13:30:05 +0800
Message-ID: <20241107053005.10558-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The wrong ieee80211_vif will lead to get invalid ip address and
the correct ieee80211_vif can be obtained from ieee80211_bss_conf.

Fixes: 147324292979 ("wifi: mt76: mt7925: add link handling in the BSS_CHANGED_ARP_FILTER handler")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index b43617dbd5fd..123a585098e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -123,10 +123,8 @@ EXPORT_SYMBOL_GPL(mt7925_mcu_regval);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
 				 struct ieee80211_bss_conf *link_conf)
 {
-	struct ieee80211_vif *mvif = container_of((void *)link_conf->vif,
-						  struct ieee80211_vif,
-						  drv_priv);
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct ieee80211_vif *mvif = link_conf->vif;
 	struct sk_buff *skb;
 	int i, len = min_t(int, mvif->cfg.arp_addr_cnt,
 			   IEEE80211_BSS_ARP_ADDR_LIST_LEN);
-- 
2.25.1


