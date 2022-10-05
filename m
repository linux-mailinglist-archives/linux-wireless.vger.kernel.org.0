Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D55F5282
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 12:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJEKWu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJEKWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 06:22:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71D760FC
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 03:22:47 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id y20so1431755qtv.5
        for <linux-wireless@vger.kernel.org>; Wed, 05 Oct 2022 03:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IClrzqheK2yukCaauMB8/wpkGilQ38YAviIRtp8bq2A=;
        b=FxoAFI/X0cjlMecHe7QNJo2sHdE8fkIJzb6an9mg4jm9oUrheg1UGXBFAmJ5o88dqI
         cdyeYQEwNETeLx4kocvvFkBHY72Gn6StamhBTcK2VLyb5qioA/4GaphYEsPRAnA139fN
         4Qi0Cfz+OHec8G/Ye3/HGeUSSxnwiqLJfvOGZZFnjW78T7yvFdTwVRORHyBd2bv+idYR
         EBcrlFAsq74lxeOYefoK+m8hyWtpqEKUM+LpCkYtL3RI1B2y+PBDnYDvRqT68ZebM0AT
         chEf52v4gEFVS1Gw9TCskoH9RoQXEAtQvn7UGlgDpZ7P7GrYkmFQ9bal3hZEXizJivaU
         afAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IClrzqheK2yukCaauMB8/wpkGilQ38YAviIRtp8bq2A=;
        b=bB0V54oI5iINrv3norxdXIQ47fB7p15hZvyJ0sE0VHV2U7D659Jer+gYnM3u/eR8BQ
         gH8Toep2UFNFED1RsP8v5yx66V0XXZMKH6KszmIeig85eKF0hs6oZB3RIZPnTI5jyiph
         D/6yBbQ44Fc7yME256UbXookVarszhlqilQRCJYAuSWCHcomhfhwqdvynzumF/jNBpcp
         9FbWngLaL9oP8ra0fCL/9EfsMOpSTpGbGfv51jwDnbT5JSuJsDkgrHVhLA5Wz6zZ1+Hs
         mdVAJCcjOWR5mPBzMe3+BtCrewovNoSACgfmBao5VVKEVBD6Ghe3e/NxJk1yhUo67gGg
         zTYA==
X-Gm-Message-State: ACrzQf10Im8uVVdRJBsB4Nm2A9kOd55fhi5UJaB97BUSVtRqkedobQfr
        sNPCWdYSbCbRl+tww/DPEfg=
X-Google-Smtp-Source: AMsMyM6zQF+Wj6WiI/CxAcBLTHmUui7ibH+qdfKhV7Kl3GbksJo2rPnaw1J3kAI236KGT736my2PWw==
X-Received: by 2002:ac8:5f0c:0:b0:382:65e1:5ea5 with SMTP id x12-20020ac85f0c000000b0038265e15ea5mr7806209qta.193.1664965366109;
        Wed, 05 Oct 2022 03:22:46 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id bm8-20020a05620a198800b006cfc7f9eea0sm16364041qkb.122.2022.10.05.03.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 03:22:45 -0700 (PDT)
Message-ID: <9e166687-1d35-4216-5c2c-a0e783ead406@gmail.com>
Date:   Wed, 5 Oct 2022 12:22:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while informing
 its bss to cfg80211 layer
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        Double.Lo@infineon.com
References: <20220927034138.20463-1-ian.lin@infineon.com>
 <20220927034138.20463-5-ian.lin@infineon.com> <874jwsrojr.fsf@kernel.org>
 <4e602611-aed5-dfe7-6ce7-42d1fc7ca53e@infineon.com>
 <b43d934d-f3e8-9459-0096-11908df27c15@infineon.com>
 <87y1tupuqy.fsf@kernel.org>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <87y1tupuqy.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/5/2022 9:58 AM, Kalle Valo wrote:
> "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com> writes:
> 
>> On 9/28/2022 6:07 PM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
>>>
>>>
>>> On 9/28/2022 2:38 PM, Kalle Valo wrote:
>>>> Caution: This e-mail originated outside Infineon Technologies. Do
>>>> not click on links or open attachments unless you validate it is
>>>> safe<https://intranet-content.infineon.com/explore/aboutinfineon/rules/informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en.aspx>.
>>>>
>>>>
>>>>
>>>> Ian Lin <ian.lin@infineon.com> writes:
>>>>
>>>>> From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>>>
>>>>> cfg80211 layer on DUT STA is disconnecting ongoing connection
>>>>> attempt after
>>>>> receiving association response, because cfg80211 layer does not
>>>>> have valid
>>>>> AP bss information. On association response event, brcmfmac
>>>>> communicates
>>>>> the AP bss information to cfg80211 layer, but SSID seem to be
>>>>> empty in AP
>>>>> bss information, and cfg80211 layer prints kernel warning and then
>>>>> disconnects the ongoing connection attempt.
>>>>>
>>>>> SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
>>>>> updating the SSID for hidden AP while informing its bss information
>>>>> to cfg80211 layer.
>>>>>
>>>>> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>>>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>>>>> ---
>>>>>    .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8
>>>>> ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>> index 6c37da42e61b..3560afe0ccfe 100644
>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>> @@ -3003,6 +3003,7 @@ static s32 brcmf_inform_single_bss(struct
>>>>> brcmf_cfg80211_info *cfg,
>>>>>         u8 *notify_ie;
>>>>>         size_t notify_ielen;
>>>>>         struct cfg80211_inform_bss bss_data = {};
>>>>> +     struct brcmf_tlv *ssid;
>>>>>
>>>>>         if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
>>>>>                 bphy_err(drvr, "Bss info is larger than buffer.
>>>>> Discarding\n");
>>>>> @@ -3032,6 +3033,13 @@ static s32 brcmf_inform_single_bss(struct
>>>>> brcmf_cfg80211_info *cfg,
>>>>>         notify_ielen = le32_to_cpu(bi->ie_length);
>>>>>         bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>>>>>
>>>>> +     ssid = (struct brcmf_tlv *)
>>>>> +             brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
>>>> This still casts away the const. For some reason brcmf_parse_tlvs()
>>>> takes a const buffer:
>>>>
>>>> static const struct brcmf_tlv *brcmf_parse_tlvs(const void *buf,
>>>> int buflen, uint key)
>>>>
>>>> I'm not familiar with brcmfmac internal so I don't know why it does
>>>> that, but that means the buffer cannot be modified. If you need to
>>>> modify the ssid should you make a copy of it?
>>>
>>> In brcmf_parse_tlvs(const void *buf, int buflen, uint key),
>>> it will find the key in buf and return the address of this key, as
>>> the return pointer.
>>> This function don't intend caller to modify content of buf in most
>>> cases, so it defines a const return pointer.
>>> But in this case, it just need to do it, so I need the typecast here.
>>
>> Do you accept the typecast here?
> 
> To me writing a const data is wrong. IIRC it was something like six
> months ago that rtw89 was also writing a const variable and it caused a
> crash because the memory was in a read-only area (or something like
> that).

So how should this be solved. The pointer returned by the 
brcmf_parse_tlvs() function is pointing inside the buffer passed as 
first argument, ie. notify_ie which is non-const. So it is perfectly 
safe to do the cast as suggested here. We could do a pointer-arithmetic 
dance here to avoid the cast, but that only make things more obscure.

Regards,
Arend
