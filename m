Return-Path: <linux-wireless+bounces-16606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 172EA9F7BC4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E577189564D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A4223E69;
	Thu, 19 Dec 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX1ygIFH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62931FA8C2
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612371; cv=none; b=QkX40bHGq9IEBEhuby2q2LaSg7opKv209oONEQqzIsRaKezj1PA5fmVCZKC58mmr1HgTiUsKqri7zBhXFnuK44AF0pWiWTIDCAzXvWig3cIP8Bum0u6ngRs2GtWKewFt4YuncKcjK2XOuEXzrcVxBgIXgaGod/B8IX8Oa4xqozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612371; c=relaxed/simple;
	bh=Z2y3+nX6PYaeY2PKKzmEG8TmQm//i+Wu6AcB+EyOX60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvEqFJTe4WRhalelImvBG+BoOoSIR6KKcPEQfU086IYrr00dbtrGFt6Vgt4fXsZ+Iynu/DFEuV13k0oAouEpJ9d9HMBqzuJ9rMiRqx6JzQRlPmnuMdwcBuNg0iw2Sj4cxj4a4xrpHL1UTAZERKxkh6yxRTr5EH0WB21wx1RS/UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX1ygIFH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728e1799d95so897610b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 04:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734612369; x=1735217169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9i7sU9vTfGCO+wAqUAkwlNVJXzTKljVo4fvWJFo3034=;
        b=DX1ygIFHrmNYvZtjq0A4BZ5e0+mDDzE2BzQSiubm+8ri7e7UZk0lrW64JGlRM4SKSe
         e0/gLGL4gdLOujA7MVGOh40S5Dvrey31sbblno0Dd1FXv6a6+k7EwgxlIqFXtLKd04e0
         UbW8XGE6TNTmRtCbailj2agFJL6BgX7q78o43VG0QlueUFOrvNu+Tqqy1s8T9AtC+phh
         S3UkdFxFYPXgo/77bP9vuaRgmsIvA2VVynOpj99zir+a8RuPi3IyagVxNyOe1gimSPhg
         NobDUfM0tRTMlFsRee6ZCUA3I1qFqnjXWcV13lgPs3kWn+pH7lQ7HtU2WHT4693mX8/K
         5H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734612369; x=1735217169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9i7sU9vTfGCO+wAqUAkwlNVJXzTKljVo4fvWJFo3034=;
        b=WYhvgfBm1dqEJGhVj3FDQ8jwsopBILd/jy3jwIwVr1EtzDSRWINVeAl6AwFIaVz02U
         TMjaE//JKxbJNtRRfeRQvyUZ/q5JmhmFcrQ4GFu4qHOUAyOsPBI6PPwgsLw9nOfyaoRF
         4Io+h+acjnm0pxnVSbLvsEiW2EhsUWYYYF3NZ9oL0hG+goSZDvH8P9zG7o89ldTcfN1U
         BcnEQ7Atan+lng2mWoDjPwwxkWaVbcz+AH54wOyyiAMHU709FCNwPY8M1j3qPFfSJz2W
         bPdgeAmGmIErUbnErk16+ZgEpv//ZZHmvg3GsnMUmc0WxB4dt0qdHmgYfEBrd8d/5riT
         FAgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCCX7FYizVAFrubt9MA1BBendIje5uFA633sobiPQYSs1+DfWZXe167ZGU8YgJpzR1CNfQRPq0WzZxqHZMtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHIlImUHfW6DHtGJddHx+TRlPa9chqry46uSoWliUBLiZ8dko
	hQVQ2gMvL2SmqvDoAh0/diH2Cbr8pYGFxINjP84+0Jm67pyC2flH
X-Gm-Gg: ASbGnctua1pgRNVZQn1359tSjTub58htodKxhvlJCuH/3+wXCz/eJ8IdPKxe1E3CTiL
	jtD75KdZFAPTLtLn/4wElYxVhvj9OnZyEjpYXskdK8lxXxxsWejKcyzUIM5bXieSNczA/337brB
	HZlPMEw+zxAsXmPBe+h4M4rT8Mm1WZ/fbJEaVjYIVU0LVfSgjW7sKzzdqHF9r5RkVqiuIyOyVvR
	Tk4jeHVDO7yZDCEqUPPuDuF/yifApzMyWB23/LmgqURimbrRgUz1iXoyWss
X-Google-Smtp-Source: AGHT+IEj2YyT3V51rPmu44MAMYhiHSxZeb093lutmfKdhnCYGnp0zc+E7WHXMT6siDazG5Es5REWgg==
X-Received: by 2002:a05:6a20:3d88:b0:1e1:b023:6c98 with SMTP id adf61e73a8af0-1e5b482147emr11143365637.26.1734612369040;
        Thu, 19 Dec 2024 04:46:09 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad834cecsm1196722b3a.70.2024.12.19.04.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 04:46:08 -0800 (PST)
