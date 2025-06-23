Return-Path: <linux-wireless+bounces-24372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCFDAE4DB2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E9A7A2ADC
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34919296156;
	Mon, 23 Jun 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXWi/euI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5719C554;
	Mon, 23 Jun 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707602; cv=none; b=nOuImT91RyMv2yFvBrudQ6ZMnyPTy5Mf2P4+jTmvHD1hAg7X7gt4RlFUjGmG9pCFvSGO3yvJ1keus4i5uY/R+VAo3OKD8uIPi8te8BNSknlCRk1Dy3X9ivWMnCNN6he7dvAT1CL6tPWrFdHFwjqDdXzQVA01aJEFfbfQ7DqXBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707602; c=relaxed/simple;
	bh=YjGxbIXYgtou/2N9dnExwJU6eiqD4x/SaqWx1BAYUcc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bEyaUAB4IoSvtBnBoxiL7DuWYq23U3cOymV09TY5u21XYAmGyXzuiLu3v26PG+u1WPnVuO/6Pdizw4U4dDywGGatYhBcvOgSJev8YEmGwAqB2m12jaSsQVCb20WeXLdSCJB0qbaq9hxeF26KpVuCdDN3xx+EhwjCLq40XHz5Vo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXWi/euI; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-235d6de331fso65538145ad.3;
        Mon, 23 Jun 2025 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750707600; x=1751312400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YjGxbIXYgtou/2N9dnExwJU6eiqD4x/SaqWx1BAYUcc=;
        b=MXWi/euIkgbVNMD4lrFTleic7AncK25XEecBe4TrvmWoRcTqPBZNSlTOWpzTeBO2Yj
         9TRhH9haG+ne/Nz62rt8udGOOuGGIVuaRI3WL+DkPI8KC+YY2PR3FmIPykcXEiWPX2Ff
         PGVvyUc0EmIj1BjCdgHRjChMxQ7HIFt55OTu2HNyH3uj/xFd3Kqz4aiOvEtCyNcoiedZ
         /Jn2xQHgxXA4ZEYwsivI+qqa6l0V++bdccAQ0FtOXIzGMAjwWubilQUqnF1Ufu3BX2g5
         +ES1SUTnFHc+mcf9+x1oz8rIldsae1TlCtoXjYLWOGvxCoL9ha0/B1KxcKVGxmsE641A
         tCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750707600; x=1751312400;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjGxbIXYgtou/2N9dnExwJU6eiqD4x/SaqWx1BAYUcc=;
        b=V0oilinXttirE6TyDBTz4H7rBFTsknOXEml5/Kx4eRYHXoY+j0gM7iOIP6j7g8tUNF
         PNNfOT03pSjJ7iGcCRzgrqQ91Bgu65ZiowLJHTCbMbu+/gsOfj/wPyd2O/qi3Z19MA/e
         vDjxJ/y39zy05XB13nrZ3q2Opo4flvUjPM+/wAJ2iZ6/YjnfHv03ufYJpZ94hkOX5V2D
         lRk+DBnko1Yo3u1/KBWqFJ2+ffgEGrngo9n6Smm8u7bE/bPM7mFL5bdh1IjStWeg56ai
         +rjKM+Eho/XU+SvMMqM1qWRB4+5jGMdbZYmem/9ZSg00hiKN4/R+eEDPbWFVkoohbyBD
         A8ug==
X-Forwarded-Encrypted: i=1; AJvYcCWKSxlcEnZDH8CxwVzML5vmcR2I/uM1vICG+AG1YoPRgP290S9IKgd1ofFyoLtzv8TE5on9CqRIo4ur+tAVXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrrSbSSOzDqHFX+gZHUlQ0ghNG4cs1wmCgWBDj60hqDl5Rg26
	DC9IQa7S8ZsaalXq4okmpZN/CWVy2CV6sZN7d052x1CVjehf7Gco768W/Ug3on3rVxlUuQ==
X-Gm-Gg: ASbGnctn6rlTT+k0FfovBwxjN1pU6ecfeEMlGvTf3XCt15+mRzgvA9W9x1OgK/0r0+r
	cfqj8L8bx7OcCK7iqfodg+hXxIVwJMEwZ5pbmc0yh2/Hb0fXWun9+WM4+zN95V5ogIQbOiwn/kF
	tyPeUMoNrqNOB4oAwqd+Kv8R4EPuqaVVsrGKHF3fh8A1GR7ysboFlxnsS77QVz7JXec+g0+waMV
	a1GHONLD0Y49/HGTEKhXghXyhRHzWkGNnCSudrj2I/UGS+RY6Kfvmh9hyM1ty0C1QHCWm2C5cS8
	2qAThcydLw/qaKs9IOu8htQwTHdPgqdiUEekSzbHkgOYnSDRAHUliZrxlik/ZHiZUCVnfM04QE6
	4GA==
X-Google-Smtp-Source: AGHT+IFz4YvLG07mimiQgwKZPZoghEEezyT2BnEsvi6aWF8kiYYOdo4a1M9ViO9A648E8FlyqHklig==
X-Received: by 2002:a17:902:c404:b0:234:a139:11fa with SMTP id d9443c01a7336-237d980c3f8mr184292145ad.3.1750707599736;
        Mon, 23 Jun 2025 12:39:59 -0700 (PDT)
