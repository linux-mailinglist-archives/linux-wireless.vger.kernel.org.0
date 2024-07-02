Return-Path: <linux-wireless+bounces-9844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE98923DC5
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769792852B1
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79D17B423;
	Tue,  2 Jul 2024 12:25:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 51CEF177986;
	Tue,  2 Jul 2024 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923145; cv=none; b=DRYMCIL+3gspMNgApMuv4dohipM7Bk3YeM/00YmSwEItcU9InOXGvVs2zV57j2BHk8rab4f0VQ1HIlPFm7R5JCLuJHuf5uSarQnL7k3Cq1LK/Jwks9OWpcuo6UIw0oFz44Tnzfyi1U0ya4A0FwYcsI8IRr6l2TIMgSAbt4oN10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923145; c=relaxed/simple;
	bh=EZlLmoTtAlTf/n0780AcOKkral2xyrZbpk9+FQd/Nhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=DplwkL5TnbkFSzH6ErXdiiRY5M8SA0OiHWz5odyKNjazUROtTxsUHVLhjiWA42zlWdk8TmIBvvZuGv0zNvVOpIaz7ni4EghcC+axUosomnsSkq30At+Z7tX5IK+hC7sUIsc1Edg+8GpaaSHKff8vo0MRpWu3/qRMuOmCLdG9E5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 9A8766031A649;
	Tue,  2 Jul 2024 20:25:28 +0800 (CST)
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
	duoming@zju.edu.cn,
	petr.tesarik.ext@huawei.com,
	colin.i.king@gmail.com,
	meuleman@broadcom.com,
	frankyl@broadcom.com,
	linville@tuxdriver.com,
	pieterpg@broadcom.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 7/9] wifi: cfg80211: avoid garbage value of 'wsec' in brcmf_cfg80211_add_key()
Date: Tue,  2 Jul 2024 20:24:50 +0800
Message-Id: <20240702122450.2213833-8-suhui@nfschina.com>
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

Fixes: f09d0c02b63d ("brcmfmac: use different fw api for encryption,auth. config")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index eb1196db8407..2a97d4d7f684 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2782,7 +2782,7 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_wsec_key *key;
 	s32 val;
-	s32 wsec;
+	s32 wsec = 0;
 	s32 err;
 	u8 keybuf[8];
 	bool ext_key;
-- 
2.30.2


