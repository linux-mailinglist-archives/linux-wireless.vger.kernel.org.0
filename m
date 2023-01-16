Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C659866BCD7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 12:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjAPL0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 06:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAPL03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 06:26:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929D93C3D
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 03:26:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FA1660F72
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 11:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB53C433F0;
        Mon, 16 Jan 2023 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673868387;
        bh=IG3Tv3fkh8BNxY552orAlUwDWMCoXtRYT6M9OUB+XCw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YGVI3KvdFmC7qvs0Ko1sBWx4deX/pNl2pcg9ub8jgyi+HTo581fIhX1mzT5GUpAZg
         05/eFvuNemVS5CoM1FggQZ7hGOwQvZXcR50vBzu3osFZU3nu1mY0ldV6hBSvv16dTB
         yXEzONsibsmBXCvAjVwejqRkdYwZ9W104fHzgBE8qu0jC+8Ng3l2ErJstqkKJlLcSj
         4A7CwBCUYO/DN43AfY4E4oEyo78+Y90zEnxzZMz1MCM5/L0jSFAyl1bP/IXK9lwx8S
         XGCHu2HW1Uai5BB0ZjRUstJCx/YsrLxQLpMzoondBBJUYQZfqIqDwRqL1MxTDOuV4O
         /MiSI05LamU1g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH for-6.2 1/3] wifi: brcmfmac: avoid handling disabled
 channels
 for survey dump
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230103124117.271988-2-arend.vanspriel@broadcom.com>
References: <20230103124117.271988-2-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167386838367.4736.1608145032804252356.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 11:26:26 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> An issue was reported in which periodically error messages are
> printed in the kernel log:
> 
> [   26.303445] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
> [   26.303554] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with error -2
> [   26.516752] brcmfmac_wcc: brcmf_wcc_attach: executing
> [   26.528264] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
> [   27.076829] Bluetooth: hci0: BCM: features 0x2f
> [   27.078592] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
> [   27.078601] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342
> [   30.142104] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 across:102396k SS
> [   30.590017] Bluetooth: MGMT ver 1.22
> [  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, reason -52
> [  104.897992] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, reason -52
> [  105.007672] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, reason -52
> [  105.117654] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, reason -52
> [  105.227636] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, reason -52
> [  106.987552] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, reason -52
> [  106.987911] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, reason -52
> [  106.988233] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, reason -52
> [  106.988565] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, reason -52
> [  106.988909] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, reason -52
> 
> This happens in brcmf_cfg80211_dump_survey() because we try a disabled
> channel. When channel is marked as disabled we do not need to fill any
> other info so bail out.
> 
> Fixes: 6c04deae1438 ("brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection")
> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

2 patches applied to wireless.git, thanks.

e5d1ab1a73ad wifi: brcmfmac: avoid handling disabled channels for survey dump
aadb50d15712 wifi: brcmfmac: avoid NULL-deref in survey dump for 2G only device

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230103124117.271988-2-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

