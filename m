Return-Path: <linux-wireless+bounces-34505-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MZeLQfH1WnA9wcAu9opvQ
	(envelope-from <linux-wireless+bounces-34505-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:09:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A93B67CB
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 05:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC3F3025701
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E82D0C62;
	Wed,  8 Apr 2026 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehSY7s1G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C13E2C17B3;
	Wed,  8 Apr 2026 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617767; cv=none; b=S1mtthJEv0naufMk0Tv4u5sTIjbly04uY0t7t5iN688HMG/qzhmIgtKXns60b1sLEId0MpTHPjpYrkiEcFJC717Qun9W5vn1cbzEb5RRaqlMK0MVkQJZtXjn6souqvddmbokVRgmSfrRk3+xMamKux1iJtWxHNH+tTyiGdl2TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617767; c=relaxed/simple;
	bh=j4GlWJ+j9z7J/xL6Xs2UuoVzMpFWWK/XuOBq61TQ49U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0nHRZk1ydsWaJNuCx41kRZc4A/pCbdBz30JMtlW42sm55CXMRyEQpW8R7cAxoA0FKAkMKrujZmY5wUPDQdxhPyyu3wLtb8TIMSAu/ghoBTLH184FizuI9NAttCW/oYj1N1+DMFleao1OaRRSLOQYsmNaJy/VqtFDc+qbL6eTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehSY7s1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D70C2BCB1;
	Wed,  8 Apr 2026 03:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775617767;
	bh=j4GlWJ+j9z7J/xL6Xs2UuoVzMpFWWK/XuOBq61TQ49U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehSY7s1GIGvNT2l3mglh7zyjPM1AZPGLpaWhwio2SI16tzzzrp6JIGhgDpo5PUSZf
	 ZEjoa5OAfxleo90tUf9ItaittSN42hrkSdPt+/8h+McDbW/mZfm+NDWP5AMcojUCqi
	 O/Rqf9e701qvUvzTZj2Stp/S7GKBWwcFk5YF0+BzGhuvFwkD6Ankqv6J5Q+g9fL3S2
	 UPsnjEJRnI4Ia7UPtJutUqGu50S5PcXrx2QW1tzV5vLuviQuzysRPO3NbIa2+Fkp2F
	 hwARFuqvUAS+/c9NwafdDQWr16XRfRJcTRDxxHDJHnsi5fRvdylYHLdQJmpsPGxmFA
	 E5Jk/wPQ3UMMQ==
From: Eric Biggers <ebiggers@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH wireless-next v2 2/6] wifi: mac80211, cfg80211: Export michael_mic() and move it to cfg80211
Date: Tue,  7 Apr 2026 20:06:47 -0700
Message-ID: <20260408030651.80336-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408030651.80336-1-ebiggers@kernel.org>
References: <20260408030651.80336-1-ebiggers@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34505-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 582A93B67CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Export michael_mic() so that the ath11k and ath12k drivers can call it.
In addition, move it from mac80211 to cfg80211 so that the ipw2x00
drivers, which depend on cfg80211 but not mac80211, can also call it.

Currently these drivers have their own local implementations of
michael_mic() based on crypto_shash, which is redundant and inefficient.
By consolidating all the Michael MIC code into cfg80211, we'll be able
to remove the duplicate Michael MIC code in the crypto/ directory.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/linux/ieee80211.h                     |  5 +++++
 net/mac80211/Makefile                         |  1 -
 net/mac80211/michael.h                        | 22 -------------------
 net/mac80211/wpa.c                            |  1 -
 net/wireless/Makefile                         |  2 +-
 .../michael.c => wireless/michael-mic.c}      |  5 ++++-
 6 files changed, 10 insertions(+), 26 deletions(-)
 delete mode 100644 net/mac80211/michael.h
 rename net/{mac80211/michael.c => wireless/michael-mic.c} (96%)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index ffa8f9f77efe4..23f9df9be8372 100644
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
diff --git a/net/mac80211/Makefile b/net/mac80211/Makefile
index abf46c9512993..20c3135b73ea6 100644
--- a/net/mac80211/Makefile
+++ b/net/mac80211/Makefile
@@ -16,11 +16,10 @@ mac80211-y := \
 	s1g.o \
 	ibss.o \
 	iface.o \
 	link.o \
 	rate.o \
-	michael.o \
 	tkip.o \
 	aes_cmac.o \
 	aes_gmac.o \
 	fils_aead.o \
 	cfg.o \
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
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 62a83faf0e07d..a77fd5ba63686 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -6,11 +6,11 @@ obj-$(CONFIG_WEXT_CORE) += wext-core.o
 obj-$(CONFIG_WEXT_PROC) += wext-proc.o
 obj-$(CONFIG_WEXT_PRIV) += wext-priv.o
 
 cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o scan.o nl80211.o
 cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o trace.o ocb.o
-cfg80211-y += pmsr.o
+cfg80211-y += michael-mic.o pmsr.o
 cfg80211-$(CONFIG_OF) += of.o
 cfg80211-$(CONFIG_CFG80211_DEBUGFS) += debugfs.o
 cfg80211-$(CONFIG_CFG80211_WEXT) += wext-compat.o wext-sme.o
 
 CFLAGS_trace.o := -I$(src)
diff --git a/net/mac80211/michael.c b/net/wireless/michael-mic.c
similarity index 96%
rename from net/mac80211/michael.c
rename to net/wireless/michael-mic.c
index 8a1afc93e7499..50cdb67f0503d 100644
--- a/net/mac80211/michael.c
+++ b/net/wireless/michael-mic.c
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
-- 
2.53.0


