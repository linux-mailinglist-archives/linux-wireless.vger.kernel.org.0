Return-Path: <linux-wireless+bounces-26081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F90B187F9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83143188B4FF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545921F4297;
	Fri,  1 Aug 2025 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQNLdyGa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F81DF71
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078910; cv=none; b=UOIvGsl0wtaFaKm+bX+h3SHIu4gqEV9SXuH99Q/DcWjN62nyZzZMdB52766coqZKx/OiwFrnxmEzSU238LCcnXyHuceM7ZKjKARGZ9F2fjC3tbZEaxHr73VnCCm+pVnTeMy6KC9MPoO9h3Qnh3uR81wsDpQwZARB29EriSNz/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078910; c=relaxed/simple;
	bh=jGpq6xCMSUb48EWKBh1+D/21OH6wCXqwcZSSZDHFLac=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=V3k2qpqF8IsbCjbhpQllxrqcFuVWaVMruDvW8qm7nX2Z163t3a4/WkFGANLdMcyDdbMs+YZcE7Ul/4A/gjvyELstAZ0emuQS7NiPTHJm2TfgLiCYeTJBlG0vap0mZ95L2YA86s5JfIrWUJo0obLu69TuE/yWiqG7b39CkE/D1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQNLdyGa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615622ed70fso3410633a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754078907; x=1754683707; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG0yoohqWfbsb6PKceEFsBeEo0KbDoE3JO7gQrtl0ts=;
        b=EQNLdyGa6+4SdI7jkS681Fzz4KSq8LCBNz+/rwkmmr6LmNlmpTOcvHOOoA0CGytpHs
         QnsjWBC1fdx4oe9tYHRUuDwtB+nDUN1qtwwAPBCxnfeT1F5MHnlsQL/aJQqrLSW2/D/u
         wZLPkW8JQTD32xQvDG2WrTnkmMMS50egI8FDXMQd4J2CsjKcpAwFpvF2hlgZoQCzP8Dj
         39uk6s/OjwerwrmgTvv7gVpMcwzghO6yNW3ER3afkYIuc+AgMlxMdQ8uDITU6GTD614e
         nz02EGuK1QJF8Ruw89Pf3RMrVc4zNmSTjzbl0DkvSlzo4laaiOwHhIjEQCPJHpitQjCv
         QYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754078907; x=1754683707;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MG0yoohqWfbsb6PKceEFsBeEo0KbDoE3JO7gQrtl0ts=;
        b=PvaEQTWJVeybKckV1EByJ7q2U7AsxkXfqacy22fHbKTGRTdJNUZblDbjq1xceGRKv9
         TRdEYTJe2fgIasVj2x4Pos+DUwCu+oFAwZHg3tXrcWOJeWG3KskzVNHikIgwyphn6Jgk
         Lq1EwSObTDJM9+UKv7CpLAykXd+Vq1mqyhcYLrW26p51kT4M+hfraA5DZXS+5/PYaGWL
         O0rOR+7Mf1P0CkEsLwJcLApdFyz0d11nyph5I8celF70lAjfJnPUFgNGsTN3JW6miss/
         y2/92dqF5mciPZU+Jx98M45J32NRv4AgYnnfPBykctKVy7zxr6+T//xpG4A6t+5+ecAd
         e0Bg==
X-Gm-Message-State: AOJu0YwtmJoWN+UqV4h+u6ugZ0UJ3T8ddsNI65Zkp/GHpJaRdnu/xo8x
	Wd8Vs570aE6gBiWyUisFgLfYpvqNAq5Q63IKyXN4bd6xE/0TAQDdlUGNy/eEzw==
X-Gm-Gg: ASbGnctrl46p1+aGBczKfSJBgyL6xRToRuuMe1jZ1oCyAer9/5/MnObeZ364hDIvQHe
	mx4gl+8/s0CXvRF3tJpVbpfxExLKqCQX+HIK9RN5M/nJ2077MO072T0qx/GMlRtE7D5WtvNOtGp
	KbKi58NYMAyZzLjs2a9XcwaczeScVNm2TT5jx1+7XgghjsxUAoSXk5f7IAIUp9/lJcdFbt+kZj3
	uAm/Kj0qnHKNr6Q4zJqjINMrrpFcoWum+3yuf6+eH8h/4IQT1IdzbyUK7mkokCxj5GzwSr8d7DQ
	S4WiPYt6UNfFGduBlQy/ePw7soMPqBGAPQtwPvdbmp7QASt+JHyIxSDbIpeXLr0c98MY2gFSTmi
	ipkD8gljYl/5ZLakoLllzXhstRRO0rA==
X-Google-Smtp-Source: AGHT+IGCVGZ1KKc7ibaGX/+cXNsDUs3GZhAiqv8cKD+39r4DNfr6sQOeEXBEQb0d6pitgmgWXDNM5w==
X-Received: by 2002:a17:906:6a0c:b0:af2:4769:8917 with SMTP id a640c23a62f3a-af9401b054dmr104811466b.37.1754078906548;
        Fri, 01 Aug 2025 13:08:26 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0f4sm326701766b.106.2025.08.01.13.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:08:26 -0700 (PDT)
Message-ID: <ed69fa07-8678-4a40-af44-65e7b1862197@gmail.com>
Date: Fri, 1 Aug 2025 23:08:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: Lock rtwdev->mutex before setting the
 LED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some users report that the LED blinking breaks AP mode somehow. Most
likely the LED code and the dynamic mechanism are trying to access the
hardware registers at the same time. Fix it by locking rtwdev->mutex
before setting the LED and unlocking it after.

Fixes: 4b6652bc6d8d ("wifi: rtw88: Add support for LED blinking")
Link: https://github.com/lwfinger/rtw88/issues/305
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/led.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/led.c b/drivers/net/wireless/realtek/rtw88/led.c
index 25aa6cbaa728..7f9ace351a5b 100644
--- a/drivers/net/wireless/realtek/rtw88/led.c
+++ b/drivers/net/wireless/realtek/rtw88/led.c
@@ -6,13 +6,23 @@
 #include "debug.h"
 #include "led.h"
 
-static int rtw_led_set_blocking(struct led_classdev *led,
-				enum led_brightness brightness)
+static void rtw_led_set(struct led_classdev *led,
+			enum led_brightness brightness)
 {
 	struct rtw_dev *rtwdev = container_of(led, struct rtw_dev, led_cdev);
 
+	mutex_lock(&rtwdev->mutex);
+
 	rtwdev->chip->ops->led_set(led, brightness);
 
+	mutex_unlock(&rtwdev->mutex);
+}
+
+static int rtw_led_set_blocking(struct led_classdev *led,
+				enum led_brightness brightness)
+{
+	rtw_led_set(led, brightness);
+
 	return 0;
 }
 
@@ -37,7 +47,7 @@ void rtw_led_init(struct rtw_dev *rtwdev)
 		return;
 
 	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
-		led->brightness_set = rtwdev->chip->ops->led_set;
+		led->brightness_set = rtw_led_set;
 	else
 		led->brightness_set_blocking = rtw_led_set_blocking;
 
-- 
2.50.0


