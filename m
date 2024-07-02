Return-Path: <linux-wireless+bounces-9843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B7923DC3
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7CE1C23AF6
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C6117B40B;
	Tue,  2 Jul 2024 12:25:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 10549176ABB;
	Tue,  2 Jul 2024 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923145; cv=none; b=j4nMXqFuEd1SgTTs4yrf3znvihr/NMcJpN7LLY226j7de0NPkpaCMPmqwxuQQZB9C4C9S2NlGK+eQOQzamr1bMEQ5wwoSaa1WiWmY+OYZ7wgrd2h1dbZY82X3COiKFhcO0A9L0LGrpUh9H1oAA9PcCNhpmRTczUEzYF72jcFdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923145; c=relaxed/simple;
	bh=/ybC0azd/YcZ5gUZ1daUGO+ZlGw0Gp2SnfzhyW7qEdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=PGLcqufQvsrQc0T174bU+NlXtRyrmEgL/88OqceNsmHcT7pna+SSbcukzSN5v7SncREw6lo51fVCOujNa+SaiEicNiv775yTDFlructPq7wr5HwLERMwLVfTjLfAxN9CReoS6j5H+W+M+Tf7emVLd7VdbE7KYZQl3Lf0nNLVXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 846F56031A64B;
	Tue,  2 Jul 2024 20:25:25 +0800 (CST)
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
	justinstitt@google.com,
	marcan@marcan.st,
	duoming@zju.edu.cn,
	colin.i.king@gmail.com,
	antonio@open-mesh.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 5/9] wifi: cfg80211: avoid garbage value of 'freq' in brcmf_cfg80211_mgmt_tx()
Date: Tue,  2 Jul 2024 20:24:48 +0800
Message-Id: <20240702122450.2213833-6-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcmf_fil_cmd_int_get() reads the value of 'freq'.
Initialize 'freq' to avoid garbage value.

Fixes: c2ff8cad6423 ("brcm80211: make mgmt_tx in brcmfmac accept a NULL channel")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e672565de437..9a5b1f77c890 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5511,7 +5511,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	struct brcmf_fil_af_params_le *af_params;
 	bool ack;
 	s32 chan_nr;
-	u32 freq;
+	u32 freq = 0;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
-- 
2.30.2


