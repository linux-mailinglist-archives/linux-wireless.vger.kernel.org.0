Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1DB6BADA8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 11:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjCOK3X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjCOK3W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 06:29:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68862769C5
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 03:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A5701CE1990
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 10:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CB7C433EF;
        Wed, 15 Mar 2023 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678876154;
        bh=V7p7t5ulCDAthzV6TDbShJmfYxB0GhhSLmZWVhXqVRc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=obBYlyFtmupp93eGT3dnpin4fgnjugR8oU/rc9NcaFcmi+fEhCyqPsUWLlFKIO1fg
         WQEtyhOWfkP/lHnA2lRnUz0oko/9qhRIf1dkSfvF7FZCRL8mqQy0UiIx9XiGyHg4FW
         LtN2VvXt2lcxtCONeB6p6PPrARVMRlFXGTjw7fQoGivQYK5t598MnLvjBwR5/cyYDu
         9wxMd6fejD/ha4/BVdwsTSX7yPbZu6ntp06Y9kNsoASZy22bhwdXV2i0etC8IThXs/
         Yb/SIf/77RFdCio/A3JuEJDT9N+gU+WVkKY0oKuyB8jMJveONcqbJuLOCnzMkrJdLE
         K0fsxJDZs/bGw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: Optimize 6 GHz scan time
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230309095220.1495-1-quic_mpubbise@quicinc.com>
References: <20230309095220.1495-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167887615209.12266.424609891131575348.kvalo@kernel.org>
Date:   Wed, 15 Mar 2023 10:29:13 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> wrote:

> Currently, time taken to scan all supported channels on WCN6750
> is ~8 seconds and connection time is almost 10 seconds. WCN6750
> supports three Wi-Fi bands (i.e., 2.4/5/6 GHz) and the numbers of
> channels for scan come around ~100 channels (default case).
> Since the chip doesn't have support for DBS (Dual Band Simultaneous),
> scans cannot be parallelized resulting in longer scan times.
> 
> Among the 100 odd channels, ~60 channels are in 6 GHz band. Therefore,
> optimizing the scan for 6 GHz channels will bring down the overall
> scan time.
> 
> WCN6750 firmware has support to scan a 6 GHz channel based on co-located
> AP information i.e., RNR IE which is found in the legacy 2.4/5 GHz scan
> results. When a scan request with all supported channel list is enqueued
> to the firmware, then based on WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND
> scan channel flag, firmware will scan only those 6 GHz channels for which
> RNR IEs are found in the legacy scan results.
> 
> In the proposed design, based on NL80211_SCAN_FLAG_COLOCATED_6GHZ scan
> flag, driver will set the WMI_SCAN_CHAN_FLAG_SCAN_ONLY_IF_RNR_FOUND flag
> for non-PSC channels. Since there is high probability to find 6 GHz APs
> on PSC channels, these channels are always scanned. Only non-PSC channels
> are selectively scanned based on cached RNR information from the legacy
> scan results.
> 
> If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set in the scan flags,
> then scan will happen on all supported channels (default behavior).
> 
> With these optimizations, scan time is improved by 1.5-1.8 seconds on
> WCN6750. Similar savings have been observed on WCN6855.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
> 
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

Fails to apply, please rebase.

error: patch failed: drivers/net/wireless/ath/ath11k/wmi.h:2097
error: drivers/net/wireless/ath/ath11k/wmi.h: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230309095220.1495-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

