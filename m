Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6CB53C5D1
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 09:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiFCHQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 03:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiFCHQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 03:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5543B3
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 00:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8536C6188A
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 07:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023F3C385A9;
        Fri,  3 Jun 2022 07:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654240610;
        bh=FlVVz2JA4/jKmb9ZJzSNebZGnixWxPza/BZ9EhqFGKg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=s5eNDre4JZr8/w5WerNGBF4XviuxhI3bk2P11xW8yKOVxXN5boJFPVa/eWIYRJw6j
         Ytu+DQkEIKCDYAcs6NrUtFdkInKO7V2iHzjOj2ZYcXtxyGO0AMUsC72pc9dAY+SIsS
         W+ssFF0JVj4rxFAB2sd2tNAwdH8wWLqSZdk1KT+13fbt2p9zDjIVD35nTr+7L+E2Pf
         BWf+fosertxGXDHMdNmxpuec08XwGd+I7duiPoOdR9B05B1N0Tw1ePMmNRUOpwTVKV
         s/3MwoxotjIrlbZLnz+W81IASkZN3HyvPDC56zKFkYNzdlGzOLsqmZE5RdRhEMQWl3
         JJl38iwt+qsMg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add wmi ctrl path stats
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1654176800-29003-1-git-send-email-quic_tmariyap@quicinc.com>
References: <1654176800-29003-1-git-send-email-quic_tmariyap@quicinc.com>
To:     Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165424060628.24941.10656719779515709897.kvalo@kernel.org>
Date:   Fri,  3 Jun 2022 07:16:49 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thiraviyam Mariyappan <quic_tmariyap@quicinc.com> wrote:

> Currently, ath11k HTT debugfs uses the HTT interface to send stats request
> to target and response from target. Here HTT interface already overloaded
> with the data path stats. To reduce the load from HTT, using WMI interface
> to print the control path stats. This patch come up with framework for
> control path stats using wmi interface.
> For now, this framework supports PDEV_STAT and further stats will be
> added.
> 
> WMI control path stats command and results are below:
> echo <stats_id> <action> >
>         sys/kernel/debug/ieee80211/phy3/netdev\:wlan3/wmi_ctrl_stats
> cat sys/kernel/debug/ieee80211/phy3/netdev\:wlan3/wmi_ctrl_stats
> stats_id:
> 1 -> WMI_REQ_CTRL_PATH_PDEV_STATS
> action:
> 1 -> stats get
> 2 -> stats reset
> 
> WMI_CTRL_PATH_PDEV_STATS:
> req_id = 26
> fw_tx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:109, 6:0, 7:0, 8:344, ...
> fw_rx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, ...
> scan_fail_dfs_violation_time_ms = 0
> nol_chk_fail_last_chan_freq = 0
> nol_chk_fail_time_stamp_ms = 0
> tot_peer_create_cnt = 2
> tot_peer_del_cnt = 1
> tot_peer_del_resp_cnt = 1
> vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = 0
> 
> Tested-on: WLAN.HK.2.5.0.1-00517-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This added new warnings:

drivers/net/wireless/ath/ath11k/debugfs.c:1600: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/debugfs.c:1666: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:2702: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:2703: line length of 97 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:7037: line length of 97 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:7085: line length of 97 exceeds 90 columns

I fixed them in the pending branch. But in the future please use ath11k-check.

There was one way too long field:

	u32 vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt;

I renamed that to:

	u32 vdev_pause_fail_rt;

In ath11k_wmi_send_wmi_ctrl_stats_cmd() the error handling was unnecessarily
using else branch which caused long lines, I fixed that by avoiding else
branches.

Also I saw some other things, like calling kzalloc() in variable declarations,
but I will look at them in detail later.

Here's what I did now:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=28bc80a6a9c675fdc7003934a9493d9e95570f5f

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1654176800-29003-1-git-send-email-quic_tmariyap@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

