Return-Path: <linux-wireless+bounces-41-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C27F6ED3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 09:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19D51C20E4D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF913FFE;
	Fri, 24 Nov 2023 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SL5iB9l8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FE21BD;
	Fri, 24 Nov 2023 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815716; x=1732351716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhgbBzthM/WTBTOWAYA/GP6MTbrtMnKaOGmStuDv10k=;
  b=SL5iB9l8TWry/wB6T1WaO2ziRQ2EArsA9JZKEdCUXhyGnzISFGVxfpqF
   toa2U4iqFlK4TQZ8u/SUDkYgc1B6J2SVrPbNv1seL6wvPJz0q40PAGVm8
   LzCT+uL4a4+gaw4yK0ExUjDxVE38OTgd+9fQmBwURkGXixg0hN3iqVm51
   hdzy0QbBZg3Qwo/v4otn/MU96b2pZkk96jgCRmgS79g0GBWRSxgkBqOjA
   EQK/iXohqgVnTep7QB5URnzJCiA18Qg9rsfrARHJK8qPEzcDJI51lePwG
   AivoaTy6AqL2BaGcTSWEVcTDND+Z0bmzAToxcHlENnDGPAHIIGMJC0Z1V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456728897"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="456728897"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760900448"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="760900448"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 07/10] wifi: rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
Date: Fri, 24 Nov 2023 10:47:22 +0200
Message-Id: <20231124084725.12738-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
References: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add local variable pdev to shorten rtlpci->pdev.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 7877509c34c7..7cc648d49f2d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2270,10 +2270,11 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
+	struct pci_dev *pdev = rtlpci->pdev;
 	u8 pmcs_reg;
 	u8 pm_cap;
 
-	pm_cap = pci_find_capability(rtlpci->pdev, PCI_CAP_ID_PM);
+	pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
 	if (!pm_cap) {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
 			"Cannot find PME Capability\n");
@@ -2283,13 +2284,13 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 	/* Get the PM CSR (Control/Status Register),
 	 * The PME_Status is located at PM Capatibility offset 5, bit 7
 	 */
-	pci_read_config_byte(rtlpci->pdev, pm_cap + 5, &pmcs_reg);
+	pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
 
 	if (pmcs_reg & BIT(7)) {
 		/* Clear PME_Status with write */
-		pci_write_config_byte(rtlpci->pdev, pm_cap + 5, pmcs_reg);
+		pci_write_config_byte(pdev, pm_cap + 5, pmcs_reg);
 		/* Read it back to check */
-		pci_read_config_byte(rtlpci->pdev, pm_cap + 5, &pmcs_reg);
+		pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
 			"Clear PME status 0x%2x to 0x%2x\n",
 			pm_cap + 5, pmcs_reg);
-- 
2.30.2


