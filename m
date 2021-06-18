Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409C73AC96F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhFRLIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:08:45 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48280 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231810AbhFRLIp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:08:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBww-001YXx-Kd; Fri, 18 Jun 2021 13:42:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:37 +0300
Message-Id: <iwlwifi.20210618133832.8238ab3e19ab.I2693c581c70251472b4f9089e37e06fb2c18268f@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 12/31] mac80211: Properly WARN on HW scan before restart
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The following race was possible:

1. The device driver requests HW restart.
2. A scan is requested from user space and is propagated
   to the driver. During this flow HW_SCANNING flag is set.
3. The thread that handles the HW restart is scheduled,
   and before starting the actual reconfiguration it
   checks that HW_SCANNING is not set. The flow does so
   without acquiring any lock, and thus the WARN fires.

Fix this by checking that HW_SCANNING is on only after RTNL is
acquired, i.e., user space scan request handling is no longer
in transit.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 62145e5f9628..da3e0ca6aa31 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -256,14 +256,13 @@ static void ieee80211_restart_work(struct work_struct *work)
 	/* wait for scan work complete */
 	flush_workqueue(local->workqueue);
 	flush_work(&local->sched_scan_stopped_work);
+	flush_work(&local->radar_detected_work);
+
+	rtnl_lock();
 
 	WARN(test_bit(SCAN_HW_SCANNING, &local->scanning),
 	     "%s called with hardware scan in progress\n", __func__);
 
-	flush_work(&local->radar_detected_work);
-	/* we might do interface manipulations, so need both */
-	rtnl_lock();
-	wiphy_lock(local->hw.wiphy);
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		/*
 		 * XXX: there may be more work for other vif types and even
-- 
2.32.0

