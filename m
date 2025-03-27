Return-Path: <linux-wireless+bounces-20868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6776DA727BE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 01:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F081899896
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78385A55;
	Thu, 27 Mar 2025 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP6Ge3dw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D242FB6
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 00:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743035162; cv=none; b=L1HMxomZmB/OVb1sdlvjlIgMHo/IKA2I5fbD5+jIrr50HaXWxshSMpr82KwFxt/eQ/XGGjQju45PD1f0f7xy+LCuBOpexG5oN+6HK1XN8vLFsRhYqELcUb2noCvUddn0w/cXbfkVpNXxWK2qKdMYUJPVnY1NHaWKuOOJKT1r5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743035162; c=relaxed/simple;
	bh=wpGxByV50OlDZn2QwHkxGZK92IWJB0wuU7brIrCfXUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thhqmS1UkCR7BgC90P27CKzGs/gYhw4h4n+1G/NMpSZWd1HSh2lGlt5RV7L9stugnKkdc4n++kEnwlNJ6hgJxeo6OxXTM7smXsI1mg7iJuxBPON59fkFwVyWIEX1euGJPJtaycEjNrdrD/IxjFIh3ZJvZcqlQrrKvX68phHJXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP6Ge3dw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac298c8fa50so66383566b.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 17:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743035159; x=1743639959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Omd2eaIskZ9cyOWAHw2DEBSzoNZiY52XIxRN1Zv96Lw=;
        b=DP6Ge3dw9yk2wL2KYOR4sTaV6L/Md/0prF0I7Jpr/lc+FPRMIuQBhf/+0cHpC9pfrv
         rFZxn87M9PJde6n9SVPzFtD3bJrvUG/TeHvO+rh2c+KqUIiE3fco472LnqgjQTirGfWn
         cKO4rojHJlp66AoJ/zruGRdOBIgDGG/5YIy3PVV6QIbJKeZdT0dS0O1wWH6qLEyr13Qg
         wltJt0W8mW1LI2PzC5ZzS+Bb/gVvtMl1jKm25h1sbgrabF93yw0chTRWz7UHm88JwdN5
         bnMHsXmpSgCBe2oe9xuWm2/+yDsYLK+ldKpY15UKstU1MBy7+OYkYEx51qyJl/RFtdmU
         sQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743035159; x=1743639959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Omd2eaIskZ9cyOWAHw2DEBSzoNZiY52XIxRN1Zv96Lw=;
        b=ppyZWgBT79q7asq/jIuzcdE1iUhRIo0lAJvuybFfYg0ecX4mhuox44Isbi6kykoD5c
         dkY3NeS7cASsRYIbB5wOVgKYR8qcvkJtsVtW1po7Sa8lABhPcxYbuTqq9+BkOqtxUBTQ
         1M2ZyVLpNSsv4p2RUQEchQqaG2agPkzG931uAObAZ36hhK49OAKsB44vD6F8cT7u7NaL
         4yNeUEW7tTHKJY9++uHdvNDjtTzcrq91VikbZ6BDapjSUZc0wYE0pimUDIPdkIGpO6ND
         //ufN3+nY86knnQtiuvpOs3pXyqt8lpqT3ul5kyCQ7oatuQ2ct6XcHvLglE1B0mg5989
         9QqA==
X-Gm-Message-State: AOJu0Yy17om72QQmsJIckhxKiLSMN7VyHjcMccEch680aee/vj4oaFRe
	cr19ZEPsW6Mv4xZq0eVgBolq+ZxmzN3Eq84bWZAok6inBM9TD+1JuW1QHQ==
X-Gm-Gg: ASbGncv5THvUSmKPhkvxeIhrZb3KqhabRk65sk5v+6Gv9a/Z0NaGhxwWEkI8rBWgxkm
	EEZOQQMiExR4M6ZdYS9yOjmxjzoU539cS3eD/+0bOrDAprkr3/PBR3xfrgeYfPt1wstssmlRB1h
	WKDROk7twG9+M6GgbxiYylA5tpzxf7BiFTtFRM+qB0eLoxKIMH3q6VW0ok6MIOJX0QlDpmJHIOL
	Jkr9ecwhvrxS4VMZr11wyczzax2wJ2Or+lbCtIQNLsuKZHBqbg3PhSbcd2GUnt0nErt0E6SHG8M
	jphf2F6xELC/GBtoi//r9IiWnZg2UxbeYnt0+RqtUS0yLce0FrMTsebJNp3RPdJT
