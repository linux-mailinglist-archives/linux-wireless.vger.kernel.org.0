Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309661E0410
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbgEYAC7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 20:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbgEYAC7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 20:02:59 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E998C061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 17:02:58 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d26so12631548otc.7
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n9Vx9NvGMoEY67+PuuJAu6T2gQaNrvsedW9NpfMHlHM=;
        b=c5bs4d4bIEO5FeLdAJBv5MP+ora7SI0zbGmD0a+y/G7myWZboEepuKVQzBnV1iGbcI
         JXL6/YRCr61Ptq3MjxNYkLPVMOa3KrRpscyaDQFdW+dKYTBYwdfmwema4GjiX3gAplmG
         +l24qL7mMjPcKK6j+ZJV7dt8vDLeh9J2jOEoKimZdM5jeM7VC0Fl3xAnGDp5WHFQxBFd
         eF/nVEUZ6b+T75dpeRnXQQ3R4eLey+tXyZWn+HMyMjnxMyNAl02sbA4FCho6NB+c98l2
         rYFfnkcSzitJFHkEm40JRGH/zOvvbN1V1nVa08OBGmOZsau/j2S2CJpJQg/gfFs4OuQX
         EzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9Vx9NvGMoEY67+PuuJAu6T2gQaNrvsedW9NpfMHlHM=;
        b=LRv34+Nkrnu/Od4RkvedMYgB1D3jIVu2xSES2n7dsWBPYhhDTVzxH0a6m0BzMRl73h
         FJewouHLHkfZeGjFJdU6+ttJaVgauYP1SvA+2El+IBkqaGYVnrT6Lbs2OUov/Jp+v7j1
         +LRv9xrxgxJdCY7vs38XEo+5OrDhbyu5A4QoMIB4oewZx82T9yYKHFVmzXv4heUIvokP
         QgWag1BygC4LVkpRkLrfgXgK5Y2chXuyOgvxoPs/QXT/GXcbzZWICgXHbH/zTzhpGLbl
         b7LtnzfEPY9uqC1iWywhdZzcFdpbSSHESjKpQ0+s8UPdKX9wIxcl2cVYK0MShrYGJfBO
         M/cw==
X-Gm-Message-State: AOAM530kG27MV+sJG57PXbK2iBQGLVlcBzZPOFr0ZtDEaxOtDRzXYtLa
        2JeCPdzjovJJ4KTliPXiJ4kYJ2o/
X-Google-Smtp-Source: ABdhPJy8p6bPlwrrNhZMuVkm886mVK90PdQsviU8ms/KfZR/iAGOmK7YtniAzyd3lmTRHdBqd9Juxw==
X-Received: by 2002:a05:6830:400a:: with SMTP id h10mr17594849ots.105.1590364977255;
        Sun, 24 May 2020 17:02:57 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c12sm4844834oib.22.2020.05.24.17.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 17:02:56 -0700 (PDT)
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
References: <20200524094730.2684-1-rsalvaterra@gmail.com>
 <20200524111751.GA914918@wp.pl>
 <CALjTZvbHbMEWTmZk4Li5ZNAETdVd3Q_kHUS6KQw+WDS6ayE9vA@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <12222a10-e5d9-514e-7667-0602919a4866@lwfinger.net>
Date:   Sun, 24 May 2020 19:02:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALjTZvbHbMEWTmZk4Li5ZNAETdVd3Q_kHUS6KQw+WDS6ayE9vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/20 10:07 AM, Rui Salvaterra wrote:
> Hi, Stanislaw,
> 
> On Sun, 24 May 2020 at 12:18, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
>>
>> AFICT more work need to be done to support MFP by HW encryption properly
>> on rt2x00. See this message and whole thread:
>> https://lore.kernel.org/linux-wireless/977a3cf4-3ec5-4aaa-b3d4-eea2e8593652@nbd.name/
>>
>> Stanislaw
> 
> This RT2790 has been working just fine with my patch for hours. No
> hangs at all. What additional bad behaviour should I expect?

I read the above thread. It seems that the best thing to do with b43 is to send 
the MFP_CAPABLE only when nohwcrypt is set as a module option. I wish it could 
have worked the other way, but I think the potential for keys getting out of 
sync should be avoided.I still need to find a place the log something when 
ciphers are present and the option is not set.

Larry

