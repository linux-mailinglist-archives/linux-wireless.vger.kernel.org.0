Return-Path: <linux-wireless+bounces-7943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58F8CBE72
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B24281BA8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 May 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406F7F460;
	Wed, 22 May 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ8KSH1v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC419470;
	Wed, 22 May 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371187; cv=none; b=VttJR0mk4cQNH1KV/XCW8mQwu47kLgCnYAiDvjTNTs58mudqvMMBr1beX7AswNFXPSfZ8N4XnPrBchYX4/TH7G8TlKUn1oXI3MGBgPyW7LWoNk9j4yqTbhMSU56TUnlmYju4fyGXkDVgnQi4UUtOrqclm8AsX8Tcx2G65TXWJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371187; c=relaxed/simple;
	bh=QJumkkZR6qagpwpY/H8WHNdfEgsCNhV3ncAsS/9+02Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZDDHOowJVpR44ivTPzFzXxZRtHxtpKiP1tuy/hTd9WXf9JT0rga47iqrDcA6EOEmZ3cAk+rkPSQ9K6sciNHHLjbOVNdnP79U9pmLOrboQWG6YsNKuA1ytEDc39d8490Jxk0SC48TSI9J4J99Zi0Jz96k1980QHV3Nrs1v5+ZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ8KSH1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB18C2BD11;
	Wed, 22 May 2024 09:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716371186;
	bh=QJumkkZR6qagpwpY/H8WHNdfEgsCNhV3ncAsS/9+02Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kQ8KSH1vGkcgrSK5f25Wb1fxM/+dk3Q5TK7GuUIwfsjKpbgDaSDCHEcL1I4cmODw0
	 SIbw4QZv2fqFd6L+h62OqAzz4fvt51MFjHs83FDmBSGZl9dSP3Bv6q3f520qh7eATv
	 ZAK94DvjP09UdWxCXZQIqolL1GnGo3T2vnzdUvHULF+3s9TvYNQzXbx4Qu0aiRisw5
	 ziiH20rKUP8Z4PvyHROHg5kt6Pc7nMpQRJziicxoQuX2EzXuGWvXWcoX+QpQzH6owz
	 WjdptlNp3ELfcXQS59MXvJClqB8vL3fErg3jIBGAyftrMaahHyYhdbciVfKtvoRmlo
	 TjwZ97qqJgndA==
Message-ID: <cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
Date: Wed, 22 May 2024 11:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] Add main.c
To: michael.nemanov@ti.com, Kalle Valo <kvalo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, Breno Leitao <leitao@debian.org>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-9-michael.nemanov@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240521171841.884576-9-michael.nemanov@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/05/2024 19:18, michael.nemanov@ti.com wrote:
> From: Michael Nemanov <Michael.Nemanov@ti.com>
> 
> General code and structures.
> Notably:
> 


...

