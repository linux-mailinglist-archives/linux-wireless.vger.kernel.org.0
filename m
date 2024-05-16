Return-Path: <linux-wireless+bounces-7750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74248C7D96
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 22:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DA1C20E50
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 20:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9E157480;
	Thu, 16 May 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPHV+nym"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC4156F2D;
	Thu, 16 May 2024 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889970; cv=none; b=Udvl7lSwuG+ye6abcHSRMullUTLMuRtufTwt3HaIB1T+ktAQ/mefVUS0gOhalRXnY2AO2r5j2KODy5NBpSVPw6G0p8SIjTuSAg2QEVxQ62GoJbhAagITv/3VIIfybrWwIm9Ul+lyx2F0wa5OHEGbiAZ26eclWBa0YocEgKiz/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889970; c=relaxed/simple;
	bh=55gTRHB9c4bCkwXx/S0L7qGd1+x76r/nb9xDfdC9hrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFIr3HU5QHNn1FHFM48oPPE1Yy4LeGVeOTz7/dodKEvCdtN22qx1RR3p4yUCP3Et+AosRMB0wgDSV1jd8QNYu7tKUzGgw144Fmx9bl9WrGcoP1XWvEwb/guGvdelW2dqW2CsomySnzu6vA5uPulyK/RQ27TVhly/PopnXR/ISjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPHV+nym; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed41eb3382so62407775ad.0;
        Thu, 16 May 2024 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715889968; x=1716494768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQeZofPLv2uYbOMLS7VkNQBeTMAMV19SlyQflyRbY4Y=;
        b=gPHV+nymY0nv2mTQaO+ZCEh4S6ZChpyTHX8JOr9xgiK6g/M/aFkytNBRwMUYFVI0cU
         hf5JL4grPA9Bxvo3p2WWVdfS1kAhtwCAouTUdqIXjoLbAkjD37CJV6CR2t1senSlpCqZ
         FI2pbblz9uUh1bt/ygkDL0/S5W2fNzTKD1CMXIoQZubHWSXrhMkrywD69108D1wS6YK8
         pyMnk2sI02Wnz5Wz1SnobiuZJtVgcgcAFlS+Q3XjED44m/WWYFs2osy7yAhZYYQ6DQHX
         2mbVwbsLgQ9r7/fiMfHKPsODrWwX3RkFtNDMIHrGYB2dE4KDbRBUac9XPzH6T/rvg5my
         lJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715889968; x=1716494768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQeZofPLv2uYbOMLS7VkNQBeTMAMV19SlyQflyRbY4Y=;
        b=a5VG0hB1lskb+cZwzajRGpQ1hR04b86xr+MiQfmYu7+S7/+dgswUZzuJpyMiOQR19l
         sOBbECvInHOKCs7+gZWBV6CU6FNLgFcLMrfk4Qqkbd8DSIq30alKPXOGbWig+yrnYxl+
         SE9gUdECm2FSX29zXY6uP7aFo2EY1zdZfGQk2wjONXzh8MQtNFTVFPPYEWL1hDi6rLz3
         Wol8qCKZZndOMYlgSEjRg+MxdOkfK+SROgL214BalIDhqvFOZr8dWOeZYLdarBjG3h9D
         rsT7C4s1AThlwx0egON+7BXzUlPwaylhyXcIKIgZ7naDUfERKrBrJyCTsd4nB4jkPHsQ
         dHxA==
X-Forwarded-Encrypted: i=1; AJvYcCWjUwae0VHlKXJ+Vd0LT0CgCwH4Z+vf+Tukjqo1VyT/8kLHN2V2DvC2QHBrhFtD4MzVbXa4rpN7ppbzr5+V03e4kC74N/mLsgBSNbj5iyTCoE7mVUdj/oI5tpPrfloWLBTojgdXLgdJtUDvYPQ=
X-Gm-Message-State: AOJu0YwvWrRovALOP8lQPVilfFhlcPaS/CNYcUBJPIuvncUFywq0jozT
	oJVOfePjUei94llWk8Jynjs7vQ2frMnXSwD73LyV+c67auxiavsntT1mTnNl
