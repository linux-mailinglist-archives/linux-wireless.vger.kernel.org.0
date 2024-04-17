Return-Path: <linux-wireless+bounces-6447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6528A834D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09241C21904
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0D913CF94;
	Wed, 17 Apr 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNKAPpyk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F313342F
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357754; cv=none; b=hR+9o4NT/KbsRmTafMqxWDHfCvfCxzk9DL6oPVmvBB6LAJLlLLoKS3FpRaO0BfNfhdx2fUsaHbE9wDijdRjR9h1x8UF2U0208yXWZIrhnUZRyAF98YyRqZfJSE1xQfJiRUYuPG4ZXJ8DID9yhojWAGSRAubZkXl+ZADyExTOIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357754; c=relaxed/simple;
	bh=XJKyw2y5CxJd9iw2pv8v49mLUMxj5j5397B5IBORIKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcEjo7hiGG53xNNfwS75CmMtvYD5ELliAVY+JA/yT0luq4EqK8EIXH8jkLwl9lQ11DXoT9Py3vmcLivoT4mGdA1czJfTxr4IvxGvLHw4qjRh47Ib0SoMuZoBwHXTy4XNejlZlxjFI2oQfmpjo6NXYZOKNpa6iXV6HwEBFk/1wTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNKAPpyk; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22f01274622so3492254fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713357751; x=1713962551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3oveVIqvfXpANC6X0yZp4EOyb3G4ovV7gjUYkogoPps=;
        b=QNKAPpykDxi1kF7/LiDlqsri1i24v0k8OGYNV3RfyZ9UL/ngF1KEVQvh3ucVhe4Gt/
         RWBofa5FKdeq1reNCayzTI4JkfxohiKI6Ru7W8ZskZ6WwOhjg7HQQHeOcL8OryQMzdps
         P3+xFA5yiefG8jkmPwVNEAI//ovHe4mYZfgRT7GOjvh6vPcp+RtiZShNtq9KIGeUcGW6
         ERPQ7kdnUcJi2QqoZXZPu/RHU89zFSH8F9/TNVIkJtrd48TvO1KeRkBcAhFlC5z+FUbW
         4DtZ77Mz7tmbuwvwdOX4cAB2Nsn/gDLEcvkIcVp7PBjKYpcV9l/Z0jF+bYy+WO3V9BYa
         znLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713357751; x=1713962551;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oveVIqvfXpANC6X0yZp4EOyb3G4ovV7gjUYkogoPps=;
        b=cYtidoCIqRHJZBNscP8oH91SvPB3tT90Ae1epGllPEhyAPaAwVDK7ug50Gs9aHAtAd
         mr2Su2B1PJVWw1pT/4rMBeLnWOxn3YPrY1D8Nf3dF3vX2IkQN6WSCwKv9tNxf3wRCNR/
         KEmP9xafIF1LSB9U/pklrunyJPqdwmXvoh2xTE2y2BTQ7MhaZNPSRomXmetnt6KwQ4FU
         P5mXygB+NTJ6SsRaZqpkaUsK8RPziAD1uNX/aytoyi8qch9Uq6+DVwv/ndb+tKxNEq48
         LY+5TnxMakYXNlISQGrFSaqYW4/rHVl8PU4udFJyDrlOwDzY9oX6oerEmgfBn46JQHMb
         plqw==
X-Gm-Message-State: AOJu0YwOtwrvrsBk83E4FjRusC+rL88JpurJSUc05SDKu9dww0/bTdwr
	rAOiZbXnqC1bisoy6yPbKF/4sKcmDfGXQ1rSHYc6wHNXn0b6IlWh
X-Google-Smtp-Source: AGHT+IGD/GDkNXQwvUnzsEGr8VZocCQZuoc5HYGQxn2wyiQ9xk5kv1R81udHtCoUvw7iheI/MHgI8Q==
X-Received: by 2002:a05:6870:718f:b0:229:fa5a:2fec with SMTP id d15-20020a056870718f00b00229fa5a2fecmr19418889oah.54.1713357751602;
        Wed, 17 Apr 2024 05:42:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id lg22-20020a0568700b9600b00238abc3bb0bsm198465oab.40.2024.04.17.05.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 05:42:31 -0700 (PDT)
Message-ID: <b0e70576-a53f-4d03-a503-ddf1f98bbe9d@gmail.com>
Date: Wed, 17 Apr 2024 07:42:30 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: putting future iwlwifi firmware into intel/ ?
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
References: <fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
 <9aa64d50-cb4d-4118-bc27-86c23410ff8b@gmail.com>
 <f65765b29ea7503fbbaa5e047c95a82de6fc2083.camel@sipsolutions.net>
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <f65765b29ea7503fbbaa5e047c95a82de6fc2083.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 07:39, Johannes Berg wrote:
> On Wed, 2024-04-17 at 07:31 -0500, Mario Limonciello wrote:
>>
>> On 4/17/24 06:18, Johannes Berg wrote:
>>> Hi,
>>>
>>> Since I was just looking at some firmware related thing (files for the
>>> hardware that might be shared between Intel BT and WiFi), I noticed that
>>> just over 30% of the files/dirs in the top-level firmware tree are
>>> iwlwifi-* files.
>>>
>>> While we can't move the files that older drivers might consume, we could
>>> e.g. change the driver to look up future versions/future hardware under
>>> intel/ instead? Would that be worth doing?
>>>
>>> johannes
>>>
>>
>> How about moving them all now and then creating compat symlinks for
>> older kernels at linux-firmware 'make install' time?
>>
> 
> Didn't realize there even was a 'make install' time :-)
> 
> But then I guess it'd be simpler in the driver since we could just
> unconditionally add the intel/ prefix to the request_firmware call.
> 
> johannes

Do both.  All the stuff already there add the compat symlinks in linux 
firmware so that current and older kernels work with older hardware.

Any "new firmware" only put in the new path, and add commits to the 
kernel to look for "all" firmware in the new path.

Should hopefully cover everything without too much pain then.

