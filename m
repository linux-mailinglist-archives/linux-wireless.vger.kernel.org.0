Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C22F4D8C7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfFTSBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 14:01:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:40007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfFTSBk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 14:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561053693;
        bh=q4t3XhZJQP+3zneHfXvORcFzZWMLgasYjwCYVRo/H9c=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=MmMpjIR6eNhTKPYu7C/gYjJWOFqCp5a4d/Ygfwc+l1rFF/PWiWJ39B7FUMHLMc16p
         Y+49zjYJY4Imw6Nn8AKX5YL3b7WrIxSSFFvMGv6cKFRlXJeM/CV7xfrvTbAfpsAq6D
         +ey6StSk8Pg7ox44OE7naJSrzmWZkpjZqap5KzIw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.111]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiTrM-1iByc521yG-00cdtl; Thu, 20
 Jun 2019 20:01:33 +0200
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
To:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
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
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <6653dbf4-6e45-156e-1f3c-60734b84ef21@gmx.net>
Date:   Thu, 20 Jun 2019 20:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:VcqUsnUQzu4YyUu4skdO658ecJguqWBJ2q0rMuRNzaMEsz3kxpJ
 ATwnX103YdlFY7MqDY0NaDKHr3SqNbp/8uGHQmMzLsKWODWiyKWxkxpbynbYA/QIaHX2s/b
 V9twFT/WACvgglKEH1XIfUAebqLveN+05ZWJHjFC7SxRUckYiRMr3XjdsYO988cywTYcxYY
 sy2AB+2ozQFRm36PJGo7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6jndhfN/z9s=:qXFGcAPMzPIaEJEroU7PB5
 4/WScxlUdeIIf9a5nwcDGgIrndcZZyZzVbas4TSSN6fDvkknahWudursoPa/HnMSA369u6n8+
 /PgI0B+4V1HOKHC5k74jdM6unzWwpQKpNoXtSqM9F9R4h6tmGA0g0pP4wqTNzXXQ6aCvILElR
 SmqZF8Sd+aZcpqNXRwd02M0t6+tnlAf3EIMH5f4tzcRHjCXrkvcttHD3ZFTYFDRhpkkZWHuVc
 WYZg38x3WL1M6RCOcMa1uVTZt0ur3gEC/bFjHW2tvTCIexvZGKHXVRWLyLHtRvfRvKmIGYjUV
 LyuKfXMX4DnRf18hpVCR/L5XqNrSO4vicudGSR4Gk7FPnOtlzhDUfvhlvKPXl/grPywXUHLLy
 6Iuos+ELlBlPFD0dSE5w3kVkzosCv5S/+UZ6/oBiXql7sF/ReFWSxT52r6ZblbmEf3eAATbfk
 2eJZZhUr7dDiF5RdhxqZ5BPET+Nkodg7eMwjpTVBPe8RgdPBHUvUURHOS0ucy29Jgwf2ESCPL
 B+Od0+WolmgoQ19LOMHRcE9I5pgsgb26bt5xr/pwnJqJeKlSWmfLX9SrXxnT/ZAXK/zAzh+mg
 yNkDcYFNNdup3kPTE4YhUK5mJefoQvhzjpjVjbA+0BIMWWS9wQSJS/nwPXw09XUdLbWfSdW+c
 dl1SRJ+WXymHFcJOAEnV9SphT8W7YBiyCRC7RyKI3+IKKAykKH67gClYlOSleQrXDo+mfbVvJ
 J0Ih3w7R/c/z4NdRq6vtVrtGOvqDElC8UUGlWYaHxgIMvphZaPA+TpEc2FBaoOm798riVTyXI
 edywd4Y7JNg6WfjZLB/IaRK2HnU7O0zd6zv37vDftqhvS4epXu86aX0k6+2irZL6+u++2YrRm
 jrNL124KyIEjDpQ2Q2Jl2BRS3AHz/442+46ouPGfbkwNmJcoiIDdf9Tv1erf2ofolg5cCLesO
 vQmUMmiRWL30H/oFq8WKZzPBcuRSffYbPVRjFaOwUUVnt3y0xBJPw
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Chi-Hsien,

Am 17.06.19 um 10:04 schrieb Chi-Hsien Lin:
> (+Stanley)
>
> On 06/16/2019 1:21, Stefan Wahren wrote:
>> Am 15.06.19 um 19:01 schrieb Stefan Wahren:
>>> Hi,
>>>
>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and=
 a
>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>>
>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=3D1665608
>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=3D202521
> Stefan,
>
> Could you please try the attached patch for your wpa_supplicant? We'll
> upstream if it works for you.

i tested your wpa_supplicant patch on top of current hostap-2.9-devel.
After applying the patch the driver warning disappeared.

Please take care of the upstream work.

Thanks
Stefan

>
> Regards,
> Chi-hsien Lin
