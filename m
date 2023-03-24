Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008E56C7881
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 08:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCXHLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 03:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjCXHLu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 03:11:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259725E35
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 00:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 437D3B822B5
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 07:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0155DC433EF;
        Fri, 24 Mar 2023 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679641904;
        bh=kUN5xrlpoJluSYXeA6jQhKXtezB/+/6iMOE659UMlfA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mMstbuZko8JvIzDRK+C6tGM/msKR6gj14b/TOQRxOsYiWRuF/ZJ/J90AYaU/+oKZw
         i+/wNwylQ9MRh4ui0VQmDuZF4z8WQZyHb0gh2HZpWB1gUZVqSGnzWNM5cLQXYZQNe/
         4bbtDODZA1mv2JJezJ0Gwb5K/4aKNd9/vCcHHtkyf085XbUM1HwSbKPLcE+dD32JnC
         OsbKGdBbeNGeaWlXGwh6cU+ge8yrUiu4jBT5+Z+jKEhx1yzE5Bp2HFJmED8wjOydtI
         PZQXAaKPAxKkTbk0u/Q69wNgQI8YoDq6eIf+McSaevZtNJkiKLzo0XBH1DXYDZqnCP
         WnAgpFQDThLag==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix SDIO suspend/resume regression
References: <20230320122252.240070-1-hdegoede@redhat.com>
        <CAPDyKFpacDCKeoyoz86oB-esqTP05Aqd6FZvXvMSA5pmdjo+ow@mail.gmail.com>
Date:   Fri, 24 Mar 2023 09:11:38 +0200
In-Reply-To: <CAPDyKFpacDCKeoyoz86oB-esqTP05Aqd6FZvXvMSA5pmdjo+ow@mail.gmail.com>
        (Ulf Hansson's message of "Thu, 23 Mar 2023 15:33:44 +0100")
Message-ID: <874jqavd1x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> + Yann, Christophe
>
> On Mon, 20 Mar 2023 at 13:22, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
>> unless WOWL is used"), the wifi adapter by default is turned off on suspend
>> and then re-probed on resume.
>>
>> In at least 2 model x86/acpi tablets with brcmfmac43430a1 wifi adapters,
>> the newly added re-probe on resume fails like this:
>>
>>  brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>>  ieee80211 phy1: brcmf_bus_started: failed: -110
>>  ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
>>  brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
>>
>> It seems this specific brcmfmac model does not like being reprobed without
>> it actually being turned off first.
>>
>> And the adapter is not being turned off during suspend because of
>> commit f0992ace680c ("brcmfmac: prohibit ACPI power management for brcmfmac
>> driver").
>>
>> Now that the driver is being reprobed on resume, the disabling of ACPI
>> pm is no longer necessary, except when WOWL is used (in which case there
>> is no-reprobe).
>>
>> Move the dis-/en-abling of ACPI pm to brcmf_sdio_wowl_config(), this fixes
>> the brcmfmac43430a1 suspend/resume regression and should help save some
>> power when suspended.
>>
>> This change means that the code now also may re-enable ACPI pm when WOWL
>> gets disabled. ACPI pm should only be re-enabled if it was enabled by
>> the ACPI core originally. Add a brcmf_sdiod_acpi_save_power_manageable()
>> to save the original state for this.
>>
>> This has been tested on the following devices:
>>
>> Asus T100TA                brcmfmac43241b4-sdio
>> Acer Iconia One 7 B1-750   brcmfmac43340-sdio
>> Chuwi Hi8                  brcmfmac43430a0-sdio
>> Chuwi Hi8                  brcmfmac43430a1-sdio
>>
>> (the Asus T100TA is the device for which the prohibiting of ACPI pm
>>  was originally added)
>>
>> Fixes: 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card unless WOWL is used")
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Seems reasonable to me, thanks for fixing this! Feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

As this is an older regression from v5.19 should I take this to
wireless-next to get more testing time?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
