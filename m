Return-Path: <linux-wireless+bounces-20188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31894A5CC93
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 18:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5CE189EFB0
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395C72620D6;
	Tue, 11 Mar 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaQn4OyQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6A262D20
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715138; cv=none; b=KyXlCXA6TmxstP+O65s881KcbI4Rqe4P4Hc18by2yD4gZzCk94mDQLL8hBGjNyrXoarDKuk93RM5eeZDcj962QdhNr8xNS4BLbwGpYOTlPWmWnpnVCeIlmGONww2FsjEVAS0+oT+Bx3TJXztcxGdV8dpX4Bo1GVuUgQFYXI99YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715138; c=relaxed/simple;
	bh=LVJawuz9qJYzYyrfmxkyS2WnH9bwQG3JJ+05tO0wnlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9w0t6Zm/Bb5okR6SQLZAW9CtkZfxkjD00kKPn/zvoUucQSaln3+vT+P1qptuQU/m9vJM7w/PAAhYN20RMdiuH4f1SAlrX/oPethPOnXrmBrv6bmehbzP4NYIYJJoFkwoFAAHkB92wkEe1GOMg+9vEOMgnKgRANetReI2fbD+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaQn4OyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A857C4CEE9;
	Tue, 11 Mar 2025 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715137;
	bh=LVJawuz9qJYzYyrfmxkyS2WnH9bwQG3JJ+05tO0wnlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gaQn4OyQ5++jIDUZ913GwZLxCPjkXEcDxeXKyxfLhuoBD7eloqIJ6gr7NcY97KADN
	 OSLxzl4WXuL1+oV0V53PLw1KtZ8xQbdLwwsYIuEiT19PF0NfLZKBz9DKjAEAKJyVLS
	 MabKFdfS8r/654CPtvJ3Vz/DuNpYtMmT1lzwUMTzEGPU2Krm3tD5PYPGbAiKm2F/vN
	 ph3yPl08SPrG00axHfzKKNSj0Yp380BoimOj8wlmYCUD2disNyqWeUE99ZYMYNujGG
	 DVH6n1ft3iIF/84YIca81qwldpSOz/wLFOuq0CUzb1E5WGKb0VWNziO0TKDvsXRUjr
	 YX/K004TWI5Cw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 11 Mar 2025 18:45:07 +0100
Subject: [PATCH v2 08/13] wifi: mt76: mt7996: Add
 mt7996_mac_sta_change_links callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-mt7996-mlo-v2-8-31df6972519b@kernel.org>
References: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
In-Reply-To: <20250311-mt7996-mlo-v2-0-31df6972519b@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Intrdouce mt7996_mac_sta_change_links routine to set change_sta_links
required by mac80211. This is a preliminary patch to introduce MLO
support for MT7996 driver.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 1bca444d2d02333cabd31ba2c8565769a42ab581..307c68c6b0cd7c3acdbfd7be78a007a66d3183bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -952,6 +952,26 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	return err;
 }
 
+static int
+mt7996_mac_sta_change_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, u16 old_links,
+			    u16 new_links)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	unsigned long add = new_links & ~old_links;
+	unsigned long rem = old_links & ~new_links;
+	int ret;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt7996_mac_sta_remove_links(dev, sta, rem);
+	ret = mt7996_mac_sta_add_links(dev, vif, sta, add);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
 static int
 mt7996_mac_sta_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta)
@@ -1921,4 +1941,5 @@ const struct ieee80211_ops mt7996_ops = {
 	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
 	.change_vif_links = mt7996_change_vif_links,
+	.change_sta_links = mt7996_mac_sta_change_links,
 };

-- 
2.48.1


