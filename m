Return-Path: <linux-wireless+bounces-10061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7D9297CC
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 14:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E3E2815A8
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B11CD24;
	Sun,  7 Jul 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw8MYAqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640901CAB2
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jul 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720354971; cv=none; b=qrIuSh0CgyDxtAKFe45bARhTqzuD4y7K3YJe8HQga/UBwlI4Wwki3cSkJ5e8nEC4fZPbttoolNgYYJDk4gZXCBTO1Od1svorXByfOeLrf8yxP5crsEUdVWXog/mj1FTn0ySIl0AfWFEYOrtUNS/WZS3crzB+jM0/hR2fHp7RrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720354971; c=relaxed/simple;
	bh=+CXFIVfFvvwW4GvASmxmUlnYwcL+GLAgC+SyDaqFxw0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fe3YKwOlx1ureSx+INa0evmMqJxwA1Vyp6Wzj2VeZGgB9+zHAagNZBHvZbcCTqKnt8X9WhiMfXBQzzMNXz0aKQ+VTWj3opxNRe7FVmmQvHVBvoLzbjLqtK4qzABIiJQaSa9ZCOMMweJfmlhzR0y+KZ3ezuY4fbPPTdS012y4Lq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw8MYAqN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c9d3e593so228018866b.0
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jul 2024 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720354969; x=1720959769; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9sc60lciZAXb7QzPxcfPWmmHEtScDELqGwwdUh19ys=;
        b=Dw8MYAqNPQ7Dj40Nb+LJh0XChtlDGTkq5MErhxRCj/HDBJj7rEEWcxWlpROqShV4id
         mHfKn7pIBPyNQ0YJtqX4sIBZb1zcth1xqS6cnJRGefETdonidlR7K+9GGBQAVbAxEWUM
         9F224AXqS4VQyouKapyy1oZCB5r88+Lt7TvB8XGsxKjc/eia2VgemtIzB0/hes8WWDjB
         NimDuRQR3mGmWCVUmM/R+AUI/sO0812wFs4mvJIrqMxOj6BiyxtDA3z94SpnD0oHFr7N
         cUlKpjlmJZnszoSLJAoklOawdiv8T1/5D2o1+XfQBKhJCIlfa/zL9ZFvy7Hzb/pHdG/l
         D6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720354969; x=1720959769;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L9sc60lciZAXb7QzPxcfPWmmHEtScDELqGwwdUh19ys=;
        b=sY75dnvpDpk8EOzwy+xw9pHImK3361zeysBGEARZoxdN5qzzfQ9QGawAXZ95ny3F8S
         6IsgWLTE5GDNSF7OL+Qbt1bTSONhA85OoMcVz48hxWnbOHSzoQEEJY3VIPQNmKOS5XzC
         ESNSmSojJTX6UzX2HDQU7/zK0zV1lnf9cd+y2Z4ZKPL8lp86S6tVF7SxV7rVM1XkSaqe
         ZN++gJhkrZMLL+OqTU5qg4kgugiCIM4k2TXUoTuLAgKhn42KbOX2fZtv40hB/Jpu6Ic7
         mRmN1zjUT0sRuG9dy3DevIZEuawPnNQcX0V0nmqMUm9Bi79xUdL7MDHsBt9PEWfQ+RUF
         04Sw==
X-Gm-Message-State: AOJu0Yzm4KXDmaFCm0kYncw1u05OOdk5Up+ONOl2F0Evq2QK8DS5Nme3
	SV515pIf0zGXISkUGZHCjuNvEVcYQBSxYexB/HO73a77SkobTjf7mH4Kl3WVkA0=
X-Google-Smtp-Source: AGHT+IFmQiydKHDg+5QZGpROqyuHJEfT81GJGQDnm9AdGvVwed+uKdBuMElrzWAWCTh1tNRjmQ/RXA==
X-Received: by 2002:a17:906:5a84:b0:a77:cf09:9c5f with SMTP id a640c23a62f3a-a77cf099ce8mr425339766b.37.1720354968353;
        Sun, 07 Jul 2024 05:22:48 -0700 (PDT)
Received: from [192.168.0.100] (014-189-172-081.dynamic.caiway.nl. [81.172.189.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c720a09dsm235355366b.218.2024.07.07.05.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 05:22:48 -0700 (PDT)
Message-ID: <1c6684f6-d3a8-4eaa-842d-c21fa2dd81c1@gmail.com>
Date: Sun, 7 Jul 2024 14:22:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, arend.vanspriel@broadcom.com,
 nikolay.nikolov@bench.com
From: Nikolay Nikolov <dobrev666@gmail.com>
Subject: [PATCH 1/1] wifi: brcm80211: brcmfmac: Prevent sdio bus going to
 sleep while transfering data
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Use mutex to prevent sdio bus to be put to sleep by the sdio_bus_watchdog
while sdio dataworker handles sdio_dpc data transfers.

Signed-off-by: Nikolay Nikolov <nikolay.nikolov@bench.com>
---
  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 6 ++++++
  1 file changed, 6 insertions(+)
---
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 6b38d9de71af..26d0bce6cedc 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -524,6 +524,7 @@ struct brcmf_sdio {
  	bool txglom;		/* host tx glomming enable flag */
  	u16 head_align;		/* buffer pointer alignment */
  	u16 sgentry_align;	/* scatter-gather buffer alignment */
+	struct mutex dpc_mutex;
  };
  
  /* clkstate */
@@ -3724,6 +3725,7 @@ static void brcmf_sdio_bus_watchdog(struct brcmf_sdio *bus)
  	}
  #endif				/* DEBUG */
  
+	mutex_lock(&bus->dpc_mutex);
  	/* On idle timeout clear activity flag and/or turn off clock */
  	if (!bus->dpc_triggered) {
  		rmb();
@@ -3748,6 +3750,7 @@ static void brcmf_sdio_bus_watchdog(struct brcmf_sdio *bus)
  	} else {
  		bus->idlecount = 0;
  	}
+	mutex_unlock(&bus->dpc_mutex);
  }
  
  static void brcmf_sdio_dataworker(struct work_struct *work)
@@ -3755,6 +3758,7 @@ static void brcmf_sdio_dataworker(struct work_struct *work)
  	struct brcmf_sdio *bus = container_of(work, struct brcmf_sdio,
  					      datawork);
  
+	mutex_lock(&bus->dpc_mutex);
  	bus->dpc_running = true;
  	wmb();
  	while (READ_ONCE(bus->dpc_triggered)) {
@@ -3763,6 +3767,7 @@ static void brcmf_sdio_dataworker(struct work_struct *work)
  		bus->idlecount = 0;
  	}
  	bus->dpc_running = false;
+	mutex_unlock(&bus->dpc_mutex);
  	if (brcmf_sdiod_freezing(bus->sdiodev)) {
  		brcmf_sdiod_change_state(bus->sdiodev, BRCMF_SDIOD_DOWN);
  		brcmf_sdiod_try_freeze(bus->sdiodev);
@@ -4525,6 +4530,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
  
  	/* SR state */
  	bus->sr_enabled = false;
+	mutex_init(&bus->dpc_mutex);
  
  	brcmf_dbg(INFO, "completed!!\n");
  


