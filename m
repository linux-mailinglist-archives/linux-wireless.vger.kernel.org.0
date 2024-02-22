Return-Path: <linux-wireless+bounces-3930-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A632385FBFB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 16:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61527289447
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349FC14C5A3;
	Thu, 22 Feb 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeZNiHxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7D14AD2C
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614719; cv=none; b=VJRfm51uK5/VaS1+UxuGboRh2At04bmheqIfOiiOiNq47s6jqhU4hxlr2DhPhePFU/4E56QmoXy5gauctQ97FcM2e0pNoRJLzN+OUND5TEj4aerzUcibgnI6nUbg7cjw85FWpsU73AHwG0qEcRtC8IcO/0WykWGbLJSe7IbHsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614719; c=relaxed/simple;
	bh=2nHeGSw/Y0bu/0rFODKaGA3bo8+cj6tJuf8IA1hGEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4rn9avlNQbcC3ygOPvhkg8OfmnybUfw89cRRcBw6/+v4JWAsJhbJia/6hsNS1NlxxzFS4Jt0ibDBbuk3Jh5fo+KoffFRI54xc8+3teD+hN1uZi2CjumtdovuJtPrc6mNb8Pp/b0VS1OGG16qt8foAYdWRrT8dWHvluRHEjDBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeZNiHxt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4128d787765so3181855e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614714; x=1709219514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZdeavs8ARZ4Wp8jVIIq5rYX8CQepVWYtNx7IdtKagA=;
        b=VeZNiHxtvtZwKy/iwYUtH6ubigGXm4t/ZNRSfgRtK3OZMuYCQwPvzTbMuIUamhdduY
         N+nOlR4+VsstAAJUxg6kRM/BQ9a19WZ95EAgO9xbOY6XXCc38dEUEEMQ1sHsYudUCYcz
         sOaXg57w0KMBZr3tuM457coSnaQnP+c08o8KaXdxir0eLieYLRAQBbyFJMzx6PQAFqlk
         X2Ng/f9JJR0MtXqLKzWLbECZBCpCyOtnWlYGiR0/3jb9KgkuxFSxlWdOEkBrv41yvNca
         DbNDZmuODTjp6NcpMj8U2MDsNr/sdN0eDbBHaqJwKRoH2+u2CReT5YdSy8Z2NYw9p262
         VxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614714; x=1709219514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZdeavs8ARZ4Wp8jVIIq5rYX8CQepVWYtNx7IdtKagA=;
        b=E7ArJmeuIfl8oYruD9iYyoh5FN/ylmbBPsyQVnksPA1vdGprPdFSVLl1DCzKuwIeJH
         9y9HYbUoXKXuz958qurYMD1xaX5w+wDtV5mgaumv9ybZ3CxevE6OT3dbpSGehXC8++0t
         PVj1/4afBUL+/0bwgDTkOr6q/fDXcxcn6jobAvNJ32nvlJ9NNeiELA2gjDm2dUlw5tg9
         zzGqLBBNpkby16dX0Z4MfNHK9IUpwfjPxSqCXMz7i/+qj30uNVowhztrC8oS65QLumFw
         KtKvjYu/0ZYX7fgtOF8IY3fpRky3UALAAbjr/PW0iPTHLDBXVfl0X4H/HVrfqICfUedB
         HYAg==
X-Forwarded-Encrypted: i=1; AJvYcCWRT941KiZeXdcKtT8LKrWeeRL/6wPnXFrNsFmvpOfHVRu+nFl8Tri53DvMfn8SUfxefTfxKgBAjEck5CwRvsPxPSAHJuI+8M1kGAYF5E0=
X-Gm-Message-State: AOJu0YwZcPHid77+Y8n3NBjpFxI0REHQujyn19JjOh6ZK7C9X2++iwSL
	6xw7cp3so0t4KVcxzYUS/Ezs1dkCuE3sQ8Qx/ANlOdvHRjJQ+b8C/HIlh5ekP4Q=
X-Google-Smtp-Source: AGHT+IH5VhU9UCTY6WCZTJEB3gZr9zWbimtj+EBEQnbqM+B6oMV2+MqMrPueMl04ish8T7F7PfrFzw==
X-Received: by 2002:a05:600c:190f:b0:412:8560:1baf with SMTP id j15-20020a05600c190f00b0041285601bafmr1129700wmq.26.1708614714030;
        Thu, 22 Feb 2024 07:11:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600c4e0f00b004128f41a13fsm369363wmq.38.2024.02.22.07.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:11:53 -0800 (PST)
Message-ID: <e0a65f94-73b8-4a27-87d8-8fa3d8e88e7c@linaro.org>
Date: Thu, 22 Feb 2024 16:11:52 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] thermal: intel: Set THERMAL_TRIP_FLAG_RW_TEMP
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
References: <6017196.lOV4Wx5bFT@kreacher> <3281804.44csPzL39Z@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3281804.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:34, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some Intel thermal drivers need/want the temperature of their trip
> points to be set by user space via sysfs and so they pass nonzero
> writable trip masks during thermal zone registration for this purpose.
> 
> It is now possible to achieve the same result by setting the
> THERMAL_TRIP_FLAG_RW_TEMP trip flag directly, so modify the drivers
> in question to do that instead of using a nonzero writable trips mask.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I've reviewed the changes. Some changes in the DTS are opaque for me, so 
I can not give my reviewed-by tag but the acked-by


Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


