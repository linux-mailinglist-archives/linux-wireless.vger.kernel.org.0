Return-Path: <linux-wireless+bounces-21742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B183A93EC2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 22:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D98A2990
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8FB215066;
	Fri, 18 Apr 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4Lu0/5V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D32A1C9
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007517; cv=none; b=Z7g7e5eEMXW0J/NN7dYoB7/7/+5Ad5PQEDwGVRwNXzyqXzjBt1YhkH0m75I3juzy5Jb8Pw4OckiBAGvUmaS3u+tJPml/n1veHUkI4BdbPn54pQktrRcnnwNKM8y47tC8QaHbSuY3qDQWCqDxEAYfbamIzkrfvA8npBrACD3ro/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007517; c=relaxed/simple;
	bh=iEKVruJyIJHSriZDIR8Q9KbH766leYZe6Tr3qCjlNdc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fifrZjzJxspVfOqA58ojzG54DVxoBdVFPsSSBkDH7bQ4GgcyPXph2nDLPs78Jm2TM9BKs7G7wxTgvgV6XEerWz26Pvgw+ZtnJuj2ChyrBgSi4xfUnamwChZ2kCP71iwU7nBTVY4df1RskboOsPNLgAXBTKNv3yx0JMChQcf/R9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4Lu0/5V; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso20660281fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745007514; x=1745612314; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V6o6RwR1vw31OglLkXtrPoEomg6BFXZVXUmxVdmE0qQ=;
        b=l4Lu0/5VSwgwFEg3c6MSbpaV9AbFe8g/kH450RXtvKYJVQqOnH0FgPmJkK+r/1JBzt
         QCZoPO251QA8WB8uNk2WxpAVzxRJcexDry1oaAKDibBl5y47aHhwb7/OhJJqCkINhNMW
         5Ub5gvaNTM5ufEOPZrspS0Vh/4v4xkP68UOClIr518nbI+NkhuY6EkXgb12XudoeGQVh
         bQJJcHcFaMPMTtAS8ruEkvskx9Xrdf13i8dVBHEZD4sfL0mbiA4Lx3JP4ptV39re3g/J
         cIiwkTuakxXXEe9xWwM+nTudOqRdgYjHK5Mlm1fTsUX5I13MNoRsfnCq+Z1NiD7dMvLt
         /c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745007514; x=1745612314;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6o6RwR1vw31OglLkXtrPoEomg6BFXZVXUmxVdmE0qQ=;
        b=XNKz5eNRfdKjWBX8hz0cHDS8pU0i5LtBSzMzi8yqAYXetM6jkVu3kgH43WgZ0vWDvn
         4eONZ4jZzX9ENW53dC3gPtutcIqsfQjxWHeS9mrQiuLCywbrIFozJgfMgUqPA3Td1MOr
         /Ai5oCr81RzkMKXf0spjyrt59JwHKgGjPP+OXzT65CH/lL2P4b2kqFwGMh+ylH480YiM
         Kk6jy3iW6AN6zVdNsWm8PA4XwM7NpJ6T2/b3r5sCYAC7AbjG7Opo/TM5c7Cpix0b872g
         SSZYXXZb6w0mGsWbP+zlinfV0XEEIhxsdIns+pJxm5zqWMv4MOvJuSaJkeRkBoIpvs8s
         Zxew==
X-Gm-Message-State: AOJu0YxqxwYr1AyFL2dQ2iubSIetoez9qB5opNN8xVm5YEDwFRawiEhO
	oHlXdO45jzolbN7QucwXzYXRr3J3ze+Al3W5etkx3GPoB8/MoHcVzlZZwQzEMKM+3ZYKBKiNjTU
	/us8I7uiDmFwSIdllA3RuWK9uWvLRHtWc
X-Gm-Gg: ASbGncv6mHMTdAtTsM0Pax1RAF4UVtrMQaDX8nsUq6XR3O8aJZOwgHbhKaTWN5M0LDY
	kiARG9vjIuJLeQdjAuIaXoi1G/mjAh8Qmrf549n6PKELXy4OzGlH0Mr4wmIPBNrFaYyH+49ZnIn
	tEif2afEKGZn+jSM6tawST1A==
X-Google-Smtp-Source: AGHT+IE4C44VkGRW5HIqq1E3hbOAr5PFoLvdPZKc9ZKzX4qyMHvZ5RO0QWViKxGFJ77c70mN4y+18Q0HY3QZ0oLg5H4=
X-Received: by 2002:a05:651c:312b:b0:30d:62c1:3c0a with SMTP id
 38308e7fff4ca-3109054a0a8mr14224601fa.25.1745007513927; Fri, 18 Apr 2025
 13:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nicholas Popovic <nickpop.development@gmail.com>
Date: Fri, 18 Apr 2025 16:18:22 -0400
X-Gm-Features: ATxdqUE7jC3VEhibV2IJSZL0Dke-_tesk-w8S5o3ZXAsTpi02PMgjrT4T8CGd1U
Message-ID: <CAM1C61G96L+5jYxJ+-JzV0sF0fHd_pLdg7yP9VdTwKCLBG8FHA@mail.gmail.com>
Subject: [BUG] mt7921e: Missing PCI ID 14c3:7902 for AzureWave device [1a3b:6040]
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Linux Wireless developers,

This is my first time sending a bug and I did my best to follow best
practices - please advise in the event that I haven't.

-----------------------
Issue Description
-----------------------
I have a WiFi card based on the MediaTek MT7921 (Device ID 7902)
chipset which is not being recognized by the `mt7921e` driver on
recent Arch Linux kernels.

**Hardware Information:**

Output of `lspci -nnk -d 14c3:7902`:

08:00.0 Network controller [0280]: MEDIATEK Corp. Device [14c3:7902]
        Subsystem: AzureWave Device [1a3b:6040]
        Kernel modules: mt7921e

(Note: `lspci -k` shows no "Kernel driver in use" for this device).

**System Information:**

* Distribution: Arch Linux (kept up-to-date with `pacman -Syu`)
* Kernels Tested (where issue occurs):
    * `6.14.2-arch1-1` (Standard Arch kernel)
    * `6.12.23-1-lts` (Arch LTS kernel)

**Problem Description:**

The WiFi card is detected by `lspci`, but no driver is automatically
loaded. The `mt7921e` module exists on the system, but does not appear
to claim the device, likely due to a missing PCI ID alias.

**Diagnostics:**

1.  `lspci -k` output for the device shows no "Kernel driver in use".
2.  Checking the module information on both tested kernels confirms
the specific PCI ID is missing from the aliases:
    ```bash
    # modinfo mt7921e | grep 7902
    (This command returns no output)
    ```
3.  `ip link` does not show any `wlanX` interface.
4.  Manually loading the module (`sudo modprobe mt7921e`) does not
result in the interface appearing, and `dmesg` shows no specific
errors or probing messages from `mt7921e` related to this device
(08:00.0).
5.  A search of a local kernel git repository log (using `git log
-S'7902' -- drivers/net/wireless/mediatek/mt76/mt7921/` and `--grep`)
did not reveal any obvious commits adding support for this specific
PCI ID (`14c3:7902`).

**Expected Behavior:**

The `mt7921e` driver should recognize the `14c3:7902` PCI ID (with
subsystem `1a3b:6040`), bind to the device, and create a functional
`wlanX` network interface.

Could support for this specific PCI ID (`14c3:7902`, Subsystem
`1a3b:6040`) be added to the `mt7921e` driver? Please let me know if
any further information or testing is required.

Thank you for your time and work on the Linux kernel.

Best regards,
Nick Popovic

