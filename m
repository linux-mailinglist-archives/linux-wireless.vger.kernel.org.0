Return-Path: <linux-wireless+bounces-15986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E39E7786
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 18:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5891D16A13D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799FC22068A;
	Fri,  6 Dec 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dnyrRS4T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBDC220684
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506650; cv=none; b=c+VZzL0W0wox9nlAA2ZoPix6nLvSLNfjQca3WlJV+bZYfwYLe+IGWBaNb+E0Zjj0sBIt7U0xZma/hVn6nWyAVOtxQkDpzaLKiKsTuqdqGQrHGb/iPhOf94l8dxl1CIlSqixm9ZNVQ4wJeSgXOo64aw8/DuJD/0fS6rQYgbNvAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506650; c=relaxed/simple;
	bh=5r3mrCOVLqFMv9aq+h3KDAg5zuZGvOYQmiW9XDFW2YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ScX0gbmdvfwQKzP92152lcXKp1iXqxDU+oINHLRwPuzlsqvQXjdCsCjDBUn4vTWoCshpU/IQ/mpn8gZMiEsuCEXZr7oJezBJDlK447Ze8juvKoQ0Ir2vHvFFfx3B7qQD6YUevEIf010OUpgovYQyv6crYQxu5xQuzOX0+VWfeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dnyrRS4T; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e9Ouaw0EXyJLfuNdzRNC/kDmvlzDTzVm1DTISvpNTyw=; b=dnyrRS4TA9v+vs8k6hoLDqRjhH
	1hafM3E2AcInBr1FJ6Xnv+94Auw7d6swcsn27zQ/YDF+awZW5ysB0Rc6e3tnp3FQfSR1oOJNJcz3c
	SSFhiHWtuewTBDcA1rRjoZOhIVz0VNSdz4b2Cm08rRLuh6522PlQNV2y7PsNjQcBV9Uoml6GxNbnK
	tUxl85dJOfXfTwXY08C8pbDR1DH+xEjqtQ7t7z6D/bwGs3q5KrQHPKYu2eaHzs0w0UXoAKifdJzrX
	GUb1bw97+lxwds3lzSO0iApHwIBc93LTVJ9d2E20RWYT+PLP5Fe3mAPLO3a4E0unkT9jTBNpWf2VH
	Cq1519yw==;
Received: from 179-125-79-245-dinamico.pombonet.net.br ([179.125.79.245] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tJcGb-00HUvD-C6; Fri, 06 Dec 2024 18:37:25 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH v2 2/4] wifi: rtlwifi: destroy workqueue at rtl_deinit_core
Date: Fri,  6 Dec 2024 14:37:11 -0300
Message-Id: <20241206173713.3222187-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206173713.3222187-1-cascardo@igalia.com>
References: <20241206173713.3222187-1-cascardo@igalia.com>
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
 drivers/net/wireless/realtek/rtlwifi/base.c | 6 ++++++
 drivers/net/wireless/realtek/rtlwifi/pci.c  | 2 --
 drivers/net/wireless/realtek/rtlwifi/usb.c  | 5 -----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index fd28c7a722d8..ff61867d142f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -575,9 +575,15 @@ static void rtl_free_entries_from_ack_queue(struct ieee80211_hw *hw,
 
 void rtl_deinit_core(struct ieee80211_hw *hw)
 {
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
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


