Return-Path: <linux-wireless+bounces-9272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979D90FCB1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 08:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794631F2568A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8FB3BB22;
	Thu, 20 Jun 2024 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="dE+amQ/j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DE1CFA9;
	Thu, 20 Jun 2024 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864979; cv=none; b=dXFNG5XBmXQ5ho+9CBA9zt8HXkBNdesm3UbaNr37+Nvz2QjuS960EHnlGwBdxsEgcJtZ9hxDx/XLzTRaSIjMIKloJsaqIuh147AUZJn5RBc8q79Ge3WT25bIPF8I/xAHZ0ikkyNRzoDA3ftueAw9czCJl9ABMFSdx62uac8SWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864979; c=relaxed/simple;
	bh=DM47QfH0OnPYYsBaUwpgRf2+2jamsLzfAMfcSGpafHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/w9KmSVKAx7Wpn5canLJPbLfFxtjrOmXHbNa3fbC3f9QxxRm1znkr6FNvYTR0eG9/l1IYvpj3WvE6Oj0/RayGPUZDEm3cIDewWfHtuD2RBItrg8ZZ6Jlyt7Mr4XNn7YJ/z+nwMguYbWbaDq1JG+sfqfOhE6b0sv8VPaNxjdFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=dE+amQ/j; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1718864576; bh=DM47QfH0OnPYYsBaUwpgRf2+2jamsLzfAMfcSGpafHw=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=dE+amQ/jE6lb3989A+35c/U3LqF132QheJhXd10NoItHaxRBfUhoeGHT0lblb9E2T
	 pA5e9M1yj19xOBnJ3b0OjVfVBRqNsfy6BPeKzCB0jQ3gxHnWIqmBV/n4hCsrfuGVrv
	 miTwGm2CzbESi2Rbz/zySAaZbccXaiQedMnHUqf0=
Date: Thu, 20 Jun 2024 08:22:54 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: arend.vanspriel@broadcom.com, kvalo@kernel.org, duoming@zju.edu.cn, 
	bhelgaas@google.com, minipli@grsecurity.net, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, nick@khadas.com, 
	efectn@protonmail.com, jagan@edgeble.ai, dsimic@manjaro.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] net: wireless: brcmfmac: Add optional 32k clock
 enable support
Message-ID: <4ynke3hcrkzowv63u43b55zidr55gzlnca6vvwrndvvpb5r57y@iberusehts5q>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jacobe Zang <jacobe.zang@wesion.com>, arend.vanspriel@broadcom.com, kvalo@kernel.org, 
	duoming@zju.edu.cn, bhelgaas@google.com, minipli@grsecurity.net, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	nick@khadas.com, efectn@protonmail.com, jagan@edgeble.ai, dsimic@manjaro.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240620020015.4021696-1-jacobe.zang@wesion.com>
 <20240620020015.4021696-3-jacobe.zang@wesion.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620020015.4021696-3-jacobe.zang@wesion.com>

Hi,

On Thu, Jun 20, 2024 at 10:00:14AM GMT, Jacobe Zang wrote:
> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver.

There's also this approach https://lore.kernel.org/lkml/20240117160748.37682-1-brgl@bgdev.pl/

> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 06698a714b523..f241e1757d7e3 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2014 Broadcom Corporation
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/firmware.h>
> @@ -2411,6 +2412,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct brcmf_pciedev *pcie_bus_dev;
>  	struct brcmf_core *core;
>  	struct brcmf_bus *bus;
> +	struct clk *clk;
>  
>  	if (!id) {
>  		id = pci_match_id(brcmf_pcie_devid_table, pdev);
> @@ -2422,6 +2424,14 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	brcmf_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
>  
> +	clk = devm_clk_get_optional_enabled(&pdev->dev, "32k");

If you do this, you need to update the DT bindings. Current ones don't have 32k
clock.

> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +	if (clk) {
> +		dev_info(&pdev->dev, "enabling 32kHz clock\n");

The driver has its own debug logging infrastructure (brcmf_dbg).

Kind regards,
	o.

> +		clk_set_rate(clk, 32768);
> +	}
> +
>  	ret = -ENOMEM;
>  	devinfo = kzalloc(sizeof(*devinfo), GFP_KERNEL);
>  	if (devinfo == NULL)
> -- 
> 2.34.1
> 

