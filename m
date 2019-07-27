Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6677A0B
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2019 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfG0PSP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Jul 2019 11:18:15 -0400
Received: from mout.gmx.net ([212.227.15.19]:34399 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfG0PSO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Jul 2019 11:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564240671;
        bh=UnTf2WwFWUPTip8DTEyqCu6JihIVuoeasLZZ4G2fHro=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FUTImWDxBVn4cYuQj65tKQvuhmTXTX1FWp7Ho41foa3rfhq9/75jNfFqH3b8zzX2M
         aRpaXBhcWkMvcix/KK/3zHLibfLUu+CqESfD6AKSfMq04PdyW43bhbwaWhoMEma2AI
         u66Drm7cjNqM8JaeLrk+Wj7DiexS6+KDvyg+1OEY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.127]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt1eU-1iXlVU3gp0-012btl; Sat, 27
 Jul 2019 17:17:50 +0200
Subject: brcmfmac: Probing regression in Linux 5.3-rc1
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <96113adb5fcab9c2f4bb5fa82b84ff5f9c07fd07.camel@suse.de>
 <bc650090-db86-ccac-01dc-23f08ad7b19b@gmx.net>
 <20190723093442.GA27239@lst.de>
 <04c5eaa03f3a124dbbce6186e11e19acc4539cc8.camel@suse.de>
 <b15509d6-bc2e-3d06-0eea-943e6e456d62@gmx.net>
 <5f9b11f54c66fd0487837f7e58af3adf7f86635f.camel@suse.de>
 <CAGb2v66-o23CW5iH9Bn1aELymPSiKrA43eJd2q6EZ7iubcogaw@mail.gmail.com>
 <ab7af8537ebcbc7a7bdf04d2c06152ba6821b333.camel@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <3daef629-8baf-3c5c-16a4-73d67604d1e5@gmx.net>
Date:   Sat, 27 Jul 2019 17:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab7af8537ebcbc7a7bdf04d2c06152ba6821b333.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:KANL+UEVbofPDLfDVCGu1V30zI2qDAM0iw0Z1FDGqjjPngV1UUT
 yiy8oknCnY+2eHMJb97Ogzq2+K0UCiWo6iId+5cn5Supx9iqEYh4aJi1M/bmTapPm+aBLWQ
 uyvz5qnU3QaQ/gicroj7LnydewPVk2mPvWU7qKCVCvk8vFBFihZBIL4i5Slfw92xTXYOdBY
 h5S9257vTgGn40WG17PUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7SCg7cWCkcc=:04Y4D9LfCPYexEs7oyCPux
 M434UYx1AtBsxASACN69S1CZf7hcyBGOlsXz1Q7+KlA1GZ24OjQewEXTjPpQdEM3JkQw1RuTw
 5OYtRsd4Dh4uUHUH22mUuJlkNosy1F2/IH5NQi+FJUpUdBGrNykmL08kjLxdGYZhLd9YRQJsQ
 q0zdRJS71Sm6j/xYTYOQMq6ABp6ZUDgOEQawlVUd2VZHOlZLvfP3pV/rq0kIuJ7a7DCm0eCWv
 9qWD6GLmqQ6v0rkLtRzayG9tU7CzYUtAPfOi/5xLmxxtvRTUsU5WaJ1n5w7O5VzMbeZ3V9uAK
 plvV2qsK6m+de8xzvuV+972oBpCFdPr3MVT+yPmhmv/LOTvr/2ZAUlAk3yklbdp5A//RGaBer
 9oO6QExfefHm/a2tV0QG17q62mkEq6xvrqrP7Ya0ZKMu6iivatBY73hMj7kGFwvf1MEbk/4Ul
 TVH/o3YaQCn0mfQoNRR+5pFutgVsaBkaR6+//SU5RzGIEWQ9IO59+dWoqxcp1yWrx9xlFyYC2
 hK3y6NnzkqL0uha0geticuHNDDroJnilhTIY8pRxaS/4dY3C3zjV+NAIPOPXWTFh3PO5+7qex
 GeWV6nbKxPONLt4u9+BJtWQcA2ot70/gtebNgHvh7L9h5RKrlyZMyEyi7b7r9QDEGaQsS8oVU
 ec1uptwvCLEDUUwCHsfoNhNea6n66QvEGodwAqLsFuKOu3gE/kLa5PaqqclXkHGlnCdcQaT9L
 FvQe8RvMOiCOGyu8oI2U7MWalfNzAQFWjG8s3gIrmwZ1OAqCbUOUAmP97isuF10EwPG/AbUHE
 O1uzZBdKS0VX233rko1VrekA+hqo6Lp6PKYNq46TIDU9p14pSZkeeEgrJGoije8CvvfGJQ/xz
 3RHqTJvVUoiMrkscHL8DKw2z6kQxgYD8tjCSmEGXpjwM+ASXo056lEXsTYisiZC/TSLRcfNoj
 OGRDaqIBB3JcFgYD2a85h6OzLusl/Sy9kV3QRAIWsxyC2vU/soh+xV7lQxbxZt2zDTeZir4z+
 VL/dtjH8IYW0yj9GG4z5TolO2chPcGlq7KcF3MQdkozw38OOPcjBOWIijLZYR32IoEK8BjgWx
 m4lQXwxazLXxSo=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Am 24.07.19 um 10:37 schrieb Nicolas Saenz Julienne:
>>>> Does it fix the wifi issue too?
>>> Well it works as long as I revert this: 901bb98918 ("nl80211: require and
>>> validate vendor command policy"). Which has nothing to do with DMA anyways.
>>>
>>> Was this the issue you where seeing?
>>>
>>> [    4.969679] WARNING: CPU: 2 PID: 21 at net/wireless/core.c:868
>>> wiphy_register+0x8e8/0xbdc [cfg80211]
>>> [...]
>>> [    4.969974] ieee80211 phy0: brcmf_cfg80211_attach: Could not register
>>> wiphy device (-22)
>> We're seeing this on different platforms (allwinner / rockchip / amlogic)
>> with Broadcom WiFi chips. So it's unlikely to be related with anything in
>> this series.
>>
>> I believe a fix for this has already been queued up:
>>
>>
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=91046d6364afde646734c7ead1f649d253c386e9
>
> Thanks for pointing it out, it fixes the issue alright.
>
i cannot confirm. I still need to revert Johannes' commit "nl80211:
require and validate vendor command policy" to get brcmfmac probing on
Raspberry Pi 3B+ and 4B.

The commit "nl80211: fix VENDOR_CMD_RAW_DATA" didn't fix the probing
issue (see warning above).

Regards
Stefan


