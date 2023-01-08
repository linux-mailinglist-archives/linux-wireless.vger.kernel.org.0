Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD62661740
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 18:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjAHROi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 12:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjAHROh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 12:14:37 -0500
X-Greylist: delayed 382 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Jan 2023 09:14:35 PST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C2BC03
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 09:14:35 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id EE25410189A6F;
        Sun,  8 Jan 2023 18:08:09 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C418E603DB87;
        Sun,  8 Jan 2023 18:08:09 +0100 (CET)
X-Mailbox-Line: From e7280be84acda02634bc7cb52c97656182b9c700 Mon Sep 17 00:00:00 2001
Message-Id: <e7280be84acda02634bc7cb52c97656182b9c700.1673197326.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 8 Jan 2023 18:08:08 +0100
Subject: [PATCH] wifi: cfg80211: Deduplicate certificate loading
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, David Howells <dhowells@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

load_keys_from_buffer() in net/wireless/reg.c duplicates
x509_load_certificate_list() in crypto/asymmetric_keys/x509_loader.c
for no apparent reason.

Deduplicate it.  No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: David Howells <dhowells@redhat.com>
---
 crypto/asymmetric_keys/x509_loader.c |  1 +
 net/wireless/reg.c                   | 54 +++++-----------------------
 2 files changed, 9 insertions(+), 46 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index 1bc169dee22e..a41741326998 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -55,3 +55,4 @@ int x509_load_certificate_list(const u8 cert_list[],
 	pr_err("Problem parsing in-kernel X.509 certificate list\n");
 	return 0;
 }
+EXPORT_SYMBOL_GPL(x509_load_certificate_list);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4f3f31244e8b..af65196c916e 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -737,51 +737,9 @@ static bool valid_country(const u8 *data, unsigned int size,
 }
 
 #ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
-static struct key *builtin_regdb_keys;
-
-static void __init load_keys_from_buffer(const u8 *p, unsigned int buflen)
-{
-	const u8 *end = p + buflen;
-	size_t plen;
-	key_ref_t key;
-
-	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 &&
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
-			goto dodgy_cert;
-
-		key = key_create_or_update(make_key_ref(builtin_regdb_keys, 1),
-					   "asymmetric", NULL, p, plen,
-					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-					    KEY_USR_VIEW | KEY_USR_READ),
-					   KEY_ALLOC_NOT_IN_QUOTA |
-					   KEY_ALLOC_BUILT_IN |
-					   KEY_ALLOC_BYPASS_RESTRICTION);
-		if (IS_ERR(key)) {
-			pr_err("Problem loading in-kernel X.509 certificate (%ld)\n",
-			       PTR_ERR(key));
-		} else {
-			pr_notice("Loaded X.509 cert '%s'\n",
-				  key_ref_to_ptr(key)->description);
-			key_ref_put(key);
-		}
-		p += plen;
-	}
-
-	return;
+#include <keys/asymmetric-type.h>
 
-dodgy_cert:
-	pr_err("Problem parsing in-kernel X.509 certificate list\n");
-}
+static struct key *builtin_regdb_keys;
 
 static int __init load_builtin_regdb_keys(void)
 {
@@ -797,11 +755,15 @@ static int __init load_builtin_regdb_keys(void)
 	pr_notice("Loading compiled-in X.509 certificates for regulatory database\n");
 
 #ifdef CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS
-	load_keys_from_buffer(shipped_regdb_certs, shipped_regdb_certs_len);
+	x509_load_certificate_list(shipped_regdb_certs,
+				   shipped_regdb_certs_len,
+				   builtin_regdb_keys);
 #endif
 #ifdef CONFIG_CFG80211_EXTRA_REGDB_KEYDIR
 	if (CONFIG_CFG80211_EXTRA_REGDB_KEYDIR[0] != '\0')
-		load_keys_from_buffer(extra_regdb_certs, extra_regdb_certs_len);
+		x509_load_certificate_list(extra_regdb_certs,
+					   extra_regdb_certs_len,
+					   builtin_regdb_keys);
 #endif
 
 	return 0;
-- 
2.39.0

