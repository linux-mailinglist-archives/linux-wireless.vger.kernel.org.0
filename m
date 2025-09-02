Return-Path: <linux-wireless+bounces-26936-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E82B401C1
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 15:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501BC2C5822
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD332DA750;
	Tue,  2 Sep 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwazNMHJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7272D5C95;
	Tue,  2 Sep 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817774; cv=none; b=OflUV30N9gXKLZY2hp1scbAjUj1nG7/F7KbOGURtB9TKkMiYSECYRchaPr+iogtlSvc0M3LDgz+FL4yizQttHuOfFP4CCFOnGUcufEgK+5v8aovMvDfMsQmQGbHUPGGCFhnaPGC4Wuqs26I/xM+E9Z44vn1YgwlaY6H4MBQhDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817774; c=relaxed/simple;
	bh=6fXt4bhKhGQeDgocLc+VTGxwmm9hlaSYbwbrhqO4eo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lucBmrwg++jHdYRdZCeDdEewQV8yTkO9VH8r6aYoCyLEEhM0cDDeEv8/AIXY67ZL3LWYQcVHHiNWJD5xn5U+4WUcSIpBx3RR4JXNSxUZLX+nXr1non7c0csbBC4IV4YCXN7SAqCKcTorBGJl/TCEpKSfyYL+WcrC63s32vPSHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwazNMHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F86C4CEF4;
	Tue,  2 Sep 2025 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817774;
	bh=6fXt4bhKhGQeDgocLc+VTGxwmm9hlaSYbwbrhqO4eo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pwazNMHJ405xvwddvksWXCvf2Bzxx2noy2IUYDoxR08pNT70eoYJ6avMGFl9/Brfy
	 djIhKc4IwsWYRDzf4ckgbuj4YCoKw+9YxQrmPP2zcN5BTWN72msT/8L7gG1b4AnNXA
	 H4LLv6NBYhzDqxK03/Bs/TmEL+LOYNY+NS+YPvoSxcEaL2K4fCDy8dQcwcD1Yoj3r7
	 9WeAzZMLfWuw825r0YE0Jvdw3d0z5Gpm6BLaVjSBhLdAAnUEwVxIWvjvouZoMk16IB
	 vPb54RivBXsgQ9vEkrWC7YCee6GXl108+ujfuPj+LCZ1l3MNDksA1EisuEfyh34BqK
	 8exw6nerb4i/Q==
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jeff Johnson <jjohnson@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, patches@opensource.cirrus.com, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20250808151822.536879-1-arnd@kernel.org>
References: <20250808151822.536879-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH 00/21] gpiolib: fence off legacy interfaces
Message-Id: <175681776381.2341743.17892612215782644085.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 13:56:03 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Fri, 08 Aug 2025 17:17:44 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit 678bae2eaa81 ("gpiolib: make legacy interfaces optional") was
> merged for linux-6.17, so now it is possible to use the legacy interfaces
> conditionally and eventually have the support left out of the kernel
> whenever it is not needed.
> 
> [...]

Applied, thanks!

[12/21] mfd: arizona: make legacy gpiolib interface optional
        commit: 12f6c0afc8987d72017a3ecf7c1183cb951b0d24
[13/21] mfd: si476x: add GPIOLIB_LEGACY dependency
        commit: 1ae250257e43b3fba225e4f8ea7d87125dc861ae
[14/21] mfd: aat2870: add GPIOLIB_LEGACY dependency
        commit: 3144986f37911f131f373743f294b2941a8ef37c

--
Lee Jones [李琼斯]


