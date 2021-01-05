Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59F2EADC3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbhAEO5s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 09:57:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:39336 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726020AbhAEO5r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 09:57:47 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kwnlb-003b9K-7m; Tue, 05 Jan 2021 16:57:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  5 Jan 2021 16:56:57 +0200
Message-Id: <iwlwifi.20210105165657.613e9a876829.Ia38d27dbebea28bf9c56d70691d243186ede70e7@changeid>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH] cfg80211: Save the regulatory domain with a lock
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Saving the regulatory domain while setting custom regulatory domain
was done while accessing a RCU protected pointer but without any
protection.

Fix this by using RTNL while accessing the pointer.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reported-by: syzbot+27771d4abcd9b7a1f5d3@syzkaller.appspotmail.com
Reported-by: syzbot+db4035751c56c0079282@syzkaller.appspotmail.com
Reported-by: Hans de Goede <hdegoede@redhat.com>
Fixes: beee24695157 ("cfg80211: Save the regulatory domain when setting custom regulatory")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/reg.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index bb72447ad960..8114bba8556c 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -5,7 +5,7 @@
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright      2017  Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2021 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -139,6 +139,11 @@ static const struct ieee80211_regdomain *get_cfg80211_regdom(void)
 	return rcu_dereference_rtnl(cfg80211_regdomain);
 }
 
+/*
+ * Returns the regulatory domain associated with the wiphy.
+ *
+ * Requires either RTNL or RCU protection
+ */
 const struct ieee80211_regdomain *get_wiphy_regdom(struct wiphy *wiphy)
 {
 	return rcu_dereference_rtnl(wiphy->regd);
@@ -2571,9 +2576,13 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
 	if (IS_ERR(new_regd))
 		return;
 
+	rtnl_lock();
+
 	tmp = get_wiphy_regdom(wiphy);
 	rcu_assign_pointer(wiphy->regd, new_regd);
 	rcu_free_regdom(tmp);
+
+	rtnl_unlock();
 }
 EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
 
-- 
2.29.2

