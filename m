Return-Path: <linux-wireless+bounces-9840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84063923DB7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1F1F235A6
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DCE174EFE;
	Tue,  2 Jul 2024 12:25:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E048216DECF;
	Tue,  2 Jul 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923142; cv=none; b=bPTBpV5sf8zKb3DZA/b5Vlyk/Sru3CR1BbKEDeh6wOeZtW0sejYO35VwIqT18uA1LAcJccxlCzhPOPMMOn64irsUFRWY2F1bKFPXebQ8/VcvPYM2S4162RJOgDkPYRh3HWTlQvbWpTVYZhowo4+wXC0P0GXdZ8ceEaHfwL11zS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923142; c=relaxed/simple;
	bh=Xi97Ab9KSnAJutc+jpQwepKwVeNjLKH94VB89Wuz084=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=SB03dfQlem9GN036vwnsFcJdeZOzeSlHHIPL/b2Xtx7dtGFDuWuXpnX2pWSa/YugFpjWKLo2oEIZMcC3D85EwmM0GcWip9HRXy6Q/EWhitdYdvUjvmTc3thPYvZ8r19Yn/i91O9Pp5G7hdrXonwy1Pw4SzbJGXY9RYHZYW+YSuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id C2C226031A63E;
	Tue,  2 Jul 2024 20:25:18 +0800 (CST)
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
	quic_alokad@quicinc.com,
	zyytlz.wz@163.com,
	petr.tesarik.ext@huawei.com,
	duoming@zju.edu.cn,
	colin.i.king@gmail.com,
	frankyl@broadcom.com,
	meuleman@broadcom.com,
	phaber@broadcom.com,
	linville@tuxdriver.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 1/9]  wifi: cfg80211: avoid garbage value of 'io_type' in  brcmf_cfg80211_attach()
Date: Tue,  2 Jul 2024 20:24:44 +0800
Message-Id: <20240702122450.2213833-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
 brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage value.

Fixes: 83cf17aa8082 ("brcmfmac: adopt new d11 interface")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5fe0e671ecb3..6be7e7bd8ce7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -8249,7 +8249,7 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
 	struct brcmf_cfg80211_vif *vif;
 	struct brcmf_if *ifp;
 	s32 err = 0;
-	s32 io_type;
+	s32 io_type = 0;
 	u16 *cap = NULL;
 
 	if (!ndev) {
-- 
2.30.2


