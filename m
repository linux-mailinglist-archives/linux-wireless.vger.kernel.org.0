Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E3947162
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfFORV0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 13:21:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:35697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfFORV0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 13:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560619281;
        bh=CHLtpSwCk00f1BWbMejN+QhcdT7BoWQvNmaxe8ss8w8=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=QLm8bFm1BT2ofcsrlj+i0/ReGsiu81532JJSemPezMiCeBtIKsiOPXxQD0y0RY75r
         8UhrEnUFQ4pa3kxkenyIcIGEThs6njnR6n+ku7jDnePslJtOaAEStgOKRkrS5KapxS
         kSogXeu2sllmkyzDPo6EeU8FkagcBNPBTXyRYypI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1iFfua1sNl-00e5m1; Sat, 15
 Jun 2019 19:21:21 +0200
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
Message-ID: <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
Date:   Sat, 15 Jun 2019 19:21:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:eEfnHjyNFYN0no3VvvnUj1kwyW4GGg8+CXeDwEyuAWLlxhjehF/
 TMAJyDtAmH4XcWHG+VcfiyHF4uJz9InRLLUuk+LsOLBFcsaFkSW6uSwb6HG1eVFY6R7QC/1
 A2kCxHYW2AJwf50XhLGkw3Zs4Zo466NB8HdCdmpRvoHk9pPl5sD4XsCPwQmiwYX+Ql7gY5T
 J7Yqpk1bmJqrk/4yU9s5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tuXSV8w7uZw=:UiGaM8AHWOiJpPZbIFYi9P
 a3NIdsLbCJV67N1INsFC1uMCWTjZNsp13gZjsXwiaw/zhZaYups/6v0U765bdBmOsMVvYYTFq
 eVaT+bh6GQanOxHViheHj2V3N7dLPqtuW/ORJkxeeRW9SR9VbX+yPUU+vyxh6k6QSm9jsFk57
 N2/Nukq8gEbeS3cHjurUYE4yrxN90qDOyvQtxmTbaBHMdjpsGJGO1LuQ/r3FPhuofakR5iur/
 roBO053TV7kaCWOhjtE/G57PAex4UPxf8p0iKa4ycLiv6gLAwu3dtLfvuhW6pQocwUMyGctkC
 xXk1yoLYSgId3hTsUBAFQMHXLbnZ5ptgZZVM2y6oTRretceZ2FhwCRXsaw6UCm3W5/Zd/ewpf
 ae2dBTHfx3k4qW3EMpNJq6vaBL0VgHB+/5uOT2O1GxTAjtmXe/x277bYCB44Hq+0jxnuOD7jY
 5WwJ2bhq7gvFaFj17zh4XE32ggUgL4XYI924nLx/5gTLN7ZihhbfvTslflf4mPm+WncM9Bx4W
 Shi0oYUHnVyegotm2rpSGwVcDXDNYbD5fT35Z3z/2593Fk1urNzQYI/MlEdxHFNJeZ1itGvd4
 xWtIodS2mM9JLm/kKdScaBsaT5PnLXvCajvlciGRuW6vGgHAib8B1oiEPMf0rcXg2wcQhy2Wi
 k+DbgqGKX8e0xJc1a+AjB+gP8REGJNURaV/Xl+f4l1ykCfr7wRS2BCQdoxpCb5QrP/SdVgigw
 jVBzMZed28UEhFU3trQXGfpF0DhP1omQuhEjk13lDKOM6T7cTBAgzfKMMTr0AiGNwji6vNkQe
 UQ8obdGptdCIshsx35oeEUTjqzCZfcTgfa9PCMFJ4gtoKm0wVDlesx+u0Uq2UX+h9AuvjJhAm
 pH+fyZIbSGzmms0Tba4CC8vtLnIecB4stKR6tMDuieztAyqytsdZdthiibhRXsuiU+TWeJxd5
 BjroUmsdu8fJOaEujC3mkQJUwC91RJmyLARH/igRac+Q9RTRuGwyK
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 15.06.19 um 19:01 schrieb Stefan Wahren:
> Hi,
>
> i was able to reproduce an (maybe older issue) with 4-way handshake
> offloading for 802.1X in the brcmfmac driver. My setup consists of
> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and a
> Raspberry Pi 3 A+ (Linux 4.19) on AP side.

Looks like Raspberry Pi isn't the only affected platform [3], [4].

[3] - https://bugzilla.redhat.com/show_bug.cgi?id=3D1665608
[4] - https://bugzilla.kernel.org/show_bug.cgi?id=3D202521