> +}
> +
> +static int read_version_info(struct cc33xx *cc)
> +{
> +	int ret;
> +
> +	cc33xx_info("Wireless driver version %s", DRV_VERSION);

Drop

> +
> +	ret = cc33xx_acx_init_get_fw_versions(cc);
> +	if (ret < 0) {
> +		cc33xx_error("Get FW version FAILED!");
> +		return ret;
> +	}
> +
> +	cc33xx_info("Wireless firmware version %u.%u.%u.%u",
> +		    cc->all_versions.fw_ver->major_version,
> +		    cc->all_versions.fw_ver->minor_version,
> +		    cc->all_versions.fw_ver->api_version,
> +		    cc->all_versions.fw_ver->build_version);
> +
> +	cc33xx_info("Wireless PHY version %u.%u.%u.%u.%u.%u",
> +		    cc->all_versions.fw_ver->phy_version[5],
> +		    cc->all_versions.fw_ver->phy_version[4],
> +		    cc->all_versions.fw_ver->phy_version[3],
> +		    cc->all_versions.fw_ver->phy_version[2],
> +		    cc->all_versions.fw_ver->phy_version[1],
> +		    cc->all_versions.fw_ver->phy_version[0]);
> +
> +	cc->all_versions.driver_ver = DRV_VERSION;

Drop

> +
> +	return 0;
> +}
> +
> +static void cc33xx_nvs_cb(const struct firmware *fw, void *context)
> +{
> +	struct cc33xx *cc = context;
> +	struct platform_device *pdev = cc->pdev;
> +	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
> +
> +	int ret;
> +
> +	if (fw) {
> +		cc->nvs_mac_addr = kmemdup(fw->data, fw->size, GFP_KERNEL);
> +		if (!cc->nvs_mac_addr) {
> +			cc33xx_error("Could not allocate nvs data");
> +			goto out;
> +		}
> +		cc->nvs_mac_addr_len = fw->size;
> +	} else if (pdev_data->family->nvs_name) {
> +		cc33xx_debug(DEBUG_BOOT, "Could not get nvs file %s",
> +			     pdev_data->family->nvs_name);
> +		cc->nvs_mac_addr = NULL;
> +		cc->nvs_mac_addr_len = 0;
> +	} else {
> +		cc->nvs_mac_addr = NULL;
> +		cc->nvs_mac_addr_len = 0;
> +	}
> +
> +	ret = cc33xx_setup(cc);
> +	if (ret < 0)
> +		goto out_free_nvs;
> +
> +	BUILD_BUG_ON(CC33XX_NUM_TX_DESCRIPTORS > CC33XX_MAX_TX_DESCRIPTORS);
> +
> +	/* adjust some runtime configuration parameters */
> +	cc33xx_adjust_conf(cc);
> +
> +	cc->if_ops = pdev_data->if_ops;
> +	cc->if_ops->set_irq_handler(cc->dev, irq_wrapper);
> +
> +	cc33xx_power_off(cc);
> +
> +	setup_wake_irq(cc);
> +
> +	ret = cc33xx_init_fw(cc);
> +	if (ret < 0) {
> +		cc33xx_error("FW download failed");
> +		cc33xx_power_off(cc);
> +		goto out_irq;
> +	}
> +
> +	ret = cc33xx_identify_chip(cc);
> +	if (ret < 0)
> +		goto out_irq;
> +
> +	ret = read_version_info(cc);
> +	if (ret < 0)
> +		goto out_irq;
> +
> +	ret = cc33xx_init_ieee80211(cc);
> +	if (ret)
> +		goto out_irq;
> +
> +	ret = cc33xx_register_hw(cc);
> +	if (ret)
> +		goto out_irq;
> +
> +	cc->initialized = true;
> +	cc33xx_notice("loaded");

?!?!?

> +	goto out;
> +
> +out_irq:
> +	if (cc->wakeirq >= 0)
> +		dev_pm_clear_wake_irq(cc->dev);
> +	device_init_wakeup(cc->dev, false);
> +
> +out_free_nvs:
> +	kfree(cc->nvs_mac_addr);
> +
> +out:
> +	release_firmware(fw);
> +	complete_all(&cc->nvs_loading_complete);
> +	cc33xx_debug(DEBUG_CC33xx, "%s complete", __func__);

NAK, drop. This applies everywhere.


> +}
> +
> +static int cc33xx_remove(struct platform_device *pdev)

Why remove callback is before probe? Please follow standard driver
convention. This goes immediately after probe.

> +{
> +	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
> +	struct cc33xx *cc = platform_get_drvdata(pdev);
> +
> +	set_bit(CC33XX_FLAG_DRIVER_REMOVED, &cc->flags);

?!?!

Your code is seriously buggy if you depend on setting bit in remove
callback.

> +
> +	cc->dev->driver->pm = NULL;
> +
> +	if (pdev_data->family && pdev_data->family->nvs_name)
> +		wait_for_completion(&cc->nvs_loading_complete);
> +
> +	if (!cc->initialized)
> +		goto out;
> +
> +	if (cc->wakeirq >= 0) {
> +		dev_pm_clear_wake_irq(cc->dev);
> +		cc->wakeirq = -ENODEV;
> +	}
> +
> +	device_init_wakeup(cc->dev, false);
> +	cc33xx_unregister_hw(cc);
> +	cc33xx_turn_off(cc);
> +
> +out:
> +	cc33xx_free_hw(cc);
> +	return 0;
> +}
> +


