Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1353B46F231
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243111AbhLIRkt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 12:40:49 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15909 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243110AbhLIRks (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 12:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639071435; x=1670607435;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=cnKC6v3RwzfsPigqhU8z9kF/y8ptdbENxJwfN3gN1wg=;
  b=IGD0SROPQeHjbTbQUqkCQj3Oe5WSn09pdcnt5fIeJrucGvqQaaS6ys7Y
   c3Rqtlw5AVg7OmosOulG62LKqx//QOLnTgmD3C3WB3x124Yd2zdoEPHi9
   M2e0iqzNNpH5mEDhNl3qdzayRBRt4sJ5+0EoU5e1YZSvfP5mrqzR3jIUU
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Dec 2021 09:37:15 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:37:15 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 09:37:14 -0800
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 09:37:12 -0800
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH] ath11k: Fix deleting uninitialized kernel timer during fragment cache flush
Date:   Thu, 9 Dec 2021 23:07:01 +0530
Message-ID: <1639071421-25078-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

frag_timer will be created & initialized for stations when
they associate and will be deleted during every key installation
while flushing old fragments.

For AP interface self peer will be created and Group keys
will be installed for this peer, but there will be no real
Station entry & hence frag_timer won't be created and
initialized, deleting such uninitialized kernel timers causes below
warnings and backtraces printed with CONFIG_DEBUG_OBJECTS_TIMERS
enabled.

[ 177.828008] ODEBUG: assert_init not available (active state 0) object type: timer_list hint: 0x0
[ 177.836833] WARNING: CPU: 3 PID: 188 at lib/debugobjects.c:508 debug_print_object+0xb0/0xf0
[ 177.845185] Modules linked in: ath11k_pci ath11k qmi_helpers qrtr_mhi qrtr ns mhi
[ 177.852679] CPU: 3 PID: 188 Comm: hostapd Not tainted 5.14.0-rc3-32919-g4034139e1838-dirty #14
[ 177.865805] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[ 177.871804] pc : debug_print_object+0xb0/0xf0
[ 177.876155] lr : debug_print_object+0xb0/0xf0
[ 177.880505] sp : ffffffc01169b5a0
[ 177.883810] x29: ffffffc01169b5a0 x28: ffffff80081c2320 x27: ffffff80081c4078
[ 177.890942] x26: ffffff8003fe8f28 x25: ffffff8003de9890 x24: ffffffc01134d738
[ 177.898075] x23: ffffffc010948f20 x22: ffffffc010b2d2e0 x21: ffffffc01169b628
[ 177.905206] x20: ffffffc01134d700 x19: ffffffc010c80d98 x18: 00000000000003f6
[ 177.912339] x17: 203a657079742074 x16: 63656a626f202930 x15: 0000000000000152
[ 177.919471] x14: 0000000000000152 x13: 00000000ffffffea x12: ffffffc010d732e0
[ 177.926603] x11: 0000000000000003 x10: ffffffc010d432a0 x9 : ffffffc010d432f8
[ 177.933735] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 0000000000000001
[ 177.940866] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
[ 177.947997] x2 : ffffffc010c93240 x1 : ffffff80023624c0 x0 : 0000000000000054
[ 177.955130] Call trace:
[ 177.957567] debug_print_object+0xb0/0xf0
[ 177.961570] debug_object_assert_init+0x124/0x178
[ 177.966269] try_to_del_timer_sync+0x1c/0x70
[ 177.970536] del_timer_sync+0x30/0x50
[ 177.974192] ath11k_peer_frags_flush+0x34/0x68 [ath11k]
[ 177.979439] ath11k_mac_op_set_key+0x1e4/0x338 [ath11k]
[ 177.984673] ieee80211_key_enable_hw_accel+0xc8/0x3d0
[ 177.989722] ieee80211_key_replace+0x360/0x740
[ 177.994160] ieee80211_key_link+0x16c/0x210
[ 177.998337] ieee80211_add_key+0x138/0x338
[ 178.002426] nl80211_new_key+0xfc/0x258
[ 178.006257] genl_family_rcv_msg_doit.isra.17+0xd8/0x120
[ 178.011565] genl_rcv_msg+0xd8/0x1c8
[ 178.015134] netlink_rcv_skb+0x38/0xf8
[ 178.018877] genl_rcv+0x34/0x48
[ 178.022012] netlink_unicast+0x174/0x230
[ 178.025928] netlink_sendmsg+0x188/0x388
[ 178.029845] ____sys_sendmsg+0x218/0x250
[ 178.033763] ___sys_sendmsg+0x68/0x90
[ 178.037418] __sys_sendmsg+0x44/0x88
[ 178.040988] __arm64_sys_sendmsg+0x20/0x28
[ 178.045077] invoke_syscall.constprop.5+0x54/0xe0
[ 178.049776] do_el0_svc+0x74/0xc0
[ 178.053084] el0_svc+0x10/0x18
[ 178.056133] el0t_64_sync_handler+0x88/0xb0
[ 178.060310] el0t_64_sync+0x148/0x14c
[ 178.063966] ---[ end trace 8a5cf0bf9d34a058 ]---

Add changes to not to delete frag timer for peers during
group key installation.

Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01092-QCAHKSWPL_SILICONZ-1

Fixes: c3944a562102 ("ath11k: Clear the fragment cache during key install")
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 71d8796..9e3cb32a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2837,7 +2837,7 @@ static int ath11k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	/* flush the fragments cache during key (re)install to
 	 * ensure all frags in the new frag list belong to the same key.
 	 */
-	if (peer && cmd == SET_KEY)
+	if (peer && sta && cmd == SET_KEY)
 		ath11k_peer_frags_flush(ar, peer);
 	spin_unlock_bh(&ab->base_lock);
 
-- 
2.7.4

