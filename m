Return-Path: <linux-wireless+bounces-24364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3834DAE479E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF75216285E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE2126D4F9;
	Mon, 23 Jun 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhTxkR3R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB726B747;
	Mon, 23 Jun 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690385; cv=none; b=QAXfXknRBKkJXUNey611RP2QyGzoQo8KBQPORZ0C/nN8PtiThDb+AEI7xofjFmaPYSEo3ZjC6jg6H/Uv/FcRpzqKXLWDnzAcmOb2FlAhFpexqLWPiZyrwzLg/ImnEtCLbBRYNMMYr16oX1g9QSiYauCWMxeYC4uvksKAtkN6QvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690385; c=relaxed/simple;
	bh=6rnP6cA4XpkCV+nk1j1HPQAk1FnLLZr1V8SkkJgMTz4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KnxSrkhCW2ykblSFbmad7Xx4VpV1bgghM5WODIiwVht8E/sEEezSMgpfEW/vu1NQjvZzBFOA161F701QURBoCeN76G/cqrOKVd4iI5R4AhWtVGwcWItBGA+X5HwswBJH4UaD3cgZJCf8osucj7YmHORMraFGlfB6lXaWEoWDhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhTxkR3R; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-22c33677183so38730155ad.2;
        Mon, 23 Jun 2025 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750690383; x=1751295183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6rnP6cA4XpkCV+nk1j1HPQAk1FnLLZr1V8SkkJgMTz4=;
        b=HhTxkR3RlIgH2q9aberXhZxs0zTs0+PRmGkST7yZRW7QMsYv3hel+MJl6b2542f9Rd
         vp7DLFfBV8KRADAf9SqRbIBIcvFq2OV8rWjxBsbxNZ2a70cSBZ0gp1AdhUCVYnkNqi6n
         n2lkKOK++9bs1ZQF2G3tHXGT2M6N+AyjtxByiilVbZHjPB5Js96grxJ0t1nQIEmnLzbw
         Jr+zqFgRgK1Pds7UiodwZ/RGG+Vr2bxdFtV9Iu2wbspYAcXBqDvAHTB4hJe82sKescc3
         KP49zCrNKpJPE4OHK9uMsBPiWUTLWmr7qBH70o8xLwU+1CWJK+WW998WHLIK8wScF5zd
         6scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690383; x=1751295183;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rnP6cA4XpkCV+nk1j1HPQAk1FnLLZr1V8SkkJgMTz4=;
        b=k2thONk6mGd2ZJ3lxGhGEgwy0YU319M5mIcZckHMWiXrnuKAx4zH/5USkGFw72g98S
         k430pfsh6+dnZlkBs0RqjGnJh+wNkoqcf7ieoRwCz1d+M1p0ARyW7zHbMYt+gBT/1jwF
         d3emp+Pwn96vvoO4/Ixvj0YMZkdaPIlKYDC8ErhxCeWfhMNDMLzNamn0uqHreOfytSny
         wVZ+rODR09Rtr471cmPZMLrfMT/0fCE7Lp2RLWqlaSnm3GKJcZhFOMl3utSvZbrvk5mI
         VrM0kfVpOTxFiyGIPpzRuBdvnz4bNFTENeJ5VDw1YDV8aJkrkovCNY7ADt1/kjQr71cd
         eCRA==
X-Forwarded-Encrypted: i=1; AJvYcCUvAyfa15HcpFTbKDjlVU+W6XNav5GLr/SWxyEieGd26R+yAE/UMTx9jxQTwutlH3uKUh2SkqxNLs/zKp/7Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQF1q8qDyx94q8FLB58tWRh6Ic8YSHM3enlTp2k245D2uoDl3H
	i1lg9ypOeplulBGsPl126L06ldbPREyCQofedceH6dxboFsPwfXiHPJx
X-Gm-Gg: ASbGncvdk2yJ7wVi0hIl2nsxBnynQMXQ4DIYjjfS7haGqNveKgYHhu6dL/SmObiLJb0
	TZVCoScpTrTKqOcV5AGhbwQhbccVxZg9WBtHcWzOPFcmNVw7975bpA4QFxDIyzoZxhz9EzIw/Cc
	gVsW7zOyyk5YYM7j1GXYSYnqHHJpkZOCEORsQgHxx2t6FfKQxGOB7aCBKqhmEJIP45ECOv/Qc4f
	be6BQ8XHknvnFEmfoI2IT6UNjZgDyEsPNEm956Xv40MhBtyzc9Hv6XeHKZiW4mZiqLIoUSvEhdw
	q9vgG5kgweeGOHIQqLaC/AB02mQcoP7vcLD3whWksSfGcgHX5lA4MXfUr/ezPFSYqSAdae28wRW
	jWg==
X-Google-Smtp-Source: AGHT+IEpofGO1rB/8THZSo27dmHyR0/onH+VJ5lhvs94WqBArO7vFA8MObxLSVNA5KrNdZ+XBMOaAg==
X-Received: by 2002:a17:903:1aa7:b0:234:8a4a:adad with SMTP id d9443c01a7336-237d98f9968mr203103975ad.26.1750690383294;
        Mon, 23 Jun 2025 07:53:03 -0700 (PDT)
