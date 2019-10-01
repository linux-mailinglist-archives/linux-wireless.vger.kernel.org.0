Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D2C30EC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 12:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfJAKIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 06:08:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58626 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbfJAKIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 06:08:20 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFF4s-0004qc-5p; Tue, 01 Oct 2019 12:08:18 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Subject: [PATCH] mac80211: keep BHs disabled while calling drv_tx_wake_queue()
Date:   Tue,  1 Oct 2019 12:08:05 +0200
Message-Id: <1569924485-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid>
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
 net/mac80211/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 051a02ddcb85..ad1e88958da2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -273,9 +273,9 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 						&txqi->flags))
 				continue;
 
-			spin_unlock_bh(&fq->lock);
+			spin_unlock(&fq->lock);
 			drv_wake_tx_queue(local, txqi);
-			spin_lock_bh(&fq->lock);
+			spin_lock(&fq->lock);
 		}
 	}
 
-- 
2.20.1

