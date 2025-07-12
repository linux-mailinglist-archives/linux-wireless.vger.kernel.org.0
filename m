Return-Path: <linux-wireless+bounces-25313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E952B02A69
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB037A802C
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13721273D85;
	Sat, 12 Jul 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="rns9txDP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FFB273D66
	for <linux-wireless@vger.kernel.org>; Sat, 12 Jul 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752315639; cv=none; b=frsRPXQ8uz5tVDzjSjVh4v/1Te83PwunIao4vXVFEwu9fDgBlQNa7PBga0/spsfQXiex8lVGb6/Co1vvX7qakZr9q9Uz8O5voAYxcors5TfyZmkLpHaDU9JZPlwGD4mzHSTCI0MiScx9meGq/uKjtOM0OcX+rPZqRgNpfsq2pGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752315639; c=relaxed/simple;
	bh=j1s59oPAb4bVcYMPFHev2W/lMcmXhl0y2qlCMeT5F8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goegeFIyudvBldwzGpE+jm7l/TWoJdtJFXfnxo+nAAeaaqECPAPk4PORTqIP2LnMjIO9PiBDmT7e1W/c2xm7nPxrQU3eIRMs3xZ6muphWRcM1bTljFklLuR4ZB0UQvDXE5vlS/VtEJY3x9MAR0qhvLG4cOnU28HUgaxeIBbwdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=rns9txDP; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 26666 invoked from network); 12 Jul 2025 12:20:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752315631; bh=61F+GlsgsQKOVx2NEzbmz5vCdf2PV5lBMexPsqNrBkQ=;
          h=From:To:Cc:Subject;
          b=rns9txDPIyaDIIsiivzTQMlNs5p/IPt+fjF/uYD8RzmaF6g1fOzG0fAIbC9NCAeLE
           gMrPgclwF8D152O1w5YlGhVu6XzeF8fJRF0qFq9vCVGi+iyvnnHb5MEKwKnY7mBqa6
           jVzi5Jpl5e4dCb1c4Sx5OHUQxaaMVrnNZipHtsFJ/dVp5fomAFlQwHUl3QoyNVNgh5
           krWlX10Z2xob1wmXce+kLp+RNxuBFTkDyUU8Jcpzz3HtrMXop0y8UhtT9gO3+zv7y3
           4AtkoslPThsgZfafMIeVg2JMhWXYtHYLXQ0ga1HrIZqapaI/EK2B15oFF/oLj6JxgA
           bxwGNzTih4GgA==
Received: from 89-64-3-180.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.180])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 12 Jul 2025 12:20:31 +0200
Date: Sat, 12 Jul 2025 12:20:31 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCHv3 wireless-next 4/7] wifi: rt2800: move 2x00soc to 2800soc
Message-ID: <20250712102031.GA13264@wp.pl>
References: <20250710200820.262295-1-rosenp@gmail.com>
 <20250710200820.262295-5-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710200820.262295-5-rosenp@gmail.com>
X-WP-MailID: d421b79413c679fd27ca1628dcc50f56
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [4QGC]                               

