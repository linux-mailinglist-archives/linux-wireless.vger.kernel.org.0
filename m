Return-Path: <linux-wireless+bounces-15088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48D9C0799
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57F31F23558
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C86210197;
	Thu,  7 Nov 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S/Ci8Dax"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E072101BF
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986429; cv=none; b=EA+sLZ1kG5p+iJi2J9S0E6AS3kRnlv4H3UNGd/IYvJAbVGlfBeETBncOV9qWciLRhIjGD/ZmKJsP0TLvDyoHFpMeGQRVt0ne0GO40e3MYlvHzTNRh3EW+5+BTWQ1LdkE1gmBKMGHDvyOJUuDgj2IR3hO+001p0HQClDuzyHm2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986429; c=relaxed/simple;
	bh=bzAU50gtgYaeYf5HMsuxid0+7GYR7kmuUtzYsGfLrBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rrpw+PBckFt6O4xB8WzjS67c1Jwq70OtJ2ZHmI7Ezk1vWAlQ0fpDTM6Vg8GCWH2puS3QqjwuALDfg1Yo+ekH21ZsoKG9EQhXNEDVKwiNLXKUeOnlbfNd+XgcosYJiCp7NBqMU82w2RnxxqFY7N+nMPGYOdrtWQ03zbo+sN0HKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S/Ci8Dax; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nKAkaAVraMrH3KpRPmD+jKtH0uUtbhfUjK9MHwH4FyU=; b=S/Ci8DaxO2o35lmIiC6Kg4jKnG
	IEz7hkoFBb1veYwv2zrVmTezIYhnCz4GQIaDp7Yk+nJUck4kfHhxXXJu6Lw33z21Q7bwk1XqQ4vDM
	PWZpLqCLj9pGDCjxTJvSeR29R9QGDUR4uIcZF9mGtOeo25VmY3KgHeoSVk9OELqXWYIMPsTdJyUIR
	fja5lT4rNlUxS13zqhvx+vy/CSsOGJKpY7W9EPiFhyRpiom1e74PhkaJyCm2n7RF1R3uju8JqaedR
	d6liM1M7OZUiFnatLp57Ki6C8m6C7xOd+Ag3sDfysknwPMmObE/9pjXWTYqD2Nq8I9AYUB4jnVgHj
	giL0Mdqg==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t92dt-003Zsz-HL; Thu, 07 Nov 2024 14:33:46 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net 3/5] wifi: rtlwifi: wait for firmware loading before releasing memory
Date: Thu,  7 Nov 2024 10:33:20 -0300
Message-Id: <20241107133322.855112-4-cascardo@igalia.com>
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

At probe error path, the firmware loading work may have already been
queued. In such a case, it will try to access memory allocated by the probe
function, which is about to be released. In such paths, wait for the
firmware worker to finish before releasing memory.

Fixes: a7f7c15e945a ("rtlwifi: rtl8192cu: Free ieee80211_hw if probing fails")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index c3aa0cd9ff21..c27b116ccdff 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1028,13 +1028,15 @@ int rtl_usb_probe(struct usb_interface *intf,
 	err = ieee80211_register_hw(hw);
 	if (err) {
 		pr_err("Can't register mac80211 hw.\n");
-		goto error_out;
+		goto error_init_vars;
 	}
 	rtlpriv->mac80211.mac80211_registered = 1;
 
 	set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
 	return 0;
 
+error_init_vars:
+	wait_for_completion(&rtlpriv->firmware_loading_complete);
 error_out:
 	rtl_deinit_core(hw);
 error_out2:
-- 
2.34.1


