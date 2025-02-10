Return-Path: <linux-wireless+bounces-18690-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8CA2E32B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 05:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B4B7A1455
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 04:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A130413C908;
	Mon, 10 Feb 2025 04:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="TTeoTgHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4317591;
	Mon, 10 Feb 2025 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162226; cv=none; b=VVJ/wrR81fIxHOZLPPDAmMgxSGsHsA9VOh6uJ54YNJuVJzPyrW57IdncNPQcPAc5HC6Chnq4evJ6lEWT3HmYsgHNoB0wLxE7xrlt61QQbup/AAKLLld9i7PNoXvDlNv1R/Bq5HeUPJA6XX4I9iJGuIcKo3x3HhgMId/Uyq7eQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162226; c=relaxed/simple;
	bh=98YvdDd8MACN2jIjR7PjcggzsLEldn9tlL9QS0Lp7q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lz7PQKzN1KdhfE1dDlMEcXmXaYjR1JWGQ2dAmOtEqpbV4ABarA3aq1iIDiNVakuE7HpCujoxzQDdBktxjoQHpkyTzD/Ftwk1FNvx3eIu8tKver4tvXb8l/jcSsmp7/x48L1p4BbXRhNUeHzfCU7yhS2NKTPFNIU/5C6rfZDioVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=TTeoTgHk; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YrsHJ1GFhz9ssM;
	Mon, 10 Feb 2025 05:37:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739162220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U5/LwMtOeJ6224+d5XpyHm/ckyi9zP3Rw8TDDPRJNIU=;
	b=TTeoTgHkMOicZho9YKX2bN0b4sqymlcc9wOBBvMZUJUGIKzyeTfyxCA5zHH9/08HRO+VbW
	KnelvbFEI9gt44MN9vkNu1R8mh3C7tUoKtD5uTMerpuikZDhqIQhHrklOlHkvFBfvN8W3a
	FJ3pMjqvIQcHbFhf1uYcvivO7pf0WTYJqd/DNpN8tYfF412JjkOX18zA69iAOFBESjoktm
	oH8DKF3hSFc+JaRZNVxxJOBrR1aC8HM7vu3tjbEWD+EsMWjUr4ldBJy1TgeUSfPVklevJV
	ENjBUmpTakExrVN0ZK6K0zWDObYHnUlDo+YvT2zOLzErVYmMmYeB3r9JrUdriQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sun, 09 Feb 2025 23:36:50 -0500
Subject: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAGGCqWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNL3cSSDEOjbN3SvMy8zBJdQwtTM4O0FEvDZANzJaCegqLUtMwKsHn
 RsbW1ALKQzXJfAAAA
X-Change-ID: 20250209-ath12k-uninit-18560fd91c07
To: Kalle Valo <kvalo@kernel.org>, 
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, 
 Harshitha Prem <quic_hprem@quicinc.com>, 
 Kalle Valo <quic_kvalo@quicinc.com>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=98YvdDd8MACN2jIjR7PjcggzsLEldn9tlL9QS0Lp7q8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBLOXN5bWk5eVBQVDZlSnBWZG16bG5yVHp0MjlQcS9VCmNMbWMxblB6S0tzZ05kUGZV
 NTUwbExJd2lIRXh5SW9wc3Z6UFVVNTdxRGxEWWVkZmx5YVlPYXhNSUVNWXVEZ0YKWUNJemZCbit
 lMzRURno2c3MyV3hEeTlEWDRiKzNManZKeGNHYjN4ZXcvcC8xYysvdGZ6Smlvd01CMzFsK202TA
 pQUHA3Ty8zRzlNU29YWWRyVHN4ZGtWMGFuN2xqUXUvRGVtVXROZ0NnbGs2bgo9TnJHdgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

There is a possibility for an uninitialized *ret* variable to be
returned in some code paths.

This moves *ret* inside the conditional and explicitly returns 0 without
an error. Also removes goto that returned *ret*.

Addresses-Coverity-ID: 1642337 ("Uninitialized scalar variable")
Fixes: b716a10d99a28 ("wifi: ath12k: enable MLO setup and teardown from core")
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0606116d6b9c491b6ede401b2e1aedfb619339a8..ae75cdad3bd6b6eb80a35fee94c18d365d123cbd 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -908,7 +908,6 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
 {
 	struct ath12k_hw *ah;
 	struct ath12k *ar;
-	int ret;
 	int i, j;
 
 	for (i = 0; i < ag->num_hw; i++) {
@@ -918,14 +917,13 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
 
 		for_each_ar(ah, ar, j) {
 			ar = &ah->radio[j];
-			ret = __ath12k_mac_mlo_ready(ar);
+			int ret = __ath12k_mac_mlo_ready(ar);
 			if (ret)
-				goto out;
+				return ret;
 		}
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)

---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250209-ath12k-uninit-18560fd91c07

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


