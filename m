Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51855444687
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 18:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhKCRFd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 13:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232969AbhKCRFc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 13:05:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E44061076;
        Wed,  3 Nov 2021 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635958976;
        bh=ouZxH/WMfEySjTKcEt1l/NLz/qWghGiiimiV9ls89kI=;
        h=From:To:Cc:Subject:Date:From;
        b=UeUDiGNv38f3TyH3QaLaJ7vxURycTa4EoDIiOWE4APDHgTIHvKWi0ikLIzVJcggZC
         0EFBfEDA+WjKx2Gq7BR2krg+0/Ep+E6Xaa5wGgrP+U7GN1HapSzJyMv4a3AB3V0RTl
         jbfrrCr/X0FNyTbugLQqVK2ef0XR2fC0pkoNMY98UGgEXdTxM1AIBbSUt3sDoGJ8U3
         Ujo2NPkRaODCLJ8vFizX3rVdW0ZZb3V58xR3xqU9bJI7wZcD97wk2J/hdE6jroG8Xl
         leBp0tmLJXkpAQimylYSlp8C9ecYcuf1SS3tqts9m0nk81jrtrht9tLdBG0QsjnDru
         L5MxH370ufamw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH mac80211-next] cfg80211: fix possible NULL pointer dereference in cfg80211_stop_offchan_radar_detection
Date:   Wed,  3 Nov 2021 18:02:35 +0100
Message-Id: <c2e34c065bf8839c5ffa45498ae154021a72a520.1635958796.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following NULL pointer dereference in
cfg80211_stop_offchan_radar_detection routine that occurs when hostapd
is stopped during the CAC on offchannel chain:

Sat Jan  1 0[  779.567851]   ESR = 0x96000005
0:12:50 2000 dae[  779.572346]   EC = 0x25: DABT (current EL), IL = 32 bits
mon.debug hostap[  779.578984]   SET = 0, FnV = 0
d: hostapd_inter[  779.583445]   EA = 0, S1PTW = 0
face_deinit_free[  779.587936] Data abort info:
: num_bss=1 conf[  779.592224]   ISV = 0, ISS = 0x00000005
->num_bss=1
Sat[  779.597403]   CM = 0, WnR = 0
 Jan  1 00:12:50[  779.601749] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000418b2000
 2000 daemon.deb[  779.609601] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
ug hostapd: host[  779.619657] Internal error: Oops: 96000005 [#1] SMP
[  779.770810] CPU: 0 PID: 2202 Comm: hostapd Not tainted 5.10.75 #0
[  779.776892] Hardware name: MediaTek MT7622 RFB1 board (DT)
[  779.782370] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[  779.788384] pc : cfg80211_chandef_valid+0x10/0x490 [cfg80211]
[  779.794128] lr : cfg80211_check_station_change+0x3190/0x3950 [cfg80211]
[  779.800731] sp : ffffffc01204b7e0
[  779.804036] x29: ffffffc01204b7e0 x28: ffffff80039bdc00
[  779.809340] x27: 0000000000000000 x26: ffffffc008cb3050
[  779.814644] x25: 0000000000000000 x24: 0000000000000002
[  779.819948] x23: ffffff8002630000 x22: ffffff8003e748d0
[  779.825252] x21: 0000000000000cc0 x20: ffffff8003da4a00
[  779.830556] x19: 0000000000000000 x18: ffffff8001bf7ce0
[  779.835860] x17: 00000000ffffffff x16: 0000000000000000
[  779.841164] x15: 0000000040d59200 x14: 00000000000019c0
[  779.846467] x13: 00000000000001c8 x12: 000636b9e9dab1c6
[  779.851771] x11: 0000000000000141 x10: 0000000000000820
[  779.857076] x9 : 0000000000000000 x8 : ffffff8003d7d038
[  779.862380] x7 : 0000000000000000 x6 : ffffff8003d7d038
[  779.867683] x5 : 0000000000000e90 x4 : 0000000000000038
[  779.872987] x3 : 0000000000000002 x2 : 0000000000000004
[  779.878291] x1 : 0000000000000000 x0 : 0000000000000000
[  779.883594] Call trace:
[  779.886039]  cfg80211_chandef_valid+0x10/0x490 [cfg80211]
[  779.891434]  cfg80211_check_station_change+0x3190/0x3950 [cfg80211]
[  779.897697]  nl80211_radar_notify+0x138/0x19c [cfg80211]
[  779.903005]  cfg80211_stop_offchan_radar_detection+0x7c/0x8c [cfg80211]
[  779.909616]  __cfg80211_leave+0x2c/0x190 [cfg80211]
[  779.914490]  cfg80211_register_netdevice+0x1c0/0x6d0 [cfg80211]
[  779.920404]  raw_notifier_call_chain+0x50/0x70
[  779.924841]  call_netdevice_notifiers_info+0x54/0xa0
[  779.929796]  __dev_close_many+0x40/0x100
[  779.933712]  __dev_change_flags+0x98/0x190
[  779.937800]  dev_change_flags+0x20/0x60
[  779.941628]  devinet_ioctl+0x534/0x6d0
[  779.945370]  inet_ioctl+0x1bc/0x230
[  779.948849]  sock_do_ioctl+0x44/0x200
[  779.952502]  sock_ioctl+0x268/0x4c0
[  779.955985]  __arm64_sys_ioctl+0xac/0xd0
[  779.959900]  el0_svc_common.constprop.0+0x60/0x110
[  779.964682]  do_el0_svc+0x1c/0x24
[  779.967990]  el0_svc+0x10/0x1c
[  779.971036]  el0_sync_handler+0x9c/0x120
[  779.974950]  el0_sync+0x148/0x180
[  779.978259] Code: a9bc7bfd 910003fd a90153f3 aa0003f3 (f9400000)
[  779.984344] ---[ end trace 0e67b4f5d6cdeec7 ]---
[  779.996400] Kernel panic - not syncing: Oops: Fatal exception
[  780.002139] SMP: stopping secondary CPUs
[  780.006057] Kernel Offset: disabled
[  780.009537] CPU features: 0x0000002,04002004
[  780.013796] Memory Limit: none

Fixes: b8f5facf286b ("cfg80211: implement APIs for dedicated radar detection HW")
Reported-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Tested-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/wireless/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index abf81e71210a..472f63a45dd6 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -980,6 +980,9 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 
 	lockdep_assert_wiphy(&rdev->wiphy);
 
+	if (!cfg80211_chandef_valid(chandef))
+		return;
+
 	if (event != NL80211_RADAR_CAC_STARTED && !rdev->offchan_radar_wdev)
 		return;
 
@@ -1094,6 +1097,6 @@ void cfg80211_stop_offchan_radar_detection(struct wireless_dev *wdev)
 
 	rdev_set_radar_offchan(rdev, NULL);
 
-	__cfg80211_offchan_cac_event(rdev, NULL, NULL,
+	__cfg80211_offchan_cac_event(rdev, wdev, &rdev->offchan_radar_chandef,
 				     NL80211_RADAR_CAC_ABORTED);
 }
-- 
2.31.1

