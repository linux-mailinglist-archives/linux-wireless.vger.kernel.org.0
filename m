Return-Path: <linux-wireless+bounces-26227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 203BDB1EB73
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB811882BF0
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Aug 2025 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0272836A4;
	Fri,  8 Aug 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEKu1+Qa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68188645;
	Fri,  8 Aug 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666350; cv=none; b=d/qNzJTtFz9c6cgj0aU/25vaDo+9LHMBs4Q0FASsCap1QV/p8zm1fu1w8XEIK7vr0zOEjSqjPdLmFWj7ijEYBmbihd2Ya9yawV2AZyZZ3QjQioGZkN10bHldrUQIuKUmfJSI1PDX6Sbr92Ag4xVvrLOK3MVYB9ZqxiRkTj4pquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666350; c=relaxed/simple;
	bh=tsdeCPIPkX+wdlJnsaj55GinnOFi+s4xef6Bgzt4ay4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AmKyVvIKw95CU5dFGVPeMHqMJKyY00nyqTtIAOLCVgykrovIj/Ls3VRWfv1+EneRS24bLlgFSppVkQQNmUO5p8TERLAbRgK+7EJ+XdS1Twl7/WCpbQUCfbunI+rLlJHLH+niBQinFM61pgSfNHmROLIum4rtVx2Hb4Ch93oqjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEKu1+Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA27C4CEED;
	Fri,  8 Aug 2025 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754666350;
	bh=tsdeCPIPkX+wdlJnsaj55GinnOFi+s4xef6Bgzt4ay4=;
	h=From:To:Cc:Subject:Date:From;
	b=jEKu1+QacMpqQYXBXccohR6zFIE5s3psXsmyHRGVtrVZ0pnr1KmEtw/7ur1/cNOIW
	 7yaC0tT7pE/PEjOsCREluDbIOYElxV91R5zU3GXDduQNPG8iQNtdKgQXXVLW71gXl5
	 fRmW8W+WmqtOuYX/bt+7acRqoQOvMWs/tb/l9dLqifK5e8D6y8omqS0IUDwTvWnmUF
	 1F33T1JsWwfXSls+ht4OCwM/ynfr2/txGMl1BZG+D42MTMRH6wjt8FtNVLI5StDKkm
	 cyfFCwSelTNh5o5BUDnQ68xW+NwKXbG9KE6xPzchGCg1TuE5BEY10KBkXbjn1Yy2DL
	 MtO6m2yoXCqug==
From: Arnd Bergmann <arnd@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org,
	patches@opensource.cirrus.com,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 00/21] gpiolib: fence off legacy interfaces
Date: Fri,  8 Aug 2025 17:17:44 +0200
Message-Id: <20250808151822.536879-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Commit 678bae2eaa81 ("gpiolib: make legacy interfaces optional") was
merged for linux-6.17, so now it is possible to use the legacy interfaces
conditionally and eventually have the support left out of the kernel
whenever it is not needed.

I created six patches to force-enable CONFIG_GPIOLIB_LEGACY on the
few (mostly ancient) platforms that still require this, plus a set of
patches to either add the corresponding Kconfig dependencies that make
the device drivers conditional on that symbol, or change them to no
longer require it.

The final patch ends up turning the Kconfig symbol off by default,
which of course depends on everything else getting merged first to avoid
build errors.

I would suggest that patches 1-20 can just get merged through the
respective maintainer trees independently when they are deemed ready,
and the final patch can wait another merge window.

     Arnd