X-Google-Smtp-Source: AGHT+IF8pigxZSG7NKMUXgV1JQUZSawMCBajjWd3oUoHr9OtUQvcCz05jjzVpa2NMnqpnobMyBrtag==
X-Received: by 2002:a17:907:1b10:b0:ac3:8896:8c47 with SMTP id a640c23a62f3a-ac6fb1a69d4mr133188466b.47.1743035158530;
        Wed, 26 Mar 2025 17:25:58 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac696678277sm680714866b.174.2025.03.26.17.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 17:25:57 -0700 (PDT)
Message-ID: <7034ab1a-68e2-4cc3-9d2a-e0c6adf20ca9@gmail.com>
Date: Thu, 27 Mar 2025 02:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: RTL8812BU TX FIFO corruption (?) in USB 3 mode
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b69f6496-dc12-4662-84ac-aa62d0ceac3f@gmail.com>
 <91456392399d4bb5b7b96cbe35a6b17c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <91456392399d4bb5b7b96cbe35a6b17c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2025 03:44, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Hi,
>>
>> I ran into a problem with the RTL8812BU. If I load it a bit in USB 3
>> mode, like with "iperf3 -c 192.168.0.1 -R -t 60" the connection often
>> stops working. It may take a few tries. It still receives beacons but
>> the AP can't be pinged anymore.
>>
>> Looking at the registers with
>> "watch cat /sys/kernel/debug/ieee80211/phy*/rtw88/mac_2", I noticed
>> the high half of register 0x240 was steadily increasing.
>>
>> Register 0x240 is called REG_FIFOPAGE_INFO_5. The driver writes the
>> number of pages allocated to the public queue into the low half.
>> The high half indicates the number of pages currently available.
>> The number of available pages was steadily increasing, beyond the
>> total number of pages:
>>
>> 00000240  072b070b    0003fa00    0003fe00    0003fa60
>> 00000240  0737070b    0003fa00    0003fe00    0003fa60
>> 00000240  073b070b    0003fa00    0003fe00    0003fa60
>> 00000240  0741070b    0003fa00    0003fe00    0003fa60
>> 00000240  0741070b    0003fa00    0003fe00    0003fa60
>> 00000240  074f070b    0003fa00    0003fe00    0003fa60
>> 00000240  075d070b    0003fa00    0003fe00    0003fa60
>>
>> Normal values when the device is functional (and idle):
>>
>> 00000240  070b070b    0003fa00    0003fe00    0003fa60
>>
>> When register 0x240 has strange values, register 0x210
>> (REG_TXDMA_STATUS) has the value 5. Normally register 0x210 is 0.
>>
>> All this only happens in USB 3 mode. Everything is fine in USB 2 mode.
> 
> I checked with internal USB team. The USB 3 mode can only work on 5GHz,
> because electrical interference between USB 3 clock and WiFi 2.4 GHz
> band. Could you check if it works on 5GHz?
> 

Thank you for taking this to them.

It doesn't work on 5 GHz. I was already using my 5 GHz network on
channel 100.

>>
>> I tried to disable USB RX and TX aggregation, SUPPORTS_AMSDU_IN_AMPDU,
>> and TX_AMSDU. None of that helped.
>>
>> This problem happens also with this driver:
>> https://github.com/morrownr/88x2bu-20210702
>> and with v5.13.1.1-1-g6f2541ef2.20240507_COEX20220812-18317b7b.
> 
> By default, it only supports USB 2 mode. Have you changed the driver?
> 

I did not change the driver. I set the module parameter
rtw_switch_usb_mode to 1. It makes the driver switch to USB 3 mode.

I forgot to say that I also tested Windows 10 with the driver from
TP-Link (I think). I tried alternating upload tests and download
tests over and over, I left iperf3 running for many minutes. It was
very difficult to make it fail. I think only one time iperf3
reported 0 speed for a few seconds but it recovered by itself.
I don't know how to examine the hardware registers (0x210, 0x240)
in Windows, so I can't say for sure that the problem doesn't happen
there. But it looks much better than in Linux. It was definitely
in USB 3 mode, the speeds were 500-600 Mbps.

>> I see
>> the same strange values in register 0x240 in
>> /proc/net/rtl88x2bu/wlp3s0f3u4/mac_reg_dump.
>>
>> My test device is TP-Link Archer T3U Plus, with USB ID 2357:0138.
>> My system is Lenovo Ideapad 3 15ADA6 with AMD Athlon Gold 3150U CPU.
>>
>> Can this be fixed somehow? I saw the other drivers have some code in
>> rtw_sreset.c to power off and on the device when register 0x210 is
>> non-zero, but that seems suboptimal.


