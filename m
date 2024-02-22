Return-Path: <linux-wireless+bounces-3924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A282785FA3A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F551F21DBC
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD891353EA;
	Thu, 22 Feb 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeaMut06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6858ADF
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609725; cv=none; b=Fz76DwoKU9PIeF2puB9mcUMnf5VyLOMxgK3NSjDjGxS9DmWIPvKujNypjmqYQOgvO9xUjotA5TmaaG1yGssRwwe+clVp5vC7EsdYndLdF746/DtyUoZPxNs2JYsdcSRHbCgJsVSbhzw+cVy54pV8ZknLLcSExA+u/vGprfL2SvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609725; c=relaxed/simple;
	bh=Y6TgWPLINj7D8BQDnroVZ+T+LDIQasr9m7F1MIYp16M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=an4dwLsIA39kf3tiBTWnWXd/KQWU4l9M9sDjskUSFWx+Yu3+Ux8HM2TUPyIBL26uTOtVR5Fezh33wBb3kUvtqkbLdXg/GGWNi1hEgslEZVhrcwU54R4nv1PhS/WcRqGwmKehSnN9ofv00hL+8oX0bkqXWPiIw4LxUEDPIyJ9PeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GeaMut06; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d26227d508so6669541fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 05:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708609721; x=1709214521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq7QWWU9M0E6N32mIV1CNOQHREQMEJTHwJ9hCgn89sY=;
        b=GeaMut06EpulYKeYJGsgRzXEwy8m+UnEuuuVN6iqS+mRzO/0xc2a2Bd+g0ntcSKrAr
         LK0dNww7n6tju7qUAACQFD35tV4tq5Z33TRLdu5FbaBPIaTvi5ZUvXj31pG9zqEpzquA
         M2t8vWVqygvHLY0sWpx37RRzFDDTQcVi/pE77ZhQFGouYBx6mSKGj4zwSiMQofsI/glf
         Dqog2cgVDnwa8F3EMqpct3WPt/HR+MesTfitn/2U3DJuoHSjW0p5osDZ6r+zg9XmmbFY
         obyL22y/VarX7o2ko3RfPoaIeUcyTDdRZv9vW82gS29gyswxRLCZzTgYmIV0mqDp2DfU
         8qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708609721; x=1709214521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq7QWWU9M0E6N32mIV1CNOQHREQMEJTHwJ9hCgn89sY=;
        b=ZBVfFx6P+Pn7vP/WNOyAr7uyWFON7AML0Acz7RykbQgJtvCJcrbZZrnQOX0C202v5H
         ZywvuDRgZoRc0URlr7pn05jML64jJNzURwOTe36kvMzjira6gMk4NxIvqt6XT43MRPOF
         1JCoGiqN/KBnAJ0bOie77PFQ8DU3AZr1oavYgCH7NIuIoFva+vTpv4bgejtkdF+QzY6k
         B6uj9MzFS7fyMlmXBXfiWbAHPFaes1WDRat99CCdVbW8jWh3UOC74zjqPURuZJCPNFz+
         a1cfV+lEMCyDehtxowGTx7ABXgH9eaWXjcTOSoao6Q04BRPGppQtRvVxtmJ1gWWi4d2u
         O5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVUkhuRPzLn2VBvIiOxM41Ujl+Zpv7e6V8dRUS45disDxIYO6Mo//yDOB8nSE1809Zdl7R4B+EePfnlIt3nSyR4qzvzBtGtNA65icDZHNg=
X-Gm-Message-State: AOJu0YzEDr97X5rUSIqGiz9g+2k7vsRtMyG+V1YmHASmfwS1w9YJ1SR1
	PEAyUtLM9QrtaOuGV6vCHOFMemXqOtO9OEK2BGJlE3ICsxODKG7uX7V8ldA4C0o=
X-Google-Smtp-Source: AGHT+IGsHjVVspiuRlVX6nCp48zMZnkeVdxWm3TMOKdhpk1Hz1OmtL6b+b6z37yUMHEk31Lp4+av4Q==
X-Received: by 2002:a2e:9256:0:b0:2d2:51c9:ef4e with SMTP id v22-20020a2e9256000000b002d251c9ef4emr3575102ljg.11.1708609720807;
        Thu, 22 Feb 2024 05:48:40 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id r11-20020a05600c35cb00b004120537210esm6505491wmq.46.2024.02.22.05.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 05:48:40 -0800 (PST)
Message-ID: <cd710cd4-c723-48e0-80d2-72d9d95f9e0c@linaro.org>
Date: Thu, 22 Feb 2024 14:48:39 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] thermal: of: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <9235101.CDJkKcVGEf@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9235101.CDJkKcVGEf@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:40, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the OF thermal code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Rename trip flag (Stanislaw).
> 
> ---
>   drivers/thermal/thermal_of.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_of.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_of.c
> +++ linux-pm/drivers/thermal/thermal_of.c
> @@ -117,6 +117,8 @@ static int thermal_of_populate_trip(stru
>   		return ret;
>   	}
>   
> +	trip->flags = THERMAL_TRIP_FLAG_RW_TEMP;
> +
>   	return 0;
>   }

Even if you are not at the origin of this default behavior. I'm 
wondering if we should be more protective against changes from userspace 
when the firmware is telling us to protect the silicon at a specific 
temperature.

What do you think if we set the THERMAL_TRIP_FLAG_RW_TEMP only if the 
trip point is not bound to a cooling device?

So trip points without associated cooling device can be writable but 
others can be considered as managed by the kernel and no modifiable.

(This comment does not put in question this patch BTW)

> @@ -477,7 +479,7 @@ static struct thermal_zone_device *therm
>   	struct device_node *np;
>   	const char *action;
>   	int delay, pdelay;
> -	int ntrips, mask;
> +	int ntrips;
>   	int ret;
>   
>   	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> @@ -510,15 +512,13 @@ static struct thermal_zone_device *therm
>   	of_ops->bind = thermal_of_bind;
>   	of_ops->unbind = thermal_of_unbind;
>   
> -	mask = GENMASK_ULL((ntrips) - 1, 0);
> -
>   	ret = of_property_read_string(np, "critical-action", &action);
>   	if (!ret)
>   		if (!of_ops->critical && !strcasecmp(action, "reboot"))
>   			of_ops->critical = thermal_zone_device_critical_reboot;
>   
>   	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
> -						     mask, data, of_ops, &tzp,
> +						     0, data, of_ops, &tzp,
>   						     pdelay, delay);
>   	if (IS_ERR(tz)) {
>   		ret = PTR_ERR(tz);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