Message-ID: <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com>
Date: Thu, 19 Dec 2024 04:46:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: KeithG <ys3al35l@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 Denis Kenzior <denkenz@gmail.com>
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <21a81894-2e1e-440b-b7ea-27660fa08d9d@broadcom.com>
 <CAG17S_O5K4Uh2c6xqph5sUZe8gMjhD3z4FDkSSQ0dhCuZA6aug@mail.gmail.com>
 <193cb61e210.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_P+cOQMpQda00JTCCKEB6MpPE4X2i8mRrEaM-n5YKdpNg@mail.gmail.com>
 <14ec6009-7b91-4a25-9943-f63da91d8c41@broadcom.com>
 <caa186d8-1e07-421d-a127-7bb6482ac704@broadcom.com>
 <CAG17S_N0V=_Es0C7wA3fPu2MrBKBM7tEHRXOnVGWiUSxPucaRQ@mail.gmail.com>
 <ec23f0d9-a23c-4684-b0b6-a89141c5ec37@broadcom.com>
 <CAG17S_PmXNP2bdUU5ErQd-N2jyScqvfKTFsnWgADb3uhqpBsZA@mail.gmail.com>
 <65e4975d-2234-44d6-bdd0-a679df2b1c66@broadcom.com>
 <CAG17S_OAPEWsr61cBA1qfNhFst-mYK5a2_VrCZVZhdd-KVM9cw@mail.gmail.com>
 <c6e8ab71-d1e3-41a1-925c-9013f5a87f12@broadcom.com>
 <CAG17S_MoZDbu1vSt+=80xs+Cje_PPFhFwPxmWDUeNPJ9qRZ6bw@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 12/18/24 5:46 PM, KeithG wrote:
