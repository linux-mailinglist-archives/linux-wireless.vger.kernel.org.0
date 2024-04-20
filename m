Return-Path: <linux-wireless+bounces-6603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9455E8ABBF1
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0DDB20A69
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32B20304;
	Sat, 20 Apr 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fa/3oJK2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D951CD25
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713622143; cv=none; b=AlustSMkp1kWhOT1DwBfo9cmuogpAup6XNbgm9Qqso+VRPvb/X18bF/rRg6Zi2kD2UpUeNDVPXduGizsc9tlJtTVT3mz3zKA6TP1WGUOg4HsCOwpD/G/q/UxAPO5uYaWrFjQxg+RBhEpqxOzj18CQGpcgIPprtpkmetgFzAt1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713622143; c=relaxed/simple;
	bh=CQ9TOxDT53E+ODgLBzyBYUDSATjdnB9DCxtWlR3LOWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jejg1lz0h//Qgdicx7gZC722qoSnfw+dyO7yUR60YoH87yRhv6iLZFCBW2Zj5kMlExIxANIYMbpaRz8rClFrMdc0bakUjECmucIz4VM0WysUHTfWvSVbjCzD9hG53IKNpEj/ZJxKJXQvjj0C55LBMzco1v06xqS3uEt+VJos8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fa/3oJK2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51ae315bb20so715169e87.1
        for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713622140; x=1714226940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MgVP7bwsBg/Q1ktkX1toe/peQcmtS6Se8iElstUjkhk=;
        b=fa/3oJK2xmqKwSYm9J78eaE7Z86rQpqtNQ17CVM0w+sGZYURADDFRtczQN59sNk4iW
         Ti2enL+AKlfHBmYcnmxmsqkiMS4YQGX4UFA3SD08eYSSbpkvOaSW2+AA10QDB6pJYjJt
         Y7h02nO43FC2o3qo5C79FBAoT8lEwwosmnjorj+ZgY4/WvebPS4hKef00CpDomR/MxXZ
         cOOVwC5SVHnk3TLekk5hQn8yetsDOdAhRgWdGZw4aa38mjYofFql91lb2yFiu3Q4Xlcv
         JHYf8hikRDMEYh3onFfr4nhpPaZNB3VrDf3nOhl1fdqnjANieAqM0dSbcz6qcLLMppfJ
         RCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713622140; x=1714226940;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgVP7bwsBg/Q1ktkX1toe/peQcmtS6Se8iElstUjkhk=;
        b=i6nczJ2syl3r0L1qaXksaTbxbcMPk4ewIncC5oiSIpFV7uFZdVhGKEZY6wZZQJhHbY
         v3SMU6e6bIHO4I0O1BxueJ2sXMhL5RfYC/h/pmGHciNbPm9+TSp6ebiQZEe62mG3NKl5
         d50rcP7K9OiZCOMhMQE3bNEgf/ywaMbxse8rD/KzTy7rFBX4paYhGvl2m+1vzdG68jH1
         Y6btCFW8owdHpvqU6d7rV+cgIrJnhhN9Zo3UeMumZUUx6Yikr9LDXKGLh8pEZHAIj8hZ
         Pv6WAs/vBvFoiSq0JvXwFHaSaJZD+JEmNzxF8ElsX9bTF6XsCJRTjprE6KezOwooxao4
         ZFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTj02b2n7P99fVq1FRONPGMiqa2iYMZ4bwc9WKgy/aCYdBupZyIcFz/lFc3/YBRKBcvYsFIADIX5AzzuoKursJIDLCdxLAcfjllBX1feo=
X-Gm-Message-State: AOJu0Yz2uM9Zk532vNmnSzXRkuNek/Y4fZy4pYndr4MhAzhfSAZRVLl4
	YTRRmcoqvhIAkEVjPUrtdvvVFF0dfP31RYV+2H1ok3mS0HX3Mr7ACg013H9e
X-Google-Smtp-Source: AGHT+IH4dlOQAb1OfckkjkUmlvEKMdatc4+qFdeh6uwhrNDyh2x+CFJ3Fkuapf72040RPlsge97YdA==
X-Received: by 2002:a05:6512:210d:b0:51a:ece1:6ae6 with SMTP id q13-20020a056512210d00b0051aece16ae6mr737394lfr.51.1713622139287;
        Sat, 20 Apr 2024 07:08:59 -0700 (PDT)
Received: from [192.168.200.7] (p3ee2b231.dip0.t-ipconnect.de. [62.226.178.49])
        by smtp.gmail.com with ESMTPSA id w34-20020a0565120b2200b00518df6c9d07sm1150317lfu.24.2024.04.20.07.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 07:08:58 -0700 (PDT)
Message-ID: <c6e00544-dbde-4b59-8d43-912b04a3f824@message-id.googlemail.com>
Date: Sat, 20 Apr 2024 16:08:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9 iwlwifi regression: Thinkpad 480 no Wifi
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <8c3f3a43-ac65-4bd1-9563-cb8d9192b0ce@message-id.googlemail.com>
 <8fe50dcfc5159994c5976a406e27bb1df03ca0fb.camel@sipsolutions.net>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Content-Language: en-US
In-Reply-To: <8fe50dcfc5159994c5976a406e27bb1df03ca0fb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

Am 20.04.24 um 15:44 schrieb Johannes Berg:
> On Sat, 2024-04-20 at 09:44 +0200, Stefan Seyfried wrote:
>> Hello,
>>
>> I'm running a Thinkpad T480, lspci reports
>> 03:00.0 0280: 8086:24fd (rev 78)
>> Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
>> Subsystem: Intel Corporation Dual Band Wireless-AC 8265 [Windstorm Peak]
>>
>> Using 6.8 kernels, everything is fine (the first kernel I ever used on
>> this machine was 6.8.1 from openSUSE Tumbleweed).
>>
>> Since 6.9-rc1 (using precompiled SUSE Kernel-of-the-day), wireless just
>> does not work.
>>
>> Nothing suspicious in dmesg, NetworkManager does nothing and a manual
>>
>> mixi:~ # ip link set up dev wlp3s0
>> RTNETLINK answers: Invalid argument
> 
> I think you may need this fix:
> 
> https://lore.kernel.org/r/20240420154435.dce72db5d5e3.Ic40b454b24f1c7b380a1eedf67455d9cf2f58541@changeid

Yes, this fixes it (applied manually, just built iwlmvm, rebooted into 
6.9-rc4 and loaded the patched module => wifi is happy :-)

Thanks, saved my weekend :-)

-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman


