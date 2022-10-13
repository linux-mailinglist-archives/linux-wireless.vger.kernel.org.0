Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97365FD48D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 08:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJMGNq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 02:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJMGNj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 02:13:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E057712EA43
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 23:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE1361700
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 06:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9147AC433C1;
        Thu, 13 Oct 2022 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665641610;
        bh=AsTcyRovHdmI1JSKaLmC6uMFqN5sylDL/MF8j3m34aY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DP9MgE/qOOt6N/YRtwlGE1BLBwHDzdhRmhZBPabss/kAFWr/1I4bKdiatWDTtjR4H
         o1Fm7IbbicrGr9a5bo6f18xqjjLylDbzHJS3+C0+k2Fnj8sytpHbs7bdxmBv1MGzwL
         sEDHDbrfro3eZTOaeEkbNEtTKzvuxUj0oIxxrQVRmy+tMjQ2UE3xOi7OqzS3n5/yIt
         nUlBlivreYbvzoaLBFTYdAtQSy/D8dNIcGjzx+V8XV46V1cizO76UI2gt7zs1/Bz9H
         /QPzw7ieeAt7jx5b6DN8PTBdYU9QpeYZs9awLbP/By0i9W6LJ5BY/DOWYoPXzYbtQd
         zVRQ9YGgfLXYg==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <lkp@intel.com>
Subject: Re: [PATCH 1/8] wifi: wilc1000: fix incorrect type assignment sparse warning
In-Reply-To: <2b432ae1-48fc-5a70-0afe-2b9f788f14e4@microchip.com> (Ajay
        Kathat's message of "Wed, 27 Jul 2022 17:32:03 +0000")
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
        <87v8rik8vp.fsf@kernel.org>
        <2b432ae1-48fc-5a70-0afe-2b9f788f14e4@microchip.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 13 Oct 2022 09:13:22 +0300
Message-ID: <874jw8ntdp.fsf@kernel.org>
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

<Ajay.Kathat@microchip.com> writes:

> Hi Kalle,
>
> On 27/07/22 18:30, Kalle Valo wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> <Ajay.Kathat@microchip.com> writes:
>>
>>> From: Ajay Singh <ajay.kathat@microchip.com>
>>>
>>> Sparse reported below warning
>>>>> drivers/net/wireless/microchip/wilc1000/cfg80211.c:361:42: sparse: sp=
arse: incorrect type in assignment (different base types) @@     expected u=
nsigned int key_mgmt_suite @@     got restricted __be32 [usertype] @@
>>> 'key_mgmt_suite' value is expected in big-endian format. After receiving
>>> mgmt_suite value from wpa_s convert to cpu endianness because the same
>>> value is return back using cfg80211_external_auth_request(). Use
>>> be32_to_cpu() conversion API to avoid the sparse warning.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Fixes: c5b331d4f550fb78 ("wifi: wilc1000: add WPA3 SAE support")
>>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>>> ---
>>>   drivers/net/wireless/microchip/wilc1000/cfg80211.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drive=
rs/net/wireless/microchip/wilc1000/cfg80211.c
>>> index 5c2c7f1dbffd..19862d932f1f 100644
>>> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>>> @@ -359,7 +359,7 @@ static int connect(struct wiphy *wiphy, struct net_=
device *dev,
>>>                        memcpy(vif->auth.ssid.ssid, sme->ssid, sme->ssid=
_len);
>>>                        vif->auth.ssid.ssid_len =3D sme->ssid_len;
>>>                }
>>> -             vif->auth.key_mgmt_suite =3D cpu_to_be32(sme->crypto.akm_=
suites[0]);
>>> +             vif->auth.key_mgmt_suite =3D be32_to_cpu((__force __be32)=
sme->crypto.akm_suites[0]);
>> No time to investigate in detail but the cast is just ugly. Isn't there
>> a better way to fix this?
>
>
> I think, there is an another way to handle this issue. 'key_mgmt_suite'=20
> element in 'cfg80211_external_auth_params' struct should be converted to=
=20
> '__be32' type(like below code snippet) because wpa_s expects the value=20
> in big-endian format . After this change, the type case can be avoided.=20
> Though I am not sure if these changes can have impact on other driver.
>
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index cc8a9880b9d6..92df70afe445 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -3509,7 +3509,7 @@ struct cfg80211_external_auth_params {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum nl80211_external_auth_ac=
tion action;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 bssid[ETH_ALEN] __aligned(=
2);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cfg80211_ssid ssid;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int key_mgmt_suite;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 key_mgmt_suite;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 status;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u8 *pmkid;
>  =C2=A0};

So just that I understand correctly: struct
cfg80211_crypto_settings::akm_suites is in cpu endian but struct struct
cfg80211_external_auth_params::key_mgmt_suite is in big endian? But your
original patch uses be32_to_cpu() so I must be confused.

It would be good to document this in cfg80211.h, the documentation there
doesn't mention anything about endian.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
