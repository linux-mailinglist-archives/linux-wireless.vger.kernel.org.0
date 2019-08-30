Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF0A35A1
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 13:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfH3LZE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 07:25:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39456 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727820AbfH3LZE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 07:25:04 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i3f1Z-0001lc-OI; Fri, 30 Aug 2019 14:25:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:24:50 +0300
Message-Id: <20190830112451.21655-8-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830112451.21655-1-luca@coelho.fi>
References: <20190830112451.21655-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 7/8] mac80211: don't check if key is NULL in ieee80211_key_link()
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We already assume that key is not NULL and dereference it in a few
other places before we check whether it is NULL, so the check is
unnecessary.  Remove it.

Fixes: 96fc6efb9ad9 ("mac80211: IEEE 802.11 Extended Key ID support")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 93ea03b86b80..0f889b919b06 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -793,7 +793,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 
 	/* Non-pairwise keys must also not switch the cipher on rekey */
 	if (!pairwise) {
-		if (key && old_key && old_key->conf.cipher != key->conf.cipher)
+		if (old_key && old_key->conf.cipher != key->conf.cipher)
 			goto out;
 	}
 
-- 
2.23.0.rc1

