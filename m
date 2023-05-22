Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1224770BF13
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbjEVNDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjEVNDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 09:03:34 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B41092
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 06:03:32 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6af6df840ffso1185340a34.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684760611; x=1687352611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OGYIAzQOuTRI66Am1Ptve2sIqi15jbY7Ad1+ZUDPwKs=;
        b=i5Kz0r5ksBfNMoLvbcZm3FoTs8aKSS31URr0dnQifGl3GSRY0iQmGaTTsn3OJ3DRMk
         6fYnCvdN6lDnPcP6YBl0iMErSRSmok1KG2suYSIbt4NAYB05rl3+7uganJ8XJIIag1DJ
         kfxuoO02x85/XemYGsM9mCaTNxgSLHO2XCcRp0rB29VWFT6j+E/xJdC/oXBHrAJkKXlX
         UGqShnqj4f6jxy9WI57JxFBw3Ih7PjzfpEPclco1Gno40Sjj/gs7yC3M90EcEFIBnpPq
         tbwoTMGixLVWHLVpy7Z9qo5bMr2MNS4bz8wfwfGPxsP3KxKbg+R8idvPcC95ZtsCDWta
         8efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684760611; x=1687352611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGYIAzQOuTRI66Am1Ptve2sIqi15jbY7Ad1+ZUDPwKs=;
        b=TeZAKtnMY4HGozWlXauId2NN9P1+y7WkrhNQjqVpVge6y8CAaeggfGCr9UASc+hYHG
         IvmtvBUSyEdiOJJzpmJpWw5910rljmR7dERC8Ro5d41FJvoSq8dGSJq4nXRtwE1qR5Gt
         SfhOTUaQwQu6KM1SGMSFIvrnHdDpllKX2rpvnvRR0AQY3mdGyGVHntacg+YiwFtfnOXN
         ppTFX6w8x8OXIn7WAlfCzYjWJxe+bd/LL6rBhy/vp1m2NC0Mk2IdmEWKrXyMf2ninWvY
         NF2QTAjycFqqnwJopzyq430ISwn3BaSR8CVBCdjNl8zs1EQTIaN8+PhKagIhf36DNyy/
         GLow==
X-Gm-Message-State: AC+VfDz+yKrgNKv70sSyrskiHO5p+lEhNkS9NUlgdURwTTL8Ar1tSq8H
        9cl6Sv1mBoBokHofNczL1+k=
X-Google-Smtp-Source: ACHHUZ6ZSm+kScG2S70dbxhzmm/gzyAoLaeONw8KuC4YzXluOOGmB9LEswKykWoqpTWtm+/gTYVA5g==
X-Received: by 2002:a9d:5e8f:0:b0:6af:793b:a87 with SMTP id f15-20020a9d5e8f000000b006af793b0a87mr1646601otl.28.1684760610982;
        Mon, 22 May 2023 06:03:30 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id t3-20020a9d5903000000b006a43519523fsm2324970oth.1.2023.05.22.06.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 06:03:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <e0086aed-6aad-1b1c-65d0-1bb5e2ae3698@lwfinger.net>
Date:   Mon, 22 May 2023 08:03:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] wifi: rtw89: 8851b: add to enable 8851BE
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     timlee@realtek.com, linux-wireless@vger.kernel.org
References: <20230519031500.21087-1-pkshih@realtek.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230519031500.21087-1-pkshih@realtek.com>
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

On 5/18/23 22:14, Ping-Ke Shih wrote:
> With preparation before, this patchset can enable 8851BE eventually.
> Thanks for the review, Kalle.
> 
> The first four patches are to add remaining chip_ops and chip_info.
> Patch 5/7 is to extend debugfs entry of read_reg to have ability to read
> wider length of registers. Patch 6/7 is to enable a firmware feature, and
> other features like hardware scan aren't verified completely, so I defer
> to enable them later because current version can still work fine.
> 
> The last patch 7/7 is to modify Kconfig and Makefile to enable 8851BE.
> 
> Chin-Yen Lee (1):
>    wifi: rtw89: add tx_wake notify for 8851B
> 
> Ping-Ke Shih (6):
>    wifi: rtw89: 8851b: add TX power related functions
>    wifi: rtw89: 8851b: fill BB related capabilities to chip_info
>    wifi: rtw89: 8851b: add MAC configurations to chip_info
>    wifi: rtw89: 8851b: add RF configurations
>    wifi: rtw89: enlarge supported length of read_reg debugfs entry
>    wifi: rtw89: 8851b: add 8851be to Makefile and Kconfig

I received samples of the RTW8851BE and the preliminary version of these patches 
one week ago. I tested with that code for 4 days, and then switched to this 
version when it was posted here. During the nearly 7 days of testing, I found no 
major issues. The connection was stable with a local LibreSpeed server and 
Speedtest.net both showing 400-500 Mbps up and down. The connection was to an 
ax1500 AP using the 5G band.

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry


