Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3961B6BF51D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjCQW0W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 18:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCQW0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 18:26:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580CA3771F
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 15:26:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cy23so25736124edb.12
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679091960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0s6t+9RjEdrsp5YQYHkmbrJDFcm9COEbv7mGZ9wgzsU=;
        b=QUqnle+0EmUmhlKvgw/I8Bq1J1xWzYWEmh6yO2NeT7xRGGKs8I8iutPRm2UtOVvhzt
         uXbzA2k4fLC3/5TWUw/e0L6FilIeQ5L92QfwUQMaGcrOql3h/KHXqeqt93F6uVVs3IrY
         jUOikKxfgraE+Cupb8mT4+kJTYThLwqXE8F9PHTRSK6POsiULCIMjTPz/7FUFAN+/aMs
         m7dJlWpJ3KFQV/CsA6l9VEe9NsB0evvX2TTroX0BLK0n0/bygTdsMWA450M2jh27WErU
         87ZYIeveExa3z+UXGQXQ5o57zfMZkIqPQ3+c6OMA6U9WvVJlP+SU1XS2d0Fn55xI5tzV
         MjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679091960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s6t+9RjEdrsp5YQYHkmbrJDFcm9COEbv7mGZ9wgzsU=;
        b=ZcwjeTRWxvhr8ptpF7m7YHy6cwHLPVb+vvtFnOM/VwIy/NJGjyJGkJBbK6vmepmBfH
         DKd8Vgl01XqN9USdOk2p/JCgg9WgIA2QbkW5pyDEbMommLqBzMjhfX+W6l5OqCRoaqNg
         w3Xg/hP20PwItqTKps2FrKi2ET1+CfX7Ul8nbPcllveJzvlJKxsjerm5N42vnHwLTZs7
         WJbXrXjEGCpKrkw78o8b4MzQliN4FhPxWrlkC3bxVVKwCbZwjJzl/TiLtYZND9BAuGri
         o+JT1slerFMt1WJeoThikEzDqqufAXBKMT9ZWvo+jCCxNsZz7nNKiMNlCl4oRDBVNjNM
         jmLg==
X-Gm-Message-State: AO0yUKUhx84VRdO5mh2MtF39R12qtyHN+UFS32uthvHn39tUOwv7eNpj
        7408+RVgYhmJf2x7W4o7C1ld6biUog0=
X-Google-Smtp-Source: AK7set8SBVoNHV487uq5QN66184kD3eVgF4IfriJeM3zmo0G474Q9znhoup7+dw5vZUKchWSIRuW/A==
X-Received: by 2002:a17:907:77d4:b0:930:45ea:4a28 with SMTP id kz20-20020a17090777d400b0093045ea4a28mr1157114ejc.35.1679091960534;
        Fri, 17 Mar 2023 15:26:00 -0700 (PDT)
Received: from shift (p5b0d7c06.dip0.t-ipconnect.de. [91.13.124.6])
        by smtp.gmail.com with ESMTPSA id sd13-20020a170906ce2d00b008e09deb6610sm1408963ejb.200.2023.03.17.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:25:59 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1pdIVX-0009i4-1k;
        Fri, 17 Mar 2023 23:25:59 +0100
Message-ID: <1b3779a1-7a08-fd26-5fde-c71b648aaa57@gmail.com>
Date:   Fri, 17 Mar 2023 23:25:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20230215
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-firmware@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
References: <878rgzuw37.fsf@kernel.org>
 <c9ccbfe1-9535-f46c-756e-4eb19c1afbff@gmail.com> <87a618517g.fsf@kernel.org>
 <97b7f35c-f7c9-1257-ff67-e5b61efe0ce0@gmail.com> <874jqmo7em.fsf@kernel.org>
Content-Language: de-DE
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <874jqmo7em.fsf@kernel.org>
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

On 3/15/23 07:28, Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
>> On 2/20/23 06:56, Kalle Valo wrote:
>>> Christian Lamparter <chunkeey@gmail.com> writes:
>>>
>>>> On 2/15/23 10:17, Kalle Valo wrote:
>>>>> Here's a new pull request for ath10k and ath11k. We have new hardware
>>>>> IPQ5018 and various updates for existing hardware. Especially many have
>>>>> requested the firmware update for WCN6855 which seems to fix an
>>>>> important suspend problem.
>>>>>
>>>>> Please let me know if there are any problems.
>>>>
>>>> Could you also please include all the QCA9888+IPQ4019 boardfiles updates
>>>> from last year too?
>>>
>>> I will try to go through them later. The problem here is that I don't
>>> have much time for ath10k nowadays.
>>
>> Ok, should I just post the board-2.bin updates to linux-firmware?
>> I have them ready to go for IPQ4019, QCA9888 and QCA9984.
> 
> But is the problem that then I don't know which one you picked up and
> which one you skipped? Thanks for the offer but I think it's simpler
> that I'll pick the board files instead like before. I put this now to
> top of my todo list so shouldn't take long.
>

Thank you :-) !

Cheers,
Christian

