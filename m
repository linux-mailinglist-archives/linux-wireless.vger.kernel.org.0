Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8D359B68
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDIKKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 06:10:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44316 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233965AbhDIKIc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 06:08:32 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUnd3-000ELR-2m; Fri, 09 Apr 2021 12:40:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:28 +0300
Message-Id: <iwlwifi.20210409123755.533ff7acf1d2.I034bafa201c4a6823333f8410aeaa60cca5ee9e0@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 15/15] mac80211: aes_cmac: check crypto_shash_setkey() return value
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

As crypto_shash_setkey() can fail, we should check the return value.

Addresses-Coverity-ID: 1401813 ("Unchecked return value")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/aes_cmac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index b31f1021ad9c..48c04f89de20 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -2,6 +2,7 @@
 /*
  * AES-128-CMAC with TLen 16 for IEEE 802.11w BIP
  * Copyright 2008, Jouni Malinen <j@w1.fi>
+ * Copyright (C) 2020 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -73,8 +74,14 @@ struct crypto_shash *ieee80211_aes_cmac_key_setup(const u8 key[],
 	struct crypto_shash *tfm;
 
 	tfm = crypto_alloc_shash("cmac(aes)", 0, 0);
-	if (!IS_ERR(tfm))
-		crypto_shash_setkey(tfm, key, key_len);
+	if (!IS_ERR(tfm)) {
+		int err = crypto_shash_setkey(tfm, key, key_len);
+
+		if (err) {
+			crypto_free_shash(tfm);
+			return ERR_PTR(err);
+		}
+	}
 
 	return tfm;
 }
-- 
2.31.0

