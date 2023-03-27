Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437726CA54A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjC0NMc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC0NMb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 09:12:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D11171D
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:12:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so5272147wms.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679922748;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=478A+bT4URn1+P2mr5nDXfmuV9rKOJHIHLabsxsmktg=;
        b=q5lgr2QCloeG5FgUW54nhvwaLnuSQfZSL+KcS28YAgjMCz0KM046tA5uWXMzVBgqIy
         BY2ys90MT3or8y9FQfUsFqu+6Tb1oBAqB9MTyrWCd/XNf5JAGPVGEWIMj8qJNuaw8OzK
         v0ILU/sB5PWZ0nc0Owogeh/XTt5+RkwuEvPgVx/0gxW2Hmdzp/tuLvPxe3SyBYaPThsH
         DRJYBQGdt/rY8we0pIw5Ok7HxCPdAmPj5piV0S1TtHDLbmH12tMvJETJUgcN9Fqma45b
         kylRnqpjyPUygWqU70EFm+h2zaBsKmzqRH7ZIuazJUvKlL1tl2iExV6OKE5NBdMeqIb5
         KS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922748;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=478A+bT4URn1+P2mr5nDXfmuV9rKOJHIHLabsxsmktg=;
        b=G+Iw/tuA5xbtNBB8BpY1OxeFMsO4BjLUWp2i6ZZWaossGRu1OvjfUZsTNlIxmRBxDn
         7FpC17lXz/SVg3abOfNxRJtALEsuz5GoXTsA5cPuNWglXU4DCFXyZcwkz2icxSdbXlmT
         YZvsG9ju1FRGyb44nxWxcvsbw77yfg96T97zPKnekkpxV6NWcJsX/QCNBjBFiwIP+e2N
         ZyB6TAjW0j8Gjt+oBBsQ9yFNgY29dYlcdZ1waZjtM6kbsFsJxLXhx+vTki4fXDNzdbuw
         mFTibt/GiFwKL/VxVjJLHX1Rp7+XZqaU1xri98997XgDaJef1oqe0MxrX+YivOx5g1Jf
         ryng==
X-Gm-Message-State: AO0yUKV3hJUOr7Nf4+ZhwisWteflOc1l62Qt+OzeoR/Hjfl0vjR7fAxI
        QoH/GUkO281kP2gbBOJrL+8pa+RAPps=
X-Google-Smtp-Source: AK7set+lpVgiaMlC68VAVElhi4SFoWdcuHM63eRA9Be6e+Uu5E2xdcwPsfPlYOLgwhRLXr8h+3qtaw==
X-Received: by 2002:a7b:ca4a:0:b0:3ea:e582:48dd with SMTP id m10-20020a7bca4a000000b003eae58248ddmr9461426wml.34.1679922748286;
        Mon, 27 Mar 2023 06:12:28 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b003eda46d6792sm8780933wms.32.2023.03.27.06.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 06:12:27 -0700 (PDT)
Message-ID: <27e83382-4c84-1841-c428-d1e5143ea20c@gmail.com>
Date:   Mon, 27 Mar 2023 16:12:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to
 update_rate_mask
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230322171905.492855-1-martin.kaistra@linutronix.de>
 <20230322171905.492855-8-martin.kaistra@linutronix.de>
 <b48af4c2e9ef4555997b4a6388fdd270@realtek.com> <87lejitwlf.fsf@kernel.org>
 <b6e5ee31095549268987185d276e3e7c@realtek.com>
Content-Language: en-US
In-Reply-To: <b6e5ee31095549268987185d276e3e7c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 27/03/2023 12:19, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Monday, March 27, 2023 4:42 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: Martin Kaistra <martin.kaistra@linutronix.de>; linux-wireless@vger.kernel.org; Jes Sorensen
>> <Jes.Sorensen@gmail.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: Re: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
>>
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>>
>>>> -----Original Message-----
>>>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>>>> Sent: Thursday, March 23, 2023 1:19 AM
>>>> To: linux-wireless@vger.kernel.org
>>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>>>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>>>> <bigeasy@linutronix.de>
>>>> Subject: [RFC PATCH 07/14] wifi: rtl8xxxu: Add parameter macid to update_rate_mask
>>>>
>>>> The HW maintains a rate_mask for each connection, referenced by the
>>>> macid. Add a parameter to update_rate_mask and add the macid to the
>>>> h2c call in the gen2 implementation.
>>>>
>>>> Also extend refresh_rate_mask to generate the macid in AP mode from
>>>> sta->aid.
>>>
>>> Firmware can support 32 mac_id (station instance) at most, so it will be a
>>> problem if hostapd assigns aid more than 32. Though I'm not clear how
>>> hostpad assigns the aid, it would be always safe that rtl8xxxu maintains
>>> mac_id by a bitmap in driver.
>>
>> Does rtlw8xxxu set struct wiphy::max_ap_assoc_sta? It would be good to
>> advertise the user space the maximum number of stations.
>>
> 
> Thanks for this information, Kalle.
> 
> Martin, please add this. I think we can preserve at least one mac_id for
> broadcast/multicast frames. In fact, I'm not absolutely sure we can
> support up to 32 mac_id, so set wiphy::max_ap_assoc_sta = 16 -1 or -2
> would be safer.
> 
> Ping-Ke
> 
> 
Indeed, the RTL8188FU driver has hal_spec->macid_num = 16. I think that's
the maximum for this chip.

RTL8710BU: 16
RTL8188EU: 64
RTL8192EU: 128
RTL8723BU: 128

