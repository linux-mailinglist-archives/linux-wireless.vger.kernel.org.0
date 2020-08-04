Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8218D23BE5C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHDQsf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 12:48:35 -0400
Received: from 5.mo174.mail-out.ovh.net ([46.105.34.17]:42369 "EHLO
        5.mo174.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgHDQsR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 12:48:17 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2020 12:48:15 EDT
Received: from mxplan8.mail.ovh.net (unknown [10.109.143.18])
        by mo174.mail-out.ovh.net (Postfix) with ESMTPS id 5378A2EBCF80;
        Tue,  4 Aug 2020 18:42:11 +0200 (CEST)
Received: from awhome.eu (37.59.142.99) by mxplan8.mail.ovh.net (172.16.2.81)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1979.3; Tue, 4 Aug 2020
 18:42:10 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-99G00329133d7c-03d3-4729-bdf6-0cdd7de36cd4,
                    9A9EAC4BC0F74E5B123E0DC54798B4242482FF2D) smtp.auth=postmaster@awhome.eu
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1596559329;
        bh=Eud8quTCn0EBG5tE1dfkJ5Ss/9UM22j6OFP4i3ieb/I=;
        h=From:To:Cc:Subject:Date;
        b=q0N8sDAHkbPFuUM0aMbK6i/tDIf/Xmir5iFJx2vFZ2hX2Nar5zNWaIRcl4Xil1b8v
         qClbZvbUP1XUDk1cpbRBC7iw0i6Bm/hXe3I8N7WzkMYvVcwX12tSVan/DISOlCr5w1
         2IjiwntZpI2mhw1u/tsULCtI2/q1fnofpGLDd1S0=
To:     linux-wireless@vger.kernel.org
Cc:     ath9k-devel@qca.qualcomm.com,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] ath9k: add NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 support
Date:   Tue,  4 Aug 2020 18:41:51 +0200
Message-ID: <20200804164152.175375-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Ovh-Tracer-GUID: 464b3615-58e2-4310-8196-ca95ce8bcafa
X-Ovh-Tracer-Id: 10368130768079232154
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeigddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgggfgtsehtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhguvghrucghvghtiigvlhcuoegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgeqnecuggftrfgrthhtvghrnheptdeggefhjeeujeehkeehhffgheevgedvkeffffeuveetfeetjeehgfevveetfedvnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhekrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ath9k driver was so far only able to rekey PTK0 keys correctly due
to the best effort queue flush added with commit 62872a9b9a10
("mac80211: Fix PTK rekey freezes and clear text leak").

Add the needed queue flush and set NL80211_EXT_FEATURE_CAN_REPLACE_PTK0
to tell mac80211 that the driver can now rekey PTK0 keys correctly and
no longer needs the best effort flush.

Effectively this prevents mac80211 to warn when rekeying a PTK0 key
only.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

To keep the patch readable I did not move functions around.
By moving functions we can avoid the extra declaration of ath9k_flush().

Ath9k was totally unable to rekey PTK0 under even light load till commit
62872a9b9a10 ("mac80211: Fix PTK rekey freezes and clear text leak")
was merged in linux 4.20.

This is just moving the needed queue flush into the driver and sets
NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 to suppress the for ath9k known to
be bogus warning the kernel throws currently on rekey.

From usability and security perspective at least commit 62872a9b9a10
("mac80211: Fix PTK rekey freezes and clear text leak")
should be back ported to all stable versions.

Chances are the same patch works for the all ath cards < ath10k.
I can prepare corresponding patches but can't test those.


 drivers/net/wireless/ath/ath9k/init.c |  1 +
 drivers/net/wireless/ath/ath9k/main.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 289a2444d534..ea1d17a265a7 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -1014,6 +1014,7 @@ static void ath9k_set_hw_capab(struct ath_softc *sc, struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 }
 
 int ath9k_init_device(u16 devid, struct ath_softc *sc,
diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
index a47f6e978095..7d96414741da 100644
--- a/drivers/net/wireless/ath/ath9k/main.c
+++ b/drivers/net/wireless/ath/ath9k/main.c
@@ -19,6 +19,9 @@
 #include "ath9k.h"
 #include "btcoex.h"
 
+static void ath9k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			u32 queues, bool drop);
+
 u8 ath9k_parse_mpdudensity(u8 mpdudensity)
 {
 	/*
@@ -1701,6 +1704,15 @@ static int ath9k_set_key(struct ieee80211_hw *hw,
 		return -EOPNOTSUPP;
 	}
 
+	/* There may be MPDUs queued for the outgoing PTK key. Flush queues to
+	 * make sure these are not send unencrypted or with a wrong (new) key
+	 */
+	if (cmd == DISABLE_KEY && key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+		ieee80211_stop_queues(hw);
+		ath9k_flush(hw, vif, 0, true);
+		ieee80211_wake_queues(hw);
+	}
+
 	mutex_lock(&sc->mutex);
 	ath9k_ps_wakeup(sc);
 	ath_dbg(common, CONFIG, "Set HW Key %d\n", cmd);
-- 
2.28.0

