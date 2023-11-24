Return-Path: <linux-wireless+bounces-36-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D11617F6EC9
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71563B20FC8
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242E65C;
	Fri, 24 Nov 2023 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6+tHjiH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50B810C8;
	Fri, 24 Nov 2023 00:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815678; x=1732351678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ETSthbj996fIvvlpg9K44Y+DLYz4SkudAGG/TzCRFls=;
  b=F6+tHjiHdN+OJX5EISq0E+nCCi8Cw1ANNC22hka/e2wAYlYL2mJQPbgj
   EPY6EEmfIbHqZolWHROPgBIFcFnMIldK10/YC/tz25PMC35hKU+xBoYCz
   m3ZDwwGAAbkJ2rHAQkV7X3WVUnLDNg5cPz3bMe0fpdhyqolF6nKkolNHx
   7XqkqFfLuKThsPVUzvIn1I1X3YYyijoOWyefByMKc2rdyhv8BW0KXUdi7
   99pMsLy7f1jEIHMWsfjRq8byzUQvEADE7iPJsQFt7tvVG/1wxRJn4qBpB
   XX/UvH4bCg6CBlxrpKL7aQWM8DJpzrGHwMq+gj2KypfiIUmA2Q2PiLIul
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13945409"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="13945409"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833640453"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833640453"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:47:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 02/10] wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
Date: Fri, 24 Nov 2023 10:47:17 +0200
Message-Id: <20231124084725.12738-3-ilpo.jarvinen@linux.intel.com>
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

The rtlwifi driver comes with custom code to write into PCIe Link
Control register. RMW access for the Link Control register requires
locking that is already provided by the standard PCIe capability
accessors.

Convert the custom RMW code writing into LNKCTL register to standard
RMW capability accessors. The accesses are changed to cover the full
LNKCTL register instead of touching just a single byte of the register.

Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 206eca310cd7..b118df035243 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -164,21 +164,29 @@ static bool _rtl_pci_platform_switch_device_pci_aspm(
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
+	value &= PCI_EXP_LNKCTL_ASPMC;
+
 	if (rtlhal->hw_type != HARDWARE_TYPE_RTL8192SE)
-		value |= 0x40;
+		value |= PCI_EXP_LNKCTL_CCC;
 
-	pci_write_config_byte(rtlpci->pdev, 0x80, value);
+	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC | value,
+					   value);
 
 	return false;
 }
 
-/*When we set 0x01 to enable clk request. Set 0x0 to disable clk req.*/
-static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u8 value)
+/* @value is PCI_EXP_LNKCTL_CLKREQ_EN or 0 to enable/disable clk request. */
+static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u16 value)
 {
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 
-	pci_write_config_byte(rtlpci->pdev, 0x81, value);
+	value &= PCI_EXP_LNKCTL_CLKREQ_EN;
+
+	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_CLKREQ_EN,
+					   value);
 
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192SE)
 		udelay(100);
@@ -259,7 +267,8 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
 
 	if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_CLK_REQ) {
 		_rtl_pci_switch_clk_req(hw, (ppsc->reg_rfps_level &
-					     RT_RF_OFF_LEVL_CLK_REQ) ? 1 : 0);
+					     RT_RF_OFF_LEVL_CLK_REQ) ?
+					     PCI_EXP_LNKCTL_CLKREQ_EN : 0);
 		RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_CLK_REQ);
 	}
 	udelay(100);
-- 
2.30.2


