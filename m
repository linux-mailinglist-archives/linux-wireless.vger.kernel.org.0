Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA34A7CE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfFRRDs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 13:03:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:53941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbfFRRDs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 13:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560877421;
        bh=aqTleWwsrfaefT+OQLD/f60GNy2647CIgH7c/rLp3+g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XC8laOeVmYfQtxKJILlbzQYsaVSg+C39lmw36PcXWYmwo21v9X68Jwae3oKY2b+ap
         2uBCTl5+v1dNmuCGcF/uDxsMtkg49zEiaYNhlG5FoJOuVngXpKs1ppJ4Sjrrsop9C7
         vnHUpQFcgGIjlwZ0BdIAqWOSyJgHfGLe6W1KhkEs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZD0K-1htqQj0duW-00L1ff; Tue, 18
 Jun 2019 19:03:41 +0200
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Stanley Hsu <Stanley.Hsu@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Jouni Malinen <j@w1.fi>
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
 <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
 <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
 <d6bfe313-3aa7-82bb-dfac-25e6261dbf63@cypress.com>
 <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <ab26ac30-e49c-8712-f124-8cf996b32a76@gmx.net>
Date:   Tue, 18 Jun 2019 19:03:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:CkgjAuPISyKFHb0+q506bbXyaMF7zfIyuBv63T3UNZfOb5atM7G
 SFQaiU9RuOTi8CAFNRt5jV7CCBdfN+qWRrkCds1eaDRCfSBYEb3WyymPsXW/h49Ht/kbLKt
 5q1T54mMDU9FJOQK5b7eSgB4LF76rtoooMgEUFXP96BaPmAOfl5StJDKvEnDB8M1FoO7P0J
 Yhivap5kDNG4NvN39BpGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GaisVJwxpK0=:nmN4OA/RNoIU9ockryb+y4
 x5c2HTErxS4iL1UeAk6ZsX89gY4FlDaCwXJ7F68Tyu6lW0+PrAZNln9kHIzDdp97Ouog0lnhZ
 FgRTNSbBoDsT1a40oan4d0/7oaX9C62KZr0LSTikaB+83TOnk5tUVWSdvO2esK+e3zWhqeFxp
 0MidvnX7WX2jEmywhtF0iyRqhLuxsRRl42feF90RrtFEt2FEg0+ra1XDNRisdQVkqJCAEAkCm
 fy6UZYcp6mifhe119Yif7EWRDYBhn36hRJtqsaZwXfhQpxbH70PqvKCHfaBcCO212J+7Zy0xP
 8avWetq7uLOjDy2/qRZuDaXJlkTq9kvWiCtwWGj3DRa9+WCMLkKs9adBKxDeB60RXXSL5cG87
 rys/uqhdbOVIs2BysH6utOu9CzDTU19VPsPdu2HtDODUbCUicU/jNqZN+pbg0rOeUQtICiAkh
 ybToNboYL76iQwxkJgkPjSeuIVaD6LXmZCkIC52JKv/Crz1is016ayrdBHHddVO0/U5pmrLhp
 eacRifM9i8LAEgusRNW2qEXQu4SpcPaOlUhhYtV+POnv5R85wrBk7pKSPBbYyPpetl9HPVnlD
 VBNM9QurP1r/CSqJrU9CNoatK/zQLGgwl7PUbORAHSZlNHy4WhvmnbVKPvP/hls5lasN7PhBQ
 p73585zlarMTWT3WLMOL4i0TQ/t8s8zc4W6WW+TqsN86BA8A93KY7p+bULY0oPbJU48AwUrdS
 Y9Isxl9Z/6sP0oSUzPaU6iydu4lEwvajvG75lAi+q/SED5AmwYlYCpGIKV/sgCE7Ugoo23Xfd
 +/UuhPdQZJ80EWdLCky/LuOkIcbVO2bc8TXaumcYb51LPtGvTIuzYFz+co7qy9isoXVdpgvPa
 FyENMdbvjtF48cVdDJ07ofj0h5xRK330O/CpmAn4HSpiCQI2S+lJXNyll/YGpQ5367g+KegMb
 k1A1EEbDjM6d3Z0QxVj5+AWukJT7xrgudL9x447WtxDOQwXAcQzZV
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Am 18.06.19 um 10:27 schrieb Arend Van Spriel:
> + Jouni
>
> On 6/18/2019 7:33 AM, Chi-Hsien Lin wrote:
>>
>>
>> On 06/17/2019 10:33, Marcel Holtmann wrote:
>>> Hi Chi-hsien,
>>>
>>>>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>>>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>>>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA
>>>>>> side and a
>>>>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>>>>>
>>>>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>>>>>
>>>>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=3D1665608
>>>>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=3D202521
>>>>
>>>> Stefan,
>>>>
>>>> Could you please try the attached patch for your wpa_supplicant? We'l=
l
>>>> upstream if it works for you.
i've forward this patch to the Arch Linux board hoping someone else has
currently more time.
>>>
>>> I hope that someone is also providing a kernel patch to fix the
>>> issue. Hacking around a kernel issue in userspace is not enough. Fix
>>> the root cause in the kernel.
>>
>> Marcel,
>>
>> This is a kernel warning for invalid application PMK set actions, so th=
e
>> fix is to only set PMK to wifi driver when 4-way is offloaded. I think
>> Arend added the WARN_ON() intentionally to catch application misuse of
> =C2=A0> PMK setting.
>>
>> You may also remove the warnings with the attached patch, but let's see
>> what Arend says first.
Instead of removing the WARN_ON i suggest to replace it with a more user
friendly dev_warn().
>>
>>
>> Arend,
>>
>> Any comment?
>
> Hi Chi-Hsien, Marcel
>
> From the kernel side I do not see an issue. In order to use 802.1X
> offload the NL80211_ATTR_WANT_1X_4WAY_HS flag must be set in
> NL80211_CMD_CONNECT. Otherwise, NL80211_CMD_SET_PMK is not accepted.
> The only improvement would be to document this more clearly in the
> "WPA/WPA2 EAPOL handshake offload" DOC section in nl80211.h.

I missed to add my expectation as a user. At first i assume this new
behavior in wpa_supplicant 2.8 has been tested successful with at least
one Linux wifi driver. So i'm curious if all drivers behave that way?

Another point is that in my wpa_supplicant.conf i never enforced 802.1X
offload and i assume this feature is optional. So can't we do some kind
of fallback in this case?

Stefan

>
> As for the wpa_supplicant behavior it seemed a good idea to reuse the
> req_key_mgmt_offload parameter at the time, but it seems to bite each
> other. Maybe it is better to have a separate flag like
> 'req_handshake_offload'. Jouni, any thoughts on this?
>
> Regards,
> Arend
