Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7779E56C31B
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Jul 2022 01:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiGHS4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbiGHS4k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 14:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D0F18376
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657306598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ig4258kYojz8CKiZ03ArVSByEBCP6CGZ1eK07rwaNrA=;
        b=Aydg/ahuyHmT5ox+gA3kUCtlabHJNGZPVTvuip7tmfzcAzA6GGxNehcg+aTJ0zK2+KJ342
        ApVALTI3S8a4VMkghNNhB+/21Q/ZwGHEilMurIWvEr5wQNyD8AZhpgNkOspMSRBYXDante
        aAE0+DrXT9OIOOgImdOW+e6nRVAkfgs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-23ip_fl7PC-pu9wgwcb0Mg-1; Fri, 08 Jul 2022 14:56:37 -0400
X-MC-Unique: 23ip_fl7PC-pu9wgwcb0Mg-1
Received: by mail-ed1-f72.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so16799153edc.15
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jul 2022 11:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ig4258kYojz8CKiZ03ArVSByEBCP6CGZ1eK07rwaNrA=;
        b=aUyqhbBnd+8/VtwfTTb/Z9g7IwSXMlWWsxYCQtgSLRjHtxjfN5Fm48SbdA2LSbk1tB
         0LIbTSK+UiZczPCvB1nUxBZmEEsDOUk1dUrIoRVgsfgUz3anIuv9Ogrh1fEhejO7m824
         PaD+sjVl/HMsJBj77lBQdtbAkZM3uBcukwSe4KG1+ZyGnvLv7jgTSjtmRnKIXtj2Lq+F
         I03OjCX6xWM6YYs76lraWefZoJrLFjN87jyV8lGanJpeyTN/FFqx54IgVTiziqV1KUpN
         9pG6pjYqkIBOP1KgFcGZw6bLzfsFzZZGb9zupwsJSNktZ1cZ4hZFvq6VbghR+H2HcU2j
         Xyzg==
X-Gm-Message-State: AJIora9LBXNtb699EAIsimPGiWQpgt+pwL3VPc22rrZJ7JNlICg2CSx4
        UPwFRgygZw4TrBBTwxDDYPbtsen3OoeJctMN/fN6z53dycfsBa48rZOIWJyBMdXE+kUBcip/Oke
        WdNwMdGau+P7O28oRiSvjH/iEHbs=
X-Received: by 2002:a17:907:6e11:b0:722:e5e7:e6d with SMTP id sd17-20020a1709076e1100b00722e5e70e6dmr5180724ejc.222.1657306595881;
        Fri, 08 Jul 2022 11:56:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vJwu7R+CZdkJ3zLDsaXkLmWEEIueEM+V1wJ0DxVBwSvnIYUV1S4iUDOUwdtuA+51enaLrurw==
X-Received: by 2002:a17:907:6e11:b0:722:e5e7:e6d with SMTP id sd17-20020a1709076e1100b00722e5e70e6dmr5180705ejc.222.1657306595656;
        Fri, 08 Jul 2022 11:56:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709063c0100b006feec47dae9sm20602926ejg.157.2022.07.08.11.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 11:56:35 -0700 (PDT)
Message-ID: <b02c8912-216a-cef1-e87c-1eb8ac14dc64@redhat.com>
Date:   Fri, 8 Jul 2022 20:56:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] brcmfmac: Replace default (not configured) MAC with a
 random MAC
Content-Language: en-US
To:     Arend Van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220708133712.102179-1-hdegoede@redhat.com>
 <20220708133712.102179-2-hdegoede@redhat.com>
 <9bf3dc09-73df-8914-aa13-68ed9d48f350@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9bf3dc09-73df-8914-aa13-68ed9d48f350@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 7/8/22 20:27, Arend Van Spriel wrote:
> On 7/8/2022 3:37 PM, Hans de Goede wrote:
>> On some boards there is no eeprom to hold the nvram, in this case instead
>> a board specific nvram is loaded from /lib/firmware. On most boards the
>> macaddr=... setting in the /lib/firmware nvram file is ignored because
>> the wifi/bt chip has a unique MAC programmed into the chip itself.
>>
>> But in some cases the actual MAC from the /lib/firmware nvram file gets
>> used, leading to MAC conflicts.
>>
>> The MAC addresses in the troublesome nvram files seem to all come from
>> the same nvram file template, so we can detect this by checking for
>> the template nvram file MAC.
>>
>> Detect that the default MAC address is being used and replace it
>> with a random MAC address to avoid MAC address conflicts.
>>
>> Note that udev will detect this is a random MAC based on
>> /sys/class/net/wlan0/addr_assign_type and then replace this with
>> a MAC based on hashing the netdev-name + the machine-id. So that
>> the MAC address is both guaranteed to be unique per machine while
>> it is still the same/persistent at each boot (assuming the
>> default Link.MACAddressPolicy=persistent udev setting).
> 
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/common.c      | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> index dccd8f4ca1d0..7485e784be2a 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> 
> [...]
> 
>> @@ -226,6 +240,15 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
>>               bphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
>>               goto done;
>>           }
>> +
>> +        if (ether_addr_equal_unaligned(ifp->mac_addr, brcmf_default_mac_address)) {
> 
> Is it necessary to use the unaligned variant?

The type is: u8 mac_addr[ETH_ALEN] so there is no guarantee it will
be aligned. Even if it is aligned today, if someone inserts
a struct member in front of it it will end up unaligned.

Regards,

Hans

