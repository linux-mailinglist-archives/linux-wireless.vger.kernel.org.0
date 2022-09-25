Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E895E9485
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Sep 2022 18:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiIYQ5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 25 Sep 2022 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiIYQ5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 25 Sep 2022 12:57:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3C2B62E
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:57:10 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h21so2899884qta.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 Sep 2022 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=g2THmump3TEzRKWxaNdWARTO3yMmgfzKiXbOPnfYrKo=;
        b=GvGtOkZFHNdyqm8VXsvaYzA18sKq+z1/UFZ7zjyvbgtPGQ9PFdeA3UsyYhElsph2w2
         db7tifvXg/TXOxnGlt6uHI4czjMZNxi83CfyQwOSIgvtv9TT674VHtGCsgfuWWgP3UD/
         tTywpzeLsqTY3GJ6j7nyIsMbeoYVosdOvnZDc5jf7hfhhAty1o2FfqZ9IHTp/1aflBD/
         6tedHXHG2AUVgR2OKplCW406SNdU33/9a+UZv8TpO0AD6kR3HIpR//53O+s+K6d9viC9
         ihFth2CnFXdPHg9wdWY6k7I/yQACbVTsEgzPkrFsGtcFKMYS5XT88Nuv9Btvhb+/541L
         WGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=g2THmump3TEzRKWxaNdWARTO3yMmgfzKiXbOPnfYrKo=;
        b=P7pAt5wr+gajToudO4eQsOM5QX6Uk3QidiR/WHILP4oaTs8XMbqYqB51hI5jur5O7P
         xPUpVcx6r/jJcQA+PtVhjSAsJX5gKJbwp+S4+IBVRRSVQTlI1GbQNqxblzmfQILh4UzO
         0eayDMDuZoovzBLyop+/grPbZ3sFwT5I27Gb/GlfHl51CvudXPDMkBaufwhmHqtsHOUy
         edyo4XE2XvqCBplYDUHZTC+1ngpP4YohdcPiOk1MjQyTp+0EtYrLnO7LmkEKTM5LCsri
         cy6KOJzrI2CXRslQP4p1qA8V8KgZ99CvPXASOcRopsnG7hbot6TUNYdWbeR96jiMlhTK
         H/8w==
X-Gm-Message-State: ACrzQf18oT84RkIGOlGXOY7bTwv5u3OmT0UO+k7fI9Pl1m+un+bRhuza
        0pUpf1stIUBIT7YDf8i+ymQ=
X-Google-Smtp-Source: AMsMyM7aF7qGtOodKOZHARSf1OeVXK1WV5NsO89y1yAMyqp3AsUkn++L6dSmnjAyp88eNYpiogMvxw==
X-Received: by 2002:ac8:5c0b:0:b0:35c:e066:998d with SMTP id i11-20020ac85c0b000000b0035ce066998dmr14815053qti.336.1664125029142;
        Sun, 25 Sep 2022 09:57:09 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::c4? ([2620:10d:c091:480::af4b])
        by smtp.gmail.com with ESMTPSA id bb4-20020a05622a1b0400b0035cf2995ad8sm9084323qtb.51.2022.09.25.09.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 09:57:08 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <584b0e48-8695-e224-5865-3ed232c42e23@gmail.com>
Date:   Sun, 25 Sep 2022 12:57:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] wifi: rtl8xxxu: Improve rtl8xxxu_queue_select
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     chris.chiu@canonical.com
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
 <2af44c28-1c12-46b9-85b9-011560bf7f7e@gmail.com>
In-Reply-To: <2af44c28-1c12-46b9-85b9-011560bf7f7e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/18/22 08:47, Bitterblue Smith wrote:
> Remove the unused ieee80211_hw* parameter, and pass ieee80211_hdr*
> instead of relying on skb->data having the right value at the time
> the function is called.
> 
> This doesn't change the functionality at all.
> 
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Jes Sorensen <jes@trained-monkey.org>

Jes


