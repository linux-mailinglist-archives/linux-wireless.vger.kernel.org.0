Return-Path: <linux-wireless+bounces-9842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DF4923DC0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C671F23AE5
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5589E17921D;
	Tue,  2 Jul 2024 12:25:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 238ED174EDF;
	Tue,  2 Jul 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923144; cv=none; b=X725tF2PREo7RM6jHkkz6LC65GuxQYukscoVo6p+tHEEZBVEJexF8h+5vqNgp1FZQoyqFBIMlD20uY+ZUZmA1rwpGyWh7imFYsRCFpjAYxnXf9vbg3zrHGgXUC+jquOmy9fMavsvl1Np5tibLwO6O1bpKnjGK0SUQ/oHvVL6m/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923144; c=relaxed/simple;
	bh=QEHj1YJApM67xSQPt8/HlxK6R7veWsWbHV9VxRLTYK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=KwMi8R2JBJ/Ja/8WQhB6na5idmhm2W942P8GAGRjDuH21l4vjvPUmbuNKsB3WuLaIIC4leKxYf40DT3G1/ib9NfvaKtwOw0lYCi+26v0WnJ/u2rBX0GplaJPaPFOq88qR20fN+2km63R+Bwg5oMpT+ULuVdGwfWiI7fXA8Mo0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 288AA6031A64D;
	Tue,  2 Jul 2024 20:25:32 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	johannes.berg@intel.com,
	kees@kernel.org,
	a@bayrepo.ru,
	duoming@zju.edu.cn,
	marcan@marcan.st,
	petr.tesarik.ext@huawei.com,
	colin.i.king@gmail.com,
	linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 9/9] wifi: cfg80211: avoid garbage value of 'wsec' in brcmf_cfg80211_{get,config_default}_key()
Date: Tue,  2 Jul 2024 20:24:52 +0800
Message-Id: <20240702122450.2213833-10-suhui@nfschina.com>
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

Fixes: 5b435de0d786 ("net: wireless: add brcm80211 drivers")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 95193e09504f..eb8d7455d0ea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2707,7 +2707,7 @@ brcmf_cfg80211_config_default_key(struct wiphy *wiphy, struct net_device *ndev,
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = ifp->drvr;
 	u32 index;
-	u32 wsec;
+	u32 wsec = 0;
 	s32 err = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
@@ -2907,7 +2907,7 @@ brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_cfg80211_security *sec;
-	s32 wsec;
+	s32 wsec = 0;
 	s32 err = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
-- 
2.30.2


