Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A537760728B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 10:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJUIih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 04:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJUIid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 04:38:33 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4024F246C2F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 01:38:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id e15so1260685qvo.4
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbhtGgr0al6txR5T93Lfw5fuVs7gPv85CNB0re4+Lgs=;
        b=KrvxsvTZzo1qtxuTwxziMWr+eDR0z2w3HHgE5I4Tj1YfyeLadeOAiNgJ6KMDaKyfdH
         zO8tNGKcv5lLAqTzTxMAPMKVSJFW98SNQ0vKrFyGdLcj3G0lPgmmKyD3m4oMFFojDD/c
         l10+arcGUE1fBhD0Am8uzTF4M8pzRXr+hPgBGmBWy0y7rgjpwBoOpYYoAmyL4/sxd9w/
         FRO6jyVhal/d54hD8U6+Q++g4wbqXpy+BBizvsSynZMF8l+WhTZRjo1u6BuAiE93qbM4
         +ZvMTOmhCXr1MCYCpVgjENKIRLeDf6zzExNK/lr8i70KWdguUabrdxwQl339Azf99RfE
         JWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbhtGgr0al6txR5T93Lfw5fuVs7gPv85CNB0re4+Lgs=;
        b=hvBVC4Nin4vuwaBoRgTPAtRk2jBhxVYiwpLcKwyP4H4tXoiOEuIfqj/liuE7mA3vUp
         TgBSOb+WRnrdSjAst4pVRtNL6/4LZ2j/OjXeNgxttbFUy/17Pk6Pfs6cEdLGAU84y+xA
         J1g5UsJIGW69EM0XOqFvceyUylnaj12TdwD1ZM9cenMWLM4SeYy13iCiXEozO1eP4aO2
         PRaFD3SflSyyf2Nf0w9LaDNax+UHFT+4+PC/3HrFhS2xIGUKhUVTiwZlZKYriU4qzYhi
         BVQBxo0xsRAkvWRNOF2QuJ0dV8U8GFQXp1YzMllKG9WD1e/NgYzRiczytgQpD946ljk4
         +eEg==
X-Gm-Message-State: ACrzQf3Pq0h87qOhNExrouh5TqrnB60uXStEk9zkynA31sAKSCZTp8JN
        jlDqas1QMGnCLZw2Gdv3nFM=
X-Google-Smtp-Source: AMsMyM7Kr2z3dYWzzE2/k1tMq73IPMKD+Ns1c56G53dbWNmO1BYjyKhfoq9aclghqzr/jIjD1+qY5w==
X-Received: by 2002:a05:6214:d04:b0:4b3:fcfb:6464 with SMTP id 4-20020a0562140d0400b004b3fcfb6464mr15858407qvh.52.1666341503018;
        Fri, 21 Oct 2022 01:38:23 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id y21-20020a37e315000000b006ecb3694163sm8872267qki.95.2022.10.21.01.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 01:38:22 -0700 (PDT)
Message-ID: <10230673-8dbe-bf67-ba76-9f8cdc35faf3@gmail.com>
Date:   Fri, 21 Oct 2022 10:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] wifi: Fix potential buffer overflow in
 'brcmf_fweh_event_worker'
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Dokyung Song <dokyung.song@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
References: <20221021061359.GA550858@laguna> <87v8od1x69.fsf@kernel.org>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <87v8od1x69.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/21/2022 8:57 AM, Kalle Valo wrote:
> Dokyung Song <dokyung.song@gmail.com> writes:
> 
>> This patch fixes an intra-object buffer overflow in brcmfmac that occurs
>> when the device provides a 'bsscfgidx' equal to or greater than the
>> buffer size. The patch adds a check that leads to a safe failure if that
>> is the case.
>>
>> This fixes CVE-2022-3628.
>>
>> UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
>> index 52 is out of range for type 'brcmf_if *[16]'

[...]

>> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
>> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
>> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
>> Reviewed-by: Arend van Spriel <aspriel@gmail.com>
>> Signed-off-by: Dokyung Song <dokyung.song@gmail.com>
>> ---
>> v1->v2: Addressed review comments
>> v2->v3: The subject now begins with 'wifi:' and add a reference to a CVE number
>>
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Please include the driver name in the subject. And we prefer use
> parenthesis with function names. So the subject should be:
> 
> wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_worker()
> 
> I can fix that during commit.
> 
> Should I queue this to v6.1?

Please do. Probably good to add Cc: for stable. Should apply to older 
kernels as is.

btw. is there any formal way to reference CVE. There probably isn't as 
generally we don't require a CVE in kernel tree [1].

Regards,
Arend

[1] https://docs.kernel.org/admin-guide/security-bugs.html
