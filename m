Return-Path: <linux-wireless+bounces-8310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8118D4B10
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 13:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1445E1F22C8F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0017D370;
	Thu, 30 May 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BKTBEtfG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA017C7A3;
	Thu, 30 May 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070084; cv=none; b=pp1OfIeSmdHLcDwMrUJ7ZRR0u3aAGHIy4Kii6eXCSKp8HNpLRcaLhqjOGii0R6hfMXdJRmb6dsfs9nDwv6/3deP+myJ7FFMOhAByLqd+tgddldVXQcRodPxvWJibQQdsYAIhYCn5gFbmQLPAfkn4mYiXdUdnV9YqEBUv9+Y81wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070084; c=relaxed/simple;
	bh=VJ8ehQgUMcvMrXpCfTU6zLOyWgGUXJrd0gzuRb7KicE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=a8jkm5B8j5FssaqUkTzbWjoGSvt93dlS9r+KKJOUHtM6lY341uTEbhW0Juu5wouHrBSF6VD4vb45B4AeC5Pn1+i6VtyyeeL1ZXbcU1d0d7ISIe5nxOPZyFvzOGxSgTMA4eqEc7LJs81rz98bIEUGUVyRswxRsERUhA+D3kybuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BKTBEtfG; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44UBsSqU088153;
	Thu, 30 May 2024 06:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717070068;
	bh=jKP8XkjZeu2NWJ+EB4DTOArTnnI3l4BiNSQmPohAi9c=;
	h=Date:From:Subject:To:CC:References:In-Reply-To;
	b=BKTBEtfGZwzM9oJTCMheKuX68XWlqWkeS0B7w/YHcXQwSl7D1TwreeHKdCob4DXGW
	 cngo6+RXGEZTi8I4WRKLOT6gZ+e9TtOT1F4SODkync0H49OqMJ/UUNCMOnScNRz4Br
	 42BlaBmbQzMvdgcWw37iOMTa6vUBiFBOT+CfEDA4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44UBsS33003356
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 06:54:28 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 06:54:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 06:54:28 -0500
Received: from [137.167.6.219] (lt5cg1094w5k.dhcp.ti.com [137.167.6.219])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44UBsQZD068565;
	Thu, 30 May 2024 06:54:26 -0500
Message-ID: <456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
Date: Thu, 30 May 2024 14:54:26 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Nemanov, Michael" <michael.nemanov@ti.com>
Subject: Re: [PATCH 08/17] Add main.c
To: Krzysztof Kozlowski <krzk@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-9-michael.nemanov@ti.com>
 <cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
Content-Language: en-US
In-Reply-To: <cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/22/2024 12:46 PM, Krzysztof Kozlowski wrote:
> ... > +} > + > +static int read_version_info(struct cc33xx *cc) > +{ > 
> + int ret; > + > + cc33xx_info("Wireless driver version %s", 
> DRV_VERSION); Drop > + > + ret = cc33xx_acx_init_get_fw_versions(cc); 
> > + if (ret < 0) { > + cc33xx_error("Get FW version FAILED!"); > + 
> return ret; > + } > + > + cc33xx_info("Wireless firmware version 
> %u.%u.%u.%u", > + cc->all_versions.fw_ver->major_version, > + 
> cc->all_versions.fw_ver->minor_version, > + 
> cc->all_versions.fw_ver->api_version, > + 
> cc->all_versions.fw_ver->build_version); > + > + cc33xx_info("Wireless 
> PHY version %u.%u.%u.%u.%u.%u", > + 
> cc->all_versions.fw_ver->phy_version[5], > + 
> cc->all_versions.fw_ver->phy_version[4], > + 
> cc->all_versions.fw_ver->phy_version[3], > + 
> cc->all_versions.fw_ver->phy_version[2], > + 
> cc->all_versions.fw_ver->phy_version[1], > + 
> cc->all_versions.fw_ver->phy_version[0]); > + > + 
> cc->all_versions.driver_ver = DRV_VERSION; Drop
You mean drop the trace? Will exposing FW/PHY versions via debugfs be OK?
> > +} > + > +static int cc33xx_remove(struct platform_device *pdev) Why 
> remove callback is before probe? Please follow standard driver 
> convention. This goes immediately after probe.
Will fix

[...]
> > +{ > + struct cc33xx_platdev_data *pdev_data = 
> dev_get_platdata(&pdev->dev); > + struct cc33xx *cc = 
> platform_get_drvdata(pdev); > + > + 
> set_bit(CC33XX_FLAG_DRIVER_REMOVED, &cc->flags); ?!?! Your code is 
> seriously buggy if you depend on setting bit in remove callback.
If removal of the CC33xx driver was caused by the removal of its parent 
SDIO device then all I/O operations will fail as SDIO transport is no 
longer available. This will eventually trigger the recovery mechanism 
which in this case is futile. If this flag is set, no recovery is attempted.

[...]
> > + return -EINVAL; > + } > + > + hw = 
> cc33xx_alloc_hw(CC33XX_AGGR_BUFFER_SIZE); > + if (IS_ERR(hw)) { > + 
> cc33xx_error("can't allocate hw"); Heh? Since when do we print memory 
> allocation failures? Since when memory allocation returns ERR ptr?
Will fix
> > +}; > +MODULE_DEVICE_TABLE(platform, cc33xx_id_table); > + > +static 
> struct platform_driver cc33xx_driver = { > + .probe = cc33xx_probe, > 
> + .remove = cc33xx_remove, > + .id_table = cc33xx_id_table, > + 
> .driver = { > + .name = "cc33xx_driver", > + } > +}; > + > +u32 
> cc33xx_debug_level = DEBUG_NO_DATAPATH; Why this is global? Why u32? 
> Why global variable is defined at the end of the file?!?!
cc33xx_debug_level together with cc33xx_debug/info/error() macros is how 
all traces were done in drivers/net/wireless/ti/wlcore/ (originally was 
wl1271_debug/info etc.) It enables / disables traces without rebuilding 
or even reloading which is very helpful for remote support. These macros 
map to dynamic_pr_debug / pr_debug. I saw similar wrappers in other 
wireless drivers (ath12k). This is also why there are plenty of 
cc33xx_debug() all over the code, most are silent by default.
> > +
> > +module_platform_driver(cc33xx_driver);
> > +
> > +module_param_named(debug_level, cc33xx_debug_level, uint, 0600);
> > +MODULE_PARM_DESC(debug_level, "cc33xx debugging level");
> > +
> > +MODULE_PARM_DESC(secure_boot_enable, "Enables secure boot and FW downlaod");
>
> Eh? why secure boot is module param?
>
> > +
> > +module_param_named(fwlog, fwlog_param, charp, 0);
> > +MODULE_PARM_DESC(fwlog, "FW logger options: continuous, dbgpins or disable");
> > +
> > +module_param(no_recovery, int, 0600);
> > +MODULE_PARM_DESC(no_recovery, "Prevent HW recovery. FW will remain stuck.");
> > +
> > +module_param_named(ht_mode, ht_mode_param, charp, 0400);
> > +MODULE_PARM_DESC(ht_mode, "Force HT mode: wide or siso20");
>
> Does not look like suitable for module params.
Was useful during development but can be removed
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Texas Instruments CC33xx WLAN driver");
> > +MODULE_AUTHOR("Michael Nemanov <michael.nemanov@ti.com>");
> > +MODULE_AUTHOR("Sabeeh Khan <sabeeh-khan@ti.com>");
> > +
> > +MODULE_VERSION(DRV_VERSION);
>
> Drop.
I saw other drivers use this, is it no longer allowed?

Michael.

