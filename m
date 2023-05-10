Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76BA6FDFDD
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbjEJOTs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbjEJOTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 10:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F90546A9
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683728331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuOUa9KYh5PmE79OUIXU+YKRUs/vGY8xczPXTJ10Qec=;
        b=CZV7mcemfpZ7mqFY+gW/OUMn+gOFgtbf0YFW3oYVhYtpEPyBhnM3TG4Fm8kl7JpXvlvEID
        nsNi6ycW+GBfhXf2ATRjxSytONtCEM1GmKfzimpHlxbHVy7wPLtluzt1xKo+P1BRNsbwa9
        OsZODzZu/Ecj/6oXpRuVmHYQo9uniRw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-6KAN4uZfOR2fM5W5q6Y8ZQ-1; Wed, 10 May 2023 10:18:49 -0400
X-MC-Unique: 6KAN4uZfOR2fM5W5q6Y8ZQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50de84a3861so171499a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728328; x=1686320328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuOUa9KYh5PmE79OUIXU+YKRUs/vGY8xczPXTJ10Qec=;
        b=PC4ivzY6ARcq+e55mvKxSi1xJUdU3IjHzKrh0shs4ncyIGcaN/mmBCCYYigfS14dqX
         lJ+mXRb8UVyLEHNcNDwCx/HMUwAX0Byaz2BRvmPmWGA/+R8N7wB08nSQTGylWB8bFSoR
         U68UXWm9kj58tilZ5IcOfbhxvforpnRxFLMCwlkHeEPLp5MrEDhFfs6BVNP88CBi1vtv
         Wfit7HELo7Yt8gVtZb3nqX3Ni0NtkQQgJxW/s0i5hgClmf/HvFvmroq7kHcsN2U4UOMC
         n/Vk6NPP8FkuF1etWIJxeUwnj7EMxk0uRk2B5/Fa0DpXGLjyp+Yzv99SbR4HUc+OL/+Z
         IUYw==
X-Gm-Message-State: AC+VfDwpyQM/OWl31+ST6J9Hia+LDthC0TUCj6n7LrEHD6QvLKD8ZDI3
        /05XoictO/kwvq7qt5j2eCKZ8ymUcIf0LGPuOZHHg2nk3ZYicuG15ZEiMSshrviJkbPLiokeHKR
        pl7goKcmt6iXuVAYkWQwvvuiVIPY=
X-Received: by 2002:a17:906:7304:b0:921:da99:f39c with SMTP id di4-20020a170906730400b00921da99f39cmr19213520ejc.12.1683728328730;
        Wed, 10 May 2023 07:18:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vHpbiTR7GNjFCfIEAqh1zlSEJZmji3BktutSVamw7Oiyr+82YNobx9E3OjNmbuwL6OHbHVQ==
X-Received: by 2002:a17:906:7304:b0:921:da99:f39c with SMTP id di4-20020a170906730400b00921da99f39cmr19213485ejc.12.1683728328430;
        Wed, 10 May 2023 07:18:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t27-20020a170906269b00b0096616aef7e5sm2804404ejc.149.2023.05.10.07.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:18:47 -0700 (PDT)
Message-ID: <ed5b02e3-ded8-1edd-c903-d7a439065c3a@redhat.com>
Date:   Wed, 10 May 2023 16:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: brcmfmac: Check for probe() id argument being NULL
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, regressions@lists.linux.dev,
        Felix <nimrod4garoa@gmail.com>, stable@vger.kernel.org
References: <20230510100050.27099-1-hdegoede@redhat.com>
 <7f563b21-4c06-134e-f30d-02ed61521c1f@broadcom.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7f563b21-4c06-134e-f30d-02ed61521c1f@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

On 5/10/23 14:12, Arend van Spriel wrote:
> On 5/10/2023 12:00 PM, Hans de Goede wrote:
>> The probe() id argument may be NULL in 2 scenarios:
>>
>> 1. brcmf_pcie_pm_leave_D3() calling brcmf_pcie_probe() to reprobe
>>     the device.
>>
>> 2. If a user tries to manually bind the driver from sysfs then the sdio /
>>     pcie / usb probe() function gets called with NULL as id argument.
>>
>> 1. Is being hit by users causing the following oops on resume and causing
>> wifi to stop working:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000018
>> <snip>
>> Hardware name: Dell Inc. XPS 13 9350/0PWNCR, BIDS 1.13.0 02/10/2020
>> Workgueue: events_unbound async_run_entry_fn
>> RIP: 0010:brcmf_pcie_probe+Ox16b/0x7a0 [brcmfmac]
>> <snip>
>> Call Trace:
>>   <TASK>
>>   brcmf_pcie_pm_leave_D3+0xc5/8x1a0 [brcmfmac be3b4cefca451e190fa35be8f00db1bbec293887]
>>   ? pci_pm_resume+0x5b/0xf0
>>   ? pci_legacy_resume+0x80/0x80
>>   dpm_run_callback+0x47/0x150
>>   device_resume+0xa2/0x1f0
>>   async_resume+0x1d/0x30
>> <snip>
>>
>> Fix this by checking for id being NULL.
>>
>> In the case of brcmf_pcie_probe() also add a manual lookup of the id
>> when it is NULL so that fwvid will still get set correctly on reprobe
>> on resume.
> 
> Hi Hans,
> 
> Thanks for looking into this and coming up with a fix. Does it make sense to proceed with 
> BRCMF_FWVENDOR_INVALID though. I think it will end up in probe failure in brcmf_fwvid_attach() 
> because of it so why not bail out right away.

You are right since the vendor stuff is in separate modules I thought
the driver would just continue without, but that indeed does not work.

I have just prepared a version 2 which immediately bails from probe()
if id is still null after doing a pci_match_id() / usb_match_id()
to try and lookup the id. Note for the SDIO case v2 will immediately
bail on a NULL id since there is no sdio_match_id() helper.

I'll send out v2 right away.

Regards,

Hans



>> Fixes: da6d9c8ecd00 ("wifi: brcmfmac: add firmware vendor info in driver info")
>> Reported-by: Felix <nimrod4garoa@gmail.com>
>> Link: https://lore.kernel.org/regressions/4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com/
>> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 2 +-
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c   | 8 +++++++-
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c    | 2 +-
>>   3 files changed, 9 insertions(+), 3 deletions(-)