> On Wed, Dec 18, 2024 at 8:10 AM KeithG <ys3al35l@gmail.com> wrote:
>> On Wed, Dec 18, 2024 at 4:21 AM Arend van Spriel
>> <arend.vanspriel@broadcom.com> wrote:
>>> On 12/18/2024 1:21 AM, KeithG wrote:
>>>> On Tue, Dec 17, 2024 at 7:47 AM Arend van Spriel
>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>
>>>>>
>>>>> On 12/17/2024 1:13 AM, KeithG wrote:
>>>>>> On Mon, Dec 16, 2024 at 1:50 PM Arend van Spriel
>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>> On 12/16/2024 1:21 PM, KeithG wrote:
>>>>>>>> On Mon, Dec 16, 2024 at 3:47 AM Arend van Spriel
>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
>>>>>>>>>> On 12/16/2024 1:17 AM, KeithG wrote:
>>>>>>>>>>> On Sun, Dec 15, 2024 at 11:33 AM Arend Van Spriel
>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> On Sun, Dec 15, 2024 at 6:12 AM Arend van Spriel
>>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
>>>>>>>>>>>>>>> Arend,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I looked through the info where I got the latest firmware:
>>>>>>>>>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-
>>>>>>>>>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
>>>>>>>>>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/
>>>>>>>>>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
>>>>>>>>>>>>>>> and did not find anything, but I really do not know what I am
>>>>>>>>>>>>>>> looking for.
>>>>>>>>>>>>>> I think I had a bit more luck and maybe found the needle. I sent out
>>>>>>>>>>>>>> another RFT patch which hopefully gets rid of the BCME_BADLEN error.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>> Arend
>>>>>>>>>>>>> Arend,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Can you send me a link to that patch? I want to try it.
>>>>>>>>>>>> Hmm. I explicitly sent it to you, but here is a link to patchwork:
>>>>>>>>>>>>
>>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/
>>>>>>>>>>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
>>>>>>>>>>>>
>>>>>>>>>>>> You can apply it on top of the other 3 patches.
>>>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>> Arend
>>>>>>>>>>>>
>>>>>>>>>>> Thanks! I got it.
>>>>>>>>>>> I am building now and have tried to apply what I think are the correct
>>>>>>>>>>> patches. They do not apply cleanly and I had to hand edit things. My
>>>>>>>>>>> guess is I messed something up.
>>>>>>>>>>> I will see what happens when I reboot. It'll take a few hours to build
>>>>>>>>>>> on my Pi4 then for me to install it on the 3b+ to test.
>>>>>>>>>>>
>>>>>>>>>>> I hope I understand which are the '3 other' patches.
>>>>>>>>>>>
>>>>>>>>>>> This is the one I got from your link:
>>>>>>>>>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
>>>>>>>>>>>
>>>>>>>>>>> These are what I understand are the '3 other patches'
>>>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-
>>>>>>>>>>> firmware-events.patch.diff
>>>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-
>>>>>>>>>>> station-mode.patch.diff
>>>>>>>>>>>
>>>>>>>>>>> If they are not correct could you send me links to them and I'll try
>>>>>>>>>>> again.
>>>>>>>>>> You got it right. Kuddos.
>>>>>>>>> Ignored my spelling checker, but apparently it should be "kudos".
>>>>>>>>> Another lesson learned today.
>>>>>>>>>
>>>>>>>>> Regards,
>>>>>>>>> Arend
>>>>>>>> Arend,
>>>>>>>>
>>>>>>>> Thanks for the confirmation. My attempt at a hand edit to apply the
>>>>>>>> rejected portions resulted in a failed build with the current RPiOS
>>>>>>>> kernel in the git repo:
>>>>>>>> # uname -a
>>>>>>>> Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30 CST 2024
>>>>>>>> aarch64 GNU/Linux
>>>>>>>>
>>>>>>>> When I try to apply them, I get this:
>>>>>>>> $ patch -Np1 -i
>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events.patch.diff
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>>> Hunk #1 FAILED at 6752.
>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>>>>>>> Hunk #1 succeeded at 524 (offset 33 lines).
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>>>>>>>> Hunk #1 FAILED at 1359.
>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>>>>>>>> Hunk #1 succeeded at 74 (offset -1 lines).
>>>>>>>> Hunk #2 succeeded at 336 (offset -70 lines).
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
>>>>>>>> Hunk #1 FAILED at 15.
>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
>>>>>>>> $ patch -Np1 -i RFT-v2-
>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events.patch.diff
>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station-mode.patch.diff
>>>>>>>> $ patch -Np1 -i
>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
>>>>>>>> Hunk #1 FAILED at 337.
>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
>>>>>>>> $ patch -Np1 -i
>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station-mode.patch.diff
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>>> Hunk #1 succeeded at 75 (offset 1 line).
>>>>>>>> Hunk #2 FAILED at 1940.
>>>>>>>> Hunk #3 FAILED at 2158.
>>>>>>>> Hunk #4 FAILED at 2216.
>>>>>>>> Hunk #5 succeeded at 5522 (offset 22 lines).
>>>>>>>> Hunk #6 succeeded at 5697 (offset 90 lines).
>>>>>>>> Hunk #7 succeeded at 6126 (offset 125 lines).
>>>>>>>> Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
>>>>>>>> Hunk #9 FAILED at 7647.
>>>>>>>> 4 out of 9 hunks FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
>>>>>>>> Hunk #3 succeeded at 243 (offset 15 lines).
>>>>>>>> Hunk #4 FAILED at 244.
>>>>>>>> Hunk #5 succeeded at 507 (offset 18 lines).
>>>>>>>> 1 out of 5 hunks FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
>>>>>>>> Hunk #1 FAILED at 8.
>>>>>>>> Hunk #2 FAILED at 39.
>>>>>>>> Hunk #3 FAILED at 49.
>>>>>>>> 3 out of 3 hunks FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
>>>>>>>> Hunk #1 FAILED at 42.
>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
>>>>>>>> Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
>>>>>>>> Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>>>>>>>> Hunk #1 FAILED at 450.
>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
>>>>>>>> Hunk #1 FAILED at 94.
>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
>>>>>>>> Hunk #1 FAILED at 15.
>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.r
>>>>>>>> $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>>>>>>>
>>>>>>>> Is there another missing patch?
>>>>>>>>
>>>>>>>> The kernel for the RPi is at this commit:
>>>>>>>> commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi-6.6.y,
>>>>>>>> origin/rpi-6.6.y, origin/HEAD)
>>>>> So what repository does origin refer to. Can you share the URL?
>>>>>
>>>>> I will check if I posted any patches between 6.6 and 6.10+ Get back to
>>>>> this later o
>>>>>
>>>>> Regards,
>>>>> Arend
>>>> Arend,
>>>>
>>>> I am using the RaspberryPi repo:
>>>> https://github.com/raspberrypi/linux
>>> I was afraid you would say that. So we need to determine what brcmfmac
>>> patches are in there compared to upstream kernel. So checking the code I
>>> think you should apply only the "Fix-structure-size" patch to
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h. Let me
>>> know if that works for you.
>>>
>>> Gr. AvS
>> Arend,
>>
>> That patch applied to the file in the folder you suggested. I am
>> building a kernel now and will see any changes this evening. Thanks
>> for the help.
>>
>> Regards,
>>
>> Keith
> Arend,
>
> Thanks for the guidance and help.
>
> I tried with the patched kernel and was unable to connect. The 2
> attached files are the log with brcmfmac debugging and iwd debugging
> turned o. and the other is an iwmon capture of an attempt to connect.
> This time, though, I get no IP address at all. Just an error out when
> I try to connect using iwctl. I get:
>
> [iwd]# station wlan0 connect deskSAE
> Type the network passphrase for deskSAE psk.
> Passphrase: *********
> Operation failed
> NetworkConfigurationEnabled: enabled
> StateDirectory: /var/lib/iwd
> Version: 3.1
> This is with kernel:
> Linux jackrune 6.6.66-v8+ #7 SMP PREEMPT Wed Dec 18 10:18:01 CST 2024
> aarch64 GNU/Linux
> and this firmware:
> Dec 18 19:37:08 jackrune kernel: brcmfmac: brcmf_fw_alloc_request:
> using brcm/brcmfmac43455-sdio for chip BCM4345/6
> Dec 18 19:37:08 jackrune kernel: usbcore: registered new interface
> driver brcmfmac
> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_process_txcap_blob:
> no txcap_blob available (err=-2)
> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_preinit_dcmds:
> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> (be70ab3 CY) FWID 01-95efe7fa

Even closer this time. I've just sent a patch to the IWD mailing list. 
Please try that along with Arend's kernel patch.

Thanks,

James

>
> Keith

