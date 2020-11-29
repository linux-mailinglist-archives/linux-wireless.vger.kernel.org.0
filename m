Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DDC2C79C3
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbgK2Pb4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33574 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387395AbgK2Pbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:55 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfJ-0035ld-2G; Sun, 29 Nov 2020 17:31:05 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:53 +0200
Message-Id: <iwlwifi.20201129172929.e1df99693a4c.I494579f28018c2d0b9d4083a664cf872c28405ae@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/13] mac80211: set sdata state once vif is up after restart
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Borwankar, Antara" <antara.borwankar@intel.com>

On FW recovery mac80211 is supposed to reconfigure the driver.
In the scanario when vif is of monitor type, after FW assert the vif
was getting added and channel context was getting created but this
channel context was not getting assigned to the vif.

This was fixed by setting the monitor sdata state bit to running once
the vif is up and running after the virtual monitor is added.

Signed-off-by: Borwankar, Antara <antara.borwankar@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/iface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f5d4ceb72882..3b9ec4ef81c3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -940,6 +940,8 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		return ret;
 	}
 
+	set_bit(SDATA_STATE_RUNNING, &sdata->state);
+
 	ret = ieee80211_check_queues(sdata, NL80211_IFTYPE_MONITOR);
 	if (ret) {
 		kfree(sdata);
-- 
2.29.2

