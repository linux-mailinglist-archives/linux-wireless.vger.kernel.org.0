Return-Path: <linux-wireless+bounces-8142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6908D096F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79801F2233F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E415EFC5;
	Mon, 27 May 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKn7GVh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910E15ECD3
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 17:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831328; cv=none; b=O+OoWz3nhguvFzRpJk5p9m12mzKNNRnntLn3mb171AU9/TcvWsULgM+lo9EmeLFpkWNJpmU3dV19/ImK8uklAj9nf+fdTMlef/yFkpQiHqZMukIRH/jipu2Qv4UvTIKmE/2ZsPwXsRics/fI0AdTVvoR4yZ793B7Fh/50jrq7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831328; c=relaxed/simple;
	bh=68yIhEvb9FjH6f0sGFez019la9iLBE+u0nLfuW0IJOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsGQmYKHVpcIdguOaSOvvrI5tYsfDcXmtTWu0ThyKqYyytEtmG1q7UWeqYaz2/LHII4WabnmDHBObmgsIgiokcDBVLtz49bymq72/Op71YTjczhDBVU8tcWNxmamMOU2AonJe/ft6HLQwXHcn3o+2GAnP1Ey5Asx+K9/5bPa3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKn7GVh3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-529614b8c29so5329945e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716831324; x=1717436124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebfJZ8PwhlH8q5JiE5pvjuHAQWR0IKg+SwzFXyu6Wqc=;
        b=BKn7GVh3KHvuFsiq6dR3IsYU54VhZIq34ld1Tex4jHvfL3M/7q2JZlyRpJ5Npx1h2I
         yEh3Ef/rQsqQ4h7SzwW0YyO3I5ekbKDUaDfRLpmD7DARcKMGmIoC128Vm/QcIyD+fQFa
         do6DgYGQmWwzZ48PIWZkcaJPMgKCPGlxvh4AvFJWEZRS6HtOA96xnN9qzoIur2r8Hp4F
         wBAYiC69we9b5xsIB9nlVh9GSKLwJ9a+zK1+AIy/6aKtOYqxxULQmaun+a//TOo614dD
         WQMagbr9LEZYIiTLjsbCAXZrzteCy/UMVgm1nAlGGJgy4hpv/iFJeILYhZNUx5OgfBXV
         Su1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716831324; x=1717436124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebfJZ8PwhlH8q5JiE5pvjuHAQWR0IKg+SwzFXyu6Wqc=;
        b=K0Jh+NFKVchyW/ppYquRuQVU6MYL3Ei3TrF4IUUm+I5Z0NNhMaSTiA4WBSewDuRNBx
         q/j+BRsoA/Ov9iolrflwit0TR4IbheZCBviDGv9hbgr63gL8EJ03AiMOMTVbQ6cnnR8i
         uBPAlxFY3KuPIwh4pt7CT5hfHbhgairgXonyFoVsB8cCEm8mzDmP8t6HAE3IZurQTqdo
         NsZ3tsIlBabk8x9EDpFywdgKxEePJH6S4SiYkeXaUS62d34xHp1s2MfSe5cLrzkjsdcS
         c5hHqOq+6Rwarrwr9CZSIUcN003uI1ExmSscOdfwM6BUBzRiIgrpd5+63xnVjTXgkiqa
         xOLg==
X-Gm-Message-State: AOJu0YzafGwP+ZzVAuTW6SfZm8QfB9O9SqbwB7qDJC0eavBwXFMDZDu5
	o9esNrMDWL8Pho9ag2ilCk9IOU3x7DbEcVcKUOF8wopPYEsp3DTdJ20bba7z
X-Google-Smtp-Source: AGHT+IErFSVUj4tVBJWqlaEVajfGy3grjY5JvnwAUd1RQtw49FABpAdVH/MhPYi8NPDvGoWFqCh+ZQ==
X-Received: by 2002:ac2:561c:0:b0:51f:5d1a:b320 with SMTP id 2adb3069b0e04-52967f06cd4mr7572562e87.68.1716831323517;
        Mon, 27 May 2024 10:35:23 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (1779df417e104.rev.snt.net.pl. [213.192.104.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm512070466b.125.2024.05.27.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:35:23 -0700 (PDT)
From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 2/2] wifi: rtw88: disable power offs for 8821C
Date: Mon, 27 May 2024 19:34:54 +0200
Message-Id: <20240527173454.459264-3-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527173454.459264-1-marcin.slusarz@gmail.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcin Ślusarz <mslusarz@renau.com>

This chip fails to reliably wake up from power off.

After some number of power off+on cycles, it stops with endless spamming of:
rtw_8821cu 1-1:1.2: rtw_usb_reg_sec: reg 0x4e0, usb write 1 fail, status: -71
killing both Wifi and Bluetooth part of the device.

On arm, just leaving the wifi device unconfigured kills it in up to 20 minutes.
If I keep restarting wpa_supplicant I can trigger it within a minute.
Looping "ifconfig wlan0 down; ifconfig wlan0 up" also triggers it within a minute.

On x86_64 system the only way I could trigger this was via ifconfig loop,
but it took 3 hours and 20 minutes to do it.

The only thing that "fixes" the device is replugging it.

Signed-off-by: Marcin Ślusarz <mslusarz@renau.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/realtek/rtw88/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7ab7a988b123..e8bfa683d7bb 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1482,11 +1482,11 @@ void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 
 int rtw_core_start(struct rtw_dev *rtwdev)
 {
-	int ret;
-
-	ret = rtw_power_on(rtwdev);
-	if (ret)
-		return ret;
+	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags)) {
+		int ret = rtw_power_on(rtwdev);
+		if (ret)
+			return ret;
+	}
 
 	rtw_sec_enable_sec_engine(rtwdev);
 
@@ -1534,7 +1534,9 @@ void rtw_core_stop(struct rtw_dev *rtwdev)
 
 	mutex_lock(&rtwdev->mutex);
 
-	rtw_power_off(rtwdev);
+	/* FIXME: 8821C doesn't wake up from this state from time to time */
+	if (rtwdev->chip->id != RTW_CHIP_TYPE_8821C)
+		rtw_power_off(rtwdev);
 }
 
 static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
-- 
2.25.1


