Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2560A5F5084
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJEH6x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJEH6b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 03:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D64754A2
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 00:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5686861563
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 07:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428F9C433C1;
        Wed,  5 Oct 2022 07:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664956699;
        bh=rOpejgsa0FwzvRufmwjvxmg54CoiLVFCgbbeAfNm1qE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NOzSVeVRcmPI63U6Ju2omZcdGpsAIlDfOJNouSz40NGUxzgDhSEOs2xNa75QHjWRE
         TG9JtASsMC1db1KMK/28dV3I9Q95cwQdYRiq8Gbz9YsSmLhYHjEo3NmncXP0PhEFW8
         4OQc34hkCLhfdBkj0AmOdHoSAgizSJJuIAaYlkyKEF4a8EaFnS7Wa7XBTRlLTD3HEC
         YVjAUF1eXc/rfKhhHkBoELWWDM0FXwssfiCHwcwOMjKDcDJG6mMZAACXLxaILVwDBn
         vgAcNWpXGS0BU12IkURCYsTuQSg9F4/CtKv6c6gmEChJuueZegCp7hdV6GsdaiSJZ1
         ZfsD6Nwm4vJHQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Lin Ian \(CSSITB CSS ICW SW WFS \/ EE\)" <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH v3 4/5] brcmfmac: Update SSID of hidden AP while informing its bss to cfg80211 layer
References: <20220927034138.20463-1-ian.lin@infineon.com>
        <20220927034138.20463-5-ian.lin@infineon.com>
        <874jwsrojr.fsf@kernel.org>
        <4e602611-aed5-dfe7-6ce7-42d1fc7ca53e@infineon.com>
        <b43d934d-f3e8-9459-0096-11908df27c15@infineon.com>
Date:   Wed, 05 Oct 2022 10:58:13 +0300
In-Reply-To: <b43d934d-f3e8-9459-0096-11908df27c15@infineon.com> (Lin Ian's
        message of "Tue, 4 Oct 2022 19:01:42 +0800")
Message-ID: <87y1tupuqy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com> writes:

> On 9/28/2022 6:07 PM, Lin Ian (CSSITB CSS ICW SW WFS / EE) wrote:
>>
>>
>> On 9/28/2022 2:38 PM, Kalle Valo wrote:
>>> Caution: This e-mail originated outside Infineon Technologies. Do
>>> not click on links or open attachments unless you validate it is
>>> safe<https://intranet-content.infineon.com/explore/aboutinfineon/rules/=
informationsecurity/ug/SocialEngineering/Pages/SocialEngineeringElements_en=
.aspx>.
>>>
>>>
>>>
>>> Ian Lin <ian.lin@infineon.com> writes:
>>>
>>>> From: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>>
>>>> cfg80211 layer on DUT STA is disconnecting ongoing connection
>>>> attempt after
>>>> receiving association response, because cfg80211 layer does not
>>>> have valid
>>>> AP bss information. On association response event, brcmfmac
>>>> communicates
>>>> the AP bss information to cfg80211 layer, but SSID seem to be
>>>> empty in AP
>>>> bss information, and cfg80211 layer prints kernel warning and then
>>>> disconnects the ongoing connection attempt.
>>>>
>>>> SSID is empty in SSID IE, but 'bi->SSID' contains a valid SSID, so
>>>> updating the SSID for hidden AP while informing its bss information
>>>> to cfg80211 layer.
>>>>
>>>> Signed-off-by: Syed Rafiuddeen <syed.rafiuddeen@cypress.com>
>>>> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
>>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@infineon.com>
>>>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>>>> ---
>>>> =C2=A0 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c=C2=A0=
=C2=A0 | 8
>>>> ++++++++
>>>> =C2=A0 1 file changed, 8 insertions(+)
>>>>
>>>> diff --git
>>>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> index 6c37da42e61b..3560afe0ccfe 100644
>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>>> @@ -3003,6 +3003,7 @@ static s32 brcmf_inform_single_bss(struct
>>>> brcmf_cfg80211_info *cfg,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *notify_ie;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t notify_ielen;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cfg80211_inform_bss bss_da=
ta =3D {};
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct brcmf_tlv *ssid;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (le32_to_cpu(bi->length) > WL_=
BSS_INFO_MAX) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bphy_err(drvr, "Bss info is larger than buffer.
>>>> Discarding\n");
>>>> @@ -3032,6 +3033,13 @@ static s32 brcmf_inform_single_bss(struct
>>>> brcmf_cfg80211_info *cfg,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 notify_ielen =3D le32_to_cpu(bi->=
ie_length);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss_data.signal =3D (s16)le16_to_=
cpu(bi->RSSI) * 100;
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ssid =3D (struct brcmf_tlv *)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 brcmf_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
>>> This still casts away the const. For some reason brcmf_parse_tlvs()
>>> takes a const buffer:
>>>
>>> static const struct brcmf_tlv *brcmf_parse_tlvs(const void *buf,
>>> int buflen, uint key)
>>>
>>> I'm not familiar with brcmfmac internal so I don't know why it does
>>> that, but that means the buffer cannot be modified. If you need to
>>> modify the ssid should you make a copy of it?
>>
>> In brcmf_parse_tlvs(const void *buf, int buflen, uint key),
>> it will find the key in buf and return the address of this key, as
>> the return pointer.
>> This function don't intend caller to modify content of buf in most
>> cases, so it defines a const return pointer.
>> But in this case, it just need to do it, so I need the typecast here.
>
> Do you accept the typecast here?

To me writing a const data is wrong. IIRC it was something like six
months ago that rtw89 was also writing a const variable and it caused a
crash because the memory was in a read-only area (or something like
that).

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
