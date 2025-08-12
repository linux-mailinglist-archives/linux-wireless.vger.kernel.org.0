Return-Path: <linux-wireless+bounces-26323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F004DB22D7D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3921886669
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Aug 2025 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C397E2F8BDD;
	Tue, 12 Aug 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUc1N2T8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790D2F6579;
	Tue, 12 Aug 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015838; cv=none; b=PFSAsZCzunVv8gxa4XEnMbp4b1XzoLBqLL/LabS+zdECBLqbQdr7NkCGymxOLXqexXnXZviu5gMJI2up8TfHG/RF9BA0ekc4T5CR8UHR0JEuZPMC7Tv/dzgH27UL1wmDoU3vtr2/oqMLcJ09ome62caGZQ4XNkEx6Ruu8p+CvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015838; c=relaxed/simple;
	bh=DX/a/5+B4C5HgtQc829srmgZngPbuyntkKppc+GEAp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qoUE0X8/Zh2dyxXBZ/8TlB1SpBlKjievCEAZlK0Eqy29AoTcginN8L8QvP3Cm1uwnCNeDfPcK97+RT6phk8Sgjc+AzobKGGA/D12b+ehzOyALA0xmOVk8qjJ20XvWdSN0iI1xRPQ446wfAsFVai8AmgxLJt8aAUwtSRP50YGods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUc1N2T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58270C4CEF6;
	Tue, 12 Aug 2025 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015838;
	bh=DX/a/5+B4C5HgtQc829srmgZngPbuyntkKppc+GEAp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TUc1N2T8TbtzPU7YHakEEQGtQWIy/0cxkndUmUoUoYyBPJnec8Qeecaa3FYjGPqXU
	 0hRy0dOCtkiN6geGXdcQu084ZA3CqeMRvV/ZNJA9/XBh5noIoAUAQ0DQWHzW5Wqp2a
	 sL/nXMBTC6PtZ3Yp4MzWPzScAq5+GwmFF4F/KIAzFsPijQ9BmpGGaqglT12Om22K5l
	 IukZHX0AMZOFvl/jAuwISbexWGd0F8HooIRbCFqdb4FDMlRmnBka+3HmX8MYbr2ScI
	 5T00COSasqF4+8FBfCUz+YIveYu4rSNYVl+hzJO+2PkDwAkvJCdaZP6Pyrh0ljhIcl
	 KR+rDDyLCWlMg==
From: Mark Brown <broonie@kernel.org>
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
 Liam Girdwood <lgirdwood@gmail.com>, 
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
Message-Id: <175501582810.192378.6304989017593161369.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 17:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 08 Aug 2025 17:17:44 +0200, Arnd Bergmann wrote:
> Commit 678bae2eaa81 ("gpiolib: make legacy interfaces optional") was
> merged for linux-6.17, so now it is possible to use the legacy interfaces
> conditionally and eventually have the support left out of the kernel
> whenever it is not needed.
> 
> I created six patches to force-enable CONFIG_GPIOLIB_LEGACY on the
> few (mostly ancient) platforms that still require this, plus a set of
> patches to either add the corresponding Kconfig dependencies that make
> the device drivers conditional on that symbol, or change them to no
> longer require it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[08/21] ASoC: add GPIOLIB_LEGACY dependency where needed
        commit: 5383d67e2430822fa7bd20dcbbebbd8ae808e386
[20/21] ASoC: pxa: add GPIOLIB_LEGACY dependency
        commit: 2d86d2585ab929a143d1e6f8963da1499e33bf13

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


