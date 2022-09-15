Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485545B9183
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Sep 2022 02:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIOAOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Sep 2022 20:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIOAOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Sep 2022 20:14:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF084BA7E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 17:14:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u15-20020a05600c19cf00b003b4acef34b1so92738wmq.4
        for <linux-wireless@vger.kernel.org>; Wed, 14 Sep 2022 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JFP7rBj3JYmYOP6yWJYqk5t61VCcDobym+z8+1lrG3o=;
        b=jlphYtvKkeSlpsyvhmr/4R4XDq2/QxAmcg5EdoET/9a7Gq4jgGUZ9CM4pmJUfS0DI0
         fkyo4Zl24ZGyAXkKZSIqbHVSTZ8NRAaD+cyAmQI0U3TV68sQH6YCTd+GaUDV1V+vbJIr
         /eaeBeBQSKu5W2BzPcinL4UAkVZg+EWgqwHIJI1bnzUqfAylnON/3AchEbTDJG/YYo5l
         8IkuZqLz+oxQFB8TjurUHbXCHL79jBDGvhRItaEROFxGA4jREw9+G540iF0j397mSB0l
         0jEEKb/GBH5DyTDpr/lFOkESOJcmdlZoL+pY95po5cAw66ANbC1qcEwcgr8G3/55EmPr
         PLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JFP7rBj3JYmYOP6yWJYqk5t61VCcDobym+z8+1lrG3o=;
        b=JKMqc6iuYuhBql3klPjKPHk2YMduOcxbPNtW4LgnSKBD8j6M3KaYrxC411Fvs0IZCb
         bujZGgIaADgKMNszSPJLtr+FG77rXoMzTUAVkAyhzzVoWBpVlrdS+1dSIflAwbvJDeA3
         3sUL58sQCh09KSWbyxWdbI2ET8NHyTPAxPbd78YAzyoylHt/rdHxujIPMHzRwR+rSmDa
         Ewocowl9qcXSAQH1uS+JqZD3d875fJtzkT/fTeb6FfB4PoE5ievpoocTmQ5M7UhZP1Si
         oyTyAwanNatrYu7V041WcFX40NEPV9nB7CGzHX1fdw6NjI/79yPEHRBqfc9t8vFmq8ey
         BtRA==
X-Gm-Message-State: ACgBeo1lErCRlHthOksQAAfOnxi/sbnIltWhHZO9josJR+UlPhKLKmpr
        hZjeOsBv1vR+0W3EGO9ncYiOiA==
X-Google-Smtp-Source: AA6agR7M+hxWjHvEd3j5wv3qfJbgRdZz0GtlIqeOrsb+OlPADXBKaUNaf0j9GdGXHEcj1TfKLQJblQ==
X-Received: by 2002:a7b:cc85:0:b0:3b4:9fc7:cd4d with SMTP id p5-20020a7bcc85000000b003b49fc7cd4dmr3982852wma.68.1663200850084;
        Wed, 14 Sep 2022 17:14:10 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c294600b003b482fbd93bsm644933wmd.24.2022.09.14.17.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 17:14:09 -0700 (PDT)
Message-ID: <cbfa8d05-48a5-4950-a852-ad018d70da8e@linaro.org>
Date:   Thu, 15 Sep 2022 01:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] wcn36xx: Add RX frame SNR as a source of system
 entropy
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     loic.poulain@linaro.org, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20220914212841.1407497-1-bryan.odonoghue@linaro.org>
 <20220914212841.1407497-2-bryan.odonoghue@linaro.org>
 <YyJqfsXLESDWDBvR@zx2c4.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <YyJqfsXLESDWDBvR@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 15/09/2022 00:57, Jason A. Donenfeld wrote:
> Won't this break on big endian? Just have an assignment handle it:
> 

Yes but these SoCs are all LE

>      u8 snr_sample = snr & 0xff;
>      add_device_randomness(&snr_sample, sizeof(snr_sample);
> 
> That & 0xff is redundant, but it doesn't hurt to be explicit.

Sure NP I'll v3 it.

---
bod
