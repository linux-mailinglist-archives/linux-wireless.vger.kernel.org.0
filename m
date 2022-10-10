Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C495F9BCA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJJJXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiJJJXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 05:23:32 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B284A834
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:23:22 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h10so6785914qvq.7
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GngJHu84keVFVSxjlICRQPlheGjtxaNHdwIFm3QLoGQ=;
        b=YEUbTYl98iXu+RPOU306hf8h0+bblN5nwyV3mHuNeqmMZTe/TMPMhna+xpXsvLUOcE
         xtiHgkZuSw470rYsR+CcbmAE7MBXrLyuum8k9LAGIioV+pjNm5IIh031mfhGBASLBmus
         lNeQc2sOuiwznhoYWIHcT9MBTbeW+py4CqPQkrzDdksupsrDteJikmBVcl3eMEem1sTp
         VatF6pAvf08CRuioOwrEPBKEgvwD+n9Ofdr5T+w5FDCRVJfR3cvZpF9yLmeg+TMixI9x
         xpxTVg1EtiRYFpsdRaEHn625C+k4dBasu3MOkpOBrhBiRvbS+7hsy0/QFFjwZgmhvAK4
         pRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GngJHu84keVFVSxjlICRQPlheGjtxaNHdwIFm3QLoGQ=;
        b=XbDxScgazMraWvk5mamu9oAg6fsikr7LNuPLYvNuw0MQs+OFfpSdaBs4iQSFgwP3uf
         kvAmMoFNQfRx9tmpY146jNnAmBijtuHbIp2jD58fEbM7IwpaY7YjdxrXzZRWgWTQ6uFa
         IuqmztFiDqrebGcBlBlvg4U4jiGCciNxz5zKO2Hmtw1DevKspDz5J/O4zwd2z8Kt/My2
         krklpIG0cy/wbu80DPD9Thc/h7Xgx9DXZTy1vE1T+hUYzIigj7qVUzm6t1ptyWY6QtQf
         NFS6h961rlyNw/dzfNogvCpNWzjPe+B/rNibPRbjp/m85gtRI1Ed4i5y7SyiQmEtnrio
         azpg==
X-Gm-Message-State: ACrzQf2H4NW3tAVcwnLMA0kg9a7wdTqr7vsKhH0h1QlRekmRNgj7Tgnw
        avSJxGfQOuN8D7dJMcebHW8=
X-Google-Smtp-Source: AMsMyM6axkWz/sBFqPigulPmM5pioBt2jdeyYlHKtemE5w6qh64I5CWas7fxj6+ztMmtu6uMoIELzw==
X-Received: by 2002:ad4:5949:0:b0:4b3:cfb6:5ef9 with SMTP id eo9-20020ad45949000000b004b3cfb65ef9mr10468894qvb.103.1665393802027;
        Mon, 10 Oct 2022 02:23:22 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id i5-20020a37b805000000b006cfc9846594sm9367750qkf.93.2022.10.10.02.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:23:21 -0700 (PDT)
Message-ID: <b7518fd9-fcd1-0ddb-e1cc-2bc7687d3ab7@gmail.com>
Date:   Mon, 10 Oct 2022 11:23:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while informing
 its bss to cfg80211 layer
Content-Language: en-US
To:     "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        Double.Lo@infineon.com
References: <20220927034138.20463-1-ian.lin@infineon.com>
 <20220927034138.20463-5-ian.lin@infineon.com> <874jwsrojr.fsf@kernel.org>
 <4e602611-aed5-dfe7-6ce7-42d1fc7ca53e@infineon.com>
 <b43d934d-f3e8-9459-0096-11908df27c15@infineon.com>
 <87y1tupuqy.fsf@kernel.org> <9e166687-1d35-4216-5c2c-a0e783ead406@gmail.com>
 <51236a0c-5210-533b-7755-94145e6c5a1d@infineon.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <51236a0c-5210-533b-7755-94145e6c5a1d@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/6/2022 10:34 AM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
