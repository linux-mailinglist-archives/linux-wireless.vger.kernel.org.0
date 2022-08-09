Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CA58D39C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiHIGQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiHIGQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 02:16:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4EE1F608
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 23:16:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E932611DC
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 06:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B181C433C1;
        Tue,  9 Aug 2022 06:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660025779;
        bh=TGchnS6BkA6p6sFkGmCoUx5L9X5+8rZ1CbWWD6TQ7iQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KFrVZVSpkjMG3fRbYJl7u65RUpxYEY3dgt0ZMnaMTHkeqf1BCIROTa7ch6oTW7xaa
         flmqYS6x77MrFfU2Nn+f2QGlVx6rY6jMAar6PGhHCkehJAxqnslQn4E9a076Ji2dyY
         EvtT29v7URRo8+TjN2jJU+dYDUI5N9zAyIVURu3q3e0sq2MgiVR/x3v6+MEY5ijpvz
         e6gUxmX6L3gbJsq1bUhJY+e9toxL2o6a+mAIaRvV/72C3HqyrrH6ZEuiHifgy1G/fS
         RE+lKRHjnuUKb8zq4nGjdePFk7ItiuBD0TArsQm+nYueOrzC1M6Jz/nbAPz4zlaBPX
         QzLZaU5jsmXWg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: add peer map clean up for peer delete in
 ath10k_sta_state()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220801141930.16794-1-quic_wgong@quicinc.com>
