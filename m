Return-Path: <linux-wireless+bounces-24321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F0AE3259
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 23:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABFC816CAEE
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Jun 2025 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C27FBA1;
	Sun, 22 Jun 2025 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er0j6+JA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D900C2E0;
	Sun, 22 Jun 2025 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627881; cv=none; b=C/cflnjEbSN1hlbpMJ2HhKR3NBgRwGDNnpzk+fXZ7mcfmN7U3n+7qWM+tluDIkIsL7DvCBre0MNfyvQmPkgSjXvqFPS/cQRWWpRU9DFUM+xp2BJhbyOts/s51dLA7e5lI6uUsftwuTpPTpoXgW7xXc4LmjWUnWxr8rGpkVZmbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627881; c=relaxed/simple;
	bh=IdW5b/ilQ2wpV5HyTgBGLknyissGVZ99awUBdPrUHEw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DlhASIEOE2teDj7sLbN2GWpid104F2jFpZA1xN0PY4LsxmKmNN4lvv11kbcc4jLgykvNWJ8yY9AL8gtLzIoXd88Ux2ddBatW1Du/XJNZiYcKO9TjGF9AzZmt3iEx3cSQdeEIxL5mPPaRFXMMjdJbj6wzU/4aEOh6QCnBmO03/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er0j6+JA; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3139027b825so2625484a91.0;
        Sun, 22 Jun 2025 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750627879; x=1751232679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IdW5b/ilQ2wpV5HyTgBGLknyissGVZ99awUBdPrUHEw=;
        b=er0j6+JANzClYFfbe2EuFJcWVBFjeDvQMCZsaX63d8os6GbNgv1BjYPQs3AGjLP0wP
         5ktP8jE9RZShC2apqXwQAZ0StnbiulKNBEBxlm/+ySeorRhOCbvxg73FC7YryhUu1XHb
         J4o7Uwd1jGU8uOGWTiW4+dnE9CbA6sEHH4pyLBXJOl0gRwJMCC4sh1Q5/3GhzmcIqeBC
         zzJ+NeXrNJ2oNW907IlHkb33aJiG0URYmRMgmAGLUt45odC6pZvHLjI2BVUjPrNIkUFg
         rNMIc+3sHpOO41NK97Ana2wUhR+qNUjBf5rOEL1eHm+jDv8eSBJKU7YOQ9rKjPDCbOc1
         BcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750627879; x=1751232679;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdW5b/ilQ2wpV5HyTgBGLknyissGVZ99awUBdPrUHEw=;
        b=mwh7zo55SJc2BGqtOMOIsT7SIWmXk351KGrmpVJf7vTUuLyvWk6Czw13+bBWCpcB0n
         NacHBgrl9/xwfADIUKcdxZNpYBVvKxUD3+vKyJp4VXCADPBpnt/t8wsi/fccRVnMcOzC
         tQEsmGLWGL8cggLdT/D14C9/GA2rBWc+fsvhe5szpyu3fCFDvnKQB4owlFV91kurkbiy
         bC06WL4IyJXTT5HvdhbKKA/LA1pNvrn3+RdFfBKXeDUYPe4QDL6LMqXlOy8Y/5HZWCyH
         fz0QW0XLb28Jr8eoQnqYSLWMqX4HqCtFLb41K37RHKsX+5mCIexeXn1sOcXxoq3qtD4X
         8gUg==
X-Forwarded-Encrypted: i=1; AJvYcCWvpbCbDzpFca0kLK6efTgVEKFnzAh6cp1k1CS8MPe6uZtIiwa1ksAIN86ipQon6eAy26KE848GFbv7L0ul/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqbXMxqviPm5WHJq9a8q4hJYYTukEKsQGl136ZpFSPGeKVXS2
	uEPsuvTpnDkECN5SOe+vdmrhQKEnpLeoY8RG4cSzzA2yYMzDyYfG9gZc5PN/2KPap5KxKCyMaPm
	wsQKi3akvWgKWLH+fkSq2urndYb9BdD4=
