Return-Path: <linux-wireless+bounces-34-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 104497F6EC4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942D0B20C01
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462C4436;
	Fri, 24 Nov 2023 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDaXmkX3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C89F;
	Fri, 24 Nov 2023 00:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815659; x=1732351659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cAzCbwXnfLwA65VPrnihNlz9VygOMk8fpr5Mgo8JUJw=;
  b=KDaXmkX3NbjZl3qVQs6uRbP0fhfqsnadTUDYvURU8GgfZcBDWSw0mYv4
   5m5A3xOSBD0e35okUwqFd3KZbJjT+mYf/0veKqp4+ZwMS4PoBhbsr8lZ4
   ExLcaLmdHgOqNKxpn2StT37yRLvQAcrtilHsyonzDedO9hSnm2hV3thSQ
   FMZo4ygPg4oBE/VoyWfmyUA4NY54Qq6lOCSoU/Eot6YlKaiEqvOraVORh
   /qYnt8OyrwX2Nk3HRxckMuOqiEI0q8pRsEaU338RwKQpM8SfCKvM2YCXV
   VfW7qrUMxGUL9aojV51ajtqZTRIYy+cRxjwHvb4LXcvvP5QCWPICFvqkr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423525771"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="423525771"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:47:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="802137645"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="802137645"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:47:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/10] wifi: rtlwifi: PCI related fixes & cleanups
Date: Fri, 24 Nov 2023 10:47:15 +0200
Message-Id: <20231124084725.12738-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The rtlwifi driver has code fragments that are using old interface or
custom code to access PCIe capabilities which is buggy and messy.

First two patches are fixes to problems related to ASPM and LNKCTL
register RMW operations. The rest of the patches cleanup PCIe
capability related code.

Additional note: This series provides only a stop-gap solution to the
RMW concurrency issue, the overall plan is to migrate all ASPM related
handling into the ASPM service driver in order for it to accurately
track ASPM state [1].

[1] https://lore.kernel.org/linux-pci/20230918131103.24119-1-ilpo.jarvinen@linux.intel.com/

v2:
- Remove upstream bridge ASPM code which has never functioned
- Convert more bits to pci_regs.h
- Ensure _rtl_pci_switch_clk_req() only changes CLKREQ_EN
- wifi: prefix to all patches
- Add 2 more cleanup patches for unused stuff

Ilpo Järvinen (10):
  wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
  wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
  wifi: rtlwifi: Convert to use PCIe capability accessors
  wifi: rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
  wifi: rtlwifi: rtl8821ae: Reverse PM Capability exists check
  wifi: rtlwifi: rtl8821ae: Use pci_find_capability()
  wifi: rtlwifi: rtl8821ae: Add pdev into
    _rtl8821ae_clear_pci_pme_status()
  wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
  wifi: rtlwifi: Remove unused PCI related defines and struct
  wifi: rtlwifi: Remove bridge vendor/device ids

 drivers/net/wireless/realtek/rtlwifi/pci.c    | 98 +++++--------------
 drivers/net/wireless/realtek/rtlwifi/pci.h    | 24 -----
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 76 ++++----------
 3 files changed, 43 insertions(+), 155 deletions(-)

-- 
2.30.2


