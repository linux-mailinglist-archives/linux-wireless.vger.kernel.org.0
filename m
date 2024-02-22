Return-Path: <linux-wireless+bounces-3934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20F85FC77
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E3E284B67
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4C14E2DB;
	Thu, 22 Feb 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZNREsMZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099C14F9EF
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616023; cv=none; b=ggyLXsdg5/CaEhevYoY6uwjvcB+xe9YSksEF88zhKkOxRmaO6oZElOERQCoomlbHzB1Qc/IQiSE2y1TqeFdvajqHZF3BZsNinitne0T7kBPsf9u9DhewQ1JYxaJX9lrs9sFc0LWJJj/Tb/NvXHvolskKn/e+JyBsxJ640299oFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616023; c=relaxed/simple;
	bh=oK1amVuCox27CRvUtnAUQD4LEuZhjZZ7ofBpfkgNkaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz6fkI3udTMC+mwl3FwCrKveCc9a6Dc2TffyG0f2VQeHoF5FxyjDlrzb+suhAXrQkOKNrgICbmHu/ndh9PmqZLsrrLohiXGu91dKiZECU6glkRREyPMzAsCdCOHqL5WtTjRoWQxoS/BrAdB99tIP1UjJ/NMv7uw8hlxGS8L0tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZNREsMZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563c2b2bddbso11502809a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616006; x=1709220806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtcvbi0VWL42LwVToPMJNo4Anu/JDy4cWWHbbORlvFk=;
        b=MZNREsMZYA1dUuuJXcwdIGhVNu3HLUQ+vCC1o0gjEtzieQauTeaSnI5S+AFvQU2QxK
         +o97s/hm1hFhh0WUFtpjAtqsro1AXzkVRE4zCO/BphVihk1xm+QZIAdl4yREQlowbTK/
         zOgWdbwVHIHFLlfQXUbO3C8MgMYIPm0eU3fx3f5NKWSl7VB4QPWoEmWSNJproyGYbCRj
         owZEUIdJZTGyJ1sK8ga2CLabA4UZ9caZouCa0HrK7MvvKLmI1yhm0XvzHxZ1Eq8Ss/3l
         Nfb4XM/r7xLImjs0y4liYdbemEs2ftD0/BjEAjF9VGIIO56Jar02IzDTpE+1Y/0TpAkd
         ReSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616006; x=1709220806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtcvbi0VWL42LwVToPMJNo4Anu/JDy4cWWHbbORlvFk=;
        b=Hlp9GmTsUA3PJqS+SEGmeP5xkLUVjV6ZE284nNmSwLiy3YZ6bfDoftlCK8A0VktB+0
         OC5AUJzihwBXThOi+xJrsh6pRLaKMgtuY4gIPiMh0N5BunT2NGeFCdo1rGhPg+qk5VPb
         +7/y2bylLahoZoIA2hKlDrNzwuDlW9hIoGeAw3f6FTzA3ZhjoBHzabQ7Z6ssiW2tet0o
         auqiW3vv7cSgAXyx6hbMgJxioQl5K9pgSx8mpdHBXYNhpVS4CDJhL594hjRft6mA4Kdk
         sQRfm2CDJi3yOpzJ1jY3gWZ99yOt2wNIYDJutXh60ei0//tz5KqsbxwpkUbGaRp6PHDJ
         52vw==
X-Forwarded-Encrypted: i=1; AJvYcCX1RmHxZDYsF+tBR4YPhBu+6raMoNjfM7f7AHhxXC7XJA4nNVGukT9GgeiBjm8si6+QQdMCVpmr0rYdR43Wfu1CvG6EZdLIOifbnzxFdZc=
X-Gm-Message-State: AOJu0YwGWKd1EySoccmCTOTn9vdbCKpsQ64tm9W62U9PhvT0peFcKwdW
	csA+7qvvdBIsQzNiU/b0w1Igm861rav2VPk3+g8xnaFC0VCo/TIdUt0NdEGnOJHJ5GLILDqNUL9
	U
X-Google-Smtp-Source: AGHT+IHyJpAfcsOcSg7wL7lE6r7Z24xHwfv17RJU0PRSdSw7isnIXMwanFuLtLcaJs949t6M0RUnYg==
X-Received: by 2002:a7b:c4c8:0:b0:411:fe7d:ac4 with SMTP id g8-20020a7bc4c8000000b00411fe7d0ac4mr15711697wmk.24.1708615986587;
        Thu, 22 Feb 2024 07:33:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ka7-20020a05600c584700b004101543e843sm6434548wmb.10.2024.02.22.07.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:33:06 -0800 (PST)
Message-ID: <3e282706-2025-45d7-a2df-1c07f98ce10d@linaro.org>
Date: Thu, 22 Feb 2024 16:33:05 +0100
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


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