Arnd Bergmann (21):
  ARM: select legacy gpiolib interfaces where used
  m68k: coldfire: select legacy gpiolib interface for mcfqspi
  mips: select legacy gpiolib interfaces where used
  sh: select legacy gpiolib interface
  x86/platform: select legacy gpiolib interfaces where used
  x86/olpc: select GPIOLIB_LEGACY
  mfd: wm8994: remove dead legacy-gpio code
  ASoC: add GPIOLIB_LEGACY dependency where needed
  input: gpio-keys: make legacy gpiolib optional
  leds: gpio: make legacy gpiolib interface optional
  media: em28xx: add special case for legacy gpiolib interface
  mfd: arizona: make legacy gpiolib interface optional
  mfd: si476x: add GPIOLIB_LEGACY dependency
  mfd: aat2870: add GPIOLIB_LEGACY dependency
  dsa: b53: hide legacy gpiolib usage on non-mips
  ath10k: remove gpio number assignment
  nfc: marvell: convert to gpio descriptors
  nfc: s3fwrn5: convert to gpio descriptors
  usb: udc: pxa: remove unused platform_data
  ASoC: pxa: add GPIOLIB_LEGACY dependency
  gpiolib: turn off legacy interface by default

 arch/arm/mach-mv78xx0/Kconfig                 |  1 +
 arch/arm/mach-orion5x/Kconfig                 |  1 +
 arch/arm/mach-pxa/Kconfig                     |  1 +
 arch/arm/mach-pxa/devices.c                   |  7 --
 arch/arm/mach-pxa/gumstix.c                   |  1 -
 arch/arm/mach-pxa/udc.h                       |  8 --
 arch/arm/mach-s3c/Kconfig.s3c64xx             |  1 +
 arch/arm/mach-sa1100/Kconfig                  |  1 +
 arch/m68k/Kconfig.cpu                         |  1 +
 arch/mips/Kconfig                             |  5 +
 arch/mips/alchemy/Kconfig                     |  1 -
 arch/mips/txx9/Kconfig                        |  1 +
 arch/sh/Kconfig                               |  1 +
 arch/sh/boards/Kconfig                        |  8 ++
 arch/sh/boards/mach-highlander/Kconfig        |  1 +
 arch/sh/boards/mach-rsk/Kconfig               |  3 +
 arch/x86/Kconfig                              |  1 +
 drivers/gpio/Kconfig                          | 11 ++-
 drivers/input/keyboard/gpio_keys.c            |  5 +-
 drivers/input/keyboard/gpio_keys_polled.c     |  2 +
 drivers/input/misc/Kconfig                    |  3 +
 drivers/leds/leds-gpio.c                      |  8 +-
 drivers/media/usb/em28xx/Kconfig              |  1 +
 drivers/media/usb/em28xx/em28xx-dvb.c         |  4 +-
 drivers/mfd/Kconfig                           |  2 +
 drivers/mfd/arizona-irq.c                     |  5 +-
 drivers/mfd/rohm-bd71828.c                    |  2 +
 drivers/mfd/rohm-bd718x7.c                    |  2 +
 drivers/mfd/wm8994-irq.c                      | 94 +------------------
 drivers/net/dsa/b53/b53_common.c              | 17 +---
 drivers/net/dsa/b53/b53_priv.h                | 24 +++--
 drivers/net/wireless/ath/ath10k/leds.c        |  3 +-
 drivers/nfc/nfcmrvl/main.c                    | 47 +++-------
 drivers/nfc/nfcmrvl/nfcmrvl.h                 |  5 +-
 drivers/nfc/nfcmrvl/uart.c                    |  5 -
 drivers/nfc/nfcmrvl/usb.c                     |  1 -
 drivers/nfc/s3fwrn5/i2c.c                     | 42 +++------
 drivers/nfc/s3fwrn5/phy_common.c              | 12 +--
 drivers/nfc/s3fwrn5/phy_common.h              |  4 +-
 drivers/nfc/s3fwrn5/uart.c                    | 30 ++----
 drivers/platform/x86/Kconfig                  |  3 +
 .../platform/x86/x86-android-tablets/Kconfig  |  1 +
 drivers/usb/gadget/udc/pxa25x_udc.c           | 41 +++-----
 drivers/usb/gadget/udc/pxa25x_udc.h           |  2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c           | 35 +------
 drivers/usb/gadget/udc/pxa27x_udc.h           |  2 -
 include/linux/gpio_keys.h                     |  2 +
 include/linux/leds.h                          |  2 +
 include/linux/mfd/arizona/pdata.h             |  6 ++
 include/linux/mfd/wm8994/pdata.h              |  5 -
 include/linux/platform_data/pxa2xx_udc.h      | 15 ---
 sound/pci/Kconfig                             |  1 +
 sound/soc/codecs/Kconfig                      |  4 +
 sound/soc/codecs/arizona-jack.c               | 17 +++-
 sound/soc/pxa/Kconfig                         |  4 +-
 55 files changed, 192 insertions(+), 320 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/udc.h

-- 
2.39.5

Cc: Linus Walleij <linus.walleij@linaro.org> (maintainer:GPIO SUBSYSTEM,commit_signer:1/2=50%)
Cc: Bartosz Golaszewski <brgl@bgdev.pl> (maintainer:GPIO SUBSYSTEM,commit_signer:1/7=14%,commit_signer:1/2=50%)
Cc: linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM)

