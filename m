Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226886A9B3D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjCCPxn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 10:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCCPxm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 10:53:42 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350031043D
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 07:53:41 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-172afa7bee2so3377565fac.6
        for <linux-wireless@vger.kernel.org>; Fri, 03 Mar 2023 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xb+OmR3+4HrL60FugcZ/GwBNVBERxf+88L102vrgLXQ=;
        b=T8ARMIVPetJtgNeksYUAZ/ULLeFVzhOtJrVYayGsa9hbtLi1HQXXsN4hUkCBBGqK74
         8t7t32NN4gfAEaxxIVYgmSBfRbtuzD5dFdsUVwYVl1VArIcW59FNOFw5tTk97Bfy2iQA
         p4tZAt50mLDbJTKQk7i4yN3ECmjVxHKCeb3BWwqv84wA0C4kdJuvQnG+1roPIPHTeCSP
         jg+ZSpp70er72RC8eZNdeWYTcgdtIpssjZy5b61KmCugRwkA+Gxg2y3Q5OsUvYGdi84J
         5dXAZtyiOIC5L3RDB7z7NoEJZCjnB7cneb+F5i9/UzQuLglKkhOD8nIqRLqecI6jDKKC
         bjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xb+OmR3+4HrL60FugcZ/GwBNVBERxf+88L102vrgLXQ=;
        b=nG+R/sLEXD1bsonU92QWYXnmYixuaVlmb3vls3H6VBAx6QXtchwOLU41+dGi0oQq0T
         HNDV1KmMvUo4dypj9jNqgWJ1PVpWn0eSnOkW6ZYCb1mwcTMslQuRsib9bZAEgsiN6uLr
         oE8LorLmp+XSzjCkqPDJe+5thKI9cNMDaI0xqkk0nzz3fzcscvxJj/ttUwoLhzAoUqZJ
         lfUbHQ+x84jHODxuJ4ZhlAOEpfKASs6jdRE9TLln2BqLZd+iEZfgNH0QwCWevb5G4IJz
         fHnLY8e1RgzucNJeUx1ybsoMv2Z+STmI66wOBB+Kar6Tm32daPPqzs2VH/PQyAO+1vd7
         6AaA==
X-Gm-Message-State: AO0yUKXNTTLMGOmszeaD8apHwtR50D7xBLB6mdmIXBFmOg5VT062CiCJ
        r2nZYgGVdQoJ5G7tyqX4kSk=
X-Google-Smtp-Source: AK7set9BaQFG4QkN8mZhTpN9O6GG8op02r0HXFKrLEvWnYtPo8kSzgKkI8B950ci5f7/Lmqvup7TyA==
X-Received: by 2002:a05:6871:414:b0:16e:676:bfea with SMTP id d20-20020a056871041400b0016e0676bfeamr1465479oag.9.1677858820525;
        Fri, 03 Mar 2023 07:53:40 -0800 (PST)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id v42-20020a056870956a00b001762d1bf6a9sm1094211oal.45.2023.03.03.07.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 07:53:40 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <71855f0a-c8f4-9011-2edd-08e1a3eec782@lwfinger.net>
Date:   Fri, 3 Mar 2023 09:53:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Issues with rtw88_8821cu
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "Alex G." <mr.nuke.me@gmail.com>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        neojou@gmail.com
References: <ee614c10-cfd7-de88-3f85-6448aaa17c5a@gmail.com>
 <20230303125147.GV32097@pengutronix.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230303125147.GV32097@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/3/23 06:51, Sascha Hauer wrote:
> documentation for these chips and the downstream drivers are a complete
> mess.
> 
> Have you tried one of these drivers?
> 
> https://github.com/lwfinger/rtw88
> https://github.com/ulli-kroll/rtw88-usb
> 
> The code is based on the kernel driver and the RTW88 USB support in the
> kernel is derived from these drivers. There is a chance that I broke
> something while porting it upstream and if yes it should be fairly easy
> to sort out.

My repo is based on code from the wireless-next repo, thus any upstream error 
will also be in it.

Larry

