Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53544B14F
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2019 07:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfFSF0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jun 2019 01:26:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50953 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSF0P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jun 2019 01:26:15 -0400
Received: from marcel-macpro.fritz.box (p4FEFC3D2.dip0.t-ipconnect.de [79.239.195.210])
        by mail.holtmann.org (Postfix) with ESMTPSA id AA2D3CEEB3;
        Wed, 19 Jun 2019 07:34:40 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
Date:   Wed, 19 Jun 2019 07:26:13 +0200
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
Message-Id: <0ABBF42F-1C9C-4564-A27C-511026EB733C@holtmann.org>
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
 <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
 <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
 <d6bfe313-3aa7-82bb-dfac-25e6261dbf63@cypress.com>
 <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

>>>>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>>>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>>>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and a
>>>>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>>>>> 
>>>>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>>>>> 
>>>>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=1665608
>>>>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=202521
>>>> 
>>>> Stefan,
>>>> 
>>>> Could you please try the attached patch for your wpa_supplicant? We'll
>>>> upstream if it works for you.
>>> 
>>> I hope that someone is also providing a kernel patch to fix the issue. Hacking around a kernel issue in userspace is not enough. Fix the root cause in the kernel.
>> Marcel,
>> This is a kernel warning for invalid application PMK set actions, so the
>> fix is to only set PMK to wifi driver when 4-way is offloaded. I think
>> Arend added the WARN_ON() intentionally to catch application misuse of
> > PMK setting.
>> You may also remove the warnings with the attached patch, but let's see
>> what Arend says first.
>> Arend,
>> Any comment?
> 
> Hi Chi-Hsien, Marcel
> 
> From the kernel side I do not see an issue. In order to use 802.1X offload the NL80211_ATTR_WANT_1X_4WAY_HS flag must be set in NL80211_CMD_CONNECT. Otherwise, NL80211_CMD_SET_PMK is not accepted. The only improvement would be to document this more clearly in the "WPA/WPA2 EAPOL handshake offload" DOC section in nl80211.h.

so nl80211 is an API. And an application can use that API wrongly (be that intentionally or unintentionally), the kernel can not just go WARN_ON and print a backtrace. That is your bug. So please handle wrong user input properly.

Frankly, I don’t get why nl80211 itself is not validating the input and this is left to the driver. I think we need a nl80211 fuzzer that really exercises this API with random values and parameters to provide invalid input.

Regards

Marcel

