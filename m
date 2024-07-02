Return-Path: <linux-wireless+bounces-9841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AFA923DBD
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77A71C20DA4
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA3317625B;
	Tue,  2 Jul 2024 12:25:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B87C91741DC;
	Tue,  2 Jul 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923142; cv=none; b=XU5QzCN6b6j3u6tVgduBQDeU/6GZxr29QKTTGin388hzL8t9JHe5hi6dLzme5fTZ7Uau1tJHV99lgELWy77iTpkSBFtY2iqSOwOc8M6pK6Q6gIYeqOkPeFhAsMmcGMr1wNChcGrCW3lPgyFQDrm+nv/HcMSQEjsu/zpZnfcwArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923142; c=relaxed/simple;
	bh=P+/RJb3io/2env2ZVV0+EYtpseTvbe49y6WPDt8hvdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=u5oIknmhCcDVopDcySbA7t99/tjeyaUEwx5GoUWfZ6TVYQb9URiD/2mUEK7vzdP7dqI+JCVVxs1fVVzaC9mVMW7kn426skREWbfKWJToAT+76v9y+xia5pl6f7tYv9EjpVGAEsZBCwPM3rIluCvTUcVHMTJV2JLN+Vjt+Xf6jdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 1EBF86031A64C;
	Tue,  2 Jul 2024 20:25:27 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	johannes.berg@intel.com,
	kees@kernel.org,
	a@bayrepo.ru,
	marcan@marcan.st,
	petr.tesarik.ext@huawei.com,
	colin.i.king@gmail.com,
	pieterpg@broadcom.com,
	meuleman@broadcom.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 6/9] wifi: cfg80211: avoid garbage value of 'wsec' in brcmf_cfg80211_reconfigure_wep()
Date: Tue,  2 Jul 2024 20:24:49 +0800
Message-Id: <20240702122450.2213833-7-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcmf_fil_bsscfg_int_get() reads the value of 'wsec'.
Initialize 'wsec' to avoid garbage value.

Fixes: 118eb304d055 ("brcmfmac: Fix WEP configuration for AP mode.")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 9a5b1f77c890..eb1196db8407 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2975,7 +2975,7 @@ brcmf_cfg80211_reconfigure_wep(struct brcmf_if *ifp)
 	s32 err;
 	u8 key_idx;
 	struct brcmf_wsec_key *key;
-	s32 wsec;
+	s32 wsec = 0;
 
 	for (key_idx = 0; key_idx < BRCMF_MAX_DEFAULT_KEYS; key_idx++) {
 		key = &ifp->vif->profile.key[key_idx];
-- 
2.30.2


