Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8345D2BAF30
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgKTPnt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 10:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728623AbgKTPns (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 10:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605887026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBateyvwObqLkmQosYkCqxAkxmRC8MiV0YwwaE2Y+0c=;
        b=D5IbxQxvShO6Ljas5ySLppuWx63cSja/4bN1aXDVwgBaEn5IojKg+UFNfdBus3VrolZPhx
        hoFWvqfFgkjDHwyc/2eIHTV7mWz1GIXcFtr+UhZJYuTIQ77nUMVAskSlaph1cdKbQGBDkO
        7Ir/0j/xPlKCuqv2LiDTTvZtUzT3gEk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-CZ4rPUOfM7C0HvNtqLV7ZQ-1; Fri, 20 Nov 2020 10:43:42 -0500
X-MC-Unique: CZ4rPUOfM7C0HvNtqLV7ZQ-1
Received: by mail-ed1-f70.google.com with SMTP id d3so3909845eds.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 07:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBateyvwObqLkmQosYkCqxAkxmRC8MiV0YwwaE2Y+0c=;
        b=KleKvMLWozOQlImE4SOSTgLSBHwiQZUyjXrmAnGm2pJsZnv/o6E7x/AVs/f4khS4Y8
         9eZXQlyuINBsVcIKpsWOBHo1eqYmCti77IAQ9BbtOzKJ662WShcykS6Ca4KFDuUumVLp
         4ecrymvyOSJifZbzNIq4O0P9VX80hFTp0g9N+RCShRZRcas3muH4yTkHXeqnRnNq8+Zu
         49QEBxsmt7KkxiadoYopqcTbv2cltqvNf1KAvnXzG4juAD9CLvocqBq+WTPAwsbLfmrt
         85u6yT4u8jIC6qnJIY6PAYOV7slM5c5TMRMmbBdOBc2n21xGOvddlIxwgTKonl6fm5f1
         2I4Q==
X-Gm-Message-State: AOAM532FAw5uNEtwSxUFpCol1EGI5gZkgDkXxH+MIn+oTBqF97428SAr
        ZbFS1xPp85Ha/docH2o+3TX9KFtdBjvYT5N4NMALay/7dnLOEV5wTXpXYp+Y5TbzsvbqAXlufe8
        PqDfo0lTNOOGNPp+asAVwuRLVkDI=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr5689109edm.66.1605887021681;
        Fri, 20 Nov 2020 07:43:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOyZDUWxcXdDON+pnk/DNSHvuOI/cWE01yiWF6mFLkuzrxdnx4N7O+NduZHwIqegjSs2yBNQ==
X-Received: by 2002:a50:e68a:: with SMTP id z10mr5689084edm.66.1605887021491;
        Fri, 20 Nov 2020 07:43:41 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id n11sm1260584eds.3.2020.11.20.07.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 07:43:40 -0800 (PST)
Subject: Re: [PATCH v2] brcmfmac: expose firmware config files through modinfo
To:     Matthias Brugger <mbrugger@suse.com>,
        Dmitry Osipenko <digetx@gmail.com>, matthias.bgg@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Double Lo <double.lo@cypress.com>,
        Frank Kao <frank.kao@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Saravanan Shanmugham <saravanan.shanmugham@cypress.com>,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Amar Shankar <amsr@cypress.com>
References: <20201120095233.19953-1-matthias.bgg@kernel.org>
 <2ff4dcc3-6f99-a068-8989-4293d2013627@gmail.com>
 <7e8e689a-9804-86fc-dd2c-f1622dd40476@suse.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <74370289-ae29-53ca-e8b6-107998a4a23f@redhat.com>
Date:   Fri, 20 Nov 2020 16:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <7e8e689a-9804-86fc-dd2c-f1622dd40476@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 11/20/20 12:11 PM, Matthias Brugger wrote:
> 
> 
> On 20/11/2020 11:05, Dmitry Osipenko wrote:
>> 20.11.2020 12:52, matthias.bgg@kernel.org пишет:
>>> From: Matthias Brugger <mbrugger@suse.com>
>>>
>>> Apart from a firmware binary the chip needs a config file used by the
>>> FW. Add the config files to modinfo so that they can be read by
>>> userspace.
>>>
>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> In comparison to first version [0] we use wildcards to enumerate the
>>> firmware configuration files. Wildcard support was added to dracut
>>> recently [1].
>>> [0] https://lore.kernel.org/linux-wireless/20200701153123.25602-1-matthias.bgg@kernel.org/
>>> [1] https://github.com/dracutdevs/dracut/pull/860
>>>
>>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> index 99987a789e7e..dd6d287b1b00 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> @@ -625,6 +625,15 @@ BRCMF_FW_DEF(4359, "brcmfmac4359-sdio");
>>>   BRCMF_FW_DEF(4373, "brcmfmac4373-sdio");
>>>   BRCMF_FW_DEF(43012, "brcmfmac43012-sdio");
>>>   +/* firmware config files */
>>> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac4330-sdio.*.txt");
>>> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43340-sdio.*.txt");
>>> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43362-sdio.*.txt");
>>> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430a0-sdio.*.txt");
>>> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43430-sdio.*.txt");
>>> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac43455-sdio.*.txt");
>>> +MODULE_FIRMWARE(BRCMF_FW_DEFAULT_PATH "brcm/brcmfmac4356-pcie.*.txt");
>>
>> This doesn't cover all hardware models. Note that the upstream
>> linux-firmware has files only for a few hardware models.
>>
>> I suppose that the correct mask should be "brcm/brcmfmac*-sdio.*.txt".
>>
> 
> We can use the two "brcm/brcmfmac*-sdio.*.txt" and "brcm/brcmfmac*-pcie.*.txt" to also include firmware files for chips that don't have any config file in linux-firmware.

Yes, lets just go with those 2 wildcard matches, that should catch all the files the driver needs without needing to add a lot of extra MODULE_FIRMWARE() entries to the module's firmware.

> I'm indifferent to that, although I think we should make incentivize to upstream firmware config files to linux-firmware.

I completely agree with you. Actually, if you take a look you will see that most of these were submitted to linux-firmware by me :)

But this is really orthogonal to which MODULE_FIRMWARE() entries we should add.

Regards,

Hans

