Return-Path: <linux-wireless+bounces-28701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDFC43F92
	for <lists+linux-wireless@lfdr.de>; Sun, 09 Nov 2025 15:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A557A1889E31
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Nov 2025 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE562FB968;
	Sun,  9 Nov 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="VOppQh4i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966532F7ADF
	for <linux-wireless@vger.kernel.org>; Sun,  9 Nov 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697104; cv=pass; b=YMnv3QPtbmgsK+mIfTTekG5p7fJqGJjyhr/l6x5gfMRaGSvDKTeQJXnqAPui6hvaJFekr8wRoL0HV7ZdlXz1uVDkhC/gkfpIVbXip6udufg2/HXDX52fIRjaXiRH9k8JtLFdbkt3qR3vGhr/WaF3OorvDnF4pjjNftWsFq6F8fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697104; c=relaxed/simple;
	bh=TVxKIjeRWH3fD4En+cTo7XwxFxDFs08MBOy5u17/pv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRr+tpGEh2j6lxFFra6IHhLjfxNMH6ZPMuCCnYYs8dwFiJwOHQTMvjbhhIeefZsR3yA2zCoYdKJsM5B+mikOp1rVnSr22w/KOtEtFPA2mI43dGaXyaHtFStTeHj+/p+sCADHgQuPzrYHoEyOumpJS1ayHH5l75QKVJkSFdIoiNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=VOppQh4i; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762697100; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EJQRsZxzek8pOUU/u2L14gBz5MHU3O5WfhBgdDTE7QfNoVAavvZ+vaRzIhbBbqBDLoBSUiEX9g3VKaRgoSbRaJfI+vi8LMDgaz+HJ87Cz8J0ohxEylHNI2Cbo5Q23bbtjjr1lw70w/7bqPzpmEv777frgQQwrJxpFunajqWthao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762697100; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BtaBI3/5xnYcndV21N7Dk4KRjb0K+1wzyc+nD7r/IzI=; 
	b=WRFgzZ9C+JlPmTuZofeP6WRrkTtrdsBKHa7G5KSzRlOxYFLjslSLVb0iWiSj0V1SiKhQZbvZBAZdiqgfv/Pi5T7rCPGCOy6gCRONjc8+uGoPhdWCkOrZZ1qbYqF3K/ROnKP4kJcZr41jLH4IARxEb84040e+hQd0cK09obdcHvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762697100;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BtaBI3/5xnYcndV21N7Dk4KRjb0K+1wzyc+nD7r/IzI=;
	b=VOppQh4i9mZVzTGw9NcjbYdSUauM3sHi9Z6tu+/HC3cs+002l44nR95a4Po/gDqU
	sulKMrBip26fu1k/U0AuEILEW3JfOwe9VZS6O7aU/wjmROFpCB+DNGlIGtwSq3MHGjs
	gvcvpI2vsk901HEe1xLR3Oh7jCDNuo6wyCvnGLWQ=
Received: by mx.zohomail.com with SMTPS id 1762697098020837.5203809100291;
	Sun, 9 Nov 2025 06:04:58 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/6] wifi: mac80211: remove an unnecessary copy
Date: Sun,  9 Nov 2025 22:04:45 +0800
Message-ID: <20251109140450.118106-2-m@xv97.com>
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

Using a temporary buffer for saving the CMAC result is useless.
With the patch, ieee80211_aes_cmac() just resembles
ieee80211_aes_cmac_256().

Compile test only.

Fixes: 26717828b75d ("mac80211: aes-cmac: switch to shash CMAC driver")
Signed-off-by: Chien Wong <m@xv97.com>
---
 net/mac80211/aes_cmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 48c04f89de20..a9a5b2396096 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -26,7 +26,6 @@ void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 			const u8 *data, size_t data_len, u8 *mic)
 {
 	SHASH_DESC_ON_STACK(desc, tfm);
-	u8 out[AES_BLOCK_SIZE];
 	const __le16 *fc;
 
 	desc->tfm = tfm;
@@ -41,9 +40,7 @@ void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 	} else {
 		crypto_shash_update(desc, data, data_len - CMAC_TLEN);
 	}
-	crypto_shash_finup(desc, zero, CMAC_TLEN, out);
-
-	memcpy(mic, out, CMAC_TLEN);
+	crypto_shash_finup(desc, zero, CMAC_TLEN, mic);
 }
 
 void ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
-- 
2.51.2


