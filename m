Return-Path: <linux-wireless+bounces-16218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38809EC16F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A19188A7EC
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9029670810;
	Wed, 11 Dec 2024 01:20:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D62451D0
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880014; cv=none; b=O14aNSkTab2rKr02vVtkbwWvI19CjBOhQqW9kbWz6YXoqBr3vz6vgY+iKX2dKT6lOuGZQQNUIXlU3N6+5bYG5JArN5xrauhikUcj4f/m/ytUxe+GZH8DGzL1qBWIJxxS7/wM7H5o4I35diKeRa8GO3muIpvTJYzPjOYiHxHUH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880014; c=relaxed/simple;
	bh=Yx9QfPZWzD/XAaCOS2MRiAaAKnxA7XL5d9w+SWB7iwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOXnOa5SWOLfiVHtXPKYMHzXrthyu0d54H6NOTtd4P/FZQ1HEnnbavKtHTep6ObAea/qkNz5v11n28V7nq1v//2nYxQguzCRp9QNDQEi1LYFbXhVV1/nq3rO3iAl9XmTyIp5vX8RnENJjszt4bpTRDHO6fOlwm5snhN6jvCgszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29e7516ee77so3236835fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880012; x=1734484812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV6wsq5yojUFiUHKK/2cJBWsk228RylpQzgVFP9hkUI=;
        b=ZKZUn8nsdbFZk/lyzQJe5GORxd0LZJJ0xHTJ1NfWgUHER0z44gQB7k1mUWRlPC7sht
         z8+ylAszOBMyL1Rzu/e7I373XSI3JmwDSldehkei8ZUuo8738iQ7e1JF0Qn+ICunSZyF
         PlXotIHvYeGPFnpLXOVXzREwLaq+MiYSbJ4XcgFnIIxPQQMSJ3iiIEMh1hcukvKHT3eA
         F7m4Z0Hux6Z4Hni5JQmzdeKsu3ncHAEAf+T2dPwPFV/M1oKCwPcdlVfHz0ETtix6idZ9
         XX53kHedFovFrH0XldF+LQfPZ6YyDJk0hvergyH1OU5XL6XQfczmjVRYFqRKKgXGdThP
         XA7w==
X-Forwarded-Encrypted: i=1; AJvYcCU8xB5Dgq0gcStPNTDhE7dV+Hy4WTDAtyjPYXKFaS/o2SFQyEQP3xnJH3dRGMOFXSn3smks2n6HGUXVX+5k3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9c8JEPsENfUexxwXjImTPsWVQ5GLYSJENf1NjoXGqOuw076qd
	2zo7WqJ5XCcFJAOwcXQCtDy34aw7uQA9K7tTxCfwOltF2mBJSpSV
X-Gm-Gg: ASbGnctRPE+sULer2kOf6krar5MUFR2y9U1UWRFC+TE9Oii7Ui7Vm+lolH3FqpVZZuu
	DQdHbBc2dad4uw0578zcSnLkCV4hyh5KBBjfbOnpwoN6bVwm/PynTEPQbuJIUbrJ6JNZ/+g58bw
	Py2QcuA1GdOFcwJXQLVrozN/tolU5bvExCmyPdTrWSMgbTtZiZR/P+qSsl0BmW+CDqCJIxfZLq8
	6sWQt79uRiyqQrbx31h6hAu1TgXD+9N6WW9s/7+w8NMBKcE4Tzhpk5JAID4nkA1dSpCx8o=
X-Google-Smtp-Source: AGHT+IGqlBfpoRHgY6cQ59RfOO97L29fROSkxpXSP4o/y0JiWpNvhu6DePzNcIePlys5f39S81NDGg==
X-Received: by 2002:a05:6871:e48d:b0:29f:de75:d178 with SMTP id 586e51a60fabf-2a012c541d7mr747405fac.19.1733880012250;
        Tue, 10 Dec 2024 17:20:12 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:10 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 10/17] wifi: mt76: mt7925: Update mt7925_mcu_sta_update for BC in ASSOC state
Date: Tue, 10 Dec 2024 17:19:19 -0800
Message-Id: <20241211011926.5002-10-sean.wang@kernel.org>
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

Update mt7925_mcu_sta_update for broadcast (BC) in the ASSOC state.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d0bfc7711a80..a0df9a4c4b23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1905,7 +1905,11 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
 	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
-	info.newly = link_sta ? state != MT76_STA_INFO_STATE_ASSOC : true;
+
+	if (link_sta)
+		info.newly = state != MT76_STA_INFO_STATE_ASSOC;
+	else
+		info.newly = state == MT76_STA_INFO_STATE_ASSOC ? false : true;
 
 	if (ieee80211_vif_is_mld(vif))
 		err = mt7925_mcu_mlo_sta_cmd(&dev->mphy, &info);
-- 
2.25.1


