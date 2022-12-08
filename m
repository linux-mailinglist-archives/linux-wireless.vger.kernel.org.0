Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3596469F5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 08:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLHHyh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 02:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHHyg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 02:54:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47432228C
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 23:54:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7477D61DC1
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 07:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CDAC433D7;
        Thu,  8 Dec 2022 07:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670486074;
        bh=/U0AibPvuG5Tspd4BEVOMD1Ulx8M6BW9qP8wzvQj2TY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CaFZ6mevEKaMrTXWvdgpbxrLvrepW2zIok/Em2X+Xdhq7TOiYiPy6Qs45Q53WZcRs
         mMuWEV91SIw7hKMWRL0j7G8ZCyQu+Lugj2c2aoCHH6ENGftgtZR1mBA0kqCyC9Mp0q
         G+hI8juOejNUUSqr38pAfzEfrQ3S96e5jYBlugwO3d96d3h1G0xbLWTHwu77D4N0Y9
         UaEMQjyUeTnWnI6kY9loCpoOwREFdXQF9VAudT94ZRzaEyqxlkYUm4YP1BpXs4q+X2
         46hGHVJp55+voP6PZ1kxNwN9E06yM/n9ZAhwUmM1bIDW4k/6MwXx28mU49XTx8lgPX
         uFfpnh1S+N3Eg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Enable low power mode when WLAN is not active
In-Reply-To: <2b0ac3c4-74e3-47f1-6aa7-72f2a4176824@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 25 Nov 2022 09:59:33 +0530")
References: <20221121110359.4652-1-quic_mpubbise@quicinc.com>
        <87bkoz8ica.fsf@kernel.org> <87y1s17j1j.fsf@kernel.org>
        <2b0ac3c4-74e3-47f1-6aa7-72f2a4176824@quicinc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 08 Dec 2022 09:54:29 +0200
Message-ID: <87y1ri1gay.fsf@kernel.org>
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

> On 11/23/2022 9:35 PM, Kalle Valo wrote:
>
>> Kalle Valo <kvalo@kernel.org> writes:
>>
>>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:
>>>
>>>> Currently, WLAN chip is powered once during driver probe and is kept
>>>> ON (powered) always even when WLAN is not active; keeping the chip
>>>> powered ON all the time will consume extra power which is not
>>>> desirable for battery operated devices. Same is the case with non-WoW
>>>> suspend, chip will not be put into low power mode when the system is
>>>> suspended resulting in higher battery drain.
>>>>
>>>> Send QMI MODE OFF command to firmware during WiFi OFF to put device
>>>> into low power mode.
>>>>
>>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>>>
>>>> Manikanta Pubbisetty (3):
>>>>    ath11k: Fix double free issue during SRNG deinit
>>>>    ath11k: Move hardware initialization logic to start()
>>>>    ath11k: Enable low power mode when WLAN is not active
>>>> ---
>>>> V3:
>>>>   - Removed patch "ath11k: Fix failed to parse regulatory event print" as it is not needed anymore
>>>>   - Fixed a potential deadlock scenario reported by lockdep around ab->core_lock with V2 changes
>>>>   - Fixed other minor issues that were found during code review
>>>>   - Spelling corrections in the commit messages
>>>
>>> I still see a crash, immediately after the first rmmod:
>>>
>>> Nov 22 11:05:47 nuc2  [  139.378719] rmmod ath11k_pci
>>> Nov 22 11:05:48 nuc2 [ 139.892395] general protection fault, probably
>>> for non-canonical address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP
>>> DEBUG_PAGEALLOC KASAN
>>> Nov 22 11:05:48 nuc2 [ 139.892453] KASAN: null-ptr-deref in range
>>> [0x00000000000001f0-0x00000000000001f7]
>>>
>>> Really odd that you don't see it. Unfortunately not able to debug this
>>> further right now.
>>>
>>> This is with:
>>>
>>> wcn6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.9
>>
>> A bit more information how I see the crash. So first I have all modules
>> loaded:
>>
>> $ lsmod
>> Module                  Size  Used by
>> ath11k_pci             57344  0
>> ath11k               2015232  1 ath11k_pci
>> mac80211             3284992  1 ath11k
>> libarc4                16384  1 mac80211
>> cfg80211             2494464  2 ath11k,mac80211
>> qmi_helpers            57344  1 ath11k
>> qrtr_mhi               20480  0
>> mhi                   217088  2 ath11k_pci,qrtr_mhi
>> qrtr                   98304  5 qrtr_mhi
>> nvme                  122880  3
>> nvme_core             299008  5 nvme
>> $
>>
>> Then I just remove ath11k_pci module and boom:
>>
>> $ sudo rmmod ath11k_pci
>>
>> [ 153.658409] general protection fault, probably for non-canonical
>> address 0xdffffc000000003e: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
>> KASAN
>>
>> This happens every time, there doesn't seem to be any randomness on the
>> behaviour.
>>
>
> Thanks for the help Kalle, this is exactly what I was doing in my
> tests. Unfortunately, I'm not able to reproduce the problem. I have
> also tried with the exact firmware that you have pointed out. Let me
> see if I'm missing anything.

I tested this more and patch 3 seems to be the one causing the crash. I
didn't see this when patch 1-2 were applied.

The crash happens in ath11k_dp_process_rxdma_err() in this line:

	srng = &ab->hal.srng_list[err_ring->ring_id];

ab looks sane to me (0xffff88814c960000) but err_ring is set to 0x200.
Does this help?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
