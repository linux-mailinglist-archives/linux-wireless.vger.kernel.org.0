Return-Path: <linux-wireless+bounces-25334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8592B02F36
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 09:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293001A615E7
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 07:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6321D7E35;
	Sun, 13 Jul 2025 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="EIOwdSe8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182E149C7B
	for <linux-wireless@vger.kernel.org>; Sun, 13 Jul 2025 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391199; cv=none; b=ku92lFEmblSj6prIK02r4FQChkmISURhSI8gAXp9ryrlslmZT7z/baS7UeNDHPZ8lh/hETQ4GCL/S0Uhvi5qUXkn9GN6ZmeIe0B43O/hl3lBdJF25GbmeUNXOGqjhDU+G2y27oVreiePz4nPiO8btxh7K5UMOxncofVg5ZHINSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391199; c=relaxed/simple;
	bh=xAPC6fbC/5styTt0OlZJlpIol/DyAk67PPmC15GsbPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUYTNX8VyVmtLxPm7ML2/jU4rZDFxB9cGMR91WSqwA724prgT/1SN5Rpaigxz8BMdmPYGbd4sA7YmDvMbzDrnHFl0eyzEmi6QOSug6MVb6aMJeJ82M3ZwN0M9ZrDZ6aTWkLKXzMgly1czQ9oSZy5WNv2eD6yW+ghJ22h7Qw6XM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=EIOwdSe8; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33678 invoked from network); 13 Jul 2025 09:19:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752391195; bh=nXAoM234OG9rCu8jKStzLy1mS45MNQY4lFEfySEMe7E=;
          h=From:To:Cc:Subject;
          b=EIOwdSe8WE+jxz1heiWff6azdBX6NLAMX2gJ9+S1kxSCEugaYyeyEK0ZEpM2bdAe3
           13MyXPguHexcqQF4BmMGD6RAuggyCwUqKN40fglRB9ppWnXxc4k/rH8ciA6oeWXEqV
           h7ECx93x03E7Gf67P/TgylVVde01zE+lH7AKtmPdyFF/fcBnxm6123RIaP2Ztm5txo
           +XPQukJpd8cQ1jZSuFz5I3oU6ESPLVa+EDUu5hpBpVGvJWKA+FpqP3W4ZcoHXJCVuK
           lzpTfTl1iwVSxP67ED33mIdBshkt/rxjwUXxq1RP7ERJ5HQwmfwL7OGBoGtg1dTkta
           /WcnjZjIwHfsw==
Received: from 89-64-3-180.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.180])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rosenp@gmail.com>; 13 Jul 2025 09:19:55 +0200
Date: Sun, 13 Jul 2025 09:19:54 +0200
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
Subject: Re: [PATCHv4 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Message-ID: <20250713071954.GC18469@wp.pl>
References: <20250712210448.429318-1-rosenp@gmail.com>
 <20250712210448.429318-6-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712210448.429318-6-rosenp@gmail.com>
X-WP-MailID: 5d4781cd5bae9ac13802d4c5f972c281
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MYOB]                               

On Sat, Jul 12, 2025 at 02:04:46PM -0700, Rosen Penev wrote:
> Remove a bunch of static memory management functions and simplify with
> devm.
> 
> Also move allocation before ieee80211_alloc_hw to get rid of goto
> statements and clarify the error handling a bit more.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  .../net/wireless/ralink/rt2x00/rt2800soc.c    | 185 ++++++++----------
>  1 file changed, 79 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> index a19906c35d0a..6f148dec2469 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  
>  #include "rt2x00.h"
> @@ -130,108 +131,8 @@ static int rt2800soc_write_firmware(struct rt2x00_dev *rt2x00dev,
>  	return 0;
>  }
>  
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
> -static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
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
> -
> -static void rt2x00soc_remove(struct platform_device *pdev)
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
> -
>  #ifdef CONFIG_PM
> -static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
> +static int rt2800soc_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>  	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
>  	struct rt2x00_dev *rt2x00dev = hw->priv;
> @@ -239,7 +140,7 @@ static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
>  	return rt2x00lib_suspend(rt2x00dev);
>  }
>  
> -static int rt2x00soc_resume(struct platform_device *pdev)
> +static int rt2800soc_resume(struct platform_device *pdev)
>  {
>  	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
>  	struct rt2x00_dev *rt2x00dev = hw->priv;
> @@ -357,7 +258,77 @@ static const struct rt2x00_ops rt2800soc_ops = {
>  
>  static int rt2800soc_probe(struct platform_device *pdev)
>  {
> -	return rt2x00soc_probe(pdev, &rt2800soc_ops);
> +	const struct rt2x00_ops *ops = of_device_get_match_data(&pdev->dev);
> +	struct rt2x00_dev *rt2x00dev;
> +	struct ieee80211_hw *hw;
> +	void __iomem *mem;
> +	struct clk *clk;
> +	__le16 *eeprom;
> +	int retval;
> +	u32 *rf;
> +	int irq;
> +
> +	mem = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mem))
> +		return PTR_ERR(mem);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	clk = devm_clk_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	eeprom = devm_kzalloc(&pdev->dev, ops->eeprom_size, GFP_KERNEL);
> +	if (!eeprom)
> +		return -ENOMEM;
> +
> +	rf = devm_kzalloc(&pdev->dev, ops->rf_size, GFP_KERNEL);
> +	if (!rf)
> +		return -ENOMEM;
> +
> +	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
> +	if (!hw)
> +		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate hardware");
> +
> +	platform_set_drvdata(pdev, hw);
> +
> +	rt2x00dev = hw->priv;
> +	rt2x00dev->dev = &pdev->dev;
> +	rt2x00dev->ops = ops;
> +	rt2x00dev->hw = hw;
> +	rt2x00dev->irq = irq;
> +	rt2x00dev->clk = clk;
> +	rt2x00dev->eeprom = eeprom;
> +	rt2x00dev->rf = rf;
> +	rt2x00dev->name = pdev->dev.driver->name;
> +	rt2x00dev->csr.base = mem;
> +
> +	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
> +
> +	retval = rt2x00lib_probe_dev(rt2x00dev);
> +	if (retval)
> +		goto exit_free_device;
> +
> +	return 0;
> +
> +exit_free_device:
> +	ieee80211_free_hw(hw);
> +
> +	return retval;
> +}
> +
> +static void rt2800soc_remove(struct platform_device *pdev)
> +{
> +	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
> +	struct rt2x00_dev *rt2x00dev = hw->priv;
> +
> +	/*
> +	 * Free all allocated data.
> +	 */
> +	rt2x00lib_remove_dev(rt2x00dev);
> +	ieee80211_free_hw(hw);
>  }
>  
>  static const struct of_device_id rt2880_wmac_match[] = {
> @@ -372,9 +343,11 @@ static struct platform_driver rt2800soc_driver = {
>  		.of_match_table = rt2880_wmac_match,
>  	},
>  	.probe		= rt2800soc_probe,
> -	.remove		= rt2x00soc_remove,
> -	.suspend	= rt2x00soc_suspend,
> -	.resume		= rt2x00soc_resume,
> +	.remove		= rt2800soc_remove,
> +#ifdef CONFIG_PM
> +	.suspend	= rt2800soc_suspend,
> +	.resume		= rt2800soc_resume,
> +#endif
>  };
>  
>  module_platform_driver(rt2800soc_driver);
> -- 
> 2.50.0
> 

