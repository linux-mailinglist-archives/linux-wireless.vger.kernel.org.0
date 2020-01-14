Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98FB13A0D9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 07:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgANGFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 01:05:46 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:56838 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgANGFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 01:05:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id 31B842F0A2E;
        Tue, 14 Jan 2020 05:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f9xXvWWKc-Kd; Mon, 13 Jan 2020 21:59:41 -0800 (PST)
Received: from tractor.ibsgaard.io (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id 385A12F0A42;
        Mon, 13 Jan 2020 21:59:41 -0800 (PST)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 1/2] mac80211_hwsim: add power save support
Date:   Mon, 13 Jan 2020 21:59:39 -0800
Message-Id: <20200114055940.18502-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114055940.18502-1-thomas@adapt-ip.com>
References: <20200114055940.18502-1-thomas@adapt-ip.com>
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

Leave STA power save disabled by default since it causes
several p2p, scanning, and rrm hostap tests to fail.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---

v3:
disable STA PS by default
---
 drivers/net/wireless/mac80211_hwsim.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 03738107fd10..8d9d85f3f3a7 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1595,6 +1595,11 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
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
@@ -2925,11 +2930,15 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+	ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
 	ieee80211_hw_set(hw, TDLS_WIDER_BW);
 	if (rctbl)
 		ieee80211_hw_set(hw, SUPPORTS_RC_TABLE);
 	ieee80211_hw_set(hw, SUPPORTS_MULTI_BSSID);
 
+	hw->wiphy->flags &= ~WIPHY_FLAG_PS_ON_BY_DEFAULT;
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
 			    WIPHY_FLAG_AP_UAPSD |
-- 
2.20.1

