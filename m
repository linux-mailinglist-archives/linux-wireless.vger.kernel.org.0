Return-Path: <linux-wireless+bounces-17029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59466A0047A
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 07:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A971883998
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 06:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E70D1B4137;
	Fri,  3 Jan 2025 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/LQrtw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FB1B21B5;
	Fri,  3 Jan 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886679; cv=none; b=KbBF60MYmwh7xDjsYc5QFFjc8lwFVsB7FnkffsbsGHSgd+r7v2r/FK5v2fz+HKAQ1H2RI6MkECHlQZeMjFCAhtDWbzxo1ICAidS6zyE/UD1wixor5OxN3eMGbsmEMMerLAkiBtPF2wA1an4Qq1w1yJvQEpq9fOuPn/TrWcWmls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886679; c=relaxed/simple;
	bh=3KP0nCS6lvOsicuamKMU2eVXmaOYVs8MJvEzz0z93VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4kFrAN0e6cbRHNvxyoJ9iPXq1XjYasrmjPvlptnt1xFqoVwR0XbZHFwBZjhzXc4A2szvkzOw5/Gj4bT3YmOHHUVNDLuPkrSt+S3a4puPo2rKH3rpig2HoS68C6SJsBmAMX+FtAROHDld5olAk8P5gVuHvtGajFr0yD0cREJPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/LQrtw7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862b364538so6837117f8f.1;
        Thu, 02 Jan 2025 22:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735886676; x=1736491476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABL1p7nta/CRl8BsVQhOmjXI/HpJhPxNL3TKYtG8RXE=;
        b=m/LQrtw7A6fkyS+dLafLI+0rJIhmMcW1O1pbzrdJLJNNNCzPX3G2t9vtwKgiGDSVT1
         LrT6/zTFxSGipfsjMLnZUvqjBlLVbrodQp71dp03ayVVuOTsZTHa2MkEavwteD/mykQn
         w3EFxAwcvwZGi5eEl7WjVIFo75ZJ7R4U5daWfOjZpKSn9V870Cw0WUpkg7gDQmZw/l92
         FbrV9+MjzrMJDvNGHY7zIbXcMgmIAwJ7OXsWET0vt9nB8FJUSRW6tBaIeKK793EEImn3
         EQH440SFLgsVEPwDVIAPKRelWf0X64Un0MwEL0v5GVqgTs+AoJ1QWTPH6dj0Hhrvg25T
         jrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735886676; x=1736491476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABL1p7nta/CRl8BsVQhOmjXI/HpJhPxNL3TKYtG8RXE=;
        b=P7Hg4K+5WWGZJ3rAVVEgAzPukEhJTx3shC5nBhoHyidiQS2uaJOzOUDwR/9ZmJJsc6
         dFBmTeTLsJfp59ORGy0IvMtk8lPMRwTuddYDwVx/EjzkMqlqi1Bvdgmtz7czWvdlC+M0
         6eoQwrLt0utrJhWXTNr7ICIJL5AXuq3itk5a5lfbAMlK7nsoApwt0glg5IYzAaflrvxZ
         6ioh68xk6WuNQn3KX+vY1pmjhgXYoIyaCEq5hZkVX0pRcwja8yeWjUFbT9U+xjUVpZqs
         bVv6ZhbibaicwwsB6p1LI4BuleH7DXjpsGTjpOt8yGnyE00hCWcSTlu645tmbbYCNDfo
         snFw==
X-Forwarded-Encrypted: i=1; AJvYcCUUSi4XwT67M5LuKcNuwXKOt8rDHp8tgSsDZ92voBXPOwoIw2CB4tKDNitd0wRjmwd1mXI/+G3n8/9zxDs94zc=@vger.kernel.org, AJvYcCUxL5ASMv/frbvjkB/NCikmPKbYoYOs11SqlLHqjgoz8f4QuEzChtm+cEXktbMbENPk0GDL1K1SpYCLK7w=@vger.kernel.org, AJvYcCX8Y3riVXTAWejhT1T5x1lZH3WJHrEC4RTf/IEwEF1RaqawYNzNd0yURVsXawZHPOXVnDKkuN/v@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6YF54eobhIQuHkaPnSF5aYXg9nq+Wo5v3Wdc8Ls4PWLUABC1
	UsruvFo9Sw68nMqQD1Cqg4PTaxuU+MULiCikaogqQdIxehmPkQ1Z
X-Gm-Gg: ASbGncvzZe6qBZa6/aeiobyZ/rZE8TPfzVv0s4uJFFqDbvNz4PycZHBQGLEUkkYYszG
	3zrTeQ0SxtU3waARZoT8x5snh22f74M6kmcCGQPpPq/Rb0W7ohbmcbq4x9Y+wUmDE00cSPORSfX
	eLYoUxC56mZDYjtuVHjj+zRO/m4GqTYWDWMZ+cnORh3bFTqVGdeDJcVYu3kquLBHoEf9bLIgXro
	uvQutVB3a7HBAUminawyY4ob4m/uuJ/zvz2cZdGSMFJN8RT+GyP4f7KBxz2JD4dlKaQa6OaoEnw
	7Nq/cJRjuSv/hwUrGsam75JFCBU=
