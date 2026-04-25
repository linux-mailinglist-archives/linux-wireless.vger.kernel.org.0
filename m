Return-Path: <linux-wireless+bounces-35314-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOY3GmMb7WnefQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35314-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:52:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C97B8467952
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B84230060BE
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924E30B509;
	Sat, 25 Apr 2026 19:51:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B0309DCF
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777146712; cv=none; b=OOWEAE/sVtGY8ex2YzyRF7QycW7BVOtMTud6LVudQ31GiDFlTBYRVsv4vUahV1dJOUbRorsGuxIMxTobzgAeTuJVPFu+HUDzVCcHCk5gD8URukakNRvbp8uGLtNbfLhSPjU5GAQCFZqJ7QnaqMU06x2IYV4WOSW/h6UUX7oiN5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777146712; c=relaxed/simple;
	bh=s5cqyrQpqA9oVCpDyD/OSjasXKOziHjJcWwh6CPaQfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHvblIWZriSgiRRA9gVflVoK1IJS8KC/qoFHmsd5iUtbMkeylKMDPw3yZzDzoHoI+cCLPp5ySmKSSWXZUUkjPlYjNgcsBc6OdZqXHgNtXBz+X4yvMU2/wLwX7UiLrT7Bupv4AM7zbnaNC+9AgG9mMi7Fg6DuojXglA3fic8EHVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcd689829eso4833980a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777146710; x=1777751510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2I/zvY2t9IYaNU/vQ8uoOUMW08eUe9EXXH2bArv0tJA=;
        b=BMi+Ycwn4LHwOmwHhXNS4CNuO51ENrVKwjl33/VNfi/dax1A4p5n2nx/5NkMLuR9w7
         iXFsKmmk6uHSQU0poV69pHfAzpkJ+OFbCIBXJeMobKPpfV+Smkqj25qw8Ld1zXF9Y/oD
         4sY7zh1JqR0s99RNbJMrt8nDYxoBR99ZEzPS99kpzvquVWaupVorZvzq0+eypg0Pd5Y+
         aILBR+1P58ahxlZjicIYOLP5qvhkxSGqQzn+i14gYqrp23oNpdN2z3pYZhys6jEbx55q
         lTrlSr23OiI/7S2DsXmSr8nU6dXPfZq9DJtdBpCgr6HZjB1ruuv8aB9ifKvX54sBCrD5
         21mQ==
X-Gm-Message-State: AOJu0YzrGyo9lcQe0ojFc/m5f/sX8LOgTpBjwVl9QTjomK93gdFCKun5
	GvqzOJUsGOlVXSuveLUdGnh5RlfT384E+286I2eyKBaX3nb4oGbDFt9k
X-Gm-Gg: AeBDiesfoARzVpD08IGFzp3YWjdL4dduOu0soVKeQrIddbJADVVLJg6BTzTe2NzvOpz
	AJBviL+sY63j3WM6u4+P9erakTsQCyvMcjKckXDPEkg9XK6XlyvyrPhmY9HGkJwqWsKqV8X4+H+
	E62gZnSxp0630gZ259pr5tVR9j/6E5gTBAUj/thJrf8eWKeEVfWMuHUM+/OLsbsw0jlUYyXnMHH
	pndxVJ8RuVGWJlFiJuE4GopcYgFRJS7K4LfWGODum2KSK+hUYG31OLms1l4CT3LqZLSI+ZdVKHh
	cR8jyl1cs1qKTJPda7G7M3FMlML8wgile9/9ybSahETL9+JRj7yK+b3YfhoEIm3IZxNLKM3Br8b
	wgcNdJK0oiibS3lnWikUuW7A/Q73B/Nkjl2UqzzupvaYMx9krAHiAU89B4NMYSigWtBO7vWJjEd
	9KxsHjCfMpC3al9uedOlOC24K01pCnTyjoROgDsMbemPoGtXN5HnWr/ctKJk66vTsX9SDFD18qE
	Q==
X-Received: by 2002:a05:6830:4ac6:b0:7dc:d967:63de with SMTP id 46e09a7af769-7dcd96766c6mr13718331a34.3.1777146710088;
        Sat, 25 Apr 2026 12:51:50 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:2e29:c3c3:de27:ce76])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd164d2c3sm13987624a34.24.2026.04.25.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 12:51:49 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Javier Tia <floss@jetm.me>
Subject: [PATCH v5 17/21] wifi: mt76: mt7925: sync MT7927 BSS band assignment
Date: Sat, 25 Apr 2026 14:50:07 -0500
Message-ID: <20260425195011.790265-18-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425195011.790265-1-sean.wang@kernel.org>
References: <20260425195011.790265-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C97B8467952
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35314-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[]

From: Sean Wang <sean.wang@mediatek.com>

