Return-Path: <linux-wireless+bounces-7507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F8E8C3282
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 18:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E9D28113C
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C7F1CD0C;
	Sat, 11 May 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NQZAP7tD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C61CABF;
	Sat, 11 May 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445261; cv=none; b=GSIsnh2Lo9awdhqnIDUxE9FCc5TRQLPmRMQMkQ3GW2R2FMWdPjDjiGb/hiE85vOcaDVicr0kz0cfr1VCOKLzJGtWk5IHWbs9x8A56ih1Koanv5Nc8iZi829hKtj0p4Q4AJe1oLNEABKH46R90pjNIcIDxv9mLZMn3LvdUs7afUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445261; c=relaxed/simple;
	bh=TxZLNeP4Z9jK3YH5dlUXFoTUwr4HqFZQHfXm+5QByb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgzfOOFxDago4VZhGRr6gLU0DSmlQb00mqYcbDoS3Abe5L6w2F2WawbE6GCZYbwnFwdN7C8YnjcN9AipPFRm+rYWLCjF5Kk1L5AN2ffsNKoqeCmit9I4kGRizJcYnphHRFT+pN0vn0tH7XViSOX55zlH6vjeCYXRzDRgmHGOVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NQZAP7tD; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 5peUsjqa5MXQT5pemssoaB; Sat, 11 May 2024 18:33:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715445188;
	bh=0gQj3sXLPtXnvFL3Wi6Q0PprW6RAEKCBs4IROvAxuJU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NQZAP7tDAKdANUBCvlEXVTVVFsb/jnbzeNuUFHLj6FcquEB3G0E+LwVEMq6emyQz2
	 bl+kCs33DRhLr1uEOTG4wHp3MjgKUl503yR3Y4EWABoCyVjXbr1bOBUmYgpFDNHgkZ
	 SPIiAg/RmYwO09scurs1JJpToRMJPFR9WnIic2ZuwhASoJr2z1ekkanPH6ujC43TT2
	 e6uWRzg+N1CFe44DvQUtb4y2QLuzmIElta49X5Ugocp9LP14wQiK9GSyDLg+d8qezm
	 oBq53IcBK5LrRBKXpr4XalUMngo7gg5CtyoMRX9TywTbSFRC4pv5stp9s09DbqVyGD
	 N4vn7R+ImopLQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 May 2024 18:33:08 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	johannes@sipsolutions.net,
	philipp.g.hortmann@gmail.com,
	tdavies@darkphysics.net,
	garyrookard@fastmail.org,
	straube.linux@gmail.com
Cc: linux-staging@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/3] lib80211: Constify struct lib80211_crypto_ops
Date: Sat, 11 May 2024 18:32:39 +0200
Message-ID: <a1f822093dbd01f39d9afb931bece744273b8b9d.1715443223.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715443223.git.christophe.jaillet@wanadoo.fr>
References: <cover.1715443223.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that functions in lib80211 handle "const struct lib80211_crypto_ops",
some structure can be constify as well.

Constifying these structures moves some data to a read-only section, so
increase overall security.

Before:
   text	   data	    bss	    dec	    hex	filename
   7273	    604	     16	   7893	   1ed5	net/wireless/lib80211.o

After:
   text	   data	    bss	    dec	    hex	filename
   7429	    444	     16	   7889	   1ed1	net/wireless/lib80211.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 net/wireless/lib80211.c            | 2 +-
 net/wireless/lib80211_crypt_ccmp.c | 2 +-
 net/wireless/lib80211_crypt_tkip.c | 2 +-
 net/wireless/lib80211_crypt_wep.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/wireless/lib80211.c b/net/wireless/lib80211.c
index 51e31316bcb8..64c447040786 100644
--- a/net/wireless/lib80211.c
+++ b/net/wireless/lib80211.c
@@ -234,7 +234,7 @@ static void lib80211_crypt_null_deinit(void *priv)
 {
 }
 
-static struct lib80211_crypto_ops lib80211_crypt_null = {
+static const struct lib80211_crypto_ops lib80211_crypt_null = {
 	.name = "NULL",
 	.init = lib80211_crypt_null_init,
 	.deinit = lib80211_crypt_null_deinit,
diff --git a/net/wireless/lib80211_crypt_ccmp.c b/net/wireless/lib80211_crypt_ccmp.c
index cca5e1cf089e..5aad139130e1 100644
--- a/net/wireless/lib80211_crypt_ccmp.c
+++ b/net/wireless/lib80211_crypt_ccmp.c
@@ -418,7 +418,7 @@ static void lib80211_ccmp_print_stats(struct seq_file *m, void *priv)
 		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
 }
 
-static struct lib80211_crypto_ops lib80211_crypt_ccmp = {
+static const struct lib80211_crypto_ops lib80211_crypt_ccmp = {
 	.name = "CCMP",
 	.init = lib80211_ccmp_init,
 	.deinit = lib80211_ccmp_deinit,
diff --git a/net/wireless/lib80211_crypt_tkip.c b/net/wireless/lib80211_crypt_tkip.c
index 5c8cdf7681e3..63e68e5e121e 100644
--- a/net/wireless/lib80211_crypt_tkip.c
+++ b/net/wireless/lib80211_crypt_tkip.c
@@ -705,7 +705,7 @@ static void lib80211_tkip_print_stats(struct seq_file *m, void *priv)
 		   tkip->dot11RSNAStatsTKIPLocalMICFailures);
 }
 
-static struct lib80211_crypto_ops lib80211_crypt_tkip = {
+static const struct lib80211_crypto_ops lib80211_crypt_tkip = {
 	.name = "TKIP",
 	.init = lib80211_tkip_init,
 	.deinit = lib80211_tkip_deinit,
diff --git a/net/wireless/lib80211_crypt_wep.c b/net/wireless/lib80211_crypt_wep.c
index 6ab9957b8f96..3b148c7bef85 100644
--- a/net/wireless/lib80211_crypt_wep.c
+++ b/net/wireless/lib80211_crypt_wep.c
@@ -226,7 +226,7 @@ static void lib80211_wep_print_stats(struct seq_file *m, void *priv)
 	seq_printf(m, "key[%d] alg=WEP len=%d\n", wep->key_idx, wep->key_len);
 }
 
-static struct lib80211_crypto_ops lib80211_crypt_wep = {
+static const struct lib80211_crypto_ops lib80211_crypt_wep = {
 	.name = "WEP",
 	.init = lib80211_wep_init,
 	.deinit = lib80211_wep_deinit,
-- 
2.45.0


