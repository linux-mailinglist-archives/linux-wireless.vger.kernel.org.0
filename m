Return-Path: <linux-wireless+bounces-26680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85977B37CAD
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 10:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3F71B2138B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00021B9C8;
	Wed, 27 Aug 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUWbZQf6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F430CDBA
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281682; cv=none; b=LbPj7LU/MF3Gf6EwV3mqosDQs359+IRVnZF4c+bEj8TRQPeuzAS/hEzQsAUCtEoYjxN79jJXI9vM39eDtznrOT860l3cLkflYE1/51BojsQ7AMwSddwAWzJ7KP40lcXEHEMG4LXVumQwLOoTFaMN74OGPgHhijWn1dp5sDxoKBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281682; c=relaxed/simple;
	bh=Nw7JExH/BxnTMttSxUeig+mm8bvREsbFmHsG7msCRWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vAnYxsx7EEVMANtVCCoL3ipWXSo+Hw+z7ihxZ6cv+wCdI+tg6Pz+PTMdDBfBWiYI5v/lqWjemKWLagJVnk+3Fuwo5/izz+aKj1ooZzxMJPcSaIIcIHDU6Icf9fIdLhuPe0K0s+4n6DU8Ua2E0RuVBMFMAXsw5UN5jIMHcWvLNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUWbZQf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD2C19423;
	Wed, 27 Aug 2025 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756281680;
	bh=Nw7JExH/BxnTMttSxUeig+mm8bvREsbFmHsG7msCRWU=;
	h=From:Date:Subject:To:Cc:From;
	b=fUWbZQf6BTh45TtW9SnQDPvRvz1ZrsIj0ybgAJZg/94MJJIyoH5VUd8EhWV9IrXrL
	 8tfTk9AQAOfuW3D2ehGFWMmcYTB/HLHihB6ycrOpasAnuZ3sMPCu6ucS790oEy0Oma
	 Gs8PWt/U37CqW0g8ih4br4TayvqbiziZOwAJUFkt47fnelHbwKShovqG2PnmKZ6mrA
	 NxbRfElpaDvVaYMlPyk3VJyvD4xay7pbOVbcRS+QqykSHsuPUlANEjG+HLUJBBU0Ea
	 D1jZ3eLlCdorc5hnr5WpkBPdPHwTTGPyvoafDmpNE+DGyefi9Syaa5QfGIrILi0mr5
	 f9zHBnae9AjxA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 27 Aug 2025 10:01:02 +0200
Subject: [PATCH mt76] wifi: mt76: mt7996: Export MLO AP capabilities to
 mac80211
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-mt7996-mlo-ap-capa-v1-1-b5cfbcafa25f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAD27rmgC/x3MSwqAMAwA0atI1gZqUateRVykNWrAT2lFBPHuF
 pdvMfNA5CAcocseCHxJlGNPKPIM3EL7zChjMmilK9Vog9tp2rbGbT2QPDryhKRK66zhprQVpNA
 HnuT+p/3wvh+oqyF0ZAAAAA==
X-Change-ID: 20250827-mt7996-mlo-ap-capa-a04bcb7e84b5
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

From: Shayne Chen <shayne.chen@mediatek.com>

Report MT7996 MLO AP capabilities to mac80211 stack.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index a9599c286328eb2b1ff24504109d25a9d916e044..29e0cf966bcac5ab805b927fd73b7a23d15877ec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -63,6 +63,24 @@ static const struct ieee80211_iface_combination if_comb = {
 	.beacon_int_min_gcd = 100,
 };
 
+static const u8 if_types_ext_capa_ap[] = {
+	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
+	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
+};
+
+static const struct wiphy_iftype_ext_capab iftypes_ext_capa[] = {
+	{
+		.iftype = NL80211_IFTYPE_AP,
+		.extended_capabilities = if_types_ext_capa_ap,
+		.extended_capabilities_mask = if_types_ext_capa_ap,
+		.extended_capabilities_len = sizeof(if_types_ext_capa_ap),
+		.mld_capa_and_ops =
+			FIELD_PREP_CONST(IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS,
+					 MT7996_MAX_RADIOS - 1),
+	},
+};
+
 static ssize_t mt7996_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -463,8 +481,11 @@ mt7996_init_wiphy(struct ieee80211_hw *hw, struct mtk_wed_device *wed)
 	wiphy->radio = dev->radios;
 
 	wiphy->reg_notifier = mt7996_regd_notifier;
-	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+			WIPHY_FLAG_SUPPORTS_MLO;
 	wiphy->mbssid_max_interfaces = 16;
+	wiphy->iftype_ext_capab = iftypes_ext_capa;
+	wiphy->num_iftype_ext_capab = ARRAY_SIZE(iftypes_ext_capa);
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BSS_COLOR);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);

---
base-commit: a7cc1aa151e3a9c0314b995f06102f7763d3bd71
change-id: 20250827-mt7996-mlo-ap-capa-a04bcb7e84b5

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


