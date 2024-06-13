Return-Path: <linux-wireless+bounces-8925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA1906249
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDDA1C2118F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9412CDAF;
	Thu, 13 Jun 2024 03:03:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577612CD8C
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247802; cv=none; b=azUFhpyJSjZru4Eb68VFuHq+njFmRDAv2PasA0NythNbjsCeLhwAnliZdUfXNkCSbiCVh++MDLZUrKlpdfATEzJSJ2E9jf2jcE85PP9NIM0t1lkUq0B4zYdjY87kMK9/AJ2MhfInV1tYEJ+UEHBpUbV9NdFuqdVUoirAHmcBKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247802; c=relaxed/simple;
	bh=wDB2HxNuR8lyPbH7qqiHcueUkOQrG/lTBmckXlhsShU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBBoIOeVdZw5+Fd14KbEw1+SrC3cONBYBeNfuahtiL2Vw7TmKHCPhJzP7FdnljmSv9rz+rsUi1FlA0ILoS1JzPY8Qt4LasWMHi38GJBsQZLJritdZF8T1UgeU1jdNA1DdFhDK2e2ldJgoERZ0y7NmFPylKaotAlqSv23570/hFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25496e90cf5so70086fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247800; x=1718852600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OvuOb7g6PHWvVqmxVZoF3CYcis25XY+U2z4bDuSQW8=;
        b=WKJ/4dQLEgLmfHKWlpZPripqGfDogpTLb8dG79K7qQPt9B9yKTcWPowEGYU6WvQ0ED
         XtBvZq2iB0m9zmJJnn7iIau+R7mdMEZi0W5Fn02YDTkrGzKml+9gwNdSuNGd4zq6UAtc
         LQG7uhpbCVD0uczHdNLZe9A63kp1I6gCHIGKVQal9F2/R8dV0D4MI7IPpNwweJIFaSQh
         i842OyFn9XuLTmqgAbj+O4Aw0HYYOyNXxgahoz9pmEgTgu1ocioVg4GS9zGHXHyrtSAZ
         oUdsUglE7Foctf//dzLW71UICCUNTsWj+9QtENNRwoqy9JTL/w3XjcCefBEXOcbUk0QZ
         69MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkXmsd5SHoO2mB7PPEvMzXTHi3Wbe0/LF+GBLPpJ01H4IumFYrOlEzWl5mj/7Xt1HjiXTubtab9d7eKWvbVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OGxv6uY45XoTrTKjw1/+kWOkb3nk1VEa/3BYvp4LCkIIDKNi
	SXJJ6nLW/DstlN2Twit/iSYfP7alC298cdEIIlHr3NHb+cUuSEml
X-Google-Smtp-Source: AGHT+IHRrb4EIDm+nWVphSoixLDxx5BWiL1BA/EQfsBEJnVtg8ibFG8+4rJ23JbIbOgSAveW47ZePQ==
X-Received: by 2002:a05:6820:b0b:b0:5ba:c4ed:ee98 with SMTP id 006d021491bc7-5bb3b7a4c51mr3589617eaf.0.1718247800095;
        Wed, 12 Jun 2024 20:03:20 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:18 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 15/47] wifi: mt76: mt7925: remove unused parameters in mt7925_mcu_bss_bmc_tlv
Date: Wed, 12 Jun 2024 20:02:09 -0700
Message-Id: <20240613030241.5771-16-sean.wang@kernel.org>
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

remove unused parameters in mt7925_mcu_bss_bmc_tlv

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 48b157f42db9..797d4c936fec 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2179,8 +2179,7 @@ mt7925_mcu_bss_sec_tlv(struct sk_buff *skb, struct ieee80211_vif *vif)
 static void
 mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 		       struct ieee80211_chanctx_conf *ctx,
-		       struct ieee80211_bss_conf *link_conf,
-			   struct ieee80211_sta *sta)
+		       struct ieee80211_bss_conf *link_conf)
 {
 	struct cfg80211_chan_def *chandef = ctx ? &ctx->def : &phy->mt76->chandef;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
@@ -2336,7 +2335,7 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf->vif);
 
-	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf, sta);
+	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
 	mt7925_mcu_bss_mld_tlv(skb, link_conf, sta);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
-- 
2.34.1


