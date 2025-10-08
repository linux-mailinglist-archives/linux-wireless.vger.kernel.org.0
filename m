Return-Path: <linux-wireless+bounces-27891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FD8BC6519
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 20:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D183189BC5C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961979CD;
	Wed,  8 Oct 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CfB8qRf6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435FD1F7569
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949128; cv=none; b=sVvSgxq4Qy2CIklcnKxwCiHsEhbVL+jnV2+IlfRUxowGjF4S9UpMaMppzIReq01MH9iARC8jGKTQYLa6caV7XQzpdStlVR2IyryWQ+HdejmGrU/cyrxGzj8/kPrW1kcBut14E7ta2KAfU2IpiyxjVRFw1VW9M+AaIcIVHr10jL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949128; c=relaxed/simple;
	bh=sjp4NQ2YaggeLhcvMjpJuJyEa6wtqhmG0fD8dNxBRV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Un5o5sW+3AvYifmKHf6/NonzVXHuFdPbUthSibRy1Pj2Oj0FHZjn5ZNVBGzDCGgefuREN/UNyNmcjGmf6oJWnDpZw19xvJJeWWdtnWdevASM16Z7Vz+YX68kTA017EYhhr1Gi1vjzyl5mzIo84YeSKIvtKzetYOmKeuVh/ekasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CfB8qRf6; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-33292adb180so183282a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 11:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949124; x=1760553924;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PheSITAQRMbmKrfKUKoxcHaIEoBCjP18QV0SbZPeZW8=;
        b=GXei1LaYmzEIUDoORqy0bcCOpbYxnXI74aS0EC7Z6Lae7xxf4fjd6msR/3a9Tz/ePx
         uj2Qj07eauFzpQ0n1ezhYnWPvV+ZwOe6vwhPeVLwz1CNF6/vamr1L2m3yWu6obk6x0Q7
         A/h5z3AFFZje68D417jI+T1wBlwzdhSwKuUqcxgvCwpfOczwVirKl7bAw8aGb81f6ySb
         1Tk6Mrzj7C52azWiG488cnvBVLoZX4GMrmR7Or2HPRVvkMSeyQJhoH/qk3rQX5X7rMCd
         qylUyJ+IuUE0oRpHpDUCE49BT2k2UsIDD2+guh3jINI/ylQ1oILRLmYnrSq1LdPXJakv
         z73w==
X-Gm-Message-State: AOJu0YyAXkDK7orIex0V++TsEcAc/6dx/7TXLExIPL4u88/EJDZJ2Qtd
	+sKBEaqTWdVjjrlE3syoc8FbbspCAvU0HDdesNlYy0IFjtxFGV/Ys54m7fKd+KGJuDhKg7HIXiO
	TyZC5tS/dZESY6QpFDmSpctJf2SJu+GQ6Yece45IN7YIj+iX8KvbqCVFbuHXwqRqcxL/bMG53FT
	EokU5n8DZyQT3kB07xbe5VJSoXI9j/mdEPG+9NAsGJEetpQ02VwJke5i2q1OB0T41+Ye1312Rmw
	h2YPEfXPREE8URFACLKOktuaQtL
X-Gm-Gg: ASbGncs/fDLU+VgSDAkrRf+FHNZhddNmqBCuDopn1fRnEch1i1xd7/ppFfXJTC2G4kJ
	Utp7rDnGKroHOD9cRq4jvWY8Z5OggwHhmUUuV2GbglOODznqBGXmskbgDMOKkUM2nS4FtVRhEfs
	7D+PWn1KvkgVWOBCmRy4MO74fFctJnzh4gaabkNCJiqifBwSaX9umE0tOwRnZMgkqIpRgZKDcw0
	4Vf1uHSprOMMz9+5SrZL6xDH9hpumziDsuvARqw1zHXjtkNN9Dke0YxdwpV8fEvOvk+H1dMEy/b
	in79taDUsl3hiR4Pj9d5MlPQKZxbGI+7QESWm4HUhenYKHlJwmvvO/gPZnf9Ec7WjqK09HhFrAL
	dR32UgRarfWgtvb+zHr3yfsTOBJIB5A42jf8cVWK+LZiCjS5qWlI07ErQC2U2CP7cySbDECIe/S
	8lCF3G1sSD9oE=
X-Google-Smtp-Source: AGHT+IFIraFJKMwha3HH1FIqfJlTYOTCqFAKD+WIJJyzr+dy3J/DshNXDrXdkSjB8nkbCeyumDh3WRvcXjHK
X-Received: by 2002:a17:90b:4ac7:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-33b513a1e32mr5536287a91.34.1759949124293;
        Wed, 08 Oct 2025 11:45:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-33b51381dfbsm314709a91.8.2025.10.08.11.45.23
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2025 11:45:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-818c83e607bso5096266d6.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Oct 2025 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759949122; x=1760553922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PheSITAQRMbmKrfKUKoxcHaIEoBCjP18QV0SbZPeZW8=;
        b=CfB8qRf6s0kP3Sjjo0CMusSxUW/1gIdcaQSBY0EHt09OhEG4Xti9LvaABy/UhBfmOL
         cM22ZKJWx7C9a9Qs7vyyj5SPOcL2yVOYou96y6misr/TErP5auC2jO3RswM1eWF0eJ6A
         TJIAWlm27Ftv3sDEateTJzq2zdFjPyzlBkoXU=
