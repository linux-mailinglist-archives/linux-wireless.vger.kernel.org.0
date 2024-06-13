Return-Path: <linux-wireless+bounces-8921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7F4906245
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7782C1C214D5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083B18028;
	Thu, 13 Jun 2024 03:03:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1018212D1F6
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247793; cv=none; b=Bsmh+5CRX5CN1zkgJg22JQBX59xZNrNGwQGb79Kqqn4lCfKKrEgCTKAlUwOtHeS2vaGRN1YuyGS1le6LfmXrn3i2h2kxfc3/6BgPpZ4cgD3vqlx32IzdLDbsxDDZH3vtrj09ASHWnxppe1b/PGixpWZRStCtdqDeTk2en1R0Ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247793; c=relaxed/simple;
	bh=IXqV1O3S4gEuJh566HxUR76On4HvwLVKlwCuBwwUXBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vg86RvY/gjAevut+PRGyFPdb2IZkmQwattb1byBDgEUSU4JxMnNe1K6ZRlFZXS9yUY/8N2VF7Qtd4Sr/fwNObjV7ayR7wiNJB2olaX/h5VeAF4x3nlz49BPYVSNPW+IkL5wklYzLqsEDlDbOWjs7OoCQVDtHrYaWJURdLdI99H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5bad97708efso31430eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247791; x=1718852591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQHpQNEsytBYs2FLiCmUpTPqTQTP3NJD/MKbmAcXuJk=;
        b=d3zjlhinyL1I0kDp0SpNb1pX3U/xgWfgwwc02N43yhmE8iucwvLHFvREQchLCShEPj
         GAz2nsE0AsjMx9/udHug1SoL02W7mrv0UqtenXmhbyxvdY1xWzsA85bQGfxUdddQrccF
         SYA28mWeSooNBVJLPDLU3ZbaMdIJDR658Hld6g+VWRVN7R34Ux4OYnpnSEsn4ZTIFe2p
         2/bkGCGQRMB8ABq6H5m+jKIzR+2wjWvoJTwVCku09PJGHnu3dkqx9RRVsSmS06mdoVkK
         EUh8GxLjVdZMNwb1kj6GmsLcYHg39YDBflZpaIIBobxPz7B/qte2ko6dZW8Z59mWbE7w
         iqsg==
X-Forwarded-Encrypted: i=1; AJvYcCXhiLgw8fZmV/n4mn+fwAEs5xxJXjTsOo0x7Q/NtDMXBF4Z9IYCDorQYml0j8izki+CDSJdg/XANySW19HWdO06Zy4S7d9ev4kuU5SqmSk=
X-Gm-Message-State: AOJu0YwhTxEBxAzLCiDTINcSdMj3Qh4qqoQJmOS17uBySSFFz3uT0vQT
	SAQraxQj/VJSzrSoE8ikj6Fi+DzBNbmZm4ui2/Q38EQmz0pRmI7o
X-Google-Smtp-Source: AGHT+IHRYjNKPC2FOi2+KaQtr+N2oUkVlnnJ0LtIy99g1YcK7m+ehh3yibeBWAa97dm0X9RUmo3A4w==
X-Received: by 2002:a4a:a5ca:0:b0:5ba:e11d:a2ae with SMTP id 006d021491bc7-5bb3b9f4ef7mr3671269eaf.1.1718247790954;
        Wed, 12 Jun 2024 20:03:10 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:09 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 11/47] wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv for per-link BSS
Date: Wed, 12 Jun 2024 20:02:05 -0700
Message-Id: <20240613030241.5771-12-sean.wang@kernel.org>
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

Extend mt7925_mcu_bss_he_tlv with per-link BSS configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 10e38637eb83..533214403008 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2238,7 +2238,7 @@ mt7925_mcu_bss_qos_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 }
 
 static void
-mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
+mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_bss_conf *link_conf,
 		      struct mt792x_phy *phy)
 {
 #define DEFAULT_HE_PE_DURATION		4
@@ -2247,16 +2247,16 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	struct bss_info_uni_he *he;
 	struct tlv *tlv;
 
-	cap = mt76_connac_get_he_phy_cap(phy->mt76, vif);
+	cap = mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof(*he));
 
 	he = (struct bss_info_uni_he *)tlv;
-	he->he_pe_duration = vif->bss_conf.htc_trig_based_pkt_ext;
+	he->he_pe_duration = link_conf->htc_trig_based_pkt_ext;
 	if (!he->he_pe_duration)
 		he->he_pe_duration = DEFAULT_HE_PE_DURATION;
 
-	he->he_rts_thres = cpu_to_le16(vif->bss_conf.frame_time_rts_th);
+	he->he_rts_thres = cpu_to_le16(link_conf->frame_time_rts_th);
 	if (!he->he_rts_thres)
 		he->he_rts_thres = cpu_to_le16(DEFAULT_HE_DURATION_RTS_THRES);
 
@@ -2341,7 +2341,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	if (link_conf->he_support) {
-		mt7925_mcu_bss_he_tlv(skb, link_conf->vif, phy);
+		mt7925_mcu_bss_he_tlv(skb, link_conf, phy);
 		mt7925_mcu_bss_color_tlv(skb, link_conf, enable);
 	}
 
-- 
2.34.1