> 
> 
> On 10/5/2022 6:22 PM, Arend Van Spriel wrote:
>> Caution: This e-mail originated outside Infineon Technologies. Do not 
>> click on links or open attachments unless you validate it is 
>> safe<https://intranet-content.infineon.com/explore/aboutinfineon/rules/informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en.aspx>. 
>>
>>
>>
>>
>> On 10/5/2022 9:58 AM, Kalle Valo wrote:
>>> "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com> writes:
>>>
>>>> On 9/28/2022 6:07 PM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
>>>>>
>>>>>
>>>>> On 9/28/2022 2:38 PM, Kalle Valo wrote:
>>>>>> Caution: This e-mail originated outside Infineon Technologies. Do
>>>>>> not click on links or open attachments unless you validate it is
>>>>>> safe<https://intranet-content.infineon.com/explore/aboutinfineon/rules/informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en.aspx>. 
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Ian Lin <ian.lin@infineon.com> writes:
>>>>>>
>>>>>>> From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>>>>>
>>>>>>> cfg80211 layer on DUT STA is disconnecting ongoing connection
>>>>>>> attempt after
>>>>>>> receiving association response, because cfg80211 layer does not
>>>>>>> have valid
>>>>>>> AP bss information. On association response event, brcmfmac
>>>>>>> communicates
>>>>>>> the AP bss information to cfg80211 layer, but SSID seem to be
>>>>>>> empty in AP
>>>>>>> bss information, and cfg80211 layer prints kernel warning and then
>>>>>>> disconnects the ongoing connection attempt.
>>>>>>>
>>>>>>> SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
>>>>>>> updating the SSID for hidden AP while informing its bss information
>>>>>>> to cfg80211 layer.
>>>>>>>
>>>>>>> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>>>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>>>>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>>>>>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>>>>>>> ---
>>>>>>> .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 8
>>>>>>> ++++++++
>>>>>>>    1 file changed, 8 insertions(+)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>> index 6c37da42e61b..3560afe0ccfe 100644
>>>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>>>>> @@ -3003,6 +3003,7 @@ static s32 brcmf_inform_single_bss(struct
>>>>>>> brcmf_cfg80211_info *cfg,
>>>>>>>         u8 *notify_ie;
>>>>>>>         size_t notify_ielen;
>>>>>>>         struct cfg80211_inform_bss bss_data = {};
>>>>>>> +     struct brcmf_tlv *ssid;
>>>>>>>
>>>>>>>         if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
>>>>>>>                 bphy_err(drvr, "Bss info is larger than buffer.
>>>>>>> Discarding\n");
>>>>>>> @@ -3032,6 +3033,13 @@ static s32 brcmf_inform_single_bss(struct
>>>>>>> brcmf_cfg80211_info *cfg,
>>>>>>>         notify_ielen = le32_to_cpu(bi->ie_length);
>>>>>>>         bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>>>>>>>
>>>>>>> +     ssid = (struct brcmf_tlv *)
>>>>>>> +             brcmf_parse_tlvs(notify_ie, notify_ielen, 
>>>>>>> WLAN_EID_SSID);
>>>>>> This still casts away the const. For some reason brcmf_parse_tlvs()
>>>>>> takes a const buffer:
>>>>>>
>>>>>> static const struct brcmf_tlv *brcmf_parse_tlvs(const void *buf,
>>>>>> int buflen, uint key)
>>>>>>
>>>>>> I'm not familiar with brcmfmac internal so I don't know why it does
>>>>>> that, but that means the buffer cannot be modified. If you need to
>>>>>> modify the ssid should you make a copy of it?
>>>>>
>>>>> In brcmf_parse_tlvs(const void *buf, int buflen, uint key),
>>>>> it will find the key in buf and return the address of this key, as
>>>>> the return pointer.
>>>>> This function don't intend caller to modify content of buf in most
>>>>> cases, so it defines a const return pointer.
>>>>> But in this case, it just need to do it, so I need the typecast here.
>>>>
>>>> Do you accept the typecast here?
>>>
>>> To me writing a const data is wrong. IIRC it was something like six
>>> months ago that rtw89 was also writing a const variable and it caused a
>>> crash because the memory was in a read-only area (or something like
>>> that).
>>
>> So how should this be solved. The pointer returned by the
>> brcmf_parse_tlvs() function is pointing inside the buffer passed as
>> first argument, ie. notify_ie which is non-const. So it is perfectly
>> safe to do the cast as suggested here. We could do a pointer-arithmetic
>> dance here to avoid the cast, but that only make things more obscure.
>>
> I may calculate the offset and cast on notify_ie.
> Than the code will be like this, is that ok?
> 
> u8 *notify_ie;
> int ssid_offset;
> ssid_offset = brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID) - 
> (struct brcmf_tlv *)notify_ie;
> memcpy(notify_ie + ssid_offset + offsetof(struct brcmf_tlv, data), 
> bi->SSID, bi->SSID_len);

Hi Ian,

I am strarting to doubt the entire patch now. The notify_ie contains 
beacon/proberesp elements in TLV format. So how can this work by simply 
copying an SSID into the notify_ie buffer. The patch says: "SSID is 
empty in SSID IE" so I would conclude the element to be two bytes, ie. T 
= WLAN_EID_SSID and L=0 (no V). If this is true, it means the SSID will 
overwrite/corrupt the TLVs located after the SSID. Also the length is 
not corrected. Maybe I am mistaken and the SSID element for the 
Hidden-SSID scenarion is different. Will check the 802.11 spec.

Regards,
Arend