MT7927 needs DBDC enabled and uses a fixed firmware band assignment for
2.4GHz and 5/6GHz BSS contexts.

Reprogram the STA dev context when the channel context is assigned so the
firmware sees the updated band_idx before the BSS is used. This avoids
stale band programming after band changes.

Co-developed-by: Javier Tia <floss@jetm.me>
Signed-off-by: Javier Tia <floss@jetm.me>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/init.c  |  9 ++++
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 42 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  1 +
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 12 ++++++
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  7 ++++
 5 files changed, 71 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index a8c2ca7c0efc..e85b0d104fbe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -117,6 +117,15 @@ static int __mt7925_init_hardware(struct mt792x_dev *dev)
 	if (ret)
 		goto out;
 
+	if (is_mt7927(&dev->mt76)) {
+		ret = mt7925_mcu_set_dbdc(&dev->mphy, true);
+		if (ret) {
+			dev_warn(dev->mt76.dev,
+				 "MT7927 DBDC enable failed: %d\n", ret);
+			ret = 0;
+		}
+	}
+
 out:
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 044043a8768d..b36f5eb30371 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -396,6 +396,18 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 	mconf->mt76.omac_idx = ieee80211_vif_is_mld(vif) ?
 			       0 : mconf->mt76.idx;
 	mconf->mt76.band_idx = 0xff;
+
+	if (is_mt7927(&dev->mt76)) {
+		struct ieee80211_channel *chan = NULL;
+
+		if (link_conf->chanreq.oper.chan)
+			chan = link_conf->chanreq.oper.chan;
+		else if (mvif->phy->mt76->chandef.chan)
+			chan = mvif->phy->mt76->chandef.chan;
+
+		mconf->mt76.band_idx = mt7927_band_idx(chan->band);
+	}
+
 	mconf->mt76.wmm_idx = ieee80211_vif_is_mld(vif) ?
 			      0 : mconf->mt76.idx % MT76_CONNAC_MAX_WMM_SETS;
 	mconf->mt76.link_idx = hweight16(mvif->valid_links);
@@ -2238,6 +2250,29 @@ mt7925_change_sta_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return err;
 }
 
+static int
+mt7927_reconfig_band(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+		     struct ieee80211_bss_conf *link_conf,
+		     struct mt792x_bss_conf *mconf,
+		     u8 band_idx)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_link_sta *mlink = &mvif->sta.deflink;
+	int ret;
+
+	ret = mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf,
+					  &mconf->mt76, &mlink->wcid,
+					  false);
+	if (ret)
+		return ret;
+
+	mconf->mt76.band_idx = band_idx;
+
+	return mt76_connac_mcu_uni_add_dev(&dev->mphy, link_conf,
+					   &mconf->mt76, &mlink->wcid,
+					   true);
+}
+
 static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *link_conf,
@@ -2248,6 +2283,7 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct ieee80211_bss_conf *pri_link_conf;
 	struct mt792x_bss_conf *mconf;
+	u8 band_idx;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -2261,6 +2297,12 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 						NULL, true);
 	} else {
 		mconf = &mvif->bss_conf;
+
+		if (is_mt7927(&dev->mt76)) {
+			band_idx = mt7927_band_idx(ctx->def.chan->band);
+
+			mt7927_reconfig_band(dev, vif, link_conf, mconf, band_idx);
+		}
 	}
 
 	mconf->mt76.ctx = ctx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index b338d6bf02f5..f7e14cc53dac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2918,6 +2918,7 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mt7925_mcu_set_dbdc);
 
 static void
 mt7925_mcu_build_scan_ie_tlv(struct mt76_dev *mdev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 984be40ca76d..242f83f90dd4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -252,6 +252,18 @@ struct mt7925_txpwr {
 	s8 eht996x3_484[16][2];
 };
 
+static inline u8 mt7927_band_idx(enum nl80211_band band)
+{
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		return 0;
+	case NL80211_BAND_5GHZ:
+	case NL80211_BAND_6GHZ:
+	default:
+		return 1;
+	}
+}
+
 extern const struct ieee80211_ops mt7925_ops;
 
 int __mt7925_start(struct mt792x_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 1626a3684082..97683949a305 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -3,6 +3,7 @@
 
 #include "mt7925.h"
 #include "../dma.h"
+#include "mcu.h"
 #include "mac.h"
 
 int mt7925e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
@@ -144,6 +145,12 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 	if (err)
 		goto out;
 
+	if (is_mt7927(&dev->mt76)) {
+		err = mt7925_mcu_set_dbdc(&dev->mphy, true);
+		if (err)
+			goto out;
+	}
+
 	err = __mt7925_start(&dev->phy);
 out:
 	clear_bit(MT76_RESET, &dev->mphy.state);
-- 
2.43.0


