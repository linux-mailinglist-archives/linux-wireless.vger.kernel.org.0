Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C17664C96
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 20:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjAJTfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 14:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjAJTfP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 14:35:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C6F1EEFC
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:35:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g10so9572866wmo.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mQE4IAjk+VflFgV1WCqXh4GbPZobVdOWuXM0Q7eR7g=;
        b=zJQhm/Z5X90cjpUls6+rGTHaltG8jCZ8mstEOyA4QP+xDMnGbKNiaK8iuhpR3LTNMi
         ET95if+UNbkKYln5bdw/euNRmgIwnd0/bLiLJJ4XHf/WF8SMn6EaVeanamSLpJciVS+8
         CVHx1RHrbsyAuBHzFIZhdAPMztjp0eCPd9q3FLrlSiljRhoDeJFhWx720N6bchJhLjxi
         bYsLT6aQ4LG8uFxx54KAy4bkWqWSFdL37F3dL4gxyCPHfEeH3EbEVBztmYr9VWD+urYb
         0VcvCzWg8+POzUQ4Luz4Jc9/0ntMU1zDGcRpT92eq8J0ziSPXzqgjV2k5maxDKlz2QCm
         IZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mQE4IAjk+VflFgV1WCqXh4GbPZobVdOWuXM0Q7eR7g=;
        b=EbZ4CyffuVb5wunrpp3S6rMlL9sbA4nJ/pTplznkYiiSGJ12Y9FqKgFbf17YA03/ND
         QxKmi2hWgbH+2gFWksS2Lp4/J4NsA3p7pA5MZIYV+MS0yDfJ3+uLfkpDFG4t0y2rDS5f
         NRnXUV5f3c0goy2ghdPGQUXz3bgmkOiJuJYTor/sp0LOs98jgXHYogfXj4zEvVZiAXVE
         KXhcHicW7ANh9lF8KRN/34TpZcvR0EQFt9dignPQh/UjMDtXxfXsB9wBAmXIIPguTb8o
         Lgur2xvls44NJt6QzWDd/bLKN+sz6aC7gjC0wXztICQnFLYKoN2cW/HAb0Z/VEu5Nf6c
         JDFw==
X-Gm-Message-State: AFqh2kr5GuGx1dbr0VRacL5DF8rk1FHDLMAIrhxh6zNDjoe8pKte7//5
        wqPG4RTPLq0PJp8j1k9mJkL4mgWWKd7YuMYTcSQ=
X-Google-Smtp-Source: AMrXdXv4Dl8ncnFNqSvBKYY65n2yANNnOiTMzfpcoTeUYK5bwK1+RNqQkz9ZDDoGxKZJw37SKpVQWg==
X-Received: by 2002:a05:600c:3844:b0:3d3:4406:8a3a with SMTP id s4-20020a05600c384400b003d344068a3amr60384278wmr.30.1673379310200;
        Tue, 10 Jan 2023 11:35:10 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm17197868wmq.25.2023.01.10.11.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 11:35:09 -0800 (PST)
Message-ID: <a76fb1b7-1ca2-93ed-17e3-e141ccf7be84@linaro.org>
Date:   Tue, 10 Jan 2023 19:35:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] wifi: mac80211: Proper mark iTXQs for resumption
Content-Language: en-US
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20221230121850.218810-1-alexander@wetzel-home.de>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20221230121850.218810-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/12/2022 12:18, Alexander Wetzel wrote:
> When a running wake_tx_queue() call is aborted due to a hw queue stop
> the corresponding iTXQ is not always correctly marked for resumption:
> wake_tx_push_queue() can stops the queue run without setting
> @IEEE80211_TXQ_STOP_NETIF_TX.
> 
> Without the @IEEE80211_TXQ_STOP_NETIF_TX flag __ieee80211_wake_txqs()
> will not schedule a new queue run and remaining frames in the queue get
> stuck till another frame is queued to it.
> 
> Fix the issue for all drivers - also the ones with custom wake_tx_queue
> callbacks - by moving the logic into ieee80211_tx_dequeue() and drop the
> redundant @txqs_stopped.
> 
> @IEEE80211_TXQ_STOP_NETIF_TX is also renamed to @IEEE80211_TXQ_DIRTY to
> better describe the flag.
> 
> Fixes: c850e31f79f0 ("wifi: mac80211: add internal handler for wake_tx_queue")
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>

 From the right address this time

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

