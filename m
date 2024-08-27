Return-Path: <linux-wireless+bounces-12036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C0960571
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 11:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8771F21CB4
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55E194A4F;
	Tue, 27 Aug 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PrljT6WN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EF76056
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750517; cv=none; b=M3BKGkD7e7TlFgaGh+FMLjAI98y3RgUTiqOy2OtSWFDXgl0VfafBsrs5modZQCxAX1cbQHEiw2/NC2Wtg5wc9L2FIo6tqJfYCqyNUW+olppAgiNnP9Fv0FALkLco4u4nx7Pic+R6NgMd7yPxGEINb4I850NnQDaLGJqybkv5jko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750517; c=relaxed/simple;
	bh=7tROP6I9eEk+ThOmj8CNHT8BOdgjTn8mUIac7/PQDr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4Z6PvKnV+pUEbdvHeiXiE0vzi2DGbPfACHiz4dqC9BfwcPRfneYdZDIiMHQiLyt2h5pafX2GnT739BPOPOWPd/dtjZZVcp0efzHNHemHxmNWmYTjjcsKAm4VqyirPsVhXQqlqysTeuo0R2an063O2pPdwa9uapD5z4Bf3NUiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PrljT6WN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35E671BF20B;
	Tue, 27 Aug 2024 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724750508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHu+trMcrihZwcCu7Gh4cJ7BXtuhTvnzaPlZCAgom18=;
	b=PrljT6WN3LQ6JjFz44PagqnHJrcxHfA2aXJn4Vcwxt5UBEaYknSQlVe/hzqXLYYfU6jdu5
	lpiSu3TWx8N7cF+sGa99GJOtPxbc2AWAKvlC1viCUplhS/nTlmAwmONuyxtM6H/m9lE0Dh
	ig1UBfa9i+u9nGgJBSAK+NxEuOBYFKf0zPaPgctQOwkw46+6y0cF4CTff3mo5yuH8LNxiw
	5FCy5286mAkwpdIWMPqZasTQ2/Zz502cH1p/iu4hs+/H26e+bZ4r6U5e8J75FIwz+l4+Yr
	pinsOigv7g2A9py43RcYS+ycnQ3+fufQb22Dg1B+wseSULH6QJI1KAILwjvkgA==
Message-ID: <60071661-bde4-4203-a54c-73420b14aee3@bootlin.com>
Date: Tue, 27 Aug 2024 11:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Do not operate uninitialized hardware
 during suspend/resume
To: Ajay.Kathat@microchip.com, marex@denx.de, linux-wireless@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev, kvalo@kernel.org
References: <20240821183639.163187-1-marex@denx.de>
 <05ada8d8-d5b5-4b9b-88dd-bdbd9aea65ce@microchip.com>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <05ada8d8-d5b5-4b9b-88dd-bdbd9aea65ce@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/23/24 19:16, Ajay.Kathat@microchip.com wrote:
> Hi Marek,
> 
> On 8/21/24 11:36, Marek Vasut wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> In case the hardware is not initialized, do not operate it during
>> suspend/resume cycle, the hardware is already off so there is no
>> reason to access it.
>>
>> In fact, wilc_sdio_enable_interrupt() in the resume callback does
>> interfere with the same call when initializing the hardware after
>> resume and makes such initialization after resume fail. Fix this
>> by not operating uninitialized hardware during suspend/resume.
> 
> Is this behavior observed then power-save is enabled when interface is not up.
> Ideally registers read/write commands should pass as soon the wilc module is
> up. But anyway, it is good have this check to avoid these commands. if
> possible, please add the similar check for wilc_spi_suspend/resume() to have
> similar behavior.

It looks like there is a hole and that no PM ops are implemented in the upstream
driver on spi side. That may be a miss from me when I sent the power management
series a few months ago. I'll fix that.

So for this change:

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

> 
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> Cc: Kalle Valo <kvalo@kernel.org>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: linux-wireless@vger.kernel.org
>> ---
>>  drivers/net/wireless/microchip/wilc1000/sdio.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> index 0043f7a0fdf97..7999aeb76901f 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> @@ -977,6 +977,9 @@ static int wilc_sdio_suspend(struct device *dev)
>>
>>         dev_info(dev, "sdio suspend\n");
>>
>> +       if (!wilc->initialized)
>> +               return 0;
>> +
>>         if (!IS_ERR(wilc->rtc_clk))
>>                 clk_disable_unprepare(wilc->rtc_clk);
>>
>> @@ -999,6 +1002,10 @@ static int wilc_sdio_resume(struct device *dev)
>>         struct wilc *wilc = sdio_get_drvdata(func);
>>
>>         dev_info(dev, "sdio resume\n");
>> +
>> +       if (!wilc->initialized)
>> +               return 0;
>> +
>>         wilc_sdio_init(wilc, true);
>>         wilc_sdio_enable_interrupt(wilc);
>>
>> --
>> 2.43.0
>>
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


