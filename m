Return-Path: <linux-wireless+bounces-31304-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG60NHYYe2lCBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31304-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:21:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC48AD708
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3215030580B8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A703783C9;
	Thu, 29 Jan 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7WES9ZF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76E23F26A
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674736; cv=none; b=hzBQtjJA9z1Sy/K6L7aARb3nDEvfzdbXSgukkQQKMcPhVrYokWFC3kG6MenWdoX05tQLnV8XSuP8sL0/yx5xOYaCIbLFwnRVLHxMuCg1wHiEBCgXDdPqKFc0JZDWAOikFXpYU4TaXlkCH5LB4bzahLhLdAolULzReJAFnuRESzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674736; c=relaxed/simple;
	bh=xl3UgJeqbTdzlSajXSm9VOSPzyX9z7hRNR2pLFxKQuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqHsAbadQcKClZP+L1uEJ8RQOtPJ8/6ibAMXHi7KWdtPuSD8iqMD/wp6ITLLN9SfOD6OJNoV/4g4CHtpUP6sPFgHEqMTk8/bmjG8pxRwU9pwoSNUUHTzf12vuitx9KDGqwEt3Dq+JVskOmSC1DtI51CJiXCsvFU4gsIfGzZR8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7WES9ZF; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-124a635476fso976265c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 00:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674733; x=1770279533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKrm2KEh+DPYHiCEU3ivvoqMw474gqaI6xe0hQwvxHI=;
        b=D7WES9ZF158rHXc0DHk0UPnBeXIuiMxh8L3KvuwRbSpWQn7FkROjz9Orr2nU6qiO6v
         e3GGAYZROKzXHcNzge9kV9hQTtxA7SB/BLDNLP2FTYqGrX9VT/nqqtvmFFnKw+fCno8g
         QUrilUAQ2HOsOT7CqZZbDgr+ng+KJToUX1UTZ6LZvSKhE96zPROAq/uCf+52Jeuxc5MR
         w/ww9P2sA4411PZxQu8pPqr6Fp0xjqSECrfyRekFxo0uH1AVNiH6vq3t99GOvzCAaR28
         1slTBY5LoQolyPkobi1u8RbHWZ8eJEOWV78JkjdIQI2m1CJDR9FKKEMmahIxxYU/l65W
         F/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674733; x=1770279533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKrm2KEh+DPYHiCEU3ivvoqMw474gqaI6xe0hQwvxHI=;
        b=dSEyaetOm5Nk2DD2GkwUJLW2fQyNL4q3KR+qGwTl/aPTUFmPBbhYNHm8pevSq4K56z
         lrVaiKEdi3QUfn9VnGUOo3FYtJOfGl/s9gzqciQyyD9IFk5EbNHbYBfFrs1SXH97L0H0
         p8GLVyz9VoFgTq8Nb/IrP+ozIQCg78v86UjwU/oKCsJWHX8MRFfr7bEy9ce7X8v2tbOt
         eJ+xqMHcZEm5h8WkLs0eZgMawTuXG6vJ23gOKKUdw7YeRemvWJ+nQioH18VCdL8HEpHl
         +Bqvk3aEicvTJxUeULvd5f87Jifpize+GTONcCCUI+MbONgwESJ0CxpTmOI4F16ttU9k
         +49w==
X-Forwarded-Encrypted: i=1; AJvYcCUFnFRnsRe4KXXZ1hy9AP/AJXWAdEdb6PD0+ibjCWsw8iDP65Q+7izIAgOch7BGeelx4VIorWqK/eJf3H9vdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX2gCr2cwNej4DaRCpIH7zNd/x6QpFJXwXdyMsFUGF2gk4w7K0
	TfSunj98kPIZCu6S5LnX0cpuIhEB8fNIJ3r2mUjfLyLb7dTl/Hge+4aA
X-Gm-Gg: AZuq6aLdsOS6V8cNeJh4cQF1TjfeUVT+7aHexrjqTm1Iop3E6aEilCMpayAXufyHXkI
	PSPMk+uLb/4IY+pB6Pc6moHP3UCJZAyJO+zIy2YhbGt+k5FVmnwjpQNiKEDLniQESfHT6I1RjS2
	Kj/i4IutnQsddRcanVsMOIvDajcWgBI9B+vVvYgfDeQYiggnGdPyvc0trw6cY6FBGd8uz7Bl/nz
	9pOZI+nkcUfA8b6y9CQ+DyAK535AQioiij+ycZ+y7YgBHomdO9hGHI5gqeiEgmLxnEWvGmcgfU9
	hMjWnidRCawxG1uDJFlHstThcbSltyOgUsNrsi1kd4MA+dqeYFzeHK0Xfy7fcuZPGU5TZ+TAUuK
	PyzHxb8AvT3qHeXSskvLSSoYYUTHP3tlqNbpMErpm4haLVe31TbVgGbWR8Cc1s14PkrYmjMmo3o
	SmR9x75OHmRwR96vXrEsEJxohV+Z2/lnkHNVxB7nuRaVP1Ijf0Voqd3NtEfEbJ
X-Received: by 2002:a05:7022:24a9:b0:122:345:a944 with SMTP id a92af1059eb24-124a00f4ecdmr3632733c88.29.1769674733341;
        Thu, 29 Jan 2026 00:18:53 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efb4casm5483508c88.16.2026.01.29.00.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:18:52 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: nbd@nbd.name
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux@frame.work,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	sean.wang@kernel.org,
	sean.wang@mediatek.com,
	zac@zacbowling.com,
	zbowling@gmail.com
Subject: [PATCH v7 5/6] wifi: mt76: mt7925: add lockdep assertions for mutex verification
Date: Thu, 29 Jan 2026 00:18:38 -0800
Message-ID: <20260129081839.179709-6-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129081839.179709-1-zac@zacbowling.com>
References: <c9b81e89-cd29-44f2-b4e8-0179b2049c21@nbd.name>
 <20260129081839.179709-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31304-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,zacbowling.com,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[zacbowling.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zacbowling.com:mid,zacbowling.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DC48AD708
X-Rspamd-Action: no action

Add lockdep_assert_held() calls to critical MCU functions to help catch
mutex violations during development and debugging. This follows the
pattern used in other mt76 drivers (mt7996, mt7915, mt7615).

Functions with new assertions:
- mt7925_mcu_add_bss_info(): Core BSS configuration MCU command
- mt7925_mcu_sta_update(): Station record update MCU command
- mt7925_mcu_uni_bss_ps(): Power save state MCU command

These functions modify firmware state and must be called with the
device mutex held to prevent race conditions. The lockdep assertions
will trigger warnings at runtime if code paths exist that call these
functions without proper mutex protection.

Also fixes a potential NULL pointer issue in mt7925_mcu_sta_update()
by initializing mlink to NULL and checking it before use.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 1379bf6a26b5..2ed4af282120 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1532,6 +1532,8 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 		},
 	};
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
@@ -2032,13 +2034,15 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt792x_sta *msta;
-	struct mt792x_link_sta *mlink;
+	struct mt792x_link_sta *mlink = NULL;
+
+	lockdep_assert_held(&dev->mt76.mutex);
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
-	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.wcid = (link_sta && mlink) ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
@@ -2840,6 +2844,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.52.0


