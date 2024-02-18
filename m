Return-Path: <linux-wireless+bounces-3741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA98597B0
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E371C2096F
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Feb 2024 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA776BB41;
	Sun, 18 Feb 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDq3jF0U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB54290F
	for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708271764; cv=none; b=YbeDZz3C4PKohVhk14zZcDvVk487YkHk9lnYZKCA5VddLVJj9Vk84rPLz0Gj03b15BGwlEGZhbgWweaTxBJcORBBSNPLSOLEAPkjL7BafWz9OGmnnLxxuXxStP0FHnfkOX5GEAu1c5lVpoRTNwEb7Pj69HGQlS0ACmW3XLCCbb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708271764; c=relaxed/simple;
	bh=9EWwLZSmqmcSYNCzl1ps4RCS1LR9zR74mhjigh0EwAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=paZRC74hlPYOlJlWtrkU2OCzrOSfCYHS8eN0dmFLAIkKzW5CYTSZGpzaqetuuWgktqIvjllTevHp3ksU4QAniNLlgM3RgVeMSm9jPtDDbiWekhYyAd+1cRXfurFI9COi+DGa6jgy6qJ8qnMf5Nzbai8PNOuFPIwwBiPGmakUooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDq3jF0U; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21433afcc53so1283103fac.3
        for <linux-wireless@vger.kernel.org>; Sun, 18 Feb 2024 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708271761; x=1708876561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=b1hPXC+1vrl9fs78t1w9vNot+CE8zpL6AkSe7toOvL4=;
        b=PDq3jF0U2TEEJ36EDkDz1WOZqnaaCzF59fQ7bqAu2s2ehlEo1uh1c8zkVOo0kXd4Bv
         nPKNFMkOMu/1tn7MlnERdAtYYi1z79kKCiChPewU0cykIk4vyOkayhLiSOItY7Gy5fNP
         FDnjx/1OU8pmdeWc7QoW4n7epfhS6TtATdSGeR4GF2+C/9k+Jpdbkz6lVL6WbJbHgM9Y
         FMtWnx3RL28cQkAmrH78CkVl6D/pB7rjcRxvpZ0J+zHo3vh92XR2ZDel7XmBoOlqy/zl
         FRKRivw5Nb3XHN3LSyxUM6rnb5s+2jssX6xtMGaINPcDBtZf6/zY1uN94mGQo8IBFLxJ
         YpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708271761; x=1708876561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1hPXC+1vrl9fs78t1w9vNot+CE8zpL6AkSe7toOvL4=;
        b=aD/BHJ332LppTMBEoyFgv0xNrDmgn/+c5q9ZnqqkXnKQB/7BWOoXyNPMVyvQ5SgK5I
         ahRdlBdDoM04aZYjhy6iieWtYfhCtZTm3WK/o1tUHP1LtgdaXx54DmNUXxApmc4h00i+
         KMy9hy5KfHFL1s+JPFTYDn0ZVappso0qP+Aqtwq7d6MWwL6CBMz+AjFJWpm4Ss3kB+rg
         PzjR4jdeZ5nbGPRxHssEs7mR0w6WAGRXZ9BVNnla24dIFpliJmMP/+HNeuANLkKgwzmN
         LCnjPuvaWWyIpwH+87NQrLL+sk7RYwX0LFz0uPOBP6IprlNbm4r0fJSvrDz18dPiL5Vg
         YQqw==
X-Forwarded-Encrypted: i=1; AJvYcCUTzslA44SeQqPp+Fyk30EhPbDYo77Aw1PUOGLDJxtkvxzd1pmVBavMzmsUT/bw1Xeq3l3pUdJoH0RDktW+rpI8ORg1+TrdGHAazJ2r/1M=
X-Gm-Message-State: AOJu0YxwC2JCHQEMhveXsBh/XbuVgmyMErMykSSF2EQc+tMoxQi8RFw/
	0NHldP8EthUjdB66HW5X2VVZBU45eP9b5aO2ow2JKKsvYYrUbJ3xMDl8kxqd
X-Google-Smtp-Source: AGHT+IEc6YzfDbY09S3ruHzo5nWVdaIlacylDbfc+dTQQd/0VF+8wDbfSv10JgKAAjhj1ir+h2uHEw==
X-Received: by 2002:a05:6870:219e:b0:21e:624d:56f3 with SMTP id l30-20020a056870219e00b0021e624d56f3mr8004865oae.56.1708271761170;
        Sun, 18 Feb 2024 07:56:01 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id hc8-20020a056870788800b0021e76be1f23sm965201oab.31.2024.02.18.07.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 07:56:00 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b9a4df4e-4b1f-436f-ae4b-90fc0c68ae81@lwfinger.net>
Date: Sun, 18 Feb 2024 09:55:59 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa
 RockPi-S
To: Brent Roman <brent@mbari.org>, linux-wireless@vger.kernel.org,
 martin.blumenstingl@googlemail.com
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
 <9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
 <f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <f8d31d74-fdfe-8706-6748-273b8c3674ca@mbari.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 23:13, Brent Roman wrote:
> Larry,
> 
> Radxa confirmed that they do not program the eFUSE on these boards.
> We do not get a sensible MAC from the chip, so I derive a one from the CPU's 
> unique serial number.
> It's a hack, but it works well and is standard's compliant.
> 
> The RockPI-S a *very* inexpensive board, so I can understand Radxa wanting to 
> minimize the time spent configuring each one.
> https://shop.allnetchina.cn/products/rock-pi-s
> 
> The vendor driver seems to deal with this by applying typical gain parameters 
> when the eFUSE is invalid.
> With that driver, this board's WiFi performs beautifully, despite the 
> unprogrammed eFUSE.
> 
> Would you accept a patch to add this logic to RTW88?

Of course a patch would be accepted. Ultimately, the changes should be made to 
the wireless-next code base, and sent to this mailing list. To make things 
easier, you can send me a patch file for the rtw88 repo, and I can reformat it 
for wireless-next and send it to the mailing list under your signed-off-by. 
Either one would work.

Thanks for sorting this out. I like the idea of deriving the MAC address from 
the CPU serial number. That is unique and reproducible.

Larry