References: <20220801141930.16794-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166002577637.17823.4403860593680632775.kvalo@kernel.org>
Date:   Tue,  9 Aug 2022 06:16:17 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When peer delete failed in a disconnect operation, use-after-free
> detected by KFENCE in below log. It is because for each vdev_id and
> address, it has only one struct ath10k_peer, it is allocated in
> ath10k_peer_map_event(). When connected to an AP, it has more than
> one HTT_T2H_MSG_TYPE_PEER_MAP reported from firmware, then the
> array peer_map of struct ath10k will be set muti-elements to the
> same ath10k_peer in ath10k_peer_map_event(). When peer delete failed
> in ath10k_sta_state(), the ath10k_peer will be free for the 1st peer
> id in array peer_map of struct ath10k, and then use-after-free happened
> for the 2nd peer id because they map to the same ath10k_peer.
> 
> And clean up all peers in array peer_map for the ath10k_peer, then
> user-after-free disappeared
> 
> peer map event log:
> [  306.911021] wlan0: authenticate with b0:2a:43:e6:75:0e
> [  306.957187] ath10k_pci 0000:01:00.0: mac vdev 0 peer create b0:2a:43:e6:75:0e (new sta) sta 1 / 32 peer 1 / 33
> [  306.957395] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 246
> [  306.957404] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 198
> [  306.986924] ath10k_pci 0000:01:00.0: htt peer map vdev 0 peer b0:2a:43:e6:75:0e id 166
> 
> peer unmap event log:
> [  435.715691] wlan0: deauthenticating from b0:2a:43:e6:75:0e by local choice (Reason: 3=DEAUTH_LEAVING)
> [  435.716802] ath10k_pci 0000:01:00.0: mac vdev 0 peer delete b0:2a:43:e6:75:0e sta ffff990e0e9c2b50 (sta gone)
> [  435.717177] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 246
> [  435.717186] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 198
> [  435.717193] ath10k_pci 0000:01:00.0: htt peer unmap vdev 0 peer b0:2a:43:e6:75:0e id 166
> 
> use-after-free log:
> [21705.888627] wlan0: deauthenticating from d0:76:8f:82:be:75 by local choice (Reason: 3=DEAUTH_LEAVING)
> [21713.799910] ath10k_pci 0000:01:00.0: failed to delete peer d0:76:8f:82:be:75 for vdev 0: -110
> [21713.799925] ath10k_pci 0000:01:00.0: found sta peer d0:76:8f:82:be:75 (ptr 0000000000000000 id 102) entry on vdev 0 after it was supposedly removed
> [21713.799968] ==================================================================
> [21713.799991] BUG: KFENCE: use-after-free read in ath10k_sta_state+0x265/0xb8a [ath10k_core]
> [21713.799991]
> [21713.799997] Use-after-free read at 0x00000000abe1c75e (in kfence-#69):
> [21713.800010]  ath10k_sta_state+0x265/0xb8a [ath10k_core]
> [21713.800041]  drv_sta_state+0x115/0x677 [mac80211]
> [21713.800059]  __sta_info_destroy_part2+0xb1/0x133 [mac80211]
> [21713.800076]  __sta_info_flush+0x11d/0x162 [mac80211]
> [21713.800093]  ieee80211_set_disassoc+0x12d/0x2f4 [mac80211]
> [21713.800110]  ieee80211_mgd_deauth+0x26c/0x29b [mac80211]
> [21713.800137]  cfg80211_mlme_deauth+0x13f/0x1bb [cfg80211]
> [21713.800153]  nl80211_deauthenticate+0xf8/0x121 [cfg80211]
> [21713.800161]  genl_rcv_msg+0x38e/0x3be
> [21713.800166]  netlink_rcv_skb+0x89/0xf7
> [21713.800171]  genl_rcv+0x28/0x36
> [21713.800176]  netlink_unicast+0x179/0x24b
> [21713.800181]  netlink_sendmsg+0x3a0/0x40e
> [21713.800187]  sock_sendmsg+0x72/0x76
> [21713.800192]  ____sys_sendmsg+0x16d/0x1e3
> [21713.800196]  ___sys_sendmsg+0x95/0xd1
> [21713.800200]  __sys_sendmsg+0x85/0xbf
> [21713.800205]  do_syscall_64+0x43/0x55
> [21713.800210]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [21713.800213]
> [21713.800219] kfence-#69: 0x000000009149b0d5-0x000000004c0697fb, size=1064, cache=kmalloc-2k
> [21713.800219]
> [21713.800224] allocated by task 13 on cpu 0 at 21705.501373s:
> [21713.800241]  ath10k_peer_map_event+0x7e/0x154 [ath10k_core]
> [21713.800254]  ath10k_htt_t2h_msg_handler+0x586/0x1039 [ath10k_core]
> [21713.800265]  ath10k_htt_htc_t2h_msg_handler+0x12/0x28 [ath10k_core]
> [21713.800277]  ath10k_htc_rx_completion_handler+0x14c/0x1b5 [ath10k_core]
> [21713.800283]  ath10k_pci_process_rx_cb+0x195/0x1df [ath10k_pci]
> [21713.800294]  ath10k_ce_per_engine_service+0x55/0x74 [ath10k_core]
> [21713.800305]  ath10k_ce_per_engine_service_any+0x76/0x84 [ath10k_core]
> [21713.800310]  ath10k_pci_napi_poll+0x49/0x144 [ath10k_pci]
> [21713.800316]  net_rx_action+0xdc/0x361
> [21713.800320]  __do_softirq+0x163/0x29a
> [21713.800325]  asm_call_irq_on_stack+0x12/0x20
> [21713.800331]  do_softirq_own_stack+0x3c/0x48
> [21713.800337]  __irq_exit_rcu+0x9b/0x9d
> [21713.800342]  common_interrupt+0xc9/0x14d
> [21713.800346]  asm_common_interrupt+0x1e/0x40
> [21713.800351]  ksoftirqd_should_run+0x5/0x16
> [21713.800357]  smpboot_thread_fn+0x148/0x211
> [21713.800362]  kthread+0x150/0x15f
> [21713.800367]  ret_from_fork+0x22/0x30
> [21713.800370]
> [21713.800374] freed by task 708 on cpu 1 at 21713.799953s:
> [21713.800498]  ath10k_sta_state+0x2c6/0xb8a [ath10k_core]
> [21713.800515]  drv_sta_state+0x115/0x677 [mac80211]
> [21713.800532]  __sta_info_destroy_part2+0xb1/0x133 [mac80211]
> [21713.800548]  __sta_info_flush+0x11d/0x162 [mac80211]
> [21713.800565]  ieee80211_set_disassoc+0x12d/0x2f4 [mac80211]
> [21713.800581]  ieee80211_mgd_deauth+0x26c/0x29b [mac80211]
> [21713.800598]  cfg80211_mlme_deauth+0x13f/0x1bb [cfg80211]
> [21713.800614]  nl80211_deauthenticate+0xf8/0x121 [cfg80211]
> [21713.800619]  genl_rcv_msg+0x38e/0x3be
> [21713.800623]  netlink_rcv_skb+0x89/0xf7
> [21713.800628]  genl_rcv+0x28/0x36
> [21713.800632]  netlink_unicast+0x179/0x24b
> [21713.800637]  netlink_sendmsg+0x3a0/0x40e
> [21713.800642]  sock_sendmsg+0x72/0x76
> [21713.800646]  ____sys_sendmsg+0x16d/0x1e3
> [21713.800651]  ___sys_sendmsg+0x95/0xd1
> [21713.800655]  __sys_sendmsg+0x85/0xbf
> [21713.800659]  do_syscall_64+0x43/0x55
> [21713.800663]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> 
> Fixes: d0eeafad1189 ("ath10k: Clean up peer when sta goes away.")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f020d9570a04 wifi: ath10k: add peer map clean up for peer delete in ath10k_sta_state()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220801141930.16794-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

