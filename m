Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37988703C7E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245214AbjEOSUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245233AbjEOSUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 14:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D079918871;
        Mon, 15 May 2023 11:19:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA9663139;
        Mon, 15 May 2023 18:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0548BC433EF;
        Mon, 15 May 2023 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684174745;
        bh=lXn4/zb+8zA/44joIb7RJ/8M0SqiyaD6fWxJaePD334=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pJk9W1N/tU7YdZNKnWhelPsah1WtS6AEMRSG50aD1YXSNJxvFu5ulgwikz42uZEzu
         cQ7Xxxsbf8GVFomC3xjsw71xEfd7hmIuZURcOmooCoehdJd8IXqhTa8V/FCAkiEh+U
         R421aoEQYuQhflN+ASSNhExsoNdak9aYBFAw53gdQjbrBcv5WG/8fI3RKcWN8h8E4F
         UIx7Dsl35Pj1Jt4RCdpMOsxQFugRCdHpbAeBRiwSmV/9x5c3ASBmlBzpWk47BXVUH6
         6y9g202U+s7sUeJkYyMIS6q7HS5VPMIc2ewW0feGLSrq3yT6XPT4xhGuH8uGmQRsZL
         jVtTVzX2nfw8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: brcmfmac: Check for probe() id argument being NULL
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230510141856.46532-1-hdegoede@redhat.com>
References: <20230510141856.46532-1-hdegoede@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, regressions@lists.linux.dev,
        Felix <nimrod4garoa@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168417474077.32723.9868823702580384780.kvalo@kernel.org>
Date:   Mon, 15 May 2023 18:19:02 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> wrote:

> The probe() id argument may be NULL in 2 scenarios:
> 
> 1. brcmf_pcie_pm_leave_D3() calling brcmf_pcie_probe() to reprobe
>    the device.
> 
> 2. If a user tries to manually bind the driver from sysfs then the sdio /
>    pcie / usb probe() function gets called with NULL as id argument.
> 
> 1. Is being hit by users causing the following oops on resume and causing
> wifi to stop working:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000018
> <snip>
> Hardware name: Dell Inc. XPS 13 9350/0PWNCR, BIDS 1.13.0 02/10/2020
> Workgueue: events_unbound async_run_entry_fn
> RIP: 0010:brcmf_pcie_probe+Ox16b/0x7a0 [brcmfmac]
> <snip>
> Call Trace:
>  <TASK>
>  brcmf_pcie_pm_leave_D3+0xc5/8x1a0 [brcmfmac be3b4cefca451e190fa35be8f00db1bbec293887]
>  ? pci_pm_resume+0x5b/0xf0
>  ? pci_legacy_resume+0x80/0x80
>  dpm_run_callback+0x47/0x150
>  device_resume+0xa2/0x1f0
>  async_resume+0x1d/0x30
> <snip>
> 
> Fix this by checking for id being NULL.
> 
> In the PCI and USB cases try a manual lookup of the id so that manually
> binding the driver through sysfs and more importantly brcmf_pcie_probe()
> on resume will work.
> 
> For the SDIO case there is no helper to do a manual sdio_device_id lookup,
> so just directly error out on a NULL id there.
> 
> Fixes: da6d9c8ecd00 ("wifi: brcmfmac: add firmware vendor info in driver info")
> Reported-by: Felix <nimrod4garoa@gmail.com>
> Link: https://lore.kernel.org/regressions/4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless.git, thanks.

60fc756fc8e6 wifi: brcmfmac: Check for probe() id argument being NULL

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230510141856.46532-1-hdegoede@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

