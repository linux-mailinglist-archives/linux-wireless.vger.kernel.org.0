Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C86DF13E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDLJ5i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 05:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLJ5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 05:57:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4535072A4
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 02:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6F962D39
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 09:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3E3C433EF;
        Wed, 12 Apr 2023 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681293455;
        bh=hE4La5t8yB1HoZ0gdw/pM5HDZGdI4D6Kb1y56YSkmco=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WtvrHIJLg/LM826Jb+72eYripZIsNMHF+Oc9LSJaWvgJBd50zIwi9X3GUNM1wWwqZ
         Ah3xxRN8ip/5UxHisiitHuWfvgR1X6RdzvhEn3AGcBwjTMFR4api3LIVaGUXxXT6Jp
         4U/F6glSB1A+3bnsWCPR4pxqidKm7C4Mt6gD7Mh8NbN+dUAb4n8ztR/PK3vimDtb+O
         kBSx7GCK4Hyg8gpvo0RWb+QsHHLhMCM+uqgSLG+PoQ2jvkVribuZa/PoBB0R06xfkd
         OnyGXWVhqCAOQ+zaNfvmkfXBIgOgg06aQxdmfmBg35/65x94GtQPio0EEKk2DdYRGn
         eKTbKdTzITknQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] wifi: ath11k: Optimize 6 GHz scan time
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230323060913.10097-1-quic_mpubbise@quicinc.com>
References: <20230323060913.10097-1-quic_mpubbise@quicinc.com>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168129345224.14673.5339592403399193751.kvalo@kernel.org>
Date:   Wed, 12 Apr 2023 09:57:34 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8b4d2f080afb wifi: ath11k: Optimize 6 GHz scan time

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230323060913.10097-1-quic_mpubbise@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