Received: from [127.0.0.1] ([115.187.48.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ce31asm84459365ad.63.2025.06.23.07.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:53:02 -0700 (PDT)
Date: Mon, 23 Jun 2025 20:22:57 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
CC: stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bath10k=5D=5BQCA9377=5D_Firmware_crashes_on_Dell_I?=
 =?US-ASCII?Q?nspiron_5567_=28IRQ_=2316=2C_all_modern_distro_kernels=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAEmM+Qh=8tm55Ypa2w3ZtOFFrGXTpKqxue59mVAo_5TVy0RJ6g@mail.gmail.com>
References: <CAEmM+Qh=8tm55Ypa2w3ZtOFFrGXTpKqxue59mVAo_5TVy0RJ6g@mail.gmail.com>
Message-ID: <CD81F065-CDDD-41F6-AECD-167B509F57C6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

An update on the situation=2E

I installed Fedora KDE Plasma Spin, and the skip_otp option didn't work th=
ere=2E KDE specifically said that the Wi-Fi is still connected but it is no=
t connecting to the Internet (confirming my suspicions as true, that the ne=
twork interface is not disappearing this time and the Destination Host is u=
nreachable, because of the network card)=2E

Only the following convoluted (and strictly step-by-step) solution seems t=
o potentially work (not tested on my own laptop yet): https://www=2Ereddit=
=2Ecom/r/linux/s/8VKDJ6QeP
(This solution has been taken from the GitHub Issue of the Pop!_OS repo)

I used these exact sequence of steps before, and it worked properly=2E But=
 this time, I simply wrote the skip_otp option to /etc/modprobe=2Ed, and it=
 didn't work=2E

Reiterating my point: this issue seriously requires urgent attention becau=
se it affects all the stable and longterm kernels as of now=2E

Thanks,

Bandhan Pramanik


On 23 June 2025 3:01:08=E2=80=AFam IST, Bandhan Pramanik <bandhanpramanik0=
6=2Efoss@gmail=2Ecom> wrote:
> Hello,
>=20
> This is to inform all that constant firmware crashes have been seen in
> the "Qualcomm Atheros QCA9377 802=2E11ac Wireless Network Adapter",
> which was shipped with the Dell Inspiron 5567 laptops=2E This affects
> every kernel release, including the stable and the longterm ones=2E
>=20
> All the logs have been taken after livebooting an Arch Linux ISO=2E
>=20
> Every distro has been tried, and it has been confirmed that some error
> of this kind is shown in every distro=2E
>=20
> ## Steps to reproduce the issue
>=20
> 1=2E Boot/liveboot any Linux ISO through this card (and possibly, this l=
aptop)=2E
> 2=2E Wi-Fi network interface appears=2E
> 3=2E Connect the Wi-Fi router to the computer=2E
> 4=2E A few moments/minutes after that, the touchpad stops working, and
> the network interface cannot even access the Internet anymore (BUT,
> the network interface might disappear, might not disappear)=2E
>=20
> ## Affected distros and the necessary workarounds
>=20
> This has been the pattern on every distro and their corresponding
> kernels (LMDE, Linux Mint, Pop!_OS, Zorin, Kubuntu, KDE Neon,
> elementaryOS, Fedora, and even Arch)=2E The fix which made these distros
> usable is to add two things:
>=20
> - Adding "options ath10k_core skip_otp=3Dy" to a new conf file in /etc/m=
odprobe=2Ed=2E
> - Adding "pci=3Dnoaer" in GRUB kernel parameters so that the logs are
> not flooded with Multiple Correctable Errors=2E
>=20
> To defend my case (that it occurs in the other models of Inspiron 5567
> too), I have recently contacted someone running Linux Mint on the same
> model=2E The answer was the same: the touchpad and the Wi-Fi stop
> simultaneously=2E
>=20
> ## Some of the limitations
>=20
> The kernel was tainted, but the other things have been properly noted
> in case they might provide some useful details=2E As stated,
> investigating why IRQ #16 is disabled will probably give us the
> answer=2E
>=20
> ## Logs provided
>=20
> All the logs in a combined manner can be found here:
> https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a1=
6180
>=20
> - Full dmesg: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03c=
a2ea43a1d832a16180#file-dmesg-log
> - Hostnamectl: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03=
ca2ea43a1d832a16180#file-hostnamectl-log
> - lspci: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea4=
3a1d832a16180#file-lspci-log
> - Modinfo of the driver:
> https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a1=
6180#file-modinfo-log
> - Ping command:
> https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a1=
6180#file-ping-log
> - /proc/interrupts:
> https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a1=
6180#file-proc_interrupts-log
> - IP addr command (Heavily Redacted):
> https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a1=
6180#file-ip_addr-log
>=20
> Lastly, this issue on the GitHub repository of Pop!_OS 'might' be
> relevant: https://github=2Ecom/pop-os/pop/issues/1470
>=20
> It would be highly appreciated if the matter were looked into=2E
>=20
> Thanks,
>=20
> Bandhan Pramanik

