Return-Path: <linux-wireless+bounces-19209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC13A3DB25
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677AC179255
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BB1F8672;
	Thu, 20 Feb 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t82jy/YF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761141F5425
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057576; cv=none; b=rkweyFe53SfoAdDGAWExdc3ONbcSI8fC32X6kA/UStVDIL96NbSIbNE5KyYWuOalWbz6gblUUvDA1RSc7jiuHJfCVztpgEOdXVT5vVwVXrHyfGcgs7DCHF9oZb9gKZdWXbt56KWEebndgE2mjdA+jWloF9i+YEoIqBldA7vNIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057576; c=relaxed/simple;
	bh=gGdf+VRUhiXXWh8gyuHClI8gYTA7M7cqi6oq8hubugI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbxRNsre9wtRKr278xLGvGcnactAzk71NRvlY3hvI/o85LliSpinBh1Q+GJ8t1TUhHNZplfAGGXdK7EG7SytqPijttqAoItfNmeULV9bzOo5ix5nbfcohWDunVGpwoxge1+JPk0r7kQJ/xDqLdQxzl9HWPp4FHug7bv698uoD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t82jy/YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90488C4CED1;
	Thu, 20 Feb 2025 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057575;
	bh=gGdf+VRUhiXXWh8gyuHClI8gYTA7M7cqi6oq8hubugI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t82jy/YFvAa+dlqo2L7ilXJDn1InyBLjHC4lthLaoLWmDvkO4zi5i7NxEWvd41UIE
	 /MwbqjipOdqylRR0E7aB74mfJGUloSDlG+J1jLvCi9MuxGmuRjtkKAxxE7vK0skfVd
	 jIH2+OuyaQ+EXq7ppkV6s7sN4q2mL14rpgasAcT5pVDaPIKCcYKeBuHVuIZTfyh6TU
	 qa05ANvGzyLPwYHUvZ4uStZCavoONYDmPB0naLLfVooUpoQ4mlUi7KNrqzEQF1yD42
	 h7jN9KNszmVAOWPUO3LMcXqnV3xR7nolxApVfnHFKFR5Z0vw986Lh1Iaxro9BjjnN7
	 Q4tO+5kPfFoZg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 20 Feb 2025 14:18:55 +0100
Subject: [PATCH 09/14] wifi: mt76: mt7996: Add mt7996_mac_sta_change_links
 callback
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-mt7996-mlo-v1-9-34c4abb37158@kernel.org>
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
index 06e87a8cae48902d3ffa641127f653ddb146cb3d..104f832c1676912fbd07886da57c262112efea15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -910,6 +910,26 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
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
 int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
@@ -1827,4 +1847,5 @@ const struct ieee80211_ops mt7996_ops = {
 	.net_setup_tc = mt76_wed_net_setup_tc,
 #endif
 	.change_vif_links = mt7996_change_vif_links,
+	.change_sta_links = mt7996_mac_sta_change_links,
 };

-- 
2.48.1


