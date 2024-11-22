Return-Path: <linux-wireless+bounces-15607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B5B9D630F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75370B23688
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3963B1DEFC6;
	Fri, 22 Nov 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mYD0xa2U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A501DEFF0
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296504; cv=none; b=mVcx923xMHZeg5LKancAe/Lhxx13sCrce5E0yxMiWkRn4cOxTBFfzrq1WryrZdKDmN51oUbHM2IzIVv/yuuGOepIUUkz/aFB8apD8spaUefUihijWJ6BlcGIc+1dgpTTS0Y0XiBHg60nxXAKgzrnBhVC+XSsFlBnulQRX0hpQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296504; c=relaxed/simple;
	bh=6sLqr8T5oNllPie0FXtuPfOux4BMIjy1DXSCtbETzj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avSZ7KlOU4+XfEpoC6ruugK026sdrWmCPFpRVIypBLkNmfb/JIzA8RaCjqjiLtaFw67lHb/u6JgULjaNIiXf9PSx4A8LC3Mt7MNILQWgGkT5tZlQJG0Rg2HiKfnz+Lmmmvb+ksauyHUyunzUzmCt6diQY1OCMlKH7+uMEYepEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mYD0xa2U; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=nDEN/3ps0ao/Me8pYKHt+y4J4UsZ7gYnppCHKQT8FCg=; b=mYD0xa2UNPcnKt4+8dreGNhx9a
	CtZbAi9iGxYAtjXYvd/FthUBTaGUpFPtuCLM0aJ42HoqA4NKPidvY91tjJCtlrkEP7n5acVbCXkmS
	/nDXLm5Q/KDH54BSvxFUkMdeMf/X8nOPAyKGOktaFxDHhL+c2VukdhIuzA6KzKVrRbThaKEQraIry
	TK8mp35HGYUnzsqSeyMflKd9MMr45b3anWxv8C5E3C0CD4mX7F7egvmIjEDefRmr8IYKo+5iMIzt/
	IA+VDgUfZK8TeLvdsIbhsiRu9Z0NLr4Bdk7ncA0JyZX/Fmgnq9iUlG94QgeUvvSggQo8MDXPLbxBD
	4QJDPV5Q==;
Received: from 179-125-75-203-dinamico.pombonet.net.br ([179.125.75.203] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tEXS7-00B3IM-Oc; Fri, 22 Nov 2024 18:28:20 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 3/4] wifi: rtlwifi: fix memory leaks and invalid access at probe error path
Date: Fri, 22 Nov 2024 14:27:17 -0300
Message-Id: <20241122172718.465539-4-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122172718.465539-1-cascardo@igalia.com>
References: <20241122172718.465539-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deinitialize at reverse order when probe fails.

When init_sw_vars fails, rtl_deinit_core should not be called, specially
now that it destroys the rtl_wq workqueue.

And call rtl_pci_deinit and deinit_sw_vars, otherwise, memory will be
leaked.

Remove pci_set_drvdata call as it will already be cleaned up by the core
driver code and could lead to memory leaks too. cf. commit 8d450935ae7f
("wireless: rtlwifi: remove unnecessary pci_set_drvdata()") and commit
3d86b93064c7 ("rtlwifi: Fix PCI probe error path orphaned memory").

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index e60ac910e750..a870117cf12a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -2165,7 +2165,7 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
 		pr_err("Can't init_sw_vars\n");
 		err = -ENODEV;
-		goto fail3;
+		goto fail2;
 	}
 	rtl_init_sw_leds(hw);
 
@@ -2183,14 +2183,14 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	err = rtl_pci_init(hw, pdev);
 	if (err) {
 		pr_err("Failed to init PCI\n");
-		goto fail3;
+		goto fail4;
 	}
 
 	err = ieee80211_register_hw(hw);
 	if (err) {
 		pr_err("Can't register mac80211 hw.\n");
 		err = -ENODEV;
-		goto fail3;
+		goto fail5;
 	}
 	rtlpriv->mac80211.mac80211_registered = 1;
 
@@ -2213,9 +2213,12 @@ int rtl_pci_probe(struct pci_dev *pdev,
 	set_bit(RTL_STATUS_INTERFACE_START, &rtlpriv->status);
 	return 0;
 
-fail3:
-	pci_set_drvdata(pdev, NULL);
+fail5:
+	rtl_pci_deinit(hw);
+fail4:
 	rtl_deinit_core(hw);
+fail3:
+	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 
 fail2:
 	if (rtlpriv->io.pci_mem_start != 0)
-- 
2.34.1


