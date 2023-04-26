Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BED6EFC18
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbjDZU7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbjDZU7r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 16:59:47 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4FC19AA
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 13:59:46 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-18f16bb1a9bso163873fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682542784; x=1685134784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2Yz4qB0Upm2dHZe1lD1B+YiYLe86VCrk5ulxAt72jd4=;
        b=cfy9vcQhCZnFdZOjBTW8PkOEx798QA1mKrvVgJaEazoep2tPpmx/LOPdHi+GLmoVQ0
         AwW4SlJOwqx1W3B+aT+LM6B56gpVW7x41LpqR+Q841jS+7wrMbI/lKCDF6hdaZ0MgTTr
         adSVf0X/pqlyXgsmhOr/gZVDG1ZZja671n+ymOknV5dglAs1gBu11U5X7ojRBNM7v7ju
         jlelr4CjzAZrk563TMJlJUgtKNFAlafPE78rImcF6xDrSlihpABtiUHTI0S974bC1lsP
         utGBU+1nFm/I22SDCwINcvEM6NK8aVnBIDsFZO64hpvoZsXGxH5RZ45NyuNUZUYq0NO0
         Io1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682542784; x=1685134784;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Yz4qB0Upm2dHZe1lD1B+YiYLe86VCrk5ulxAt72jd4=;
        b=XL7HYuFob1aeuR5D6hPvY4X0AQPmoChlOt3CMxhyHDIPs8hFU4KwY+x/c0FsVYFBaC
         y4gzqBClF82e07ZgNy8MmOMaIpNyaoMqPSk3z3ENMETEFFkxaXbn9wrLpUrOMT7aW6VZ
         7lAlmfk+eWScU4X1hby8ng/vr6YynCEsySJmb7GZep6hmNbjgDC/02l9QDQ2qvTO9f6h
         4nXwdTB3EbsKRIuh478kLW57n5aWneyjtcvacCfAyH5IUWZSQGlyeMqN604G76M13QyV
         MigcyPCY0YQK31WgE240GJ/ErVuv8eewLXJD1U76DvubkI6awO53bSMZsEeSFyFxpsmr
         uPGg==
X-Gm-Message-State: AC+VfDyr/9ld4J+4sZeFQUSPHOhlZlphd79vDmmZGaq3VVuFIRa24i/2
        asBh9lp6afsgWMiZTY7B9vw=
X-Google-Smtp-Source: ACHHUZ7WG4MkeisNRVwk+qjLFKOPs/FKqbWQyfpP6IELlOQf5WI6xiJFtzrCCOjKyxsrtRJjB3KgRw==
X-Received: by 2002:a05:6870:35c4:b0:184:3a8c:87f7 with SMTP id c4-20020a05687035c400b001843a8c87f7mr1699453oak.15.1682542784074;
        Wed, 26 Apr 2023 13:59:44 -0700 (PDT)
Received: from [192.168.0.162] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id p22-20020a05687052d600b0017243edbe5bsm7030532oak.58.2023.04.26.13.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 13:59:43 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <32f92249-2866-75b9-42f4-8bdcbeeca750@lwfinger.net>
Date:   Wed, 26 Apr 2023 15:59:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Macbook pro 7,1
Content-Language: en-US
To:     Pogprogrammer <spikey@rslp.org>, b43-dev@lists.infradead.org
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <63806E6D-2230-44FA-9DAE-0790F35C9F6C@rslp.org>
 <54db8ecb-b817-eda9-09ff-adbd54806c95@lwfinger.net>
 <726093C0-6877-4427-B7FF-9DACE88B9982@rslp.org>
 <716d9146-605e-b370-b3e2-ded0849cddeb@lwfinger.net>
 <D675B28A-707B-4D9E-80E9-986EC1A266B6@rslp.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <D675B28A-707B-4D9E-80E9-986EC1A266B6@rslp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/25/23 19:47, Pogprogrammer wrote:
> [   17.153826] wl: loading out-of-tree module taints kernel.
> [   17.153837] wl: module license 'MIXED/Proprietary' taints kernel.
> [   17.153838] Disabling lock debugging due to kernel taint
> [   17.164164] wl: module verification failed: signature and/or required key missing - tainting kernel
> [   17.215776] wlan0: Broadcom BCM432b 802.11 Hybrid Wireless Controller 6.30.223.271 (r587334)
> 

I was hoping that the log stuff would not do to all the members on the Linux 
wireless mailing list, but at least the log was not too large.

In the section quoted above, it tells us that you are using wl - the proprietary 
driver from Broadcom. As that is distributed as pre-compiled binary without 
source code, there is nothing that we can do to help you. As you wrote on the 
b43 ML, I expected that you were using b43.

Sorry, but you are on your own. I do not expect that Broadcom would provide help 
for this legacy product. If you had any other brand, I would suggest that you 
change the wifi chip. On a Mac, that is not an option. You might try getting a 
USB dongle, but that can be tricky to get one with a Linux driver.

Larry

