Return-Path: <linux-wireless+bounces-7506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B5A8C327D
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 18:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B061C20D85
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5C414285;
	Sat, 11 May 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="liIzOWID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A311C290;
	Sat, 11 May 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445256; cv=none; b=Ov0sVbvRyXBe7v0pss60LNc/MJ0VpEZqeT6ETN97YG/exeeVS6uCf9yOF1NFBV8cbF83JgtuyqpXrMB+6PX74VaIDe1qCjl5HencHR+qbaHJtCYg5aQIeJ0BnWltvVdFTbE1LRVIB06NbJZirkHUEHqsYqnI5EEDs2wwVEEj2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445256; c=relaxed/simple;
	bh=6xUepPtYC3ErhIlctwNeg5gGvuYSj4ulAS7J+8qRDFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9Ucv1kEHDY/+m0gJoZTveMlxVasog/6/ijkUqYqoVz8N6szaQeLNH8SECS6cTtJ7ZTnNd9WiagOl5WILqqRSCv4y2TFkdipmTOgkwEAiyR6lc5uGcctcc+YgQZxqAnu8K60PWn3C5uccj3SGqnzLpBeCvZkYRHeTl6qC3+B2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=liIzOWID; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 5peUsjqa5MXQT5pejssoZh; Sat, 11 May 2024 18:33:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715445185;
	bh=TvU+WlooXy0Q21dSizGCB4Cb/0JOSAxcicREnFxTifI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=liIzOWIDjx8/YNNuXbZGPQlUWGtZWeft+8oZjli5cYFxHZXyaSZpZByNzPc9IBsLn
	 bnn7lggOC0xKex95Hgk7+Rt/jjxEVM3kX7ZLZhUkFdCeruuZU/XirEt+DUjyobze0i
	 p1qonssPev0W5Js3rBff9BISofoAwN6fG9JuYNY14Kl9erbccWh9qL6KI3uhb6b4TL
	 j7HHI6BWwHZYc0q2V713AUIKf0bGkSodSlEEYa++ZgOH4v/SE6Loc5QjO1omsLjbZf
	 QfSK/uts5OSlItfWIoIRfhywOgVQGP8HwKmKhNop3dq946uoNz3Fc44ka2VSEx89FE
	 m05c2ECzJw3FA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 May 2024 18:33:05 +0200
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
Subject: [PATCH 1/3] lib80211: Handle const struct lib80211_crypto_ops in lib80211
Date: Sat, 11 May 2024 18:32:38 +0200
Message-ID: <d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr>
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

lib80211_register_crypto_ops() and lib80211_unregister_crypto_ops() don't
modify their "struct lib80211_crypto_ops *ops" argument. So, it can be
declared as const.

Doing so, some adjustments are needed to also constify some date in
"struct lib80211_crypt_data", "struct lib80211_crypto_alg" and the
return value of lib80211_get_crypto_ops().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
 include/net/lib80211.h               | 8 ++++----
 net/wireless/lib80211.c              | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index fbd4ec824084..c730d921463d 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -474,7 +474,7 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 	int i, idx;
 	int group_key = 0;
 	const char *alg, *module;
-	struct lib80211_crypto_ops *ops;
+	const struct lib80211_crypto_ops *ops;
 	struct lib80211_crypt_data **crypt;
 
 	struct rtllib_security sec = {
diff --git a/include/net/lib80211.h b/include/net/lib80211.h
index 8b47d3a51cf8..fd0f15d87d80 100644
--- a/include/net/lib80211.h
+++ b/include/net/lib80211.h
@@ -92,7 +92,7 @@ struct lib80211_crypto_ops {
 
 struct lib80211_crypt_data {
 	struct list_head list;	/* delayed deletion list */
-	struct lib80211_crypto_ops *ops;
+	const struct lib80211_crypto_ops *ops;
 	void *priv;
 	atomic_t refcnt;
 };
@@ -113,9 +113,9 @@ struct lib80211_crypt_info {
 int lib80211_crypt_info_init(struct lib80211_crypt_info *info, char *name,
                                 spinlock_t *lock);
 void lib80211_crypt_info_free(struct lib80211_crypt_info *info);
-int lib80211_register_crypto_ops(struct lib80211_crypto_ops *ops);
-int lib80211_unregister_crypto_ops(struct lib80211_crypto_ops *ops);
-struct lib80211_crypto_ops *lib80211_get_crypto_ops(const char *name);
+int lib80211_register_crypto_ops(const struct lib80211_crypto_ops *ops);
+int lib80211_unregister_crypto_ops(const struct lib80211_crypto_ops *ops);
+const struct lib80211_crypto_ops *lib80211_get_crypto_ops(const char *name);
 void lib80211_crypt_delayed_deinit(struct lib80211_crypt_info *info,
 				    struct lib80211_crypt_data **crypt);
 
diff --git a/net/wireless/lib80211.c b/net/wireless/lib80211.c
index d66a913027e0..51e31316bcb8 100644
--- a/net/wireless/lib80211.c
+++ b/net/wireless/lib80211.c
@@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
 
 struct lib80211_crypto_alg {
 	struct list_head list;
-	struct lib80211_crypto_ops *ops;
+	const struct lib80211_crypto_ops *ops;
 };
 
 static LIST_HEAD(lib80211_crypto_algs);
@@ -161,7 +161,7 @@ void lib80211_crypt_delayed_deinit(struct lib80211_crypt_info *info,
 }
 EXPORT_SYMBOL(lib80211_crypt_delayed_deinit);
 
-int lib80211_register_crypto_ops(struct lib80211_crypto_ops *ops)
+int lib80211_register_crypto_ops(const struct lib80211_crypto_ops *ops)
 {
 	unsigned long flags;
 	struct lib80211_crypto_alg *alg;
@@ -183,7 +183,7 @@ int lib80211_register_crypto_ops(struct lib80211_crypto_ops *ops)
 }
 EXPORT_SYMBOL(lib80211_register_crypto_ops);
 
-int lib80211_unregister_crypto_ops(struct lib80211_crypto_ops *ops)
+int lib80211_unregister_crypto_ops(const struct lib80211_crypto_ops *ops)
 {
 	struct lib80211_crypto_alg *alg;
 	unsigned long flags;
@@ -206,7 +206,7 @@ int lib80211_unregister_crypto_ops(struct lib80211_crypto_ops *ops)
 }
 EXPORT_SYMBOL(lib80211_unregister_crypto_ops);
 
-struct lib80211_crypto_ops *lib80211_get_crypto_ops(const char *name)
+const struct lib80211_crypto_ops *lib80211_get_crypto_ops(const char *name)
 {
 	struct lib80211_crypto_alg *alg;
 	unsigned long flags;
-- 
2.45.0


