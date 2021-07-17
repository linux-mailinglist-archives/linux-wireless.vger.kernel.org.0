Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194663CC23A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhGQJm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Jul 2021 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbhGQJm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Jul 2021 05:42:57 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24597C06175F
        for <linux-wireless@vger.kernel.org>; Sat, 17 Jul 2021 02:40:00 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so12574785otl.3
        for <linux-wireless@vger.kernel.org>; Sat, 17 Jul 2021 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4LdQ8zfbRaYWvmngS3pfQwz120CHXSSdpaWyamdxufU=;
        b=uBe93ffvZY0x6xzebaGPb7qUNuq3UbHemcsRll6Zg2NoYMTwLin7b9a+EJtOTxmHRd
         jTdbnN5L0XZi3wo7Wnl33ogrNrPUvLWoPUkuYOV0V6ROo483emKmQ8bBLU5YOlCkuXLC
         XgBtgLNAetmS/kJKF22Ew38f+jJM+ui6VWgFogZz+1XYeI08U+vw6kjZp7yv90xRqzHI
         ozKkygY55MDP/Z25KIphjf4nknxat6n4YgYjWnDz3fQtVX9t2xutV+fbpM6iAprWn0Yw
         1mF9C4Z9C9JbZTy4+0rqj6NvF1BtSnAvOHjQpkzJTmTmsRDwEwlYzz1+WYAcALKOS6jr
         6a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4LdQ8zfbRaYWvmngS3pfQwz120CHXSSdpaWyamdxufU=;
        b=Uk4RS+OHXaD9CXxlzZDuii2doGwav/fcf/A4Jd5Ikzxg+dN+KrCS4t6YWyU8ht7rjE
         QaN1cmD+Db+rYBxk4sArTr6ETNgxbj9iXeCjtsVaWUOuPCnZlyEEFMjlw5W5J7Ty+EtX
         5gVg7MGGeSSPAehrwYJW7UsCQilUexZl/2WMWlLIwQv3qo97veASo1mknsjl5lkYW4Y6
         sBzoq0aBx4tvnQxf/v9yZgFe4B4qNxugIM5JWTq4HDrUZv3lcoruFoT+98D2ZTSiufkm
         9EX3i/6JW6XXixXF6tJt0epHW2+vk4xKrHeYC1sE1KMCL9S0pO0NRBK//BXv66kEmlOn
         d56Q==
X-Gm-Message-State: AOAM531NseU8j93/9DqkFDR5zJMlW/ZQwd7c+TMpLFAfkVpqcAvyiTbs
        cs3kdB45jyJIQupcwCRpdiJmhnPFG/I=
X-Google-Smtp-Source: ABdhPJy3ZNKL72En0UrpQUKwe3EZPgVn9WdICczQIl1YeFb2znCaT+bGLVv4XKx45WdCQ7M8No7AEg==
X-Received: by 2002:a9d:2621:: with SMTP id a30mr11436539otb.221.1626514799123;
        Sat, 17 Jul 2021 02:39:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id b11sm2521329oti.30.2021.07.17.02.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 02:39:58 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Difficulty connecting to AP using rtw89
To:     Pkshih <pkshih@realtek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <f2ee1dbd-28b5-a1e6-8f41-e7ed8dfc2521@lwfinger.net>
 <d74a6a489b2f466eb66df3f5f965a1fa@realtek.com>
 <28f2a476-b690-24dd-df7e-f88f45b9292d@lwfinger.net>
 <04a1e9643c09406697b48f5f781a3e2d@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5d598377-e587-f9f0-8d88-97ba8449dcee@lwfinger.net>
Date:   Sat, 17 Jul 2021 04:39:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <04a1e9643c09406697b48f5f781a3e2d@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/16/21 8:40 PM, Pkshih wrote:
> 
> 
>> -----Original Message-----
>> From: Larry Finger [mailto:larry.finger@gmail.com] On Behalf Of Larry Finger
>> In a separate question, will v6 have provisions for IPv6?
>>
> 
> The driver handles L2 things only, but IPv6 that is L3 that we don't have special deal.
> Could I know the problem you met?

Personally, I do not use IPv6, but one of the users 
(https://github.com/lwfinger/rtw89/issues/19) has bad IPv4 throughput with his 
ISP, but better with IPv6. That doesn't make any sense to me, but I told him 
that I would ask.

Sorry that I have not had time for reviewing the v5 code. There have been a 
couple of emergencies with VirtualBox, which I maintain for openSUSE.

Larry

