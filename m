Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0FE47B0D3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 17:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhLTQFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 11:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhLTQFl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 11:05:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABDBC061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 08:05:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87ADD61216
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 16:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE315C36AE7;
        Mon, 20 Dec 2021 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640016339;
        bh=S7sK97so3kfnMyFom1Q4VY8R6f2iw/t8cpeVtlAbxV8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=o/9FUzrWVy5ZX1TYAkvc8bxxyMA2blPaIlAddgqDMjDFWav/JAaom656VICU7RFiX
         dDJtQ6cuTpYw6zoIrJgFqcVFYR+JNdHMK4RqhXPhaT0GWOoc3YYXz4+Kh/YzebtYXJ
         KSyQHr8UepKdscbrIbG1pgjNxpcqRzhyTDLHBewKPxWf6UVijD/szG8hzhi/+ihTI4
         CnwDYkmAIPRkREyUkxiGAQfd8XFdmFCHOIHfHff6MgkSrRMQlq/J6Hdr8bgAn6cQuD
         zZ6wWyTNjLOgPqHjdxkrDsd/kAiPji3JZ/oOo/AqNm12wY1N+/atDYCoRSORM6L2Qf
         U9xj+vGxalRLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6] ath11k: report rssi of each chain to mac80211 for
 QCA6390/WCN6855
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211215090944.19729-1-quic_wgong@quicinc.com>
References: <20211215090944.19729-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164001633723.2023.743892704725312742.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 16:05:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> Command "iw wls1 station dump" does not show each chain's rssi currently.
> 
> If the rssi of each chain from mon status which parsed in function
> ath11k_hal_rx_parse_mon_status_tlv() is invalid, then ath11k send
> wmi cmd WMI_REQUEST_STATS_CMDID with flag WMI_REQUEST_RSSI_PER_CHAIN_STAT
> to firmware, and parse the rssi of chain in wmi WMI_UPDATE_STATS_EVENTID,
> then report them to mac80211.
> 
> WMI_REQUEST_STATS_CMDID is only sent when CONFIG_ATH11K_DEBUGFS is set,
> it is only called by ath11k_mac_op_sta_statistics(). It does not effect
> performance and power consumption. Because after STATION connected to
> AP, it is only called every 6 seconds by NetworkManager in below stack.
> 
> [  797.005587] CPU: 0 PID: 701 Comm: NetworkManager Tainted: G        W  OE     5.13.0-rc6-wt-ath+ #2
> [  797.005596] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW (1.33 ) 07/29/2011
> [  797.005600] RIP: 0010:ath11k_mac_op_sta_statistics+0x2f/0x1b0 [ath11k]
> [  797.005644] Code: 41 56 41 55 4c 8d aa 58 01 00 00 41 54 55 48 89 d5 53 48 8b 82 58 01 00 00 48 89 cb 4c 8b 70 20 49 8b 06 4c 8b a0 90 08 00 00 <0f> 0b 48 8b 82 b8 01 00 00 48 ba 00 00 00 00 01 00 00 00 48 89 81
> [  797.005651] RSP: 0018:ffffb1fc80a4b890 EFLAGS: 00010282
> [  797.005658] RAX: ffff8a5726200000 RBX: ffffb1fc80a4b958 RCX: ffffb1fc80a4b958
> [  797.005664] RDX: ffff8a5726a609f0 RSI: ffff8a581247f598 RDI: ffff8a5702878800
> [  797.005668] RBP: ffff8a5726a609f0 R08: 0000000000000000 R09: 0000000000000000
> [  797.005672] R10: 0000000000000000 R11: 0000000000000007 R12: 02dd68024f75f480
> [  797.005676] R13: ffff8a5726a60b48 R14: ffff8a5702879f40 R15: ffff8a5726a60000
> [  797.005681] FS:  00007f632c52a380(0000) GS:ffff8a583a200000(0000) knlGS:0000000000000000
> [  797.005687] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  797.005692] CR2: 00007fb025d69000 CR3: 00000001124f6005 CR4: 00000000000606f0
> [  797.005698] Call Trace:
> [  797.005710]  sta_set_sinfo+0xa7/0xb80 [mac80211]
> [  797.005820]  ieee80211_get_station+0x50/0x70 [mac80211]
> [  797.005925]  nl80211_get_station+0xd1/0x200 [cfg80211]
> [  797.006045]  genl_family_rcv_msg_doit.isra.15+0x111/0x140
> [  797.006059]  genl_rcv_msg+0xe6/0x1e0
> [  797.006065]  ? nl80211_dump_station+0x220/0x220 [cfg80211]
> [  797.006223]  ? nl80211_send_station.isra.72+0xf50/0xf50 [cfg80211]
> [  797.006348]  ? genl_family_rcv_msg_doit.isra.15+0x140/0x140
> [  797.006355]  netlink_rcv_skb+0xb9/0xf0
> [  797.006363]  genl_rcv+0x24/0x40
> [  797.006369]  netlink_unicast+0x18e/0x290
> [  797.006375]  netlink_sendmsg+0x30f/0x450
> [  797.006382]  sock_sendmsg+0x5b/0x60
> [  797.006393]  ____sys_sendmsg+0x219/0x240
> [  797.006403]  ? copy_msghdr_from_user+0x5c/0x90
> [  797.006413]  ? ____sys_recvmsg+0xf5/0x190
> [  797.006422]  ___sys_sendmsg+0x88/0xd0
> [  797.006432]  ? copy_msghdr_from_user+0x5c/0x90
> [  797.006443]  ? ___sys_recvmsg+0x9e/0xd0
> [  797.006454]  ? __fget_files+0x58/0x90
> [  797.006461]  ? __fget_light+0x2d/0x70
> [  797.006466]  ? do_epoll_wait+0xce/0x720
> [  797.006476]  ? __sys_sendmsg+0x63/0xa0
> [  797.006485]  __sys_sendmsg+0x63/0xa0
> [  797.006497]  do_syscall_64+0x3c/0xb0
> [  797.006509]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  797.006519] RIP: 0033:0x7f632d99912d
> [  797.006526] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 ca ee ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2f 44 89 c7 48 89 44 24 08 e8 fe ee ff ff 48
> [  797.006533] RSP: 002b:00007ffd80808c00 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> [  797.006540] RAX: ffffffffffffffda RBX: 0000563dab99d840 RCX: 00007f632d99912d
> [  797.006545] RDX: 0000000000000000 RSI: 00007ffd80808c50 RDI: 000000000000000b
> [  797.006549] RBP: 00007ffd80808c50 R08: 0000000000000000 R09: 0000000000001000
> [  797.006552] R10: 0000563dab96f010 R11: 0000000000000293 R12: 0000563dab99d840
> [  797.006556] R13: 0000563dabbb28c0 R14: 00007f632dad4280 R15: 0000563dabab11c0
> [  797.006563] ---[ end trace c9dcf08920c9945c ]---
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01230-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

b488c766442f ath11k: report rssi of each chain to mac80211 for QCA6390/WCN6855

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211215090944.19729-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

