Return-Path: <linux-wireless+bounces-22236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06866AA4548
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 10:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A704C4B5E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5757B218AD4;
	Wed, 30 Apr 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNzJV2Ny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF4216396
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001585; cv=none; b=k2sn+GPU1N6szmyawyUObU9b/bfiBBOzrOoeHxiDxFNPkIsWoFAYjchIp82AgAZkH/XzD+l/aKCF8K2PJum++UvRAkDkSGAdnulzWDO/1UGrS3kjvsDGQM2W2uBwLb4+xn0ol9edNUyJqPWDI+ib7Tz4pRqH+r2hSqQEtFQzypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001585; c=relaxed/simple;
	bh=BRECV0litb9sf5YOhxbcb7V9DjBiF7+fzwh8Vx2Bmyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7NPyWx9Q6EEbbY8HuNIKKtzC9FFQM23HIpl4DtoRMQAZJTyWfQk0cDZX9070qcZQrAMoO4Q84+4AWSlh3ah52SmDCEWej1CK+r8n/MJp1mgslIKMY/zQMJBKa671YYgEoSsPxOVRAd5ZCO3yVhAAx312cfrqrOirT1NbR4oIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNzJV2Ny; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746001583; x=1777537583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BRECV0litb9sf5YOhxbcb7V9DjBiF7+fzwh8Vx2Bmyc=;
  b=DNzJV2NyW+RK9upTPHvarpbTgvcaqFp8k3EZIubAzZJxMIX6Cm8+50rk
   kmztDXuWLLt7wxwnQ6E4hVMZzehPqaUb7rnnj/aUU/3MC1oQkvUGpLnIc
   uupObyPShv9TPDBB6vG6+HlrdkVoTg4U/mARzYC2Qpz0ivwxChIWvRO1e
   ANhYtIBSfNrUKirQAyFXoOT7GcMoa1HHonxHjyq15VTsxykoRe0p4AQ7Q
   /OuHMGr3TxgL8reRwoRe2v6NDBh60rk4A+Wq7crMJxv8ZdHMrnK9UHOJu
   3jYiYvWW/NKl8vnNgoOSskhyvAI2jKv1FNQARszSSOi/wV/YSNsnOeI+B
   w==;
X-CSE-ConnectionGUID: I5U00wccTOekD+4Vlt5Whg==
X-CSE-MsgGUID: 4057AevzRg+Y7lfeTDRj1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47742030"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47742030"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:26:23 -0700
X-CSE-ConnectionGUID: PY2xEaXcSKGfyO1DZSVc+w==
X-CSE-MsgGUID: dTNYyuKtQ4a8lzypNOtS4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="133774785"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:26:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update iwlwifi git link
Date: Wed, 30 Apr 2025 11:26:07 +0300
Message-Id: <20250430112552.1eb2dee64e96.Ic462b7be21af71a3c27eddb5b56e1b46f07ac91d@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The link is wrong, fix it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c7d796131a8..0a757661a954 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12309,7 +12309,7 @@ M:	Miri Korenblit <miriam.rachel.korenblit@intel.com>
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi.git
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/
 F:	drivers/net/wireless/intel/iwlwifi/
 
 INTEL WMI SLIM BOOTLOADER (SBL) FIRMWARE UPDATE DRIVER
-- 
2.34.1


