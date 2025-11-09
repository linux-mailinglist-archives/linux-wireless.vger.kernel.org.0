Return-Path: <linux-wireless+bounces-28704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B9C43F9B
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 15:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B87584E5728
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52732FB0A0;
	Sun,  9 Nov 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="IRyabFrB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722C2FBE03
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697107; cv=pass; b=iburNXlVaongM1+Lup6VWrcKcah/E8rJKsipVygSzdM3VJVCdTbgV5RVwZTKIfn8c8wOjP+XAo5JXzob34dGiIHdUoqDDA2wfRhEtk5BapvEOccVXVbemXZEXlWnLQH0z7glQ2HN6SYL2FTSTcFhklMZRt4Nyhx4oz7ZpsFhLrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697107; c=relaxed/simple;
	bh=3y8Y3EHajHNNrWaWYH1sez2XtzjdQJxjIlHM2VnJxDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RM5u6jNf8cXFJGp3UMpTgz4ZNwYXvgtj7zkK2bSG1Q1o841OO3iyF40IhSm+Tgvj362KmA9IYN+AE0FoF8JdfTGUs1fpiUpOW2fkuJr7Tf6FQQHGpyBH+kn9njQ4eVDZAqpqRHGINEYLazzxeDcPXSZno9StQNiVOgcfC+FTJSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=IRyabFrB; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762697104; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SdcZb69vN7JL5tS/Wx7rL8cBPnGwBTyiJIB7htgrnyhBgetgaDh29u38n+ummtVvaprJn8FEC5sfUhZEb3ZWyZJ1PLct8kpGWen3TYAyDofXJWT305lNYjekM9eP++tKudFAgJSOaHNpJ/aMCFgBUvHT2dkwWUw70aXA+/tSsRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762697104; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2nBLsVrkZT5B62tko61K3VVGI0pGGgWm87RC0kVe6XU=; 
	b=e+ckcS28989NwQ61r/MNbnQFZdz1ENb4ED5rx/9yndlY49a+OKcJpfEoeKF2wlvy/tgjOls/nnkq29012XSrs4Q2EoPZJ8NL6n4RiCy8StV4IHIKv27bQpGyDJjKs3bp9srrGolZNt4u7ReUH54oe7oFUUZNsyqH2BGWLbPntF8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762697104;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2nBLsVrkZT5B62tko61K3VVGI0pGGgWm87RC0kVe6XU=;
	b=IRyabFrBwfA7l7bJ9sUfylCXJQThEXK77MDBa1HePyQW6xGb3T2XagCtVzgnUb8e
	FoyKx7xjqmBiBl+EDDTGnmEx2RPyvtv/vyGS7tpg7IDwHsv4sCoQvRgC2p9LN0IcFM3
	ap5aPjFzttVvw/R5dO44XC6nXCpm9kYVJwMciAx8=
Received: by mx.zohomail.com with SMTPS id 1762697103222178.14158570218206;
	Sun, 9 Nov 2025 06:05:03 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] wifi: mac80211: utilize the newly defined CMAC constants
Date: Sun,  9 Nov 2025 22:04:48 +0800
Message-ID: <20251109140450.118106-5-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251109140450.118106-1-m@xv97.com>
References: <20251109140450.118106-1-m@xv97.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Make use of the added constants to reduce duplication.

Compile test only.

Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 4 ++--
 net/mac80211/aes_gmac.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index d7d1117f1313..2c2d15c50b65 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -16,8 +16,8 @@
 #include "key.h"
 #include "aes_cmac.h"
 
-#define CMAC_TLEN 8 /* CMAC TLen = 64 bits (8 octets) */
-#define CMAC_TLEN_256 16 /* CMAC TLen = 128 bits (16 octets) */
+#define CMAC_TLEN IEEE80211_CMAC_128_MIC_LEN
+#define CMAC_TLEN_256 IEEE80211_CMAC_256_MIC_LEN
 #define AAD_LEN 20
 
 static const u8 zero[CMAC_TLEN_256];
diff --git a/net/mac80211/aes_gmac.h b/net/mac80211/aes_gmac.h
index c739356bae2a..09378e52c7a6 100644
--- a/net/mac80211/aes_gmac.h
+++ b/net/mac80211/aes_gmac.h
@@ -9,7 +9,7 @@
 #include <linux/crypto.h>
 
 #define GMAC_AAD_LEN	20
-#define GMAC_MIC_LEN	16
+#define GMAC_MIC_LEN	IEEE80211_GMAC_MIC_LEN
 #define GMAC_NONCE_LEN	12
 
 struct crypto_aead *ieee80211_aes_gmac_key_setup(const u8 key[],
-- 
2.51.2


