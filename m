Return-Path: <linux-wireless+bounces-19784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8367AA4F222
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C85D7A692C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ACD802;
	Wed,  5 Mar 2025 00:09:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66275C147;
	Wed,  5 Mar 2025 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133346; cv=none; b=KtrLTpRjQ5qb1cSe5295/Fz3IxPMzt2Ld27DUaJ1lVy0i5vkWA45f/T/2sU93e5hm/4JRk3ad/cvzE1CyXxXfUwFrzgg+oMImPTvlcYrNoNo/L4WAWcjZOCTX0ix9D7pGXVvEF8THuhFnyD3NbhVYvhrd2dAVpNwuo2dtXS6E0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133346; c=relaxed/simple;
	bh=mGjeON0GpHAqrXkVHjD/yjoxNhvqFdfMmvq3/NeILjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdCCSmR1Z8g2MzfujbucHbCfR8peDg7OvyRjRQXSEuJM5H9Ubms1XE1HvWqhEWPZ/dk5byD5grtrJb06m9rAi62OZQ8dSGeHhdNUGPkPmiYIGVOTnicyCwfzX6G1wnGkbDT1PaM/RAXRu01pBcNivAkfpJvjAsE3tHhvRgYecfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f4d935084aso4717366eaf.2;
        Tue, 04 Mar 2025 16:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133344; x=1741738144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9eJeXiBH2lgfUF9NdCY1XMR3UJufv/lPn99+6l/Nkk=;
        b=nhzqkKS24FNGEf5YuEqNxcA50O5RVn2jZAWKJbOc3FQGHQLlLzUjl1c48LmcVPQqlp
         wU0V1trcx1lvM0BN2fzfGDwDYrfTsU+jiaOiBHVpCIR8a6NSF4tYgA4wAKCgBLEBYHIy
         CZZbGZ/EnhMyWlULcfYVPmqIC0WYA1eDcfIwu05TeQmHtUSbSkrKI98l/5t9BuZXstZJ
         cX5cp6Fq+4xwbY8vWSdnP5o48Qr6FecBwn2BTl3UJrhfCe4fYDulCU9vWl6+1rhH+2HN
         f9Gw6c3IjW8HNsNTNIl2TPTATd+wrcOvY8/T1K86anb9WEXCiHm2fxi5T/eFb7tHWh7I
         aocg==
X-Forwarded-Encrypted: i=1; AJvYcCVJwbkMz0DckmGe0EZMkvrapIpC/p/V61kvDytL2jxQ9vYlldJN219fPXMp8nGBA1iuEOqnR/cZ@vger.kernel.org, AJvYcCX/2myBw+Bc4KCv+xqQKbTJhyg+yvHFL/d4sLzNsO5eYO9AS8DZr1lfQTGqaFI7AIRNVcdHdDzmfMKKwjwE9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyVKOXcHF62M1YGMLhGz9kxK14iSQYj7rFowmUT8j5t0eJxAu
	w2agU7Uk2TLLcsl4JeFOrtvzyQWy8uOgHdeOgUvtPuNCS718nbBk
X-Gm-Gg: ASbGnctnVKAYx28OsJaBmMCsMOVFCwseBI0idrS7hhHeP7uaJi0P4x/5JKrCfCzGV0t
	Mtmxr/jrCBCFKpxB4cz4nzv9Jfl1BrxL74j720FbJaUvGWET5y/8GSef2shJG0vOrA80jfRYjmh
	ux8cYC0lM5VsHIeu2VBTrJOI++AHmVXNm8wc+fo7y48ccDBQGrI3EQXAJyk2esKmjtNMizBziFD
	b6YOZtdmUSot0q6dqC1oFRABOhOQycXlsxsiHGtSb19IPkJ6tw+/6kGUj1TAon1Ffs/QzpQTkJO
	IKn3aU916YRbyxc00OP55MvvmW6FW1AErnn8hiszb2d398zABPVEuF7szhnFZQ==
X-Google-Smtp-Source: AGHT+IEwvVhbQJMEaGdrFKMtOxiiJCKto8VYM3jUlbmpjF3jkBrGvZ4szLZ7/dmzI2XnhwPbqNTrlg==
X-Received: by 2002:a05:6808:1a1b:b0:3f4:af3:74a5 with SMTP id 5614622812f47-3f6831755e7mr500177b6e.21.1741133344379;
        Tue, 04 Mar 2025 16:09:04 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f67ee8f479sm299985b6e.40.2025.03.04.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:09:03 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v5 3/6] wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
Date: Tue,  4 Mar 2025 16:08:48 -0800
Message-Id: <20250305000851.493671-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305000851.493671-1-sean.wang@kernel.org>
References: <20250305000851.493671-1-sean.wang@kernel.org>
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
Cc: stable@vger.kernel.org
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1)  add tested-by tag
v5:
  1) update co-developed-by tag
  2) rebase to wireless.git
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 4f35c2f16d0d..604f771af68e 100644
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


