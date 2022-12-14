Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3264C7D9
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 12:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiLNLXn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 06:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiLNLXj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 06:23:39 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B37D655E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 03:23:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id t17so43745702eju.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1biEslHldAsmR+Scn/udysfoqjERpj8d8iKhGCik3o=;
        b=BCugCobdpsH3wo40WL/P80oVxoNjoiANSpFRkCbnOi0uGXbu0kiEPtlRh+inB+fs1+
         qp+CRFwePi/p+dMSNTIsnOl5XyfFLcmnbLaqKFfKf1oIHRhlVL8cYzc3/mMQR+afHXpf
         rKuVpa45HtR3IdEq1+5CMpzhuOudn1OeThLYyxT4+H1SYE/2h5Gxe83XkrB/nD4kWSiu
         Cl5AoaDAPHn58HHNJVFrk1uUB0WCBlnOTJa9tV00ht+e/tHOT7EtsxmbAMEGnYislurr
         9VajTkWmYgjymxFCbrAR3BJlcS93w1ryXCawCSltvE+n490G4c3Zm2tIdc82YwM7fACn
         1tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p1biEslHldAsmR+Scn/udysfoqjERpj8d8iKhGCik3o=;
        b=B60fPNMUcqIgBauRYI5uivwTCido/ewMyPovOcbFBgY3pml0x1KboStcWeTkmg6qcv
         pfGAUEj/MOxzPWHncWC1sVIpEseC+HCX0ndzYlWMZUDA9KOIdreAdd0+teWHoumoorhp
         psOn6Vr7kCm49IjpeCVaovMb5whUiHZ5p+Bzvj8BmsqJ+3NlEC0Q1KI7xVyfqL+HYBps
         LGxK/ifypl+5q5nvZp0gYfkwi+Y4/hCDsuvEq7WlneB5i+akYwGVJDHZUehGywjTRarG
         mywCPNQkWYyKxK7QP4PN7JhAfYHcDXqf4H2yth2R7SaXkIimMLaSBHa0UdK/HPxQla4/
         IalQ==
X-Gm-Message-State: AFqh2kopN/az6yquKwwKsXIY6DE/2Tu7Wxwf5s9/BG9T6UnPBRR6kRsE
        4TBHC1xIfi+lea771glOorryFRyY0MA=
X-Google-Smtp-Source: AMrXdXukpy5GIdKnIRtPeucDx5PlJm8E03rRhe4naAUdaEtbGgyOQxv3QqQhAxPZSC5I+3XglCBTUA==
X-Received: by 2002:a17:906:6b13:b0:7ae:29fa:ba8f with SMTP id q19-20020a1709066b1300b007ae29faba8fmr2131417ejr.2.1671017015786;
        Wed, 14 Dec 2022 03:23:35 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.153])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007c10bb5b4b8sm5675202ejf.224.2022.12.14.03.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 03:23:34 -0800 (PST)
Message-ID: <1e366190-eb84-3cdb-6408-18dfa8da18c0@gmail.com>
Date:   Wed, 14 Dec 2022 13:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping code
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Andrea Merello <andrea.merello@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>
References: <c9619d20-ba6b-1611-dafb-9fe14617e1ee@gmail.com>
 <40b9a6949d22484493e49af0200ca65d@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <40b9a6949d22484493e49af0200ca65d@realtek.com>
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

On 14/12/2022 05:58, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, December 14, 2022 1:27 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Ping-Ke Shih <pkshih@realtek.com>; Andrea Merello
>> <andrea.merello@gmail.com>; Taehee Yoo <ap420073@gmail.com>
>> Subject: [PATCH v2 1/5] wifi: rtl8xxxu: Deduplicate the efuse dumping code
>>
>> Every chip family except RTL8723AU has a copy of the efuse dumping
>> code. Remove this and dump the efuse from a single place using a new
>> function rtl8xxxu_dump_efuse().
>>
>> Also, use print_hex_dump() to print the efuse instead of a loop and
>> dev_info(). It shows the ASCII interpretation of the bytes, which is
>> nice.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Patch is new in v2.
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 11 -----------
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c | 10 ----------
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |  9 ---------
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 11 -----------
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 ++++++++++++++
>>  5 files changed, 14 insertions(+), 41 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 3ed435401e57..827672ce953d 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -1813,6 +1813,17 @@ static int rtl8xxxu_read_efuse(struct rtl8xxxu_priv *priv)
>>  	return ret;
>>  }
>>
>> +static void rtl8xxxu_dump_efuse(struct rtl8xxxu_priv *priv)
>> +{
>> +	dev_info(&priv->udev->dev,
>> +		 "Dumping efuse for RTL%s (0x%02x bytes):\n",
>> +		 priv->chip_name, EFUSE_REAL_CONTENT_LEN_8723A);
>> +
>> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
>> +		       priv->efuse_wifi.raw, EFUSE_REAL_CONTENT_LEN_8723A,
> 
> EFUSE_MAP_LEN seems to be more suitable, because:
> 
> 	union {
> 		u8 raw[EFUSE_MAP_LEN];
> 		...
> 	} efuse_wifi;
> 
> and, suffix _8723A is weird to me.
> 
Yes, that's better. I didn't notice EFUSE_MAP_LEN.

>> +		       true);
>> +}
>> +
>>  void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
>>  {
>>  	u8 val8;
>> @@ -6839,6 +6850,9 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>  		goto err_set_intfdata;
>>  	}
>>
>> +	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE)
>> +		rtl8xxxu_dump_efuse(priv);
>> +
>>  	rtl8xxxu_print_chipinfo(priv);
>>
>>  	ret = priv->fops->load_firmware(priv);
>> --
>> 2.38.0
>>
>> ------Please consider the environment before printing this e-mail.

