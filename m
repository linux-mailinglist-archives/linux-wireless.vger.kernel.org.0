Return-Path: <linux-wireless+bounces-12548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8566396E19B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC82FB25DBB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E021E17A599;
	Thu,  5 Sep 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL0MQGes"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183B17BEDB
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559778; cv=none; b=GGceOxq60MUv96LxjVe5KnKLt8Ou7J7zoIT/+Ct3rleMOAC4ezLEPVOM5lQsVhfttblBtY9NfAG+x/8Q+r/vp7DpUplWKFrbUDubQkL4T8fDaamdjcYKkSsoXLkZnSQQpzB8uPfrbEHOsXZcG9+JEvAuMYdK9xTDMSflFhiPQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559778; c=relaxed/simple;
	bh=VjUXCoSjt3sLw3efTtF2cdRJ/UNBzRerP7/0olvsEx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etuEfy0e8HUS1vdaw+lk+T9+bU+JcI6Iw6HEcEadWroHJ6h6+KVO6n6WrfmjPJ4IiENMbnfLN7vsxdwGs3A7lv+ucVlDk5c5OLbWsdT0zJoZxpr4A1vvhNj7LLIV5CyBTbOr60Ni2F/dciAC9ozmY/PBLdg4G4yOyC71XwbllY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL0MQGes; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7b8884631c4so546634a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559776; x=1726164576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HzwQnbN7VjF2EcMeWh3G5m0T1m4yLEushhnAr1Awfc=;
        b=HL0MQGesyRYN01HxGbsjOkepGGfG6tdQCzm1dKhZnZidX0ItQf/oYOr4Y7fPAubCvc
         1n4biKaOjbPEVVrov6bMMoh4xCNCtGiy/qMHsR8YYNdqrP1AK8smk+esKUP1ZWf5rj5b
         oJJgbVJDhKVsn3au8nc6Rq1ewpcrNTgV41xGNskLEQHoUcQm1iGxnbKPwiUUZG4Q41W6
         S4KrUhLPIQUltRuEUhnSwY2KFzvG0ejvnS/X7E4sv6k4lRj5EFBKXK0zrWCC+riY/IHa
         8uYNRGkGzT3ZpWg9VTC4RVBCQz1wk+k0N2XcvVUnp+8T7Rfx/sprMk25ngEzNBGX2jLE
         QnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559776; x=1726164576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HzwQnbN7VjF2EcMeWh3G5m0T1m4yLEushhnAr1Awfc=;
        b=W16w6N3LYV3qB3VEb/XP/q2pwendth5PtEFJUdj7eVAE3fOdeKquCD2a7nWlQ97r4G
         ybK9nPkxp5Hht/SElbslv3/5j5hySDPwwDG1bOvMQncbUihVkmyAZQhDz3KGPrJh9BbO
         fkwJk6AmMIg0VrV3pk/Tx/Aqzd8uav/DkOfGi9Lr3wR2yoB/VOL6wMW5B8du+XJUFNLO
         OeapZxOgsVe0XYWsVRIRHbqZ/fraTLeGOrRD3FTblGANe1tfN7/MFEQ4a4vK2apvmzIJ
         hlQzz10z+rG+6mDJWM1F1eUbKWkrxR3M9XykMHhYczKDByNpTqBBn67wAkAnGBEcAABJ
         wZ+w==
X-Gm-Message-State: AOJu0YzG423COVgsyDNP/43x0DckyXrlQuKfeh45H1b29/6L5JX3phqC
	paCFYke9EODD7rPd/n4LR6JCtUK92K6EsAebruTiCMF2+p712PJg+ERb18th
X-Google-Smtp-Source: AGHT+IFUTDXdiovNRUIZ+88MnM2go0ews+P5sCj0uUB6+FxG3rCtCgEop0GCmJNzE30FTYMlfQw+uw==
X-Received: by 2002:a05:6a21:a4ca:b0:1c6:9e5e:2ec4 with SMTP id adf61e73a8af0-1cecf78a0c7mr18915793637.50.1725559776412;
        Thu, 05 Sep 2024 11:09:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfd5sm3485199b3a.133.2024.09.05.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:09:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com
Subject: [PATCH 3/5] wifi: ath9k: add extra options to of_init
Date: Thu,  5 Sep 2024 11:09:26 -0700
Message-ID: <20240905180928.382090-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905180928.382090-1-rosenp@gmail.com>
References: <20240905180928.382090-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in preparation for removing platform_data support from ath9k.
Except for led-active-high, these are already present downstream in
OpenWrt and never upstreamed.

For tx_gain_buffalo, just set it based on the device. The flag was made
for a single device. Instead of adding an extra option, just look for
the compatible string.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 7fad7e75af6a..88db51ec7e55 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -670,6 +670,7 @@ static int ath9k_of_init(struct ath_softc *sc)
 	struct ath_common *common = ath9k_hw_common(ah);
 	enum ath_bus_type bus_type = common->bus_ops->ath_bus_type;
 	char eeprom_name[100];
+	u8 led_pin;
 	int ret;
 
 	if (!of_device_is_available(np))
@@ -691,6 +692,12 @@ static int ath9k_of_init(struct ath_softc *sc)
 		ah->ah_flags |= AH_NO_EEP_SWAP;
 	}
 
+	if (!of_property_read_u8(np, "qca,led-pin", &led_pin))
+		ah->led_pin = led_pin;
+
+	ah->config.led_active_high = of_property_read_bool(np, "qca,led-active-high");
+	ah->config.tx_gain_buffalo = of_device_is_compatible(np, "buffalo,wzr-hp-g450h");
+
 	of_get_mac_address(np, common->macaddr);
 
 	return 0;
-- 
2.46.0


