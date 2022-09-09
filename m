Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D425B3B64
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiIIPDp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiIIPDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 11:03:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F209FAA0
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 08:03:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r18so4609447eja.11
        for <linux-wireless@vger.kernel.org>; Fri, 09 Sep 2022 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0PvzO7Zc/9lsEj+q9ShQXujTF1Hie64ssOba6lCUGWg=;
        b=VpdObf80jvfKQpoTF0eJilRApaz6Zr6bMGpBMZ5JVyXqEWqX7VtPNh6GUPtgR1+vnP
         jftR9tTvZHRc0Nz0bth02ht9drX+V6+5N4OkSorc5R9KRzTj5/VpKaW/MGRmwoBShFBd
         t12YKHcUSWIiPcm/zCs2Nshv86UXELDmVhE6ZY841QHvSTGFkwNpyTRTgopZLR4P0dOn
         /0uB+LJ2H7gxR1P7qWpHyYIXHSpVhmtLXVd3JIKqZfEzIgphKUGAO4hu7/N0/oT0re/u
         4a+nkaXg085WFDSZhS2i9YhtCpX80/lvqVDkzAOtodklaKiTB7ixVejOveVZSSRGgwOI
         i45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0PvzO7Zc/9lsEj+q9ShQXujTF1Hie64ssOba6lCUGWg=;
        b=KBuz9aiCGQgQiI3IpY36rvfb6SUu4HJBc3Acybghh7m0jWY2Fj3/HhZXZZV+rUhzPD
         gfg3OYk7d1uCHUY0uwfm8iFgCipIL46d2qJ1ZpebZkjKS1wkuKUzFlQGxBTC0LJoReGp
         rwi37w+PFR5ixQRNmYfV22DvursyGk8R2AIfcdoYnGyi3C+rFk/dXJNPb5y21hGNNz7C
         5LNkY2MKyGvcKaysrgyz3hGQ9Hy3O9hZzook5ot8NLkSrq/hJVlq4VQSFN5BibmuuVQx
         Ow+9PIf3qtQ7UxxxO8fyi/0R34l9TEEm0VGQEfMgkpAG3Fh3hK89UmsgOaOegRErjP4D
         yeuw==
X-Gm-Message-State: ACgBeo3pvPb/aNh0kuxip1EiP6+HLTXAIxInfyDE+/1bCTMAZm7hTAa0
        SB1vZbYzexziu/5WthmPsVg=
X-Google-Smtp-Source: AA6agR5AlHuj6UZ/9ayWZEp7XXOVGVJuzZaT84LHPn8r/qAyd9ypNp1MZ5uaF5VklbfaKDmHrgVBQg==
X-Received: by 2002:a17:907:31c1:b0:742:28a3:5d08 with SMTP id xf1-20020a17090731c100b0074228a35d08mr9950099ejb.112.1662735816047;
        Fri, 09 Sep 2022 08:03:36 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id h12-20020aa7cdcc000000b0044f0c01196esm476707edw.65.2022.09.09.08.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:03:35 -0700 (PDT)
Message-ID: <52f498b9-9fc1-aabb-fad8-ef6ce95b594b@gmail.com>
Date:   Fri, 9 Sep 2022 18:03:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Fix skb misuse in TX queue selection
Content-Language: en-US
To:     Jes Sorensen <jes.sorensen@gmail.com>,
        linux-wireless@vger.kernel.org
References: <7fa4819a-4f20-b2af-b7a6-8ee01ac49295@gmail.com>
 <acd30174-4541-7343-e49a-badd199f4151@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <acd30174-4541-7343-e49a-badd199f4151@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 07/09/2022 18:02, Jes Sorensen wrote:
> On 8/31/22 12:12, Bitterblue Smith wrote:
[...]
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 52240e945b58..8d6f693bf60b 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -5177,6 +5177,8 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>  	if (control && control->sta)
>>  		sta = control->sta;
>>  
>> +	queue = rtl8xxxu_queue_select(hw, skb);
>> +
>>  	tx_desc = skb_push(skb, tx_desc_size);
>>  
>>  	memset(tx_desc, 0, tx_desc_size);
>> @@ -5189,7 +5191,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>  	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
>>  		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
>>  
>> -	queue = rtl8xxxu_queue_select(hw, skb);
>>  	tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
> 
> This could actually be made more resilient from someone moving the code
> around by passing in 'hdr' instead of relying on using skb->data in
> rtl8xxxu_queue_select(). We could also get rid of the hw argument to
> that function since it isn't used.
> 
> Cheers,
> Jes
> 

Good ideas! I'll do that when I'm done fiddling with the RTL8188FU.
