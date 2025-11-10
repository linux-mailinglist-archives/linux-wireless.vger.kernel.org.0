Return-Path: <linux-wireless+bounces-28794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37583C474E9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 15:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 053834E41C4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E82144CF;
	Mon, 10 Nov 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b="qHUwe7EC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A80757EA
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785958; cv=pass; b=B8TzwMqSGUeiyow0fn8H/6a7OFfWWUlgyb90baKFnmuTkr4tWbZGH4sEw8T8TyYLcwIgU36S+BXnvgbpfXqjz5RKxl9FCiSXpamIUVwKQFCn0wHD2KYRgssI9Be5i/xXSkcEwhK4ZObNuf9G5094x987nWJVglOsixrRou6BUAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785958; c=relaxed/simple;
	bh=Foix5m/Wmk/8H6Sd59P1yBckmIBRv9qsIRQ01wY+pOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJTgEreFVEIkkQ4fRDzAX/EElxQanVVLtBqPIyfDB5ZNOJ8Oy58aGgb7DlX5kPc+k9Ezd9JSDE0MiD1opYRa1uwgxBGEsV22Bx1VtgEMxnornSIv5bv+sQQUKTZNwDzf98Nik6yfVDZjS6d6sebBPaUysEBM2orq3Iwa1sTBx48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com; spf=pass smtp.mailfrom=xv97.com; dkim=pass (1024-bit key) header.d=xv97.com header.i=m@xv97.com header.b=qHUwe7EC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xv97.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xv97.com
ARC-Seal: i=1; a=rsa-sha256; t=1762785954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TRaLuzyF1uM2ZipxSd47bn5lIfRzFxJQhNn38fVpARixPKY+sCUUpiGIilaORotE8sBxYK+s7AdoqY+rcvr43p0qLykqQt5Dkz3LKwo//7W/vDYIHMz2nGihnJsfwvuT2Jdq7lb2HFDvRAGqaz6RnzjDvADmWNzJY2r4Sud/e7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762785954; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V7aWA7W2byMiSxAHMGoMA/+ubgqgUyKoj+1XI0Ahl/c=; 
	b=Y1vEV9ZpvMYu+qAD1wB2qcBdyl7Up4bYGGwDzYsTrwqjixC/2R9URZZ5JWrZkfhOQUdsyxWE9RcMc/XCjzhSAecGag24jPpZhoJiZB96XTsDq5Qzk3N0mreJP2iuWMEThRifsKHq4lKz7Xw/fmJOT9hbSm1fVVRbaolRN7uoFzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=xv97.com;
	spf=pass  smtp.mailfrom=m@xv97.com;
	dmarc=pass header.from=<m@xv97.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762785954;
	s=zmail; d=xv97.com; i=m@xv97.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V7aWA7W2byMiSxAHMGoMA/+ubgqgUyKoj+1XI0Ahl/c=;
	b=qHUwe7ECbcWYFPTRH1nikSEF0rHRH3nPEafUhiUPglg6JtjPTzGj+C8sBBk31bB7
	wZUJyo7PIFVKAb5ZZoyqL8/950UDkqGjJidOS01cJvR8uiSYba3JYd27KHp8XqiLaGX
	nH/TN/nR2eWT6iyBtO6DmNIe3iGGGRT39taBUa6U=
Received: by mx.zohomail.com with SMTPS id 1762785952979549.5848632324129;
	Mon, 10 Nov 2025 06:45:52 -0800 (PST)
From: Chien Wong <m@xv97.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/6] wifi: mac80211: remove an unnecessary copy
Date: Mon, 10 Nov 2025 22:45:40 +0800
Message-ID: <20251110144545.15149-2-m@xv97.com>
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

Using a temporary buffer for saving the CMAC result is useless.
With the patch, ieee80211_aes_cmac() just resembles
ieee80211_aes_cmac_256().

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


