Return-Path: <linux-wireless+bounces-16210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DB59EC166
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CADC168FF4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AB07346F;
	Wed, 11 Dec 2024 01:19:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE12451D0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879983; cv=none; b=I303Q7kjTIYqrL6ZLt4jurTrqXXTmX+HZCuBYoJOk9uCbQDny3o1OWZkMgO/G6hHFAB/oMseBLF/iwNW9hIy2fdCVeIMmOOhplYCZuZF9uXaEz3VG+kUV2fBp68k992Frigqhic4vnYqtUp3bGWG9p5BE6SHPd9wG2SmIC+fn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879983; c=relaxed/simple;
	bh=HsDP+ktQDnTCTV73AHp2cMqdWdKNB1b2/EmOlwMgjA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qn+Ih++HkH7o1CYBAAPMFz08gRbkVf+p1M7FPisY30SbCe9o9rsWa0QvsnLSjrp5lXyKNTD9ObTCQYAwSo0Py0JKvxOuQL93LtqiPUnWl4O0aIbUZx18f9WM3n8kuZMp32rcegi4a+GhMuIhj8hwCct8VksXHnGSLn89KtdrIRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e5c0c46c3so3195990fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733879981; x=1734484781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAlj/teGsDEq9AqLoVCNv/Q4QETD233FzVs6JHfwoUg=;
        b=ZC1trDGDkrQN/RkMuL7v2Xo2klNSR7aeWJn6ur2JGFCI7cNkxNmwdwImFKPX1ppP7C
         gnoYiH+XoiCzeDgPMhJTGQ4wZd9azdYJ8kG7S6ADDeRzODnhN7LBGRbDrpmF3fpjik0R
         RCmQ2DZ+3blLNTHdYTKfAqZNzj9BLSj2/cDUbyYvr0KhpmFcA57qRARa8yyEJxEKipk8
         5+Nu3oJdINNbkmuXKQlDItUW3Tbbh5l3LCxBhLiqUh5H2cZNn5uNtJwtuxfrT0v9sFkl
         UsKfYALbPBkSq5ig0r/+qeKtQHxKtZTPexkTVgduQKrjiLotxPlLGpc3GDoJotdxT7Ys
         aVGg==
X-Forwarded-Encrypted: i=1; AJvYcCXw4BfivDplrB8b3jQACxiFzPHqJ3sDdZosqu9IANxFPOkdRagzokMybmM1InkmfKSRoNjsJUpjyG1nZ2QbxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KDUIwQSn9uCr1EULKlaUmrXACCdSzxshGXCmnV/3JDEOqai0
	W7v3ZvpZdigPrtYvgIzzXxBMHEuKi4AeF3CMmxr7KZLqddr8w7Yy/TSBGd6g6NI=
X-Gm-Gg: ASbGnctKXS9d7G1ULJkz0Fu+/7TvNWZDAOpf5plLGcCwrtNAcsZvZMlH1FcANwtycZp
	7vc6dt2R8kEhs03JVPq077UqyRiPR+qKjZW0mp3geZhpIBwHNwSVGQEV2vYyY/56l7Nr7BRA8+Z
	Xu40s42AGlWiFoBdugecK1YBx317yVA4r1Nr2DGqXok+wTDVRrmPnHcxaBOYBL6vnA3eGAeKRmd
	QMO4FdTUBLbBa3pROjOcfnDEjaMGG4pZPf+cQv/5A2hrk+1boGhqyD1UOzGuv+x6Nd8dro=
X-Google-Smtp-Source: AGHT+IEKGtkKMDcOAvSZPb9fRrb8ifnKVB5UFdmFjXR1LR7QbnJ19pUR1iRC2SZdihLd7LrZZ/euWA==
X-Received: by 2002:a05:6870:3286:b0:289:2126:6826 with SMTP id 586e51a60fabf-2a012d9ce35mr796668fac.30.1733879981290;
        Tue, 10 Dec 2024 17:19:41 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:19:39 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 02/17] wifi: mt76: mt7925: Fix incorrect MLD address in bss_mld_tlv for MLO support
Date: Tue, 10 Dec 2024 17:19:11 -0800
Message-Id: <20241211011926.5002-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

For this TLV, the address should be set to the MLD address rather than
the link address.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0c2a2337c313..7189d4f6dd4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2463,6 +2463,7 @@ static void
 mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 		       struct ieee80211_bss_conf *link_conf)
 {
+	struct ieee80211_vif *vif = link_conf->vif;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct bss_mld_tlv *mld;
@@ -2483,7 +2484,7 @@ mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
 	mld->eml_enable = !!(link_conf->vif->cfg.eml_cap &
 			     IEEE80211_EML_CAP_EMLSR_SUPP);
 
-	memcpy(mld->mac_addr, link_conf->addr, ETH_ALEN);
+	memcpy(mld->mac_addr, vif->addr, ETH_ALEN);
 }
 
 static void
-- 
2.25.1