On Thu, Jul 10, 2025 at 01:08:17PM -0700, Rosen Penev wrote:
> This driver was written with multiple SOC platforms in mind. However
> since Ralink was aquired by Mediatek, it only effectively got used by
> older platforms. As such, we can slim down the driver slightly by moving
> all of rt2x00soc to rt2800soc in order to benefit from inlining.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/Kconfig    |   5 -
>  drivers/net/wireless/ralink/rt2x00/Makefile   |   1 -
>  .../net/wireless/ralink/rt2x00/rt2800soc.c    | 119 +++++++++++++-
>  .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 151 ------------------
>  .../net/wireless/ralink/rt2x00/rt2x00soc.h    |  29 ----
>  5 files changed, 118 insertions(+), 187 deletions(-)
>  delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
>  delete mode 100644 drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
> index a0dc9a751234..4d98b7723c56 100644
> --- a/drivers/net/wireless/ralink/rt2x00/Kconfig
> +++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
> @@ -203,7 +203,6 @@ endif
>  config RT2800SOC
>  	tristate "Ralink WiSoC support"
>  	depends on OF && (SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST)
> -	select RT2X00_LIB_SOC
>  	select RT2X00_LIB_MMIO
>  	select RT2X00_LIB_CRYPTO
>  	select RT2X00_LIB_FIRMWARE
> @@ -231,10 +230,6 @@ config RT2X00_LIB_PCI
>  	tristate
>  	select RT2X00_LIB
>  
> -config RT2X00_LIB_SOC
> -	tristate
> -	select RT2X00_LIB
> -
>  config RT2X00_LIB_USB
>  	tristate
>  	select RT2X00_LIB
> diff --git a/drivers/net/wireless/ralink/rt2x00/Makefile b/drivers/net/wireless/ralink/rt2x00/Makefile
> index de030ebcdf6e..48d84d243606 100644
> --- a/drivers/net/wireless/ralink/rt2x00/Makefile
> +++ b/drivers/net/wireless/ralink/rt2x00/Makefile
> @@ -12,7 +12,6 @@ rt2x00lib-$(CONFIG_RT2X00_LIB_LEDS)	+= rt2x00leds.o
>  obj-$(CONFIG_RT2X00_LIB)		+= rt2x00lib.o
>  obj-$(CONFIG_RT2X00_LIB_MMIO)		+= rt2x00mmio.o
>  obj-$(CONFIG_RT2X00_LIB_PCI)		+= rt2x00pci.o
> -obj-$(CONFIG_RT2X00_LIB_SOC)		+= rt2x00soc.o
>  obj-$(CONFIG_RT2X00_LIB_USB)		+= rt2x00usb.o
>  obj-$(CONFIG_RT2800_LIB)		+= rt2800lib.o
>  obj-$(CONFIG_RT2800_LIB_MMIO)		+= rt2800mmio.o
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> index db8d01f0cdc3..a19906c35d0a 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> @@ -22,7 +22,6 @@
>  
>  #include "rt2x00.h"
>  #include "rt2x00mmio.h"
> -#include "rt2x00soc.h"
>  #include "rt2800.h"
>  #include "rt2800lib.h"
>  #include "rt2800mmio.h"
> @@ -131,6 +130,124 @@ static int rt2800soc_write_firmware(struct rt2x00_dev *rt2x00dev,
>  	return 0;
>  }
>  
> +static void rt2x00soc_free_reg(struct rt2x00_dev *rt2x00dev)
> +{
> +	kfree(rt2x00dev->rf);
> +	rt2x00dev->rf = NULL;
> +
> +	kfree(rt2x00dev->eeprom);
> +	rt2x00dev->eeprom = NULL;
> +
> +	iounmap(rt2x00dev->csr.base);
> +}
> +
> +static int rt2x00soc_alloc_reg(struct rt2x00_dev *rt2x00dev)
> +{
> +	struct platform_device *pdev = to_platform_device(rt2x00dev->dev);
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	rt2x00dev->csr.base = ioremap(res->start, resource_size(res));
> +	if (!rt2x00dev->csr.base)
> +		return -ENOMEM;
> +
> +	rt2x00dev->eeprom = kzalloc(rt2x00dev->ops->eeprom_size, GFP_KERNEL);
> +	if (!rt2x00dev->eeprom)
> +		goto exit;
> +
> +	rt2x00dev->rf = kzalloc(rt2x00dev->ops->rf_size, GFP_KERNEL);
> +	if (!rt2x00dev->rf)
> +		goto exit;
> +
> +	return 0;
> +
> +exit:
> +	rt2x00_probe_err("Failed to allocate registers\n");
> +	rt2x00soc_free_reg(rt2x00dev);
> +
> +	return -ENOMEM;
> +}
> +
> +static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
> +{
> +	struct ieee80211_hw *hw;
> +	struct rt2x00_dev *rt2x00dev;
> +	int retval;
> +
> +	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
> +	if (!hw) {
> +		rt2x00_probe_err("Failed to allocate hardware\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, hw);
> +
> +	rt2x00dev = hw->priv;
> +	rt2x00dev->dev = &pdev->dev;
> +	rt2x00dev->ops = ops;
> +	rt2x00dev->hw = hw;
> +	rt2x00dev->irq = platform_get_irq(pdev, 0);
> +	rt2x00dev->name = pdev->dev.driver->name;
> +
> +	rt2x00dev->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rt2x00dev->clk))
> +		rt2x00dev->clk = NULL;
> +
> +	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
> +
> +	retval = rt2x00soc_alloc_reg(rt2x00dev);
> +	if (retval)
> +		goto exit_free_device;
> +
> +	retval = rt2x00lib_probe_dev(rt2x00dev);
> +	if (retval)
> +		goto exit_free_reg;
> +
> +	return 0;
> +
> +exit_free_reg:
> +	rt2x00soc_free_reg(rt2x00dev);
> +
> +exit_free_device:
> +	ieee80211_free_hw(hw);
> +
> +	return retval;
> +}
> +
> +static void rt2x00soc_remove(struct platform_device *pdev)
> +{
> +	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
> +	struct rt2x00_dev *rt2x00dev = hw->priv;
> +
> +	/*
> +	 * Free all allocated data.
> +	 */
> +	rt2x00lib_remove_dev(rt2x00dev);
> +	rt2x00soc_free_reg(rt2x00dev);
> +	ieee80211_free_hw(hw);
> +}
> +
> +#ifdef CONFIG_PM
> +static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
> +	struct rt2x00_dev *rt2x00dev = hw->priv;
> +
> +	return rt2x00lib_suspend(rt2x00dev);
> +}
> +
> +static int rt2x00soc_resume(struct platform_device *pdev)
> +{
> +	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
> +	struct rt2x00_dev *rt2x00dev = hw->priv;
> +
> +	return rt2x00lib_resume(rt2x00dev);
> +}
> +#endif /* CONFIG_PM */
> +
>  static const struct ieee80211_ops rt2800soc_mac80211_ops = {
>  	.add_chanctx = ieee80211_emulate_add_chanctx,
>  	.remove_chanctx = ieee80211_emulate_remove_chanctx,
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
> deleted file mode 100644
> index f7f3a2340c39..000000000000
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
> +++ /dev/null
> @@ -1,151 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> -	Copyright (C) 2004 - 2009 Ivo van Doorn <IvDoorn@gmail.com>
> -	Copyright (C) 2004 - 2009 Felix Fietkau <nbd@openwrt.org>
> -	<http://rt2x00.serialmonkey.com>
> -
> - */
> -
> -/*
> -	Module: rt2x00soc
> -	Abstract: rt2x00 generic soc device routines.
> - */
> -
> -#include <linux/bug.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -
> -#include "rt2x00.h"
> -#include "rt2x00soc.h"
> -
> -static void rt2x00soc_free_reg(struct rt2x00_dev *rt2x00dev)
> -{
> -	kfree(rt2x00dev->rf);
> -	rt2x00dev->rf = NULL;
> -
> -	kfree(rt2x00dev->eeprom);
> -	rt2x00dev->eeprom = NULL;
> -
> -	iounmap(rt2x00dev->csr.base);
> -}
> -
> -static int rt2x00soc_alloc_reg(struct rt2x00_dev *rt2x00dev)
> -{
> -	struct platform_device *pdev = to_platform_device(rt2x00dev->dev);
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENODEV;
> -
> -	rt2x00dev->csr.base = ioremap(res->start, resource_size(res));
> -	if (!rt2x00dev->csr.base)
> -		return -ENOMEM;
> -
> -	rt2x00dev->eeprom = kzalloc(rt2x00dev->ops->eeprom_size, GFP_KERNEL);
> -	if (!rt2x00dev->eeprom)
> -		goto exit;
> -
> -	rt2x00dev->rf = kzalloc(rt2x00dev->ops->rf_size, GFP_KERNEL);
> -	if (!rt2x00dev->rf)
> -		goto exit;
> -
> -	return 0;
> -
> -exit:
> -	rt2x00_probe_err("Failed to allocate registers\n");
> -	rt2x00soc_free_reg(rt2x00dev);
> -
> -	return -ENOMEM;
> -}
> -
> -int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
> -{
> -	struct ieee80211_hw *hw;
> -	struct rt2x00_dev *rt2x00dev;
> -	int retval;
> -
> -	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
> -	if (!hw) {
> -		rt2x00_probe_err("Failed to allocate hardware\n");
> -		return -ENOMEM;
> -	}
> -
> -	platform_set_drvdata(pdev, hw);
> -
> -	rt2x00dev = hw->priv;
> -	rt2x00dev->dev = &pdev->dev;
> -	rt2x00dev->ops = ops;
> -	rt2x00dev->hw = hw;
> -	rt2x00dev->irq = platform_get_irq(pdev, 0);
> -	rt2x00dev->name = pdev->dev.driver->name;
> -
> -	rt2x00dev->clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(rt2x00dev->clk))
> -		rt2x00dev->clk = NULL;
> -
> -	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
> -
> -	retval = rt2x00soc_alloc_reg(rt2x00dev);
> -	if (retval)
> -		goto exit_free_device;
> -
> -	retval = rt2x00lib_probe_dev(rt2x00dev);
> -	if (retval)
> -		goto exit_free_reg;
> -
> -	return 0;
> -
> -exit_free_reg:
> -	rt2x00soc_free_reg(rt2x00dev);
> -
> -exit_free_device:
> -	ieee80211_free_hw(hw);
> -
> -	return retval;
> -}
> -EXPORT_SYMBOL_GPL(rt2x00soc_probe);
> -
> -void rt2x00soc_remove(struct platform_device *pdev)
> -{
> -	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
> -	struct rt2x00_dev *rt2x00dev = hw->priv;
> -
> -	/*
> -	 * Free all allocated data.
> -	 */
> -	rt2x00lib_remove_dev(rt2x00dev);
> -	rt2x00soc_free_reg(rt2x00dev);
> -	ieee80211_free_hw(hw);
> -}
> -EXPORT_SYMBOL_GPL(rt2x00soc_remove);
> -
> -#ifdef CONFIG_PM
> -int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
> -{
> -	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
> -	struct rt2x00_dev *rt2x00dev = hw->priv;
> -
> -	return rt2x00lib_suspend(rt2x00dev);
> -}
> -EXPORT_SYMBOL_GPL(rt2x00soc_suspend);
> -
> -int rt2x00soc_resume(struct platform_device *pdev)
> -{
> -	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
> -	struct rt2x00_dev *rt2x00dev = hw->priv;
> -
> -	return rt2x00lib_resume(rt2x00dev);
> -}
> -EXPORT_SYMBOL_GPL(rt2x00soc_resume);
> -#endif /* CONFIG_PM */
> -
> -/*
> - * rt2x00soc module information.
> - */
> -MODULE_AUTHOR(DRV_PROJECT);
> -MODULE_VERSION(DRV_VERSION);
> -MODULE_DESCRIPTION("rt2x00 soc library");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
> deleted file mode 100644
> index d6226b8a10e0..000000000000
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> -	Copyright (C) 2004 - 2009 Ivo van Doorn <IvDoorn@gmail.com>
> -	<http://rt2x00.serialmonkey.com>
> -
> - */
> -
> -/*
> -	Module: rt2x00soc
> -	Abstract: Data structures for the rt2x00soc module.
> - */
> -
> -#ifndef RT2X00SOC_H
> -#define RT2X00SOC_H
> -
> -/*
> - * SoC driver handlers.
> - */
> -int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops);
> -void rt2x00soc_remove(struct platform_device *pdev);
> -#ifdef CONFIG_PM
> -int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state);
> -int rt2x00soc_resume(struct platform_device *pdev);
> -#else
> -#define rt2x00soc_suspend	NULL
> -#define rt2x00soc_resume	NULL
> -#endif /* CONFIG_PM */
> -
> -#endif /* RT2X00SOC_H */
> -- 
> 2.50.0
> 

