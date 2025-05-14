Return-Path: <linux-wireless+bounces-22957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B317AB7415
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365997B97ED
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97482882B4;
	Wed, 14 May 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlbePtd9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB1286D5D
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747245869; cv=none; b=aDLEfyJKIRu4SNXl8GiP/XRv7ePO8uaVV41raK62NMmegyRD5Dk0WvPeJ/LuZiOJI/S/NmvKKbC9ZfUw1Op7ZnzWo1QV2iDE4svD8yjwG7nkt76neR3Q/KXOz8y6X111MAOCHIDYG0bl5ZbbyiGbCsU9QO4prkrT3l4czOUOvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747245869; c=relaxed/simple;
	bh=SADZB/Y0ZUGzDYNONLDwaoThwP2m+chanBYUOlrK06w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp73phSvFCQXmYhqV+eQdN78P0O9pXgR5ufce3769hOjtzzTlY+D8Dh3yIHmr3ST56QO/keGedTlfVWLiKO5MVECzDTNH45zASk/W7If2cekS33RxJaOXo2/72C9UTyak1NsV19yKke8MBzTnP8WxFpbAEeXEfsVB16uexGoGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlbePtd9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso9245499e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747245866; x=1747850666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDMBMzADKKox9GCPdKLJeFeagPfYA7vA7jUG9nBpmzs=;
        b=GlbePtd9hAdRPtSmXEqo4pD4jSVWPkAQReRZUCuaZlEPQwWwIHhym01WXzawwUaU60
         vUYjHGNVBEWP4a6j8V2K699z2KL64WhJ1RMS53HO/d/Auj52Z7pocSdWNLMr+iqjdsNe
         wRLXimBMvnLv2FDHTWI7cJxGNWrsTL/PNBrel0Syv8RIx7jKOBcAKqp0laN+bzEkcGQL
         DVteAEgQ8eDUqsORJBUqvtLDNafZWq3zs2TvKuOsfilsvQ/YOHOVyPaEja78YMMmTgkE
         gzYH4+yrLFXZKd/vBCSbIvxgPmc8c7BGEoq0DjmbQxDgHlrBo8vS7Wojm91mNnPQvGnT
         wJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747245866; x=1747850666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDMBMzADKKox9GCPdKLJeFeagPfYA7vA7jUG9nBpmzs=;
        b=mjIcHtGV3cjdY4oBmf7ydSsvFKw5OVzT2k9CqOoKRr9aesSZ5twxz3JWonx/hWNv+c
         KsBDYxt/e31nnAAJJVqsuVC9aN3LC3VncfEYEZ31mkEAdv67HCDRLJOknO6fZMmP6JR2
         TaTDjwRQ91KqhB/H1pWzbkD5JamoIlzdEZ1XgJAJ520gb6pAw8pmyRhvD1HpRNWuGtC+
         A+JOSJAE7RokmDPGr0jOwEK2UwjQWTFIXIm+DNPCiu0iaDCh/JEiVy37c6nFEWDbnbxi
         zxWngzAFcKoFEcS0GALfEnZvoNf3nKof8UT3PeMSGRUeN5qCRrpQvwdV1muTGxp8Nq5r
         uXuA==
X-Gm-Message-State: AOJu0Ywci789snONFDXzRe36tGbUFOhj7a+G2YGTmIuJJOrooQGPOy6f
	czOgjbSf3yHJXEugH5xalTzNcuFk38FowKvQLPWf2apU9jSe3jZr2GnTynJb
X-Gm-Gg: ASbGnctgLnnQfT2TkIOmAbFl4vH3shcsD1wtfjpb/zXx8+Q69XggNJqNUhnfT3hn+eL
	D+0I96kA5/uit2rof/4E8XldUAnas0nMLQLNtRPFZTJw7Yiv3C2Bo86ziiiKnWc78eKse9T5D9W
	KeX9krcAcKT28ktmep9VLGBDXPpS0tmPZD6yKOiuSGM4MkyFutVjjq0+6bQoio2nxBWT8u6PZz5
	TRl7/3F7HBAA3bGROR4Y11vZnrXhd9LFVW+ql/qEEgK1NB7AleyWKcVLghAo0kHW0pKaMvVS6fZ
	tOGivAK8FII7bZT8QSi13tPIAFZ+ru9RKr4sczHo+CrG5M+ILYA=
X-Google-Smtp-Source: AGHT+IEYBoqgrSwvWHb+YgcPKOmMGVbRZLiZU2RTXD/Nl5lkkZWIJe3Gs4Aj4TjySteHQUFOm7SDfg==
X-Received: by 2002:a05:6512:e86:b0:549:7d6d:3db5 with SMTP id 2adb3069b0e04-550d5fadbafmr1662302e87.25.1747245865540;
        Wed, 14 May 2025 11:04:25 -0700 (PDT)
Received: from hobontica.lan ([192.162.197.131])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64bfd8asm2335644e87.199.2025.05.14.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 11:04:25 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
X-Google-Original-From: Oleksiy Protas <elfy@ecognize.me>
To: elfy.ua@gmail.com
Cc: linux-wireless@vger.kernel.org,
	Oleksiy Protas <elfy@ecognize.me>
Subject: [PATCH] ath9k: keep ANI in monitor mode
Date: Wed, 14 May 2025 21:04:13 +0300
Message-ID: <20250514180413.373876-2-elfy@ecognize.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250514180413.373876-1-elfy@ecognize.me>
References: <CACC_pfLYxUXPTAo0P9aqeP-xKAMdGsAckg_=j0HO6fRf7rNxoA@mail.gmail.com>
 <20250514180413.373876-1-elfy@ecognize.me>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier changes that made is_monitoring a separate flag as opposed to setting the opmode caused AMI to never start when monitoring
---
 drivers/net/wireless/ath/ath9k/link.c | 2 +-
 drivers/net/wireless/ath/ath9k/main.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
index 9d84003db800..cd2ead7b2883 100644
--- a/drivers/net/wireless/ath/ath9k/link.c
+++ b/drivers/net/wireless/ath/ath9k/link.c
@@ -468,7 +468,7 @@ void ath_check_ani(struct ath_softc *sc)
 			if (!test_bit(ATH_OP_PRIM_STA_VIF, &common->op_flags))
 				goto stop_ani;
 		}
-	} else if (ah->opmode == NL80211_IFTYPE_STATION) {
+	} else if (ah->opmode == NL80211_IFTYPE_STATION && !ah->is_monitoring) {
 		if (!test_bit(ATH_OP_PRIM_STA_VIF, &common->op_flags))
 			goto stop_ani;
 	}
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index aa271b82875e..2685aeecffad 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -1530,6 +1530,7 @@ static int ath9k_config(struct ieee80211_hw *hw, u32 changed)
 		if (conf->flags & IEEE80211_CONF_MONITOR) {
 			ath_dbg(common, CONFIG, "Monitor mode is enabled\n");
 			sc->sc_ah->is_monitoring = true;
+			ath_check_ani(sc);
 		} else {
 			ath_dbg(common, CONFIG, "Monitor mode is disabled\n");
 			sc->sc_ah->is_monitoring = false;
-- 
2.41.0


