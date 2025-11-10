Return-Path: <linux-wireless+bounces-28796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42217C4750A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432853B5D27
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4092264BA;
	Mon, 10 Nov 2025 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="nq0d+MfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD023112DA
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785964; cv=pass; b=AN0fsIqS0cBhlDzNFnfp5g/PQdsU8FncuKrEB46pmYAGhF8G27+vKpJnfF2NnHieY4mUjccXmOS4oHQA86QtlMoD2TXqezl4NKGCGF7r7EjSUdXuyY6hBu5OvH+flDU6kogYvhslx2Mc2IlsswZYY+lFOUVzmTBz8yi3rs4EXwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785964; c=relaxed/simple;
	bh=Sx0ryMF213J3kVhR2b+F5A+zJo1tinkmnBr9Rg9STqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBWBy9HfHD+zU4RT44pPJpWlltBUz1sS6ubcvrw7icfawX1XpaUXtx/e/xFy6ayhHCgAhllwcB8DK5yzxPa2bpOQZ1e8x7/8irbYExmIqyO/dAlrF1yd5E3TjrrWhIpYEB+HM5fUQqrgP8pDy3+WUUdEkzoQI49jwWJ4mWdrstU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=nq0d+MfW; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762785960; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Pif+A7F8rAOCQUhXiogvoI+J2wHZN3FBWyBDjBmCHgprDa0I3j8QR8sVCoqeQiCl+iE5paoWvx5jj4N9jUFa613lO3DkumdBxemsVI/NiehNmMlEhzHy7vU270CujhwONjIkR4/HAv7D2kDt53qiOpqhcLNzsMDrTqLyGDnQP4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762785960; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A2OFbQt6ntd7CKPUq03VlylK1eKUlw7ksLK6n4Ij5v0=; 
	b=eDTWE2+NzE1IjmM+3KSQoTCFIGjSqqm76f9jPJm1Gbq3eZyKvVHGr3f3gDSK5bumKiY5IFMwalLwei7+LtWQL5X2chkqhrZHjfEc/Ac4uuoWHYVtiV60Mtjwennh6dmP8wUvyGnwr3VJZ0OtNWMdDjEsU4y0I/fnQnHubDeY2UA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762785960;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=A2OFbQt6ntd7CKPUq03VlylK1eKUlw7ksLK6n4Ij5v0=;
	b=nq0d+MfW0T7u1cYv4mWOYIJjEz5zN60AfIBCz2Zd5YLn39+XKj/1eXpHOS+Ri9Yl
	y8p9GeEA7ysaumJTW27Ap1K/00rsXGQiFjBrMyDK3pROmkDx9VMdkUm7EZEuFXbKWXj
	83LBnRnJdW+sScnN8i6ov837jgk31n/NE+WEKoMI=
Received: by mx.zohomail.com with SMTPS id 1762785959516649.086088217197;
	Mon, 10 Nov 2025 06:45:59 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 4/6] wifi: mac80211: utilize the newly defined CMAC constants
Date: Mon, 10 Nov 2025 22:45:43 +0800
Message-ID: <20251110144545.15149-5-m@xv97.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110144545.15149-1-m@xv97.com>
References: <20251110144545.15149-1-m@xv97.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Make use of the added constants to reduce duplication.

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


