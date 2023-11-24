Return-Path: <linux-wireless+bounces-42-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A277F6ED6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 09:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26538B20EB7
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82491156C3;
	Fri, 24 Nov 2023 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCPg5cI3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A810FE;
	Fri, 24 Nov 2023 00:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815724; x=1732351724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cnRhqRHN/FCSPFyKVdYVH7cYpVC1KUyHAWcRs58SbBg=;
  b=iCPg5cI3BJ4bEttl+g8b/DLN0nmX+9ywudf7qfg10EGj1cw4RNs3IU5/
   QZH2PDY9iB8gRKFGvaunG372c/tPEECq1wurqfsrarDv7w/iffGf4IkkV
   AdxmMUyPd7UXYWcjEmru/K8MenIL8UZd9TlVPnXPbi0glYSJrq5Ai+SXR
   0tQwhOFtgVuN6TQ64e3gV1mTm9ZOgwBuOX6z+mxxA4LMX34oIZIbH/e2g
   D7rvsSbSfpByhU4E9We63oXwG4Ad8bKRrUWjkcGGIlQFmeEwYcFteUid4
   8JI3/mfnQxuZCn/nmZgpaAxzajs+2fW2s9fI3RJSR2JZ2njIN7Bi5qs7J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456728916"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="456728916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760900499"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="760900499"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 08/10] wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
Date: Fri, 24 Nov 2023 10:47:23 +0200
Message-Id: <20231124084725.12738-9-ilpo.jarvinen@linux.intel.com>
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

_rtl8821ae_clear_pci_pme_status() accesses the upper byte of the Power
Management Control/Status register (PMCS) with literal 5 offset.

Access the entire PMCS register using defines from pci_regs.h to
improve code readability.

While at it, remove the obvious comment and tweak debug prints
slightly to not sound misleading.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 7cc648d49f2d..f4b232f038a9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -2271,7 +2271,7 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct pci_dev *pdev = rtlpci->pdev;
-	u8 pmcs_reg;
+	u16 pmcs_reg;
 	u8 pm_cap;
 
 	pm_cap = pci_find_capability(pdev, PCI_CAP_ID_PM);
@@ -2281,23 +2281,16 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 		return;
 	}
 
-	/* Get the PM CSR (Control/Status Register),
-	 * The PME_Status is located at PM Capatibility offset 5, bit 7
-	 */
-	pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
-
-	if (pmcs_reg & BIT(7)) {
+	pci_read_config_word(pdev, pm_cap + PCI_PM_CTRL, &pmcs_reg);
+	if (pmcs_reg & PCI_PM_CTRL_PME_STATUS) {
 		/* Clear PME_Status with write */
-		pci_write_config_byte(pdev, pm_cap + 5, pmcs_reg);
-		/* Read it back to check */
-		pci_read_config_byte(pdev, pm_cap + 5, &pmcs_reg);
+		pci_write_config_word(pdev, pm_cap + PCI_PM_CTRL, pmcs_reg);
+		pci_read_config_word(pdev, pm_cap + PCI_PM_CTRL, &pmcs_reg);
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-			"Clear PME status 0x%2x to 0x%2x\n",
-			pm_cap + 5, pmcs_reg);
+			"Cleared PME status, PMCS reg = 0x%4x\n", pmcs_reg);
 	} else {
 		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
-			"PME status(0x%2x) = 0x%2x\n",
-			pm_cap + 5, pmcs_reg);
+			"PMCS reg = 0x%4x\n", pmcs_reg);
 	}
 }
 
-- 
2.30.2


