Return-Path: <linux-wireless+bounces-15090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED9B9C079E
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83383B2249C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F056212D05;
	Thu,  7 Nov 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P9xQk2d+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C3212180
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986436; cv=none; b=uPJ93FB78KOe7/KKVu5+VDOB2ojbqyecJa/4ENw9WlPL2r9SDorWdpMprD5LMjjrIZJDdCqXSWg3RTLzY7lZ4cRZZQWYL1CxpitpvTHKQxFEJoHlhS2q1SNEU3o4Vc9i5/aNg0mflR9NgJvvgcY7bDDXzuSEUknLVoAJqHg807Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986436; c=relaxed/simple;
	bh=eQNfJTTXuBMkIld/UqlY+MLCw44+Vjr8DRGWIIITx3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3RJuCuw4EnfTs/ze3i3qC5hhR3AHJdr3CWhQ62/n6/bnw00M1kV1P//5zXHbHVU2y+QqPtDaMfAuZdnB0LMthBgpV6Ic0g59JGoLa+xyJPhFctYj5CcxFp1BghPSzrXJP1lFdTtl+LG7mhyKWbcDRHZ1bIhPGh1LZQ8Pw1V0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P9xQk2d+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aPMeNjBGCE7sdNVWDvuDbCesnkKVRkTEHukCFI1Mqdc=; b=P9xQk2d+71aBiW0Hjg6ggv5J8w
	zIMAwvbTgvBoAmhVd2IdyZJ5hauFWwV/hzE1eI9cbDFII0Op7YhcbV5O1/aYkMHJxfGoE9DirhQY9
	6MW8XwBzql26VxrVkRQ7t2Tx9EzsteMCJmopmumCGPv1GcvbSkUx95o9MGM5FTIP9qCdE0t14at/e
	DGnVqYnCjMYFGjjL2rMh2kpWcAkTrPjLULKKmd71zjC/7JRWfc7XoDLPPqbmq7m0PZkuzWppgVInr
	7qrRU9V4B6j0uJ+jF4Z6EO9r6TKLPolZpE0M+scZZPf4WNDkvKJm4+DN/axsBVUgjfrfyTuDuoPlF
	NDZY6o7Q==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t92dz-003Zsz-V8; Thu, 07 Nov 2024 14:33:52 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net 5/5] wifi: rtlwifi: usb: fix workqueue leak when probe fails
Date: Thu,  7 Nov 2024 10:33:22 -0300
Message-Id: <20241107133322.855112-6-cascardo@igalia.com>
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

rtl_init_core creates a workqueue that is then assigned to rtl_wq.
rtl_deinit_core does not destroy it. It is left to rtl_usb_deinit, which
must be called in the probe error path.

Fixes: 2ca20f79e0d8 ("rtlwifi: Add usb driver")
Fixes: 851639fdaeac ("rtlwifi: Modify some USB de-initialize code.")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 8ec687fab572..0368ecea2e81 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1039,6 +1039,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 	wait_for_completion(&rtlpriv->firmware_loading_complete);
 	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 error_out:
+	rtl_usb_deinit(hw);
 	rtl_deinit_core(hw);
 error_out2:
 	_rtl_usb_io_handler_release(hw);
-- 
2.34.1


