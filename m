Return-Path: <linux-wireless+bounces-3260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5735484C20B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 02:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1159328C2CD
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 01:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0967200AD;
	Wed,  7 Feb 2024 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fgfwDmrp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43254F9F7
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270004; cv=none; b=PY+sODDPXB7r71hT5IMZc9nVE9xw+ZHIsWEVwEOIY97vEvhQUwxI6gczk9/v8EGLu6LbGVZ2354bgaU4fkz5gr93VFgjn2OL2X3vjvtGVh1gtn31RHoOU/8sFVNJ+TA9qpvHuevvYFhjXNBUmBZXUGGkO1CQ/dmxjhFVzGKtN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270004; c=relaxed/simple;
	bh=mkXsOTVtzPGnVdeMan/cvnNzUB86ikW3Nr1J9YAL0LI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVLyaVYYTv4cUv+ubXcUaY5OzSsCULK1Qq+VXAdHa78XAU/MM/oRah7ZZtAVZqEmYDomAaZF53bOe56qoK8cL3XeO92iFwbgdqZhKu2qTcxiuombKZ69RbBFJnL+5PZ16FqTLpa/5xDk5jvKIeOg11m78EAeChk2Iv33PD/tT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fgfwDmrp; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cc8e78fec55911eea2298b7352fd921d-20240207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uDouN0pdbhwQRjTzuJpHQCJy8aUyeV2qZj7bI+J4528=;
	b=fgfwDmrpaqMez5Z9BkpGXFNZYLQDof9jjel6dunDkNgfvWyf1h10PN7uhIh5bGy55a8/A/0gPIy6qIkQXx88xdEUkqTX1xozjtd/YiEdgI1DBCesiylbyVe0Rq7UXGQ8fU3R9L0/ocEOBLR47SDFtJEgMMcLyNnpukVS5hMWwzs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:65120662-306b-41aa-b21b-7c6cb1c6066d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:d447b383-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cc8e78fec55911eea2298b7352fd921d-20240207
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 268962624; Wed, 07 Feb 2024 09:39:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Feb 2024 09:39:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Feb 2024 09:39:54 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: fix suspend issue on MediaTek COB platform
Date: Wed, 7 Feb 2024 09:39:45 +0800
Message-ID: <20240207013945.23558-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.150300-8.000000
X-TMASE-MatchedRID: yZoAMijhO4c9S3IiQd+eNRNEPNwNrw/rieyBFTE1+ceIoW+1yT7Gw6UJ
	mwqvEWihdAyEKWUq4v4C3sKcss0odmK6SHtwuj6rQpxiLlDD9FWusS9CiBzL8X5h6y4KCSJcZ10
	wKXUWXnJirZ/FbBb+bqCF2qOQ8zIWVJTV35UngiMZXJLztZviXKxwr8rYOW+O0zabL4+/4csJSK
	yYs8AD/ax4GQqkd00FumMCMwce1mUfE8yM4pjsDwtuKBGekqUpOlxBO2IcOBajycPov0YYz9FAH
	qz04bFbXGumjTnZ3ElZZFJWUoXZhel/jnRe4WMsiMi52pBTvfk12WiR9TdDZ5UDrgLdu1TA4gKV
	wGe6cHjBkGBTIlURuXoXDz8+lMxFpW+aIDJ4DaRzkxJ+SIkUjmncuUSUEdOX
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.150300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: B575A5AC19A7385059901DA6BF1BFA2F5ED3C6E1A2C7CF06A57263B916AC3F032000:8

From: Michael Lo <michael.lo@mediatek.com>

MediaTek's controller driver on COB platform (e.g. MT8188) is
capable of controlling power supplies and reset pin of a component
(e.g. a WIFI chip) in power-on and power-off process.

Due to this optional feature, mt76 need to inform controller
that mt76 need to keep power during suspend. Otherwise WIFI will be
powered off when system enters suspend process.

The "wakeup-source" property was used for the device that need
this to go into suspend mode so that mt76 suspend handler doesn't
fail and the system is able to enter into a suspend state.

An example:
wifi: mt7921@0 {
	wifi0{
		reg = <0x0000 0 0 0 0>;
		wakeup-source;
	};
};

Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <MingYen.Hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index fabd24726f3e..e673a153d3cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/of.h>
 
 #include "mt7921.h"
 #include "../mt76_connac2_mac.h"
@@ -369,6 +370,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_irq;
 
+	if (of_property_read_bool(dev->mt76.dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev->mt76.dev, true);
+
 	return 0;
 
 err_free_irq:
@@ -386,6 +390,9 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
+	if (of_property_read_bool(dev->mt76.dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev->mt76.dev, false);
+
 	mt7921e_unregister_device(dev);
 	set_bit(MT76_REMOVED, &mdev->phy.state);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
-- 
2.18.0


