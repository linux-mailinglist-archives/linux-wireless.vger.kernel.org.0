Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90744605ED5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 13:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiJTL3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 07:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiJTL3L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 07:29:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630211CB68
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 04:29:10 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t25so12543007qkm.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Oct 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90wiFngH1+zfXrSTTOx8+fdGzM6IhOrpFDU4dB9LYfU=;
        b=S5PC/bn5n9QDNPOQQlCu4/szd2WD1GwdrzV+nmHBkoT5XV/PicvlUy+egD5O+9PKd1
         ycxPeS0DUlOl4/FMi4wndekMAjXboJFXRfeXo9BgqvUa7NGvbPuE/fIPkU7msH8pyq4s
         tD/7gj+mtQS8rfJeHLbiqmeZ8YRhoqOvtj6T1WM+mWZuOdKC/LJilD44L4FelLT5J9oM
         Ze/WjdUEw9c+ZDLcm4Jjf2NKDTNXYp2YUkYrefjmVF/6R04adFyGTeCq3B1dmFsAs1gG
         YbjwIUewlpAhszdbpXiPiHORRUAPF8V9ItYvcoMuuA+Os8xBvY8V7S0rkQNLWzwPWZti
         h/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90wiFngH1+zfXrSTTOx8+fdGzM6IhOrpFDU4dB9LYfU=;
        b=X8FjFTETNADpmBndZWKYo7cQ6+MExVYe6SHRIZPZYLEfLR+BNUK72VLLLnTVTlrQib
         us321zuTN/goRNjyWs2Nbu8KQphjwHl0Gy5lmf9INo5Hpxos+bICJGls4S3Biuw5++79
         3/csFsffS1quTe4URo4cLa+FzgzjrafqBndSH+5VFfkml6M3UkA1aKceixbKFOGLpRBP
         Rki9iVwuHFUyIOnx2lkT7ebdJx9uZTILiodB8+GRT1IfTF7U0mw+p6RYf8q5EVtEWXxQ
         rIM0twYnWXlu83wz0WMpYD0cN0Kulzni4EJrv1mFyP1mvHiQLKv0iGJvKfg+WnF0Vb2H
         9N4A==
X-Gm-Message-State: ACrzQf2y6yRUkAUIo8OtoN07pIMpYhnhTEcNfK/15/iEA1i2zahUsIy8
        FrTJkpY5XLnTaJwgYoLsjAQ=
X-Google-Smtp-Source: AMsMyM40lrZ0UoyWyfmKEKwg8aEcvW6x0wmHhAfncWc2jx4CajdWlJBW2KjJjqxCym4XuW/bOjLXaA==
X-Received: by 2002:a05:620a:2699:b0:6cf:3ee4:5657 with SMTP id c25-20020a05620a269900b006cf3ee45657mr8621558qkp.475.1666265349220;
        Thu, 20 Oct 2022 04:29:09 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id j5-20020ac874c5000000b0039ccd7a0e10sm5766830qtr.62.2022.10.20.04.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 04:29:08 -0700 (PDT)
Message-ID: <1cbd1d8e-8dc5-052b-118a-0c546d5edad6@gmail.com>
Date:   Thu, 20 Oct 2022 13:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] brcmfmac: Fixes potential buffer overflow in
 'brcmf_fweh_event_worker'
Content-Language: en-US
To:     Dokyung Song <dokyung.song@gmail.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
References: <20221020104954.GA461052@laguna>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20221020104954.GA461052@laguna>
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

+ Kalle

On 10/20/2022 12:49 PM, Dokyung Song wrote:
> This patch fixes an intra-object buffer overflow in brcmfmac that occurs
> when the device provides a 'bsscfgidx' equal to or greater than the
> buffer size. The patch adds a check that leads to a safe failure if that
> is the case.

Thanks for the updated patch. The subject for all linux-wireless patches 
should begin with 'wifi:'. Sorry for noticing it not earlier. Maybe 
Kalle can correct it when applying the patch.

Regards,
Arend
