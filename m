Return-Path: <linux-wireless+bounces-28438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA3C240BE
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 10:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0456401BBD
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239532E72A;
	Fri, 31 Oct 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ahFQkRBV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294D32E68E
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901454; cv=none; b=J/h3/IjVHfA3zGu5X5o+j9OlD+u5ZWjFQ7h7wXNdz6S03HyvASBaYgsxW9wWpVmFjF3HrFOh4FHpUWc35Uti7nmDhysZD8egrP3uAgNcdiqc7LoI2QgFnRQBwoLvu2lD67es6//Wxh1Ock+W3T6NQA6e7ED0003JBt4FJy+OKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901454; c=relaxed/simple;
	bh=r1y3x274+hf53BbyXJ9J61iFSv51A00dCTEj+3DSDR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyGilc81DXydRM/R1Cbno+VH/Exqy1EEKo6ZD3A6a8OvQO7805jybxBN5L+DIL8mgd2VmIuYmpLG2c9tYMUJTqQoqD1dfLHuw9H0i50XhelQ7PPEYd5hVWY2rr5GoockdpK6zQxYyFfkiJyW9mm8D14Mo64ywhNgRHknc7qUqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ahFQkRBV; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8ebe870eb63811f0ae1e63ff8927bad3-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xtPt9S/dRICeSuTOWbXBIStFl3r42xpbJLKfvKyvRTo=;
	b=ahFQkRBV2OnXooV9BpYWWyEDhGx609C3MinaIDO66UtTOuFMgLzKug8yRqlUJbTqdU2XiYsWJqdh8NRm6tRGqk/qaymeb8C+tc+OPxAFvX4y9JuKGbLxDcnxZYajxollzud/dr+FFX3DX3vBwoUtzygPcyoABnc58zVMUDT7k9c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4fc181b3-8307-4934-80ca-1678242c1100,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:bb28fcdf-3890-4bb9-a90e-2a6a4ecf6c66,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8ebe870eb63811f0ae1e63ff8927bad3-20251031
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1086206809; Fri, 31 Oct 2025 17:04:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 17:04:06 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 17:04:06 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH 6/6] wifi: mt76: mt7925: disable auto regd changes after user set
Date: Fri, 31 Oct 2025 17:03:52 +0800
Message-ID: <20251031090352.1400079-7-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
References: <20251031090352.1400079-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Add regd_user flag to block automatic regulatory domain updates
if set by user.

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 1 +
 drivers/net/wireless/mediatek/mt76/mt7925/regd.c | 7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt792x.h      | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index fe1a7e386fc7..ac3049360bab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -738,6 +738,7 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 	int ret, i, len, offset = 0;
 
 	dev->phy.clc_chan_conf = 0xff;
+	dev->regd_user = false;
 	if (!mt7925_regd_clc_supported(dev))
 		return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
index 4565e1132b36..292087e882d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/regd.c
@@ -173,6 +173,10 @@ void mt7925_regd_notifier(struct wiphy *wiphy, struct regulatory_request *req)
 	struct mt76_connac_pm *pm = &dev->pm;
 	struct mt76_dev *mdev = &dev->mt76;
 
+	if (req->initiator == NL80211_REGDOM_SET_BY_USER &&
+	    !dev->regd_user)
+		dev->regd_user = true;
+
 	/* allow world regdom at the first boot only */
 	if (!memcmp(req->alpha2, "00", 2) &&
 	    mdev->alpha2[0] && mdev->alpha2[1])
@@ -224,7 +228,8 @@ int mt7925_regd_change(struct mt792x_phy *phy, char *alpha2)
 		return 0;
 
 	if (!mt7925_regd_is_valid_alpha2(alpha2) ||
-	    !mt7925_regd_clc_supported(dev))
+	    !mt7925_regd_clc_supported(dev) ||
+	    dev->regd_user)
 		return -EINVAL;
 
 	if (mdev->alpha2[0] != '0' && mdev->alpha2[1] != '0')
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index ed2606e9251a..8388638ed550 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -231,6 +231,7 @@ struct mt792x_dev {
 	bool hw_init_done:1;
 	bool fw_assert:1;
 	bool has_eht:1;
+	bool regd_user:1;
 	bool regd_in_progress:1;
 	bool aspm_supported:1;
 	bool hif_idle:1;
-- 
2.34.1


