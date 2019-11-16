Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A063DFF4AA
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfKPSVo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 13:21:44 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:33182 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfKPSVn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 13:21:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id B21B72F0323;
        Sat, 16 Nov 2019 18:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5RgfBa9kAviZ; Sat, 16 Nov 2019 10:12:36 -0800 (PST)
Received: from tractor.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id C10752F031C;
        Sat, 16 Nov 2019 10:12:34 -0800 (PST)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 1/3] mac80211_hwsim: add power save support
Date:   Sat, 16 Nov 2019 10:12:31 -0800
Message-Id: <20191116181233.1037-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116181233.1037-1-thomas@adapt-ip.com>
References: <20191116181233.1037-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Advertise the correct flags to mac80211 to indicate PS
trigger frames and frame buffering should be handled by
mac80211. This means mac80211_hwsim will now also have to
release buffered multicast frames after a (DTIM) beacon.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 772e54f0696f..bede49f686ba 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1574,6 +1574,11 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	mac80211_hwsim_tx_frame(hw, skb,
 				rcu_dereference(vif->chanctx_conf)->def.chan);
 
+	while ((skb = ieee80211_get_buffered_bc(hw, vif)) != NULL) {
+		mac80211_hwsim_tx_frame(hw, skb,
+				rcu_dereference(vif->chanctx_conf)->def.chan);
+	}
+
 	if (vif->csa_active && ieee80211_csa_is_complete(vif))
 		ieee80211_csa_finish(vif);
 }
@@ -2804,6 +2809,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+	ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 
 	/* We only have SW crypto and only implement the A-MPDU API
-- 
2.20.1

