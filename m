Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544EC44DBB5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 19:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhKKSq3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhKKSq2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 13:46:28 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4438AC061766
        for <linux-wireless@vger.kernel.org>; Thu, 11 Nov 2021 10:43:39 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so10154245otk.13
        for <linux-wireless@vger.kernel.org>; Thu, 11 Nov 2021 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eNvEDACItuf0bFWex6fZmN9pN/X1bGajMm1MvKPutWk=;
        b=RZGAb63lzKD4EUCO18ZhsF70zRG815h0Bt6G+xU63VR8mYXo/aLXv5bCqmwzhtm3KG
         gM1RyflpVFukR+kXANlrrx61p/xKBdI1zX0fodPUJQvkFAEyRlzH2S0ZPmpaqaR2nd/s
         cjYeu7QyH5U7cAVvEJN+lk2E3CJHL6LlnbAqvfuFlLKKTZZNsVpvriu7SrLGZRPp7FLI
         chKCPXQQZtIEsOeTlmWCKh9ka5DgrLaGjlZYNJogMlKuERgqv5UMv/AebAU9OTitmEvZ
         3FHHGrhVWcVz3ARmk7HicuSPiKUnlt4dn32Vk3P0wVbMMej+YiEKNkaU0Uq+MJJwAxQp
         m6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eNvEDACItuf0bFWex6fZmN9pN/X1bGajMm1MvKPutWk=;
        b=Lj65zHK2P70uCdrDQdrK/n9/viGgyGeFIzRq5QRnAZvYaczhT4fTDwNmMJSEI0mfOl
         QQATybJWIhhKORZ5F2pr83far6UWRF9b6mKouUPVeRI2N7SM6U6/NiRJ3kfNYHZDR/2K
         IJUjl/xQ/Q7mgylNbP04ut4Sh6HSt4s9IWhBJUKqE2pJqC0rr+p7TxvTuU4cHwgrWn62
         DQi1Y8qm1kQ931vqJTUQkUJdJq1LHNGqoAy13J2SGznsaDa8/tiSCbl4fja7AsG1oetd
         Wb3reyVmRyKnAgNuMA9iD3jYM7jk9SJ+TO7Kxbtb27sQeltOoJ10AWoGVqXjWMd9i+D6
         1Chg==
X-Gm-Message-State: AOAM530g/nckuRcC4ss7rvYKxkspzqvqwu8m7vn5JLrS4SeFyfSpy9I3
        6kI2eKOBWCM7uKR7SYRU5r0=
X-Google-Smtp-Source: ABdhPJyY6hWtVPepe0Y8LE4zEJaYUrCSz2x8j0nMsf32cKgCJxV94U6CpzZJqgWgJLR6q5/RJbfqLQ==
X-Received: by 2002:a9d:490e:: with SMTP id e14mr7454261otf.194.1636656218633;
        Thu, 11 Nov 2021 10:43:38 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id j10sm656054ooq.5.2021.11.11.10.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 10:43:38 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <40821ab1-3e0a-4546-669f-0a6bdcaf9361@lwfinger.net>
Date:   Thu, 11 Nov 2021 12:43:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/3] rtw89: fix crash when loading firmware file on
 certain platforms
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, tiwai@suse.de
References: <20211111021457.13776-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20211111021457.13776-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/10/21 20:14, Ping-Ke Shih wrote:
> First patch is to avoid writing "partition size" on read-only firmware
> buffer, so it has to fix the crash.
> The later two patches are used to make the semantics clear, but they don't
> change the logic at all.
> 
> I hope at least first patch can be taken into 5.16-rc, so people can avoid
> this crash.

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> Ping-Ke Shih (3):
>    rtw89: update partition size of firmware header on skb->data
>    rtw89: add const in the cast of le32_get_bits()
>    rtw89: use inline function instead macro to set H2C and CAM
> 
>   drivers/net/wireless/realtek/rtw89/cam.h  |  468 ++++--
>   drivers/net/wireless/realtek/rtw89/fw.c   |    2 +-
>   drivers/net/wireless/realtek/rtw89/fw.h   | 1768 ++++++++++++---------
>   drivers/net/wireless/realtek/rtw89/txrx.h |   46 +-
>   4 files changed, 1370 insertions(+), 914 deletions(-)
> 

