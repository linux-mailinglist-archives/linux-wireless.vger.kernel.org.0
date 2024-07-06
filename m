Return-Path: <linux-wireless+bounces-10022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22719291D3
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8C0B21C27
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764841CAB3;
	Sat,  6 Jul 2024 08:28:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC449658
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254508; cv=none; b=Vw+3y6SpuZvaNa86hG5NiHIAHh2CvDH2kWXxcUcqt3IpE4Q/8F7Mi5ns6HDjGs+wYIVtfl/lFkFJ/bEIrC4vWKt6ATesRxKqVPumAUO84tJ3v8JOXwplBeHTqgDLgwGCoL4tlbI7ZlG7n1DWKfcDpMp+dVvtR5s++loDagI5gDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254508; c=relaxed/simple;
	bh=0/EHT0weM0KUHhhI/ZXrNqh4jcEc/p3jEqnHPNc6SLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNbHPML5nx8k3lCH6HngZBZttWmjiDtxJA0xBmeB7ptQaWooIKkZPLMH9449VSYNCx5cFiKN/ct7dYLjDljWHa9nHTgNgA6X4h6ARqv7yCKs7fQNCvzOL0Zw/musdt8XBod2rLostk7yEcUnIh2z5wawozflAgoZM9+5RmdaGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-254925e6472so364153fac.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254506; x=1720859306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNQtKh9bModTpWH38BJ8Wnv4gv4BE649XF4YBalyJck=;
        b=tae+MyzqrvV+RK4NKIusjCSnYjxvmKtdVECvmjsQZZlLIvKcLYsgSS0wCUUXHsH9iK
         jIPCwaH/FxJrOxkVNHQS2uQC+Q/HvpOmVud8sfBUZEiIolsCqsDdJyaZagl44yUhTREn
         af6C1H/tqO4cJbBM/xdtpgxm5C2I4avMMXrA1/DsReRdR2auPPBHPZtnXA3e9OsuuxLT
         0Tmo3QQeNvrKT1MSf2DwEVFSIZeWiys/c/ERfLYatDkSuBjdvldSawfcb9NCnVlIqzub
         oHvBhE2NjFkNiY3wRK6zc2oHyvRnhjRn9WTiDRc3+j+rOuEJA7CNuTjRLvu93LkIN2MD
         +DBA==
X-Forwarded-Encrypted: i=1; AJvYcCWKiEHTsevujNgI0bfXoNTbHDl1HUjo2kUYyUMUgEYUEYVrtysv88RDmmWnIIFXGoZDQX7I47eP6VGVHNJXj+jYSSIdlE0zrNLS1m8GbK8=
X-Gm-Message-State: AOJu0Yz01hW+Z6+uABEqexemAyAuds2DK7FTZ41wvtiawwG9Iz+6xr6C
	3GmVZRTkgOPDMyKb7jSLwtl6VzoH04wvWyxwSIrMewhmh2lvgHnn
X-Google-Smtp-Source: AGHT+IHN1M66NzqNwtknjegs1rT75zTFpJEy7wrGI7ifp6dtVEt/+v1/Wwqi9urwSqufR1oHldYTvA==
X-Received: by 2002:a05:6870:5590:b0:25e:1817:e4a8 with SMTP id 586e51a60fabf-25e2bf93ebcmr7013302fac.4.1720254505963;
        Sat, 06 Jul 2024 01:28:25 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:24 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 03/37] wifi: mt76: mt7925: set Tx queue parameters according to link id
Date: Sat,  6 Jul 2024 01:27:43 -0700
Message-Id: <84a401891b8942f66d1ffbd0a3f10866c94d1bc0.1720248331.git.sean.wang@kernel.org>
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

Configure TX queue parameters according to link id.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index a043d93f3e1d..da70c203d618 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1306,6 +1306,7 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_vif_to_link(mvif, link_id);
 	static const u8 mq_to_aci[] = {
 		    [IEEE80211_AC_VO] = 3,
 		    [IEEE80211_AC_VI] = 2,
@@ -1314,7 +1315,7 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	};
 
 	/* firmware uses access class index */
-	mvif->bss_conf.queue_params[mq_to_aci[queue]] = *params;
+	mconf->queue_params[mq_to_aci[queue]] = *params;
 
 	return 0;
 }
-- 
2.25.1


