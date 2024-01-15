Return-Path: <linux-wireless+bounces-1927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BB82DB88
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106C128208C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A561799E;
	Mon, 15 Jan 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GN3oz/kl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C617995
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2a17f3217aso975851066b.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705329571; x=1705934371; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rUt6qUSC7rZj+/61nIeLHFSyBQOSIsG662zkAFFLuco=;
        b=GN3oz/kl1jvvTaZ6ZwItnMJd/QRBEQ7quPklnQ698/HP6RuTl39DTA3ZmiiCQYUaL5
         AUQ5gOGn9W56njXxEQqSVZqJSXpwhRGkGfP5heziIdvjY4AS0TZkmWZgSJQgHo9ByUqA
         MTW9vzQOCIhi9hGJOLsqMtZrbHS50tyrFkdmt1v19YIvR3HXOCSQKiWkDAyO/omZyeIf
         UdFIeon9WkYYRx96PN72SOPyKykAwNTRbIwXwn1vuWxWGNmraJZ5WA6fQrh25Y459yYt
         j8Y+xxjIw6tmc/cSYdCZL17FuO7oXWOSJC03AboAsbAEIqftk9SdQEtABuMI5YvsrmIp
         Y++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705329571; x=1705934371;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUt6qUSC7rZj+/61nIeLHFSyBQOSIsG662zkAFFLuco=;
        b=WAc6xiqU4Mb28eZ/HsA2yGR/dy/5nIclZ/6ZRg1BCl8EVBckJKXqlblBerRO47Zx1/
         0pVr81ZviVnPNBfsSXpDZk9cmWTGPXVLr84jCP+B2UDVkCE7mWeqawN0FIFKkx6tqZL+
         rQZH4dvdo5E7Y/jtBNOnsQoHpDPCFvrpG0/aJe9NzrcezCGnqwyQhwdWATxqG1brJpDP
         Mt8P+69TgSDUJ6JDEEveUKNhjXphXAMRt2QZ1t/g3UQ89CIWE5AY3Lw86UZJWLG9Pwb0
         OCGk1pqNOjiMonSz+2ZSnmgp28Avubb3mnRrk5tUpckotvD1lDAqoYBLB41QIYgwGgo6
         3pGA==
X-Gm-Message-State: AOJu0YyHvMVVG/90nG4AKZWpDxe72flBp17bN/yNrF5blGfyEqLBZ8Qr
	UQGh4f3nV/TbsEiD57eLcvwAEdmQaY2+EQcrLqk=
X-Google-Smtp-Source: AGHT+IHMWuPKY2gsrGW21Hb+Dr9sHBaRGoxtP+zhdj4/kr9soYMxCpRKk+OpNBcEp/vokTtmcGGLu+qGxd2G73jn0qc=
X-Received: by 2002:a17:906:da85:b0:a2c:8649:67e1 with SMTP id
 xh5-20020a170906da8500b00a2c864967e1mr3536459ejb.87.1705329570960; Mon, 15
 Jan 2024 06:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: coldolt <andypalmadi@gmail.com>
Date: Mon, 15 Jan 2024 16:39:23 +0200
Message-ID: <CAJvGw+DQhBk_mHXeu6RTOds5iramMW2FbMB01VbKRA4YbHHDTA@mail.gmail.com>
Subject: [REGRESSION] 6.7 broke wifi "AP is in CSA process, reject auth"
To: ayala.beker@intel.com, gregory.greenman@intel.com, johannes.berg@intel.com, 
	linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I'm on Arch linux, updated the kernel from 6.6.10 -> 6.7.

Now it doesn't connect to my 5GHz wifi, to 2.4GHz it still connects.
Also the earlier kernel version still works. Output from "sudo dmesg |
grep -i wlp2s0":

> [    6.049600] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
> [  131.095861] wlp2s0: AP is in CSA process, reject auth
> [  132.143170] wlp2s0: AP is in CSA process, reject auth
> [  133.599906] wlp2s0: AP is in CSA process, reject auth
> [  135.549325] wlp2s0: AP is in CSA process, reject auth
> [  145.510438] wlp2s0: AP is in CSA process, reject auth

I notice that the commit c09c4f31998bac, which was added to kernel
6.7, introduced rejecting a connection with that error message "AP is
in CSA process, reject auth".

My guess is that commit is the cause of the regression.

I have a Dell E5550 laptop, lspci -k shows:

> 02:00.0 Network controller: Intel Corporation Wireless 7265 (rev 59)
>        Subsystem: Intel Corporation Dual Band Wireless-AC 7265 [Stone Peak 2 AC]
>        Kernel driver in use: iwlwifi
>        Kernel modules: iwlwifi

Output from "sudo dmesg | grep -i wifi":

> [    5.198655] Intel(R) Wireless WiFi driver for Linux
> [    5.221823] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
> [    5.230357] iwlwifi 0000:02:00.0: Detected crf-id 0x0, cnv-id 0x0 wfpm id 0x0
> [    5.230513] iwlwifi 0000:02:00.0: PCI dev 095a/5410, rev=0x210, rfid=0xd55555d5
> [    5.272339] iwlwifi 0000:02:00.0: Found debug destination: EXTERNAL_DRAM
> [    5.272344] iwlwifi 0000:02:00.0: Found debug configuration: 0
> [    5.273573] iwlwifi 0000:02:00.0: loaded firmware version 29.4063824552.0 7265D-29.ucode op_mode iwlmvm
> [    5.551806] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 7265, REV=0x210
> [    5.565689] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
> [    5.566606] iwlwifi 0000:02:00.0: Allocated 0x00400000 bytes for firmware monitor.
> [    5.577802] iwlwifi 0000:02:00.0: base HW address: 34:02:86:17:53:27, OTP minor version: 0x0
> [    6.049600] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
> [    6.559212] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
> [    6.638617] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
> [    6.640695] iwlwifi 0000:02:00.0: FW already configured (0) - re-configuring
> [    6.657163] iwlwifi 0000:02:00.0: Registered PHC clock: iwlwifi-PTP, with index: 1
> [    6.710776] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
> [    6.790826] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
> [    6.792667] iwlwifi 0000:02:00.0: FW already configured (0) - re-configuring

#regzbot introduced: c09c4f31998bac

