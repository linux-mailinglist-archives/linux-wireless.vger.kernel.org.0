Return-Path: <linux-wireless+bounces-11629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E02957270
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548031C2317D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A769116132E;
	Mon, 19 Aug 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpD8qDvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10981D531
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090018; cv=none; b=VbULurcFO9ZW9dV1qJNuRpcSJx6csIicZtZKzkt7oY0CihALul8N5ioAuMAOQgNWmi0+U3BHfvX9r6TlVZRj9uNtfhejmnZGgaP1qduq9TAZlzpwXH0GyzWSn8KWfhzRDM+X7j4RO8JARpaJEVZesvhDH7LF1nAPEBQmt7xGEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090018; c=relaxed/simple;
	bh=Vr6cK37SZMFdy35NeULBBokyBcqiRYDxKCJLqfI7tlA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=U7jWRk4paolyc9q9c+pGhoaJnf/jNMT7ujS1HOEr3Q0R2zdb5i72LH9ZZoRLWpMDvxhDMKp/7pzczkuqWH3X2bKlsTgUUmj+rg3q615DlhuqG2TccCNZ1wiFcardM2EE6b6oH2Nlgy8O69nZEoDwFKHuFhs1rlM8rRfw8cH+xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpD8qDvL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a94478a4eso977634466b.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724090015; x=1724694815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvpNoqTP1hHlhIUaTS2P2h9C9DvZFu/E/brW9FaoFWg=;
        b=SpD8qDvL412VrDnEBnmthmFZCgJQ5fthB+ykloGHUyEyhUfQ5pVM6JJVG88sGzFan0
         k/He3zt5IdUqFSvCqtlWZg1yiVFP2bMdXdzYg+YllfSo295xNV7WK7buX63sJQhMkBQj
         2i8rtOb3HvC+WpULZndd2CYAkpSpEeIfR8Az5vZPw7rNWSrTP3D2NQ4bw0WDgmaE+kzx
         +zEDYAmFAarAdLAUp7aNk20SrP1SbAoI+dw9R6aCloVi+yo8kbDMQqO3dKBJuk0e0Uua
         MoxiLoaj9Hoh9FxiChEoH/hDZYqEMwpRc7iqO4tgY9XSEYePOaEcQS0Oibvfu5U+aviJ
         xKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724090015; x=1724694815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvpNoqTP1hHlhIUaTS2P2h9C9DvZFu/E/brW9FaoFWg=;
        b=Jfq+JoTJUfoiylQYYz6k2jeamOwxufrb0FW81NnmoO4ZXaUn6HyBC0RFQYnNgOFr1q
         KN1oIucqX30hHw2k87LbnQ8ssCNDDC0BWb+3lYReuWlyvnY4n9LwXoZI2xiPe2Ejpot5
         XqGDZq0AoL0qZgu+QvYZ0FYzT4B8ygjDCY0ZgPdyQmknqGGf6weg+T+Gap1zWKTJXKVb
         nrZctW9W4zhgutQBurmFBk2XqF6YrtJIV1ThMNHLA8+MlJe8HCxPMr1e6PuT1hG/KH9H
         /ItbfZEpYam5BWrmiewHW0HFeoerSv7KjGlv6zvXQBg7oAYDLnAGMVkQz5L6LMzYHO7w
         zu5w==
X-Forwarded-Encrypted: i=1; AJvYcCUuzbrg73PuF+wh4jV35D6V7RzCf/qmvltoBW4fEyeg08cpK1Ih7hHhkczjHEGYaC0O8S8dUwsi0WjfCTBdhZUTCX9Eod6MG1fHU0KCQRU=
X-Gm-Message-State: AOJu0YzR2nomhfqC/uqBV+juoVsS0l+Vh3fablt4nhMJUw306jVavfAx
	HLeTZliZDfqw/tGflq9bDSNauY473RkVTil8TkOUkH4rV8aBM1ak
X-Google-Smtp-Source: AGHT+IFayOniONOgs0W870khZVhy8ecB0xz/FXttULqqcEQcw2nlBsH6EDsVrBiFo0Pe5FyOld32lQ==
X-Received: by 2002:a17:907:2d8d:b0:a7a:b561:356d with SMTP id a640c23a62f3a-a8643ffb894mr40651466b.26.1724090015047;
        Mon, 19 Aug 2024 10:53:35 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfe70sm655863466b.75.2024.08.19.10.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:53:34 -0700 (PDT)
Message-ID: <a01b31f6-d33d-4763-9742-e22a1f975277@gmail.com>
Date: Mon, 19 Aug 2024 20:53:33 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 05/20] wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be
 NULL
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <6d4194e2-8c8c-4d37-9b44-aada8d1d519f@gmail.com>
 <eb32692b42db48d2a05bd4feac9a814c@realtek.com>
Content-Language: en-US
In-Reply-To: <eb32692b42db48d2a05bd4feac9a814c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2024 09:33, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> RTL8821A doesn't have this. Trying to use it results in error messages,
>> so don't try if ltecoex_addr is NULL.
> 
> In short term, it is fine to avoid these messages, but we need BT-coexistence
> for RTL8821A if we want better user experience with BT.
> 
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> 

I wasn't able to find this LTE stuff in the btc folder:
https://github.com/morrownr/8821au-20210708/tree/main/hal/btc

I did what I could to make the coexistence work, and it does.
I used my Bluetooth headphones for several days, listening to
music and watching videos. There is only a problem with the
wifi speeds with one router.

With ISP's HG6544C router:
Official driver: 3/5 Mbps.
rtw88: a bit more, but not steady at all. Not enough to watch
a 1080p Youtube video.

With my D-Link Eagle R32 router running Openwrt, on the same
channel:
Official driver: 6/10 Mbps.
rtw88: download starts around 30, climbs to 50 / upload is 10
Mbps. I can watch a 1080p Youtube video.

The music doesn't cut out during any speed tests.

I also tested transferring files to and from my phone. I don't
have other types of devices to test.

