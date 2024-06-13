Return-Path: <linux-wireless+bounces-8944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7224390625C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8142840A1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77CF12E1C6;
	Thu, 13 Jun 2024 03:03:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9012F581
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247839; cv=none; b=RJHVGCR+cEu/aGNKJ6AKBeQnQr+B7p/fkqyc9KnFWYlc97YG94pUGvJoTyLxK6MTgf4zl4ATrZHxcJz0boTAUfkeWFM5dGc5npnnrIsrKxOzewI/m3lryzFFPS0eLAHwyn5xPD2aK0mn3vNx4g+/qDO4N8vyk912lPNILIW+WVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247839; c=relaxed/simple;
	bh=ABwgBz7zb0tL5nl1OVO16rswOeC2ujA0WmZYzZNo7+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKNIjM5x/xFp+qAIsUjuXUwMAfXcCHZoPBmfjJ/AC6poilZ1w6l+YXsH243blqNRBf3XubpAD8L+hNx0N0Fkpd+qIUfNWiz13PsmayjgTzUtEt0Rnv6SSIiWpkqshqwxiSblFEVW32fjHfIDxuEuoFxbBVxmZFgs2IV9aLAwjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b97f09cde3so43153eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247837; x=1718852637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDdCS5wTSvZ4XBL7ZL9EjuprlNu9A2pnAl8ILdhp1NM=;
        b=bXtFFnVbEN1Qn1k7d6hv57CkEnRzBw0VApcZaiW3DHpOFa9cbzcQuR5QS/7NaN95SC
         mYBjGQDoEqBV4XxAcMk5GyKQfrH2XaxPLVqvL9OmwcGtLszbyNaiMNPnWMx7WZ8GFTGl
         qAweqXNek3aMVJooKgXdsJop9EcyoFT4Z6zKBLi46pDnt35GPJj9e7uhPkGVwfQkiC/v
         AZTDHlmj+QieUcNOQLPIDDDzKSMdT89CJAsPd6XPUB+nXgtuJFETJ+mnvMCKU+JEzfag
         jYYguyV2yzgHth17T3tB6bMQZX4fLpoYkvZnJUI/nMLMqERJ80Rza7zR5U5lG7LQ2K1n
         2Oqg==
X-Forwarded-Encrypted: i=1; AJvYcCX6gOJgtPPipCTuDzG3MdY7H6tPESY53tCoM6uPrV54WgucoUJhyBZSlDozzHsX369Jf5y0bekjjraDH5ve4bmBQmEL1jrcQOK+R8C2J3I=
X-Gm-Message-State: AOJu0YxegYtr8nTqmcQsbtUQdsdACg2lC+NhoTO5VD759FQ3+uI6fBjq
	gBE8mwyCunzZpcfN+QPl5iM1OV+Lx9jhHRqyd0Guu4fBQXFJFJNQxwOeqepj4w0=
X-Google-Smtp-Source: AGHT+IGYteeIl0hbP50uC7mXetKY9ae07NNSA+90LC4OT/5TPcu7XyaM2tMVgvkcaDY43dbLLtudjA==
X-Received: by 2002:a4a:8552:0:b0:5ba:ca86:a025 with SMTP id 006d021491bc7-5bb3b7a9135mr3997317eaf.0.1718247837460;
        Wed, 12 Jun 2024 20:03:57 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:56 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 34/47] wifi: mt76: mt7925: extend mt7925_get_phy_mode_ext for per-link STA
Date: Wed, 12 Jun 2024 20:02:28 -0700
Message-Id: <20240613030241.5771-35-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613030241.5771-1-sean.wang@kernel.org>
References: <20240613030241.5771-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Extend mt7925_get_phy_mode_ext with the per-link STA configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a0fd02dd9551..32ea71128280 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2035,16 +2035,17 @@ int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 
 static u8
 mt7925_get_phy_mode_ext(struct mt76_phy *phy, struct ieee80211_vif *vif,
-			enum nl80211_band band, struct ieee80211_sta *sta)
+			enum nl80211_band band,
+			struct ieee80211_link_sta *link_sta)
 {
 	struct ieee80211_he_6ghz_capa *he_6ghz_capa;
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	__le16 capa = 0;
 	u8 mode = 0;
 
-	if (sta) {
-		he_6ghz_capa = &sta->deflink.he_6ghz_capa;
-		eht_cap = &sta->deflink.eht_cap;
+	if (link_sta) {
+		he_6ghz_capa = &link_sta->he_6ghz_capa;
+		eht_cap = &link_sta->eht_cap;
 	} else {
 		struct ieee80211_supported_band *sband;
 
@@ -2104,7 +2105,8 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 						      mconf->mt76.omac_idx;
 	basic_req->hw_bss_idx = idx;
 
-	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band, sta);
+	basic_req->phymode_ext = mt7925_get_phy_mode_ext(phy, vif, band,
+							 &sta->deflink);
 
 	if (band == NL80211_BAND_2GHZ)
 		basic_req->nonht_basic_phy = cpu_to_le16(PHY_TYPE_ERP_INDEX);
-- 
2.34.1


