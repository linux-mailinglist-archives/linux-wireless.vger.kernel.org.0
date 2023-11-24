Return-Path: <linux-wireless+bounces-46-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB87F6F29
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 10:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB1C280E8F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A944C64;
	Fri, 24 Nov 2023 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLbBx5hK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F910EF;
	Fri, 24 Nov 2023 01:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700817011; x=1732353011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66TLivhScrf9PDmhJ5Qy/pTIXujF0a8LJJSvL83bbzY=;
  b=mLbBx5hKKnigSec5QNzGIf4VS5jO637IueqGnXW9/HYzVYbBpp1x4vYS
   w+Qz7zG4aF3Nn+QflC+JPgh06zeuXrb0xCAqgvGLVaW2tWPBsUoucquEc
   S7FEgUBm8RGDAlLSKOrGFYJxu9RkZoHq64121wbmOJQrHHRnhZ8jqWqC5
   PuQhECYoW7CEH138YySVyUwtZETynP8BAUhFeFQ+WUDZhWOSaAw/LmiJ0
   885+k6TN1vPOrpafAdkIOQHjCMhAzt+MlzYYbxU7TuqVQtjtNQveMlNFs
   sxdXyS63zSeJaDiaiNvv4quegVMQEvDEb3aMIzJCJX3dSsgf2ESzE8S5I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478603519"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="478603519"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="15911703"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:10:09 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/6] bcma: Use PCI_HEADER_TYPE_MASK instead of literal
Date: Fri, 24 Nov 2023 11:09:18 +0200
Message-Id: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace literal 0x7f with PCI_HEADER_TYPE_MASK.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/bcma/driver_pci_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
index aa0581cda718..ed3be52ab63d 100644
--- a/drivers/bcma/driver_pci_host.c
+++ b/drivers/bcma/driver_pci_host.c
@@ -280,7 +280,7 @@ static u8 bcma_find_pci_capability(struct bcma_drv_pci *pc, unsigned int dev,
 	/* check for Header type 0 */
 	bcma_extpci_read_config(pc, dev, func, PCI_HEADER_TYPE, &byte_val,
 				sizeof(u8));
-	if ((byte_val & 0x7F) != PCI_HEADER_TYPE_NORMAL)
+	if ((byte_val & PCI_HEADER_TYPE_MASK) != PCI_HEADER_TYPE_NORMAL)
 		return cap_ptr;
 
 	/* check if the capability pointer field exists */
-- 
2.30.2


