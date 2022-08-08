Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184C758C829
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiHHMK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiHHMK1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 08:10:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5638AC
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 05:10:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d16so8333194pll.11
        for <linux-wireless@vger.kernel.org>; Mon, 08 Aug 2022 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5s6N1tgDZ2BQEGIP+tvG8pqTTCaTzwtNPh6tqB3uiKU=;
        b=bYZUKfDiDLe8x0+wGulMRF9HAz1UuAlA0O50CZ7esz4YjAEuHmCc3BSVxuWnHwIHN0
         j1R6znCs40UM5zIBx0eDq5TnQc/HGlE6V1B64efa/lrOq+6goS6P7Zvq8RErJqpPz65q
         qdFBoIJPa3LVL+n8GJIrNyuPpH3DRgaZBbqC99rt7iKcQf6xJUzm9EOHD4ARCH4tJq5Z
         MRtG+1GuNHqwUqpKIllbuRym5F01NrPlT0G9jhCaGZbql5QudyAA5BQKrYrOS/wYQmSe
         t3ZgUkGx3zVtyf7UXSpl6aIj2CJWZBLafCdj+SoT2mgZZ028rg8RQ+4+p+3+kvakfDKg
         LvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5s6N1tgDZ2BQEGIP+tvG8pqTTCaTzwtNPh6tqB3uiKU=;
        b=NIL/7WlCAggmt/Nc3EenxUBcVL+PrNCP9Q1fZX3d1wM6Nz2a8z59AUmeong8H0o+WW
         biXEPxVyFzxpF6KNDy1e2P5ecwMqTx+G2fu6ltPfBZ44olJJ0uhpuwz8rEL1zIPjg6UV
         Ei7FiiaCFmMnvav1D2wwEsragGQP8wXac++EG5599+pBPugMo99+0S1+owSfwqjk3MUl
         2GrJsX+o8LMgoiwS2K7bvwZ7mAG81VfSWaZZx/5Htk2ETBayvNlFOxNThpsEI6kdsyQf
         FjeQ1v/ZukNPcsztgoMpfJQ2MUmB6e7Km5WJdrhzHxPMoUnmCMJBug75gl9auF++Ek+6
         q/pw==
X-Gm-Message-State: ACgBeo3eUgssNdXAHd/wyX+vJbGaizsdec7P6DFajTmXRX23AcASd/Xy
        tg3MaqwY1+ZX4b+TZTvcTtqcP4EA88gJ0S8t
X-Google-Smtp-Source: AA6agR4HnVeup1UqE4qN4S+6zj8qCuBwKhJeOWVfup1/U4rLGS65xGqYa6AgsBZ0PCw2fbM+ADXm4g==
X-Received: by 2002:a17:902:7293:b0:16f:17c3:e809 with SMTP id d19-20020a170902729300b0016f17c3e809mr18612461pll.158.1659960626351;
        Mon, 08 Aug 2022 05:10:26 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id j18-20020a170903029200b0016db43e5212sm8538274plr.175.2022.08.08.05.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 05:10:19 -0700 (PDT)
Message-ID: <fa1879c7-ba9e-fcd7-9a5b-f6a187b74781@gmail.com>
Date:   Mon, 8 Aug 2022 14:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] brcmfmac: fix use-after-free bug
Content-Language: en-US
To:     Alexander Coffin <alex.coffin@matician.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220802172823.1696680-1-alex.coffin@matician.com>
 <20220802172823.1696680-2-alex.coffin@matician.com>
 <ff359bed-ddfa-9f18-e926-fad986b9918b@gmail.com>
 <CA+hUFcvJVkN6Z=x0paU3roCxOos6V7=L3gHoyCiOz4LKjhMWQQ@mail.gmail.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <CA+hUFcvJVkN6Z=x0paU3roCxOos6V7=L3gHoyCiOz4LKjhMWQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/8/2022 11:38 AM, Alexander Coffin wrote:
> I am resending this message as apparently it wasn't delivered to some
> people as it was an HTML message. I apologize for the double email,
> but I forgot to tell Gmail to use plain text only.
> 
> Arend,
> 
>> A commit message would have been nice...
> 
>> If there would be a commit message with some error report that proofs there is a use-after-free
> 
> I apologize for not including a longer commit message. I thought that
> my stack trace in my first email would be sufficient, but looking back
> I see how I should have clarified what was going wrong. What occurs is
> that line 360 of core.c
> 
>> ret = brcmf_proto_tx_queue_data(drvr, ifp->ifidx, skb);
> 
> may be entirely completed (as in not only scheduled, but also the
> entire transaction may have completed) by the time that `skb->len` is
> invoked which means that skb will have been freed by the corresponding
> later function (in this case brcmu_pkt_buf_free_skb if you see the
> trace from my first email).
> 
>> We only get here when ret is zero.
> 
> Therefore this error only occurs when ret is zero, but skb may have
> been freed after line 360, and before that line (369) if how the
> kernel schedules tasks is very unfavorable.
> 
>> ndev->stats.tx_bytes += skb->len;
> 
> Please let me know if you need any further information.

Not sure I've seen your first email. It is better to have it all in the 
patch so it is clear the patch solves an actual observed failure. So if 
you can dig up that stack trace and add it to the patch I will be happy 
to acknowledge the patch so it can be taken upstream.

Regards,
Arend