X-Gm-Gg: ASbGncs93y8BuP3t8CxJsMGgAjdtoXE9a9PSMOgojaAA10SEZSBtKfEYOy651i5m2BD
	keqcHn3/txd1SVoCO2+n+c7ThWV0PZldlT7cYWMFAujyRgIABw01jz4RtQNoVJiQWUqeSavqARE
	PJlPcVf7e3J6GljJoTeBbNan6B494vQorkCQEqEL2gSmK0
X-Google-Smtp-Source: AGHT+IFZWKTvXxbH3G7bLqTtzvIEx7H67Au/OCzCNxls/aVYC/EQxcLNtVDi0fCMPkkqWWhWpADdtxZfBDjg7529qc0=
X-Received: by 2002:a17:90b:3d0b:b0:311:b413:f5e1 with SMTP id
 98e67ed59e1d1-3159d8ffc0amr14898875a91.32.1750627879479; Sun, 22 Jun 2025
 14:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Date: Mon, 23 Jun 2025 03:01:08 +0530
X-Gm-Features: AX0GCFv-PIdhMtiuqEmBSJhBAx3V8LVajpf5wYth2A1G7mmD97Qg2BPG5kV2AXg
Message-ID: <CAEmM+Qh=8tm55Ypa2w3ZtOFFrGXTpKqxue59mVAo_5TVy0RJ6g@mail.gmail.com>
Subject: [ath10k][QCA9377] Firmware crashes on Dell Inspiron 5567 (IRQ #16,
 all modern distro kernels)
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

This is to inform all that constant firmware crashes have been seen in
the "Qualcomm Atheros QCA9377 802.11ac Wireless Network Adapter",
which was shipped with the Dell Inspiron 5567 laptops. This affects
every kernel release, including the stable and the longterm ones.

All the logs have been taken after livebooting an Arch Linux ISO.

Every distro has been tried, and it has been confirmed that some error
of this kind is shown in every distro.

## Steps to reproduce the issue

1. Boot/liveboot any Linux ISO through this card (and possibly, this laptop).
2. Wi-Fi network interface appears.
3. Connect the Wi-Fi router to the computer.
4. A few moments/minutes after that, the touchpad stops working, and
the network interface cannot even access the Internet anymore (BUT,
the network interface might disappear, might not disappear).

## Affected distros and the necessary workarounds

This has been the pattern on every distro and their corresponding
kernels (LMDE, Linux Mint, Pop!_OS, Zorin, Kubuntu, KDE Neon,
elementaryOS, Fedora, and even Arch). The fix which made these distros
usable is to add two things:

- Adding "options ath10k_core skip_otp=y" to a new conf file in /etc/modprobe.d.
- Adding "pci=noaer" in GRUB kernel parameters so that the logs are
not flooded with Multiple Correctable Errors.

To defend my case (that it occurs in the other models of Inspiron 5567
too), I have recently contacted someone running Linux Mint on the same
model. The answer was the same: the touchpad and the Wi-Fi stop
simultaneously.

## Some of the limitations

The kernel was tainted, but the other things have been properly noted
in case they might provide some useful details. As stated,
investigating why IRQ #16 is disabled will probably give us the
answer.

## Logs provided

All the logs in a combined manner can be found here:
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180

- Full dmesg: https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180#file-dmesg-log
- Hostnamectl: https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180#file-hostnamectl-log
- lspci: https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180#file-lspci-log
- Modinfo of the driver:
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180#file-modinfo-log
- Ping command:
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180#file-ping-log
- /proc/interrupts:
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180#file-proc_interrupts-log
- IP addr command (Heavily Redacted):
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180#file-ip_addr-log

Lastly, this issue on the GitHub repository of Pop!_OS 'might' be
relevant: https://github.com/pop-os/pop/issues/1470

It would be highly appreciated if the matter were looked into.

Thanks,

Bandhan Pramanik