Received: from [127.0.0.1] ([115.187.48.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d873845esm93019575ad.243.2025.06.23.12.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 12:39:59 -0700 (PDT)
Date: Tue, 24 Jun 2025 01:09:54 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
CC: stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bath10k=5D=5BQCA9377=5D_Firmware_crashes_on_Dell_I?=
 =?US-ASCII?Q?nspiron_5567_=28IRQ_=2316=2C_all_modern_distro_kernels=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <CD81F065-CDDD-41F6-AECD-167B509F57C6@gmail.com>
References: <CAEmM+Qh=8tm55Ypa2w3ZtOFFrGXTpKqxue59mVAo_5TVy0RJ6g@mail.gmail.com> <CD81F065-CDDD-41F6-AECD-167B509F57C6@gmail.com>
Message-ID: <2DC25FD4-0EA4-41CE-BA17-BFF84C1C5F7E@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

For some reason, the Reddit link on troubleshooting the firmware leads to n=
owhere=2E

Here is the Reddit link yet again (let's see if it works): https://www=2Er=
eddit=2Ecom/r/linux/s/egXvRBYhYp

Apologies for interrupting more than once=2E

On 23 June 2025 8:22:57=E2=80=AFpm IST, Bandhan Pramanik <bandhanpramanik0=
6=2Efoss@gmail=2Ecom> wrote:
> Hello,
>=20
> An update on the situation=2E
>=20
> I installed Fedora KDE Plasma Spin, and the skip_otp option didn't work =
there=2E KDE specifically said that the Wi-Fi is still connected but it is =
not connecting to the Internet (confirming my suspicions as true, that the =
network interface is not disappearing this time and the Destination Host is=
 unreachable, because of the network card)=2E
>=20
> Only the following convoluted (and strictly step-by-step) solution seems=
 to potentially work (not tested on my own laptop yet): https://www=2Ereddi=
t=2Ecom/r/linux/s/8VKDJ6QeP
> (This solution has been taken from the GitHub Issue of the Pop!_OS repo)
>=20
> I used these exact sequence of steps before, and it worked properly=2E B=
ut this time, I simply wrote the skip_otp option to /etc/modprobe=2Ed, and =
it didn't work=2E
>=20
> Reiterating my point: this issue seriously requires urgent attention bec=
ause it affects all the stable and longterm kernels as of now=2E
>=20
> Thanks,
>=20
> Bandhan Pramanik
>=20
>=20
> On 23 June 2025 3:01:08=E2=80=AFam IST, Bandhan Pramanik <bandhanpramani=
k06=2Efoss@gmail=2Ecom> wrote:
> > Hello,
> >=20
> > This is to inform all that constant firmware crashes have been seen in
> > the "Qualcomm Atheros QCA9377 802=2E11ac Wireless Network Adapter",
> > which was shipped with the Dell Inspiron 5567 laptops=2E This affects
> > every kernel release, including the stable and the longterm ones=2E
> >=20
> > All the logs have been taken after livebooting an Arch Linux ISO=2E
> >=20
> > Every distro has been tried, and it has been confirmed that some error
> > of this kind is shown in every distro=2E
> >=20
> > ## Steps to reproduce the issue
> >=20
> > 1=2E Boot/liveboot any Linux ISO through this card (and possibly, this=
 laptop)=2E
> > 2=2E Wi-Fi network interface appears=2E
> > 3=2E Connect the Wi-Fi router to the computer=2E
> > 4=2E A few moments/minutes after that, the touchpad stops working, and
> > the network interface cannot even access the Internet anymore (BUT,
> > the network interface might disappear, might not disappear)=2E
> >=20
> > ## Affected distros and the necessary workarounds
> >=20
> > This has been the pattern on every distro and their corresponding
> > kernels (LMDE, Linux Mint, Pop!_OS, Zorin, Kubuntu, KDE Neon,
> > elementaryOS, Fedora, and even Arch)=2E The fix which made these distr=
os
> > usable is to add two things:
> >=20
> > - Adding "options ath10k_core skip_otp=3Dy" to a new conf file in /etc=
/modprobe=2Ed=2E
> > - Adding "pci=3Dnoaer" in GRUB kernel parameters so that the logs are
> > not flooded with Multiple Correctable Errors=2E
> >=20
> > To defend my case (that it occurs in the other models of Inspiron 5567
> > too), I have recently contacted someone running Linux Mint on the same
> > model=2E The answer was the same: the touchpad and the Wi-Fi stop
> > simultaneously=2E
> >=20
> > ## Some of the limitations
> >=20
> > The kernel was tainted, but the other things have been properly noted
> > in case they might provide some useful details=2E As stated,
> > investigating why IRQ #16 is disabled will probably give us the
> > answer=2E
> >=20
> > ## Logs provided
> >=20
> > All the logs in a combined manner can be found here:
> > https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832=
a16180
> >=20
> > - Full dmesg: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca0=
3ca2ea43a1d832a16180#file-dmesg-log
> > - Hostnamectl: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca=
03ca2ea43a1d832a16180#file-hostnamectl-log
> > - lspci: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2e=
a43a1d832a16180#file-lspci-log
> > - Modinfo of the driver:
> > https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832=
a16180#file-modinfo-log
> > - Ping command:
> > https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832=
a16180#file-ping-log
> > - /proc/interrupts:
> > https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832=
a16180#file-proc_interrupts-log
> > - IP addr command (Heavily Redacted):
> > https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832=
a16180#file-ip_addr-log
> >=20
> > Lastly, this issue on the GitHub repository of Pop!_OS 'might' be
> > relevant: https://github=2Ecom/pop-os/pop/issues/1470
> >=20
> > It would be highly appreciated if the matter were looked into=2E
> >=20
> > Thanks,
> >=20
> > Bandhan Pramanik

