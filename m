Return-Path: <linux-wireless+bounces-8342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE38D5B94
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9D11C212BD
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D47404C;
	Fri, 31 May 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfElxK7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0D74047;
	Fri, 31 May 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140908; cv=none; b=iQMKHxOLRHJUbewAFsKJg2VPZVj32bE960Mg3Sq+/cp0IUPen6WKbObkmEOo2aRYruXaIefGDgRMMwbHOwH+MRenCAxYgL73xa19wgwSi6P00w9U+Ts4PBQSS3QY4AzYV8bmNFV6JzR6LlzmQWjvoS7jZgDnLTzHzNx+5qg14NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140908; c=relaxed/simple;
	bh=FcnVBrBbVGC7mRLxRj7oghdJQTffvfVGCO/SyOTquqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHWYfZpEhCaHOzwi+d4TfGn/6MsJD7rT9f8NozntOXdjBDwD1EBcPy+HRWN36a2Du8JNOL2YJOG1nCrfBeqFabxHtiKoa3tbbedB5tMC0v8ifKu/9BENX0BfJaf0+HMyt8VXvZpyhsp/hzNc8Mo3gXlB20OgYEsOQMGpvRYdrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfElxK7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9339C116B1;
	Fri, 31 May 2024 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717140908;
	bh=FcnVBrBbVGC7mRLxRj7oghdJQTffvfVGCO/SyOTquqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lfElxK7CSmmItFg/3fv/OQEkZMUw91XC7sbno6BalS5q5T0N6Si382+KmsPSlJa4H
	 +PuT2WSCc09ikx+RJlSu6gTsflx40RccLamZMHPmtzp4APJiA6UfxupW3wuu+HspWx
	 kAUwT6L1V484CjC19dfn6nl7N6Ir+nqmppJ47+7NJMnuU8t2WkLGBqfwTP+LbYvT2A
	 WS9PmEkpj+qk6jU4fT4PTs2qHliXp2ChYyy7vJDlZjQw0w+hq9WkQ1VMWqtVOGaCuL
	 qgnFTbK+8AF2oQkp7Z2PkybC3XAl8GpyQtw1mMB+tzUbU6Os+QKpnX0X5HSxFWqSxt
	 46+5+FVFd1Rxg==
Message-ID: <97d8acf9-6cb3-4da7-ad4e-0f2d0a63c172@kernel.org>
Date: Fri, 31 May 2024 09:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] Add main.c
To: "Nemanov, Michael" <michael.nemanov@ti.com>, Kalle Valo
 <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Breno Leitao <leitao@debian.org>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-9-michael.nemanov@ti.com>
 <cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
 <456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/05/2024 13:54, Nemanov, Michael wrote:
