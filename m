Return-Path: <linux-wireless+bounces-3931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB3085FC03
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 16:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC3B221C9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7483314A0B3;
	Thu, 22 Feb 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vs1ERfnh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8214A08F
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614814; cv=none; b=SxfvnV0TcIKx2opHqFhsXiOLPUtrFZ51biJF9yiIQLvlomZixf957Zlt6o2gdVuXgSebS9wUX/m4Ryf5oxjtKrlDhGdWKb7hLrFuf6ZoFL4vr6RF4Uy7QkGEYBtgJTFA9QCay0OjvfcE279zxSvanY5018zEVFHJxc8sSFaYGmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614814; c=relaxed/simple;
	bh=GZidnWS47bN5w/RNyjF7xozLnTykcDoh+67IYMboy5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBEIyJiEfiNAWddJPiRhyrQ7Vql8eWGidQJScs/byw5idZgeoTLv1Ip6N+uv0pEjLGCMgT+jWw3rFtkq5Fdz6VwLa7G1jfFLMDcxDdec4BwlHn6O6a3juZ3DmRSNolrWZZNoglQlVahf/tHlPyhMRMMFzPQMMl35UoK7bhW3ieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vs1ERfnh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so1911959f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614811; x=1709219611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDJcfOimbHdFhf6ZpwF6LYw9oBwXpSoe7/s5ojrCCAs=;
        b=Vs1ERfnhkOGrgBZycSJA/OejT1/3kSX836W1CJoVwE+fLdpxbxTpB8zwlZUs6BywMb
         I8xciIyprCP6gXVejX6nP6KRzIYyQLm/aEveoor73dwcMCSGS+tnd24NR+bvHE1qUpeK
         Urj1W4Y1szm+bt9GOAWEpx2nW4WeijpPVyOd/4efVhmCgk2RxbNOrwNuOVzBBArx2QEb
         iVz3skzVDQiivvYVqIOctaMOGLo7dCpF0l6x/ZvpJzOuBcs1AeuU79nb+pyuqzagenZf
         XgsYmY8v9zDjTaSGU9zBHCEtXiZ3hg89qgFBSfwDgEE6wEPxCpDOUF20i7KFenec/AYc
         98Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614811; x=1709219611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HDJcfOimbHdFhf6ZpwF6LYw9oBwXpSoe7/s5ojrCCAs=;
        b=kKtsPGVylQJrRmTBHnBztQ2L87HToRQg36lVtfKN2qug1iwakb5asxlo2iQubeX9xo
         FJDQ2NjB/g2RtTcBKo7mrqD6cfulLZwsIGjYPZixC9K9gth7DJoIKvMRefOCTTlGzxP2
         XQYIGgY92Aqx+dd3+XXbg+phfUWi9CCHN+S9sX9oLKhNegxAVaGzG0rvbosjllYTAE13
         a+fKx9udAS2g5q9pZmGvbzCQYN5Gs+BZ0ygjKzvIh2IBP9YW2YPu8Tb3hiHXYyJ+f++a
         EHcL6GQLD+qQD/j0r/uQ4GM5iDpa/2BJK1gMu2t81y1VSyab10tJTgTwQqDMgrQ6Tuzx
         A2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM62jmqizb1inZ5kUy2b+T2fzcSM+hpLLtoCLTlm2hTo7G96CMtdIBanDpnLQrltr2279IEI4WXI0MXfgVxPge5R/ogPy90pGUl1HMTX4=
X-Gm-Message-State: AOJu0YzLdBIOiMKqg949G4Te+LO++rgO4dO2Rj1gxPy0GJkfLrekdsgA
	so8izNHlPEzjoJtaF4bWHPHWlN5nm6jtXDjaGPRpghU6xHZPf+48M8b5CKjsB9A=
X-Google-Smtp-Source: AGHT+IE3wROdfA+4GtinIm4J2aTgvzCmm/rh+JDi/HVfmwprLNADV9gOi9HjTbVE3fICbkkKMu/Y/g==
X-Received: by 2002:a5d:4fc6:0:b0:33d:3fed:6531 with SMTP id h6-20020a5d4fc6000000b0033d3fed6531mr8520211wrw.67.1708614810965;
        Thu, 22 Feb 2024 07:13:30 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600c4e0f00b004128f41a13fsm369363wmq.38.2024.02.22.07.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:13:30 -0800 (PST)
Message-ID: <694c1a7e-f41a-471b-9c73-0d9eafe5f573@linaro.org>
Date: Thu, 22 Feb 2024 16:13:29 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] mlxsw: core_thermal: Set THERMAL_TRIP_FLAG_RW_TEMP
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
References: <6017196.lOV4Wx5bFT@kreacher> <10417137.nUPlyArG6x@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <10417137.nUPlyArG6x@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the mlxsw code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


