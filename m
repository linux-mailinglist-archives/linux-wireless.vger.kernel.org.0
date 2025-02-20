Return-Path: <linux-wireless+bounces-19210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3906A3DB2A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D31188E35A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A51F5612;
	Thu, 20 Feb 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc0BvIuS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0350433BE
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057578; cv=none; b=Kdauu5jgHOqXFWtaFQLeRoVDPjrzqeMKTyq36BENePPlRfbf0ScbW3rp70zXyOHIc59naaJXDLZzOPZq4mTtTF71xPGJdiOaXvFnmRRwiseCQQ6xyT+NiCP0dfqgQhW0K6O6+XiN2mQUS0ockNkNMOqgzsMtGTDue2ZfTeYl14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057578; c=relaxed/simple;
	bh=oYh28uG3L205irwjJPq5XZAi+P7PjMKOx+i9ez8sILI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lV2FpNTFpAEQxyjEhQ7R+/DhH4QPaCyaNr6MmIPCPK3aLiFbn+l32jQuEpyBTwHwK7aR+hpj9rHNc5ZnEOsHMbwmDhBEeoK9TlodVZH8w0CeepMyHmDqEeZMtzkvIChq5mbGeuFDKvDs0T8VG0c2V7LCW39E5VdlzVVsU5wI3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc0BvIuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1F9C4CED1;
	Thu, 20 Feb 2025 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057578;
	bh=oYh28uG3L205irwjJPq5XZAi+P7PjMKOx+i9ez8sILI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rc0BvIuSLSqHguOpDDLhU7DAGb29Mffgz5LFtOx4q4dJ1wQl+zvs2UdS+C7wiCNTo
	 QJ6wnEXtUyjMdIOUmQRz0Ld3GVDTQneFVcQ6o8g1AW/STzpY4WECt2w2KoKiM5J/Jz
	 UNwWlLi6IRLsPBuBmeOCMKHD3cqQfLKpoV8L/jP7DjQb8lCepebU7BoPFmXvOBwhTl
	 p70/FdiU7Wp4pq8C0Acx6H68zFz2yUZqh4YrnOlh/308haiGt/RAhYDNy98P60UeMY
	 DSznsGSPbTi+3O/hbF4Y1jJK96KVFqyQZjHhdmMB94nslzF8Qo0eaE+pVxXqfvUIAx
	 r3eMs+EcNwrzg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:56 +0100
Subject: [PATCH 10/14] wifi: mt76: mt7996: Support MLO in
 mt7996_mac_sta_event()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-10-34c4abb37158@kernel.org>
References: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
In-Reply-To: <20250220-mt7996-mlo-v1-0-34c4abb37158@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Similar to mt7996_mac_sta_add() adn mt7996_mac_sta_remove(), update
mt7996_mac_sta_event routine to take into account MLO support.
Please note mcu routines does not support MLO yet.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 69 ++++++++++++++----------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 104f832c1676912fbd07886da57c262112efea15..008b8dd3525482f45d99774be79e75afca3fb453 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -949,41 +949,52 @@ int mt7996_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
-	struct mt7996_sta_link *msta_link = &msta->deflink;
-	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
-	struct mt7996_vif_link *link = &mvif->deflink;
-	int i, ret;
-
-	switch (ev) {
-	case MT76_STA_EVENT_ASSOC:
-		ret = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
-					 CONN_STATE_CONNECT, true);
-		if (ret)
-			return ret;
-
-		ret = mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
-		if (ret)
-			return ret;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
-		msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
-		msta_link->wcid.sta = 1;
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		struct mt7996_sta_link *msta_link;
+		struct mt7996_vif_link *link;
+		int i, err;
 
-		return 0;
+		link = mt7996_vif_link(dev, vif, link_id);
+		if (!link)
+			continue;
 
-	case MT76_STA_EVENT_AUTHORIZE:
-		return mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
-					  CONN_STATE_PORT_SECURE, false);
+		msta_link = mt76_dereference(msta->link[link_id], &dev->mt76);
+		if (!msta_link)
+			continue;
 
-	case MT76_STA_EVENT_DISASSOC:
-		for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
-			mt7996_mac_twt_teardown_flow(dev, msta, i);
+		switch (ev) {
+		case MT76_STA_EVENT_ASSOC:
+			err = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+						 CONN_STATE_CONNECT, true);
+			if (err)
+				return err;
 
-		mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
-				   CONN_STATE_DISCONNECT, false);
-		msta_link->wcid.sta_disabled = 1;
-		msta_link->wcid.sta = 0;
+			err = mt7996_mcu_add_rate_ctrl(dev, vif, sta, false);
+			if (err)
+				return err;
 
-		return 0;
+			msta_link->wcid.tx_info |= MT_WCID_TX_INFO_SET;
+			msta_link->wcid.sta = 1;
+			break;
+		case MT76_STA_EVENT_AUTHORIZE:
+			err = mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+						 CONN_STATE_PORT_SECURE, false);
+			if (err)
+				return err;
+			break;
+		case MT76_STA_EVENT_DISASSOC:
+			for (i = 0; i < ARRAY_SIZE(msta_link->twt.flow); i++)
+				mt7996_mac_twt_teardown_flow(dev, msta, i);
+
+			mt7996_mcu_add_sta(dev, vif, &link->mt76, sta,
+					   CONN_STATE_DISCONNECT, false);
+			msta_link->wcid.sta_disabled = 1;
+			msta_link->wcid.sta = 0;
+			break;
+		}
 	}
 
 	return 0;

-- 
2.48.1


