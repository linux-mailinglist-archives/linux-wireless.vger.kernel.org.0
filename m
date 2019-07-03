Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA85E537
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfGCNS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 09:18:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53939 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfGCNS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 09:18:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so2186582wmj.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2019 06:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYT4AbowFoo+snaCfFGOcn2Rzt3cparYz6IVKM/T9eI=;
        b=Y9vfwDISfBcXDLuaIBiVUyrP+9uP7SSgnj5y6vhijvJcmAbTzOCmLBTNuz5ZVZLK1D
         JUYsuwr3N9pcAgwH8I3KziDf7Wp6NCg/nVNBer1JWBoEXiUCWVisOm23sjdFB2U5d0Ax
         nzfL8PAXs7uxKNvHoV2eIklva1ccaE9S2apKm1IM4v12jWNk9P8QvXUX6v8vtKCnkP0/
         OyCxomCyml7G3o1mIBesYBNhPDgV0AKof1LM5z05EWzdbnPocQIhElMlLeKS1pVWdGqv
         V61eyG/jbze4mF7+arxUDyoKPl43SiwOWvd7fAdk2VRyKYBk/SPusRuG1c2gnTd7XsMo
         mTZQ==
X-Gm-Message-State: APjAAAV7cjaJ1bhnQhp3EqefzjxG+T0VHQWRkXn8NIYwS5JmJXMzS1dr
        R1vTO2VNbYQSG0eYi1lKLCcR7ghN
X-Google-Smtp-Source: APXvYqxHf+VlXKvazJl+7BWPDuXz4gRV2TjVwxVWkOGIMPicq07n9Hu4/nTxoBSK0csfeWNpbjjOTQ==
X-Received: by 2002:a1c:c70f:: with SMTP id x15mr7749576wmf.59.1562159934680;
        Wed, 03 Jul 2019 06:18:54 -0700 (PDT)
Received: from localhost.localdomain (46-116-2-211.bb.netvision.net.il. [46.116.2.211])
        by smtp.gmail.com with ESMTPSA id h17sm2197307wrq.79.2019.07.03.06.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Jul 2019 06:18:54 -0700 (PDT)
From:   Shay Bar <shay.bar@celeno.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, shay.bar@celeno.com
Subject: [PATCH] mac80211: HE STA disassoc due to QOS NULL not sent
Date:   Wed,  3 Jul 2019 16:18:48 +0300
Message-Id: <20190703131848.22879-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In case of HE AP-STA link, ieee80211_send_nullfunc() will not send the QOS NULL packet to check if AP is still associated.
In this case, probe_send_count will be non zero and ieee80211_sta_work() will later disassociate the AP.
(although it didn't really send a test QOS NULL packet).
Fix is to decrement probe_send_count and not call ieee80211_send_nullfunc() in case of HE link.

Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
Hope I solved all the SMTP server problems and patch is better now :)

 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 379d2ab6d327..bc5ed2dbe69b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2511,7 +2511,10 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
 
 	if (ieee80211_hw_check(&sdata->local->hw, REPORTS_TX_ACK_STATUS)) {
 		ifmgd->nullfunc_failed = false;
-		ieee80211_send_nullfunc(sdata->local, sdata, false);
+		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
+			ifmgd->probe_send_count--;
+		else
+			ieee80211_send_nullfunc(sdata->local, sdata, false);
 	} else {
 		int ssid_len;
 
-- 
2.22.0