X-Received: by 2002:a05:6214:f2b:b0:79b:d17b:b693 with SMTP id 6a1803df08f44-87b2ef7a9c0mr65800566d6.60.1759949121951;
        Wed, 08 Oct 2025 11:45:21 -0700 (PDT)
X-Received: by 2002:a05:6214:f2b:b0:79b:d17b:b693 with SMTP id 6a1803df08f44-87b2ef7a9c0mr65799786d6.60.1759949121267;
        Wed, 08 Oct 2025 11:45:21 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60dfbsm168646806d6.14.2025.10.08.11.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 11:45:20 -0700 (PDT)
Message-ID: <9a0849d8-befd-4fca-9d5d-a24520ccfa26@broadcom.com>
Date: Wed, 8 Oct 2025 20:45:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] brcmfmac: Fix NULL pointer dereference in P2P action
 frame handling
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Richard Reigh <richard@govivid.ai>
Cc: linux-wireless@vger.kernel.org, wahrenst@gmx.net,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 chris@streetlogic.pro, s311332@gmail.com, wlan-kernel-dev-list@infineon.com
References: <9811a46c-70ab-4bf6-9e20-7882fe1d0c55@gmx.net>
 <20251006231306.131967-1-richard@govivid.ai>
 <aOUyLfSuIkby_8TZ@ISCN5CG14747PP.infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <aOUyLfSuIkby_8TZ@ISCN5CG14747PP.infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/7/2025 5:30 PM, Gokul Sivakumar wrote:
> On 10/06, Richard Reigh wrote:
>> When iPhones query network information via the WiFi settings "i" button,
>> the brcmfmac driver crashes with a NULL pointer dereference. This occurs
>> because the P2P device vif is not initialized when handling certain action
>> frames.
>>
>> Added an early check in brcmf_cfg80211_mgmt_tx() to verify P2P device vif
>> availability before attepting to send action frames. Also added a defensive
>> check in brcmf_p2p_tx_action_frame() as a safety net.
>>
>> Tested on Raspberry Pi Zero 2 W with kernel 6.1.21-v8+
>>
>> Fixes: 18e2f61db3b7 ("brcmfmac: P2P action frame tx")
>> Signed-off-by: Richard Reigh <richard@govivid.ai>
>>
>> ---
>> Changes in v2:
>> - Added early check in cfg80211.c before calling P2P functions (suggested by
>>    Stefan Wahren)
>> - Changed error message to debug level in p2p.c (suggested by Stefan Wahren)
>> - Added fixes tag
>> ---
>>   .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 13 +++++++++++++
>>   .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c  |  6 ++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index ea8409e0e..9983136a7 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -5137,6 +5137,19 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>>
>>          vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
>>
>> +       /* check if P2P device vif is available before attempting */
>> +       /* action frames */
>> +       if (ieee80211_is_action(mgmt->frame_control)) {
> 
> The action frame type specific operations are done already below in the
> else if (ieee80211_is_action()) block. So ideally, it is better to do
> all action frame type specific operations in the existing else if{} block,
> instead of introducing a new if{} block, until unless it is really needed.
> 
>> +               struct brcmf_p2p_info *p2p = &cfg->p2p;
>> +
>> +               if (!p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif) {
>> +                       brcmf_dbg(TRACE, "P2P device vif not available\n");
>> +                       cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, false,
>> +                                               GFP_KERNEL);
>> +                       return 0;
>> +               }
>> +       }
>> +
> 
> IMHO, bailing out here without responding to the ANQP Request, may not be
> a viable solution for the crash. Need to have a way for the AP to respond
> with the ANQP Response Public Action frame without crashing the driver.

Carying the historical burden. The action frame transmission support in 
brcmfmac was originally introduced with only P2P in mind. So it ended up 
very entwined with the P2P code. In my opinion the action frame handling 
should be implemented in a separate source file in the driver.

> Have a solution in mind, will send the patch for review after testing it.

Okay. Go ahead.

Gr. AvS

>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> index 10d9d9c63..e62135cd4 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> @@ -1559,6 +1559,12 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
>>          else
>>                  vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>>
>> +       /* add NULL check */
>> +       if (!vif) {
>> +               brcmf_dbg(TRACE, "vif is NULL, cannot send action frame\n");
>> +               return -ENODEV;
>> +       }
>> +
>>          err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
>>                                          sizeof(*af_params));
>>          if (err) {
>> --
>> 2.34.1
>>
>>

