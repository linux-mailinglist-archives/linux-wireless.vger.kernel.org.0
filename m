Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8103B7199D0
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 12:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjFAKbx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjFAKbt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 06:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4209139
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 03:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F94761166
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 10:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F252C433EF;
        Thu,  1 Jun 2023 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615501;
        bh=vY0ak8FCDGLIm05/0KdfhWzAPS36q0ukUqV1Wa5Tzn8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=i8oMMu6pCwV3vQIrlY2Y2Um7fnQF5y4cwC5i7I59LJGmJ0fpYusdJUyoRVN6vaHsh
         BKzY2uq85c8X9Qn0wl1D+by/5xDMDzIhRytR91khPwOXqt+m5yjEgRFgXlJCau+YyN
         3MsJ1tuZeQBlm3xX4gU8Z4qFOe8xdJK963/PDkSSpXGe5NpoMHFz048NBkOwVnwy2U
         rfEOznEWDg1csc4zRU6VWOsgwz1W8ZgJ4fnE9TKexvxEduJeqVTVnkNLlq+bVUZuZ2
         Aj4dA0klWDue/9kQQuVTMg9X8C3YycIwgNuurjM8EAmt3j619hTGHA2obD9hn4GoSt
         ZpHTvEXh3WZMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Add HTT stats for PHY reset case
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230517141242.2754293-1-quic_mkenna@quicinc.com>
References: <20230517141242.2754293-1-quic_mkenna@quicinc.com>
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Nidhi Jain <quic_nidhjain@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168561549890.17301.6614952476365220366.kvalo@kernel.org>
Date:   Thu,  1 Jun 2023 10:31:40 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <quic_mkenna@quicinc.com> wrote:

> New HTT stats are added with stats type 37 to
> provide PHY reset stats and PHY reset counter stats.
> 
> PHY reset stats are used to display the current
> PHY-related operation information such as band, CCA
> threshold, current operating channel etc.,
> 
> PHY reset counter stats are used to display the
> PHY reset counter values like calibration counts,
> temperature based recalibration counts etc.,
> 
> Usage:
> echo 37 > /sys/kernel/debug/ieee80211/phyX/ath11k/htt_stats_type
> cat /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats
> 
> Output:
> 
> HTT_PHY_RESET_STATS_TLV:
> pdev_id = 0
> chan_mhz = 5180
> chan_band_center_freq1 = 5210
> chan_band_center_freq2 = 0
> chan_phy_mode = 18
> chan_flags = 0x8
> chan_num = 36
> reset_cause = 0x50000
> prev_reset_cause = 0x50000
> phy_warm_reset_src = 0x0
> rx_gain_tbl_mode = 0
> xbar_val = 0xfac688
> force_calibration = 0
> phyrf_mode = 0
> phy_homechan = 0
> phy_tx_ch_mask = 0x3
> phy_rx_ch_mask = 0x3
> phybb_ini_mask = 0x5
> phyrf_ini_mask = 0x0
> phy_dfs_en_mask = 0x0
> phy_sscan_en_mask = 0x0
> phy_synth_sel_mask = 0x0
> phy_adfs_freq = 0
> cck_fir_settings = 0x0
> phy_dyn_pri_chan = 6
> cca_thresh = 0x26232020
> dyn_cca_status = 0
> rxdesense_thresh_hw = 0xcfe0afe
> rxdesense_thresh_sw = 0xcfe0afe
> 
> HTT_PHY_RESET_COUNTERS_TLV:
> pdev_id = 0
> cf_active_low_fail_cnt = 0
> cf_active_low_pass_cnt = 0
> phy_off_through_vreg_cnt = 0
> force_calibration_cnt = 0
> rf_mode_switch_phy_off_cnt = 0
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nidhi Jain <quic_nidhjain@quicinc.com>
> Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2d4f9093e2d8 wifi: ath11k: Add HTT stats for PHY reset case

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230517141242.2754293-1-quic_mkenna@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