X-Google-Smtp-Source: AGHT+IGQdvPgqTzpk0WRuVzdLZsIt+PIefsocHXzFjrLAXub+kn/VbRC5GaMAeWVaox1/rcijULwdw==
X-Received: by 2002:a17:902:8695:b0:1eb:85d:8973 with SMTP id d9443c01a7336-1ef4404cd5fmr228087965ad.58.1715889968418;
        Thu, 16 May 2024 13:06:08 -0700 (PDT)
Received: from localhost.localdomain ([187.120.157.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0977e2316sm27310235ad.193.2024.05.16.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:06:08 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	kvalo@kernel.org,
	rafael.j.wysocki@intel.com,
	daniel.lezcano@linaro.org,
	johannes.berg@intel.com,
	dmantipov@yandex.ru
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [thermal] adding check if the thermal firmware is running
Date: Thu, 16 May 2024 17:05:53 -0300
Message-ID: <20240516200555.33982-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in the dmesg is showing the message "failed to read out thermal zone"
as if the temperature read is failed by don't find the thermal zone.

After researching and debugging, I see that this specific error is
occurrence because the thermal try read the temperature when is started,
but the firmware is not running yet.

For more legibiliti i create the NOTLOAD error code in the errno-base.h,
and in the iwl_mvm_tzone_get_temp() on tt.c i check if firmware is
running and I set the NOTLOAD code for ret variable and goto out.

After this, in the update_temperature() in the thermal_code.c i received
the return of thermal_zone_get_temp() and check if return is NOTLOAD,
because if it is, I print the warning message "firmware yet not load"
and return for caller

The thermal_core.c i think that is generic for any thermal drivers and
not only used for tt.c of course.
But if this ipotetic driver not check if firmware is running before read
the temperature, the thermal_code.c is work as a before this change.

After this change, in my computer I compile and install kernel in /boot
and in my dmesg the message "failed to read out thermal zone" is not
show any more. In your place the warning messafe "Firmware yet not
load" is showing.

I would like to thank you in advance for any contribution, suggestion
or criticism of my patch suggestion.
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
 drivers/thermal/thermal_core.c              | 10 +++++++---
 include/uapi/asm-generic/errno-base.h       |  1 +
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 8083c4b2ab6b..dd5725db06d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -620,8 +620,14 @@ static int iwl_mvm_tzone_get_temp(struct thermal_zone_device *device,
 
 	mutex_lock(&mvm->mutex);
 
-	if (!iwl_mvm_firmware_running(mvm) ||
-	    mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
+	const int res = iwl_mvm_firmware_running(mvm);
+
+	if (!res) {
+		ret = -NOTLOAD;
+		goto out;
+	}
+
+	if (mvm->fwrt.cur_fw_img != IWL_UCODE_REGULAR) {
 		ret = -ENODATA;
 		goto out;
 	}
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 34a31bc72023..4116d312d4a1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -414,10 +414,14 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 
 static void update_temperature(struct thermal_zone_device *tz)
 {
-	int temp, ret;
-
-	ret = __thermal_zone_get_temp(tz, &temp);
+	int temp;
+	int ret = __thermal_zone_get_temp(tz, &temp);
 	if (ret) {
+		if (ret == -NOTLOAD) {
+			pr_warn("Firmware yet not load");
+			return;
+		}
+
 		if (ret != -EAGAIN)
 			dev_warn(&tz->device,
 				 "failed to read out thermal zone (%d)\n",
diff --git a/include/uapi/asm-generic/errno-base.h b/include/uapi/asm-generic/errno-base.h
index 9653140bff92..8b92c41f7993 100644
--- a/include/uapi/asm-generic/errno-base.h
+++ b/include/uapi/asm-generic/errno-base.h
@@ -36,5 +36,6 @@
 #define	EPIPE		32	/* Broken pipe */
 #define	EDOM		33	/* Math argument out of domain of func */
 #define	ERANGE		34	/* Math result not representable */
+#define	NOTLOAD		35	/* Firmware yet not load */
 
 #endif
-- 
2.45.1


