Return-Path: <linux-wireless+bounces-13343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0730998B09C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 01:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9081C20C76
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 23:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00647185B6D;
	Mon, 30 Sep 2024 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn1sDkq6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4D183CA4;
	Mon, 30 Sep 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727737469; cv=none; b=gY0PVIEvCGEnCyz/vtR3BmW//efHpkYWEW0bPzTaK3NIdWIJIK0+9yM/jpUJU5tu254BsBFGKtqHvT+EAuasbpm5qOEBcKfsh8BLNKkWedy+WcmA/YmDRQdhw1MkLSlvbMiEOXCYKwSPSv2JD5CFIcPK2zVY5c/rf5D6dJNWQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727737469; c=relaxed/simple;
	bh=4fjdky3a+S89PjSlrNCpJAC/zNwralELZJ91gon/LTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXKawocsVESgDCerUMeheZQrni0nlsH5y8eqNa+Tpl/Ht/t7x6SQt0KUT+ZawsFs9jQMByTfsWl0kr+hRqw8Dp8rXTkqpDdW3/rnimmncwsHDtFI5xJfalZyGuS52g6xTCQlTokF73fKNS/aDUBXnujSZIuGC0kkFP5Bh0l2NfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn1sDkq6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7191fb54147so3542795b3a.2;
        Mon, 30 Sep 2024 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727737468; x=1728342268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyzaDyrsFt+RV9znRkbYukdtozGtLZAtKdcYpeCwWBg=;
        b=fn1sDkq6UYi/b224Ye9QWFeNoGflwzYkgbwgJ8E1bgZaZo0faOmQ9wPwHFDVSxc2DK
         GxPWtqaHsIp3X8OUIlte84rUvoW+2e17x7NFI86GizlvFM+hxhFhd6iozcriTKYkFHzo
         26Oh+iF4bQ3uZp2UWPO/0IM4vuA7DyHap6CoEvz7nGIU4F3PVn1PanUfsHwwe1moL9Ax
         odZ79HNvzG2T8SkLzf6pEDYwUSHq8I7w7dypV39ovPG73AHDS9idZMwYWFtwjnRN5o72
         5WbzrRLsVrMz0vvese5xkLCb8Q7gUGqlFD66X/PJIly4tr7QC1CVK/Oq+yhp07yJcG9/
         b4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727737468; x=1728342268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyzaDyrsFt+RV9znRkbYukdtozGtLZAtKdcYpeCwWBg=;
        b=MJLOn+qa/SOOZW+M1SaGNPIE7AhosK8DwhqyOF3BSW2HqSB2+kFz57uDd6NuCHOlNB
         LHBDzFM8xF2wbOpBXaLJdeJBiTgO0JoXCL/HuGBPZVIx3kAirL6SuGhzI1rB+ciiEQdy
         +h+Fy84bXNHqpCzpHCykkyJJxNhg186NcKR4cN8CsHyYAM3sYwhTg4MIsvhau27zuRqL
         wxBdeaAonu4c1ysULkhUu5KxdSt4MoVlUub4eTE7eaJ8nq57n07iBiW3hD7Gd9LWsdn8
         9ti7XYUQSXPrPEhK1EyGFIIMa2eg7WIg6mKFj9YZmV3GZSFyPfJmqNNxhpeoePR/F/xS
         LwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUitqLjQsW+v3SC2tS4neyhNXNtYEEGIF/Wop7iHMdFLWxzM2OyjXWTWk0eun5CqNgzRF4eg9ara3fdjIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQDCtqY7Br9xW59AFCVdZZgPfM354sZUSngjHNQB0sgIo87sS8
	ucGWNLd/X6TDYvabN2pnqPiKf1dftWXYA5+10J7mK8OWsYPLrZILRbWtybAV
X-Google-Smtp-Source: AGHT+IEa5GjrHZAAs7dopksscnLMCrTpR/ZRb2s+mRqCsQrnFkyyHz9MWfHwQ7PjIm4x2H0bbcHi8w==
X-Received: by 2002:a05:6a00:10d5:b0:717:8deb:c195 with SMTP id d2e1a72fcca58-71b2604937emr21702683b3a.21.1727737467723;
        Mon, 30 Sep 2024 16:04:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2651628bsm6770806b3a.128.2024.09.30.16.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:04:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath9k: return by of_get_mac_address
Date: Mon, 30 Sep 2024 16:04:25 -0700
Message-ID: <20240930230425.369534-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can return -EPROBE_DEFER when using NVMEM. return it so that it gets
forwarded to _init.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index f9e77c4624d9..8924d49fd8b5 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -647,9 +647,7 @@ static int ath9k_of_init(struct ath_softc *sc)
 		ah->ah_flags |= AH_NO_EEP_SWAP;
 	}
 
-	of_get_mac_address(np, common->macaddr);
-
-	return 0;
+	return of_get_mac_address(np, common->macaddr);
 }
 
 static int ath9k_init_softc(u16 devid, struct ath_softc *sc,
-- 
2.46.2


