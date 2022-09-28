Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF655EE398
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 19:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiI1Ryg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiI1RyK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 13:54:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F69FF3DC
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 10:53:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f20so18275780edf.6
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DPorE9KZcNPg4WdfyIukNzavjt8jeCSzabQCG/Z5/sk=;
        b=jefaBmBek4cjFK7DndB/j04WX2ZC/OF4tI0VSxXs5U+9OFoqF9TAjdQ6qtXr+Is1sc
         fzHRsZnQUKsyQKVrt7vuQ5KTMB/dU8+P6AFez8UVEu6Lse9KU1TMuxS5/RtvonI0kH++
         5nInalnD9/sZ+qpT4eZoAQIQsYbHtw5OGjVR6pqKpjNrC2vbetxmGHKn8/FQNt0cRpKX
         TNlqED2H1Wl1ObwJ8m/NFazGrkTQJDuu/eoDq5TCi3XWk6ibGLiBCGOKCD/MafLLWGcl
         e5iH24HVf8dpNrME+1aBaULFy7flfsUuoR0xEYjaqfNGeSNXdBu3ncYaF0hU6grlMgvj
         04Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DPorE9KZcNPg4WdfyIukNzavjt8jeCSzabQCG/Z5/sk=;
        b=ckrpJ7uvkrY5cJ8CuVfdF2axfUuJu5wtGzlFzS8Zl5NCMyRrJw3cIGvQlDwrb81+kD
         jHEC0uWEFMUY36wwQWBBKk60WB74hRZ5MAZFMaabMb93+BgugoGoyvbxlO7DYmvN/oQQ
         oyZadlumGK4ySfnkYRDtxYazCCAuvGowFF7fDJyjlpSaaEtvcL3DdJT3TDMQ0ZpOU5mv
         USpWewDydmx4YyF+j8aOWKOwPdr2GlArFIGJIWClcOwVn9ZhGwX8+zLbRtOvSaAoQ3HR
         B+EeVnKqxFInkuUwtreSeNKcKET2rmhlNmyPsXP5jwsDYiVIpnj+GpWCvCf1egaahW5J
         auZA==
X-Gm-Message-State: ACrzQf00Gdv/rPYYdLwAMp0s5eIxeTVhQnZX/noOp3nq1wKsQzElk3wq
        SbxxxYgO15R/BthWT6XbCb8=
X-Google-Smtp-Source: AMsMyM5g71Mip/bOmQsWGB9lliivZnXiO0MPsDzg2Gykj0UQ+nhcQ5PJpoWGIiARA1ZX9LVL3k70pQ==
X-Received: by 2002:a05:6402:518e:b0:452:49bc:179f with SMTP id q14-20020a056402518e00b0045249bc179fmr34905025edd.224.1664387619458;
        Wed, 28 Sep 2022 10:53:39 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906219200b0073de0506745sm2694467eju.197.2022.09.28.10.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:53:38 -0700 (PDT)
Message-ID: <b8af19f6-564e-d592-0993-6b4c33728ac4@gmail.com>
Date:   Wed, 28 Sep 2022 20:53:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8188FU
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
References: <dfc6a877-e50a-87a2-08f7-7007c8083386@gmail.com>
 <87bkr27amy.fsf@kernel.org>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <87bkr27amy.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 26/09/2022 12:22, Kalle Valo wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
> 
> [...]
> 
>> +static struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {
> 
> [...]
> 
>> +static struct rtl8xxxu_reg32val rtl8188fu_phy_init_table[] = {
> 
> [...]
> 
>> +static struct rtl8xxxu_reg32val rtl8188f_agc_table[] = {
> 
> [...]
> 
>> +static struct rtl8xxxu_rfregval rtl8188fu_radioa_init_table[] = {
> 
> [...]
> 
>> +static struct rtl8xxxu_rfregval rtl8188fu_cut_b_radioa_init_table[] = {
> 
> Can these arrays be static const?
> 
Only if I modify the functions rtl8xxxu_init_phy_regs and
rtl8xxxu_init_phy_rf, and the struct rtl8xxxu_fileops. Otherwise the
compiler complains about discarded const. Perhaps in a future patch?

I implemented everything else you mentioned.
