Return-Path: <linux-wireless+bounces-3932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F685FC16
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 16:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156701C2446F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DFA14C5AB;
	Thu, 22 Feb 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExBYgegH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64214A088
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614866; cv=none; b=nii2pdxdOznl6hiAAx1Lu9aHOIg4AbSvgnVpd0jBdy0ClRyeyYr7ktQYrxVsBiSYR9Hx1FFZtDtMmBTqVMG164IhUxo8G6GsfSsY2dhInwC5oi49QKm1b8eoeo7Yvncmz6gyKOSjqrzli5bCX3YVhnizKdOD/eKdccW2VezXKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614866; c=relaxed/simple;
	bh=z+bQGd7lhGlkzLgCY3Y5LXLX7JDxsGgeC5rd3on7E+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itIpaK7p5Bcs/EsIQHH334gmrxb5FWSFLIE+5aas70f/IPKlctA0dp5HwEyNepnBwKeX9i/JGYK2VbogYpH69Fc/MtaSvj2njrNivtvovK0KNkf62XOtuBD97aY+x84ui8Q5g4X0r1EQdzN/d13mVmBeOiX2f8voQBu69xj9hPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ExBYgegH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so5336489e87.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614862; x=1709219662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KL+GhFhNxZpNqbae1gTMvkBtFm+kvUgZPPGnCJLq3wY=;
        b=ExBYgegHxYBVycJNANFXVvtYslt9xSIgOzeUeNeO+01GpPaIO61pLNNnHdGtVDTLBb
         v5mX69n3a+IX6UlX4FQMxIm6Fgynlk2xEPXrFkweac482TmlGc4rhLdha1yNoW9kFvJY
         Eu+Q7my13k0sy04i7OPFyQKB2irxFKmpauXe8IxpS7m3XaeRuB3HHIgSedhGLf8DfK/2
         K+R7Y+oVteOpavBSoPVZJ31S0INZ6b4gr5JOGDXzck6nJQja8AaXOxZkpDvprx91bmLD
         FdN5QphrOD7p0dBqfAT0zVIF/kxK4Dz2wOD251EyftQSNBxudxu7mbv3fl9lz09YiMzB
         Ix7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614862; x=1709219662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KL+GhFhNxZpNqbae1gTMvkBtFm+kvUgZPPGnCJLq3wY=;
        b=CioofTAIrKEDfAQRk/H7VyrOih9Gtvudw6t4MvDY9Z3ZlS8qw9EJwnF/YAhvQj68fm
         q2t3GXmEeRoDrFFU5UDfsgejTXMJetm7ZphpqMJv0OL7vcGBJUPNP5CegdPSirK5ec7b
         gsqSwSjYfTY6ghYOaHsSTzUYclI3KaAHX7iKXjrfxFqK9snBuUX6+XF2bENHqT1GQK/6
         8T2sm9t6QyjyrJZJVGTpJ+ls+Z/oSoX7Q1nh2skQGJ/cH7EBvcDEXIwfMQskG0Z65ymo
         EHNuzhbMZBbKxh435OUZEC217BH+PSpFBjHWlJwQugee65jttAUEnp6SdsKUwyff9FQe
         p+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCULst9OB9jx31e1U0VH8EHyiqjSW6sSkWvQIdKoJlmauDqzdXPaHlE2iiRvsovT1aiYes0KSVpMzxbK2oGToIeH8j4aMdnkrH8+Jo9xOsY=
X-Gm-Message-State: AOJu0YxRTrxsR8amoOhmGm4rP+p15pgN5JeOpurbhWBAOLyjOnQ+hg6r
	SyVfSv7h7Hat6cT1UZ3cuyFL7a4LmRYThT8Ag5Xw3ao/LdvIOIQY2Zbp0Drmyig=
X-Google-Smtp-Source: AGHT+IGroMpZ9APx0YPMGdzMTuMhRTHXabT2Ty9HFlZwTbS0D3CzycMuGExnkKnYQ/qNfMPrHCtg7A==
X-Received: by 2002:a05:6512:20c9:b0:512:be5b:30aa with SMTP id u9-20020a05651220c900b00512be5b30aamr6004695lfr.49.1708614861787;
        Thu, 22 Feb 2024 07:14:21 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600c4e0f00b004128f41a13fsm369363wmq.38.2024.02.22.07.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:14:21 -0800 (PST)
Message-ID: <9845d5b0-9f79-458e-96f6-51eafcd59223@linaro.org>
Date: Thu, 22 Feb 2024 16:14:20 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] wifi: iwlwifi: mvm: Set THERMAL_TRIP_FLAG_RW_TEMP
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
References: <6017196.lOV4Wx5bFT@kreacher> <22182690.EfDdHjke4D@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <22182690.EfDdHjke4D@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the iwlwifi code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


