Return-Path: <linux-wireless+bounces-6713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125D8AE361
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88723B21E95
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FE7D3E3;
	Tue, 23 Apr 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+DtIO96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D897BB19
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870378; cv=none; b=tla+ElJFwZ9cVyo4/fk/7QpG8n+M6SL04F1o/bETdHuB5V11SZC3r5+sb+iB3hN9GsSMGF2Q/SM6cyt4BMSHXzmfGCEfKcewfEFz41OE3QBliV7+Vt3FEwSjsC/YWRt+NFxT9PbPmVm6Ug4nkb/N3VWYZ2cLazTGDHuLcd2xvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870378; c=relaxed/simple;
	bh=+NlcJltyE83VIE3KB2EX8PPq1Vb0hWvgLHugQDq8ff0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqS3R3dOaWQCn90Vd16Uw+u8SxaJEJpmof4JFBWBND7T1O0CQEhBjZLsIbG+Rt9KGBz5bXuXxs9g3SxMPC/JpSkgUc/LIfzeeIdiYSczmj7cPtzYgu+F2lrHqrh0dPTJbgIyE8v9h2sz1rRdA84q4Tft/20cdMvXq6ZZlmr1lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+DtIO96; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5200afe39eso603794866b.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713870376; x=1714475176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Inp/UEu3xOIHeD6jpiR508FFw8sFX8psh5ZxVd98CZY=;
        b=a+DtIO96wkK0EkcQhAPod23QBhej8JvT9715UQjUrp5sFhiFr+GV1G+BCKavMqXVCI
         crbIKIRyY1NSz7DWT6AZvAGNKLJgsyqedgcXuoUq1tTZJpRCQc4fOiE17naJsiyxYfTj
         XLJ6f8MMR/kZivP+oxxb9KbByCd4n6K9ZxIPaPGbtcTMe/6wgl4Ek56E5qfR5I9oYWsv
         3WgL6tChh2wC5nkN3AtLJeApuY8Fcxs8aiQQWWrI8d5pUEnQPbvVroFZkbkFYVwn5K0f
         NxIiqf3guq8Dnn8+5dfSCpCABmKmr4ZXceIY7ie4jswrsF0C/lNKxd5GOezE7U4UC9b1
         gApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870376; x=1714475176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Inp/UEu3xOIHeD6jpiR508FFw8sFX8psh5ZxVd98CZY=;
        b=eaAE6szl0KhiwBfoUy6w7S4rZ5lw8nB+UDoSQG8j5KEE3mvJFp6KbbLr/+ZAeBSdb4
         COXyudwSoMLvgWe729rcOe59snmXNFQFPMtLSW8BIboIy3Ee1MozjRXxpbr595VAL5H3
         I381Q/4DnI85iJ7IiDuEMZCfgYiTOA2zhdoUA6wQNf1ZDQQTZ1hNeTd3oCnme4SjChSB
         X+o0L/BNfOvs6llLD36OaFVryo87XZ1RI1VJsAwPu3qVSbbWiAV2xpzCbIobByxyCJ52
         FmGYxKnbWMTKQi13vHJh13XDyJFlsMQ7sehofCUDOvJFff69bwAUNVzbc1b/1JcdTIzq
         5yCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdmC2C8HDLwb7mnP76a7Bku+lTXeku1lLJogLOzjygX55xE2lqslMbz2/1jQwd5iTrxvtrqTZyZO6j23H7C1RtAiN3cTAYN59HyCF7WZU=
X-Gm-Message-State: AOJu0Yx7t2/iixKq/yADZqJgFoeWWT2gwhAsqG1oQxOmXypsQlnfFm7c
	ae9t8x4mFFSq8ueLiaH5cqdvHNCVzIu4WvitQewJvom61ICSqBmNmMdO8BL/
X-Google-Smtp-Source: AGHT+IEGEFBqU9yJiupbnFZ8APim7tEVHTE4pywBOk0V5w38uo7r+nJhCBTl8NbeJoEX1xRbF8hRpQ==
X-Received: by 2002:a17:906:240a:b0:a55:ba01:7cf8 with SMTP id z10-20020a170906240a00b00a55ba017cf8mr4625787eja.40.1713870373909;
        Tue, 23 Apr 2024 04:06:13 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b00a46a2779475sm6874469ejk.101.2024.04.23.04.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:06:13 -0700 (PDT)
Message-ID: <937ed41e-6915-426b-8098-01e95c8554c0@gmail.com>
Date: Tue, 23 Apr 2024 14:06:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <459a193c-ce2e-4b89-827c-ff6721c470e0@gmail.com>
 <4e7bb78f7dad4383bc98f4a94a2c9b48@realtek.com>
 <509ded5b-6b31-4750-9f87-4d080ea4f71a@gmail.com>
 <054791df5141422fb0f8220eaeb66ff3@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <054791df5141422fb0f8220eaeb66ff3@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/04/2024 03:48, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 22/04/2024 05:55, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
>>>> @@ -0,0 +1,9 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Copyright(c) 2009-2012  Realtek Corporation.*/
>>>> +
>>>> +#include "../wifi.h"
>>>> +#include <linux/module.h>
>>>> +
>>>> +MODULE_AUTHOR("Realtek WlanFAE <wlanfae@realtek.com>");
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_DESCRIPTION("Realtek 8192D 802.11an common routines");
>>>
>>> Not sure why you emphasize '802.11an' instead of just '802.11n'.
>>>
>>>
>>
>> I saw somewhere a dual-band chip described as 802.11an.
>> It seemed like a good idea. Should I change it?
> 
> 
> I'm not sure what '802.11an' defines, but this old chip should not support that.
> Then, maybe '802.11an' here means '802.11a/802.11n', but I still don't know the
> relation with dual-band chip.
> 
> FYI:
> 802.11a: 5GHz band, CCK/OFDM
> 802.11b: 2GHz band, CCK
> 802.11g: 2GHz band, CCK/OFDM
> 802.11n: 2/5GHz bands, HT
> 

Ohh, right, there is probably something officially called
"802.11an". I will change it back then.

