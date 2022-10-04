Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F075F4141
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 13:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJDLBw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDLBu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 07:01:50 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74A2937F
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 04:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664881309; x=1696417309;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YHG9ffD5ZTYsTVncWDEo+aojfxyLssugwSGIyGicS9A=;
  b=lVTbWGoL5nvsdp0lih7NJqcfejTbjsQC+j4dltMhR5oY0QXfphwGBT0u
   wfo7yP33OWdkxchPFxMCYSoHF5Mz5p0U5zxTnD9ZbVedwsrYjnVR57FYl
   DNG/go+z9XJL4pfeUGrzsQs1p24Xz/biACwrSQWKwQAQlljAGNdsauDxM
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="143877660"
X-IronPort-AV: E=Sophos;i="5.93,367,1654552800"; 
   d="scan'208";a="143877660"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 13:01:47 +0200
Received: from MUCSE812.infineon.com (MUCSE812.infineon.com [172.23.29.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Tue,  4 Oct 2022 13:01:47 +0200 (CEST)
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:01:47 +0200
Received: from [10.234.36.216] (10.234.36.216) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:01:44 +0200
Message-ID: <b43d934d-f3e8-9459-0096-11908df27c15@infineon.com>
Date:   Tue, 4 Oct 2022 19:01:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while informing
 its bss to cfg80211 layer
Content-Language: en-US
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
References: <20220927034138.20463-1-ian.lin@infineon.com>
 <20220927034138.20463-5-ian.lin@infineon.com> <874jwsrojr.fsf@kernel.org>
 <4e602611-aed5-dfe7-6ce7-42d1fc7ca53e@infineon.com>
In-Reply-To: <4e602611-aed5-dfe7-6ce7-42d1fc7ca53e@infineon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.234.36.216]
X-ClientProxiedBy: MUCSE807.infineon.com (172.23.29.33) To
 MUCSE835.infineon.com (172.23.7.107)
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/28/2022 6:07 PM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
>
>
> On 9/28/2022 2:38 PM, Kalle Valo wrote:
>> Caution: This e-mail originated outside Infineon Technologies. Do not 
>> click on links or open attachments unless you validate it is 
>> safe<https://intranet-content.infineon.com/explore/aboutinfineon/rules/informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en.aspx>.
>>
>>
>>
>> Ian Lin <ian.lin@infineon.com> writes:
>>
>>> From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>
>>> cfg80211 layer on DUT STA is disconnecting ongoing connection 
>>> attempt after
>>> receiving association response, because cfg80211 layer does not have 
>>> valid
>>> AP bss information. On association response event, brcmfmac 
>>> communicates
>>> the AP bss information to cfg80211 layer, but SSID seem to be empty 
>>> in AP
>>> bss information, and cfg80211 layer prints kernel warning and then
>>> disconnects the ongoing connection attempt.
>>>
>>> SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
>>> updating the SSID for hidden AP while informing its bss information
>>> to cfg80211 layer.
>>>
>>> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>>> ---
>>>   .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 8 
>>> ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git 
>>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> index 6c37da42e61b..3560afe0ccfe 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> @@ -3003,6 +3003,7 @@ static s32 brcmf_inform_single_bss(struct 
>>> brcmf_cfg80211_info *cfg,
>>>        u8 *notify_ie;
>>>        size_t notify_ielen;
>>>        struct cfg80211_inform_bss bss_data = {};
>>> +     struct brcmf_tlv *ssid;
>>>
>>>        if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
>>>                bphy_err(drvr, "Bss info is larger than buffer. 
>>> Discarding\n");
>>> @@ -3032,6 +3033,13 @@ static s32 brcmf_inform_single_bss(struct 
>>> brcmf_cfg80211_info *cfg,
>>>        notify_ielen = le32_to_cpu(bi->ie_length);
>>>        bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
>>>
>>> +     ssid = (struct brcmf_tlv *)
>>> +             brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
>> This still casts away the const. For some reason brcmf_parse_tlvs()
>> takes a const buffer:
>>
>> static const struct brcmf_tlv *brcmf_parse_tlvs(const void *buf, int 
>> buflen, uint key)
>>
>> I'm not familiar with brcmfmac internal so I don't know why it does
>> that, but that means the buffer cannot be modified. If you need to
>> modify the ssid should you make a copy of it?
>
> In brcmf_parse_tlvs(const void *buf, int buflen, uint key),
> it will find the key in buf and return the address of this key, as the 
> return pointer.
> This function don't intend caller to modify content of buf in most 
> cases, so it defines a const return pointer.
> But in this case, it just need to do it, so I need the typecast here.
>
Do you accept the typecast here?
Thank you.

>> -- 
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches 
>>
>

