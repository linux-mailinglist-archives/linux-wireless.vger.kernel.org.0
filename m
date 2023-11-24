Return-Path: <linux-wireless+bounces-44-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A807F6EDB
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 09:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C14B2101A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B5C2E9;
	Fri, 24 Nov 2023 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCF+NMRh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DDC10F3;
	Fri, 24 Nov 2023 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700815740; x=1732351740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szHP/bH/uBQ0qXbVg2RukeAFWzc2VqyRXvm/T4TFP44=;
  b=JCF+NMRhrfVTPJ0Eguibm+Fs1pFtxPEKnTminF76/6FdNYihqhz6/isF
   pbuYmAWFHiRRqrBTJGVXAaI42nut53AyHKz7B3w5zuHLu+eENjHgDzpSq
   SL6GykA3bz8bPdx4CitDjwqqbhH2iPvynrBjaqbLmvAvkpyNKOG8eIsUs
   17Mf42mtq8XwlkJrS3yWSRfrysMXGQqztGGVckgeRxnlTHjYxwdPGlji3
   OhOIsiFfbFm8W5r8n99EKStCHFOtrr2bm4pfZzuSMJv+eiNnkc1kNm5QL
   dcDbU3JscTl/m2nFPvVrF0USOfBxzc4jKgtGbcGDJxWReU5AnLQdQmQNv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382791767"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="382791767"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="838026227"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="838026227"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:48:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 10/10] wifi: rtlwifi: Remove bridge vendor/device ids
Date: Fri, 24 Nov 2023 10:47:25 +0200
Message-Id: <20231124084725.12738-11-ilpo.jarvinen@linux.intel.com>
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

Neither vendorid nor deviceid in the struct mp_adapter is used so
remove them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/wireless/realtek/rtlwifi/pci.c | 1 -
 drivers/net/wireless/realtek/rtlwifi/pci.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index a29d7df6fff5..aa00ee971bc3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -1969,7 +1969,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
 	 */
 	if (bridge_pdev) {
 		/*find bridge info if available */
-		pcipriv->ndis_adapter.pcibridge_vendorid = bridge_pdev->vendor;
 		for (tmp = 0; tmp < PCI_BRIDGE_VENDOR_MAX; tmp++) {
 			if (bridge_pdev->vendor == pcibridge_vendors[tmp]) {
 				pcipriv->ndis_adapter.pcibridge_vendor = tmp;
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
index 8bb35506ab1e..616e5ba30d74 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.h
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
@@ -216,8 +216,6 @@ struct mp_adapter {
 	u8 pcibridge_funcnum;
 
 	u8 pcibridge_vendor;
-	u16 pcibridge_vendorid;
-	u16 pcibridge_deviceid;
 
 	bool amd_l1_patch;
 };
-- 
2.30.2


