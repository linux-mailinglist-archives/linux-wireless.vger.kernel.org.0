Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759A163380A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 10:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiKVJLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 04:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiKVJLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 04:11:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE748769
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 01:11:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2FB3615C9
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 09:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E85C433C1;
        Tue, 22 Nov 2022 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669108266;
        bh=06WBHnIaeJF8wvV9xffzaRx2sY/eraCrCD+NYMHPGno=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=e3AzE1HoD9iRF+0+3MSo5WnQRd0xCHgZT+kBxj3g9cneCUwJL/e+lMEeTU1hhYukU
         aBjD/x8oRgvtfyLh65P9nlwoIovFM5tWNb75nvukfimsZv8GfxLc2jM2gCtHEmfyS7
         NzuMGW48h+FcVM/3/JjuKqoSJZSoKBUxsRm+rujZ02ASGjdgaYXE70j2veEHixAXZL
         knqOWYme7SCscfPm6odlSFBvom6VsimN5EQdJ7E/8xRRVNPSaOiLZ09U34Ode10aZh
         2mw0CyiwDVwdILIXlVkLm4CiT6UNcraJYTzsudhtzHwk/2pEZD9QI6rVUaQsRO+ZKr
         XbQzXr+chcBjQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Enable low power mode when WLAN is not active
In-Reply-To: <20221121110359.4652-1-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Mon, 21 Nov 2022 16:33:56 +0530")
References: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 22 Nov 2022 11:11:01 +0200
Message-ID: <87bkoz8ica.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Currently, WLAN chip is powered once during driver probe and is kept
> ON (powered) always even when WLAN is not active; keeping the chip
> powered ON all the time will consume extra power which is not
> desirable for battery operated devices. Same is the case with non-WoW
> suspend, chip will not be put into low power mode when the system is
> suspended resulting in higher battery drain.
>
> Send QMI MODE OFF command to firmware during WiFi OFF to put device
> into low power mode.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>
> Manikanta Pubbisetty (3):
>   ath11k: Fix double free issue during SRNG deinit
>   ath11k: Move hardware initialization logic to start()
>   ath11k: Enable low power mode when WLAN is not active
> ---
> V3:
>  - Removed patch "ath11k: Fix failed to parse regulatory event print" as it is not needed anymore
>  - Fixed a potential deadlock scenario reported by lockdep around ab->core_lock with V2 changes
>  - Fixed other minor issues that were found during code review
>  - Spelling corrections in the commit messages

I still see a crash, immediately after the first rmmod:

Nov 22 11:05:47 nuc2  [  139.378719] rmmod ath11k_pci
Nov 22 11:05:48 nuc2  [  139.892395] general protection fault, probably for non-canonical address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
Nov 22 11:05:48 nuc2  [  139.892453] KASAN: null-ptr-deref in range [0x00000000000001f0-0x00000000000001f7]

Really odd that you don't see it. Unfortunately not able to debug this
further right now.

This is with:

wcn6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
