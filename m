Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E67522199
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiEJQtc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEJQt2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:49:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC0B2A3743
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30DDDB81E21
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 16:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016EEC385C2;
        Tue, 10 May 2022 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652201127;
        bh=Xau5U8O+mJZo3//0D1VJHnUYN7QvrdNMl75LqPlFn5c=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cFK4020jT2kUBuLwkDHIWnk/ahHc6Jl3+y9R2BJdWMsCCmbTd916uaam4OQil5KFA
         0QU+A24YeIWRBiOUolw3PlLd+T+zRY/i/YQNM/F7WJNmwJrRXmzORq98CgCadxwt4N
         LM1OPmhA6ffu7ktF6k4OsA2QmZMLVSDiMGkWjqZmc7uOlvcLE+8rZzShAExoTgN0Hb
         k9sV8xqAfHTQHgSaElCW1CQEtvAyeDk+3P3a2oE/CCoLwBqNVko1EsiED5iINA+kAb
         teHozMUwyLBWFmn2Xkfy+iAA6Z0dedzlRUwr+HpqsZgbojF+hrNfLTX+lJHilVv9tw
         fmSYVxTQ7DI3g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Sriram R <quic_srirrama@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: update missing mumimo and ofdma stats
References: <1652152236-12038-1-git-send-email-quic_srirrama@quicinc.com>
Date:   Tue, 10 May 2022 19:45:22 +0300
In-Reply-To: <1652152236-12038-1-git-send-email-quic_srirrama@quicinc.com>
        (Sriram R.'s message of "Tue, 10 May 2022 08:40:36 +0530")
Message-ID: <87mtfp72vx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <quic_srirrama@quicinc.com> writes:

> Update the missing MU-MIMO/OFDMA info in PDEV RX,
> trigger and schedule stats. i.e HTT stats type 10, 12 and 17
> respectively.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4-01209-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>

[...]

> @@ -734,6 +738,21 @@ struct htt_tx_pdev_mu_mimo_sch_stats_tlv {
>  	u32 ac_mu_mimo_sch_nusers[HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS];
>  	u32 ax_mu_mimo_sch_nusers[HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS];
>  	u32 ax_ofdma_sch_nusers[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
> +	u32 ax_ul_ofdma_basic_sch_nusers[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
> +	u32 ax_ul_ofdma_bsr_sch_nusers[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
> +	u32 ax_ul_ofdma_bar_sch_nusers[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
> +	u32 ax_ul_ofdma_brp_sch_nusers[HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS];
> +	/* UL MUMIMO */
> +	/* ax_ul_mumimo_basic_sch_nusers[i] is the number of basic triggers sent
> +	 * for (i+1) users
> +	 */
> +	u32 ax_ul_mumimo_basic_sch_nusers[HTT_TX_PDEV_STATS_NUM_UL_MUMIMO_USER_STATS];
> +	/* ax_ul_mumimo_brp_sch_nusers[i] is the number of brp triggers sent
> +	 * for (i+1) users
> +	 */
> +	u32 ax_ul_mumimo_brp_sch_nusers[HTT_TX_PDEV_STATS_NUM_UL_MUMIMO_USER_STATS];
> +	u32 ac_mu_mimo_sch_posted_per_grp_sz[HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS];
> +	u32 ax_mu_mimo_sch_posted_per_grp_sz[HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS];
>  };

In the pending branch I added some newlines to make this more readable.

> @@ -1297,6 +1316,8 @@ struct htt_tx_pdev_rate_stats_tlv {
>  #define HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
>  #define HTT_RX_PDEV_MAX_OFDMA_NUM_USER             8
>  #define HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS 16
> +#define HTT_RX_PDEV_STATS_NUM_RU_SIZE_COUNTERS     6
> +#define HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER          8
>  
>  struct htt_rx_pdev_rate_stats_tlv {
>  	u32 mac_id__word;
> @@ -1375,6 +1396,21 @@ struct htt_rx_pdev_rate_stats_tlv {
>  	u32 per_chain_rssi_pkt_type;
>  	s8 rx_per_chain_rssi_in_dbm[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
>  				   [HTT_RX_PDEV_STATS_NUM_BW_COUNTERS];
> +
> +	u32 rx_su_ndpa;
> +	u32 rx_11ax_su_txbf_mcs[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
> +	u32 rx_mu_ndpa;
> +	u32 rx_11ax_mu_txbf_mcs[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
> +	u32 rx_br_poll;
> +	u32 rx_11ax_dl_ofdma_mcs[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS];
> +	u32 rx_11ax_dl_ofdma_ru[HTT_RX_PDEV_STATS_NUM_RU_SIZE_COUNTERS];
> +
> +	u32 rx_ulmumimo_non_data_ppdu[HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER]; /* ppdu level */
> +	u32 rx_ulmumimo_data_ppdu[HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER];     /* ppdu level */
> +	u32 rx_ulmumimo_mpdu_ok[HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER];       /* mpdu level */
> +	u32 rx_ulmumimo_mpdu_fail[HTT_RX_PDEV_MAX_ULMUMIMO_NUM_USER];     /* mpdu level */
> +	u32 rx_ulofdma_non_data_nusers[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
> +	u32 rx_ulofdma_data_nusers[HTT_RX_PDEV_MAX_OFDMA_NUM_USER];
>  };

The comments didn't provide any extra information so I removed them.

There were also new warnings, fixed in the pending branch:

drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:2978: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:2983: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3051: line length of 95 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3054: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3057: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3060: line length of 96 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3063: line length of 97 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3066: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3069: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c:3072: line length of 93 exceeds 90 columns

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
