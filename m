Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE19465C7E6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjACUMN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 15:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjACUML (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 15:12:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5BDE80
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 12:12:08 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so76711182ejc.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 12:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HIUFCwEh9wuq+a1hFljzKi3hoLmgkLbeUjD7nFv6SU=;
        b=Eec7x4wSUWqH97V1ENqgG/44xGTDk2/0tp1g73HoPMUKOwdNI+FKf7UZyPaRrOuFdR
         330jOmfQ4YcY1UmSsq7KA54qOpg/lXHmTR/DCKIdbfOsxHASHFuiwfdHcjMytisUhGjI
         ivmk+tsvxQhBF3D56Q02LIJptFLuxJbPBcc9wk2Rk+80lbgKabgJvZM+qybvTgwWSYI2
         YtMkvpbsS3TpO/NCnpNMjEItBA8EMHR8bTyMhEmme1KVRUJoODgzf9ssyXk0t9CWIbFj
         D/HZY+xPkFFirZMIkC9Ghah6oVvwnKwJnkX81DThUQBbNloijozq/9LDuKCh28pg5b0J
         avPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HIUFCwEh9wuq+a1hFljzKi3hoLmgkLbeUjD7nFv6SU=;
        b=DoYWopGEY6K1Qc02mkJ+EfahVbLt2osUQscEGlPrkKNzeI/hE4ar574aZDExrvatgi
         OaK/BEl/nXee0WhEWhySOH/SN33mU5+8tjEpiG8yhXoK30o5nXEEuVgnrtpxhJaxHmGn
         ZhvbCk05orrXL3PpSqKdAPQsT3qVhG8GMueDT1QExOM5ecunsJu9nnXEDycRXqlcKGpX
         0MzEIlMAGq0q2xjjk7SFkoX4HEO0/7LNoYBllQfHpUOj2NUKUKFqItY8HPPr+Xm6+SAc
         5F/T94iQFWOSvKCxArMf6Qc+AfXE+5CR05wenxu7uYbMd7uYZaOAiTA1NcYygnmBfoDt
         4Ciw==
X-Gm-Message-State: AFqh2krh42t/rNRpPMKeDCLRER1xm4m7OEjt8El1SMWFzMxAYw8L7zPd
        W6gdPBB6QKqb5UvaTgTfE3y8QhacFWo=
X-Google-Smtp-Source: AMrXdXu5ViyKdQ/vgU/O0WkJoacLnWN5R8OPlRDORb/EV3SQqOkFdWkSRg9rsirx27POmyPbIUEY1Q==
X-Received: by 2002:a17:907:c28f:b0:7c1:eb:b2a7 with SMTP id tk15-20020a170907c28f00b007c100ebb2a7mr3502683ejc.13.1672776726540;
        Tue, 03 Jan 2023 12:12:06 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id fy11-20020a1709069f0b00b0084ca4bd71b8sm5285570ejc.208.2023.01.03.12.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 12:12:05 -0800 (PST)
Message-ID: <7bcb7489-aec1-e20a-44d3-3ba303e5d86f@gmail.com>
Date:   Tue, 3 Jan 2023 22:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <6fcaaead-876c-68d1-a049-f1e7f7ff81e7@gmail.com>
 <55813ec6-b99f-dd25-a1e2-7af9e3be3117@gmail.com>
 <20da2e492e1e4c6ab00ddc53e7e0a79c@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20da2e492e1e4c6ab00ddc53e7e0a79c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/01/2023 10:13, Ping-Ke Shih wrote:
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Saturday, December 31, 2022 12:54 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>
>> Subject: [PATCH 2/2] wifi: rtl8xxxu: Use a longer retry limit of 48
>>
>> The Realtek rate control algorithm goes back and forth a lot between
>> the highest and the lowest rate it's allowed to use. This is due to
>> a lot of frames being dropped because the retry limits set by
>> IEEE80211_CONF_CHANGE_RETRY_LIMITS are too low. (Experimentally, they
>> are 4 for long frames and 7 for short frames.)
>>
>> The vendor drivers hardcode the value 48 for both retry limits (for
>> station mode), which makes dropped frames very rare and thus the rate
>> control is more stable.
> 
> I have similar feeling with Realtek 802.11ac chips as well, but I didn't
> dig further years ago. Maybe, it could have TX EVM problem.
> 
>>
>> Because most Realtek chips handle the rate control in the firmware,
>> which can't be modified, ignore the limits set by
>> IEEE80211_CONF_CHANGE_RETRY_LIMITS and use the value 48 (set during
>> chip initialisation), same as the vendor drivers.
>>
>> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> 
> No sure if "Fixes" is suitable to this patch, because original looks well but
> bad performance in real.
> 

Mostly I care about the Fixes tag because it gets the patch into the
stable kernels, but I can use the Cc tag for that instead.

>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>> ---
>>  drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 ---------
>>  1 file changed, 9 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index f5fd3c448587..9bca5e837583 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -6184,7 +6184,6 @@ static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
>>  {
>>  	struct rtl8xxxu_priv *priv = hw->priv;
>>  	struct device *dev = &priv->udev->dev;
>> -	u16 val16;
>>  	int ret = 0, channel;
>>  	bool ht40;
>>
>> @@ -6194,14 +6193,6 @@ static int rtl8xxxu_config(struct ieee80211_hw *hw, u32 changed)
>>  			 __func__, hw->conf.chandef.chan->hw_value,
>>  			 changed, hw->conf.chandef.width);
>>
>> -	if (changed & IEEE80211_CONF_CHANGE_RETRY_LIMITS) {
>> -		val16 = ((hw->conf.long_frame_max_tx_count <<
>> -			  RETRY_LIMIT_LONG_SHIFT) & RETRY_LIMIT_LONG_MASK) |
>> -			((hw->conf.short_frame_max_tx_count <<
>> -			  RETRY_LIMIT_SHORT_SHIFT) & RETRY_LIMIT_SHORT_MASK);
>> -		rtl8xxxu_write16(priv, REG_RETRY_LIMIT, val16);
>> -	}
>> -
>>  	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
>>  		switch (hw->conf.chandef.width) {
>>  		case NL80211_CHAN_WIDTH_20_NOHT:
>> --
>> 2.38.0
>>
>> ------Please consider the environment before printing this e-mail.

