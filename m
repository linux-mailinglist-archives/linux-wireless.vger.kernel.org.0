Return-Path: <linux-wireless+bounces-37-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A27067F6ECA
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 09:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F641C209B4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38084685;
	Fri, 24 Nov 2023 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSFHm9IV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1D5D72;
	Fri, 24 Nov 2023 00:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815685; x=1732351685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+CIZTzt+2vO07tQNaGqfZ36vMzaw9hd5OfqldzrIuA=;
  b=dSFHm9IVUGc9witI4hNUpBUczLbDtldUhpRnUMk5ur3fsvSnJVEjReVj
   UDPmU4ZQTTBYiSMlZ2fCIc9ICg+xvKQVgXJOGhW3lpC915hQ1x7yfg94l
   mNBy2bMjtLpDCFDxYLRLbv468wO5j+B1y8CdqL9eMi8tTVRPB+f+VbhAB
   YZDe+Qrdn1/7Tp0acYEKiSeQTz6eSjRUhvFV4xUdOUPSRP8u2JcxknmgD
   n+26cZhEDLOZeRycR3Fr3ZYM8W/vWD/1AdqLd/g1ve4JmEpuK46lLJlV4
   uDNKW6iTMWDBbj/Kmo7N+XxFxlurSPdetn+SzuZG3tXtXgDvtQZZjvWkq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13945456"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="13945456"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833640496"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833640496"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 03/10] wifi: rtlwifi: Convert to use PCIe capability accessors
Date: Fri, 24 Nov 2023 10:47:18 +0200
Message-Id: <20231124084725.12738-4-ilpo.jarvinen@linux.intel.com>
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

The rtlwifi driver accesses PCIe capabilities through custom config
offsets. Convert the accesses to use the normal PCIe capability
accessors.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index b118df035243..a29d7df6fff5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -64,7 +64,7 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
-	u8 init_aspm;
+	u16 init_aspm;
 
 	ppsc->reg_rfps_level = 0;
 	ppsc->support_aspm = false;
@@ -151,9 +151,10 @@ static void _rtl_pci_update_default_setting(struct ieee80211_hw *hw)
 	/* toshiba aspm issue, toshiba will set aspm selfly
 	 * so we should not set aspm in driver
 	 */
-	pci_read_config_byte(rtlpci->pdev, 0x80, &init_aspm);
+	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &init_aspm);
 	if (rtlpriv->rtlhal.hw_type == HARDWARE_TYPE_RTL8192SE &&
-	    init_aspm == 0x43)
+	    ((u8)init_aspm) == (PCI_EXP_LNKCTL_ASPM_L0S |
+				PCI_EXP_LNKCTL_ASPM_L1 | PCI_EXP_LNKCTL_CCC))
 		ppsc->support_aspm = false;
 }
 
@@ -203,7 +204,7 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	/*Retrieve original configuration settings. */
 	u8 linkctrl_reg = pcipriv->ndis_adapter.linkctrl_reg;
 	u16 aspmlevel = 0;
-	u8 tmp_u1b = 0;
+	u16 tmp_u1b = 0;
 
 	if (!ppsc->support_aspm)
 		return;
@@ -221,10 +222,10 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
 	}
 
 	/*for promising device will in L0 state after an I/O. */
-	pci_read_config_byte(rtlpci->pdev, 0x80, &tmp_u1b);
+	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &tmp_u1b);
 
 	/*Set corresponding value. */
-	aspmlevel |= BIT(0) | BIT(1);
+	aspmlevel |= PCI_EXP_LNKCTL_ASPM_L0S | PCI_EXP_LNKCTL_ASPM_L1;
 	linkctrl_reg &= ~aspmlevel;
 
 	_rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
@@ -351,9 +352,8 @@ static void rtl_pci_parse_configuration(struct pci_dev *pdev,
 	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Link Control Register =%x\n",
 		pcipriv->ndis_adapter.linkctrl_reg);
 
-	pci_read_config_byte(pdev, 0x98, &tmp);
-	tmp |= BIT(4);
-	pci_write_config_byte(pdev, 0x98, tmp);
+	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+				 PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
 
 	tmp = 0x17;
 	pci_write_config_byte(pdev, 0x70f, tmp);
-- 
2.30.2


