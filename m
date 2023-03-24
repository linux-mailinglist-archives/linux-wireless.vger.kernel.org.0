Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC96C7928
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 08:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCXHof (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 03:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCXHoe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 03:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67919F39
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679643827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=he8CzGLGInobHhz2XNWCI9/YC4YJbzsRIu07lTrdXgI=;
        b=Yfc9K7mL1QHSNt4TIcRu2Wcd6YkzSjjWuRl3HcucHYsIv1GI7O6PuXgFezWaTmGcGskyWe
        wjom5j9jPnlYjeCl5ksDXBZEld3oR7CXkvtEGHFWlJwjEeZB2LVy4V/aufhoyeRJbOW1it
        F1oYQust+zIwiVN1sjrH3EcA07pdUbY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-NoX5zQeEOQC0MtFmwiXIDQ-1; Fri, 24 Mar 2023 03:43:46 -0400
X-MC-Unique: NoX5zQeEOQC0MtFmwiXIDQ-1
Received: by mail-ed1-f72.google.com with SMTP id a27-20020a50c31b000000b0050047ecf4bfso1915506edb.19
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 00:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=he8CzGLGInobHhz2XNWCI9/YC4YJbzsRIu07lTrdXgI=;
        b=B5MmNX8XG8rN8Uxx/ODqPGhDh5xukIiDHQl0t6FHGYDeViARIBxlsUJcAtDgXEyhOp
         GlzsqXu9spNq1DQcj2KpJSC+lio3YyHlP6d/kL/SHQklPs6CqgoNKXA+CyN3walq7Qwn
         WfZMqVVb2EdeTOroyDiHU1jVMH+tWyRzof5FdixdvQ3Av5AWPQoJ85yOs1jjaxa/hzwp
         UNRTU+XF0kZf+u30lJp2exVvZ9KrK6HF2Eoz7dG8NUAMB/xehORqNnfB6zBc5nzex/Zs
         K4f4fDstbfxKLdoQg4q7dCnCmrQJMtH/M6qLH2xEep9vDgNKna5L0vqfNxmQUPmSiJrb
         icSA==
X-Gm-Message-State: AAQBX9eY9WYxAbdz//XspR6EPqBtnhPcvvfI72uyqvZdaV6w3wNNDdr4
        miAuuedUPNcswzZ9heBmiwhivd5i2my1NIh00ikQAXi+/wcj1I9Iw5r/0BviHrSUzHqKRmw54sS
        x/dmINy+9GpB8HOfrzHMOWSWvKm4=
X-Received: by 2002:a17:907:3f88:b0:909:4a93:d9d2 with SMTP id hr8-20020a1709073f8800b009094a93d9d2mr3017541ejc.2.1679643824894;
        Fri, 24 Mar 2023 00:43:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350amrII5poDBZsChALA+huMn3EhUH30ICPBfv6SYZ4p+9+dA74qKpxzp6npVvgL2GQYxpVDyFQ==
X-Received: by 2002:a17:907:3f88:b0:909:4a93:d9d2 with SMTP id hr8-20020a1709073f8800b009094a93d9d2mr3017522ejc.2.1679643824599;
        Fri, 24 Mar 2023 00:43:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id zc14-20020a170906988e00b00927f6c799e6sm9910045ejb.132.2023.03.24.00.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 00:43:44 -0700 (PDT)
Message-ID: <3b6f75e1-9d48-3de6-a3f5-3563341bebed@redhat.com>
Date:   Fri, 24 Mar 2023 08:43:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix SDIO suspend/resume regression
To:     Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
References: <20230320122252.240070-1-hdegoede@redhat.com>
 <CAPDyKFpacDCKeoyoz86oB-esqTP05Aqd6FZvXvMSA5pmdjo+ow@mail.gmail.com>
 <874jqavd1x.fsf@kernel.org>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <874jqavd1x.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 3/24/23 08:11, Kalle Valo wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
>> + Yann, Christophe
>>
>> On Mon, 20 Mar 2023 at 13:22, Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
>>> unless WOWL is used"), the wifi adapter by default is turned off on suspend
>>> and then re-probed on resume.
>>>
>>> In at least 2 model x86/acpi tablets with brcmfmac43430a1 wifi adapters,
>>> the newly added re-probe on resume fails like this:
>>>
>>>  brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>>>  ieee80211 phy1: brcmf_bus_started: failed: -110
>>>  ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
>>>  brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
>>>
>>> It seems this specific brcmfmac model does not like being reprobed without
>>> it actually being turned off first.
>>>
>>> And the adapter is not being turned off during suspend because of
>>> commit f0992ace680c ("brcmfmac: prohibit ACPI power management for brcmfmac
>>> driver").
>>>
>>> Now that the driver is being reprobed on resume, the disabling of ACPI
>>> pm is no longer necessary, except when WOWL is used (in which case there
>>> is no-reprobe).
>>>
>>> Move the dis-/en-abling of ACPI pm to brcmf_sdio_wowl_config(), this fixes
>>> the brcmfmac43430a1 suspend/resume regression and should help save some
>>> power when suspended.
>>>
>>> This change means that the code now also may re-enable ACPI pm when WOWL
>>> gets disabled. ACPI pm should only be re-enabled if it was enabled by
>>> the ACPI core originally. Add a brcmf_sdiod_acpi_save_power_manageable()
>>> to save the original state for this.
>>>
>>> This has been tested on the following devices:
>>>
>>> Asus T100TA                brcmfmac43241b4-sdio
>>> Acer Iconia One 7 B1-750   brcmfmac43340-sdio
>>> Chuwi Hi8                  brcmfmac43430a0-sdio
>>> Chuwi Hi8                  brcmfmac43430a1-sdio
>>>
>>> (the Asus T100TA is the device for which the prohibiting of ACPI pm
>>>  was originally added)
>>>
>>> Fixes: 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card unless WOWL is used")
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Seems reasonable to me, thanks for fixing this! Feel free to add:
>>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> As this is an older regression from v5.19 should I take this to
> wireless-next to get more testing time?

AFAIK the only ACPI platforms (which this patch impacts) these SDIO wifi modules are used on are x86  Bay Trail and Cherry Trail SoCs, such as the list of _4_ devices I have tested on and it does fix a real regression.

Even though this is a somewhat older regression my personal preference would be for this to get send to Linus sooner rather then later so that this regression gets fixed.

Regards,

Hans


