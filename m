Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894983779AF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 03:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhEJBSD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 May 2021 21:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhEJBSD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 May 2021 21:18:03 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765EC061573
        for <linux-wireless@vger.kernel.org>; Sun,  9 May 2021 18:16:58 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so2869462otq.7
        for <linux-wireless@vger.kernel.org>; Sun, 09 May 2021 18:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qsNERhZgjuPkdaoU4D9L9ugofC2+WkakTAJu65zjTpI=;
        b=A+tfmaSxdtS4BNMa8FulOkGDq5BGq8qO+NoTVyfI4Ez0U0gy08x0OkBUgRx38jhhQ7
         sLTw06d9iNe2z3GeMbrM+hOGSKansNGRAe9QVjfL662XFyJKignj7FEH9/k+ou1lgo/E
         4knU/6FnQ+DjiBqK0z/tROeq0p8kxmZqAfLnmAGEd3UvbOHMB7IUTH3VFFqMXc/eYOP/
         SypJ0PZyE8TXVUsaMzymqIye08X5q1zvWpPkHLMHRn8rb16VFqT4g+oawIadRn7bxBMA
         Z719rkEqreLX3Ub2B2Q3v1gr2JWhdpmckjIGeWw/qML7tjJxXt1pKo14prbYiixq7tb1
         SFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qsNERhZgjuPkdaoU4D9L9ugofC2+WkakTAJu65zjTpI=;
        b=ISpi0YDo7L0P0HGnWQOaO2jU+mLtLjyiq1tRhlZDkHSvwRGoi224lMX2gU9cyMo1EK
         EBIaPtlQ0UYVHaXrFkRoPG4REm0/f/w2WY0jjzEoSPL79LLmt7t5HoHSGwDa3rtl6WTT
         vLhymhPBex2nkrGhh8vGrWtBz0Bu0FdrymlvhHsx5Ofz2NlH9UeyJuvQtWj1wGzJsu95
         PY8PKweyUap/N+RcA7YIqHGOoOscRHseIVGODnBRme4SPLWJbDUpLQVTUkHMf0TjqhCI
         EFPsdt2d3lbpthAvaHVKz25aG4UwDGHVuA5geYzUSUrvHM4B5Ww2sj+NJgNvCiUm5che
         gQyA==
X-Gm-Message-State: AOAM532/sY8Z+z0BfS0QDPtN6n949haanTV9Pox3ZzBWCRMMJ/1aB8ch
        bcRYrsj+OLq5LwJE4NNHBYMNJ00LSto=
X-Google-Smtp-Source: ABdhPJxJGq+SI92ZJk900WkyFhaTFMAiT6w8sNrKEqotBwHSguHxs8nuoc8GK306Vne+dUO0kOzM8A==
X-Received: by 2002:a9d:6d88:: with SMTP id x8mr2663902otp.35.1620609417601;
        Sun, 09 May 2021 18:16:57 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l186sm2315452oih.55.2021.05.09.18.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 May 2021 18:16:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
To:     rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net>
Date:   Sun, 9 May 2021 20:16:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/9/21 2:35 PM, rtl8821cerfe2 wrote:
> Hi!
> 
> My system freezes if I use this driver. My laptop's wifi card is RTL8821CE, type RFE 2. My laptop is HP 250 G7, model 6MQ29EA.
> 
> It happens within a few minutes after booting if I don't do anything out of the ordinary. If I do a speed test at speedtest.net, the system usually freezes during the test. I have to hold the power button to shut it down.
> 
> This happens with the 5.12/5.12.1 kernel provided by Arch Linux, but it also happens with the latest rtw88 code from https://github.com/lwfinger/rtw88, revision 22f319b11d6d3c4a3ac9e1f90e3433ed9f5ecf11.
> 
> I have been using the driver from https://github.com/tomaspinho/rtl8821ce since late 2019 with no problems, even with Linux 5.12/5.12.1.
> 
> I tested all combinations of rtw_pci parameters "disable_msi" and "disable_aspm". Nothing helped.
> 
> I set up netconsole and added the parameter "loglevel=7" to the kernel command line. Unfortunately all the messages that came through netconsole also appear in journalctl, so I got no new information that way. I used the driver from the stock Arch Linux kernel for this test.
> 
> I'm attaching the file "journalctl-nono.txt", which contains the output of "sudo journalctl _TRANSPORT=kernel" from the time I tested the code from lwfinger/rtw88.
> 
> I'm also attaching the file "journalctl-senorsnor.txt", which comes from another user who has the same problem. Their wifi card is also RFE 2. Maybe there is something relevant, I don't know.
> 
> I'm happy to provide more information, test possible fixes, etc.
> 

The only splat that shows in either attachment is due to you not installing the 
regulatory database that sets the channels etc. for your domain. I do not know 
what it is called for your distro - it is wireless-regdb on mine. It is unlikely 
that this is the cause of your problem, but who knows?

Larry

