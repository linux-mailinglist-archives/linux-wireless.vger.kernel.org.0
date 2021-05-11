Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE237ADD8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhEKSJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbhEKSJJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 14:09:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC3C061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 11:08:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso18293000otm.4
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I07Kad5IPh1ONvurzdAnbmdkBCvQNj8szfzlZBVqjUg=;
        b=ZjpYGhwjtVHqSYNpqThMj+CkWHd0/UBwK0KdZx5+r4S6m68gypa0fBAl7l2v4vePPD
         wSIryWIFm2tXmbwh+m3b/pDUvm+XlNcT/lPNOyY6P9bmmHAeZeHepzhWfQv24WNJ47jU
         9VeaB4DNmogb0xb5DIuWShOGjv5iNDlS91g3N9ki+vKlt8fGVu9MWl8BIlpg2UX+MMwM
         0bCzj0zJi+lUgVr/ngGVrNM8lI5p+ibRrlerfPaWW1C+C6uxseyJalBWE9ToFv+RZD1W
         W9Cjg2XRbPGFZELShBXtX0ZHdnk0nKg2TEp9qI6XapoF7sFm7axNTbD6g7nyYIZ94wd8
         MD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I07Kad5IPh1ONvurzdAnbmdkBCvQNj8szfzlZBVqjUg=;
        b=VZujb/51U7e5CD8ulnFcABxV/RoBOwPHhUVHKc6RHo+OPrY4UskHn2+499PchLtAAr
         ISoB62mFC1JB0bRYEKNqFHXW5pTE/eCw/RLSjxO7fSFREtbREJOoi5QBsw1nxzabx3hK
         9Dq4Z4VwQ0CImW8KGyeRhuvX1i54r9tECXlBB2u7qQ4ivs635KxRLphCBBA/kzgOAKf7
         tcuRqU7mA6wbnU+0v15DxVVNLclgHxAJjrjMdoZFuZ41ztUoWg0I8m29XpATc4oR5gyK
         1M2rnCcS0dWXNZpxBMb6CYrlcr1y3MIlWihuJT5g62ypGgUqD0yGo+OZgmLroUpa5ljk
         ZQdA==
X-Gm-Message-State: AOAM533q2DA+Z8ilIZYCaHsfrnKxI/CoEgUGJQkqCsYmgc9SoOowzYxE
        WDHjUmr7Kk05C8CaU08IYND8NF4tICw=
X-Google-Smtp-Source: ABdhPJxr4lY5C1Op114yVxSUhiQx9/LEy8YM+N71oVN3eCmzkGiLI1woPzT8xmFaMbzT8InlDqIQag==
X-Received: by 2002:a05:6830:1404:: with SMTP id v4mr27257193otp.209.1620756481589;
        Tue, 11 May 2021 11:08:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 9sm129419oie.51.2021.05.11.11.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 11:08:00 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw_8821ce: "rfe 4 isn't supported". Asus D509DA laptop.
To:     Alexis <flexibeast@gmail.com>, linux-wireless@vger.kernel.org
References: <8735v9sdw6.fsf@ada>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9e0a95fc-f068-9478-ff59-ce9e68751149@lwfinger.net>
Date:   Tue, 11 May 2021 13:08:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8735v9sdw6.fsf@ada>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/29/21 3:17 AM, Alexis wrote:
> 
> Hi all,
> 
> i've just acquired an Asus D509DA, and wifi isn't working:
> 
>    rtw_8821ce 0000:01:00.0: enabling device (0000 -> 0003)
>    rtw_8821ce 0000:01:00.0: Firmware version 24.8.0, H2C version   12
>    rtw_8821ce 0000:01:00.0: rfe 4 isn't supported
>    rtw_8821ce 0000:01:00.0: failed to setup chip efuse info
>    rtw_8821ce 0000:01:00.0: failed to setup chip information
> 
> `uname -a`:
> 
>    Linux voidlinux 5.11.16_1 #1 SMP 1619045101 x86_64 GNU/Linux
> 
> Void firmware package:
> 
>    linux-firmware-network-20210315_2
> 
> Some previous mentions of this issue on this list:
> 
>    https://marc.info/?l=linux-wireless&m=159981742905028
>    https://www.spinics.net/lists/linux-wireless/msg206075.html
> 
> Some other mentions elsewhere:
> 
>    https://bugzilla.kernel.org/show_bug.cgi?id=212435
>    https://github.com/tomaspinho/rtl8821ce/issues/142
> 
> Please let me know if there's any further information i can provide. i'm not 
> subscribed to the list.

My contact at Realtek just sent me a message containing "I'd like to let you 
know that I don't forget this thing, and my colleague is working on this. If 
there's any update, I'll let you know. Please wait a while."

Larry


