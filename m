Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E266F9D20
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 02:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjEHAzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 May 2023 20:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHAzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 May 2023 20:55:40 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCD7AA2
        for <linux-wireless@vger.kernel.org>; Sun,  7 May 2023 17:55:39 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-19619af9a02so11387fac.2
        for <linux-wireless@vger.kernel.org>; Sun, 07 May 2023 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683507337; x=1686099337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vwOtQuQ2gz8gs7V0DffMPXMJ9CT68uZRdK7uROZdpwQ=;
        b=JJJxFz5ny5c7YOX07TmmAkyjoJdPw1M6dtg3u8U3/X1v8A7BX3txwYx8Zw8YFln9AI
         /WYCUaqdAkzt7i6tfgAMO32UlohSF/VD0pu/JAMtCdWl3UWjhhr1zNFveacMME9FR860
         uAixi19xe3ZDzPNN37Unv2Q8N+QwyeeW1+uMFSvRypcFLn9WfGokCze+szWoCrdE4g0T
         3DXx5f0uPI5R6G8ehEE/heMZdKQjTaVOfHo0aUXvwUHFMsvxBZECQPHeR/mTFkeVFpWZ
         ZKE5KRr8OkXziWnT89brdCbsXjUxuZH+woFOm72t7DGLLgHOQvjUBGaopkHXHbrPn2Ty
         2FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683507337; x=1686099337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vwOtQuQ2gz8gs7V0DffMPXMJ9CT68uZRdK7uROZdpwQ=;
        b=Ai+l00agS56A3w2ZQN8IxoVbrb1ku7Iip323bq/BiE3wWeTIugdOVpEvNuFxH6f9po
         ksvV2JdCZB9Mna7vU9Z8pzuS5tV1Aegp6nw9X7zf+7sZYGiuOM+IDkH0BncRUPHee+1C
         7UxoUX3Xm5Jpz9lEdpLF7dZmDssV3dSLjbmaGaJpTTUTwusE7qRgkwOHBJH7OsGoOJ9k
         40gRhHQmjq6E9ghFurmPCKvjFFBDyvAQZreuz2PiB+AsSAEnpT/Dqhr1oo1z8/faylaq
         VKH3Bq6PJVtCkGumZypmo2kJGthkNFd4X+UgU1q2QTk5Tx3+hRPEGGeRJIFPfoxj3FMB
         AtlA==
X-Gm-Message-State: AC+VfDyo9inEPUMS4dyv4ykSw1BeYnbteniRAxsc2mOCYW9GGTyYIGjs
        3eOKROx7bAiAsvX+Ed74KLLjqoJUY+k=
X-Google-Smtp-Source: ACHHUZ4rCp1X7jGeMsig0GOMwkfLka9091IfQScMJWMmc+R6rvFzqmK87sg+ik7R5RnyiT1m8oFAAw==
X-Received: by 2002:a05:6870:44c5:b0:184:7e77:b107 with SMTP id t5-20020a05687044c500b001847e77b107mr4802505oai.57.1683507337234;
        Sun, 07 May 2023 17:55:37 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y15-20020a4ae70f000000b0054c7a08d4casm907119oou.38.2023.05.07.17.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 17:55:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <f1e31e8e-f84e-3791-50fb-663a83c5c6e9@lwfinger.net>
Date:   Sun, 7 May 2023 19:55:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: RCU WARNING Splat from rtw8822bu
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <d37638ad-27c8-e74e-ece1-c4de2eaccfa6@lwfinger.net>
 <3c2eabc6fc89496fb7e200d0710ba2f2@realtek.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <3c2eabc6fc89496fb7e200d0710ba2f2@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/7/23 19:49, Ping-Ke Shih wrote:
> The ieee80211_ops::sta_rc_update must be atomic, because ieee80211_chan_bw_change()
> holds rcu_read lock while calling drv_sta_rc_update(), so I think a simple way is
> to create a work to do original things. I will make a fix later.

Thanks.

I forgot to say that the WARNING did not cause the wifi connection to be 
dropped, thus the issue is one of log spamming, not stability.

Larry

