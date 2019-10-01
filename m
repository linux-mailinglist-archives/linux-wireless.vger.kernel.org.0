Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFDC3241
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfJALTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:19:32 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:60168 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfJALTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:19:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFGBj-0006ZU-QK; Tue, 01 Oct 2019 13:19:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Subject: [PATCH v2] mac80211: keep BHs disabled while calling drv_tx_wake_queue()
Date:   Tue,  1 Oct 2019 13:19:23 +0200
Message-Id: <1569928763-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Drivers typically expect this, as it's the case for almost all cases
where this is called (i.e. from the TX path). Also, the code in mac80211
itself (if the driver calls ieee80211_tx_dequeue()) expects this as it
uses this_cpu_ptr() without additional protection.

This should fix various reports of the problem:
https://bugzilla.kernel.org/show_bug.cgi?id=204127
https://lore.kernel.org/linux-wireless/CAN5HydrWb3o_FE6A1XDnP1E+xS66d5kiEuhHfiGKkLNQokx13Q@mail.gmail.com/
https://lore.kernel.org/lkml/nycvar.YFH.7.76.1909111238470.473@cbobk.fhfr.pm/

Reported-by: Jiri Kosina <jikos@kernel.org>
Reported-by: Aaron Hill <aa1ronham@gmail.com>
Reported-by: Lukas Redlinger <rel+kernel@agilox.net>
Reported-by: Oleksii Shevchuk <alxchk@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 * use local_bh_enable/disable to capture the last occurrence
 * split spin_lock_bh() into local_bh_disable()/spin_lock() to
   make it clearer while we unlock them separately
---
 net/mac80211/util.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 051a02ddcb85..32a7a53833c0 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -247,7 +247,8 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 	struct sta_info *sta;
 	int i;
 
-	spin_lock_bh(&fq->lock);
+	local_bh_disable();
+	spin_lock(&fq->lock);
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
 		ps = &sdata->bss->ps;
@@ -273,9 +274,9 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 						&txqi->flags))
 				continue;
 
-			spin_unlock_bh(&fq->lock);
+			spin_unlock(&fq->lock);
 			drv_wake_tx_queue(local, txqi);
-			spin_lock_bh(&fq->lock);
+			spin_lock(&fq->lock);
 		}
 	}
 
@@ -288,12 +289,14 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 	    (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
 		goto out;
 
-	spin_unlock_bh(&fq->lock);
+	spin_unlock(&fq->lock);
 
 	drv_wake_tx_queue(local, txqi);
+	local_bh_enable();
 	return;
 out:
-	spin_unlock_bh(&fq->lock);
+	spin_unlock(&fq->lock);
+	local_bh_enable();
 }
 
 static void
-- 
2.20.1

