Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB99632534
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 15:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKUOMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 09:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKUOLo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 09:11:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BBFD1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 06:08:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x5so15959457wrt.7
        for <linux-wireless@vger.kernel.org>; Mon, 21 Nov 2022 06:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDdD/8FNuAnukqL7oA2yo8to399hUapxf40PgFF0knM=;
        b=BVO5JQos/oXCcBJdRX/Ez9BNCRlX23XH8xdSr6kQso9AqhzW4IwVQ9fhOt499Zbgrm
         o+XpQ0wSuHoDAw/1cVcIiu1MdXOkoj8FQbbSs3Re0NrQl62Vk7N7P/0H5GOYZNxH/oXM
         cysCzcyntGZMQ08QRGw5UtC7PBU8Pr2G6voXiwMlBjE1+NRSy89FWKWwgtl1uoqHTKdz
         TLswewng2U/F+B1Nn6XZvZu9oeT7qfC7GiT09UuDIHfdmyOqRFTA4+0hixvNnpIeOOR7
         9o+0CI65DHYzvU9Yxvosc4An0L3a5HAkbnTbCS2WdLcEWDY/qTMoPW6Gh2BD+SdhD9cN
         5Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDdD/8FNuAnukqL7oA2yo8to399hUapxf40PgFF0knM=;
        b=LFWC2qCxxPsq6jWK/xHqJQMtMu6Hv2TmE73nrAEKFE1OahX5qhUJzJYBCyOV1WtVtk
         thmCnuiXhe5kKUiOeMiaD93q3tk+fp5w218vNPdZr6Sg8exkxyqbLULuTAfjJ1dCfX2d
         8yL5X1UbPapp9LgIvFP3FsnwvR5iBkNJv40zg0mMj9yKKcV++xOGl7m6F0EbxkJ4tXmC
         cb7JQORIwV5jVhHSOooF5jjz4K3rsHAu3LeVyIkXFvrxBxD2J3OgXrkgNXRl9ZJqby+y
         ahMpGmm1ysn9dvOgPVekFy1sVuFs7yd6pMwBbaOcNT/pudLEK9aw3CCQH5DOqI3HEpvq
         i4Sg==
X-Gm-Message-State: ANoB5pmyyDJK1RG6JDoFlz1IOQaQvW0dVMLce6MP0SSk63AX4i5gExgw
        LGB2ifB1iQqqnz1z2SwWnaHNJmTnuC4=
X-Google-Smtp-Source: AA0mqf7Gc3jJrpFbvNv+V0lxWe5tJ1gN/FTK3DrTxvaYHr7OpjAYknxcwK5SwK0JPE6elbtut4SnXQ==
X-Received: by 2002:adf:dcd2:0:b0:241:b99c:b48 with SMTP id x18-20020adfdcd2000000b00241b99c0b48mr10801399wrm.45.1669039728550;
        Mon, 21 Nov 2022 06:08:48 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm27082867wms.0.2022.11.21.06.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:08:48 -0800 (PST)
Message-ID: <9686600b-f721-8849-545e-25a3854a4c9c@gmail.com>
Date:   Mon, 21 Nov 2022 16:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix use after rcu_read_unlock()
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <a4c4f176-8903-6bf7-3b31-880ff7ebf195@gmail.com>
 <391fa36560424ac893d7fc52aa8e7a63@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <391fa36560424ac893d7fc52aa8e7a63@realtek.com>
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

On 21/11/2022 07:39, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Monday, November 21, 2022 4:47 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
>> Subject: [PATCH] wifi: rtl8xxxu: Fix use after rcu_read_unlock()
>>
>> ... in rtl8xxxu_bss_info_changed().
> 
> Mentioned where you modify in subject might be better.
> 
Okay.
>>
>> Commit a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
>> introduced a line where the pointer returned by ieee80211_find_sta() is
>> used after rcu_read_unlock().
>>
>> Move rcu_read_unlock() a bit lower to fix this.
>>
>> Fixes: a8b5aef2cca1 ("wifi: rtl8xxxu: gen2: Enable 40 MHz channel width")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> My bad. I'm not sure how serious this problem is because I've been using
>> this code all this time (2+ months) without any trouble. I only noticed
>> it when moving some of this code into a new function.
> 
> 'sta' can be freed if a station leaves, and then causes use-after-free. But,
> luckily iface_work processes rtl8xxxu_bss_info_changed() and 'sta' leaving, so
> it will not happen at the same time.
> 
That's good then.

>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index e8fcd531c437..28f136064297 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4645,7 +4645,6 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>  			if (sta->deflink.ht_cap.cap &
>>  			    (IEEE80211_HT_CAP_SGI_40 | IEEE80211_HT_CAP_SGI_20))
>>  				sgi = 1;
>> -			rcu_read_unlock();
>>
>>  			highest_rate = fls(ramask) - 1;
>>  			if (highest_rate < DESC_RATE_MCS0) {
>> @@ -4670,6 +4669,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>  				else
>>  					rarpt->txrate.bw = RATE_INFO_BW_20;
>>  			}
>> +			rcu_read_unlock();
>>  			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
>>  			rarpt->bit_rate = bit_rate;
>>  			rarpt->desc_rate = highest_rate;
>> --
>> 2.38.0
>>
>> ------Please consider the environment before printing this e-mail.

