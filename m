Return-Path: <linux-wireless+bounces-30646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D848AD0F7F2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44466302CF7E
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C452B34889C;
	Sun, 11 Jan 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf4MnstP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897C634B1A0
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151497; cv=none; b=DOv9PDvCQZpoGzL+o7GSLEVBN5+kanM0LmmOuhosCL2jjQRUpKnI6QpAD4nTyknCFRCwqIZEeuXw4QNDEktFWDwod/uWTKk5ZYD/vn5nPv/uV344XLue5wPR53H1rpFaF1hyeomjZ7+/7nLvZLv2iNQ9ErFa6OaD/JJBJA75CDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151497; c=relaxed/simple;
	bh=1X4/mgD8i46cgaYtzD7T7tQWYglvatsNfrnjhmeWS04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsysM0nRw+er/N3j2W13TYqEWV3kiZ9r2/O7QGBTBqUOOnK9dGJK0jsrWZTVe97p9hJDLZPS2xo3ji9Of4m/dN6LyqYDHkCmy0bH3qULkHCceC3GxzdJ7DhbyeEg38dTyVMnXhhV5k7z1Q5uEuoc6lSK/KspjPS/OVfn7ECwd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf4MnstP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c21417781so3846120a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 09:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768151496; x=1768756296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAqq3UaflZMTR4kV8l/Zp3RcDFexgnKsLUUbdPELkew=;
        b=bf4MnstPqALvGivrguOmcLqcNhAO5B5jiJ8uAxRW5mvkZJf0fXkV8Lzyf6ENwi5FCc
         3sRJvUoFV+ekmw1/fqJIqmu7iIgOTyBxITMw10Nb87ZSPHPICx0gflFP72pPNsbWbJ17
         mVi3UilkCcVOaGtGXBKY9dCRvOlgY12RPn5MAg5WFEBC6BD00LW+joePYLATGdHVDGJF
         UEYnKBVWOizbi0y9xU6Z2ZT0vyUT0afIHVTjogNnX32wbZSeyetKg3MW9Edf1IkBneD/
         HxnhdGlwulqh6t0oMrZiF6Ou0N2ugx9aMEg/rBdpoa/53CrNapDUZ4iCkPmKJictotAG
         QvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768151496; x=1768756296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAqq3UaflZMTR4kV8l/Zp3RcDFexgnKsLUUbdPELkew=;
        b=gjuG3t2dE4/HFeAJIPWTNS48jd53pGLVAJScLb95qy/M1rLF7daGqNy0f2mnASxikX
         KKs2i1MADzEbV8aWtUjhZSAwxp5ose4l3/SApnJXj/D/WwXRyU8q+CsXdOMlGZWJMPGY
         O0PmbF9aSX6bjs3TmSZx/sAtcQRuwI5B8wm+tohXggPhDh9QYYhf922Rikh2PvM+d/RK
         OrngHXymsE+uhPls9mUkI458H8yiE6r+ZXB7moAPHXpSOCS5QHOvy9n8lw0LHhFc5k/o
         zZfQUfhNwiK0kIaWEIB/Y1NO6D20Fp/qjbQcGErGmpRZ+XNYySvQHK8Gf/DRoTSSIo5X
         yIqw==
X-Gm-Message-State: AOJu0YxW6mTUvO19cG6f1sIJ8xuNVjnozvAbPorqT06rV0KztRQVzUXu
	NV1Am69SF/L83iThhlfmZ0xrrooypRWLWa6TjT/aAHb7chsHttuIm0Oi
X-Gm-Gg: AY/fxX4nN1x8TGUzO7bZntnJyjVsWIenYC9b1/4nMaI8wt+4DwEZB2ulCEtJDEHRc2M
	E9by/woP4sN11SAuXWdE7RUOr+8PSuN78AGyxGy9ntQdPT89I0nt9GcJHjO7Fga7z0hwrM3P5Da
	PzLbPYWrywBU2Y6OkRC26fOXlQDlhA2tWWeS28Xp4WlAWlp8kNdkAXybUeteAPUtltQPOAKcisw
	+oRk0QzsYJgpy4piMtpSupNDwHujz2voqW6LXz5GJcrYsukGmAKmZVfvb90GDvYpTZm/Pa+DAOB
	5Ba2krmyeB5WYq1fFKfu/icdTQRxY0k03s0oNn0gQYPJkp7Y9E1jtQfJGzVMp/Ferhg7f8xMZR9
	+Fzud1TQceumHoCYBnk9y/tCROhcdQBDG+PiqgyAUxAOWqno6CaujqtgqsWPIoyv13qLUJD1bs5
	BEa20d4A==
X-Google-Smtp-Source: AGHT+IGkXAkN3Q14kO3huY9VOxkyFSlcXlgRN073mJecj/ahL42LaFJfICnOJ/iZcIbqx83xpsQf0A==
X-Received: by 2002:a17:90b:4f48:b0:34c:c50e:9b80 with SMTP id 98e67ed59e1d1-34f68cb900fmr14009150a91.27.1768151495670;
        Sun, 11 Jan 2026 09:11:35 -0800 (PST)
Received: from oslab.. ([2402:f000:4:1006:809:0:a77:18ea])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b1cc1sm15454063a91.2.2026.01.11.09.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:11:35 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: stf_xl@wp.pl
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH v4] wifi: iwlegacy: 3945-rs: remove redundant pointer check in il3945_rs_tx_status() and il3945_rs_get_rate()
Date: Mon, 12 Jan 2026 01:11:18 +0800
Message-ID: <20260111171118.203249-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable il_sta passed into these two functions cannot be NULL, so
remove the related null checks.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
v4:
* Remove the redundant NULL check instead of using WARN_ON_ONCE(), and
  update the subject accordingly.
  Thanks to Stanislaw Gruszka for helpful advice.
v3:
* Replace plain NULL check with WARN_ON_ONCE() and update subject to better
  reflect defensive nature of the check.
  Thanks to Johannes Berg and Stanislaw Gruszka for helpful advice.
v2:
* Return early for uninitialized STA il data and align D_RATE messages with
  il3945_rs_tx_status(). Add a wifi: prefix to the patch title.
  Thanks to Stanislaw Gruszka for the helpful advice.
---
 drivers/net/wireless/intel/iwlegacy/3945-rs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 1826c37c090c..ecc6c8d2a4c5 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -448,11 +448,6 @@ il3945_rs_tx_status(void *il_rate, struct ieee80211_supported_band *sband,
 		return;
 	}
 
-	if (!il_sta) {
-		D_RATE("leave: No STA il data to update!\n");
-		return;
-	}
-
 	/* Treat uninitialized rate scaling data same as non-existing. */
 	if (!rs_sta->il) {
 		D_RATE("leave: STA il data uninitialized!\n");
@@ -627,7 +622,7 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta *sta, void *il_sta,
 	D_RATE("enter\n");
 
 	/* Treat uninitialized rate scaling data same as non-existing. */
-	if (rs_sta && !rs_sta->il) {
+	if (!rs_sta->il) {
 		D_RATE("Rate scaling information not initialized yet.\n");
 		il_sta = NULL;
 	}
-- 
2.43.0


