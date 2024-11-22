Return-Path: <linux-wireless+bounces-15606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5E99D630E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 18:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EE5B21A35
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1E11DF255;
	Fri, 22 Nov 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="U80MHH/k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A81DEFC6
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296502; cv=none; b=ZI3mafB5VSBZUeD/dXB+BCnlxEmmr2tTTmVqkPgtUtqawy8EC80ZJbkLbVON+JsNRiyGXShs9Ba2nvgTxNv/iu87++v3AJp63LBtdDRQT51fCF3nbpFAD56FTb9ssyIEXEvxM8oCue4XdPGHrpj2DeVlBhWA6SzhBO4wg6TmOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296502; c=relaxed/simple;
	bh=iWPQ8g7th1w3oWFGbY9qUDIEz6ZHYKxaUceh3CGcUYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NF0QmmC70FoQbbrJmRFZSrKY0XLj5MrQA4hEd1jLmUsr6VXwvCW1TuaqDMTj/VIY7Vc2tNqczCdx/ClInn6rBWF2s3d+fjLXYF46eKqAt+3HVFSXqhagWUDqyf9NnoOip+Q6MO1KAG7uvkr8lGUdsXF7VqIz8p7PWPUtWeZ8X9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=U80MHH/k; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/f64KhTC5hBXeQ4DukwxE514rk0rPBksaCe/5QmBVJY=; b=U80MHH/knAiM8MFx0fPcIAY58x
	LST6Zqr7D0oHyYNjEj7BxNsuKWnEvo/Y3GjFG/u32/hzpbZYW7KVQ1SYZR6fPfR24ja8sMf2MzxSJ
	rtFuqjjzYW+VCTJzlN/UfxxC32TzLNjgeDbFGJ4vSDyuQtNGcWoTMFltF/az//2CRzwD1fhgaLWTy
	TbOaSnGaP1copqEISvWHUgAKYupfRSzum1oKKPgmTBrvmWm1p3zPt/ZYsrHIpjh0YQUQdZ11rur1H
	fYl1lgY0H+flYeEpX59e/RqHtXqsHTRQc2EIJ5ApOoIF14kfxJX3wbPwyQdZmqOwapbrg+X7AxiHu
	DUzaO/eQ==;
Received: from 179-125-75-203-dinamico.pombonet.net.br ([179.125.75.203] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tEXS4-00B3IM-QF; Fri, 22 Nov 2024 18:28:17 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 2/4] wifi: rltwifi: destroy workqueue at rtl_deinit_core
Date: Fri, 22 Nov 2024 14:27:16 -0300
Message-Id: <20241122172718.465539-3-cascardo@igalia.com>
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

rtl_wq is allocated at rtl_init_core, so it makes more sense to destroy it
at rtl_deinit_core. In the case of USB, where _rtl_usb_init does not
require anything to be undone, that is fine. But for PCI, rtl_pci_init,
which is called after rtl_init_core, needs to deallocate data, but only if
it has been called.

That means that destroying the workqueue needs to be done whether
rtl_pci_init has been called or not. And since rtl_pci_deinit was doing it,
it has to be moved out of there.

It makes more sense to move it to rtl_deinit_core and have it done in both
cases, USB and PCI.

Since this is a requirement for a followup memory leak fix, mark this as
fixing such memory leak.

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/base.c | 5 +++++
 drivers/net/wireless/realtek/rtlwifi/pci.c  | 2 --
 drivers/net/wireless/realtek/rtlwifi/usb.c  | 5 -----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index fd28c7a722d8..062d5a0a4c11 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -575,9 +575,14 @@ static void rtl_free_entries_from_ack_queue(struct ieee80211_hw *hw,
 
 void rtl_deinit_core(struct ieee80211_hw *hw)
 {
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	rtl_c2hcmd_launcher(hw, 0);
 	rtl_free_entries_from_scan_list(hw);
 	rtl_free_entries_from_ack_queue(hw, false);
+	if (rtlpriv->works.rtl_wq) {
+		destroy_workqueue(rtlpriv->works.rtl_wq);
+		rtlpriv->works.rtl_wq = NULL;
+	}
 }
 EXPORT_SYMBOL_GPL(rtl_deinit_core);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 4388066eb9e2..e60ac910e750 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1656,8 +1656,6 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
 	synchronize_irq(rtlpci->pdev->irq);
 	tasklet_kill(&rtlpriv->works.irq_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
-
-	destroy_workqueue(rtlpriv->works.rtl_wq);
 }
 
 static int rtl_pci_init(struct ieee80211_hw *hw, struct pci_dev *pdev)
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 0368ecea2e81..f5718e570011 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -629,11 +629,6 @@ static void _rtl_usb_cleanup_rx(struct ieee80211_hw *hw)
 	tasklet_kill(&rtlusb->rx_work_tasklet);
 	cancel_work_sync(&rtlpriv->works.lps_change_work);
 
-	if (rtlpriv->works.rtl_wq) {
-		destroy_workqueue(rtlpriv->works.rtl_wq);
-		rtlpriv->works.rtl_wq = NULL;
-	}
-
 	skb_queue_purge(&rtlusb->rx_queue);
 
 	while ((urb = usb_get_from_anchor(&rtlusb->rx_cleanup_urbs))) {
-- 
2.34.1


