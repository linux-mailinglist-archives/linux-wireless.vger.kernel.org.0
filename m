Return-Path: <linux-wireless+bounces-16616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796459F7CD9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 15:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8039C188B248
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CBA2111;
	Thu, 19 Dec 2024 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv6TUz57"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2905224B01
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617538; cv=none; b=YrnNTSkwwd3zo0TbtNJDpNRINdX6x3xKz6N/1d+TdD9j23uOnAco0ohrUmBFKablGXYOFpd6AeT1q2g5p3b0wCiMLs5aaM2o8/I5/1QPIHj5uCShgxfiyqgj3WSPWUR5t/VoIoNiOCjzi/fEQhzJE6cSqF3WoRSqjQOQfk758yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617538; c=relaxed/simple;
	bh=C2SdeWmVJC3/ZNqc8R5l7M1aU8Gc2ZrOmRqIVQ4/IL4=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:Subject:Content-Type; b=TNP7TgbZgFXUxPH8FYfSjZtCHtcSfuT2AanQfB05nHML2A3xHH/c4L0kDi6+Y6pY4Xnsz4JN8gjEbZNBZHkUQcY122Oa96A/E0lSQDBQOHfgysnTQzELXm3uRL0lszljkcwva93olBI99M1lEhg8lYXEIM6+HMvJu1727lgBZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv6TUz57; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eba347aa6fso432358b6e.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734617535; x=1735222335; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S9fNTREz8asEfx7P7gDaLMrioESFXSuYHFX2Glb5qI=;
        b=Fv6TUz57DIUNWl2BuoNRSKRG41u09xt9znsJ0199Mbe/LwlwnAPx3kBpZDC4AVVujQ
         6B6bea2u2QBDx8Fyw6/1QspnCdDRvezviQi9WsS3+vks/HANR4i/cSraQQlONQFBwsvO
         D/40zaaU0VEdh1NW4SXZV7T53fk0dfq7E9We6jIeuwf2E4KFLffT80LmiL5vaQNJrKlr
         tiYZx7UQwlyngEc0EaqTNpRC4pcmR+uc4nBHuio1LwiAuceBDoszKr/wi3ZdRygUyDiJ
         91cuWfpO24n2AnMv7YOFWeKfc87LQ6eu9g9oQzCbNUWsHYSqt/JJl5VkrJLZdLxHR9iJ
         +e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734617535; x=1735222335;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S9fNTREz8asEfx7P7gDaLMrioESFXSuYHFX2Glb5qI=;
        b=H5tuWjKjeZLWzvQUNp9N62zN/8tSouc/Y4xKtp4Ed4IntbsDlDzWit1KjVAWc78+90
         nE9G71xMhAAfyAUGelAs8pdoRif0gabqk7VHFor2Ffrw14HMyQJhzsHYKHqeBrBF/0P9
         rsBxdYhYsxip+sPjJD64uVRp4D4V08qsG9J9E9VKstImsrzvzleqWW1m5g9F3a0Karc2
         NegVrACMJmGkqTXQIPVQePAQt5nOWTEK45MVJkFgONKNjkS8uX6aKGDnoVCAT4tWBG/F
         WxSB2bVmLAKItP45vDtqVKyHO6Q9p+3OUNOQYygvG7eLVNgtmXM+1yDiiXQFVGf9Min+
         dCvw==
X-Gm-Message-State: AOJu0Yy057hC68p4L5VTLe5r016fQFHPSaSHyLg85taCG9pZMxgmMrNd
	fje/UkL++UqX5+iJ6TAu9uVUil4HSejgX1zpY2Ju4swXRjlOXfzu8cugdA==
X-Gm-Gg: ASbGnctwM5Qp0H03oxtlbim95liMKUQ9gU1PEj731SmVnhGxkpN/5qIXnWIA1T8Md5A
	ZPjo9DgK7+wW1qS3Pbba9MAgfNqBkvyv+Z4UFMJY+L1wM5FLuJturX4rhgSyLTlkdHhynEYDo2k
	4C34EWEFpe3NhqyZ0SNIqgjnMYbSLB7dYfNFRZ/0SHeWka6xHEDTIdYsXqilYPaDumRYstdv9aq
	1vF1NI/tTADQnQQWtXEGEHiO/QYmEjX109WsrG20NRcC7auaThr5nnfiIiZCmVW
X-Google-Smtp-Source: AGHT+IFe05NGEpKKTGtf1nDoUJk8jKush4Kdhrpt/t3T+MTKPzAVCnqFRenp6CT5Gdmt770kRqesNg==
X-Received: by 2002:a05:6870:819a:b0:24e:8987:6f34 with SMTP id 586e51a60fabf-2a7d074dcc7mr1665333fac.3.1734617535512;
        Thu, 19 Dec 2024 06:12:15 -0800 (PST)
Received: from ?IPV6:2600:8804:8c40:89::94c? ([2600:8804:8c40:89::94c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74c0012sm320280fac.15.2024.12.19.06.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 06:12:15 -0800 (PST)
From: Nick Morrow <usbwifi2024@gmail.com>
X-Google-Original-From: Nick Morrow <USBWiFi2024@gmail.com>
Message-ID: <e797f105-9ca8-41e9-96de-7d25dec09943@gmail.com>
Date: Thu, 19 Dec 2024 08:12:14 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH] wifi:mt76:mt7921u:Add VID/PID for TP-Link TXE50UH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

From: Nick Morrow <usbwifi2024@gmail.com>

Add VID/PID 35bc/0107 for recently released TP-Link TXE50UH USB WiFi adapter.

Tested-by: Shang Chieh Tseng shangchieh.tseng@tsengsy.com
Signed-off-by: Nick Morrow <usbwifi2024@gmail.com>
Cc: stable@vger.kernel.org
---
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 8aa4f0203208..e3459295ad88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -21,6 +21,9 @@ static const struct usb_device_id mt7921u_device_table[] = {
  	/* Netgear, Inc. [A8000,AXE3000] */
  	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9060, 0xff, 0xff, 0xff),
  		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
+	/* TP-Link TXE50UH */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0107, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7921_FIRMWARE_WM },
  	{ },
  };
  
-- 
2.39.5

