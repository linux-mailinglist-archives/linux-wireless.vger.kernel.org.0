Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9A7135E5
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE0RaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE0RaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 13:30:23 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E0CBC
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 10:30:22 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6af6f83fc49so1540279a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685208621; x=1687800621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FF1JwJIEQ+P231FLhJoH3xdnR6xF+oJCIkA+AFBc2ZU=;
        b=ADqgF9djOuvQtG+pLCWWB9GjkUehlzk4pYJGV0Bxusp3iv1rSoMO5Cs8gM7XKQXOdf
         6/EZwxPZA/6wJEOmy81t/ZrbjX0FSw+iKmDz7jamaootF0YbaDKKyXwami2EG2N6HifX
         s1bq3gK/2mMzHUpfw/iPmo2JcntlpGvYsbICqIm6XqlYabQriLfM4vi9vHDiTjfAYkn1
         oeH8umTK6Pu+YYD/MUlau7if9coiyvtbEGX3ADSeluQnTP6lF8JSAumHuh1ONnQhL0kC
         wsGnGyGgVzp4lWfqdjMZI03UDb71waMlKw7UiIgbIXC4nbfJzI88haUD6VjdRD5cBE3P
         TdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685208621; x=1687800621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF1JwJIEQ+P231FLhJoH3xdnR6xF+oJCIkA+AFBc2ZU=;
        b=kx5otcpJ33QoFsB53OpkHR3mok/NGahccuv4WK+/oBRb2WPR4Q/PavCrpV+nE5he/r
         E6QCLH0JlsSB7IvpyNqV5pMC3ZWQSSrsAcoIDUC5CkvQevN1PeUf831a72WEKBgVb5Ik
         l5p410JnupqrXYrK+qq9zugrFULr8uDznKP4QsqQ8FVzIqMNMAoFuDh/whupy1U0IDkK
         hDAOWdeMSjIaJo4GKwCBUVXXTtHdg8yzyrlilwSuBJr0z8oRK4QDAuQZ1WrD9KNYgrfh
         e2kbtyklY91xSIgtJC930+n24yQz230yJDojnYWERnuYPR/qL7/TSkwy6/iTWY1e91aq
         Gq5w==
X-Gm-Message-State: AC+VfDxXwaTwuQC+7MStNu6yCPhQfCRIcquMT1SXtYlpGxZJB99Xixkg
        X6YPtQFUOyVHeVvQ+WtdovGyiv4Ov/k=
X-Google-Smtp-Source: ACHHUZ6Ja7xtZJ4ApmvdcftZ6lGTjke6bcZUtEofD991Zqz6L+PQYVHHk/vg8+UQaBexq38Z6KHPyg==
X-Received: by 2002:a05:6830:134b:b0:6b0:cccc:3279 with SMTP id r11-20020a056830134b00b006b0cccc3279mr2617557otq.12.1685208621293;
        Sat, 27 May 2023 10:30:21 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id g10-20020a9d620a000000b006a5e0165d3esm2925659otj.19.2023.05.27.10.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 10:30:20 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6104c768-d055-6fff-004b-5e7c98b77a60@lwfinger.net>
Date:   Sat, 27 May 2023 12:30:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Question about power save
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c385be75-71db-6265-1a6c-24eca64e5d7f@lwfinger.net>
 <fa9429cb8d24c9bb4b810c423b150aefe116148c.camel@sipsolutions.net>
 <6d635666-4973-b498-f67b-64762dbbd768@lwfinger.net>
 <731603cd61e49fece503780a74d0efdef8c7e380.camel@realtek.com>
 <00a86f46c8ebd1f95691c77de7f009bf19c6c6fa.camel@realtek.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <00a86f46c8ebd1f95691c77de7f009bf19c6c6fa.camel@realtek.com>
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

On 5/27/23 03:41, Ping-Ke Shih wrote:
> 
> I have sent fixes [1]. Please see the patchset about the detail.
> 
> [1] https://lore.kernel.org/linux-wireless/20230527082939.11206-1-pkshih@realtek.com/T/#t
> 

Ping-Ke,

I applied those patches to the rtw88 and rtw89 repos at GitHub and asked the 
reporter of increased power usage to test and report back. I will let you know 
of the response.

Thanks,

Larry


