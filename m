Return-Path: <linux-wireless+bounces-10837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC89453AD
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CB71F219FC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7963B14A0B5;
	Thu,  1 Aug 2024 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1YrYa3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763513C832;
	Thu,  1 Aug 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722543856; cv=none; b=OhFGBlWBOEb0ngKVodn7YtdT7pLRaNty43ApIxqjP27g9qLQIHNv8fxBpWBGok4mjGrWExhTpzoSnPmjz2G3GyOhjk0zV+rh/5t5l7BMX895fuEvwPl1jpe0p0OpOhoSY5w5L+lA6SB/DUgKaMSjnnG7AF7CUrse/oWvyBwAfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722543856; c=relaxed/simple;
	bh=A/KB5IRwkJDTrHSUZs6fZR2LDhW7gYVhgR6xoOA+07E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OArpi0VtONkaaB6rh8KU/kFOIUMxk49wCPk2BwkZhUCnBnbsDsdl9zoC72XDAiFzES6sDhcoV8fY/UX+SgOUrVq8UlwlAzaxfHK09evPjMRKPbKMaoUsBUoDY4gpnAoAXJe/68lREsG7jv1ViKoJ5JuwjkdGi1vgACjUZM0vr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1YrYa3D; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so16203025e87.0;
        Thu, 01 Aug 2024 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722543853; x=1723148653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xog2N/WyrIaPwtXz/O9Ydne6Hz6difkElo2MkclaQ70=;
        b=K1YrYa3Dd/Nr7Mq6gVJP+N4lCfgUmbrQKwfEavHUGefG89xV0XdNvFtFNvVOfVPWnf
         VoJH2LQAZA7evbmuWBCH6Ysd7euQyllzO3/fZm2DwYq2ZalUxtv8Hhok6doD90iJD0pE
         lmRRf/bpRgsw46DG4HB1cqWtI96GgWZzRwX4jXxWf0gLsXqBGSd+TZDMP2OFIcSGvT2K
         gsAG0QX2R74rXhUJ5+RyMqwqQ62K82TKYYOmIO1TIDFixv1IkFXw1CKa9ED6t5TJoIAX
         EW9tR+6CJ2nrH9Q3jalhXoWv0ggZN/txVq5FR6L3kDr0iod5uyZOgzZcXiqmSTAhNLxw
         xOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722543853; x=1723148653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xog2N/WyrIaPwtXz/O9Ydne6Hz6difkElo2MkclaQ70=;
        b=f3lY+q/T8iC0S8ROwRD+TtzZ0gRGdZyZc4R14AfAgHifgTArycNYdHff2seK8KYwED
         KB2zzEy6rz1WGVyjaL2/oOK9ZjY2qIF/lvs7SNbksTJNX0d6davKCHdY4VKWJl4DR2ik
         NptBWh/praZzSpMS4ce3KfnQxHomU9df8Mk698BTikT6x52DUqROyQIi5XsNBQ9imuVv
         6nXs9QlIbE+ZyS6oQjUFEXqpyXhEOZTtFAWk3803pQEM+cWrWyfmXWRNv1O62LFV7SoC
         cFfebvOlBxAMvFeKHKJCIkFNnb02tFL0CSG/JOVMCZkO8AJdiGMOrWXmNxTEqhEemVgO
         MfqA==
X-Forwarded-Encrypted: i=1; AJvYcCUDurYo5zapNfnwByQIfQxRzNCI2w7Fqb+8EjI1XNgDSIc3vHIgCvqbLtbU50xZ/CGfq/OCBRlrt2m4QedNnSJPePuqLt5tl7XvcH5kwD8sMexMOnU5zmCY4lJSl3Ex8DD1cL3ybSMhvsRcI5w=
X-Gm-Message-State: AOJu0YycdqG99KYE5NdtboaCeYIKW0Gpa9W7RAljfpvvz0ULXPtScaKI
	6PaSLaRvUjvmnKf4gKSjRV3O1WQSYksRLNF4EXPBWF/GoC3Ymw4=
X-Google-Smtp-Source: AGHT+IGuH1rYF73S/Bhb5uCYyJyEuO0qZ+m9zZ21jCjFdn/JPw6sm/sQWhH+c9Ry+bzHk9aTTkJB4A==
X-Received: by 2002:a05:6512:1110:b0:52f:cd03:a823 with SMTP id 2adb3069b0e04-530bb3b46cfmr1151722e87.45.1722543852246;
        Thu, 01 Aug 2024 13:24:12 -0700 (PDT)
Received: from frutis-latitude7490.lan (public-gprs367134.centertel.pl. [37.47.65.95])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-530bba29fcesm45662e87.155.2024.08.01.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:24:11 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: 
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath10k: add channel 177 for 5 GHz band
Date: Thu,  1 Aug 2024 22:23:53 +0200
Message-ID: <20240801202359.794035-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for channel 177 (5885 MHz ) for the 5 GHz band.

Tested-on: qca988x hw2.0 firmware ver 10.2.4-1.0-00047

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.h | 4 ++--
 drivers/net/wireless/ath/ath10k/mac.c  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 446dca74f06a..3dff8c028526 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -39,8 +39,8 @@
 #define WMI_READY_TIMEOUT (5 * HZ)
 #define ATH10K_FLUSH_TIMEOUT_HZ (5 * HZ)
 #define ATH10K_CONNECTION_LOSS_HZ (3 * HZ)
-#define ATH10K_NUM_CHANS 41
-#define ATH10K_MAX_5G_CHAN 173
+#define ATH10K_NUM_CHANS 42
+#define ATH10K_MAX_5G_CHAN 177
 
 /* Antenna noise floor */
 #define ATH10K_DEFAULT_NOISE_FLOOR -95
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a5da32e87106..aabe70fcd065 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -9543,6 +9543,7 @@ static const struct ieee80211_channel ath10k_5ghz_channels[] = {
 	CHAN5G(165, 5825, 0),
 	CHAN5G(169, 5845, 0),
 	CHAN5G(173, 5865, 0),
+	CHAN5G(177, 5885, 0),
 	/* If you add more, you may need to change ATH10K_MAX_5G_CHAN */
 	/* And you will definitely need to change ATH10K_NUM_CHANS in core.h */
 };
-- 
2.45.2


