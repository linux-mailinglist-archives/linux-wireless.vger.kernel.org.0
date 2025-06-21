Return-Path: <linux-wireless+bounces-24312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6403DAE28FA
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 14:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B66189B9A2
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204A1E86E;
	Sat, 21 Jun 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="msA0HuKs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40880E56A
	for <linux-wireless@vger.kernel.org>; Sat, 21 Jun 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750509144; cv=none; b=Iodww4G3zWzpa6Fu/+9D7O1IyM64Xuf4/7kMgWLHX+Yc8oIb7WpCNZtptjqT9OTJCZFirO3Mpyj1FvtnjCCG15eAxp3u3K+KZtHsCQDA7LFjYj0KPnCm5Kdqu1zXAuCYGL+n6tKYYaYGNO/4ygbaxYSgghqdDJ1TK18q9nMwsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750509144; c=relaxed/simple;
	bh=80rvRyMtgxIDm1o2KBIfbxoi482dHJfEbzNkZ38/WgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVgexxP6Ya2Ui1M5as7tZLjKdU1yaWYGctSlvXvn19LoshqJEHBAaDYy/8sHSySYflvjIYiNMbwzitcOaJDg23lWxYGVncP0U1vxK+QN4EUa4bNdMPJrcLUD/fseWUmTEDZuJjykny7mqQSqemtP3aoe/6lzStdr1ttLdSKiEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=msA0HuKs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748ece799bdso1835973b3a.1
        for <linux-wireless@vger.kernel.org>; Sat, 21 Jun 2025 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1750509141; x=1751113941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O66BaKh+JhZeAwTmXM5ZiLhHZkx1nWgCUQPsfYeWl0U=;
        b=msA0HuKsBfBXkDEWnJy/A+HrJPiRyfrC1TCWURuOWOsxmvn3y/lAmpDudNZh+lJRCj
         rvLgyzonnc/nBol1UPKCxodGmQZ9FzPrOHxSNTKFTHvdqby7lBbSI24mn9BvjvaFcrGH
         DU1jZ0XMq7Ih4ZAb6XT9h/Auqbop7Br+8BUusMgs6rHjaHwoRKwH3SFF2OtZTflEhVW8
         Rz13DkRt9MLlrcJ3uuq18Sm8ww1IAdlXFDkwEUs7nuW+u5LYWBhrNtsS22ToMlXDLThS
         7S7o0I05Fq/r7rD8WqJvlIq7KoUzquQMvphky1pLt/5eb/EqkT2OqwvD7RQjj7cdedCt
         5PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750509141; x=1751113941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O66BaKh+JhZeAwTmXM5ZiLhHZkx1nWgCUQPsfYeWl0U=;
        b=EFqmfeU0/BwzBKuuplzKw+tVffYZud1/5yIU2zcaM3ulmueeS6BsnaanTTEq4FpZoz
         HlIQ/lOafO26MWm0gB0j4/3S7EeCiUvTEVMcueDeXi0EmPXsqEslWKpEdEQjGocBnvVf
         ELFl+8/nlJZV03mM7DQkHgFiVNUjgtMoKgmk1vXaEUKlgawWN98URUkvwBJA7D/aJsAk
         35Wswh7Mv8RhA8iFNl63mS8tXJQnDkGceO3fbnq8C31tBj7ymjiF1yTbXRTHltsgSIFF
         MtYa7G5Q1N9sq+cOhf236JP+CNJMvRsT//SyGFc/J/3qFCiN9XtZCqrfzMXSfOV35sWj
         16GQ==
X-Gm-Message-State: AOJu0YyxUYdnbySyVIL8nIE7sWAPie1k8rKuUhmCLNpc9C7g/mvlbGmQ
	KorX0L7oLXQCUT3Xe6FA+aovdIPKoFQHxqWc/CpY7x2eunrnMyfwsCLUS3JeIuw57UWcjDmACl1
	aONeO1Ew=
X-Gm-Gg: ASbGncsSp7d11a/PJs/A/Y3TmODtchhmBl4fraO+hcOF8Y8RwQlff7Zu8W7Qkp1lkD0
	smzg/5Hku+tmDIXenQnywCMR1s31Cs27Fxr7YMs4KVzZ0PYggWcHjRApXpTEdc05vGwo3T27A+l
	PrwB43MSfT5lC7aTjVWpaykKAjG9v19RY0T5bXxSYT3FzT6VI2vohz1GMH806UDH/jnohwBzhfg
	tlvOuM350W+0cqfZa0Fi1lUI21Ppepc6CuMB5iU7JZ3aIMbZVtQPdDBffkdlHEyRaZZZ+liOjME
	L/QIGIC86EJ/7ybGz9MnKwlxQ5tF2VTetQnTEGNRXU7zZltVzkZS3LtpS9HZ6ov6KShu+urdogh
	/032N
X-Google-Smtp-Source: AGHT+IEr8iuweIIB1F7Z2BC02r8RodQZarzq1HFERjX4Jf6HIXHNHvWwZb9Hb1ngYHnnCndudKUWMQ==
X-Received: by 2002:a05:6a00:4f8e:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7490d663722mr7364723b3a.5.1750509141547;
        Sat, 21 Jun 2025 05:32:21 -0700 (PDT)
Received: from mma-H9MHD44.lan ([60.227.214.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6494b3sm4091388b3a.125.2025.06.21.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 05:32:21 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless] wifi: mac80211: fix beacon interval calculation overflow
Date: Sat, 21 Jun 2025 22:32:09 +1000
Message-ID: <20250621123209.511796-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we are converting from TU to usecs, a beacon interval of
100*1024 usecs will lead to integer wrapping. To fix change
to use a u32.

Fixes: 057d5f4ba1e4 ("mac80211: sync dtim_count to TSF")

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 net/mac80211/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..a125995ed252 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3884,7 +3884,7 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 {
 	u64 tsf = drv_get_tsf(local, sdata);
 	u64 dtim_count = 0;
-	u16 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
+	u32 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
 	u8 dtim_period = sdata->vif.bss_conf.dtim_period;
 	struct ps_data *ps;
 	u8 bcns_from_dtim;
-- 
2.43.0