> 
> 
> On 5/22/2024 12:46 PM, Krzysztof Kozlowski wrote:
>> ... > +} > + > +static int read_version_info(struct cc33xx *cc) > +{ > 
>> + int ret; > + > + cc33xx_info("Wireless driver version %s", 
>> DRV_VERSION); Drop > + > + ret = cc33xx_acx_init_get_fw_versions(cc); 
>>> + if (ret < 0) { > + cc33xx_error("Get FW version FAILED!"); > + 
>> return ret; > + } > + > + cc33xx_info("Wireless firmware version 
>> %u.%u.%u.%u", > + cc->all_versions.fw_ver->major_version, > + 
>> cc->all_versions.fw_ver->minor_version, > + 
>> cc->all_versions.fw_ver->api_version, > + 
>> cc->all_versions.fw_ver->build_version); > + > + cc33xx_info("Wireless 
>> PHY version %u.%u.%u.%u.%u.%u", > + 
>> cc->all_versions.fw_ver->phy_version[5], > + 
>> cc->all_versions.fw_ver->phy_version[4], > + 
>> cc->all_versions.fw_ver->phy_version[3], > + 
>> cc->all_versions.fw_ver->phy_version[2], > + 
>> cc->all_versions.fw_ver->phy_version[1], > + 
>> cc->all_versions.fw_ver->phy_version[0]); > + > + 
>> cc->all_versions.driver_ver = DRV_VERSION; Drop
> You mean drop the trace? Will exposing FW/PHY versions via debugfs be OK?

It's impossible to read your email.

I have no clue what you are referring to.


>>> +} > + > +static int cc33xx_remove(struct platform_device *pdev) Why 
>> remove callback is before probe? Please follow standard driver 
>> convention. This goes immediately after probe.
> Will fix
> 
> [...]
>>> +{ > + struct cc33xx_platdev_data *pdev_data = 
>> dev_get_platdata(&pdev->dev); > + struct cc33xx *cc = 
>> platform_get_drvdata(pdev); > + > + 
>> set_bit(CC33XX_FLAG_DRIVER_REMOVED, &cc->flags); ?!?! Your code is 
>> seriously buggy if you depend on setting bit in remove callback.
> If removal of the CC33xx driver was caused by the removal of its parent 
> SDIO device then all I/O operations will fail as SDIO transport is no 
> longer available. This will eventually trigger the recovery mechanism 
> which in this case is futile. If this flag is set, no recovery is attempted.
> 
> [...]
>>> + return -EINVAL; > + } > + > + hw = 
>> cc33xx_alloc_hw(CC33XX_AGGR_BUFFER_SIZE); > + if (IS_ERR(hw)) { > + 
>> cc33xx_error("can't allocate hw"); Heh? Since when do we print memory 
>> allocation failures? Since when memory allocation returns ERR ptr?
> Will fix
>>> +}; > +MODULE_DEVICE_TABLE(platform, cc33xx_id_table); > + > +static 
>> struct platform_driver cc33xx_driver = { > + .probe = cc33xx_probe, > 
>> + .remove = cc33xx_remove, > + .id_table = cc33xx_id_table, > + 
>> .driver = { > + .name = "cc33xx_driver", > + } > +}; > + > +u32 
>> cc33xx_debug_level = DEBUG_NO_DATAPATH; Why this is global? Why u32? 
>> Why global variable is defined at the end of the file?!?!
> cc33xx_debug_level together with cc33xx_debug/info/error() macros is how 
> all traces were done in drivers/net/wireless/ti/wlcore/ (originally was 
> wl1271_debug/info etc.) It enables / disables traces without rebuilding 
> or even reloading which is very helpful for remote support. These macros 
> map to dynamic_pr_debug / pr_debug. I saw similar wrappers in other 
> wireless drivers (ath12k). This is also why there are plenty of 
> cc33xx_debug() all over the code, most are silent by default.
>>> +
>>> +module_platform_driver(cc33xx_driver);
>>> +
>>> +module_param_named(debug_level, cc33xx_debug_level, uint, 0600);
>>> +MODULE_PARM_DESC(debug_level, "cc33xx debugging level");
>>> +
>>> +MODULE_PARM_DESC(secure_boot_enable, "Enables secure boot and FW downlaod");
>>
>> Eh? why secure boot is module param?
>>
>>> +
>>> +module_param_named(fwlog, fwlog_param, charp, 0);
>>> +MODULE_PARM_DESC(fwlog, "FW logger options: continuous, dbgpins or disable");
>>> +
>>> +module_param(no_recovery, int, 0600);
>>> +MODULE_PARM_DESC(no_recovery, "Prevent HW recovery. FW will remain stuck.");
>>> +
>>> +module_param_named(ht_mode, ht_mode_param, charp, 0400);
>>> +MODULE_PARM_DESC(ht_mode, "Force HT mode: wide or siso20");
>>
>> Does not look like suitable for module params.
> Was useful during development but can be removed
>>> +
>>> +MODULE_LICENSE("GPL v2");
>>> +MODULE_DESCRIPTION("Texas Instruments CC33xx WLAN driver");
>>> +MODULE_AUTHOR("Michael Nemanov <michael.nemanov@ti.com>");
>>> +MODULE_AUTHOR("Sabeeh Khan <sabeeh-khan@ti.com>");
>>> +
>>> +MODULE_VERSION(DRV_VERSION);
>>
>> Drop.
> I saw other drivers use this, is it no longer allowed?

Was never allowed. There is only one version: the kernel version. There
were many comments already explaining why "driver version" is
wrong/meaningless.

Best regards,
Krzysztof


