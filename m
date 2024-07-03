Return-Path: <linux-wireless+bounces-9925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B5892601F
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 14:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E876F2857BA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D121741D2;
	Wed,  3 Jul 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEy79cb8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FE85298
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009276; cv=none; b=cCOzuqzl+a8RMlzPJ22ZMAGZJioAmsghEW6DZ/5nbnPgsCyHwNgVlMDmBuNcAjZ1V6V25jrmmGNFSv/RBbXt9/DOh1m+1PL/tNfpzx/sOFoJFMOLShp95Xp4lgMzGxiOUuRzC60oRmZ+fFAYLG9ZyzWHNnmJBq2O4/ogVBVmzrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009276; c=relaxed/simple;
	bh=cubV7PSPhJbJ+Qx4nqp+Dd4OkcCI8xjyljP7mHG1qOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlY6HogA75Oh8EmImy67TE+X6kz6hHJDMOBGeAW7LO4pq1gIC8sDWwHvgSAd3+lgrYo9DSuwODy0eHZ2Z0yLLLk0frvi+fXF04G/DQzuwUMS4s+PUXwRjGsrt4LvHeE9xIOnCk1yLn2pzBWe5sGbNcdgNiBweoJZqxatvEFSfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEy79cb8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdea1387eso5842932e87.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 05:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720009273; x=1720614073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+m8M3n1qsYckd6mSAf4YNSgVy1Uh2copyKJHcyhOiQ4=;
        b=hEy79cb8yCJ8LpfHgReutG402o3o3xLWz7STVx0R/B3rn65FjszZrjBQxYYH3MrhTE
         DQhYL/cXr7YJ6HOicYRPOEu1X7fR3qYTDxEMWg/Er2X2Ob59fqs24HQiHNBLyP/rnjPt
         l0kCQk9Rl2UtTp4wn4/AAoJNth0A1gayb2k8W7JhFus7uoivwhOMaaeF2J3m2b4R58NY
         rnWDwkUxkWij2fN4xabWLO8ff5qLOMZEvDFlir+T4A4DtlVFvkEslEvumD9Vljre0s3i
         yJeDMj9yfHLdbcXSB0KzPGUKBGOpc8hCHTz0hqwZB6yKnS5q64Ib4Y6DXZnwemvHgNgZ
         rX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720009273; x=1720614073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m8M3n1qsYckd6mSAf4YNSgVy1Uh2copyKJHcyhOiQ4=;
        b=FelFk+6FlE6MayH/0RflymZ1/3SIZ0F/a7Romn/WhiNL+0LmhNtBtQDGdh9bXC5hFc
         JHEPJjatCZbpdmHKqf9M+R+hUzgh9u5eGWBT+Wz6Fx33gmIhC2Zs2ho3xb+FqtISp0pt
         jIw8ilBiV0tIsYRitpQ1MBRr3trukftf5pNnh0jJKcW4f3Ks9BIr1i53GgyivyUIJxph
         0N9vO0hXmSDwBz8GuCLxzLodXB6edEa67X7aUn9Tl202+PmcY8Js979k16EVuPBBfDix
         fonjtN3qvuvoc1hXw+Bjvg5JAmzUf9qtpDkAvLZEwQGjzyRdA4BldEKtcc2Y+RHepH5C
         iLpA==
X-Forwarded-Encrypted: i=1; AJvYcCVtq+Ox97GYe29QWe8kgXySLQpFlYmkp0NyQxUtkzhPJQY+suJb6hI4fzROVORa+ZCebkKOjytDtJoSQZ53fnM4RoANAj/RcpJUAPf/Wyw=
X-Gm-Message-State: AOJu0Yx77x4jePqZWJmZaWv+O9LfqHXJ2n6qrziVZYtDuQp0V6bRojmJ
	/mDviTzTvqlcKn3fJwcvGd4qLm7+YJ0zmDmcIH1//lMq+OOrMhqbeunB8crA8D8=
X-Google-Smtp-Source: AGHT+IGoCrWnpI4H3vkYZIW4U5GwbaIxS3AV0bKKM6IK+U0+ym4oAlShp5iDrd+SuM0Al6aqGSLjKA==
X-Received: by 2002:a05:6512:3988:b0:52c:f2e0:db23 with SMTP id 2adb3069b0e04-52e826886a0mr8508503e87.40.1720009272232;
        Wed, 03 Jul 2024 05:21:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b0c19eesm243158405e9.45.2024.07.03.05.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:21:11 -0700 (PDT)
Message-ID: <47440afc-1b76-4dff-8c72-427103d7184a@linaro.org>
Date: Wed, 3 Jul 2024 14:21:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 4/5] thermal: imx: Drop critical trip check
 from imx_set_trip_temp()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-wireless@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <1890956.tdWV9SEqCh@rjwysocki.net>
 <2272035.iZASKD2KPV@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2272035.iZASKD2KPV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 16:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the IMX thermal driver does not flag its critical trip as
> writable, imx_set_trip_temp() will never be invoked for it and so the
> critical trip check can be dropped from there.

And as a rule of thumb, we should not allow writing the critical trip 
point temperature in the thermal core code.

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/imx_thermal.c |    9 ---------
>   1 file changed, 9 deletions(-)
> 
> Index: linux-pm/drivers/thermal/imx_thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/imx_thermal.c
> +++ linux-pm/drivers/thermal/imx_thermal.c
> @@ -335,21 +335,12 @@ static int imx_set_trip_temp(struct ther
>   			     int temp)
>   {
>   	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
> -	struct thermal_trip trip;
>   	int ret;
>   
>   	ret = pm_runtime_resume_and_get(data->dev);
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -	if (ret)
> -		return ret;
> -
> -	/* do not allow changing critical threshold */
> -	if (trip.type == THERMAL_TRIP_CRITICAL)
> -		return -EPERM;
> -
>   	/* do not allow passive to be set higher than critical */
>   	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
>   		return -EINVAL;
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


