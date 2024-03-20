Return-Path: <linux-wireless+bounces-4978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44647881083
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00001283786
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398863FE48;
	Wed, 20 Mar 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DdAfNmpq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400973FBBD
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932980; cv=none; b=JfId11wfIT6DtE+MYHIGJrNt+32hXubSyrDQ+9bojc+uwgli/Z77FQLtFBoLSAEX6DoLRrmEcydXICcGssWNCshOn98x9Osid+WnwgSk+aynP0VoByjIN7uFJYZbUpv8egqnqDi8AAezXv3dT1Fqi06++HMLTHiQIt+3XabT1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932980; c=relaxed/simple;
	bh=Nu0iw3rfJrRFteva0XOjZqgHtrAK0NABa8uRjEGyA3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9qf5Qr+bUiTG8clR+fhVRhRM9u1myiWa5QhlTf7o1iHXjS362blaYh2ZE78WwbeAuUwk3GdYy2fDtPAGNCLPZ1uUgabPC5XNSZurH/RD9H9SXhsirgfhhnrTzL9+xa6M6tcBlIvtsr+PWpnRo/D5u5k16YO+VGRmQM+hJjxbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DdAfNmpq; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 50660752e6aa11ee935d6952f98a51a9-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qHFq/SHYWwmMrxqEzdo+SS/aNsqA6ziw9jOujhP9PYE=;
	b=DdAfNmpqefUoT18qqyU5epKKXWrQJe6MFBhgzRJko3ENiBwTzyljijgxX0q4ght7rtF90y4TufzVbitoXn/6k+bPKpNZFCzESp/RBUGbdoQzksQA2dmNunN+4QUorjiME0+eHGEUpHPLL6GJ5mf2sQRkSRvB5PtvQ1dmPOxWrcg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:c5e9300c-f843-4738-a986-a13d4849fcc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:83443985-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 50660752e6aa11ee935d6952f98a51a9-20240320
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2096128869; Wed, 20 Mar 2024 19:09:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 19:09:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 19:09:23 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Peter Chiu
	<chui-hao.chiu@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 03/10] wifi: mt76: mt7996: set RCPI value in rate control command
Date: Wed, 20 Mar 2024 19:09:11 +0800
Message-ID: <20240320110918.3488-3-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240320110918.3488-1-shayne.chen@mediatek.com>
References: <20240320110918.3488-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.180700-8.000000
X-TMASE-MatchedRID: QbPx/KKIOtkVAKRaMHqjDuqwWVBfMuvoiXPf/NTPc3L7a38GZa638/9T
	oIqmlx19ThbvLLI8RvPySrCMyCN+k7f0EuHoGRzuXP5rFAucBUF9LQinZ4QefPcjNeVeWlqY+gt
	Hj7OwNO22utO5qEfOUcvaotXfhHsZS0JIXn46gU++kqPMl4Gd85C8Y298Z3DOAzbuP/fdBgNF+R
	fkwBqz1SePOtBmr2D8XDMWiox8SpCKT2uf3M1sLUma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6
	x5U/HriPpCuffGH9zI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.180700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	51CF1722E20EA23050E6926241C88091E4E8080300A86576510A5276BDA6BBDE2000:8
X-MTK: N

From: Peter Chiu <chui-hao.chiu@mediatek.com>

Set RCPI values in mt7996_mcu_sta_rate_ctrl_tlv(), which can make the
FW rate control algorithm be initialized with a better MCS selection
table.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index fd0cc945b22a..ddd93ec1dddd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1968,6 +1968,7 @@ static void
 mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
 {
+#define INIT_RCPI 180
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt76_phy *mphy = mvif->phy->mt76;
 	struct cfg80211_chan_def *chandef = &mphy->chandef;
@@ -2065,6 +2066,8 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 					       IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP);
 	}
 	ra->sta_cap = cpu_to_le32(cap);
+
+	memset(ra->rx_rcpi, INIT_RCPI, sizeof(ra->rx_rcpi));
 }
 
 int mt7996_mcu_add_rate_ctrl(struct mt7996_dev *dev, struct ieee80211_vif *vif,
-- 
2.39.2


