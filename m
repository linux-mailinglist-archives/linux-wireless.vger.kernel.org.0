Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF40193F7B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCZNKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:10:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44368 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727725AbgCZNKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:10:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSGl-00044K-V4; Thu, 26 Mar 2020 15:10:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:09:40 +0200
Message-Id: <iwlwifi.20200326150855.adf551928846.Iae9015573d6c350cc1b12a311d6d13d086beec6c@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326130943.623208-1-luca@coelho.fi>
References: <20200326130943.623208-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 09/12] mac80211: minstrel_ht_assign_best_tp_rates: remove redundant test
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We know this pointer isn't NULL and in fact dereferenced it before,
remove the redundant test.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/rc80211_minstrel_ht.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 694a31978a04..5547111d22bf 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2010-2013 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2019-2020 Intel Corporation
  */
 #include <linux/netdevice.h>
 #include <linux/types.h>
@@ -490,7 +491,7 @@ minstrel_ht_assign_best_tp_rates(struct minstrel_ht_sta *mi,
 	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_mcs_tp = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
-	if (tmp_cck_tp_rate && tmp_cck_tp > tmp_mcs_tp) {
+	if (tmp_cck_tp > tmp_mcs_tp) {
 		for(i = 0; i < MAX_THR_RATES; i++) {
 			minstrel_ht_sort_best_tp_rates(mi, tmp_cck_tp_rate[i],
 						       tmp_mcs_tp_rate);
-- 
2.25.1

