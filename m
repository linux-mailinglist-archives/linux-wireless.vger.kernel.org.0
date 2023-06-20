Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC34736175
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 04:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFTCRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 22:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTCRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 22:17:48 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66983A6
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 19:17:47 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a49716e9c5so4208054fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 19:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687227466; x=1689819466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GM90SJ/aEv5Euot2Vpd3XkNQtSmgcJOp+2Bm9Qx/9ug=;
        b=HYTGpx83vbIKsmFI7CLBjNLSdKTJxQG8JG/rMHhmkq4CQOQQsjNxbss1PIiL+7JlZE
         de39Xo/q4QTwVYE94VeDWAm9QqiNNDU49MZ8CdwGWxtuEPtPvm3V2rDXzNi7R/zuumM0
         cugxow9XmDrBWeMTjB5CUQS099A+XINvQBLHedb02f/bZPPP2pVisQiiS4Yx049qH4Oc
         NlpVM7m4INFoNCnF9mAT7HRJA7rynntGIDhZ+vSoCgSkdzwHvPO3GBKguusca5m6okoX
         3f6G72n9resI69VTizx+5f8zxpQ9EUpitnMWAoRvzEX/BpMH2u4vKLxs0HVa/dmD9uHA
         t88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687227466; x=1689819466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM90SJ/aEv5Euot2Vpd3XkNQtSmgcJOp+2Bm9Qx/9ug=;
        b=X4ENTiyU2IIuxObJ6dPkcBkeNro8Y5G5Pr7UmGbq1OOPQvYHxSKYx/BLOChludzbNx
         E1itTA7+pCCQUKfZj2UqDK7zS1tRTvNCudCXsS14WJ7vNxH/jpgThz/3tWsmoLl4LXO1
         VJgaXBaamKMmoreGXCsEm2EbeJrH8R+BFyq3Hk/iPyB9rPBuzqBzkWCm6hpD7CS/RSL4
         7+R5U1DHC3n2zYMFqH9ARd+C2MKYdKmSWjv3QLnZ4LRWOfHQHOHd70sxZ7MeGiIOBGvn
         biqxGk5ki1plXK6NPuZ/1o5tCdbh7fLghKFSOykP+RtcorhBYuE4OGSWpPerhhm0c5eo
         Jmug==
X-Gm-Message-State: AC+VfDzhdBjOHHD7HRCSoBMytKBbDLxAAb+fdKZ9OGzomULxOCtow6by
        jmXkeXGI9qQC5/YiBsccUKCvUZUSy7KMww==
X-Google-Smtp-Source: ACHHUZ4gau1EZuBPDUScM+XQ5knTtHJG0uZsIyoLzdi+f3VOIlgOVD+TefVO9biNv0axAxs7JseAZA==
X-Received: by 2002:a05:6870:c806:b0:1a9:caa1:9571 with SMTP id ee6-20020a056870c80600b001a9caa19571mr8365656oab.34.1687227466180;
        Mon, 19 Jun 2023 19:17:46 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id fz11-20020a056870ed8b00b001aa02b7bfabsm674777oab.33.2023.06.19.19.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 19:17:45 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <e21b462f-ac05-1b7f-154c-0dc8edddb025@lwfinger.net>
Date:   Mon, 19 Jun 2023 21:17:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: RTL8822BE not working after suspend
Content-Language: en-US
To:     Utkarsh Verma <utkarsh.naveen@gmail.com>
Cc:     linux-wireless@vger.kernel.org, James <bjlockie@lockie.ca>
References: <CALKa4bRo2DxK56pxDhqMJtr8C08OVsJ7KpVFyaELnttZaxgguQ@mail.gmail.com>
 <CALKa4bQ6quTd6PoHCt9wQ-x6LznzmSz3Vbw1aOTc21USgdnctQ@mail.gmail.com>
 <f622ae86-eead-b22c-10d1-c098754c34db@lockie.ca>
 <CALKa4bRr8z7FowCtZ-rSR0XMNEyoRbYsDu+Mswc-gs+s9Z0U=w@mail.gmail.com>
 <d443a746-106f-4626-85a8-deefe318b46a@lockie.ca>
 <1bafa8c6-fc0f-2928-712d-c24dc0a6d18a@lwfinger.net>
 <CALKa4bTJMQqhH5rDcReMWehdc1=Dj3J+danGToMpqe0hj6nNSg@mail.gmail.com>
 <1231d03d-722a-4282-8066-27dd8a516163@lwfinger.net>
 <CALKa4bSUR8UOjpue8nxkS61PkO6U6xygCdVqR-MMDH2w4XVwWg@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CALKa4bSUR8UOjpue8nxkS61PkO6U6xygCdVqR-MMDH2w4XVwWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/19/23 21:03, Utkarsh Verma wrote:
> Hi,
> 
> I just wanted to that after a couple of weeks of testing, I still
> couldn't get reliable behaviour. I installed the new Realtek drivers
> with the systems loading/unloading script. Sometimes my WiFi works
> after resume, sometimes it doesn't. I tried finding patterns, but
> couldn't. Please let me know how we can investigate this.

Perhaps your power system is taking longer to stabilize.

You might try modifying the unloading/loading script to have something line

#!/bin/sh
if [ "${1}" == "pre" ]; then
   modprobe -rv rtw_8822be
elif [ "${1}" == "post" ]; then
   sleep 20
   modprobe -v rtw_8822be
fi

If that still does not work, I have no idea what might be causing the problem. 
If it does work, try halving the sleep interval from 20 sec to 10, etc until it 
breaks again.

Larry

