Return-Path: <linux-wireless+bounces-13044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEBB97D218
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 09:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48EE1F2285D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549EB558BC;
	Fri, 20 Sep 2024 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PNr44RVR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C102558B7
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726819130; cv=none; b=S/PtN9mWL9CdXeK3HXSDAeQndbWV18DJqWs9ej9tw7WDE0IJpVoZTUxtfrE7yD8H+t81DDeuPsAraDPXQv6ZqAwRS5U7viswolL/K3n/Mnt/4oIvLuQYXJ/2t1dNY9XFcX9kE28uTnQAs5hbBEOg0boUZbCr/BXsb7GNCT8Sy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726819130; c=relaxed/simple;
	bh=G8gaXS3CKvy6upathpVQhGzsGg8TbragSm/BWYuq5gs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDqzE+oEV3IqdIhq0et0T4Ku7eceWXmOkJYDZJHickM63066tkrdo07gKJFFUoVJHFCAZfT6PCZ08VCH/VrfQegGXYFhQwYnIbIwXg4PmXD7ws3SY76D6rA3IThsOe+3oHF6h7KGPfRN7xVWjWahln739TK+N1yMRLDNVIdBrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PNr44RVR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-536562739baso1682460e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726819126; x=1727423926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G8gaXS3CKvy6upathpVQhGzsGg8TbragSm/BWYuq5gs=;
        b=PNr44RVRfDF/5JPhE+/WmZjTczCrusm+oDep7dkLfajMf9tLjDyn2MW+/lfwweM/mZ
         oQWqIsZPKQ5u7C0UjIFz2uzF2Hx9mXZRY08gHKcvp3n3s5e/OYN4T5tTiRjUI74rbs5X
         /cEIp+cwcUmIDQPPTjwahf4RPWGNlhJziEeGn/2HVsRJvSiYolJI1wsOXgClVGxVwoCo
         +00q/SqJ9GiaFYnQ7UjbRgXqW7GGh+zA6l2H7j+KmRi6EYZaMJO1cZblSTxRMbcmNUDm
         Lz9+DatKGNccZqDvKVpWllnlu/TsevTujp0715iCiL9qcxObyzaFdRbxrKJq2XdggtiT
         JV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726819126; x=1727423926;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8gaXS3CKvy6upathpVQhGzsGg8TbragSm/BWYuq5gs=;
        b=Dgkx6+XDemS26AmwWQeIpnQ7lvkoAlqZldxsIyUQz+5O4dgwdr5Ud8ml+53hXH+bFN
         Mw+z+u/4yx64Da5aJvU6BfG6Y/70kHb1Qy/LsctenFlHh2rWBdEHlq7049pTbI2RztiD
         nadGWayygTDq9NTCstzkDLuCgeFhfvQFKyDaJutAgzAX6wwbrLP5YaRG7bbtc2iu0XhJ
         dR83+uIXrLFRC4TdajH6P+xcRhS+wLSlAUeujMGNwai54sHeDkAmZ4MdUq3G942/StNz
         ICAa2r7ekZntEWn5WZBCliLKxTEFcPbWj7TDOHlIIKCAXGL5kJJEalyB6rf0T9N8Ou10
         8WGg==
X-Forwarded-Encrypted: i=1; AJvYcCVa0wemntQqVsZeQ1fLXpOT6CX4TdxJycuIyv7bR3rjzoHOxZ8O1yk7ZQMl4+2sDThIIwDN4IEMhLBf6INAwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPshkuQTeKCJpUuEHk2SskCfnCvPIiA5jBjyrMToOrKHaufH3v
	t7nSYzoVcswoxC6w+3rzfkYFSf+67Loy28OFROSso4fUbVULtGHbFc0+0K7e/TblccU8mVDOt2b
	qTQKdImelSG2UUQg/uHuodB9tFWhdC6wjTPnA+g==
X-Google-Smtp-Source: AGHT+IFWhG3CUQa9G9CqIMZPY+ykvt6XfSEiCGRn8+DLsrcQfk28XzMJQ1zmPWWX6CXejRPycjDQwRCnYNST7lawdRc=
X-Received: by 2002:a05:6512:12cc:b0:52f:368:5018 with SMTP id
 2adb3069b0e04-536ac32e5d5mr1155885e87.43.1726819126421; Fri, 20 Sep 2024
 00:58:46 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Sep 2024 00:58:45 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <87ed5ec09z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814082301.8091-1-brgl@bgdev.pl> <83c562e9-2add-4086-86e7-6e956d2ee70f@kernel.org>
 <87msk49j8m.fsf@kernel.org> <CAMRc=McEWWm8N++4a5LMCAa0GWsQdi0KuSpj3ZuS_he=H0LP+w@mail.gmail.com>
 <87ed5ec09z.fsf@kernel.org>
Date: Fri, 20 Sep 2024 00:58:45 -0700
Message-ID: <CAMRc=MdyHx72o=6Kf0AM69tQBLjuvRVepN0UNjt+Kf4LX3PaMA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the inputs
 of the ath11k on WCN6855
To: Kalle Valo <kvalo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sep 2024 08:22:16 +0200, Kalle Valo <kvalo@kernel.org> said:
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
>> On Thu, 19 Sep 2024 09:48:41 +0200, Kalle Valo <kvalo@kernel.org> said:
>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>
>>>> On 14/08/2024 10:23, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>
>>>>> Describe the inputs from the PMU of the ath11k module on WCN6855.
>>>>>
>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>> ---
>>>>> v1 -> v2:
>>>>> - update the example
>>>>
>>>> I don't understand why this patch is no being picked up. The code
>>>> correct represents the piece of hardware. The supplies should be
>>>> required, because this one particular device - the one described in this
>>>> binding - cannot work without them.
>>>
>>> I have already explained the situation. With supplies changed to
>>> optional I'm happy take the patch.
>>>
>>
>> No, silent NAKing and needless stalling is what you're doing. I responded to
>> your last email with extensive clarifications. You're being told by the
>> experts on the subject matter (Krzysztof and Conor) that the change is correct.
>>
>> The change has no functional impact on the driver code.
>
> Until now it was possible to use qcom,ath11k-calibration-variant DT
> property with M.2 devices. If your patch is applied that's not possible
> anymore.
>

This is incorrect, why do you keep repeating it? What will be impossible is
upstreaming DT sources which don't take these supplies - which is what we want.


>> It's also in line with commit 71839a929d9e ("dt-bindings: net:
>> wireless: qcom,ath11k: describe the ath11k on QCA6390") under which we
>> had literally the same discussion and that you ended up picking up
>> after all.
>
> I don't care about QCA6390 as it's not really used anywhere anymore. I
> picked up 71839a929d9e, even though I considered it to be wrong, so that
> your pwrseq subsystem is not delayed. But WCN6855 is a different matter
> as it's more widely used.
>

In upstream sources, it's only used in X13s and I added a node for it to
sc8280xp-crd but that's not upstream yet. Am I missing anything? As I said
several times: for out-of-tree DTS, this change does *not* matter.

>> Arnd: I've added you here to bring this to your attention because it's somewhat
>> related to what we discussed yesterday. It's a change that is very much
>> SoC-specific, that has trouble getting upstream due to the driver's maintainer
>> unwilingness to accept it. Is this a case where a change to DT bindings should
>> go through the SoC rather than the driver tree?
>
> Like I have said, I'm happy to take the patch if the supplies are
> optional. Why can't we do that?
>

Because this patch reflects the reality of the chipset. And device-tree is
supposed to model the reality. It's not there to configure your firmware
loader.

Bartosz

