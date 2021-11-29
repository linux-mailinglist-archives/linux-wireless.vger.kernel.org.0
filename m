Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2B462544
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 23:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhK2Wh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 17:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbhK2Wgu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 17:36:50 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADAC093184
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 13:42:58 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id n66so37193538oia.9
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 13:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T/vzAcVpZ9VeAvISw30OSYLr7Jv01Vv83fgkvrB9VF0=;
        b=M4WgzXqv/fPo4kvjFIAblFPHoRmI7LN/i2UZd59HllDNzIxvqzoopAUZslMvFALYV0
         V6CrQMC6OJ0CNsnkxOLCiZ0fvPQ1KzYxRASdk/pVYIMxBfFx+un8kBM7XpqVa2IdKBpK
         HqG9rsUh+aOREevwfuuhg+nHxkf0OQlx8P2p44dK1DY0gtE95nDMj2xMEsWDjcFJVDQ1
         h+1MCncyJM9JJCQqGFhM6DK3Z/Lj3OCH5Zwz+T5LdroQodFYQHyh0zuU4xmt75X+8JHC
         E/lRihfUuf/HUEy4Aw4SM0020dGj+KjoC8SdM9L+ckh806SF6Caaprj7ll+rS+nfKxtX
         DyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T/vzAcVpZ9VeAvISw30OSYLr7Jv01Vv83fgkvrB9VF0=;
        b=3e89juxsQWgyzzfKPofRulrjhFYmMMHMBYcommjmKO64lJBTGX76LTjo215vUM3IWJ
         kLlgkYR0ZvsT/AK2V9Rfeluvyg+xL/gs8uTqcodMm+HwRuejVx0V49NqlXj3i7CrAl+1
         y9Iq8Cw2eryQtTmGJ5i8LuBfeZHK5wi1xiMvfvKQ3h5DmDZz2xr4go/tnfoPhI3VfrK5
         GjGMuKyU0cYu+wNjjQogDuWkOqcHKEnmHfS1BACl+WPdUC3UudoJ8r8w85wfL8y57x0B
         lYkVjoFP1RmXR/p5gzpFVYVs+KHZuSBuohJKC/VzXIO6pVuOZx4926XI77qakJZl05Gk
         9nkQ==
X-Gm-Message-State: AOAM533jxf2AAsybG1y21Nl5VTv6esVkzkbUQoloBrX0lpXx3/BIC/ux
        nUrMXUstxuC2FL0mMpgec+Q=
X-Google-Smtp-Source: ABdhPJx80Knn/mtrd0eV1XbXdHpZWIW86ukmAjBl/8DT1S4ec0Uy955xrRYEvsyN6ndAZWtuvH8HVw==
X-Received: by 2002:a05:6808:3097:: with SMTP id bl23mr631202oib.0.1638222178035;
        Mon, 29 Nov 2021 13:42:58 -0800 (PST)
Received: from [10.62.118.101] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id k14sm3322961oil.38.2021.11.29.13.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 13:42:57 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <917dde5b-36c7-a079-6dc1-7441a2f90745@lwfinger.net>
Date:   Mon, 29 Nov 2021 15:42:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: USB for rtw89 driver?
Content-Language: en-US
To:     James <bjlockie@lockie.ca>, Pkshih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
 <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
 <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/29/21 08:24, James wrote:
> 
>>> Does anyone know if the proprietary driver works on the Raspberry Pi4B
>>> (Arm)?
>>
>> Don't have a proprietary driver neither.
> 
> Dlink seems to have added USB support.
> I assumed that is proprietary but I guess that is only x86.
> 
> https://support.dlink.com/ProductInfo.aspx?m=DWA-181-US
> 
> There is also an open source USB driver on github  but I don't think it is getting fixes like the lfinger github one.
> https://github.com/neojou/rtw89-usb

The D-Link driver is for the rtl8822bu, not an rtl8852au. That would make it for 
rtw88, not rtw89. BTW, it will not compile under kernel 5.16.0-rc3, but the 
fixes would be minor.

That driver is the usual collection of junk code published by the Realtek USB 
group for years. That code base is used to generate drivers for Windows, Linux, 
and FreeBSD.

A group is currently modifying the rtl8188eu driver in staging to convert it 
into reasonable Linux shape. This one would take the same effort to make it 
suitable.

The basic USB driver in the neojou repo should work, but I do not have an 
rtl8852au device.

Larry