X-Google-Smtp-Source: AGHT+IGAa139yx3LH2QxpRgTHdKaVEYWhB6ijI8gOCJypp9phUqVp1ost3xXdpx7HlRS9Snm1/kE5w==
X-Received: by 2002:a05:6000:2af:b0:388:ce0c:9f19 with SMTP id ffacd0b85a97d-38a1a177e24mr44534740f8f.0.1735886675749;
        Thu, 02 Jan 2025 22:44:35 -0800 (PST)
Received: from [192.168.2.105] (p57935577.dip0.t-ipconnect.de. [87.147.85.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366128a44fsm471876805e9.43.2025.01.02.22.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 22:44:35 -0800 (PST)
Message-ID: <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com>
Date: Fri, 3 Jan 2025 07:44:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove driver
 using deprecated API wext
To: Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geoff Levand <geoff@infradead.org>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Pavel Machek <pavel@ucw.cz>,
 Stanislaw Gruszka <stf_xl@wp.pl>,
 Gregory Greenman <gregory.greenman@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-staging@lists.linux.dev,
 linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.12.24 09:22, Johannes Berg wrote:
> On Tue, 2024-12-24 at 09:07 +0100, Philipp Hortmann wrote:
>> Driver was contributed in 2008.
>>
>> The following reasons lead to the removal:
>> - This driver generates maintenance workload for itself and for API wext
> 
> So I've been wondering, why are you so concerned about this? And in
> particular, more concerned about it than the people actually doing the
> maintenance? :)

One of my big fears is the hand over to the next generation maintainers 
and developers. The less code and the less exceptions due to old 
interfaces the easier it will be. We loose maintainers and developers 
for many reasons, like: retirement, burnout, embargos or simply because 
they are not paid and need to earn money. After giving some support on 
the staging subsystem I cannot see at all that we can attract so many 
talented people as required for a save future beyond 7 years...

People who evolved with the kernel development do not have a good sense 
how difficult it can be to join nowadays.

A friend just bought two servers. One with a paid OS and one planned 
with Linux as OS. The difference was over 12000 € due to licenses. What 
would be the price when we do not have a choice? Do not feel save 
because of today. We need to fight for tomorrow.

Where do you want to invest your time? Into the new technologies to keep 
up at the front edge or to keep old stuff running that is not productive 
anymore. But there might be someone who can pull the hardware once every 
two month out of the shelf and ask why this is not working. Should this 
really stop us from progress?

> 
> We got here because I removed a *staging* driver that was in the way of
> some wext cleanups, but that had a thousand other reasons to never go
> anywhere anyway.
> 

Partial, for me more important was the try to remove all wext drivers in 
October 2023 by Arnd Bergmann.
[PATCH] [RFC] wireless: move obsolete drivers to staging
https://lore.kernel.org/linux-staging/20231010155444.858483-1-arnd@kernel.org/

>> - wext is deprecated and only used by two wireless drivers in
>>    mainline kernel
> 
> true
> 
>> - no progress changing to mac80211
> 
> It fundamentally cannot be converted to mac80211, it has a whole
> different model. In fact it cannot even be converted to cfg80211 because
> some APIs it uses just never existed there, and likely never will.
> 
>> Tested a rebased version of this patch on the Playstation 3. Used
>> T2 Linux with Kernel 6.12.5 to test the Ethernet connection.
>>
> 
> Arguably that's a pretty strong argument for *not* removing it, if it's
> actually relatively simple today to bring up the latest kernel on a PS3.

I was not able to use the WLAN on T2 Linux. I just tested the Ethernet 
connection as I know that the developer of T2 is using it. The reason 
why I bought the PS3 is to see if Linux on it is really a use case. But 
all I found is that it is only a test vehicle to say T2 is working on 
Power PC architecture.

At the time the PS3 WLAN driver was added to the mainline kernel it was 
really cool stuff. But nowadays it is just a high Power consuming device 
with a noisy fan and not enough RAM to do anything (256MB). The 
powerfull GPU is not supported by the kernel.

Do I need to find out why the WLAN is not working under T2 on PS3 to 
convince you? The WLAN is working under redribbon Linux with Kernel 3.5 
on the PS3.

T2 is working but to make this happen the T2 Author has an own repo for 
patches to apply. In the following video he publishes his view on how 
well the ps3disk is maintained and tested by the linux kernel community. 
My impression of this is that ps3disk is not tested on hardware at all.
You can find this in a youtube video: “I can't believe VIP Linux kernel 
developer BROKE PS3 support” but watch out that you are in a good mood 
otherwise it is pulling you down like me...

The commit that is breaking the function is:
commit a7f18b74dbe171625afc2751942a92f71a4dd4ba

This fixes are not in Mainline up to today. So who beside T2 Linux is 
using this? You can find more of those breaking patches... and videos...

The following points are also in the list of reasons:
- This driver has a maximum 54MBit/s as it supports only 802.11 b/g.
- Using this hardware is security wise not state of the art as WPA3 is
   not supported.

Thanks for your patience.

Bye Philipp



