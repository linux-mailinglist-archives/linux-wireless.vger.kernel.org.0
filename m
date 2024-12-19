Return-Path: <linux-wireless+bounces-16615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4C9F7C91
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71192188DA54
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE21BC58;
	Thu, 19 Dec 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT/4UXcj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B21E9B01
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615785; cv=none; b=ptd+jjFIVG14pypowZbmec1Jh9KqG+vhJe/czINncNq/uGEkeRYMKs3kDF5MrCv4apbngqIv0atyYde+zz8Me3YnPQlFdDUFNAgr1+j3j85fXAJ4IvGVcH47/aWtDa8Y93F+G7WSLID+zx5p4JUJ281y7JBBK1xsiyy/r1j5W98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615785; c=relaxed/simple;
	bh=1gp5Ng/XiOWkrTo4jAievkLIbaLor/bZb/U2F96Gh/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1oXVJ35dS/TuYpfIz7SikUZK4MxiHRzK6gKpY2/+/sLHeWFFk+0/990tK9pNDqjQdlrRUzq4mfrz5rZ31noVNSiQdI/SdgSPHNfsqegoMpctPfZAdNiRop1CDBqEiXFPivOCxOeS/qw5j+R/6Q6gPxz1u66T9JBO0wUFmfakFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT/4UXcj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso1538062a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734615782; x=1735220582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9PTUjWclIxgXoNSguOFh/GvXHlqXx/r0S+JWNFNBRg=;
        b=aT/4UXcjFWJtcut/pM4p3qcSExDweMmoHh5LXwMQfJBJ8sy2j99V3a9nHjbPeHJIXs
         +WyGiNxA06UwNj4MICwKijc6m7JMLekryKKTcKAWDTW8w4dg5pBoeNq1qAqEXlo57iOr
         DGaoYspZC4yXPsztya4iYg40HkIPfNnaTsDbIogsTc4ZBzl4ATn9ildSmUTlIMuz0ykk
         UXv8jI/il0bGhtMO43PCMO5IdigKmCmFr6l4SE1m+YKz0iC05XjatxccJxBbUWnExpxg
         Vw+jyqy6zBz94y6cL+bmebBBVieh9Vy0OFfXrhDJ/nWAyYyvku4dUZiHNZ0YSYHBOMDV
         +KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734615782; x=1735220582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9PTUjWclIxgXoNSguOFh/GvXHlqXx/r0S+JWNFNBRg=;
        b=SWknIY9UGFy3Dju+sFg8IK7kegjnQHTg4CemA+BF66vrrm1liKQGWeG8wcgS31sSXP
         0NeXxDcv9ninYwAq5Wg+gm3nLU7vNHQMDa8xCpjViIsxyRn3oCZ1Lo8bYXjYZXvPCRSn
         kQySQLffJ/2eoO+OOhTjUb/RkirxX2Dr4Npl3QUnoqESsF6tZPT4Qorjj/SPkOvvoLL9
         rEceCbVk1WbLNKEjaSfgn+DDjAra8lMSrOK3k9LsuniIVTjU4A1RB6KvJWvVfIBnoWxv
         Vg1QLASlUvb+FucsBWJE9yIXPEB+eaeP8RtFZP9197/S51yBjiptP5i/8steiW272wlI
         6RqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCMLt4f8VXalABFqZRud+cV1jGoswiQPpgHo6V0qporHIHroxOeuvd6/bgpBdTrDzsTK30YU24DpOjvLnC+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/crzANdh+eSsEjr/q5ZNr65iaX04m0Hq35nKfe8FQ66Wa5mK
	LSHISnz0TOwmM/D0aq8ke8V3/DAnpkcrvMaFOis6x34UyuF0jKI9
X-Gm-Gg: ASbGncucQxIVIf7ElqwjFgR3TfFkbTJAtf7IXlJUYmN0lD0jCE9Amfc8HY0lHkSEo5o
	PsiaSIlEcGZlMLuAE7UZOvVaYlJi1OmDID+t9+whL/zOas2K/9nRfgKck+NBfbH0qIqcRloCRKW
	QFIKh98mjb1ZTPzSjaEX5r4e/8+mfYjfJ5TkpdhdkkyXutIsga6Ux3k4kGYsOQucyjnnFBZp4z5
	9RjRpO3Ho2sZ24o0ajacAPg69Sj3j0WYGCeE6jIU5gz+zjmmoDs4a/F1GkL
