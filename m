Return-Path: <linux-wireless+bounces-9502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C8914F74
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 16:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8521C222D9
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAEA13B2B8;
	Mon, 24 Jun 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1aMivJBH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O+Cmi+h8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828331E511
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237646; cv=none; b=GipBxmr7XAtXqqL+cCLSYPT7hxlo4AtpM7WnIwsaGqijP8S3nFikWrSCYttKHix34rhKln/7++xQZjcDYmdP0wGmRZEy+NmZCGNAE9K6wbKSAGQ/dSNIDmAbgMSd2gMx/VskbEwXFO0/M0YpowOsPAjNdFFIn0VA8D3HgmMcOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237646; c=relaxed/simple;
	bh=RoYjshpK+IIWVzGdkpETLtdAQBZgob90X5dRStXofUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LAiTRqO54Zik1HsjWNHHiPJ1T6n9ITsocxNrLI0mzArExRMXakQKe7OcLv8c4kfbGuVjTh+D9r4vlMGFluJEM0Esy4TediNLkWYk3cbODAGnaCkRmQaRqfuGyiEwbLa9Qf2q98cS+YrUbLzknQ2vYY3/dKCS+LjHvl7Z3zMkTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1aMivJBH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O+Cmi+h8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719237642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ezCGn8nfKbzDHH0VqZ5NtPqo/qvHBmxvSLOTRshbd5s=;
	b=1aMivJBHjH3itagBiIF4ukble+L61EQrwyo6zgz2MqPNspt+EFA5KFj70QrscmcbzZinEv
	q1txSFelP+fOZ3Y+gz4UGXS8fANkKqFPsYxPn4GAzEf8TvGNMbzKwcdg7qN/eSHE76t7PS
	FmS5UivcMISjKTlC11Y/uEYd86JiUe0+nHdUzqbSbWNuJyL74mLA/Yee1k81DBTsb3/9Ot
	2gsyIpqazGIxVvfc/rXAXB62Sl7ghJul/Rl2BYtd0nyI6ywMK1DLu8m4PVNLBomQmvd6Mk
	uJbLhyVF+m6852v0mFGFSy1pcqTkuL7/jGlYs92bSaVqJjYxTM1jJ5XbAXqQNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719237642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ezCGn8nfKbzDHH0VqZ5NtPqo/qvHBmxvSLOTRshbd5s=;
	b=O+Cmi+h8qhiqCIMCHqxOZCIn6eU6IFJn2CGDWCYX886N16xj8sWu4a0RmkvUH0egsoVaxh
	UPyiIXIaeb6PrsCA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: 8188f: Limit TX power index
Date: Mon, 24 Jun 2024 16:00:37 +0200
Message-Id: <20240624140037.231657-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TX power index is read from the efuse on init, the values get written to
the TX power registers when the channel gets switched.

When the chip has not yet been calibrated, the efuse values are 0xFF,
which on some boards leads to USB timeouts for reading/writing registers
after the first frames have been sent.

The vendor driver (v5.11.5-1) checks for these invalid values and sets
default values instead. Implement something similar in
rtl8188fu_parse_efuse().

Fixes: c888183b21f3 ("wifi: rtl8xxxu: Support new chip RTL8188FU")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
index bd5a0603b4a23..3abf14d7044f3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
@@ -697,9 +697,14 @@ static void rtl8188fu_init_statistics(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_write32(priv, REG_OFDM0_FA_RSTC, val32);
 }
 
+#define TX_POWER_INDEX_MAX 0x3F
+#define TX_POWER_INDEX_DEFAULT_CCK 0x22
+#define TX_POWER_INDEX_DEFAULT_HT40 0x27
+
 static int rtl8188fu_parse_efuse(struct rtl8xxxu_priv *priv)
 {
 	struct rtl8188fu_efuse *efuse = &priv->efuse_wifi.efuse8188fu;
+	int i;
 
 	if (efuse->rtl_id != cpu_to_le16(0x8129))
 		return -EINVAL;
@@ -713,6 +718,16 @@ static int rtl8188fu_parse_efuse(struct rtl8xxxu_priv *priv)
 	       efuse->tx_power_index_A.ht40_base,
 	       sizeof(efuse->tx_power_index_A.ht40_base));
 
+	for (i = 0; i < ARRAY_SIZE(priv->cck_tx_power_index_A); i++) {
+		if (priv->cck_tx_power_index_A[i] > TX_POWER_INDEX_MAX)
+			priv->cck_tx_power_index_A[i] = TX_POWER_INDEX_DEFAULT_CCK;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(priv->ht40_1s_tx_power_index_A); i++) {
+		if (priv->ht40_1s_tx_power_index_A[i] > TX_POWER_INDEX_MAX)
+			priv->ht40_1s_tx_power_index_A[i] = TX_POWER_INDEX_DEFAULT_HT40;
+	}
+
 	priv->ofdm_tx_power_diff[0].a = efuse->tx_power_index_A.ht20_ofdm_1s_diff.a;
 	priv->ht20_tx_power_diff[0].a = efuse->tx_power_index_A.ht20_ofdm_1s_diff.b;
 
-- 
2.39.2


