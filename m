Return-Path: <linux-wireless+bounces-29247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BB9C7BA7E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 21:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70C4F36871D
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538EA30215E;
	Fri, 21 Nov 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+zvWL/N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6F2FAC0D
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763757359; cv=none; b=AysqEhgiyoITOsXGs416Jajx2PPzaJSOEBpOJDW0fM1V2efgq6NTp8zbFZshEilZ8rWTsoP9sjGeaI+H8Vjphp8zBuaqjj0u7wFndYDneRLFMs/K3P61vTb57f8zvjcHH4kFzSrtdsYnNh3uyRvtZjFmqtQBQx9bfEsUEX0wCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763757359; c=relaxed/simple;
	bh=meSktXQNs/zDvTr1rLs7LeQfxQysPHSbGkzQDId9XMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhUzeFsRFQ5SjwbXfC/is2fZLS/N8aJaURXI5/Ppjs7lSDZRsrNSbNtZoRsNuy8yiFFZSPSxySDVGTB6389Wo++UoNc5Wr1b3CMftoNI5qvG2QUIqRMJgijsyWDAQ/WFCwYt1DmeOCFJolx2MbdjOTCyPiIeHvxcGmfuioGJlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+zvWL/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD99CC2BC86
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763757358;
	bh=meSktXQNs/zDvTr1rLs7LeQfxQysPHSbGkzQDId9XMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L+zvWL/Nh94FkM1rZrXcBtTOzgK+mkJwTDosBcBijCdV34X53/cdtFJtiuZ0Md/WM
	 GcqhqeRjUC0vm45dWjFBz6XmwGZdDlx/1YsRu2QyrzPY+3hCmTjo6+j5LM3zBib4I4
	 J6tKQx3AUF2IB07P8TFo+IWDzck0Yp3oj5x5qK+1dMshchSxQDW1aIOTW5EmLdVjPD
	 3zqNL5lRPlgjWSvClhgdnUG+fb4P2UmRkId3/JrLTerz93MIgGIWp8gL3/SUNNbMpt
	 Z0A6qD2K62qoXRs1K/9ABvtlMFte9d0O1sWFPTl8RY6sAvXTCprA/RgDr/i7m3fD6z
	 YI+JdDMM/fmQg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-657244ed2c2so521621eaf.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 12:35:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbnW+sXm85BgIe8TclCIQw3ipJ6z9DWHZEWkzBvuArlWqn5Ei9ZwvlJkVE33/TyEujbhwxhVEnR3T0YZa44A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RMLEOjPRk9of4fWcK383qNgs6Rn1vin4mM/JcWHM6kuOmU26
	Ogs6FmQUHUyTrcLf+Lob0y3TYbk2KguKII470Oxtgej2gNFpPIWnAeK+CnlkQPdFjnIWgGGaxXT
	ThS+EzZc5c8Dufnn8eM7ueC/gbJHMtG4=
X-Google-Smtp-Source: AGHT+IEGV1wW0AyQ4uV5rOeWs+mu0pohToH8QfmqGgzcM1nDvWFgodvXp8dfzsS7PUq8QlplylLWmLPmTb2ii+XtGZ8=
X-Received: by 2002:a05:6820:4d57:10b0:657:7289:b1dc with SMTP id
 006d021491bc7-65792596028mr1028369eaf.6.1763757357967; Fri, 21 Nov 2025
 12:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-thermal-device-v1-0-bbdad594d57a@gmx.de>
In-Reply-To: <20251120-thermal-device-v1-0-bbdad594d57a@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Nov 2025 21:35:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jOPrBcozzJMsB1eE12MuZRWDAV-+=jfrhJbi=S0p5J9Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmY4Rgl1Z4nj5ks6gNTVnBjHocEaNjk9D0MQSLHqvtZo8fqobTCygtTNLc
Message-ID: <CAJZ5v0jOPrBcozzJMsB1eE12MuZRWDAV-+=jfrhJbi=S0p5J9Q@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 0/8] thermal: core: Allow setting the parent
 device of thermal zone/cooling devices
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Len Brown <lenb@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	ath11k@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 4:41=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Drivers registering thermal zone/cooling devices are currently unable
> to tell the thermal core what parent device the new thermal zone/
> cooling device should have, potentially causing issues with suspend
> ordering

This is one potential class of problems that may arise, but I would
like to see a real example of this.

As it stands today, thermal_class has no PM callbacks, so there are no
callback execution ordering issues with devices in that class and what
other suspend/resume ordering issues are there?

Also, the suspend and resume of thermal zones is handled via PM
notifiers.  Is there a problem with this?

> and making it impossible for user space applications to
> associate a given thermal zone device with its parent device.

Why does user space need to know the parent of a given cooling device
or thermal zone?

> This patch series aims to fix this issue by extending the functions
> used to register thermal zone/cooling devices to also accept a parent
> device pointer. The first six patches convert all functions used for
> registering cooling devices, while the functions used for registering
> thermal zone devices are converted by the remaining two patches.
>
> I tested this series on various devices containing (among others):
> - ACPI thermal zones
> - ACPI processor devices
> - PCIe cooling devices
> - Intel Wifi card
> - Intel powerclamp
> - Intel TCC cooling

What exactly did you do to test it?

> I also compile-tested the remaining affected drivers, however i would
> still be happy if the relevant maintainers (especially those of the
> mellanox ethernet switch driver) could take a quick glance at the
> code and verify that i am using the correct device as the parent
> device.

I think that the above paragraph is not relevant any more?

> This work is also necessary for extending the ACPI thermal zone driver
> to support the _TZD ACPI object in the future.

I'm still unsure why _TZD support requires the ability to set a
thermal zone parent device.

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Armin Wolf (8):
>       thermal: core: Allow setting the parent device of cooling devices
>       thermal: core: Set parent device in thermal_of_cooling_device_regis=
ter()
>       ACPI: processor: Stop creating "device" sysfs link

That link is not to the cooling devices' parent, but to the ACPI
device object (a struct acpi_device) that corresponds to the parent.
The parent of the cooling device should be the processor device, not
its ACPI companion, so I'm not sure why there would be a conflict.

>       ACPI: fan: Stop creating "device" sysfs link
>       ACPI: video: Stop creating "device" sysfs link

Analogously in the above two cases AFAICS.

The parent of a cooling device should be a "physical" device object,
like a platform device or a PCI device or similar, not a struct
acpi_device (which in fact is not a device even).

>       thermal: core: Set parent device in thermal_cooling_device_register=
()
>       ACPI: thermal: Stop creating "device" sysfs link

And this link is to the struct acpi_device representing the thermal zone it=
self.

>       thermal: core: Allow setting the parent device of thermal zone devi=
ces

I'm not sure if this is a good idea, at least until it is clear what
the role of a thermal zone parent device should be.

