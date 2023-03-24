Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBDB6C7773
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Mar 2023 06:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCXFlq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 01:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXFlp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 01:41:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40DC27493
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 22:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7662B822DE
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 05:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B824C433EF;
        Fri, 24 Mar 2023 05:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679636500;
        bh=h29nt0gEMF/1LgqRHfjBAUDV0ke/wpAkbvezYM26cRE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V56mWhUY5/ISlJsP5G3oazS58WlawYqZK9D5OZzDxvGmHzIRn57vwBKZPjnbETpZN
         zqbkEnb3VYQgNEfGbpZc1pdTSA9vWwE2f/MIQn74QdCmYVuoH9yLQuJ5psRNG5vaSA
         BObndQkOGaKv2uCeC2Hhh/TrKScRTztdwLJzU06DPTNi4B+oX3imzfNbcyYj2A9/l5
         Yk2s5DF8Wi+dv9jrFWd7/CkFLb88IuCpYj2hIcejEjinlteC13Z38AuhKd4mV/hLI4
         oa7SeZCUsddcxC+OIMa71S2GIVusPEed810snnPK3lM/6vzqpsl/Rj/IVIq7UrN+fD
         /1tnzrk89naiQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] wifi: ath11k: Optimize 6 GHz scan time
References: <20230315112103.18426-1-quic_mpubbise@quicinc.com>
        <167948612507.6445.2579526780286789940.kvalo@kernel.org>
        <2152e5f1-cecd-f5d2-ca4b-e7ed159f40b7@quicinc.com>
Date:   Fri, 24 Mar 2023 07:41:34 +0200
In-Reply-To: <2152e5f1-cecd-f5d2-ca4b-e7ed159f40b7@quicinc.com> (Manikanta
        Pubbisetty's message of "Thu, 23 Mar 2023 11:41:14 +0530")
Message-ID: <871qleemep.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> On 3/22/2023 5:25 PM, Kalle Valo wrote:
>
>> Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:
>>
>>> Currently, time taken to scan all supported channels on WCN6750
>>> is ~8 seconds and connection time is almost 10 seconds. WCN6750
>>> supports three Wi-Fi bands (i.e., 2.4/5/6 GHz) and the numbers of
>>> channels for scan come around ~100 channels (default case).
>>> Since the chip doesn't have support for DBS (Dual Band Simultaneous),
>>> scans cannot be parallelized resulting in longer scan times.
>>>
>>> Among the 100 odd channels, ~60 channels are in 6 GHz band. Therefore,
>>> optimizing the scan for 6 GHz channels will bring down the overall
>>> scan time.
>>>
>>> WCN6750 firmware has support to scan a 6 GHz channel based on co-located
>>> AP information i.e., RNR IE which is found in the legacy 2.4/5 GHz scan
>>> results. When a scan request with all supported channel list is enqueued
>>> to the firmware, then based on WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND
>>> scan channel flag, firmware will scan only those 6 GHz channels for which
>>> RNR IEs are found in the legacy scan results.
>>>
>>> In the proposed design, based on NL80211_SCAN_FLAG_COLOCATED_6GHZ scan
>>> flag, driver will set the WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND flag
>>> for non-PSC channels. Since there is high probability to find 6 GHz APs
>>> on PSC channels, these channels are always scanned. Only non-PSC channels
>>> are selectively scanned based on cached RNR information from the legacy
>>> scan results.
>>>
>>> If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set in the scan flags,
>>> then scan will happen on all supported channels (default behavior).
>>>
>>> With these optimizations, scan time is improved by 1.5-1.8 seconds on
>>> WCN6750. Similar savings have been observed on WCN6855.
>>>
>>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>>>
>>> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> New warning:
>>
>> drivers/net/wireless/ath/ath11k/mac.c:3827: line length of 91 exceeds 90 columns
>>
>> I couldn't quickly figure out how to fix that, any ideas?
>>
>
> I'd thought that max_line_length is 100 from the checkpatch.pl

In ath11k-check it's set to 90.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
