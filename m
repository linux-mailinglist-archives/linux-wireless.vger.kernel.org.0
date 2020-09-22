Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B517E273A45
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgIVFho (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:37:44 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:34144 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728928AbgIVFhn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:37:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 984724F9E04;
        Tue, 22 Sep 2020 05:37:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lic9W0jsQ-ed; Tue, 22 Sep 2020 05:37:41 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 32D714F9E05;
        Tue, 22 Sep 2020 05:37:21 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v4 16/17] mac80211_hwsim: fix TSF timestamp write to S1G beacon
Date:   Mon, 21 Sep 2020 19:28:17 -0700
Message-Id: <20200922022818.15855-17-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922022818.15855-1-thomas@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mac80211_hwsim was corrupting the S1G beacon because the
timestamp location (and size) does not match the
management beacon.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>

---
v3:
  - fix this before claiming S1G support
  Reported-by: kernel test robot <rong.a.chen@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index dce3bc9c9f84..3daf5b399ebf 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1687,9 +1687,19 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	mgmt = (struct ieee80211_mgmt *) skb->data;
 	/* fake header transmission time */
 	data->abs_bcn_ts = mac80211_hwsim_get_tsf_raw();
-	mgmt->u.beacon.timestamp = cpu_to_le64(data->abs_bcn_ts +
-					       data->tsf_offset +
-					       24 * 8 * 10 / txrate->bitrate);
+	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
+		struct ieee80211_ext *ext = (void *) mgmt;
+
+		ext->u.s1g_beacon.timestamp = cpu_to_le32(data->abs_bcn_ts +
+							  data->tsf_offset +
+							  10 * 8 * 10 /
+							  txrate->bitrate);
+	} else {
+		mgmt->u.beacon.timestamp = cpu_to_le64(data->abs_bcn_ts +
+						       data->tsf_offset +
+						       24 * 8 * 10 /
+						       txrate->bitrate);
+	}
 
 	mac80211_hwsim_tx_frame(hw, skb,
 				rcu_dereference(vif->chanctx_conf)->def.chan);
-- 
2.20.1

