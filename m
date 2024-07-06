Return-Path: <linux-wireless+bounces-10050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A297F9291EF
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF2283B89
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F77041A94;
	Sat,  6 Jul 2024 08:29:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995A78C60
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254557; cv=none; b=VUTp42l93C+FL1Na3KbPAA1r5E82KhCEg1PagjtV7Dv00FQaEovFGj2GvP/tZ7KNkbuFwNWmMXhcPfghDEXfXyf3vbBojqBzYubvfHAgxL7UJbmw7en/jv+i57r/3xXKZktjISHGfoQjhjkP+jiaWiQ6cnkXejW6rXv8nBbBiao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254557; c=relaxed/simple;
	bh=DbVofvUEe+oTA4THEIEX1zwOZCs5jRqUNUvtmvNbaJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bM6JdZYwaffUXQMgUMQW/SmDBB9w9UcjpYRRdAcR4bVUz4Pll4WkWDnMXm4cBil8Q2zSmiFhKoXDOlBPg4j/CpgSBqFt81Ox/5k65cI6P66iBT6uMccqpp/h7oRL65+eRyz9k0SHjaf1wmgkwDyAb8N0/ivNYLa5Eh5eO/jAsP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-254939503baso94612fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254555; x=1720859355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwoTDp/PU6KVvsRx+iiZe0E2Jl8hFt5E3KQe6+2m5U4=;
        b=qddv8Alt8BD1sXwCatDh/TZbc/gxt1awMbWPRax2RAz6JqR5lx7BnZ2AnhOMJyBjUK
         EFmIwVyS9nvg8ubQK5vw+M4Q/tYEm4yHe0jc0YL+1iVYaEFjMifuP7h6XiGwk+n8RSgh
         U+bqWbXkvNJ5JgKrBlmIb3QexBwcE0mH7xQpp2dnQOmc/+tMGDjb4oie44MShw0aZk1n
         Tg7xRRJrrHM2R+Eow+3UgDuSOl40T3kKfe3D6YTMqjywJzgokw+0ceqU2CFJ7/4udHZ4
         lh4CzkJTzZVr/mT38kj9lp+dznbN1v+FprzzN9BAuHOVB1T1NkACEovc7AnbF34mczPq
         Uh5w==
X-Forwarded-Encrypted: i=1; AJvYcCX79VFo3lLglouuk5gLKFJXhtAjK2I8tmPGDCszwOORd6oiSybgOYoy5F7VnMKyJuliHr20MVLxGPhYhKsA2mDgKtnpbILXj2IrIU12NWk=
X-Gm-Message-State: AOJu0YwxzNMC8vANGHCKfvetdsx7n0DfXvF53h6720PiXnW8K0DXnHol
	ySEgwRfOLcW8VSx9UHLCe9nGFk71H2kAcM2BnOp9X/yq1B1QNgBy
X-Google-Smtp-Source: AGHT+IFTMYR43GUbUUITrkSqP8yZGJMr9ngdJS6LdwW1lPHqmU+a7d3M3ltpxe9UxYBsSyTGUHu0jA==
X-Received: by 2002:a05:6871:24ca:b0:254:ecbd:1815 with SMTP id 586e51a60fabf-25e2bffce48mr6347004fac.5.1720254555137;
        Sat, 06 Jul 2024 01:29:15 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:13 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 31/37] wifi: mt76: mt7925: update mt7925_mcu_sta_rate_ctrl_tlv for MLO
Date: Sat,  6 Jul 2024 01:28:11 -0700
Message-Id: <4f6ca2d082627bb93f79d5a4df80dc08998ee5d2.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Get band information from the per-link BSS.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index e6e57d11daf6..8fc75f9002d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1714,12 +1714,20 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 			     struct ieee80211_link_sta *link_sta)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct cfg80211_chan_def *chandef = &mvif->bss_conf.mt76.ctx->def;
-	enum nl80211_band band = chandef->chan->band;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
 	struct sta_rec_ra_info *ra_info;
+	struct mt792x_bss_conf *mconf;
+	enum nl80211_band band;
 	struct tlv *tlv;
 	u16 supp_rates;
 
+	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
+	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
+				    &link_conf->chanreq.oper;
+	band = chandef->chan->band;
+
 	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_RA, sizeof(*ra_info));
 	ra_info = (struct sta_rec_ra_info *)tlv;
 
-- 
2.25.1


