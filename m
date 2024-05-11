Return-Path: <linux-wireless+bounces-7508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354208C3286
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 18:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6740A1C20D81
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B195208A5;
	Sat, 11 May 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LYtIxpYv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160221865A;
	Sat, 11 May 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445262; cv=none; b=GA6/xe33fNwNsF9g5rQuUkPH5DrjW/ROXk7Va4GHO7svZvbGmBdTj1gCOw1qH4zYxpp9T6eX0fn4dzkGDFXwunvIV/h/Q9W0PuvdjiKbFqIcrtV0b1gbNayWDGl0m70ry+G4eiQ/dNVd8LGNpAjTkZGDQK3cB+uMI5BXs4DnWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445262; c=relaxed/simple;
	bh=E/NeqwYMuReaGCRnYcp3vdJpyEggLPpb2HSYcSmn0H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+4Wa64TENSZ0T3AUaSq0zifgIwW9rG3TV/nCysmkmdT5W2LHi1tpI+q5vEiHLYeB0pufkR49dSCc5uuddMaWBwBUPclOoICOPkdDgTbWOMFCEx4OcOveYw+x69LqI+TPDktEmrmqHA3+l7x/7e/7jeeXwFd3csdQOo73+cSWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LYtIxpYv; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 5peUsjqa5MXQT5pepssoaT; Sat, 11 May 2024 18:33:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715445195;
	bh=/+Vnyk4wWnOEN53vv8Rub/cXhWL4Rx9rMTvs0vfgDg0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LYtIxpYvbz0/6xuqRvbNnYxPfEUX0OJnpc+WarLHOIXk+rgQV+sckBP6q8m5YzYgt
	 gfcmJetuB4jp0695j3qD803csDTnoHRQtdAs55qpbd5UQQqna1HTBRP3a4wu82j9em
	 2cmARqZF4kgIgEVzUsuAcuywo9vZRCqtV0GKH7C4I84TIUCYiCStO9OycjS6inr3D/
	 yQeSVkxIZEmuP4L5Q7ItBPkqyEJrS/JUX3Vuiig5tRcAqozV0FBoHQgaYfVU8YpkI1
	 8LFxtKxurjxwIPHXhY0Pav68lyiunnsBmFldKJET770kIEnf6K1H8WXXURZdPr9K16
	 CmPufTyU2+Jhg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 May 2024 18:33:15 +0200
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
Subject: [PATCH 3/3] staging: rtl8192e: Constify struct lib80211_crypto_ops
Date: Sat, 11 May 2024 18:32:40 +0200
Message-ID: <81be9eb42a2339eaa7466578773945a48904d3b5.1715443223.git.christophe.jaillet@wanadoo.fr>
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

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 2 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index cbb8c8dbe9b0..ce02204ac1ba 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -378,7 +378,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 		   ccmp->dot11rsna_stats_ccmp_decrypt_errors);
 }
 
-static struct lib80211_crypto_ops rtllib_crypt_ccmp = {
+static const struct lib80211_crypto_ops rtllib_crypt_ccmp = {
 	.name			= "R-CCMP",
 	.init			= rtllib_ccmp_init,
 	.deinit			= rtllib_ccmp_deinit,
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index 0244b524a7d4..be8060ecaecd 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -678,7 +678,7 @@ static void rtllib_tkip_print_stats(struct seq_file *m, void *priv)
 		   tkip->dot11RSNAStatsTKIPLocalMICFailures);
 }
 
-static struct lib80211_crypto_ops rtllib_crypt_tkip = {
+static const struct lib80211_crypto_ops rtllib_crypt_tkip = {
 	.name			= "R-TKIP",
 	.init			= rtllib_tkip_init,
 	.deinit			= rtllib_tkip_deinit,
diff --git a/drivers/staging/rtl8192e/rtllib_crypt_wep.c b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
index 21c2b7666d6f..55c5199a25ea 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_wep.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_wep.c
@@ -209,7 +209,7 @@ static void prism2_wep_print_stats(struct seq_file *m, void *priv)
 	seq_printf(m, "key[%d] alg=WEP len=%d\n", wep->key_idx, wep->key_len);
 }
 
-static struct lib80211_crypto_ops rtllib_crypt_wep = {
+static const struct lib80211_crypto_ops rtllib_crypt_wep = {
 	.name			= "R-WEP",
 	.init			= prism2_wep_init,
 	.deinit			= prism2_wep_deinit,
-- 
2.45.0


