Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE06D2365
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Mar 2023 17:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjCaPBI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjCaPAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 11:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1031D502
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 08:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AAE66293D
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 15:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81E8C433D2;
        Fri, 31 Mar 2023 15:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680274846;
        bh=8LY7eo1n32jgo/0yb5uco8QesIkrj++TNg1Ht7mcvWM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n4pvQ3HEEuN5XDFUFeqLbZ9C9Wn2WKBbDI1JZFu2LlcHTZeYPnvX6LCSYsB/VvfWT
         N1BlzsRl3FuXy1wZY0YX3ZrqwSRjlNjxl+mABLp7K2k9z9MPknEwx1rizwFxyDPYgN
         PM3YULuITFPkHyWr5/fYbRXaB7QxxcsVC/LaEYUTU4QzBXmgETohGk116fYAZVlO1C
         vmBtoWGHyqQWzTUl0QJvSBs5s7nTteOE9R+v4aBS35tR5zxUMQCneRsCE3kY9mXDr1
         C+tZ/Anf+/cMo357E8ay9JwTgyRczzQfh9DJn4Lo79YsNfXFhPSsAUhFSghf0cvotr
         3TXZun8TpC7cw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: brcmfmac: Fix SDIO suspend/resume regression
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230320122252.240070-1-hdegoede@redhat.com>
References: <20230320122252.240070-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Ulf Hansson <ulf.hansson@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168027484302.3675.6718945488204958465.kvalo@kernel.org>
Date:   Fri, 31 Mar 2023 15:00:44 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> After commit 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card
> unless WOWL is used"), the wifi adapter by default is turned off on suspend
> and then re-probed on resume.
> 
> In at least 2 model x86/acpi tablets with brcmfmac43430a1 wifi adapters,
> the newly added re-probe on resume fails like this:
> 
>  brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
>  ieee80211 phy1: brcmf_bus_started: failed: -110
>  ieee80211 phy1: brcmf_attach: dongle is not responding: err=-110
>  brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
> 
> It seems this specific brcmfmac model does not like being reprobed without
> it actually being turned off first.
> 
> And the adapter is not being turned off during suspend because of
> commit f0992ace680c ("brcmfmac: prohibit ACPI power management for brcmfmac
> driver").
> 
> Now that the driver is being reprobed on resume, the disabling of ACPI
> pm is no longer necessary, except when WOWL is used (in which case there
> is no-reprobe).
> 
> Move the dis-/en-abling of ACPI pm to brcmf_sdio_wowl_config(), this fixes
> the brcmfmac43430a1 suspend/resume regression and should help save some
> power when suspended.
> 
> This change means that the code now also may re-enable ACPI pm when WOWL
> gets disabled. ACPI pm should only be re-enabled if it was enabled by
> the ACPI core originally. Add a brcmf_sdiod_acpi_save_power_manageable()
> to save the original state for this.
> 
> This has been tested on the following devices:
> 
> Asus T100TA                brcmfmac43241b4-sdio
> Acer Iconia One 7 B1-750   brcmfmac43340-sdio
> Chuwi Hi8                  brcmfmac43430a0-sdio
> Chuwi Hi8                  brcmfmac43430a1-sdio
> 
> (the Asus T100TA is the device for which the prohibiting of ACPI pm
>  was originally added)
> 
> Fixes: 92cadedd9d5f ("brcmfmac: Avoid keeping power to SDIO card unless WOWL is used")
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to wireless.git, thanks.

e4efa515d58f wifi: brcmfmac: Fix SDIO suspend/resume regression

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230320122252.240070-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

