Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF335CE0B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 18:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbhDLQli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 12:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343640AbhDLQfi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 12:35:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61202613D5;
        Mon, 12 Apr 2021 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244822;
        bh=v2Bmv9jEbQZ9fm48hYxIBF/tzoR3B/lZaoJW5MiTlNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1zf/2/OEs88RfRniID64UqEXI3L7xYYXjO9HlJb1hZDsYwa+A+QnVjSjAuJmGDkM
         Jac61QvQxk/QzNRuSqxf63TLrDOMLe5HdgV9lfjP0ZvxX87r60Lea7M7R03bsHEIJu
         ZJ2Sc0EDjHrH9N2lfoPmDV8u3Pizt2BhW4LMyOVaBODyfbnpsZR2n/Pdzq+ZUPxBxv
         xgMcgEpyi0jB69F4TkgcC4+o0P/XYIq146tKBQSx57zU6tm1+EzCjEG4RvnXmQK4nz
         ukFXyjIaEo3Q7GNhErEBwwAs49EyESZ/RHNPYn32ZkdyH2hkprP530x1opU/OL11eU
         bfOEKmN9GJWOQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 24/25] mac80211: clear sta->fast_rx when STA removed from 4-addr VLAN
Date:   Mon, 12 Apr 2021 12:26:29 -0400
Message-Id: <20210412162630.315526-24-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162630.315526-1-sashal@kernel.org>
References: <20210412162630.315526-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

[ Upstream commit dd0b45538146cb6a54d6da7663b8c3afd16ebcfd ]

In some race conditions, with more clients and traffic configuration,
below crash is seen when making the interface down. sta->fast_rx wasn't
cleared when STA gets removed from 4-addr AP_VLAN interface. The crash is
due to try accessing 4-addr AP_VLAN interface's net_device (fast_rx->dev)
which has been deleted already.

Resolve this by clearing sta->fast_rx pointer when STA removes
from a 4-addr VLAN.

[  239.449529] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[  239.449531] pgd = 80204000
...
[  239.481496] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.60 #227
[  239.481591] Hardware name: Generic DT based system
[  239.487665] task: be05b700 ti: be08e000 task.ti: be08e000
[  239.492360] PC is at get_rps_cpu+0x2d4/0x31c
[  239.497823] LR is at 0xbe08fc54
...
[  239.778574] [<80739740>] (get_rps_cpu) from [<8073cb10>] (netif_receive_skb_internal+0x8c/0xac)
[  239.786722] [<8073cb10>] (netif_receive_skb_internal) from [<8073d578>] (napi_gro_receive+0x48/0xc4)
[  239.795267] [<8073d578>] (napi_gro_receive) from [<c7b83e8c>] (ieee80211_mark_rx_ba_filtered_frames+0xbcc/0x12d4 [mac80211])
[  239.804776] [<c7b83e8c>] (ieee80211_mark_rx_ba_filtered_frames [mac80211]) from [<c7b84d4c>] (ieee80211_rx_napi+0x7b8/0x8c8 [mac8
            0211])
[  239.815857] [<c7b84d4c>] (ieee80211_rx_napi [mac80211]) from [<c7f63d7c>] (ath11k_dp_process_rx+0x7bc/0x8c8 [ath11k])
[  239.827757] [<c7f63d7c>] (ath11k_dp_process_rx [ath11k]) from [<c7f5b6c4>] (ath11k_dp_service_srng+0x2c0/0x2e0 [ath11k])
[  239.838484] [<c7f5b6c4>] (ath11k_dp_service_srng [ath11k]) from [<7f55b7dc>] (ath11k_ahb_ext_grp_napi_poll+0x20/0x84 [ath11k_ahb]
            )
[  239.849419] [<7f55b7dc>] (ath11k_ahb_ext_grp_napi_poll [ath11k_ahb]) from [<8073ce1c>] (net_rx_action+0xe0/0x28c)
[  239.860945] [<8073ce1c>] (net_rx_action) from [<80324868>] (__do_softirq+0xe4/0x228)
[  239.871269] [<80324868>] (__do_softirq) from [<80324c48>] (irq_exit+0x98/0x108)
[  239.879080] [<80324c48>] (irq_exit) from [<8035c59c>] (__handle_domain_irq+0x90/0xb4)
[  239.886114] [<8035c59c>] (__handle_domain_irq) from [<8030137c>] (gic_handle_irq+0x50/0x94)
[  239.894100] [<8030137c>] (gic_handle_irq) from [<803024c0>] (__irq_svc+0x40/0x74)

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Link: https://lore.kernel.org/r/1616163532-3881-1-git-send-email-seevalam@codeaurora.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0563bde0c285..3b3ed96c19e5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1536,8 +1536,10 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		}
 
 		if (sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN &&
-		    sta->sdata->u.vlan.sta)
+		    sta->sdata->u.vlan.sta) {
+			ieee80211_clear_fast_rx(sta);
 			RCU_INIT_POINTER(sta->sdata->u.vlan.sta, NULL);
+		}
 
 		if (test_sta_flag(sta, WLAN_STA_AUTHORIZED))
 			ieee80211_vif_dec_num_mcast(sta->sdata);
-- 
2.30.2

