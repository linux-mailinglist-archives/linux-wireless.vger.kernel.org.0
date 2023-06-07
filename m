Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464072652A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbjFGP4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Jun 2023 11:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbjFGP4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Jun 2023 11:56:00 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8E1BF8
        for <linux-wireless@vger.kernel.org>; Wed,  7 Jun 2023 08:55:47 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1a2b4b922d5so3065452fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jun 2023 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686153345; x=1688745345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xno6+rvDXRQ2iYEp1Au2DT3pf1LsTFmaXENNHxMefDA=;
        b=aDeF7qOgXafB43ynUt9JYGoIgFWgB7M4wdOu85PyKqHBNxZ4w0ZTTGrvyqgCsjfWfw
         BcIjF0lFpcaDqsX+ParY/HOLKvMJeTGw2N5qUMMGhstMxEAqyky+n5ijWj2gSW5+/pNR
         5Rso+Pnd9Wze7I9OVoKxkaThHy0n4K+/FAs5TnM1b1SNzRoROvD9L1KvxSTZqsMdeLnV
         0YloXIzpwWXGDtPpdTL/bMIQ7PnfSK2arBMhl5+5/aWwZpUpPU1pxI564qhN8E/UEvLe
         CI/lteCy9PnWCip74D6qUbyBJ5tqwdUMlOZZgMe2l7kM5JlHHCWGblIVpJaZtMV/JJjK
         Uk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686153345; x=1688745345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xno6+rvDXRQ2iYEp1Au2DT3pf1LsTFmaXENNHxMefDA=;
        b=cd6DSXrwztf85JVEz7E0HKWr46JN2n9H6v54tdWyFVsuQtpOctcHTL5d0riehdz7Ig
         zmnTVMFCVw/lV6vOdCNPfJOwSv69eQwgTmKyXhAw8ztpeXD3mC1kAHFb5WBLmoovTD0Y
         byNMD8ppdF50RCJWx0O8TTDNq1rEZXzP+3qAMBS8BNAFcjEQv+hccBCHS9/puZDUkQ0Q
         X4GmYGspEbnoxrFfT16nIV9ehfCms4+57JXn/MN4H3UN1VkIOLazza/A2W4Bz7aegddh
         1Gvu4gPjUrhOT7wx0+DlNBGi35/HfgRTzxDq+bMNPzkGVbPUI6X/svZdXVZoVANCGnDo
         I9ow==
X-Gm-Message-State: AC+VfDykxXnreoRVqBq/4/o9bvxcjLjB/X86PTcHbh6VcAe2qnjkQY0u
        IiSlnkbPASSwyJECOfFuYVhBz3eCW+Ao2A==
X-Google-Smtp-Source: ACHHUZ7oukVrPDGxKzC4PYkX4/hnzakQlrLffXgc2yVIJAO8FHMfa1WLfgwMfN8Efs5QVVqy81Rbzw==
X-Received: by 2002:a54:4487:0:b0:39a:a92b:c546 with SMTP id v7-20020a544487000000b0039aa92bc546mr4106387oiv.19.1686153344843;
        Wed, 07 Jun 2023 08:55:44 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q133-20020acac08b000000b0039600e3376asm5948109oif.1.2023.06.07.08.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:55:44 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <1231d03d-722a-4282-8066-27dd8a516163@lwfinger.net>
Date:   Wed, 7 Jun 2023 10:55:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: RTL8822BE not working after suspend
To:     Utkarsh Verma <utkarsh.naveen@gmail.com>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
 <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
 <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca>
 <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
 <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca>
 <1bafa8c6-fc0f-2928-712d-c24dc0a6d18a@lwfinger.net>
 <CALKa4bTJMQqhH5rDcReMWehdc1=Dj3J+danGToMpqe0hj6nNSg@mail.gmail.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CALKa4bTJMQqhH5rDcReMWehdc1=Dj3J+danGToMpqe0hj6nNSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/6/23 20:04, Utkarsh Verma wrote:
> I have a small request from my side as a user. Please mention on the
> GitHub repo that these drivers are not in the kernel yet and will be
> merged around Linux 6.5. This is because I stumbled upon this repo a
> couple of times before as well, but I did not trust it enough and even
> thought that they might be older than the kernel's drivers.
> 
> Additionally, is there any way we can have this working without the
> systems module loading/unloading shenanigans? I would love to see this
> work by default, as it does on Windows. I can help you with the driver
> testing if you wish.

I could make it more clear in the README.md that the rtw88 repo has code that 
will be in a future kernel, but that information is available in the git logs. I 
cannot help your trust issues!

The problems with your BIOS that require unloading and reloading the driver when 
suspending or hibernating are found only in some HP or Lenovo laptops. It is 
beyond my capability to fix the actual bug, thus we give you a workaround. What 
does the Windows driver actually do to overcome this problem? As none of us have 
seen that code, we have no idea!!

What harm is there in running the unload/restore script? On my laptop, it is 
totally transparent except for a few extra lines in the log.

Larry

