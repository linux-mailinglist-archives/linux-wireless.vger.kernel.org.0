Return-Path: <linux-wireless+bounces-15087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150809C0798
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED4A283C01
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE121019E;
	Thu,  7 Nov 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="of86pK5J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D6720FAA2
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986426; cv=none; b=ssFvtYWr8WXAhSgMIaOGdor/zpk8Wunpkww3mqzXMAK5MvqxbUjwvg2BCwltxnrtoYzGNPHX3ZYCMmMXWOPK8cmGCGnkzNCtOKYl+etxzXtwnd1V22YmkmH3S8NHLnagQbP2HFy5ZfLZ9TeQ7bP4+90Pn+wpxlRPbx6PoZPxvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986426; c=relaxed/simple;
	bh=Mujlp8F4WdBBBXP9ogkzZnJvEwIE283S23NcqLfmEs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5BeS4jDUVb5Hi+Q7szH1Y2M3pkAC1FwUqAASH+NKJhLaYsJILNy81Yj7jhMnTyTgsiCDsIOD2SH10Mwa/iIOdP3Qa/yWY9e650yrTFzPr0kenaUv+Z1lwMu3NHBarPDwpyHFDq59KSk5h4gKH2qKTJTp5nkaqN3SMiHh3JKkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=of86pK5J; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WW/Cyrl5gTAPbK9GlkFqWkrgh4JE370WcQepVQicaKY=; b=of86pK5JETZzAMZRZbL0yHxsMA
	UQkUYc32fiFy18udPJTCRg0Gx6oxDPCiO3EmcAf4mHM8XRPpyqgFFlVJlLPpQSHtL2nQEnDOtdqZQ
	WoTqNHxfXTKm3v+bg8cEhxr9A4opJFYP/aCRkg/JTaN0KeauDspk1lyBRhAO8kMghuQxfB6Txnaxv
	6v2M0fFYQTToKpNJzPUUKmxxGPfY3on1Fm9xTKUNZkh9Hs6fSsllQC0OLrqiMOwLzHN0Dlp0J4zlG
	MW4xGcBOfKp5n0QdxtAXa61ZUm+Phg3mULNrnXijtiV59G/XEq9fvkBos+iZd5G/L10A34nCcUYWm
	KcU4B3rg==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t92dq-003Zsz-9M; Thu, 07 Nov 2024 14:33:42 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net 2/5] wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
Date: Thu,  7 Nov 2024 10:33:19 -0300
Message-Id: <20241107133322.855112-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107133322.855112-1-cascardo@igalia.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like in commit 4dfde294b979 ("rtlwifi: rise completion at the last
step of firmware callback"), only signal completion once the function is
finished. Otherwise, the module removal waiting for the completion could
free the memory that the callback will still use before returning.

Fixes: b0302aba812b ("rtlwifi: Convert to asynchronous firmware load")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index bbf8ff63dced..e63c67b1861b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -64,22 +64,23 @@ static void rtl92se_fw_cb(const struct firmware *firmware, void *context)
 
 	rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
 		"Firmware callback routine entered!\n");
-	complete(&rtlpriv->firmware_loading_complete);
 	if (!firmware) {
 		pr_err("Firmware %s not available\n", fw_name);
 		rtlpriv->max_fw_size = 0;
-		return;
+		goto exit;
 	}
 	if (firmware->size > rtlpriv->max_fw_size) {
 		pr_err("Firmware is too big!\n");
 		rtlpriv->max_fw_size = 0;
 		release_firmware(firmware);
-		return;
+		goto exit;
 	}
 	pfirmware = (struct rt_firmware *)rtlpriv->rtlhal.pfirmware;
 	memcpy(pfirmware->sz_fw_tmpbuffer, firmware->data, firmware->size);
 	pfirmware->sz_fw_tmpbufferlen = firmware->size;
 	release_firmware(firmware);
+exit:
+	complete(&rtlpriv->firmware_loading_complete);
 }
 
 static int rtl92s_init_sw_vars(struct ieee80211_hw *hw)
-- 
2.34.1


