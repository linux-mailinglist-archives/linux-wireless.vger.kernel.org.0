Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0581BF57E1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfKHToi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:44:38 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46330 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729895AbfKHToi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:44:38 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2EF1713C2B0;
        Fri,  8 Nov 2019 11:44:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2EF1713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242277;
        bh=r5PvEG8ppUzhu0J8qlE1UgXAyGtmFCfEQCtkjTmEro8=;
        h=From:To:Cc:Subject:Date:From;
        b=aSn+mpfkQfuQ5kgaNhdj34TS/+FLpVtf8HRkN+rRWYnFtKVy5l27mQlKLtEp1fdv1
         x0CuYd2xWBJx18JW170hZY6vp4q5NbCdwYEhpi5rgjsdeMzILQaJn27gNaDbHIBKeO
         Dx7iYzbq/DfNb6sYltqmHv777QPX5KVhWh8DJvOQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 10/10] mlme: Don't unlink bss on assoc timeout and similar.
Date:   Fri,  8 Nov 2019 11:44:33 -0800
Message-Id: <20191108194433.24021-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

With lots of virtual stations, we want to keep the bss entries around
even if one station fails to associate for some reason.  The timeouts
should still get rid of truly stale ones eventually.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/mlme.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 64336433925d..240e5ff8e9df 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2691,7 +2691,7 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	/* AP is probably out of range (or not reachable for another reason) so
 	 * remove the bss struct for that AP.
 	 */
-	cfg80211_unlink_bss(local->hw.wiphy, ifmgd->associated);
+	//cfg80211_unlink_bss(local->hw.wiphy, ifmgd->associated);
 
 	ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 			       WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY,
@@ -4201,7 +4201,7 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 		 * Most likely AP is not in the range so remove the
 		 * bss struct for that AP.
 		 */
-		cfg80211_unlink_bss(local->hw.wiphy, auth_data->bss);
+		//cfg80211_unlink_bss(local->hw.wiphy, auth_data->bss);
 
 		return -ETIMEDOUT;
 	}
@@ -4267,7 +4267,7 @@ static int ieee80211_do_assoc(struct ieee80211_sub_if_data *sdata)
 		 * Most likely AP is not in the range so remove the
 		 * bss struct for that AP.
 		 */
-		cfg80211_unlink_bss(local->hw.wiphy, assoc_data->bss);
+		//cfg80211_unlink_bss(local->hw.wiphy, assoc_data->bss);
 
 		return -ETIMEDOUT;
 	}
-- 
2.20.1

