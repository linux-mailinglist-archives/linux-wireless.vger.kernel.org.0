Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4273E34F068
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 20:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhC3SBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 14:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbhC3SBk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 14:01:40 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A01EC061574
        for <linux-wireless@vger.kernel.org>; Tue, 30 Mar 2021 11:01:40 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso16454305otp.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Mar 2021 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tSLAahLIOIxfIc20PVC4oH4Vi8wQuCml+mNUoRjJhcM=;
        b=T2WMRD9w5Y1QNTw5ELLKECWIc2tAFvxZo0FZ+Lec+YODyWFBXZJm+Pz9DM7qB12HYw
         pNmbXvrrzEPJfnhlwcEyecIBRwkfJ3xAxy9XAWXGFMbSFwSkZRxmTEaNL2iYrIuGRHZK
         GzgOFZBhbOzFZbhlfijFcb4MW94vH3NyfI4SdFZLMmFS/GL/rN5IEJ2wTIbCEzKEsXLY
         hWz2v6UMED/VDgDIm/cJYCtGOexNzUYxQmxcKXOwQos7ax5xuv9SMbYByKHR58hedgay
         th/Gn7uDY5YoDSWTwYncCYmrSH0zBP1qL2jiddkM3Vh3z2nIf9L9FsDW0J4pOG/08Oqv
         TZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSLAahLIOIxfIc20PVC4oH4Vi8wQuCml+mNUoRjJhcM=;
        b=fi6cAUZtYjYO72kRh1dAeYkSTSaS9e2NtuBokm3YCRwunaI4/x3AJ6BVYzSaus9MXr
         hRhovmYX1/Dc+Pgy+2OzFeHuFpGbnaD346l1F68o372iZCMcj61FWVb8sMRmVIywLpFh
         WxZ7zpvdo6qsg4C9Qtur0tgz8M0BYrJTcpNaHUP3VjlHuPIlSqUvmaVNL/q01fXnC9uJ
         wRd+EQ3qRqTcvB6CGI7aszLHhj7gsve9vuYkpRKO2zQw02ABy5umqcBEoxQMJ7Cwz9Lp
         93uzHEjeFkjT+MxH7jceZwvlftvxGrTwCLutzy+/Afo8ETcMwGQWMt6qoG3SDy/vg32i
         BXKQ==
X-Gm-Message-State: AOAM5301p/5858y1YFTBr+Pm8InezlsTYh6U71xpUCvsNoNyRQjXEAxi
        kB9oYpj+PVQqAZUUMDoNtoQpmcC1uO0=
X-Google-Smtp-Source: ABdhPJxgmlcG6u6AmnMrS9tXmb4+iUaMv2FMgRfa7M1JO2flznPPPTqFvhmYJzkKlJrdf9k++0NN8w==
X-Received: by 2002:a9d:3b36:: with SMTP id z51mr2326612otb.317.1617127299598;
        Tue, 30 Mar 2021 11:01:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id f197sm4849386oob.38.2021.03.30.11.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:01:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw88 kernel module error report (UBSAN:
 array-index-out-of-bounds in drivers/net/wireless/realtek/rtw88/phy.c)
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?0JHQvtCz0LTQsNC9INCf0LjQu9C40L/QtdC90LrQvg==?= 
        <bogdan.pylypenko107@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CALw23pC5kFE23g8M97KJY5vK8-eP1dWPj3jze=j4Mi=NjHks0w@mail.gmail.com>
 <YGNS7WKlBmLrM9/d@kroah.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <040befa9-c88f-539a-f158-0c75d8789e47@lwfinger.net>
Date:   Tue, 30 Mar 2021 13:01:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YGNS7WKlBmLrM9/d@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/30/21 11:33 AM, Greg KH wrote:
> On Tue, Mar 30, 2021 at 07:26:15AM -0900, Богдан Пилипенко wrote:
>> Hi!
>> I finded your emails at:
>> - https://github.com/lwfinger/rtw88
>> - https://wireless.wiki.kernel.org/en/users/drivers/rtl819x
>>
>> I have an error in dmesg:
>> *dmesg | grep rtw88*
>>
>>> [   26.518691] UBSAN: array-index-out-of-bounds in
>>> drivers/net/wireless/realtek/rtw88/phy.c:1661:35
>>> [   26.518804]  rtw_get_tx_power_params+0xc66/0xd80 [rtw88_core]
>>> [   26.518822]  ? check_hw_ready+0x4f/0xa0 [rtw88_core]
>>> [   26.518836]  rtw_phy_get_tx_power_index+0x4d/0x1e0 [rtw88_core]
>>> [   26.518850]  rtw_phy_set_tx_power_level+0xcc/0x1a0 [rtw88_core]
>>> [   26.518864]  rtw_set_channel+0xc1/0x120 [rtw88_core]
>>> [   26.518878]  rtw_ops_config+0x87/0xc0 [rtw88_core]
>>
>>
>> And many-many cyclic errors like (size 224 & size 512):
>> *cat /sys/kernel/debug/kmemleak*
> 
> Can you submit a patch for this to resolve the issue as you can
> reproduce it easily?

Greg and Богдан,

I had previously reported the memory leak at 
https://marc.info/?l=linux-wireless&m=161677626908838&w=2. Unfortunately, it is 
not obvious how to fix it. When the routine exits, the skb in question belongs 
to mac80211. It is not clear why it does not free it. I also have an Intel 
device that uses iwlmvm. Although the calling sequence to ieee80211_rx_napi() 
looks the same, it does not leak the skb. Unfortunately, none of the mac8800211 
experts have responded to my E-mail.

@Богдан: What kernel version are you using? With kernel HEAD, line 1661 of 
drivers/net/wireless/realtek/rtw88/phy.c is a case statement, which should not 
generate an array overflow.

Larry
