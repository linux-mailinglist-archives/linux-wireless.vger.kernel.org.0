Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA66D6924
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 18:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjDDQom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 12:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjDDQoi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 12:44:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4339E6C
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 09:44:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-17683b570b8so35234100fac.13
        for <linux-wireless@vger.kernel.org>; Tue, 04 Apr 2023 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680626677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ofVcYIhCC/Eq9oHy7qJDRdf8r9zfv+gOplIFnQDjyBg=;
        b=gHzQQ781HnBMHDp3vb6zJS9RUIrkZ97+8AGK1AujDE5cVqpihOhhs1XtQSstBiBPEA
         0aXUCko/YqBRa1rkOwETQ7Q6xC+ccupvEuD2r6pHgNhK3SD38d+a+SVcpmmojWfP1g81
         gn/foQvtyh3wq6fIPLziRWwOr/E02z/SeFI+YPi9jROsHGihlWr67e2AsHxEmTsUCQ4F
         xPd3qRxpG2ZQIX9eG9mjpKctbCJOMSns2UnqrevaAzAj4Y7WER9fHF9eAN/NmSPjSPAR
         c+s1iSuJZet8ilP3H/zQlOoq51FaUj6qemJRspw85TR0NlaYr4//GmH2XdWm5NgaI2K2
         64AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofVcYIhCC/Eq9oHy7qJDRdf8r9zfv+gOplIFnQDjyBg=;
        b=hbEcoxQmwEY6k7YLMlwkDu3XUNYSQQ2zqk64gQGSd8Ciy2Cs9UcsH1SrEwgWYWT08b
         3m0rCP7Kl45FfsO54vFKLgmeutVlC4vHT9olyS9Bgbd6J5qFj3uZW2dMQmxOopP4p0ei
         Fg46Q1Mx9ieeYwMBhyvv2UR4pXiYxEN8QD3iDVxMlwzwI+dYhMa440w351G3TKejlSE8
         9pLeu/SR2XFElwZNuVeSelskTVnDp9sBA2E5e9GA4evMmHH6mKOqoPr6pkycYL5g5W/B
         lWq8zvh8v9Tff/y19fvb1DZRI0q3kpQvUNiI6hEQbDf9IRmgWRSHOBAjX5OCs/p8jeE2
         exvA==
X-Gm-Message-State: AAQBX9etobtwyMB5bGpPh0AAkdNIWlpGjEXkJQVVhbe9TcN3lGMKsSBe
        AyTAAASxscvycrKbw6ZQeAlbiLMSJ4o=
X-Google-Smtp-Source: AKy350bXiltCislB7E4Jy/ED/iCav0BxOqAuRUWW7TIhrGuM+km4VCuv3m9suHt05GQT9K/u0VoKeA==
X-Received: by 2002:a05:6870:82aa:b0:177:b1bf:9368 with SMTP id q42-20020a05687082aa00b00177b1bf9368mr1894281oae.24.1680626676966;
        Tue, 04 Apr 2023 09:44:36 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id bd27-20020a056871b31b00b00177be9585desm2544356oac.1.2023.04.04.09.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:44:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6e18fe31-ee8f-3286-5f4c-53a01e20e4b3@lwfinger.net>
Date:   Tue, 4 Apr 2023 11:44:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: rtw88: kernel NULL pointer dereference
To:     Tim K <tpkuester@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CA+shoWQ7P49jhQasofDcTdQhiuarPTjYEDa--NiVVx494WcuQw@mail.gmail.com>
 <26b9ce8e-a100-399d-58d0-0a649380f8cb@lwfinger.net>
 <CA+shoWRY+wqj=5rFpM5obNB0t0=vKCJHzR0hAkf2Wz1D0ap0bw@mail.gmail.com>
 <9640df2b-1241-8ddd-8a59-a0578ff08ebf@lwfinger.net>
 <CA+shoWQ_bKF9bAeL_XWu+=B2BRGBeb+5W3uMVXQe=p5qntCkZQ@mail.gmail.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CA+shoWQ_bKF9bAeL_XWu+=B2BRGBeb+5W3uMVXQe=p5qntCkZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/4/23 10:07, Tim K wrote:
>> As rx_status is local to the routine, the error has to be in the right-hand side
>> of the statement. As hw->conf.....->center_freq is apparently OK most of the
>> time, I think you are getting a spurious RX interrupt. I have pushed a patch
>> that will show if hw is NULL, and quit the routine. Do a 'git pull', make... and
>> let me know what you see in the log.
> 
> Updated the drivers to e6d63e1 on your github repo, and ran for about
> 16 hours happily. Came back this morning to an error. I've attached
> the stack trace, and the line of code that caused the error.
> 
>>>> l *rtw_rx_fill_rx_status+0x48
> 0x8cd8 is in rtw_rx_fill_rx_status (/home/tkuester/code/rtw88/rx.c:163).
> 163        rx_status->freq = hw->conf.chandef.chan->center_freq;
> 
> Much to my chagrin, it seems I have an intermittent USB cable causing
> spurious disconnects. However, while this does appear to be associated
> with the issue, I also discovered this issue 20-some odd seconds into
> boot on one boot cycle with no mention of USB disconnects.

Tim,

I suspect that your intermittent USB cable could also produce spurious 
interrupts, which I thought might be the cause of the problem.

I had done some updates against wireless-next yesterday. To them, I added an 
additional check in this routine. The driver should survive things like bad 
cables without crashing the kernel. Do a pull, and let me know what you learn. I 
would appreciate learning what happens with the faulty cable.

Larry