Cc: Andrew Lunn <andrew@lunn.ch> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
Cc: Gregory Clement <gregory.clement@bootlin.com> (maintainer:ARM/Marvell Dove/MV78xx0/Orion SOC support)
Cc: Russell King <linux@armlinux.org.uk> (maintainer:ARM PORT)
Cc: Daniel Mack <daniel@zonque.org> (maintainer:PXA2xx/PXA3xx SUPPORT)
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> (maintainer:PXA2xx/PXA3xx SUPPORT)
Cc: Robert Jarzmik <robert.jarzmik@free.fr> (maintainer:PXA2xx/PXA3xx SUPPORT)
Cc: Krzysztof Kozlowski <krzk@kernel.org> (maintainer:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES,commit_signer:1/2=50%)
Cc: Alim Akhtar <alim.akhtar@samsung.com> (reviewer:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: Geert Uytterhoeven <geert@linux-m68k.org> (maintainer:M68K ARCHITECTURE,commit_signer:1/4=25%,authored:1/4=25%,added_lines:2/13=15%,removed_lines:2/6=33%)
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de> (maintainer:MIPS)
Cc: Yoshinori Sato <ysato@users.sourceforge.jp> (maintainer:SUPERH)
Cc: Rich Felker <dalias@libc.org> (maintainer:SUPERH)
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> (maintainer:SUPERH,commit_signer:2/4=50%)
Cc: Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT),added_lines:4/36=11%,removed_lines:6/49=12%)
Cc: Ingo Molnar <mingo@redhat.com> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: Borislav Petkov <bp@alien8.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: Dave Hansen <dave.hansen@linux.intel.com> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: "H. Peter Anvin" <hpa@zytor.com> (reviewer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...,commit_signer:5/7=71%,authored:1/7=14%,added_lines:17/36=47%,removed_lines:27/49=55%,commit_signer:1/2=50%,commit_signer:3/5=60%)
Cc: Lee Jones <lee@kernel.org> (maintainer:LED SUBSYSTEM,commit_signer:2/5=40%)
Cc: Pavel Machek <pavel@kernel.org> (maintainer:LED SUBSYSTEM)
Cc: Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:EM28XX VIDEO4LINUX DRIVER)
Cc: Matti Vaittinen <mazziesaccount@gmail.com> (maintainer:ROHM POWER MANAGEMENT IC DEVICE DRIVERS)
Cc: Florian Fainelli <florian.fainelli@broadcom.com> (maintainer:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER)
Cc: Jeff Johnson <jjohnson@kernel.org> (maintainer:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
Cc: Hans de Goede <hansg@kernel.org> (maintainer:X86 PLATFORM DRIVERS,commit_signer:1/7=14%)
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com> (maintainer:X86 PLATFORM DRIVERS)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:USB SUBSYSTEM)
Cc: Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
Cc: Takashi Iwai <tiwai@suse.com> (maintainer:SOUND,commit_signer:1/3=33%,authored:1/3=33%,removed_lines:2/2=100%)
Cc: Liam Girdwood <lgirdwood@gmail.com> (maintainer:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...)
Cc: Mark Brown <broonie@kernel.org> (maintainer:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...,commit_signer:26/29=90%,commit_signer:1/3=33%)
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com> (authored:1/7=14%,added_lines:4/36=11%,removed_lines:6/49=12%,commit_signer:1/2=50%,authored:1/2=50%,added_lines:5/7=71%,removed_lines:7/7=100%,added_lines:7/7=100%,removed_lines:2/7=29%)
Cc: "Dr. David Alan Gilbert" <linux@treblig.org> (commit_signer:1/5=20%,authored:1/5=20%,removed_lines:7/10=70%)
Cc: linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell Dove/MV78xx0/Orion SOC support)
Cc: linux-kernel@vger.kernel.org (open list)
Cc: linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: linux-m68k@lists.linux-m68k.org (open list:M68K ARCHITECTURE)
Cc: linux-mips@vger.kernel.org (open list:MIPS)
Cc: linux-sh@vger.kernel.org (open list:SUPERH)
Cc: linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
Cc: linux-leds@vger.kernel.org (open list:LED SUBSYSTEM)
Cc: linux-media@vger.kernel.org (open list:EM28XX VIDEO4LINUX DRIVER)
Cc: patches@opensource.cirrus.com (open list:WOLFSON MICROELECTRONICS DRIVERS)
Cc: netdev@vger.kernel.org (open list:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER)
Cc: linux-wireless@vger.kernel.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
Cc: ath10k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER)
Cc: platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Cc: linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Cc: linux-sound@vger.kernel.org (open list:SOUND)

