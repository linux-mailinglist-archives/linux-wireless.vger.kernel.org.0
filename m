Return-Path: <linux-wireless+bounces-34352-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHa1GjTz0WlYRgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34352-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:29:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF57D39D5FB
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Apr 2026 07:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6428F3005311
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Apr 2026 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6DC34C83C;
	Sun,  5 Apr 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By6AVK4n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA2334C2B;
	Sun,  5 Apr 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775366954; cv=none; b=ZQMH4IO9vDoJcRwGqMHZmAUsMK2h4zKDLCm+0ASkNpuVsXTaAKfuJ3KqfE5iQWma8wNwGeMqRfloiZvlpnWzqZac3skJy1wQPWyf2ra7fQ6LQNrvvfxCa3zNMXsK4GVz/zHjMsKV/mvlk2vQPcJDIpwcCFZXtOzuIQZetphecgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775366954; c=relaxed/simple;
	bh=+73vBBAcFMCvFCTiAqCBr+2nkUg9Bry9d2K3/Wt9MKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvbud92InawH10cxa/HElhtpgzMobcb/WA01ZWB6EbYKEdW/jY49I5wKOD44tCNSOSXxZkf7260DZqpT/xZY29cEITPdd2iK8p/eyjzIC2ehRZgLnPadWIugYB1yaB6rOVp51HDLbvm/kuf+zzPqyWO9A7xXmyWNj+N6x0KNA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By6AVK4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB592C2BC9E;
	Sun,  5 Apr 2026 05:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775366954;
	bh=+73vBBAcFMCvFCTiAqCBr+2nkUg9Bry9d2K3/Wt9MKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=By6AVK4nuJXZhah2SfSKt91ELa4Zp47zbgGLoaKU4z+Z8NB1mDXoXKZS3KUcLtd+F
	 oCIV7PJ57dQpXKzV8TSFwbVVH7mFF8OkYv41iOkc4xRzFCXtyH1rliRXkeLE07wGyY
	 eKscM1V+FVYcoIkr2Pe2l4DFv8plwLlyNxP4zV6a4NKNV1zKDxhetcLDAKJsDGdhBJ
	 FpKAbnD4kWLcUcp0qPoRhPGkfdYudtGfVv47Z0t8Eu8UAscJ+qlxCrOrCed1HT3NW3
	 w+g4+TRBgoVfpksB0HRh9yUrsNhpPrHuanenpqi6RxnR5iXQUbiHVDD1U1sfJee5IQ
	 bFLa9wmVR+a3Q==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next 1/6] wifi: mac80211: Export michael_mic()
Date: Sat,  4 Apr 2026 22:27:29 -0700
Message-ID: <20260405052734.130368-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405052734.130368-1-ebiggers@kernel.org>
References: <20260405052734.130368-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34352-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF57D39D5FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export the michael_mic() function so that it can be reused by the
ath11k, ath12k, and ipw2x00 drivers.  Currently they have their own
local implementations of it based on crypto_shash, which is redundant
and inefficient.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/ieee80211.h |  5 +++++
 net/mac80211/michael.c    |  5 ++++-
 net/mac80211/michael.h    | 22 ----------------------
 net/mac80211/wpa.c        |  1 -
 4 files changed, 9 insertions(+), 24 deletions(-)
 delete mode 100644 net/mac80211/michael.h

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b5d649db123fe..da6fcdc742e7c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1919,10 +1919,15 @@ enum ieee80211_radio_measurement_actioncode {
 #define FILS_ERP_MAX_RRK_LEN		64
 
 #define PMK_MAX_LEN			64
 #define SAE_PASSWORD_MAX_LEN		128
 
+#define MICHAEL_MIC_LEN			8
+
+void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,
+		 const u8 *data, size_t data_len, u8 *mic);
+
 /* Public action codes (IEEE Std 802.11-2016, 9.6.8.1, Table 9-307) */
 enum ieee80211_pub_actioncode {
 	WLAN_PUB_ACTION_20_40_BSS_COEX = 0,
 	WLAN_PUB_ACTION_DSE_ENABLEMENT = 1,
 	WLAN_PUB_ACTION_DSE_DEENABLEMENT = 2,
diff --git a/net/mac80211/michael.c b/net/mac80211/michael.c
index 8a1afc93e7499..50cdb67f0503d 100644
--- a/net/mac80211/michael.c
+++ b/net/mac80211/michael.c
@@ -6,11 +6,13 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/ieee80211.h>
 #include <linux/unaligned.h>
 
-#include "michael.h"
+struct michael_mic_ctx {
+	u32 l, r;
+};
 
 static void michael_block(struct michael_mic_ctx *mctx, u32 val)
 {
 	mctx->l ^= val;
 	mctx->r ^= rol32(mctx->l, 17);
@@ -79,5 +81,6 @@ void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,
 	michael_block(&mctx, 0);
 
 	put_unaligned_le32(mctx.l, mic);
 	put_unaligned_le32(mctx.r, mic + 4);
 }
+EXPORT_SYMBOL_GPL(michael_mic);
diff --git a/net/mac80211/michael.h b/net/mac80211/michael.h
deleted file mode 100644
index a7fdb8e84615a..0000000000000
--- a/net/mac80211/michael.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Michael MIC implementation - optimized for TKIP MIC operations
- * Copyright 2002-2003, Instant802 Networks, Inc.
- */
-
-#ifndef MICHAEL_H
-#define MICHAEL_H
-
-#include <linux/types.h>
-#include <linux/ieee80211.h>
-
-#define MICHAEL_MIC_LEN 8
-
-struct michael_mic_ctx {
-	u32 l, r;
-};
-
-void michael_mic(const u8 *key, struct ieee80211_hdr *hdr,
-		 const u8 *data, size_t data_len, u8 *mic);
-
-#endif /* MICHAEL_H */
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 64a57475ce506..724ec831a8857 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -16,11 +16,10 @@
 #include <net/mac80211.h>
 #include <crypto/aes.h>
 #include <crypto/utils.h>
 
 #include "ieee80211_i.h"
-#include "michael.h"
 #include "tkip.h"
 #include "aes_ccm.h"
 #include "aes_cmac.h"
 #include "aes_gmac.h"
 #include "aes_gcm.h"
-- 
2.53.0


