Return-Path: <linux-wireless+bounces-17465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BD4A0FE76
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 03:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EACE3A314D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83C8493;
	Tue, 14 Jan 2025 02:07:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13C23027B
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736820445; cv=none; b=UnatPpkBeOkigSvprqHc/zk6sYFg9sxoouUjsSFTgT9KMGKFEsMmvBTE2zxvqAnmm0hNwEuCZkkedn0oajomajLhMKQr3N5eNXsfugYUYd//qrXsmDXYEjUFsqR61L8hbk6jqC/ngtf0oQiWIx/uuVfXmaaGhiC+aJp/pI2pdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736820445; c=relaxed/simple;
	bh=BSiD8J3/07M6inAA3u7hhZVU23gPRakjlGdFrK4/h7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxyBIrPNRC7gSCiDb/LAJXIGnxJ/wZhseOmoB6tY87S8orVzTqZg+pWfZgIB2st4uAj35oO/qv/48ipCivY2tkiFJwZ8tCmccxhBjn0J30EFcEbQTqpGfpEp/Zf0kihwPvTMOH7opWPbVFy5rG8n9rhYMt78ePwcNsxOyG2iBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e17de2816so2495505a34.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 18:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736820443; x=1737425243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TA4T2KfU8+8ccT6HhlEqhwR53p9U01ROTAG7I7Ipyeg=;
        b=moHm7WU7rxfvtEJzD4sKLkBLJxzLClQuTtEDvAGv0u6881F4VyXbhrvY9yRp5wC+Wj
         BSZoCZgfU+v0lXvweY3JRN5KNUKCOXLYr7pszaWKhUNa0u+8C9m284i33aGoKuVeuLvR
         CqvDGxI0eBJBlL6B5sS/GdZuu/gw1/h3fARqE5wiJGMKZ/NMsDvaOyL73izZYzRmTaCI
         P+mWPnGtz902i4vOyktNTrHU80FzfUrWHjY9UmunQUppQbsVzpcqlb93h1e6QmMJlS5+
         ouSlJNf1NPFaIKKNDdy7nNjqmESGnXm5RpdABO+heIn2m9Sew6Z3nVPiiLTzJ1sB/S/Q
         1wIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0q74KoVqt3ykiR/BEUbprDcBFfK1RkQ2rSHKOn1kkK8cEOWiYGNsiap+9POpQetScOrA5Oq/8tPIzM+oHBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwInlKGixuqSZhLIHu1K030NoCCXxxMTe8Gc1uCb6Cv7VzgieaO
	GNC7DfnU3wXfZca1WDreIbBzIxNLGJxN7CnPeHuH6iJE30z4fkXhoDH9kMkr
X-Gm-Gg: ASbGncuKPwjF7+s1k44/7GlK4ukrqpsUEkJypq2y35YD4QKfVGQInwm2fTEu8Ir4yqM
	WbFmxG9E4yPC+l0TNze6K1+44Hr3Q8FW+SMvuOnxqogef810fGDh9apqd8g3vj5U6ky2msfIPva
	2cJ8yFovBYvXJly45z0n7t9I7/zomGNy0QWZH4rZ2jKgF4fSfFmkgmOmFUHPbC1Wu6bA5uBgvyj
	N49BeuZ4X8tmaK7bFNURgRbYT8hvor6paDoPi4IRQz60gLU/pDqfxKuFix5sDfNKdizAfaNrQ==
X-Google-Smtp-Source: AGHT+IGFJEik2Ut15igezSRRJrQUvQBJOtShMMBcJALZhBQ9x7GaTRWakkwrOGbF5TScoAJnl3VflQ==
X-Received: by 2002:a05:6830:3748:b0:71e:1b44:35c5 with SMTP id 46e09a7af769-721e2e7966bmr15611503a34.18.1736820443561;
        Mon, 13 Jan 2025 18:07:23 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882755172sm3915340eaf.27.2025.01.13.18.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 18:07:22 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 3/6] wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
Date: Mon, 13 Jan 2025 18:07:09 -0800
Message-Id: <20250114020712.704254-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114020712.704254-1-sean.wang@kernel.org>
References: <20250114020712.704254-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

The mt7925 chip is only support a single radio, so the maximum
number of simultaneous should be 0.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: generate the patch based on the latest mt76 tree
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 502b76a40ca8..90a6d62aa816 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -256,7 +256,7 @@ int mt7925_init_mlo_caps(struct mt792x_phy *phy)
 
 	ext_capab[0].eml_capabilities = phy->eml_cap;
 	ext_capab[0].mld_capa_and_ops =
-		u16_encode_bits(1, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
+		u16_encode_bits(0, IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS);
 
 	wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
 	wiphy->iftype_ext_capab = ext_capab;
-- 
2.25.1