X-Google-Smtp-Source: AGHT+IGQFQTsAoNRZZPBSG+6FZ6UgjmfooqhBpoq887qSHAaXE3BCUVrIAxx8WXJVoK/dY4NOLmP+Q==
X-Received: by 2002:a17:90b:548c:b0:2ef:e063:b3f8 with SMTP id 98e67ed59e1d1-2f4435abac6mr5678995a91.7.1734615781476;
        Thu, 19 Dec 2024 05:43:01 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26d5c7sm3284632a91.45.2024.12.19.05.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 05:43:00 -0800 (PST)
Message-ID: <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com>
Date: Thu, 19 Dec 2024 05:42:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: KeithG <ys3al35l@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 Denis Kenzior <denkenz@gmail.com>
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
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
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com>
 <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 12/19/24 5:38 AM, KeithG wrote:
> On Thu, Dec 19, 2024 at 6:46 AM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Keith,
>>
>> On 12/18/24 5:46 PM, KeithG wrote:
>>> On Wed, Dec 18, 2024 at 8:10 AM KeithG <ys3al35l@gmail.com> wrote:
>>>> On Wed, Dec 18, 2024 at 4:21 AM Arend van Spriel
>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>> On 12/18/2024 1:21 AM, KeithG wrote:
>>>>>> On Tue, Dec 17, 2024 at 7:47 AM Arend van Spriel
>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>
>>>>>>> On 12/17/2024 1:13 AM, KeithG wrote:
>>>>>>>> On Mon, Dec 16, 2024 at 1:50 PM Arend van Spriel
>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>> On 12/16/2024 1:21 PM, KeithG wrote:
>>>>>>>>>> On Mon, Dec 16, 2024 at 3:47 AM Arend van Spriel
>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>>> On 12/16/2024 10:43 AM, Arend van Spriel wrote:
>>>>>>>>>>>> On 12/16/2024 1:17 AM, KeithG wrote:
>>>>>>>>>>>>> On Sun, Dec 15, 2024 at 11:33 AM Arend Van Spriel
>>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>>>>>> On December 15, 2024 5:08:12 PM KeithG <ys3al35l@gmail.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Sun, Dec 15, 2024 at 6:12 AM Arend van Spriel
>>>>>>>>>>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>>>>>>>>>>> On 12/14/2024 2:34 PM, KeithG wrote:
>>>>>>>>>>>>>>>>> Arend,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I looked through the info where I got the latest firmware:
>>>>>>>>>>>>>>>>> https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-
>>>>>>>>>>>>>>>>> A-class-Linux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
>>>>>>>>>>>>>>>>> https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/
>>>>>>>>>>>>>>>>> Cypress-Linux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
>>>>>>>>>>>>>>>>> and did not find anything, but I really do not know what I am
>>>>>>>>>>>>>>>>> looking for.
>>>>>>>>>>>>>>>> I think I had a bit more luck and maybe found the needle. I sent out
>>>>>>>>>>>>>>>> another RFT patch which hopefully gets rid of the BCME_BADLEN error.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>> Arend
>>>>>>>>>>>>>>> Arend,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Can you send me a link to that patch? I want to try it.
>>>>>>>>>>>>>> Hmm. I explicitly sent it to you, but here is a link to patchwork:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://patchwork.kernel.org/project/linux-wireless/
>>>>>>>>>>>>>> patch/20241215120401.238320-1-arend.vanspriel@broadcom.com/
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> You can apply it on top of the other 3 patches.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>> Arend
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks! I got it.
>>>>>>>>>>>>> I am building now and have tried to apply what I think are the correct
>>>>>>>>>>>>> patches. They do not apply cleanly and I had to hand edit things. My
>>>>>>>>>>>>> guess is I messed something up.
>>>>>>>>>>>>> I will see what happens when I reboot. It'll take a few hours to build
>>>>>>>>>>>>> on my Pi4 then for me to install it on the 3b+ to test.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I hope I understand which are the '3 other' patches.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This is the one I got from your link:
>>>>>>>>>>>>> RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
>>>>>>>>>>>>>
>>>>>>>>>>>>> These are what I understand are the '3 other patches'
>>>>>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-
>>>>>>>>>>>>> firmware-events.patch.diff
>>>>>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>>>>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-
>>>>>>>>>>>>> station-mode.patch.diff
>>>>>>>>>>>>>
>>>>>>>>>>>>> If they are not correct could you send me links to them and I'll try
>>>>>>>>>>>>> again.
>>>>>>>>>>>> You got it right. Kuddos.
>>>>>>>>>>> Ignored my spelling checker, but apparently it should be "kudos".
>>>>>>>>>>> Another lesson learned today.
>>>>>>>>>>>
>>>>>>>>>>> Regards,
>>>>>>>>>>> Arend
>>>>>>>>>> Arend,
>>>>>>>>>>
>>>>>>>>>> Thanks for the confirmation. My attempt at a hand edit to apply the
>>>>>>>>>> rejected portions resulted in a failed build with the current RPiOS
>>>>>>>>>> kernel in the git repo:
>>>>>>>>>> # uname -a
>>>>>>>>>> Linux jackrune 6.6.64-v8+ #6 SMP PREEMPT Sun Dec 15 23:55:30 CST 2024
>>>>>>>>>> aarch64 GNU/Linux
>>>>>>>>>>
>>>>>>>>>> When I try to apply them, I get this:
>>>>>>>>>> $ patch -Np1 -i
>>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events.patch.diff
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>>>>> Hunk #1 FAILED at 6752.
>>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>>>>>>>>>> Hunk #1 succeeded at 524 (offset 33 lines).
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
>>>>>>>>>> Hunk #1 FAILED at 1359.
>>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>>>>>>>>>> Hunk #1 succeeded at 74 (offset -1 lines).
>>>>>>>>>> Hunk #2 succeeded at 336 (offset -70 lines).
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
>>>>>>>>>> Hunk #1 FAILED at 15.
>>>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -9 lines).
>>>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.rej
>>>>>>>>>> $ patch -Np1 -i RFT-v2-
>>>>>>>>>> RFT-v2-1-3-wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events.patch.diff
>>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station-mode.patch.diff
>>>>>>>>>> $ patch -Np1 -i
>>>>>>>>>> RFT-v2-2-3-wifi-brcmfmac-make-per-vendor-event-map-const.patch.diff
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
>>>>>>>>>> Hunk #1 FAILED at 337.
>>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
>>>>>>>>>> $ patch -Np1 -i
>>>>>>>>>> RFT-v2-3-3-wifi-brcmfmac-cyw-support-external-SAE-authentication-in-station-mode.patch.diff
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>>>>> Hunk #1 succeeded at 75 (offset 1 line).
>>>>>>>>>> Hunk #2 FAILED at 1940.
>>>>>>>>>> Hunk #3 FAILED at 2158.
>>>>>>>>>> Hunk #4 FAILED at 2216.
>>>>>>>>>> Hunk #5 succeeded at 5522 (offset 22 lines).
>>>>>>>>>> Hunk #6 succeeded at 5697 (offset 90 lines).
>>>>>>>>>> Hunk #7 succeeded at 6126 (offset 125 lines).
>>>>>>>>>> Hunk #8 succeeded at 7596 with fuzz 1 (offset 255 lines).
>>>>>>>>>> Hunk #9 FAILED at 7647.
>>>>>>>>>> 4 out of 9 hunks FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
>>>>>>>>>> Hunk #3 succeeded at 243 (offset 15 lines).
>>>>>>>>>> Hunk #4 FAILED at 244.
>>>>>>>>>> Hunk #5 succeeded at 507 (offset 18 lines).
>>>>>>>>>> 1 out of 5 hunks FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
>>>>>>>>>> Hunk #1 FAILED at 8.
>>>>>>>>>> Hunk #2 FAILED at 39.
>>>>>>>>>> Hunk #3 FAILED at 49.
>>>>>>>>>> 3 out of 3 hunks FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
>>>>>>>>>> Hunk #1 FAILED at 42.
>>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
>>>>>>>>>> Hunk #1 succeeded at 32 with fuzz 2 (offset 1 line).
>>>>>>>>>> Hunk #2 succeeded at 60 with fuzz 1 (offset 2 lines).
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>>>>>>>>>> Hunk #1 FAILED at 450.
>>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h
>>>>>>>>>> Hunk #1 FAILED at 94.
>>>>>>>>>> 1 out of 1 hunk FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h.rej
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
>>>>>>>>>> Hunk #1 FAILED at 15.
>>>>>>>>>> Hunk #2 succeeded at 47 with fuzz 1 (offset -11 lines).
>>>>>>>>>> 1 out of 2 hunks FAILED -- saving rejects to file
>>>>>>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h.r
>>>>>>>>>> $ patch -Np1 -i RFT-brcmfmac-Fix-structure-size-for-WPA3-external-SAE.diff
>>>>>>>>>> patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h
>>>>>>>>>>
>>>>>>>>>> Is there another missing patch?
>>>>>>>>>>
>>>>>>>>>> The kernel for the RPi is at this commit:
>>>>>>>>>> commit 80533a952218696c0ef1b346bab50dc401e6b74c (HEAD -> rpi-6.6.y,
>>>>>>>>>> origin/rpi-6.6.y, origin/HEAD)
>>>>>>> So what repository does origin refer to. Can you share the URL?
>>>>>>>
>>>>>>> I will check if I posted any patches between 6.6 and 6.10+ Get back to
>>>>>>> this later o
>>>>>>>
>>>>>>> Regards,
>>>>>>> Arend
>>>>>> Arend,
>>>>>>
>>>>>> I am using the RaspberryPi repo:
>>>>>> https://github.com/raspberrypi/linux
>>>>> I was afraid you would say that. So we need to determine what brcmfmac
>>>>> patches are in there compared to upstream kernel. So checking the code I
>>>>> think you should apply only the "Fix-structure-size" patch to
>>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h. Let me
>>>>> know if that works for you.
>>>>>
>>>>> Gr. AvS
>>>> Arend,
>>>>
>>>> That patch applied to the file in the folder you suggested. I am
>>>> building a kernel now and will see any changes this evening. Thanks
>>>> for the help.
>>>>
>>>> Regards,
>>>>
>>>> Keith
>>> Arend,
>>>
>>> Thanks for the guidance and help.
>>>
>>> I tried with the patched kernel and was unable to connect. The 2
>>> attached files are the log with brcmfmac debugging and iwd debugging
>>> turned o. and the other is an iwmon capture of an attempt to connect.
>>> This time, though, I get no IP address at all. Just an error out when
>>> I try to connect using iwctl. I get:
>>>
>>> [iwd]# station wlan0 connect deskSAE
>>> Type the network passphrase for deskSAE psk.
>>> Passphrase: *********
>>> Operation failed
>>> NetworkConfigurationEnabled: enabled
>>> StateDirectory: /var/lib/iwd
>>> Version: 3.1
>>> This is with kernel:
>>> Linux jackrune 6.6.66-v8+ #7 SMP PREEMPT Wed Dec 18 10:18:01 CST 2024
>>> aarch64 GNU/Linux
>>> and this firmware:
>>> Dec 18 19:37:08 jackrune kernel: brcmfmac: brcmf_fw_alloc_request:
>>> using brcm/brcmfmac43455-sdio for chip BCM4345/6
>>> Dec 18 19:37:08 jackrune kernel: usbcore: registered new interface
>>> driver brcmfmac
>>> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_process_txcap_blob:
>>> no txcap_blob available (err=-2)
>>> Dec 18 19:37:09 jackrune kernel: brcmfmac: brcmf_c_preinit_dcmds:
>>> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
>>> (be70ab3 CY) FWID 01-95efe7fa
>> Even closer this time. I've just sent a patch to the IWD mailing list.
>> Please try that along with Arend's kernel patch.
>>
>> Thanks,
>>
>> James
>>
>>> Keith
> James,
>
> It worked. I built iwd then tried to connect via iwctl and it
> connected to a WPA3 AP. I got an IP and I can ping the AP from the
> RPi.! It is a first! Woot Woot!
>
> [iwd]# station wlan0 connect deskSAE
>                                 Available networks
> --------------------------------------------------------------------------------
>        Network name                      Security            Signal
> --------------------------------------------------------------------------------
>        deskSAE                           psk                 ****
>
> Type the network passphrase for deskSAE psk.
> Passphrase: *********
>
> When I go to connman, it shows connected and I can ping.
>
> (clear out configs and reboot)
> When I tried from connmanctl it also connects! Seems with this patch
> to iwd and Arend's patch to the driver that WPA3 now works with RPis
>
> I had to apply Arend's patch to the 6.6.y source which has the
> brcm80211 structured a bit differently and the file to patch is in a
> different folder. the patch, corrected for 6.6.y, is attached.

Great! That's good to hear. It took a while but glad its finally 
working. We'll get that patch to IWD upstreamed, or at least some 
version of it. And thanks Arend for providing the support on the kernel 
side of things.

Thanks,

James

>
> Keith

