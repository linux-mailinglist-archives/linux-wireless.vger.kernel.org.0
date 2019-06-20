Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79004CB83
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 12:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfFTKFE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 06:05:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfFTKFE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 06:05:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so2352308wrl.11
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2019 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRNYhPxwwhtuqUCoRki7KtTT+yRQv3IVAo9A8JBRX7I=;
        b=Gs+GmClX3urtosPjl/T04aaEg/jdVrxGdmJZoW3t+adSHBACVrsDUO/4ctoA0MNh9n
         wEV0/CFh7Qu8NlHpRBH2ZVS9KrVqHmS3eDaMvcDFF+b92ju5AnyiakHv04h76k4JNL2W
         TifNE8hgqlY1DKC1/HbU7zC8F217vNgxepjg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRNYhPxwwhtuqUCoRki7KtTT+yRQv3IVAo9A8JBRX7I=;
        b=mAIWCf5tzvKMU7bXyes4Cqt740wALKfXq58pfQt5puddJY7VneCLTjuM6vu9/l+lZ3
         aALv6d1kbwiL6WqMTYIPddAHsProV9MY7A9s8zoSzCi4uGe/WE41K7YWJURsgl9nKh5w
         un33XKi68f/XIZyTcAPv+biCiksIsH83QxD+Q/CXBpU7bWHPHrFIiYtuHHWylmAWAjZj
         zd55WjDk4xnyo4vPRkW1eK6QSHN8nJfepJp2DUVe4rkpYgkS/k5qbySHXwMaHjKQHZuN
         zzOrWfYZyX1BOGogJM6j5vs4Hrl0XHSiGwnKDG/E+kdncZAj12zHwATnmhMLVPdbDUgh
         U4CQ==
X-Gm-Message-State: APjAAAWYdOkgXcafTPOV+/j6+4x+o1myXgUC6UkI4lGKXp+hRgOEvjwB
        OD/hxnnKs9ljpVXlComsVcTqKw==
X-Google-Smtp-Source: APXvYqygEw1aZeQ5xixLA3XJklzL0YRxcp/5OjMV4VPjGnTKgdK3cKuKgMQr9KAxOk295kQd1wnRRg==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr10445124wrm.117.1561025101829;
        Thu, 20 Jun 2019 03:05:01 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 5sm26621440wrc.76.2019.06.20.03.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 03:05:01 -0700 (PDT)
Subject: Re: wpa_supplicant 2.8 fails in brcmf_cfg80211_set_pmk
To:     Marcel Holtmann <marcel@holtmann.org>
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
References: <06f7bda7-eeaf-536b-a583-7c9bc5f681f5@gmx.net>
 <9da02861-9151-9700-2c09-b312d74155fa@gmx.net>
 <605ea0a8-3303-b810-6223-18ccc7eb7af4@cypress.com>
 <2AF2E0A7-23F0-4FFE-A658-4906FF546199@holtmann.org>
 <d6bfe313-3aa7-82bb-dfac-25e6261dbf63@cypress.com>
 <d0263c6f-97d0-6571-32e9-778392eafe69@broadcom.com>
 <0ABBF42F-1C9C-4564-A27C-511026EB733C@holtmann.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <a65a9b67-8307-12d0-9ef7-94bd2eb5badf@broadcom.com>
Date:   Thu, 20 Jun 2019 12:04:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <0ABBF42F-1C9C-4564-A27C-511026EB733C@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/19/2019 7:26 AM, Marcel Holtmann wrote:
> Hi Arend,
> 
>>>>>>> i was able to reproduce an (maybe older issue) with 4-way handshake
>>>>>>> offloading for 802.1X in the brcmfmac driver. My setup consists of
>>>>>>> Raspberry Pi 3 B (current linux-next, arm64/defconfig) on STA side and a
>>>>>>> Raspberry Pi 3 A+ (Linux 4.19) on AP side.
>>>>>>
>>>>>> Looks like Raspberry Pi isn't the only affected platform [3], [4].
>>>>>>
>>>>>> [3] - https://bugzilla.redhat.com/show_bug.cgi?id=1665608
>>>>>> [4] - https://bugzilla.kernel.org/show_bug.cgi?id=202521
>>>>>
>>>>> Stefan,
>>>>>
>>>>> Could you please try the attached patch for your wpa_supplicant? We'll
>>>>> upstream if it works for you.
>>>>
>>>> I hope that someone is also providing a kernel patch to fix the issue. Hacking around a kernel issue in userspace is not enough. Fix the root cause in the kernel.
>>> Marcel,
>>> This is a kernel warning for invalid application PMK set actions, so the
>>> fix is to only set PMK to wifi driver when 4-way is offloaded. I think
>>> Arend added the WARN_ON() intentionally to catch application misuse of
>>> PMK setting.
>>> You may also remove the warnings with the attached patch, but let's see
>>> what Arend says first.
>>> Arend,
>>> Any comment?
>>
>> Hi Chi-Hsien, Marcel
>>
>>  From the kernel side I do not see an issue. In order to use 802.1X offload the NL80211_ATTR_WANT_1X_4WAY_HS flag must be set in NL80211_CMD_CONNECT. Otherwise, NL80211_CMD_SET_PMK is not accepted. The only improvement would be to document this more clearly in the "WPA/WPA2 EAPOL handshake offload" DOC section in nl80211.h.
> 
> so nl80211 is an API. And an application can use that API wrongly (be that intentionally or unintentionally), the kernel can not just go WARN_ON and print a backtrace. That is your bug. So please handle wrong user input properly.

Hi Marcel,

You are right. However, the kernel does also return an error if the 
WARN_ON is hit. We can improve by using the EXT_ACK functionality to 
provide more info than just -EINVAL, eg. "PMK not accepted; no 802.1X 
offload requested on connect".

> Frankly, I don’t get why nl80211 itself is not validating the input and this is left to the driver. I think we need a nl80211 fuzzer that really exercises this API with random values and parameters to provide invalid input.

That would mean nl80211 should keep state info between commands. From 
what I remember that has been avoided from day one because of the 
experiences with that in the WEXT days. I welcome any testing be it 
fuzzer or something else.

Regards,
Arend
