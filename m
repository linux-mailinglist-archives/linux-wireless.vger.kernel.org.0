Return-Path: <linux-wireless+bounces-21482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27225A87550
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 03:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF816F82C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6618DB17;
	Mon, 14 Apr 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JtxCkJH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6AB188A0C
	for <linux-wireless@vger.kernel.org>; Mon, 14 Apr 2025 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744594808; cv=none; b=SbzNHe67XvNtGjPbhcInbT/ORyybIxPQHDGiUE3uxWlcAkcETxI50b1g70v5o4Ga1QQ3KuX98snSvNfl7VuofJZ/JpeMHYzz/qOZVRyzzLlZKRfJhnPBsEYYdtTtuRGQLY/iEIu0v6sIMBj2ooZZAd3kIcg/HDhQWHouKpizSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744594808; c=relaxed/simple;
	bh=GExelr+YH9DVdtJLp/UJnkz+HhaE72Mg3nLIhwp3pDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExRfkZZDBPPhAl1qhhd9lnBIz3HUvXF2J9e2yFCu+lhQTsgrexgGSYaBfBG786tLD6eggdpUtygRWgvzPFizQeRr3cr3DxmPG878D2Kumcg7gaxqjZINbitR7CaHjW0qBCrRaYByyc/ZhWXkbfUIkObv8nQ0jbO5lMQW4C3BXio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JtxCkJH5; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5fd8b56818d111f0aae1fd9735fae912-20250414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0ToTuovZtuWURBdgscTIpuN5Hp9H7dEv2h8onAbsUyU=;
	b=JtxCkJH50QLDBm8dFYHFDuhsEGEETxk2lva5mKNK2QVdhSh1NxV2dYJasaeF4SNiqeaf9KNF00d6CP9sXkVOop0sy7MznhD0OjgLa+1ICUiLQanvc+uWMlJmSGp9kVz+WfmMydYrT7Gr4HBjSuFLJ2vHcaqqw9pnKY05jknzvdw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:8f04d6e3-89e5-44fa-ad8c-688b26ad860e,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:b15a338b-0afe-4897-949e-8174746b1932,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5fd8b56818d111f0aae1fd9735fae912-20250414
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1348197023; Mon, 14 Apr 2025 09:39:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 14 Apr 2025 09:39:57 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 14 Apr 2025 09:39:57 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo <michael.lo@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH 3/3] wifi: mt76: mt7925: ensure all MCU commands wait for response
Date: Mon, 14 Apr 2025 09:39:54 +0800
Message-ID: <20250414013954.1151774-3-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250414013954.1151774-1-mingyen.hsieh@mediatek.com>
References: <20250414013954.1151774-1-mingyen.hsieh@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Michael Lo <michael.lo@mediatek.com>

Modify MCU command sending functions to wait for a response,
ensuring consistent behavior across all commands and improves
reliability by confirming that each command is processed
successfully.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a957111d9ab9..4b0e1b2e2293 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -783,7 +783,7 @@ int mt7925_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl)
 	int ret;
 
 	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(WSYS_CONFIG),
-					&req, sizeof(req), false, NULL);
+					&req, sizeof(req), true, NULL);
 	return ret;
 }
 
@@ -1424,7 +1424,7 @@ int mt7925_mcu_set_eeprom(struct mt792x_dev *dev)
 	};
 
 	return mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_CMD(EFUSE_CTRL),
-					 &req, sizeof(req), false, NULL);
+					 &req, sizeof(req), true, NULL);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_set_eeprom);
 
@@ -2762,7 +2762,7 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 	conf->band = 0; /* unused */
 
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SET_DBDC_PARMS),
-				    false);
+				    true);
 
 	return err;
 }
@@ -2896,7 +2896,7 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	}
 
 	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
-				    false);
+				    true);
 	if (err < 0)
 		clear_bit(MT76_HW_SCANNING, &phy->state);
 
@@ -3002,7 +3002,7 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 	}
 
 	return mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
-				     false);
+				     true);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_sched_scan_req);
 
@@ -3038,7 +3038,7 @@ mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 		clear_bit(MT76_HW_SCHED_SCANNING, &phy->state);
 
 	return mt76_mcu_skb_send_msg(mdev, skb, MCU_UNI_CMD(SCAN_REQ),
-				     false);
+				     true);
 }
 
 int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
@@ -3077,7 +3077,7 @@ int mt7925_mcu_cancel_hw_scan(struct mt76_phy *phy,
 	}
 
 	return mt76_mcu_send_msg(phy->dev, MCU_UNI_CMD(SCAN_REQ),
-				 &req, sizeof(req), false);
+				 &req, sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_cancel_hw_scan);
 
@@ -3182,7 +3182,7 @@ int mt7925_mcu_set_channel_domain(struct mt76_phy *phy)
 	memcpy(__skb_push(skb, sizeof(req)), &req, sizeof(req));
 
 	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(SET_DOMAIN_INFO),
-				     false);
+				     true);
 }
 EXPORT_SYMBOL_GPL(mt7925_mcu_set_channel_domain);
 
-- 
2.34.1


