Return-Path: <linux-wireless+bounces-8346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6B8D637D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6D71F24034
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40FD158DDD;
	Fri, 31 May 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vsuQp3lQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330E156F42;
	Fri, 31 May 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163477; cv=none; b=GHtXDW20meMFEPviJgOdY0cwie+AvC3TKbTScCkFPw8smizfjdf8GSEoOjQ5NwssVmmzg/BBCDQPA6tg5EN6XDxKfYG8q2BqxFxrj6Gj7HIdIEdeb1b6UNtt65oRPV0Pa6OasbvigxrudW/qMy/PzRogsqO367RVbvUQTjeTGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163477; c=relaxed/simple;
	bh=ojwU5tlYa5Wk/yHHQBYytOTm4lgpIEAoyssULEh9GyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J13jtX90LuIOU/MK4YxcZd6iAGw3fPVUzU9KIlYLssyJBRg1RfOyXHi2IXDPQMXXuDAU0Zk6lEbzvvwxFydiZ0Zl5wcQN1o3cPxvKK61SDpG9ohaxEONyfzeOTD0XoSfENbj4vEJxZH9QlU3+rRCH3NeErs2Ut6h9SdA5kZal0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vsuQp3lQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VDop6X123484;
	Fri, 31 May 2024 08:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717163451;
	bh=o+zDO75tO86HoDX2MXWiFPthnI9gn38kT/YliHeiQ5g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vsuQp3lQgtqrZLhoQRz6sBl/XlAL1dVzctCuufa3jjTA5wI0QQHH2RCV+d/Xsr+mL
	 ZA6xo7JmcsO1HB/pM3AzM1RFY7kFTS6zbdwkW5H5fwOde/nIzxPgqj4zkl9LNJJL80
	 XWdS0VohGLJQWRt6IJ2WXl5b2j7womX/CZbKw7vA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VDopnv118148
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 08:50:51 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 08:50:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 08:50:50 -0500
Received: from [10.250.145.232] ([10.250.145.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VDomk3123567;
	Fri, 31 May 2024 08:50:48 -0500
Message-ID: <2e2ec1ba-0c24-4173-af60-ea51004f2e10@ti.com>
Date: Fri, 31 May 2024 16:50:47 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
 <97d8acf9-6cb3-4da7-ad4e-0f2d0a63c172@kernel.org>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <97d8acf9-6cb3-4da7-ad4e-0f2d0a63c172@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/31/2024 10:35 AM, Krzysztof Kozlowski wrote:
 > It's impossible to read your email.
Sorry for messing the formatting, sending again:


On 5/22/2024 12:46 PM, Krzysztof Kozlowski wrote:>
 >> +}
 >> +
 >> +static int cc33xx_remove(struct platform_device *pdev)
 >
 > Why remove callback is before probe? Please follow standard driver
 > convention. This goes immediately after probe.
Will fix


 >> +{
 >> +	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
 >> +	struct cc33xx *cc = platform_get_drvdata(pdev);
 >> +
 >> +	set_bit(CC33XX_FLAG_DRIVER_REMOVED, &cc->flags);
 >
 > ?!?!
 >
 > Your code is seriously buggy if you depend on setting bit in remove
 > callback.
If removal of the CC33xx driver was caused by the removal of its parent 
SDIO device then all I/O operations will fail as SDIO transport is no 
longer available. This will eventually trigger the recovery mechanism 
which in this case is futile. If this flag is set, no recovery is 
attempted.


 >> +		return -EINVAL;
 >> +	}
 >> +
 >> +	hw = cc33xx_alloc_hw(CC33XX_AGGR_BUFFER_SIZE);
 >> +	if (IS_ERR(hw)) {
 >> +		cc33xx_error("can't allocate hw");
 >
 > Heh? Since when do we print memory allocation failures? Since when
 > memory allocation returns ERR ptr?

Will fix.


 >> +};
 >> +MODULE_DEVICE_TABLE(platform, cc33xx_id_table);
 >> +
 >> +static struct platform_driver cc33xx_driver = {
 >> +	.probe		= cc33xx_probe,
 >> +	.remove		= cc33xx_remove,
 >> +	.id_table	= cc33xx_id_table,
 >> +	.driver = {
 >> +		.name	= "cc33xx_driver",
 >> +	}
 >> +};
 >> +
 >> +u32 cc33xx_debug_level = DEBUG_NO_DATAPATH;
 >
 > Why this is global? Why u32? Why global variable is defined at the end
 > of the file?!?!

cc33xx_debug_level together with cc33xx_debug/info/error() macros is how 
all traces were done in drivers/net/wireless/ti/wlcore/ (originally was 
wl1271_debug/info etc.)
It enables / disables traces without rebuilding or even reloading which 
is very helpful for remote support. These macros map to dynamic_pr_debug 
/ pr_debug. I saw similar wrappers in other wireless drivers (ath12k). 
This is also why there are plenty of cc33xx_debug() all over the code, 
most are silent by default.

 >> +
 >> +module_platform_driver(cc33xx_driver);
 >> +
 >> +module_param_named(debug_level, cc33xx_debug_level, uint, 0600);
 >> +MODULE_PARM_DESC(debug_level, "cc33xx debugging level");
 >> +
 >> +MODULE_PARM_DESC(secure_boot_enable, "Enables secure boot and FW 
downlaod");
 >
 > Eh? why secure boot is module param?
 >
 >> +
 >> +module_param_named(fwlog, fwlog_param, charp, 0);
 >> +MODULE_PARM_DESC(fwlog, "FW logger options: continuous, dbgpins or 
disable");
 >> +
 >> +module_param(no_recovery, int, 0600);
 >> +MODULE_PARM_DESC(no_recovery, "Prevent HW recovery. FW will remain 
stuck.");
 >> +
 >> +module_param_named(ht_mode, ht_mode_param, charp, 0400);
 >> +MODULE_PARM_DESC(ht_mode, "Force HT mode: wide or siso20");
 >
 > Does not look like suitable for module params.
Was useful during development, can be removed.


On 5/31/2024 10:35 AM, Krzysztof Kozlowski wrote:
 > Was never allowed. There is only one version: the kernel version. There
 > were many comments already explaining why "driver version" is
 > wrong/meaningless.

OK. HW / FW versions are OK?


Michael.

