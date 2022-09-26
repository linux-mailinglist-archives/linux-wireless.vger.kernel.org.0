Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8272C5E9E1B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIZJoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiIZJnj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 05:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238F7476DA
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 02:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B3160B4A
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 09:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B46FC433D6;
        Mon, 26 Sep 2022 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664185271;
        bh=f00h5sF3WBB/NQzTissBhyroT5VCQxGpAmwnvW6QaiY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QF2gy5Alv5ZmF3jltTiYGfeVLoCOTgWwzATe5Wk/eHec0TrBOpZu7pYkiU+d5pZry
         GIXarnTuZllFT6U9P2b7NLh2hYxBtTPCnd//YiuHl4jrc3JdUcM21DotjVvMJ4ifbA
         UT0l7LcoDk5kh+M6hp4ruZpOkwo/hy2UWhXl2Hoq1EZtDPYJRkNLcMkg9W3F6JllIV
         ljtzYS1f/MlZyCCeMm2ImjyH5SbAnJnsT2gUvzRTRzvQp4gEYGXLSPoDJFTrbo+qP2
         fVjCv4d06JAHphuChLBy4iMOvYF7dtTnGUnZIo99Ize/dUvLQdEc0JPs7krXphZdvP
         IMrSR5aynYPGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Fix deadlock during WoWLAN suspend
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220919021435.2459-1-quic_bqiang@quicinc.com>
References: <20220919021435.2459-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166418526848.13691.14908006715046928554.kvalo@kernel.org>
Date:   Mon, 26 Sep 2022 09:41:10 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing system hangs during WoWLAN suspend, and get below
> two stacks:
> 
> Stack1:
> [ffffb02cc1557b20] __schedule at ffffffff8bb10860
> [ffffb02cc1557ba8] schedule at ffffffff8bb10f24
> [ffffb02cc1557bb8] schedule_timeout at ffffffff8bb16d88
> [ffffb02cc1557c30] wait_for_completion at ffffffff8bb11778
> [ffffb02cc1557c78] __flush_work at ffffffff8b0b30cd
> [ffffb02cc1557cf0] __cancel_work_timer at ffffffff8b0b33ad
> [ffffb02cc1557d60] ath11k_mac_drain_tx at ffffffffc0c1f0ca [ath11k]
> [ffffb02cc1557d70] ath11k_wow_op_suspend at ffffffffc0c5201e [ath11k]
> [ffffb02cc1557da8] __ieee80211_suspend at ffffffffc11e2bd3 [mac80211]
> [ffffb02cc1557dd8] wiphy_suspend at ffffffffc0f901ac [cfg80211]
> [ffffb02cc1557e08] dpm_run_callback at ffffffff8b75118a
> [ffffb02cc1557e38] __device_suspend at ffffffff8b751630
> [ffffb02cc1557e70] async_suspend at ffffffff8b7519ea
> [ffffb02cc1557e88] async_run_entry_fn at ffffffff8b0bf4ce
> [ffffb02cc1557ea8] process_one_work at ffffffff8b0b1a24
> [ffffb02cc1557ee0] worker_thread at ffffffff8b0b1c4a
> [ffffb02cc1557f18] kthread at ffffffff8b0b9cb8
> [ffffb02cc1557f50] ret_from_fork at ffffffff8b001d32
> 
> Stack2:
> [ffffb02cc00b7d18] __schedule at ffffffff8bb10860
> [ffffb02cc00b7da0] schedule at ffffffff8bb10f24
> [ffffb02cc00b7db0] schedule_preempt_disabled at ffffffff8bb112b4
> [ffffb02cc00b7db8] __mutex_lock at ffffffff8bb127ea
> [ffffb02cc00b7e38] ath11k_mgmt_over_wmi_tx_work at ffffffffc0c1aa44 [ath11k]
> [ffffb02cc00b7ea8] process_one_work at ffffffff8b0b1a24
> [ffffb02cc00b7ee0] worker_thread at ffffffff8b0b1c4a
> [ffffb02cc00b7f18] kthread at ffffffff8b0b9cb8
> [ffffb02cc00b7f50] ret_from_fork at ffffffff8b001d32
> 
> From the first stack, ath11k_mac_drain_tx calls
> cancel_work_sync(&ar->wmi_mgmt_tx_work) and waits all packets to be sent
> out or dropped. However, we find from Stack2 that this work item is blocked
> because ar->conf_mutex is already held by ath11k_wow_op_suspend.
> 
> Fix this issue by moving ath11k_mac_wait_tx_complete to the start of
> ath11k_wow_op_suspend where ar->conf_mutex has not been acquired. And
> this change also makes the logic in ath11k_wow_op_suspend match the
> logic in ath11k_mac_op_start and ath11k_mac_op_stop.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d78c8b7131dc wifi: ath11k: Fix deadlock during WoWLAN suspend

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220919021435.2459-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

