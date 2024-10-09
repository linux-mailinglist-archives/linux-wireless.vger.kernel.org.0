Return-Path: <linux-wireless+bounces-13759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04682996035
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC1F1F232C3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B91714A5;
	Wed,  9 Oct 2024 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mna9FteA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A422EEF;
	Wed,  9 Oct 2024 06:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457068; cv=none; b=NSNgv8VL95h426z8OROVwfE9EMPyHy3+6i2V9b8CqKfjbXY770SdmDSeWmWh35jQvE0wL1vbBj6Zvyq6f6RULIsE9loEIIV3ZfUWnjQwnV3gWtcxSV3nIJCIbxnk/UaR0rH/secirSeOjToLZSxzV9nvQua2642ID4vtmPokOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457068; c=relaxed/simple;
	bh=nHU0jGiPuPgRDYsaGg0oFrwSVt1YzYUXAZSJtxyrrIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzeyYRPcA8qNbH+MQfLQXCEWIhp7SaUW6e+5q594OvsQxBZEtX3x8j9tIvmZ5XYBd+sTbx8/ASdK11n1/rZJk8bxZFxnfguJn6nNMMKn3i3s8wjLzr73y9fZogpi+ylZM9uYlp56cGdZjzvX3mM4Sc6ss9kfegL4zs2UzncVqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mna9FteA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so439467666b.0;
        Tue, 08 Oct 2024 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728457065; x=1729061865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPvYSPUlyNo11D60Rn7xn72ZEXb5uv2wt4zjMOlQ4WE=;
        b=mna9FteACp6IAgss1gourNSdrHuchwaxSMtlm5cDCXHAbSO/pA4j6X/H6a/1e8VULp
         9S3RKUr+KYKONwhokYz/RH3xCzZNRWr3gSn9KIqq3d0A69seLFYKU2ZzhTEckuDC+M0t
         GmXRTW5jk/tz4oG6Ec2P7PQituX3OdAkyJS2vgbRPVUE4ZcpIOv4rl9K72Ks0UQKkP5c
         a70SgzYrPLUeoLqgYAjBysNJ01vbqg92jol/GtBBMYC09B4lwmqUO17jnxqTZQUZCUhm
         myEuGnIdId6NPws061I9P/AJDG5ZfkfdO/jhC7M5sJysmm9aon3nTO1p9xDcasT5QzQu
         qghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728457065; x=1729061865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPvYSPUlyNo11D60Rn7xn72ZEXb5uv2wt4zjMOlQ4WE=;
        b=gw6uIw2yDoQLGD6glhcYY1YnMuCicrv8jcyjGHzt6EyUF7QmPZ83sFct9lhW6CiTTq
         ISz5685AO/MmtE5X9hamTvf8VttKDOqd6JaGjhCRyPeTd0R9P2Jjk+FBATUJaEYTGx2q
         26rwzEo+mf5Fon3WdJ1Sy91ggTHI9a1Xqphe/FfD03RnHU7r4UNwouCBWkX/cre3Uz1f
         HXG8QY4UNF6GvlHXH0nKxXytSLdGhndY42vcpuOoMRSQXaN8TtlqbQTqFL9TM/Z7jwC3
         aKJl9x63wO5H5f0+6jLSvg20VoYnHVWk8do5IJCe/6yDsGOvy7Sk98na1D4RoPCwqhgd
         SUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtvvDMyY4P80PW+mmN7G/mio8c2Wp7OG5MyvkUVvO7Uiuu6J6eP6kmnao4jYr3yIXyEWMtqT7RueGCm/w=@vger.kernel.org, AJvYcCXRsH7sPAejvpIwZVUUKvkYK1ACe544bHz+AjcYVcL9B36HduH2hlqYuNpUHwlCIJVKTwb9FRzJQ1xkOpIKiV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJ3AaqG1ei7acIioPYXVR/raX9gXntL8dS3zcZRGa2xiGZJ4F
	mp1+bA3F+bqQL/PlrxoGedPg5IU9JIJWBGg1DxGIKEb32hoGjQfARWweS/rJWw==
X-Google-Smtp-Source: AGHT+IGzGHI/bUPLoB14IBW6oz/xRDOg6TnvNCvh1TiQvQNTqF6u593L5vc0eIz9x8PT1DHo2OBRLg==
X-Received: by 2002:a17:907:97c7:b0:a99:4e8c:e5c9 with SMTP id a640c23a62f3a-a998d19831bmr114753866b.20.1728457064793;
        Tue, 08 Oct 2024 23:57:44 -0700 (PDT)
Received: from frutis-latitude7490.lan (public-gprs367762.centertel.pl. [37.47.67.211])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e5bb275sm622758566b.11.2024.10.08.23.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 23:57:44 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: 
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: ath10k: add channel 177 for 5 GHz band
Date: Wed,  9 Oct 2024 08:49:28 +0200
Message-ID: <20241009065051.51143-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240801202359.794035-1-frut3k7@gmail.com>
References: <20240801202359.794035-1-frut3k7@gmail.com>
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
index 646e1737d4c4..cee6a4d287b5 100644
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
2.46.0