> +
> +static int cc33xx_probe(struct platform_device *pdev)
> +{
> +	struct cc33xx *cc;
> +	struct ieee80211_hw *hw;
> +	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
> +	const char *nvs_name;
> +	int ret;
> +
> +	cc33xx_debug(DEBUG_CC33xx, "Wireless Driver Version %s", DRV_VERSION);

Drop

> +
> +	if (!pdev_data) {
> +		cc33xx_error("can't access platform data");

Do not use your own print code. Use standard dev_() calls. This applies
*everywhere*.

> +		return -EINVAL;
> +	}
> +
> +	hw = cc33xx_alloc_hw(CC33XX_AGGR_BUFFER_SIZE);
> +	if (IS_ERR(hw)) {
> +		cc33xx_error("can't allocate hw");

Heh? Since when do we print memory allocation failures? Since when
memory allocation returns ERR ptr?


> +		ret = PTR_ERR(hw);
> +		goto out;
> +	}
> +	cc = hw->priv;
> +	cc->dev = &pdev->dev;
> +	cc->pdev = pdev;
> +	platform_set_drvdata(pdev, cc);
> +
> +	if (pdev_data->family && pdev_data->family->nvs_name) {
> +		nvs_name = pdev_data->family->nvs_name;
> +		ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +					      nvs_name, &pdev->dev, GFP_KERNEL,
> +					      cc, cc33xx_nvs_cb);
> +		if (ret < 0) {
> +			cc33xx_error("request_firmware_nowait failed for %s: %d",
> +				     nvs_name, ret);
> +			complete_all(&cc->nvs_loading_complete);
> +		}
> +	} else {
> +		cc33xx_nvs_cb(NULL, cc);
> +		cc33xx_error("Invalid platform data entry");
> +		ret = -EINVAL;
> +	}
> +
> +	cc33xx_debug(DEBUG_CC33xx, "WLAN CC33xx platform device probe done");

Drop, tracing/sysfs gices you this. Do not print simple
success/entry/exit messages.

> +	return ret;
> +
> +out:
> +	return ret;
> +}
> +
> +static const struct platform_device_id cc33xx_id_table[] = {
> +	{ "cc33xx", 0 },
> +	{  } /* Terminating Entry */

Drop comment. Obvious.

> +};
> +MODULE_DEVICE_TABLE(platform, cc33xx_id_table);
> +
> +static struct platform_driver cc33xx_driver = {
> +	.probe		= cc33xx_probe,
> +	.remove		= cc33xx_remove,
> +	.id_table	= cc33xx_id_table,
> +	.driver = {
> +		.name	= "cc33xx_driver",
> +	}
> +};
> +
> +u32 cc33xx_debug_level = DEBUG_NO_DATAPATH;

Why this is global? Why u32? Why global variable is defined at the end
of the file?!?!

> +
> +module_platform_driver(cc33xx_driver);
> +
> +module_param_named(debug_level, cc33xx_debug_level, uint, 0600);
> +MODULE_PARM_DESC(debug_level, "cc33xx debugging level");
> +
> +MODULE_PARM_DESC(secure_boot_enable, "Enables secure boot and FW downlaod");

Eh? why secure boot is module param?

> +
> +module_param_named(fwlog, fwlog_param, charp, 0);
> +MODULE_PARM_DESC(fwlog, "FW logger options: continuous, dbgpins or disable");
> +
> +module_param(no_recovery, int, 0600);
> +MODULE_PARM_DESC(no_recovery, "Prevent HW recovery. FW will remain stuck.");
> +
> +module_param_named(ht_mode, ht_mode_param, charp, 0400);
> +MODULE_PARM_DESC(ht_mode, "Force HT mode: wide or siso20");

Does not look like suitable for module params.

> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Texas Instruments CC33xx WLAN driver");
> +MODULE_AUTHOR("Michael Nemanov <michael.nemanov@ti.com>");
> +MODULE_AUTHOR("Sabeeh Khan <sabeeh-khan@ti.com>");
> +
> +MODULE_VERSION(DRV_VERSION);

Drop.

Perform internal review first. This is really not ready.


Best regards,
Krzysztof


