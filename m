Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14CF5FF46E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiJNUQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiJNUQS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 16:16:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8080AE77BB
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 13:16:13 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n130so6204359oia.6
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TITCHpO8o8C79rIpo9L5QYUhST5Z8U6+wfGjl8SgYss=;
        b=MtOfK4soEqXH4dnrJP1chF3L+fp1y7uayALUZg1VOWPP9zWBJpBnRCkFbS6VTXXWFq
         zCyG/SoVBaAPnDt0Hy9h3mIAp5j/1nAUEknN7Gy4i9hFC6oNJ1FFFiEbHZnWNqMQ35Q/
         sUC1Ps1p3n1gRtbkcsKhPV8rktyOwzzTzQSX4HNyWxaRIxNhPfW7jC11gHPZYAleXxca
         PiW+ecqDCI0ZOuCyFTgngCD7sXHf5B3S5HKp0JRH5BwBdF3iPvaGXkQbkPUJ9ZmqBvkZ
         4AzwfbUCWCZaLONen22GlNoWeok3NUzjyk69U89YirMkLlKihxDbU2+UmxKNe/DgkKYL
         YbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TITCHpO8o8C79rIpo9L5QYUhST5Z8U6+wfGjl8SgYss=;
        b=MFYmWV56UgCK6HX5s0cP8sWZ2YbQDieQAYy1uQidIBs/TO/IY2WSTVPPumxV07UJmX
         MxF2SRi/0Gwi7ePZvRrBAZvNeZeNjAJaAlIKDUr8CrgkKkAGNHrqBFeH7oaLa2eT17rh
         zGvrIxs0X1HTkb8OVI9V5r+49HPeMQzAv3XDGXR8ePIBnwKi+UlFnSHsY4Pt4hsixXGk
         jtbE+shpAYRqdnkd5FRQIGWSzZMTPi56i7jAgSjkO1YYFIBTmhXRnYodfImXkl3MsN6i
         wHFPQjTCjeqI5LbslKEirRNmisUFgPniMuhnrIXL/Weo3pVkVy4D1O0nMb3AJPnTnOKV
         4nDg==
X-Gm-Message-State: ACrzQf0Vqog/jcd/MEYWB5aO1bYx/tUBx9jJVPlV0PNoPeRxpodMCG3t
        xCZxwI2Tx24p9vpUoO5LeJ6P5xQ7c8k=
X-Google-Smtp-Source: AMsMyM5DwGgJXa9APM3R7xSarh78io8y2tpueWtA/rM3cTXy5edypC+dh0K7Ha/elEkGLeWtTfYEvA==
X-Received: by 2002:a54:4815:0:b0:354:cbd2:4dec with SMTP id j21-20020a544815000000b00354cbd24decmr3205990oij.289.1665778572794;
        Fri, 14 Oct 2022 13:16:12 -0700 (PDT)
Received: from [192.168.0.158] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id l10-20020a4a434a000000b004768f725b7csm1351714ooj.23.2022.10.14.13.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 13:16:12 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <41d85c23-2735-ed7a-21b9-36b9f7be5439@lwfinger.net>
Date:   Fri, 14 Oct 2022 15:16:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Splat from net/wireless/wext-core.c
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <988d4c5c-a9a4-2f16-aa3c-e15778c04d46@lwfinger.net>
 <5da63402ee109ab6df3e0cdbaab3ddaa2156ab8c.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <5da63402ee109ab6df3e0cdbaab3ddaa2156ab8c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/14/22 11:57, Johannes Berg wrote:
> On Fri, 2022-10-14 at 11:49 -0500, Larry Finger wrote:
>> Hi,
>>
>> With a recent pull from kernel mainline, I am getting a log splat shown below:
>>
>> [   29.369446] ------------[ cut here ]------------
>> [   29.369447] memcpy: detected field-spanning write (size 16) of single field
>> "&compat_event->pointer" at net/wireless/wext-core.c:623 (size 4)
> 
> 
> Yeah fixed by commit e3e6e1d16a4c ("wifi: wext: use flex array
> destination for memcpy()") I think?

Johannes,

Sorry for the noise. That commit was merged when I did a new pull on mainline. 
My log is clean now.

Larry


