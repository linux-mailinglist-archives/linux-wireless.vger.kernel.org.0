Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35189721DBF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 08:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFEGAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 02:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFEGAX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 02:00:23 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28985D3
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jun 2023 23:00:21 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9741caaf9d4so655480366b.0
        for <linux-wireless@vger.kernel.org>; Sun, 04 Jun 2023 23:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685944820; x=1688536820;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix5DN157aDhdZs5uwttdNoqkK0G/+qbEmd+ldVidlQw=;
        b=JXHWiFzWXSW6GU5JYUAUvkJeE7eAMQMHP4QRQlaD8gDPIJMR9fWFqqBCgb8I23+pm/
         0GP5SYcIBe0RXk1rILJwjxIb9QsUv8rbMwFTvswKUeqpJiIyQlGoEZVgVXP9auc61wMe
         JZ+iYW3Y5pwNSeRRaeyyw6a1cBvR/ptwyEMjHR0ZEJBxPrIfGbRkf3hZpNcdF3bhBnu0
         uGeLMmhZtfBBc0NLLqQvYNDkhswyjFR+dhi5htWZdXuHKxN5E9u+1uQvgqf8FLTgP07D
         q4j+R6qfMQgVf3pdAvbGYTUTsuCSImjS1qzGnw/ZdzlWhFdxbEd8QV5ZaU2iQ6Z+LTfu
         X0Yw==
X-Gm-Message-State: AC+VfDzs2i3/7V+2ETLgnoXVIEZ2qAB3XI8/5TvSc0p6atvVxkTw0wNn
        VoTqrkefaajt8y5DUiz5uLU=
X-Google-Smtp-Source: ACHHUZ6iFtG5pWvtnMh2+ByEerRldu3i+gftohAV9jmOxQBzPIuChpjc7xHITKg13ceyu77pmQ6+Fg==
X-Received: by 2002:a17:907:2cc3:b0:973:dd61:d420 with SMTP id hg3-20020a1709072cc300b00973dd61d420mr6157286ejc.74.1685944820203;
        Sun, 04 Jun 2023 23:00:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id jo8-20020a170906f6c800b0094f1b8901e1sm3785126ejb.68.2023.06.04.23.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:00:19 -0700 (PDT)
Message-ID: <92aacacd-b33f-f86a-700c-98fc90b79cbe@kernel.org>
Date:   Mon, 5 Jun 2023 08:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
To:     Christian Lamparter <chunkeey@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     ansuelsmth@gmail.com, kvalo@kernel.org, mcgrof@kernel.org,
        mickflemm@gmail.com, robimarko@gmail.com, toke@toke.dk,
        yangshiji66@qq.com, Shiji Yang <yangshiji66@outlook.com>
References: <TYAP286MB0315EC437BF53C8DB2B5D022BC4EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <TYAP286MB0315FA0080ABAE79CC842899BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <582d6f32-23f8-6175-19da-f0b4c97393f5@gmail.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] wifi: ath: add struct_group for struct ath_cycle_counters
In-Reply-To: <582d6f32-23f8-6175-19da-f0b4c97393f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04. 06. 23, 13:11, Christian Lamparter wrote:
> On 6/4/23 03:48, Shiji Yang wrote:
>> Thank you all,
>> This patch may not look so beautiful, but its main purpose is to raise
>> some awareness about this strange compilation warning.
>>
>> This problem only occurs in mips gcc 12.3 (maybe only on arc mips/ath79).
> 
> It also occures with PPC464/APM82181. Could it be that that it occurs on
> "big-endian" archs?

Whatever, to me this very looks like a compiler bug.

So NACK to this one for now.

If this still happens on the latest tree (e.g. 6.4-rc) and with gcc 13, 
we might need to fix fortify or report to the gcc bugzilla [1] instead 
-- attach a preprocessed source there (the output of your make 
CROSSblabla=xyz drivers/net/wireless/ath/ath9k/main.i).

[1] https://gcc.gnu.org/bugzilla/enter_bug.cgi

thanks,
-- 
js
suse labs

