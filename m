Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE0A359F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfH3LZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:25:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39444 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727386AbfH3LZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:25:01 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3f1X-0001lc-Up; Fri, 30 Aug 2019 14:25:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:24:48 +0300
Message-Id: <20190830112451.21655-6-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830112451.21655-1-luca@coelho.fi>
References: <20190830112451.21655-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 5/8] mac80211: remove unnecessary key condition
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we reach this point, the key cannot be NULL. Remove the condition
that suggests otherwise.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/key.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 7dfee848abac..1be3686562ee 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -6,6 +6,7 @@
  * Copyright 2007-2008	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
+ * Copyright 2018-2019  Intel Corporation
  */
 
 #include <linux/if_ether.h>
@@ -781,9 +782,8 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		/* The rekey code assumes that the old and new key are using
 		 * the same cipher. Enforce the assumption for pairwise keys.
 		 */
-		if (key &&
-		    ((alt_key && alt_key->conf.cipher != key->conf.cipher) ||
-		     (old_key && old_key->conf.cipher != key->conf.cipher)))
+		if ((alt_key && alt_key->conf.cipher != key->conf.cipher) ||
+		    (old_key && old_key->conf.cipher != key->conf.cipher))
 			goto out;
 	} else if (sta) {
 		old_key = key_mtx_dereference(sdata->local, sta->gtk[idx]);
-- 
2.23.0.rc1

