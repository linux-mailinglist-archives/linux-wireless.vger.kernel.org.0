Return-Path: <linux-wireless+bounces-9124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364E90B55B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 17:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4F01F23BC9
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDA13AD2F;
	Mon, 17 Jun 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/0tV0zl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592913AD28;
	Mon, 17 Jun 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638829; cv=none; b=nVF9v4gDtv+X22zXK0pXN7kFT7B/A8bii/csGlVAliPyOx+4RcgwlUN39/TMUOgg1BeZ1UV9wG0EnA7fj3nJ8Y8gwyErd68oAwvvMJZM+pZelm8Dt6qoCUQRtwgF6d7Nvq300Rbox0q0Hd9V7ADcn2eLrcpUGk26rpoJDIWcXkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638829; c=relaxed/simple;
	bh=lOamXn3N/pPpYSAmY4TOJJMLx7CGifnlr7hw4fmHfHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ku9rbAzzfscBT49vlog6JtAvoNMm7vUpbHvOtmEX6uKTUr8JwgEk+nUkxG2/nZCZYe9Ep1yvY+EEcQI2dC6tl1B+ykLRbaA9QGL52MQ/rbE/rpNQV2yX4SYBu34r0rNaVR094g15gxb6t8IdlmYnlbx3El1oW4HtHp2S917t0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/0tV0zl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c2e31d319eso3653489a91.1;
        Mon, 17 Jun 2024 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718638827; x=1719243627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYKZbKA1IH1qpLBsnDaAu/eGeDN326v+sTxO24RWZEc=;
        b=h/0tV0zlxboIuVQNIPznQquLeh/OH5Ne9ZPYaPnTuajv2gX3dosOL5CC6A3ni0QNjs
         bjAHk7iRWkNubjPlS2AAwqr3SnEszPi/NpzzSHxvAZtTlGkLNpk0+abviK70SBKmdoyP
         mjx9+tyEyFR1Azwm6HTmNSm6jbfCDK8ZQjfrrkvuOMZ/eaUeqppjbtscD6esTnanMC7q
         n2H8Cy9v3WbjtQ84/4VrsGEZgABETrDaAvz9pVAKCQTFXR9l4D4DAtRmAIy/TterO1x2
         gYmuILHd1TNqMC8BWP2SCccwYZs987EOKXZZ6IyuUES+Yz7bIhAdtRr1UFXsjyU2w7g0
         PV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718638827; x=1719243627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYKZbKA1IH1qpLBsnDaAu/eGeDN326v+sTxO24RWZEc=;
        b=BlpUx9jbv7NhXQjB7tSqz/uhhFzqFBkblAQqamL2ZgWRiOkOUthQit/kg1k4y+fnrb
         xaAixQDFUdmKeKq7A60O+VYRME5S+3kXmQtu0cUnxeoQzv6bFxBVV7OJ8tO6f5laBuVd
         /kTxRkGvmI+kgSGkqKekPgIEr06rt4TUhM/JVpsIELtjVZYU3ScegoyImNWX84xWax9u
         xhK+L1YMUWgnAavlyhl8AZDPCpg+zShfacxkhbxjkitT4T1b0nLRpNSaxhUI0uTFwmMY
         rQDImpdruiO9/jcGz17d2qwPKeb2ZzpVbcBnNLX0Gno0Xga5+fjTsqmlGx3eJy/epnsc
         dPjA==
X-Forwarded-Encrypted: i=1; AJvYcCXr5FZuZxOs7gNUgA0OFH3R5gEc0bDS3HProBHJ1Qe7kGMaamMVKM2UvGANlP0PsZro9VQTTTe/cuzsKR2eeFHk0N9lZdR1pEni48IUaWbsKWU0TTYUU8O+U0dZAPY97jcWeqMqjt1nGCq/fsg=
X-Gm-Message-State: AOJu0Yze39gf2ZZL31HEEWPMiz1Xu4Fto2jiugPrUrA+8gZ6yfcb85fG
	32waAcyw1CUcpp4FTJPYjeDUYmcQqTr/Fuc0nKIhWQ7/naEHculv
X-Google-Smtp-Source: AGHT+IFHFsKHtLXkZcWv7XUVxV29Z6bbPOrvzMOfmWEj2bjq7IKEVu74hiV3XqolDSUa8zDgMsp85A==
X-Received: by 2002:a17:90a:ae06:b0:2c2:f6a3:3043 with SMTP id 98e67ed59e1d1-2c4db133ea3mr9702567a91.9.1718638827086;
        Mon, 17 Jun 2024 08:40:27 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45cc95dsm9152634a91.22.2024.06.17.08.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 08:40:26 -0700 (PDT)
Message-ID: <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com>
Date: Mon, 17 Jun 2024 08:40:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Kalle Valo <kvalo@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
 <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> <87iky7mvxt.fsf@kernel.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87iky7mvxt.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kalle,

On 6/17/24 8:27 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>> Hi Paul,
>>
>> On 6/16/24 6:10 AM, Paul Menzel wrote:
>>> Dear Linux folks,
>>>
>>>
>>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>>> connecting to a public WiFi:
>>>
>>>      ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps
>>> nss 2 mcs 9
>> This has been reported/discussed [1]. It was hinted that there was a
>> firmware fix for this, but none that I tried got rid of it. I got fed
>> up enough with the logs filling up with this I patched our kernel to
>> remove the warning. AFAICT it appears benign (?). Removing the warning
>> was purely "cosmetic" so other devs stopped complaining about it :)
>>
>> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html
> More reliable link to the discussion:
>
> https://lore.kernel.org/ath10k/76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org/
>
> I think we should add this workaround I mentioned in 2021:
>
>     "If the firmware still keeps sending invalid rates we should add a
>      specific check to ignore the known invalid values, but not all of
>      them."
>
>     https://lore.kernel.org/ath10k/87h7mktjgi.fsf@codeaurora.org/
>
> I guess that would be mcs == 7 and rate == 1440?
I think its more than this combination (Paul's are different). So how 
many combinations are we willing to add here? Seems like that could get 
out of hand if there are more than a few invalid combinations. Would we 
also want to restrict the workaround to specific hardware/firmware?
>

