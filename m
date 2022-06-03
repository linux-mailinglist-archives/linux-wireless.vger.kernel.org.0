Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4B53C6E4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiFCIXd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiFCIX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 04:23:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ABA18B0B
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 01:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FB2DB8225F
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 08:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D69FC385A9;
        Fri,  3 Jun 2022 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654244605;
        bh=/KbmjsL8JIlYkhdMkcO+aAcI+4wmIoG4EN3/mn6cgHg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=R3Lkb47grZJmoN6KLVioiPNbs9TvDKCI2fWgIJ1niRkSL3z+ZbuOYW0hApuYsFZog
         h1madfHiI988V90cuic/HKKyAMt0nbwW1EBUS36fzQdHbKeH/KvF6qygrjmj6Hqd6l
         ixvSZn3+svJuicazMkdRKtt9yP9E4/5jP6rO6WFtgW7RDFJLw4Q20Uyn4kM4bgzKym
         822GkjMQU2ZdpgEVh3TqfANRdhukMLPomo2gBdZdDQ7ofJkWu75B9Z5j4FvjgDo06g
         O5lGOkiewreMmDoiTyN3e9BVO1YtwhMWC9de9HKPcy9B6+mnfMwaqy8BywZDP5y3oe
         0NbmcnqhvM3DA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: add wmi ctrl path stats
References: <1654176800-29003-1-git-send-email-quic_tmariyap@quicinc.com>
        <165424060628.24941.10656719779515709897.kvalo@kernel.org>
Date:   Fri, 03 Jun 2022 11:23:18 +0300
In-Reply-To: <165424060628.24941.10656719779515709897.kvalo@kernel.org> (Kalle
        Valo's message of "Fri, 3 Jun 2022 07:16:49 +0000 (UTC)")
Message-ID: <87czfqnojt.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Thiraviyam Mariyappan <quic_tmariyap@quicinc.com> wrote:
>
>> Currently, ath11k HTT debugfs uses the HTT interface to send stats request
>> to target and response from target. Here HTT interface already overloaded
>> with the data path stats. To reduce the load from HTT, using WMI interface
>> to print the control path stats. This patch come up with framework for
>> control path stats using wmi interface.
>> For now, this framework supports PDEV_STAT and further stats will be
>> added.
>> 
>> WMI control path stats command and results are below:
>> echo <stats_id> <action> >
>>         sys/kernel/debug/ieee80211/phy3/netdev\:wlan3/wmi_ctrl_stats
>> cat sys/kernel/debug/ieee80211/phy3/netdev\:wlan3/wmi_ctrl_stats
>> stats_id:
>> 1 -> WMI_REQ_CTRL_PATH_PDEV_STATS
>> action:
>> 1 -> stats get
>> 2 -> stats reset
>> 
>> WMI_CTRL_PATH_PDEV_STATS:
>> req_id = 26
>> fw_tx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:109, 6:0, 7:0, 8:344, ...
>> fw_rx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, ...
>> scan_fail_dfs_violation_time_ms = 0
>> nol_chk_fail_last_chan_freq = 0
>> nol_chk_fail_time_stamp_ms = 0
>> tot_peer_create_cnt = 2
>> tot_peer_del_cnt = 1
>> tot_peer_del_resp_cnt = 1
>> vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = 0
>> 
>> Tested-on: WLAN.HK.2.5.0.1-00517-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>
> This added new warnings:
>
> drivers/net/wireless/ath/ath11k/debugfs.c:1600: line length of 92 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/debugfs.c:1666: line length of 93 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wmi.c:2702: line length of 94 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wmi.c:2703: line length of 97 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wmi.c:7037: line length of 97 exceeds 90 columns
> drivers/net/wireless/ath/ath11k/wmi.c:7085: line length of 97 exceeds 90 columns
>
> I fixed them in the pending branch. But in the future please use ath11k-check.
>
> There was one way too long field:
>
> 	u32 vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt;
>
> I renamed that to:
>
> 	u32 vdev_pause_fail_rt;
>
> In ath11k_wmi_send_wmi_ctrl_stats_cmd() the error handling was unnecessarily
> using else branch which caused long lines, I fixed that by avoiding else
> branches.
>
> Also I saw some other things, like calling kzalloc() in variable declarations,
> but I will look at them in detail later.
>
> Here's what I did now:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=28bc80a6a9c675fdc7003934a9493d9e95570f5f

And in my regression testing with WCN6855 I see new warnings:

[  422.555328] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  434.892534] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  447.169512] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  459.707762] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  472.078881] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  484.371612] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  496.663938] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  508.928868] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  521.310941] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  533.859349] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  575.072067] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  594.171473] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  617.581248] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  637.003411] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  656.153840] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  675.210066] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  694.594334] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  714.122679] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!
[  733.506719] debugfs: File 'wmi_ctrl_stats' in directory 'netdev:wlan0' already present!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
