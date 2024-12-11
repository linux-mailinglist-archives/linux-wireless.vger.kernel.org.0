Return-Path: <linux-wireless+bounces-16220-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4867F9EC171
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FD2169324
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8633A7346F;
	Wed, 11 Dec 2024 01:20:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0013A265
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880021; cv=none; b=s14p6fab/D9Oqd2IZcgfoDCYozvhlR+c3YTLDv3y7JoOnhNYTcl69Q7vf3ZJ3GOGLdy8CtThJOfawqOH2UW8kVycZCQbFqHX3I4qngGghaNn3ObG7VGGCo3JtvAPqc9JJtjO3arU2p5QsbMd5b3Tx9ovTXCOT0TNkgPzpumlvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880021; c=relaxed/simple;
	bh=lyaVV3yCnlMBmjN18jgHBsblzu4gFx3AJCNAUUj80ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OMmzKoCzG64mEO4fYCGDbXN7uq22KhBvSxZQLCigXs1rL+yAhv04EivRkr/UoIA3BEyZM/ipf2RVUGtVciLdmW5FyAMjvKgXkM/l8zuESH/dDBTl8ccum76l2MOkuZih8zQDw/ckiOCaxQCdvxoAgJN02zTN+3QgDb+0dz3zDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb7934a948so428247b6e.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880019; x=1734484819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvLYpyR5eCI3+Y1o7ii3SvRbYIqhS4yWBFBtNSrsqIo=;
        b=FkKO+Of84UEhQDPFVnc6VQpZsBv1V6XWM6/xg/VgFRgVl5Sw2Hsxmqvpy54qxDKXWt
         SmSjaLHbllvzUbzNMZ08s9lT+kzGJ6aclp3NYRys3LDQic+87qEpmyI/wVPEkd/Uq5yj
         cm0sjBurRNDMo79hzNhe5QZqcvc/p7jB1td8LmVZwhi9/uQv1PTMl9+vEJCfcH5G8Vco
         fIVlnI2pWExMwDdks++ci4FcYSkDtfV9BoQq+NqqJ6wuQSSO3t8pVrwr3aPxf/fSK6zu
         qktHRGJ6DKf8oUFQxPWkdwxyGAtoN4a5uZti34MRVC8qEsOonxrcXAJFAxDAtjlOsYb6
         tEKw==
X-Forwarded-Encrypted: i=1; AJvYcCXjzizRg2dxZzEVpPHmX3PydOCdQK9NSMgEf+bdbboL7LFwaU1eAuwGyMTF5RyNwQWRTWChpIFmgn8Ko4LV1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+WsLResjv56Ive63vjd9HfJOPqEyzTxqF1NY66WGWtu388ac
	9b3qT661CZMLoXeF6TrWWWPfJe2sBvoI+2lQ4ZaWANTi2kdqpq+sz67j5hS8+ck=
X-Gm-Gg: ASbGncsgCGAH4x6RrXtLft4shfGkpz0WB7zSc74UV06CZ/7lxen2apFIRwIJ/AlYYNw
	gvec7K0BkOmX27wXYsOwbmmS4FGrWJkurFIemlKJ9GcTyJLNdhZl1j8TzWZ5bUaOmSL1lWjtRKV
	bLKADdsEi/ffKL3uR3bvKKcTyd934g6cWnDuDZ5vpttNr1WmJZD+KuCD9z3YiC3qHXpDR+ZdkYX
	xcsmKDKaQu3zEGRSIe78MjC0YYb/gUiIoTL2Qsb7OPhX0pnL7uojZfX8kg1T4e+wYjRpf8=
X-Google-Smtp-Source: AGHT+IFvjvpgdG+j02OXVpvjD6zMw/zx1NdUsngbozfn/+B6x1XAX1y4CJhegoGRL3gvUB+sxUc79Q==
X-Received: by 2002:a05:6870:55d2:b0:287:4904:7125 with SMTP id 586e51a60fabf-2a012db0fd6mr678464fac.14.1733880019143;
        Tue, 10 Dec 2024 17:20:19 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:17 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 12/17] wifi: mt76: mt7925: Update mt7925_unassign_vif_chanctx for per-link BSS
Date: Tue, 10 Dec 2024 17:19:21 -0800
Message-Id: <20241211011926.5002-12-sean.wang@kernel.org>
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

Update mt7925_unassign_vif_chanctx to support per-link BSS.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 9e9f33b6a1bb..615d7a370923 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2090,7 +2090,7 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
-			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
+			mt7925_mcu_add_bss_info(&dev->phy, NULL, link_conf,
 						NULL, false);
 	} else {
 		mconf = &mvif->bss_conf;
-- 
2.25.1


