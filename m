Return-Path: <linux-wireless+bounces-8140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDB8D096D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8441F222B0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BA155CA7;
	Mon, 27 May 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZQ26Yb3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB026AE7
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716831312; cv=none; b=S/q0+G/WBYiMq+3AjrqsKtZXgt53MjQznj2vg2l15BPxJ1TB0tV3vyGa6ijHYhm/UnhvIJcUBj/IT9wE2kv/nkPJNcDJjV/sHLO2xyskstRoCsFhGqnNQZLctlZ5FkaOK1UWZl6om/z4Oj1yP6llfh2Boaytyqc5kGmYy4P+2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716831312; c=relaxed/simple;
	bh=p+ytuN091lwssrUIuAngaqCBwxVb8S3F7IasgiphOkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ieydz3/1sPU7kKRQaHan6KTaNAx5VlfUQ3qB66B6WXzGPK9WPWXMJgQqIoNngLW1WKMYCTh+lFnepBeF+lN2/ImuCMwZVL0eQ5UGTeT3MpoqR+4rRzyocarrF+wSOGa74AZs8rtW0krMFliXWKKkW9VhWjB1hgnZ+B6UY3VDcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZQ26Yb3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5d67064885so4240966b.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716831308; x=1717436108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lInDYFXsPaMxIXNWZZrIuwUqp1+U6OdY8xc4NrZsDgM=;
        b=bZQ26Yb39OlqMcvkKR9Fm9OwcOBd0ss7PXjFTvO3ZSjmSvXT9tBSS6u2YKnkcngrJF
         c84yC+8YgTfVmgfbSCSk6hh7F6f9npBB5isOwTFOXPJRT4IRH3v4JD49aYBsAqkHdGmx
         sY9CD2NNvwZ8fWfQpjHVqhH34wvg8sZ+lhgMcA/Ig1yhABuxAPqnRi1j1VAKifPTcfVp
         vFLUrPbpjt9njUYc+4tf1nMrwNhCg3Isj+7e2fkabiqFZKUkNSy8k2IA4HB2ZjKIKFmu
         My+9TJIqPXbcX/APVfvVy5Mum335DHXTBcXZsgX7SM7JIVyGQK/voeOb24ipgdtFzj0I
         2igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716831308; x=1717436108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lInDYFXsPaMxIXNWZZrIuwUqp1+U6OdY8xc4NrZsDgM=;
        b=bNgcgbBptvTKRLv5x0h006ifCsg0qKVA4M8tbFrg2VwF8iaTM8axdCwrAcrBFQxDq/
         /wwA5sHmsVNIwYac8eIWkxL0WtY3Hdx4M4iBDjTrXGC0Y0QjGhKbY5zw6Ks6kbyQtKrm
         2lWtNJ0/dfiJjMAC6ZcFrcvcwnF3G9j5MiMUi9mnstPcgbwzNCgtOxuhtreKoDLrcVWN
         t0U+7nOQ/GC8O3HUzjRCXxWIRMWieuD/lrioQhgtZvM7ecEaqnPE/pi1tlXovMvAes4e
         LL5S3P+3nAHe9Cr8/YHtP2tmOKaoV8Yxlki1k4CJg7Ne8620qCfIp+lGcAnbn47soW8w
         3cow==
X-Gm-Message-State: AOJu0YwYPLCW54IpwaZ+7w/kxSTUrUOB8B6+THxYRX3gI1XO0erlrVSB
	KeVk5ot1ts9QpioUEWTePcLBKy42HCT+QfSZ/0QuS1LMmYccKBkMabZznNUY
X-Google-Smtp-Source: AGHT+IGK7JMUHvO+1lhfJMcRJ0UCH3oZnqMYE+cqBklHALv9s06dN9HXe7LXeel6gyqDg2KoB0kBTA==
X-Received: by 2002:a17:907:7d9f:b0:a62:b36a:eafa with SMTP id a640c23a62f3a-a62b36b0213mr886926066b.57.1716831307537;
        Mon, 27 May 2024 10:35:07 -0700 (PDT)
Received: from mslusarz-hyperv.mshome.net (1779df417e104.rev.snt.net.pl. [213.192.104.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc500a1sm512070466b.125.2024.05.27.10.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 10:35:06 -0700 (PDT)
From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <mslusarz@renau.com>
Subject: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
Date: Mon, 27 May 2024 19:34:52 +0200
Message-Id: <20240527173454.459264-1-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marcin Ślusarz <mslusarz@renau.com>

If I don't connect to any Wifi network, after around 10 minutes, the device
hangs with endless spamming of:
rtw_8821cu 1-1:1.2: rtw_usb_reg_sec: reg 0x4e0, usb write 1 fail, status: -71
killing both Wifi and Bluetooth part of the device.

On arm, just leaving the wifi device unconnected kills it in up to 20 minutes.
If I keep restarting wpa_supplicant I can trigger it within a minute.
Looping "ifconfig wlan0 down; ifconfig wlan0 up" also triggers it within a minute.

On x86_64 system the only way I could trigger this was via ifconfig loop,
but it took 3 hours and 20 minutes to do it.

The only thing that can "fix" the device is replugging it.

I found out that the reason for those hangs is a power-off+on sequence that's
triggered by the above steps.

Disabling power-off for that chip "fixes" the issue. The patches below
implement that, but I'm not seriously proposing them for merging.

Marcin Ślusarz (2):
  wifi: rtw88: use RTW_FLAG_RUNNING for deciding whether to enter/leave
    IPS
  wifi: rtw88: disable power offs for 8821C

 drivers/net/wireless/realtek/rtw88/main.c | 14 ++++++++------
 drivers/net/wireless/realtek/rtw88/ps.c   |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1


