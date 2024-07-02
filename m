Return-Path: <linux-wireless+bounces-9847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ABF923DCC
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8975BB264B2
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 12:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3201117B51F;
	Tue,  2 Jul 2024 12:25:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DEF19176237;
	Tue,  2 Jul 2024 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923146; cv=none; b=AgU8C+y0liv97s6mJo93gh5i/Ok+68bFhfl9U82kgYFnJwop31yqayDSw72ODWW4DROFimzUfMXPjbkU3UmmU/pTgm40ouFnO8EAYSBezGLamo9LC1WzBBbeQBBeNzby9JBhKLyjqwpZ9oQi5IhTRIcShqQTKQJs+TEDvs237/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923146; c=relaxed/simple;
	bh=JkUkqJ7im0Np8iJE4dAgzWwTvaR+CRh7XcW/vBuE1XI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=YNWMRdIjSp3W/EOHoUnv+qrVg4YyaIMpdnIBEngEVwEGtedz3onobqJEyUmJnCWZ6nbVWpRb478W2DF0RbhspptWS+Ky5zXedj3ZAJrk7B4YLEFVietxcJu/THxfbALc68NQodm8bDd0hoA054M+o9X8Us39e5kZwSx/xmHjeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 23E1D6031A648;
	Tue,  2 Jul 2024 20:25:20 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: arend.vanspriel@broadcom.com,
	kvalo@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	quic_jjohnson@quicinc.com,
	u.kleine-koenig@pengutronix.de,
	stanley.hsu@cypress.com,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH wireless 2/9] wifi: brcmfmac: avoid garbage value of 'status' in brcmf_c_download_blob()
Date: Tue,  2 Jul 2024 20:24:45 +0800
Message-Id: <20240702122450.2213833-3-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702122450.2213833-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

brcmf_fil_iovar_int_get() reads the value of 'status' and passes it
to brcmf_fil_iovar_data_get(). The garbage value of 'status' will
finally be copied to 'ifp->drvr->proto_buf'. Initialize 'status' to
avoid garbage value.

Fixes: fdd0bd88ceae ("brcmfmac: add CLM download support")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index b24faae35873..03277131ef2b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -127,7 +127,7 @@ static int brcmf_c_download_blob(struct brcmf_if *ifp,
 	u32 datalen;
 	u32 cumulative_len;
 	u16 dl_flag = DL_BEGIN;
-	u32 status;
+	u32 status = 0;
 	s32 err;
 
 	brcmf_dbg(TRACE, "Enter\n");
-- 
2.30.2


