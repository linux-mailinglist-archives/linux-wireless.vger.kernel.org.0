Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3466A63654B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 17:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiKWQF4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 11:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiKWQFw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 11:05:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0E8A3156
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 08:05:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 285FEB81FDE
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 16:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2830EC433D6;
        Wed, 23 Nov 2022 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669219548;
        bh=rPBZpdey+wlD577Iq7xu+PZhQ8jYJpnS5RXmoGt7JHU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DKxOBom/wfQKst49stTQ8sdJ74NL2Hyb5DdEchQGfOt62bmS1h/dFG6f1HqG+u9CO
         C/Hiap/c34RC0uzhUnesK4TDGYrCXLY5uFwUs7Zc4eZIRef3qSjO9g3RJOWw6M8kVW
         U/49GvQ5sqoAFdVTIGfqS0XolNfP2HDs3BXwBSBufnJm+8ULlQyMZlVkY3B2H64IlT
         HZ5OhC/V2atC65YHHif/liKg9f4Dca5yHLGRQYBpfb777gN1t27DPo3N74UkedfT6R
         kbTT+F0bi70C/B9q0RogMEpBOvwvQNze3KtV05+iTTIc1bWf0qJfv/De4RsYWLflFX
         t+f5a59HjNgfQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Enable low power mode when WLAN is not active
References: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
        <87bkoz8ica.fsf@kernel.org>
Date:   Wed, 23 Nov 2022 18:05:44 +0200
In-Reply-To: <87bkoz8ica.fsf@kernel.org> (Kalle Valo's message of "Tue, 22 Nov
        2022 11:11:01 +0200")
Message-ID: <87y1s17j1j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Kalle Valo <kvalo@kernel.org> writes:

> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>
>> Currently, WLAN chip is powered once during driver probe and is kept
>> ON (powered) always even when WLAN is not active; keeping the chip
>> powered ON all the time will consume extra power which is not
>> desirable for battery operated devices. Same is the case with non-WoW
>> suspend, chip will not be put into low power mode when the system is
>> suspended resulting in higher battery drain.
>>
>> Send QMI MODE OFF command to firmware during WiFi OFF to put device
>> into low power mode.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>
>> Manikanta Pubbisetty (3):
>>   ath11k: Fix double free issue during SRNG deinit
>>   ath11k: Move hardware initialization logic to start()
>>   ath11k: Enable low power mode when WLAN is not active
>> ---
>> V3:
>>  - Removed patch "ath11k: Fix failed to parse regulatory event print" as it is not needed anymore
>>  - Fixed a potential deadlock scenario reported by lockdep around ab->core_lock with V2 changes
>>  - Fixed other minor issues that were found during code review
>>  - Spelling corrections in the commit messages
>
> I still see a crash, immediately after the first rmmod:
>
> Nov 22 11:05:47 nuc2  [  139.378719] rmmod ath11k_pci
> Nov 22 11:05:48 nuc2 [ 139.892395] general protection fault, probably
> for non-canonical address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP
> DEBUG_PAGEALLOC KASAN
> Nov 22 11:05:48 nuc2 [ 139.892453] KASAN: null-ptr-deref in range
> [0x00000000000001f0-0x00000000000001f7]
>
> Really odd that you don't see it. Unfortunately not able to debug this
> further right now.
>
> This is with:
>
> wcn6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9

A bit more information how I see the crash. So first I have all modules
loaded:

$ lsmod
Module                  Size  Used by
ath11k_pci             57344  0
ath11k               2015232  1 ath11k_pci
mac80211             3284992  1 ath11k
libarc4                16384  1 mac80211
cfg80211             2494464  2 ath11k,mac80211
qmi_helpers            57344  1 ath11k
qrtr_mhi               20480  0
mhi                   217088  2 ath11k_pci,qrtr_mhi
qrtr                   98304  5 qrtr_mhi
nvme                  122880  3
nvme_core             299008  5 nvme
$

Then I just remove ath11k_pci module and boom:

$ sudo rmmod ath11k_pci

[  153.658409] general protection fault, probably for non-canonical address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN

This happens every time, there doesn't seem to be any randomness on the
behaviour.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
