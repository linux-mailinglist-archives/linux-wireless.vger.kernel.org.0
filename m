Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45902718A6E
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 21:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjEaTsG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 15:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjEaTrl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 15:47:41 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC827137
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 12:47:39 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5556e2bddf9so59630eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685562459; x=1688154459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bqbCSy6aJP4bTjJYV/H8LUH99ETIUaxHaWy4LAJopdU=;
        b=fVBn1WPODvngFHlFAarYkyi5Ma+0lcZZC+QBU2H9s9J3tJTMiDd0faoLBnXQJ4454y
         YErcrCHk1ioME2v5K27qCndAUTQR5/lJus8mvgPb0srAS7YNmBz4SHu5a8q+JceWp9aa
         fhbHDaQAj6Rbf1WYBeCbF3JbNG1sGC390YuVLBaDy18km2EiyC9z8jEHKaeNibSvx15t
         urDj8NdkK9UgGDlZQ20Xqy92iYx0OKpjk8OQKyS3BYTQhXdy7ifpLz4m6K2fujKD9b6P
         wO0oMUycwSNb3KW5dD5r8vpxk8NUztsaipo7lTUk+Xu7E7ECLpCH01Nadhz/NQ0xuLJE
         fOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562459; x=1688154459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqbCSy6aJP4bTjJYV/H8LUH99ETIUaxHaWy4LAJopdU=;
        b=ErIJj07zSiUjDwnC4XjlYmQj51arhRILu/SVVHnkeT9bccDRLnoVqbHjC/8pd0s6D6
         P5idWKylKoijP0mGDkSIl3I9KjS3E/OLd57In58upB84Z8Keb9iGbHu4hR9sJ90feiDC
         y29pSkvvzu56p1esE508NLIiDkz0Sh8/ZaFSdmmI48UfugVS4eL+S3uUctP7oEK3PiJi
         iD3vhsLlTvOskdkDW8ioFPEawgxey8k5mBaAJFE2lfaVLeQCIhNUzp1JIqbeK5nx/l5j
         ietFcBtjhasxtKb9yAVwlkAqWCr0KFtdCTxzSB7X5ltao0nu/bFBT9xuOMr7ApD42wG/
         bc9g==
X-Gm-Message-State: AC+VfDy4ruLHHG2bfBU/9rja8wx87qHnH8xAvBCSWBha7LxqzRQTF5IM
        PDu4irJPYEQxdWhmBQmgNpM=
X-Google-Smtp-Source: ACHHUZ5SbSgpSrT/ZC4+XbECjE2BtkbmDQhk7rWl14AHE+XSKGiZqPR7+UMe1uSndL3VWhamqDJufQ==
X-Received: by 2002:a4a:2c84:0:b0:555:45e3:fed4 with SMTP id o126-20020a4a2c84000000b0055545e3fed4mr3065333ooo.6.1685562458914;
        Wed, 31 May 2023 12:47:38 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id h2-20020a4ae8c2000000b0054fd0b7af2bsm6553665ooe.31.2023.05.31.12.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:47:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <046e8421-0d94-17e6-f06e-674b29963de7@lwfinger.net>
Date:   Wed, 31 May 2023 14:47:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/4] wifi: rtw89: 8851b: enable firmware features of
 hw_scan and crash_trigger
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     phhuang@realtek.com, kevin_yang@realtek.com,
        linux-wireless@vger.kernel.org
References: <20230531060713.57203-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230531060713.57203-1-pkshih@realtek.com>
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

On 5/31/23 01:07, Ping-Ke Shih wrote:
> After verification, we can enable hw_scan and crash_trigger simulation by
> this patchset. During verification of crash_trigger simulation (patch 4/4),
> we find that driver doesn't configure TX power properly in certain
> situation, so refine debugfs entry by patch 2/4 and correct TX power by
> patch 3/4.
> 
> Po-Hao Huang (1):
>    wifi: rtw89: 8851b: enable hw_scan support
> 
> Zong-Zhe Yang (3):
>    wifi: rtw89: debug: txpwr table access only valid page according to
>      chip
>    wifi: rtw89: set TX power without precondition during setting channel
>    wifi: rtw89: 8851b: configure CRASH_TRIGGER feature for 8851B
> 
>   drivers/net/wireless/realtek/rtw89/core.c  |  5 ++---
>   drivers/net/wireless/realtek/rtw89/debug.c | 13 ++++++++++++-
>   drivers/net/wireless/realtek/rtw89/fw.c    |  2 ++
>   drivers/net/wireless/realtek/rtw89/fw.h    |  2 +-
>   drivers/net/wireless/realtek/rtw89/reg.h   |  6 ++++++
>   5 files changed, 23 insertions(+), 5 deletions(-)


Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry


