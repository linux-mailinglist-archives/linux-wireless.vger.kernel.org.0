Return-Path: <linux-wireless+bounces-18737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444FA301A5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 03:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E21A16702D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 02:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED831D54C2;
	Tue, 11 Feb 2025 02:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="b/CNz26p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC3194141;
	Tue, 11 Feb 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242193; cv=none; b=ujPPw5Zhb/igIzH/mM5IQ7Uaau18JaMZ6IR0wP/G20A+kAvASLPB1iqPmriog9gPh+trTaqz/A+kDdJc5MlF2+DmKE6M/goDaihiXthts2bL7Y/iO5USati1FTiayZhUpT9vyog4RMm7J6Yn0UJxnEqVf3nTTMZzBSHgyX4ngbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242193; c=relaxed/simple;
	bh=Rgy25EVL0wRf2teD4M9Ky3kJgd9pojM13fv9uCJKvCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q7xpDVh7Gm4nzvARE8CU/A3ddwAgHpIBKIVPxgIiquaPY6bsKk0aOiZAEC1CD/xL4kYUdyoespuJyoviEEKc3r2gD1mOpuurC+jU2mEGjx2xgIZi3iyWpdk7GwVc4NtkXs53YIE7ll06CHgmVGh/xm9ESNOfeQloD0DFqFc4mZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=b/CNz26p; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YsQs61655z9swL;
	Tue, 11 Feb 2025 03:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739242186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oa3Pz0t//cYNB/fGGI06gp+EWCDBZUXPJXgdkIf+Tpw=;
	b=b/CNz26pl/GmePFdgwcj+YTYk24EYTSjuR3dXDElCbweQaHZ3xSZSy2JcTx+Xubs3obY3K
	DziZutfThgZGF8vmLbnblorGubqAdQh+N+NEJGxLGRhofPhlc0h2657YGxxsUhZEdGTaXe
	aPhrCBmQ4/l8xE4GokM4Dl8E0zY9ZoLE6A8UamCQ/dE6VC9JZj28LTZlMiEyYCQUx9loPE
	94LLrVGDTbJbshPKba4eDPMTxhVKzTDY94l42ouT1cIbsc0iITHyEm1iPVGbePZ0FPrfw7
	XtDrKCDnlZvisMjVTWsTF7N06fYxM6AUBpNCz7Clk3Ho+81rchvRpajRmbv0wQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 10 Feb 2025 21:49:41 -0500
Subject: [PATCH v2] wifi: ath12k: cleanup ath12k_mac_mlo_ready()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-ath12k-uninit-v2-1-3596f28dd380@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAMS6qmcC/3WOQQ7CIBBFr9LMWsxArG1deQ/TBcIgEyNtAFHT9
 O5i9y7fS/7LXyBRZEpwahaIVDjxFCqoXQPG63AjwbYyKFQtKhyEzl6qu3gGDpyF7NsjOjtIgx3
 UzRzJ8XvrXcbKnlOe4mfLF/mz/0pFCim0Mz1i2x+6K50p1wOG7EtHm/ZmesC4rusXVHLVLbIAA
 AA=
X-Change-ID: 20250209-ath12k-uninit-18560fd91c07
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Harshitha Prem <quic_hprem@quicinc.com>, 
 Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org, 
 ath12k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=Rgy25EVL0wRf2teD4M9Ky3kJgd9pojM13fv9uCJKvCY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBLL2FkZlJmM3JKdHF6MTNMMXltdGJHODFNZEZiTnVxCjNPeGJseWFZQ0V6U1hNZjdv
 Zmw1UnlrTGd4Z1hnNnlZSXN2L0hPVzBoNW96RkhiK2RXbUNtY1BLQkRLRWdZdFQKQUNiQ0xzSHc
 zOUZ6cjZqT0pvR0dJTjV0WHhnYU90NHNFbTJVSzU5K1IzRkdndjZCQTNtcDVvd00wLy9kOXpsNw
 pNYmx6NnUvbTNJa09rZHFuN0pkdFc1ZlZjR1AzMWdNYlphUzltUUVwQ1U1Ygo9MjZRMQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4YsQs61655z9swL

There is a possibility for an uninitialized *ret* variable to be
returned in some code paths.

This explicitly returns 0 without an error. Also removes goto that
returned *ret* and simply returns in place.

Closes: https://scan5.scan.coverity.com/#/project-view/63541/10063?selectedIssue=1642337
Fixes: b716a10d99a28 ("wifi: ath12k: enable MLO setup and teardown from core")
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
Changes in v2:
- Rewrite commit subject to include function
- put int ret; back at top of function declaration
- minor changes to description
- Link to v1: https://lore.kernel.org/r/20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com
---
 drivers/net/wireless/ath/ath12k/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 0606116d6b9c491b6ede401b2e1aedfb619339a8..276f2ee553f4e3529abff14f2b9238ee0a78f45e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -920,12 +920,11 @@ int ath12k_mac_mlo_ready(struct ath12k_hw_group *ag)
 			ar = &ah->radio[j];
 			ret = __ath12k_mac_mlo_ready(ar);
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


