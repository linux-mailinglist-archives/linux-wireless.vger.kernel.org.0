Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E31341F35
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 15:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCSOTX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 10:19:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31790 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhCSOTO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 10:19:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616163554; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WsOiJQjmC4fDw2hXy61yxxYyAHz+rEqV3lSkTR0Mc4c=; b=hY6VZREroaZozGOgg3++bl0Ac1Wb5Ia0MKC/kZ3LEkqujnKWa6uCtOHPmX0ERYuxru4ccwnU
 khHXVCGa/luSqJr3Q4IZ7OxC19PB/uhOcEK9RXHMeHpVfqGw1SHLJwO7g73o4pm/2sPsdhwM
 T74xZTn1zKTYwlVUFl02TEhNgBA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6054b2d921031618f681ea49 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Mar 2021 14:19:05
 GMT
Sender: seevalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7CC1EC43461; Fri, 19 Mar 2021 14:19:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from seevalam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 981C3C433CA;
        Fri, 19 Mar 2021 14:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 981C3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=seevalam@codeaurora.org
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>
Subject: [PATCH] mac80211: clear sta->fast_rx when STA removed from 4-addr VLAN
Date:   Fri, 19 Mar 2021 19:48:52 +0530
Message-Id: <1616163532-3881-1-git-send-email-seevalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
---
 net/mac80211/cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c4c70e3..8bf29c5 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1788,8 +1788,10 @@ static int ieee80211_change_station(struct wiphy *wiphy,
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
2.7.4

