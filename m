Return-Path: <linux-wireless+bounces-9846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1755C923DC8
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFEB1F258D0
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E697717B4E6;
	Tue,  2 Jul 2024 12:25:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 888F816EB66;
	Tue,  2 Jul 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923145; cv=none; b=YJlF3iXAOEjlxZenZJoc3QQCk2lhNm5T6mtzD6Biyn/WXz+7veZCMmjiAE1ijTdzkNUfTmmIvB3h9HN6Cmn5NMChBx1GKakGNSM/c+kNa6Em21NYG7P7lNG0xesNdUsgU+k69afpyLIte3BhHpg5wUkjVl8CpsIdpzag/GIZb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923145; c=relaxed/simple;
	bh=evAy6djT8Jz+ckPi7/Gdz/7kZj/4vFauA7ksswOC9/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=kVb79GTtUmlDPsSxh04UFYA7x3ylxVRxvGzFkfZyd0OpJuCXoeHbllHcBay7R1A6qv2xmb/wMm9fdPGpdrZKqlEi1azaLk6rajgu2HJ3X0rh6QioXlG0fghl2XNNhePSHC8O7hIR+Z2eMJX7ak1d6RM3qkIXBGLq/YpSEQ55feg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 632836031A638;
	Tue,  2 Jul 2024 20:25:22 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	johannes.berg@intel.com,
	kees@kernel.org,
	a@bayrepo.ru,
	petr.tesarik.ext@huawei.com,
	marcan@marcan.st,
	justinstitt@google.com,
	duoming@zju.edu.cn,
	colin.i.king@gmail.com,
	chi-hsien.lin@cypress.com,
	ian.lin@infineon.com,
	wright.feng@cypress.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 3/9] wifi: cfg80211: avoid garbage value of 'noise' in brcmf_cfg80211_dump_survey()
Date: Tue,  2 Jul 2024 20:24:46 +0800
Message-Id: <20240702122450.2213833-4-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcmf_fil_cmd_int_get() reads the value of 'noise' and passes it to
brcmf_fil_cmd_data_get(). Initialize 'noise' to avoid garbage value.

Fixes: 6c04deae1438 ("brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 6be7e7bd8ce7..2377b88d7ee0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -8084,7 +8084,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
 	struct ieee80211_supported_band *band;
 	enum nl80211_band band_id;
 	struct cca_msrmnt_query req;
-	u32 noise;
+	u32 noise = 0;
 	int err;
 
 	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
-- 
2.30.2


