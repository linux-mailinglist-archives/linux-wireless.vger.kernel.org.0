Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47571103F9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 19:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLCSG7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 13:06:59 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:45283 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfLCSG6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 13:06:58 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 5A0F058007F;
        Tue,  3 Dec 2019 19:06:56 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mac80211: mesh: only warn if mesh peering is established
Date:   Tue,  3 Dec 2019 19:06:44 +0100
Message-Id: <20191203180644.70653-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following warning is triggered every time an unestablished mesh peer
gets dumped. This patch checks, if a peer link is established, when dum-
ping the airtime link metric.

[ 9563.022567] WARNING: CPU: 0 PID: 6287 at net/mac80211/mesh_hwmp.c:345
               airtime_link_metric_get+0xa2/0xb0 [mac80211]
[ 9563.022697] Hardware name: PC Engines apu2/apu2, BIOS v4.10.0.3
[ 9563.022756] RIP: 0010:airtime_link_metric_get+0xa2/0xb0 [mac80211]
[ 9563.022838] Call Trace:
[ 9563.022897]  sta_set_sinfo+0x936/0xa10 [mac80211]
[ 9563.022964]  ieee80211_dump_station+0x6d/0x90 [mac80211]
[ 9563.023062]  nl80211_dump_station+0x154/0x2a0 [cfg80211]
[ 9563.023120]  netlink_dump+0x17b/0x370
[ 9563.023130]  netlink_recvmsg+0x2a4/0x480
[ 9563.023140]  ____sys_recvmsg+0xa6/0x160
[ 9563.023154]  ___sys_recvmsg+0x93/0xe0
[ 9563.023169]  __sys_recvmsg+0x7e/0xd0
[ 9563.023210]  do_syscall_64+0x4e/0x140
[ 9563.023217]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/mesh_hwmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 68af62306385..d69983370381 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -328,6 +328,9 @@ u32 airtime_link_metric_get(struct ieee80211_local *local,
 	unsigned long fail_avg =
 		ewma_mesh_fail_avg_read(&sta->mesh->fail_avg);
 
+	if (sta->mesh->plink_state != NL80211_PLINK_ESTAB)
+		return MAX_METRIC;
+
 	/* Try to get rate based on HW/SW RC algorithm.
 	 * Rate is returned in units of Kbps, correct this
 	 * to comply with airtime calculation units
-- 
2.24.0

