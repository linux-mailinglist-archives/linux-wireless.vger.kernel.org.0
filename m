Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0B4D993
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfFTSjN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 14:39:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51773 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFTSjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 14:39:13 -0400
Received: from marcel-macbook.fritz.box (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id E7D19CEFAC;
        Thu, 20 Jun 2019 20:47:38 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a65a9b67-8307-12d0-9ef7-94bd2eb5badf@broadcom.com>
Date:   Thu, 20 Jun 2019 20:39:10 +0200
Cc:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Jouni Malinen <j@w1.fi>
Content-Transfer-Encoding: 8BIT
Message-Id: <D3FC6B1E-ABC8-408E-8CAD-75F1D5BA8469@holtmann.org>
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
 <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
 <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
 <d6bfe313-3aa7-82bb-dfac-25e6261dbf63@cypress.com>
 <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
 <0ABBF42F-1C9C-4564-A27C-511026EB733C@holtmann.org>
 <a65a9b67-8307-12d0-9ef7-94bd2eb5badf@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

>>>>>>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>>>>>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>>>>>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and a
>>>>>>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>>>>>>> 
>>>>>>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>>>>>>> 
>>>>>>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=1665608
>>>>>>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=202521
>>>>>> 
>>>>>> Stefan,
>>>>>> 
>>>>>> Could you please try the attached patch for your wpa_supplicant? We'll
>>>>>> upstream if it works for you.
>>>>> 
>>>>> I hope that someone is also providing a kernel patch to fix the issue. Hacking around a kernel issue in userspace is not enough. Fix the root cause in the kernel.
>>>> Marcel,
>>>> This is a kernel warning for invalid application PMK set actions, so the
>>>> fix is to only set PMK to wifi driver when 4-way is offloaded. I think
>>>> Arend added the WARN_ON() intentionally to catch application misuse of
>>>> PMK setting.
>>>> You may also remove the warnings with the attached patch, but let's see
>>>> what Arend says first.
>>>> Arend,
>>>> Any comment?
>>> 
>>> Hi Chi-Hsien, Marcel
>>> 
>>> From the kernel side I do not see an issue. In order to use 802.1X offload the NL80211_ATTR_WANT_1X_4WAY_HS flag must be set in NL80211_CMD_CONNECT. Otherwise, NL80211_CMD_SET_PMK is not accepted. The only improvement would be to document this more clearly in the "WPA/WPA2 EAPOL handshake offload" DOC section in nl80211.h.
>> so nl80211 is an API. And an application can use that API wrongly (be that intentionally or unintentionally), the kernel can not just go WARN_ON and print a backtrace. That is your bug. So please handle wrong user input properly.
> 
> You are right. However, the kernel does also return an error if the WARN_ON is hit. We can improve by using the EXT_ACK functionality to provide more info than just -EINVAL, eg. "PMK not accepted; no 802.1X offload requested on connect”.

just remove the WARN_ON and replace it with a dev_warn. Userspace should not be able to trigger WARN_ON by using nl80211.

>> Frankly, I don’t get why nl80211 itself is not validating the input and this is left to the driver. I think we need a nl80211 fuzzer that really exercises this API with random values and parameters to provide invalid input.
> 
> That would mean nl80211 should keep state info between commands. From what I remember that has been avoided from day one because of the experiences with that in the WEXT days. I welcome any testing be it fuzzer or something else.

And now driver bugs are bleeding into the API. I expect from a kernel API that it hides driver details. From an userspace program perspective I expect exactly the same input validation and behavior no matter what hardware is used underneath. If we can not do that, then this API has a broken design.

Regards

Marcel

