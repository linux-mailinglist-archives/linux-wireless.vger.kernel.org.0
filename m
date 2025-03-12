Return-Path: <linux-wireless+bounces-20229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A7A5DB26
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 12:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F6188C1B7
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF422DFB5;
	Wed, 12 Mar 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7lZNmSq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6122E011
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778048; cv=none; b=WQ3uX7DV+QVtJr/Ihjm4q4o34oiTpiUh5UnuVWKQRWkpPgt+y1LZMrnnZq/itrqktWw4oUSXoAqY8z9VnQyMjaJ4XLno473RJAYM5a0piV7Yt8qn9C03Lnc5aMVxXHASQYSd1yn3icFr+IzP1qSjgiP6Zx9yk0f5Z5QtMUVq3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778048; c=relaxed/simple;
	bh=EG3lLoWPuZSGQkinDAJwVshdVSbc3K3nCOlOSKDN8c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7ZThbnvfrEVoNRueypfLk48SRsR5Ge4JA7+CT5/5aaHpIn62zoBpnAEKhuBhDwmR1jb9NyXFVRySd8v5NiYeZcNOsy3xsOQM/iHwGWWRBHOv4q7iT52OnrfJ3JIvl5mTv3+NyqL9Eo3+/ZPWAGKYkzkFuA2m4q9FUeXwpsAPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7lZNmSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FF4C4CEE3;
	Wed, 12 Mar 2025 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741778048;
	bh=EG3lLoWPuZSGQkinDAJwVshdVSbc3K3nCOlOSKDN8c4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c7lZNmSqLnR4R79tyF1sYpO+Jiq0dDUAYekJGW+Kzvupt/8lJMwV/feOrNCV8zL/M
	 jweUMGyAFTXugzaht3j4yh/uy95KOlRzl7NppweM/FpRGfOvlK9dorNVL2OfsD6BKx
	 t7p+H2G7JNhZNk0NQaew2j4Fo5tYXuORPWVwuJFwhNfhk1u/Gr16oXi/Bfp+x+vO/q
	 3cefZhUAdXs+FehzMZgAc1Cs7Zbm/BdauUecQehfzSZYp6ANwsLaiFSd3Kb/VyXoC8
	 PobPgiBOgCHFpvNl7t/uHzZq/GbWQ4mRraB/nVM25VrrIxfSV89i2pwqepWXm9tEuK
	 wS6pMAJ7YBgQA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 12 Mar 2025 12:13:47 +0100
Subject: [PATCH 03/21] wifi: mt76: mt7996: Add mt7996_mcu_teardown_mld_sta
 rouine
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-mt7996-mlo-p2-v1-3-015b3d6fd928@kernel.org>
References: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
In-Reply-To: <20250312-b4-mt7996-mlo-p2-v1-0-015b3d6fd928@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

mt7996_mcu_teardown_mld_sta is used to remove MLO configuration from the
MCU. This is a preliminary patch to enable MLO for MT7996 driver

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   | 12 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 18 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 +++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 25dbf086c8ef02307ef2510b21853b1eee28f922..642d633b5126ce81f3d32a9bd912603e2c328c8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1017,6 +1017,7 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	unsigned long links = sta->valid_links;
 	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
 
@@ -1067,11 +1068,16 @@ mt7996_mac_sta_event(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 				mt7996_mac_twt_teardown_flow(dev, link,
 							     msta_link, i);
 
-			mt7996_mcu_add_sta(dev, link_conf, link_sta, link,
-					   msta_link, CONN_STATE_DISCONNECT,
-					   false);
+			if (sta->mlo && links == BIT(link_id)) /* last link */
+				mt7996_mcu_teardown_mld_sta(dev, link,
+							    msta_link);
+			else
+				mt7996_mcu_add_sta(dev, link_conf, link_sta,
+						   link, msta_link,
+						   CONN_STATE_DISCONNECT, false);
 			msta_link->wcid.sta_disabled = 1;
 			msta_link->wcid.sta = 0;
+			links = links & ~BIT(link_id);
 			break;
 		}
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ac01eb880e2a6f6ef3a81591bcacd2b90c48986a..46c5e639b9630199ffa601e545fa76690f0101e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2346,6 +2346,24 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
 }
 
+int mt7996_mcu_teardown_mld_sta(struct mt7996_dev *dev,
+				struct mt7996_vif_link *link,
+				struct mt7996_sta_link *msta_link)
+{
+	struct sk_buff *skb;
+
+	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &link->mt76,
+					      &msta_link->wcid,
+					      MT7996_STA_UPDATE_MAX_SIZE);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
+
+	mt76_connac_mcu_add_tlv(skb, STA_REC_MLD_OFF, sizeof(struct tlv));
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_WMWA_UNI_CMD(STA_REC_UPDATE), true);
+}
+
 static int
 mt7996_mcu_sta_key_tlv(struct mt76_wcid *wcid,
 		       struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index a91a50b72218c6a2d0dd32968681325ea7e6a042..c2a2916e0647cfdcbee9912e3915241465e32cac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -578,6 +578,9 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev,
 		       struct mt7996_vif_link *link,
 		       struct mt7996_sta_link *msta_link,
 		       int conn_state, bool newly);
+int mt7996_mcu_teardown_mld_sta(struct mt7996_dev *dev,
+				struct mt7996_vif_link *link,
+				struct mt7996_sta_link *msta_link);
 int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);

-- 
2.48.1


