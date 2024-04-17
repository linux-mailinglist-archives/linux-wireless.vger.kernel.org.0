Return-Path: <linux-wireless+bounces-6456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5E8A85A8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 16:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7331C2090B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35EA13FD6F;
	Wed, 17 Apr 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igbjQYsL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A4213F444
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363284; cv=none; b=C54cZwPHshsdIqx6tCQMmh0+LvnE8THvA27xu3ZHYANipMM/kMlFqAYnWelfLVrL6QTfQWsg41CWVlUE9WhQbMtNCgSqwxupeZzeN1oV8BhY/iKEK/id/3tdhyUYSzTkzHldy5s7wLfFJ1m/mqodLKJiOAT+5OUAGk5amb4mcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363284; c=relaxed/simple;
	bh=pK1V4Mzr7kOcWEn6kxf4fxSzfwUd+I6Z9/arnLQ5HEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IG1kfgIeIzLumgOq6h5368+4dPuZIds2pefAjI1ZWNK9vYbR7xk4An/esh/KueS0urFl7XYOAIP874V4pK053ttuXcQMUDwuGPLPetSA0JbQq3zYDzlckOzROlQnbX0Mdtq+ZtSB1gwiABHh7wwXCbFodUJymo5Z4cR5wB6dHJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igbjQYsL; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ac90ad396dso2222449eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713363282; x=1713968082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjawpEZOcDH/6R+eopMAGA1z4x5Ko0AY4+QCsVzXPgQ=;
        b=igbjQYsLvWU+kRiuu3LSs7BuZKM7TQ+8z95JAUFNN6+sd4B/dA8T69n3peUWUSiMWI
         9pHMiakXQJtJqKZuxXH47p0tDmoAOzE2+8OAGgfqScHjC/QAgKv7g6ncliyTyjKPddmL
         zDZvCq2RjxvIExPQbOjPRuVmzN58QFpBkFULe184Ou39KUnop3e1BNwUUVdqRDN6uYfb
         XFVpJ3sDt2uWg7GtHZ1WcDrpaggXRM1aQqtDAUD0tQqqlsxl8iBAqr0Hw6xmnogymepA
         AkrHJRgIfl17Ul9VqHzVbSSRDIgNukqGr4gcJiOdgrASlzhDP5gBrc+MKTzcL58IYzWw
         K8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713363282; x=1713968082;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjawpEZOcDH/6R+eopMAGA1z4x5Ko0AY4+QCsVzXPgQ=;
        b=RIzr7UfMExIfHOexIswfPqYYOD8Y1ltgAoZJ19mWCJn56UPGW3F87uqIUUeNpWFQaO
         4n7h1cz5Q7pckt+Y8Op4AwsANp83D2IHIMe069RvhmxbzVep2nhKZGM6SiL4EhO0Lv6l
         pclrO4dmLLfBFMCB3QWhXKJSFJ6rabHHtSMKcUldVF8OTG/Mpja+XjBpWaWtqrcVCknb
         36yw8l9fIu/PKVTZGjJ/jS8Bhu5JgQojGKXuqg2RDKfMrZ9ZXGaKUl7OELbZSRkKa8ep
         E+qm5PNNoH10S0P0V+e2UtvDDFXp1tJMNSFQWutb/Lta4RExnR9EAUSkMfj03Z9a8BtB
         7rGA==
X-Gm-Message-State: AOJu0YwWUfXZHJconRBycgtr1hFxCj0FuIlyVD+mNxZ/UFpL4KX+VbEa
	hEVdeItI0XFXOK9agmOlCD65EqjOrHnc5/DObhqi6zDtxMb0lJqt
X-Google-Smtp-Source: AGHT+IE+ue6diJmzXmTPNAmaD2gap1v+6Y50xqsM5TCQVPDQ0//1F+etzxC8z/etHBZhebo/yqYB0g==
X-Received: by 2002:a05:6820:c13:b0:5ac:6891:cee7 with SMTP id eh19-20020a0568200c1300b005ac6891cee7mr13334930oob.3.1713363282337;
        Wed, 17 Apr 2024 07:14:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id v18-20020a4a8c52000000b005acd675194asm647068ooj.8.2024.04.17.07.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:14:42 -0700 (PDT)
Message-ID: <9f0163ae-75bc-4a65-bc92-c9ae181ad83c@gmail.com>
Date: Wed, 17 Apr 2024 09:14:41 -0500
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
 <b0e70576-a53f-4d03-a503-ddf1f98bbe9d@gmail.com>
 <b712f48a3e35221b7ff7f4c8cb495b5159bdd367.camel@sipsolutions.net>
 <b7876373-08d9-4948-a49a-e79f42f3abcb@gmail.com>
 <2278e0d1026ed336559adbc9ffbf6e945eba422e.camel@sipsolutions.net>
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <2278e0d1026ed336559adbc9ffbf6e945eba422e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/24 09:09, Johannes Berg wrote:
> On Wed, 2024-04-17 at 08:58 -0500, Mario Limonciello wrote:
>>>
>>> Yeah, I guess. Though not actually sure, do we need to support new
>>> kernel + old firmware install?
>>
>> I'd say you should.  Here's a few examples of why:
> 
> Right, agree.
> 
>> So yes; do the symlinks when you move directories.  It's one line in
>> WHENCE per file that you want a symlink.
>>
> 
> That doesn't achieve it though. It means the driver needs to try for the
> file in intel/ and then fall back without the intel/ if it's not found.
> 
> Or just look for new files in intel/ and old files without intel/, but
> then you don't really need the file move/symlinks?
> 
> johannes

It's probably easiest to look in intel/ and then fallback to the 
toplevel path if -ENOENT and try again.

Like Kalle mentioned, wait a few years and then tear out the fallback 
code and the symlink creation.

