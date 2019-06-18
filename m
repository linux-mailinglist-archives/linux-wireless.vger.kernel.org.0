Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47B649C00
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2019 10:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFRI1b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jun 2019 04:27:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46193 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFRI1a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jun 2019 04:27:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so12868437wrw.13
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2019 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pByTnhI9EtjD8279pBGlW0CoWOpybCQlzKqH9Rz3Qw=;
        b=iL6uwFTD34zhx7OU8sbMEZuz7EAQRaMIqt4XQB7/eVHx6yO/qKRZ7hajGRPM/nCgOI
         aPV6y/WQuHpvroxgIbItlIZEtTxgoIn+amMvXbVZ0nf+OGi7MjzyECbbKk6HKXzpPcKS
         1Wmrl8qupb/CTQK9S2zzUA98KjVBHTJfjfvlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pByTnhI9EtjD8279pBGlW0CoWOpybCQlzKqH9Rz3Qw=;
        b=frLDSzbyzHtRftyyN1vKMRfszKwLdJx0UdB6umnuquEmUF7Igc4PgpK4q8C3Oe3dG3
         z2CCLVXYQ2jf/wKyqEJHCZXGgoDEE63fvRC0OUoTu3LqlIcQXuv6B8LqdO+yG2ClmbpL
         dVmiuhuClrBp5fDFU/+zotELDVbG9wVaU656fRCATwJzTPTXPn9Bes2zRqkH9gTY1WUp
         gPPtBR2gN++FxfaHgoIXT+vBb7DXZCBZv7gePg790mvLM9njPk5JEn0+UbnhSpq+fiDu
         zGgQlN1zYv5qeXG7iIEFB2CwI+sw0b6cEf8yCsa7CPUzIwp1KmDuKSSpOt8d0SBcpGu7
         RI4A==
X-Gm-Message-State: APjAAAUouKHAJbl5X1+BTLGROEb7MpfWSEXQN7C/J+nVtBW23vzepnKh
        qDwBtx48RvbdVgTi5xyUzC88Pg==
X-Google-Smtp-Source: APXvYqwtjQeJCyyssxLDdia1qH1lA7DoA9KZUqgksXNlJSXaWHx0Xlz5MfGxpXZ+KG5Ed5EPBcs5vg==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr40004898wrm.55.1560846448649;
        Tue, 18 Jun 2019 01:27:28 -0700 (PDT)
Received: from [10.176.68.244] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id k125sm2894514wmf.41.2019.06.18.01.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 01:27:27 -0700 (PDT)
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
To:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        Stanley Hsu <Stanley.Hsu@cypress.com>,
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
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
Date:   Tue, 18 Jun 2019 10:27:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <d6bfe313-3aa7-82bb-dfac-25e6261dbf63@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Jouni

On 6/18/2019 7:33 AM, Chi-Hsien Lin wrote:
> 
> 
> On 06/17/2019 10:33, Marcel Holtmann wrote:
>> Hi Chi-hsien,
>>
>>>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and a
>>>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>>>>
>>>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>>>>
>>>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=1665608
>>>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=202521
>>>
>>> Stefan,
>>>
>>> Could you please try the attached patch for your wpa_supplicant? We'll
>>> upstream if it works for you.
>>
>> I hope that someone is also providing a kernel patch to fix the issue. Hacking around a kernel issue in userspace is not enough. Fix the root cause in the kernel.
> 
> Marcel,
> 
> This is a kernel warning for invalid application PMK set actions, so the
> fix is to only set PMK to wifi driver when 4-way is offloaded. I think
> Arend added the WARN_ON() intentionally to catch application misuse of
  > PMK setting.
> 
> You may also remove the warnings with the attached patch, but let's see
> what Arend says first.
> 
> 
> Arend,
> 
> Any comment?

Hi Chi-Hsien, Marcel

 From the kernel side I do not see an issue. In order to use 802.1X 
offload the NL80211_ATTR_WANT_1X_4WAY_HS flag must be set in 
NL80211_CMD_CONNECT. Otherwise, NL80211_CMD_SET_PMK is not accepted. The 
only improvement would be to document this more clearly in the "WPA/WPA2 
EAPOL handshake offload" DOC section in nl80211.h.

As for the wpa_supplicant behavior it seemed a good idea to reuse the 
req_key_mgmt_offload parameter at the time, but it seems to bite each 
other. Maybe it is better to have a separate flag like 
'req_handshake_offload'. Jouni, any thoughts on this?

Regards,
Arend
