Return-Path: <linux-wireless+bounces-4705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48E87B477
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE60D1F22DB4
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA035490C;
	Wed, 13 Mar 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wav7ccjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4424691
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369571; cv=none; b=NXQPLbZ3h/ZCQywRUwS34crIrvtdF4Y9z4EO4K6aj0W7mK5+jwBbvX+puiLFr1zok/qBu4dD3EQ0stQmar6yPSvfSS2YqsaY/MUc9QUkMv4a6uN+UVk4eQqqVb3E4YLHlq3aSrBKaDh8pTDTPDN6ejzGJqo59K7nnXcnD98+W0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369571; c=relaxed/simple;
	bh=9M8yIRNWxIMTjS1BRyCR7cP7F9pwIK0G/WIGClxX2ko=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=daKBVAPxYjxLaL1WexGsybaZMWz/YHCQm5XkpvlUBFivRwKtVdfbXK7og1euyP4qx5s10tp+w3zQzeJdcATnjvTRr1CMwEe+LNJQTFPx1bG+RMBQaVVlpkux2N74S0blgWF2SwtSLrt+AK2tsBd04zYG1L06pyfrrkCorUzGYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wav7ccjK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e1878e357so110866f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369568; x=1710974368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LwL+GicBufDVGk1Rl0eCOYDPwb7OtUmhPqG6PIobYOs=;
        b=Wav7ccjK2I0Ub5vFSPbuOb+2QxYPoGCBbVnm9GSt0Nt5xyVXKOqyvnniHsN/aZdAo2
         Q3C2KZalpMhi9bhsShsusdH+aHAMW5qEevsVS2WRzk3bOc2BchYF+MvnOIhVzWh+xrFz
         cBZTpOjVlog9OaY0W9LOcYx2ef78/53x00N78LqvVoofaqa1570c3Gg/edbjh+z5RQQY
         obPrubI1af/9eXVR6LXMf3gqQdtYkLHoQ9GlVGWKPaEJ1s2JCY2blyGr3PlJDvXKHK5e
         88Kv08X5qS2HxdtuFx1qvRoA6gsUqAJzpqXDnraFxoIO5ILNWpMBxD1cCYXxTmsqyZn2
         soow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369568; x=1710974368;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwL+GicBufDVGk1Rl0eCOYDPwb7OtUmhPqG6PIobYOs=;
        b=uCavX34ARD85/cRYloRXss3ggX6GYSwmkCETCYxsqEz9td9itNg7bWKl1ESZIHxAH+
         PwzJDhFD1LTTZBcHG2GybQzLEbFcF7C46RqFrc+Pr76VhIqIqm59TVt/JtxMl/ITurx/
         vWST7kyJTM08AbYTJSg+8gLbZ8mXaIQOZhzdVvHnl8tE2jjkn3iMaKFsXMQLPBDvJqOR
         9rKxBW5f8PoTCFwx16eYkjZl22dF+1zW7JQY6fQpt23gQUpXDa33mgwc+IuDBx8SJ+lF
         B0UQ4+3tg6vLmmrp4LDxIzCYd9TK4l/gIXRUZ+dfCF5V78H3D6XoXDur3gauETkm+aax
         Qn9A==
X-Forwarded-Encrypted: i=1; AJvYcCXxFRxL3IL2fz+jnQzWY2fsX+Tr95qHo7HvGh95PqB1+yDTJra3EoQ4cvr8ItolKATVp8s/UG3NrXw3IYC9+I+Tb0Gx581s8luyj4Z8DMk=
X-Gm-Message-State: AOJu0Yx5/J1d7LsdT3zljwiWZAnPds9dy+divbAjeMflz5kEJ+ubmKCG
	9f99IFsfNOs1C+8dMtTgCvRwVp3Qfv/lP8gclFWDaQhbtJcl3XBiCK+zcQeI
X-Google-Smtp-Source: AGHT+IGlvqJfRm9Zc49oWx1sjXNM4Md2j/OVkKPOFpD/TUGD6VJe2MqvyDGGymitBxIUHZ5yC8Befw==
X-Received: by 2002:a5d:6a04:0:b0:33e:9f81:4a3f with SMTP id m4-20020a5d6a04000000b0033e9f814a3fmr9047wru.0.1710369567398;
        Wed, 13 Mar 2024 15:39:27 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bu29-20020a056000079d00b0033e456f6e7csm167144wrb.1.2024.03.13.15.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:39:27 -0700 (PDT)
Message-ID: <7eba247f-fa78-47c5-a130-5d07689180df@gmail.com>
Date: Thu, 14 Mar 2024 00:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 1/3] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <27f2a0a588ed2f6c3c89fb0b60eab7d2f60f65b6.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <27f2a0a588ed2f6c3c89fb0b60eab7d2f60f65b6.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 04:16, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 00:18 +0200, Bitterblue Smith wrote:
>>
>> Create the new module rtl8192d-common and move some code into it from
>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>> (USB) can share some of the code.
>>
>> This is mostly the code that required little effort to make it
>> shareable. There are a few more functions which they could share, with
>> some changes.
>>
>> The only other changes in this patch should be adjusting whitespace and
>> renaming some functions.
> 
> Please run checkpatch.pl that reports 
>    "total: 5 errors, 20 warnings, 67 checks, 9388 lines checked"
> 
> I know you just move them from a place to another, but let's fix them
> when touching. 
> 

All right, I will make checkpatch less unhappy.

> 
> Two unused warnings on channel_all and 
> rtl92d_dm_check_txpower_tracking_thermal_meter (you also pointed it out)
> > Ping-Ke 
> 
> 


