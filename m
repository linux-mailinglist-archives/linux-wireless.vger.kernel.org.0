Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C534726B9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 10:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhLMJyF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 04:54:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42666 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbhLMJvt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 04:51:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0208CE0E80
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27958C341C5;
        Mon, 13 Dec 2021 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639389106;
        bh=yRm83xXxfcU/dQJ2h5jdDPCw/PVTMP6hBA7A7rEJzV4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TpMcaRGVQfj9GQNCtqhLOKgcWxD0I/XRAtuxhFbvAC/2zJ6Tg+TgKp/f2fDNEHuIF
         h1AcWivp7kDKfhuZ+jPN5+iSO5XT/16NkxF/bbcpW5ucv3pXfcNX87geb9QlSlue0a
         m85YPO2lUTFU+WMIRpW1t/ZOSfa1dHZ9gLcQao+5EyDPIS01WGUX3FGNijaYR4Aj0z
         TCMZyWZhUkDKbJzEYXc6BfrHw3dYglzIAecegSWbPp1moTLxT8LOcCNHFbKJzzdz6+
         8PZMmyF1cGbETAh4QrgNnZSc3LgWlmMwenkVr9czNDVmM4Xi543i7wUUMj/dKom1kZ
         pdr7RJXpAx9tw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix deleting uninitialized kernel timer during
 fragment cache flush
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1639071421-25078-1-git-send-email-quic_ramess@quicinc.com>
References: <1639071421-25078-1-git-send-email-quic_ramess@quicinc.com>
To:     Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163938910316.20609.2975285660545540570.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 09:51:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rameshkumar Sundaram <quic_ramess@quicinc.com> wrote:

> frag_timer will be created & initialized for stations when
> they associate and will be deleted during every key installation
> while flushing old fragments.
> 
> For AP interface self peer will be created and Group keys
> will be installed for this peer, but there will be no real
> Station entry & hence frag_timer won't be created and
> initialized, deleting such uninitialized kernel timers causes below
> warnings and backtraces printed with CONFIG_DEBUG_OBJECTS_TIMERS
> enabled.
> 
> [ 177.828008] ODEBUG: assert_init not available (active state 0) object type: timer_list hint: 0x0
> [ 177.836833] WARNING: CPU: 3 PID: 188 at lib/debugobjects.c:508 debug_print_object+0xb0/0xf0
> [ 177.845185] Modules linked in: ath11k_pci ath11k qmi_helpers qrtr_mhi qrtr ns mhi
> [ 177.852679] CPU: 3 PID: 188 Comm: hostapd Not tainted 5.14.0-rc3-32919-g4034139e1838-dirty #14
> [ 177.865805] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [ 177.871804] pc : debug_print_object+0xb0/0xf0
> [ 177.876155] lr : debug_print_object+0xb0/0xf0
> [ 177.880505] sp : ffffffc01169b5a0
> [ 177.883810] x29: ffffffc01169b5a0 x28: ffffff80081c2320 x27: ffffff80081c4078
> [ 177.890942] x26: ffffff8003fe8f28 x25: ffffff8003de9890 x24: ffffffc01134d738
> [ 177.898075] x23: ffffffc010948f20 x22: ffffffc010b2d2e0 x21: ffffffc01169b628
> [ 177.905206] x20: ffffffc01134d700 x19: ffffffc010c80d98 x18: 00000000000003f6
> [ 177.912339] x17: 203a657079742074 x16: 63656a626f202930 x15: 0000000000000152
> [ 177.919471] x14: 0000000000000152 x13: 00000000ffffffea x12: ffffffc010d732e0
> [ 177.926603] x11: 0000000000000003 x10: ffffffc010d432a0 x9 : ffffffc010d432f8
> [ 177.933735] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 0000000000000001
> [ 177.940866] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
> [ 177.947997] x2 : ffffffc010c93240 x1 : ffffff80023624c0 x0 : 0000000000000054
> [ 177.955130] Call trace:
> [ 177.957567] debug_print_object+0xb0/0xf0
> [ 177.961570] debug_object_assert_init+0x124/0x178
> [ 177.966269] try_to_del_timer_sync+0x1c/0x70
> [ 177.970536] del_timer_sync+0x30/0x50
> [ 177.974192] ath11k_peer_frags_flush+0x34/0x68 [ath11k]
> [ 177.979439] ath11k_mac_op_set_key+0x1e4/0x338 [ath11k]
> [ 177.984673] ieee80211_key_enable_hw_accel+0xc8/0x3d0
> [ 177.989722] ieee80211_key_replace+0x360/0x740
> [ 177.994160] ieee80211_key_link+0x16c/0x210
> [ 177.998337] ieee80211_add_key+0x138/0x338
> [ 178.002426] nl80211_new_key+0xfc/0x258
> [ 178.006257] genl_family_rcv_msg_doit.isra.17+0xd8/0x120
> [ 178.011565] genl_rcv_msg+0xd8/0x1c8
> [ 178.015134] netlink_rcv_skb+0x38/0xf8
> [ 178.018877] genl_rcv+0x34/0x48
> [ 178.022012] netlink_unicast+0x174/0x230
> [ 178.025928] netlink_sendmsg+0x188/0x388
> [ 178.029845] ____sys_sendmsg+0x218/0x250
> [ 178.033763] ___sys_sendmsg+0x68/0x90
> [ 178.037418] __sys_sendmsg+0x44/0x88
> [ 178.040988] __arm64_sys_sendmsg+0x20/0x28
> [ 178.045077] invoke_syscall.constprop.5+0x54/0xe0
> [ 178.049776] do_el0_svc+0x74/0xc0
> [ 178.053084] el0_svc+0x10/0x18
> [ 178.056133] el0t_64_sync_handler+0x88/0xb0
> [ 178.060310] el0t_64_sync+0x148/0x14c
> [ 178.063966] ---[ end trace 8a5cf0bf9d34a058 ]---
> 
> Add changes to not to delete frag timer for peers during
> group key installation.
> 
> Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01092-QCAHKSWPL_SILICONZ-1
> 
> Fixes: c3944a562102 ("ath11k: Clear the fragment cache during key install")
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

ba53ee7f7f38 ath11k: Fix deleting uninitialized kernel timer during fragment cache flush

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1639071421-25078-1-git-send-email-quic_ramess@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

