Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEA55F30D7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Oct 2022 15:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJCNM0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Oct 2022 09:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJCNMV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Oct 2022 09:12:21 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485944D4FD
        for <linux-wireless@vger.kernel.org>; Mon,  3 Oct 2022 06:12:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y2so6267683qtv.5
        for <linux-wireless@vger.kernel.org>; Mon, 03 Oct 2022 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=vcAo4Tv8RirNyJ7H+0GJV8Qy6IyumHjkZT29kYTFCLY=;
        b=HaJlmlBWdtp4Hg7KuX7XgNz4C4g6NhzlMZBIhX895DzQ3xAtG9RGFR+EY/IB4j/tV/
         Ic27tieC/tEIzSoeZri/nVYjQZR3ItLZSSaxKPA/MWUr+U2B9vFz1zFtw8SzF5vVTzbs
         I8YMu1STD+xgtnc8yM6F964kIRRX88G7AM2qe0OSyGD2SIFJYHFhuQAK5DyO/lwY5PJN
         Gf5/n5jgF2DYBosuIiwU5c68/jwBS7A9QNJ0YJ3qy2iDFI8q+N3tuP7MbsYtrQ3rFce8
         HUTw9N1xUFfP4efgYZ58BCycuhJ8UcjyykEP+ZO9aJSa/r8MwCdECkkBvVC5j9yM3ClW
         7S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=vcAo4Tv8RirNyJ7H+0GJV8Qy6IyumHjkZT29kYTFCLY=;
        b=hJZTqVhU52T1ien0hU5izgB7lMqkpUnbdXk/daM8YSI8ZXswvyzyG6ONQNnhWGe/iO
         vMmH5rIbA8teRXzlYjXL9SRW7gFHNdroCo5lieAuSqyApyAAUZsIcEEsYOJLAVXZUyAQ
         ehp2LQYQ2CAjHBvXh5JhAea6JWUJpMCR3JqrvnB0GGBZy9WbZx1mkvGXPu3jyeDxBpFP
         KWS3ir3JERsMwr/AuRPOBP6QDySTdaJken5qP3qxcPICS79sDNaR4e+YtOhaUKQAVrFk
         TTrA7phe6spqqA8NPxrV0JOItOwSokE+iPUNCVw2xC2eieigtR+EutNKDUR+pAWEzKTl
         kUYQ==
X-Gm-Message-State: ACrzQf1GL5YwHW6/nYI7Np0/Oz9gMQgLsy4P2kSsWIxdynTaJrBIhtz3
        mSyzuUEU5PodgU66O++XrQOGXJoqvaw=
X-Google-Smtp-Source: AMsMyM6y6Sxeanxqx8+TbpJh5FpXXmfbbiZDlqtQk1lH0uzunu6sVsj90rPf37n0Oz40yoP7DefuGg==
X-Received: by 2002:a05:622a:288:b0:35c:fe52:2e5 with SMTP id z8-20020a05622a028800b0035cfe5202e5mr15555703qtw.59.1664802721465;
        Mon, 03 Oct 2022 06:12:01 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::1844? ([2620:10d:c091:480::f61a])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a409500b006bbc3724affsm12064261qko.45.2022.10.03.06.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 06:12:00 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <012874df-59d4-8973-3dee-48f42208f9fc@gmail.com>
Date:   Mon, 3 Oct 2022 09:12:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: rtl8xxxu: Should it support RTL8188EU?
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>
References: <2999b8e8-5706-8bfb-c3a5-5c547ab0a170@gmail.com>
In-Reply-To: <2999b8e8-5706-8bfb-c3a5-5c547ab0a170@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/1/22 17:42, Bitterblue Smith wrote:
> Considering there is a driver for RTL8188EU already in staging,
> which people have been whittling down, should I put any effort
> into adding support to rtl8xxxu?
> 
> It's actually mostly working already [0], but rtl8xxxu doesn't
> have AP mode, adhoc mode, power saving, etc so it wouldn't be
> necessarily better than the driver in staging.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git/log/drivers/net/wireless/realtek/rtl8xxxu?h=rtl8xxxu-8188eu

The staging driver is based on the vendor driver which is rather
dreadful. Given the similarity of the chips, it feels really silly to
have a second driver for just one chip.

I see no reason to abandon 8188eu support in rtl8xxxu, but given my
total lack of time, I am also not able to invest in it.

Cheers,
Jes

