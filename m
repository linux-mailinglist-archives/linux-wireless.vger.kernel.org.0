Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373C5638FAF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 19:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKYSYn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 13:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKYSYm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 13:24:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C766E2528C
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 10:24:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i12so8050518wrb.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 10:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/ho0aVfIHc+eKPf6SFcxpEyxbEE5wSe4gBsAfS4ZRA=;
        b=lJzC8FnGf2XkcQL+c/vEZe8Cxlfc3SNiwTF7sYmSCX4P9xIqbcyVrG4F34eF9mDwtK
         e/DwIrf6JP2tF6AyFRsAHLeA7ubtga+xPf8zKXH7+gtlU7FdKQUgy5NQdf8d++xww/7q
         3O7PigBMot6CbqvdxCKfER0OM8JwM5uKH7kc95DXnvZlwW46lT2LxagEN40NnwYPzvHu
         yh3dfD438b3llsMkNguP/fsyaeSTWcNDI70zTrMPqAXJHQ7ZuwrjCB58pQ+sknuWIKYU
         I3EUY3hvFCqupm936Y4vEzoIBihrOyvv31lIbcYZx2xy5RPDQXYCXYpgDKETGLbXgo5V
         xcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/ho0aVfIHc+eKPf6SFcxpEyxbEE5wSe4gBsAfS4ZRA=;
        b=wZmABC4x5qTxjc1QftKHRym1AWzu5gdbKt/pMBz+ls0+vpAFo1z8fy6goHFLsh3k3I
         T8e2NEuNQI+LEZC6nUYmbxaZO03tVUgy6Bw9Ras7GHOy4IlkvGARzYyLXDUGA4DH+d7B
         E6rY9FkefHqYOqoJ4dNqvSeW2XnblMEqtKeeRkXv6zluJ1U0iMrcAxlPzZRbQ8AtV0j8
         CV4wcNwVvniqGe5Gjvxf8Cg7dqvo186Js0b8nv+C6VtQY2oA9UZEAL0MQrU8ZavwvFBx
         41v6lGmb9uiF6XVebcerv9I3GB982Sk7CjhwJk/jD1Pxhg8JFNSKqYNhP0hSZrvm4iea
         FsQQ==
X-Gm-Message-State: ANoB5pmpcah7T36mZVQgPCwqKFBNEEwkEEPVHB0K6SDjA91ZsDNlRdjp
        BM1dnFN7Mb3mgkrYMf+ii+NlRv/wVzY=
X-Google-Smtp-Source: AA0mqf5ShoBgubkILSZj1B2neOIYHdfjn3sKbwv6xhL7qpsMSoUuoGoN+KJghskmHXQizMzQBTsAZQ==
X-Received: by 2002:a5d:6503:0:b0:22e:35e8:382d with SMTP id x3-20020a5d6503000000b0022e35e8382dmr24547476wru.475.1669400680324;
        Fri, 25 Nov 2022 10:24:40 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id j13-20020adfff8d000000b00241bd177f89sm4307098wrr.14.2022.11.25.10.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 10:24:39 -0800 (PST)
Message-ID: <19ab38b6-999a-a485-814e-297f7929b806@gmail.com>
Date:   Fri, 25 Nov 2022 20:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <00489244-ba7c-797a-28f0-8788a40f7974@gmail.com>
 <ee44c114-e7ba-797e-f7a8-8a8dde7d098a@gmail.com>
 <7afa29a186904e5e901ca711671e8421@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <7afa29a186904e5e901ca711671e8421@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/11/2022 10:13, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Thursday, November 24, 2022 5:34 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH 2/2] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
>>
>> The ra_report struct is used for reporting the TX rate via
>> sta_statistics. The code which fills it out is duplicated in two
>> places, and the RTL8188EU will need it in a third place. Move this
>> code into a new function rtl8xxxu_update_ra_report.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> This patch should be applied after my other patch:
>> "[PATCH v2] wifi: rtl8xxxu: Fix use after rcu_read_unlock in rtl8xxxu_bss_info_changed"
>> ---
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 105 ++++++++----------
>>  1 file changed, 45 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 1c29d0bf09e2..2c8798cb3b4b 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4598,6 +4598,32 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
>>  	}
>>  }
>>
>> +static void rtl8xxxu_update_ra_report(struct rtl8xxxu_ra_report *rarpt,
>> +				      u8 rate, u8 sgi, u8 bw)
>> +{
>> +	u8 mcs, nss;
>> +
>> +	rarpt->txrate.flags = 0;
>> +
>> +	if (rate < DESC_RATE_MCS0) {
> 
> I think 'if (rate <= DESC_RATE_54M)' would be more reasonable, because 
> rtl8xxxu_legacy_ratetable[] are list of legacy rates.
> 
Okay.

