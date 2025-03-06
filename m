Return-Path: <linux-wireless+bounces-19948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F96A55952
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D869516701E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C6272917;
	Thu,  6 Mar 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMeU78HF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6126D5B6
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298722; cv=none; b=a7eRiisYn1bsBCXXSu5ZaF8W63/0vwHfYwW8E/ocgLMtatDI36rJ9Ul2+dt2hOdsHoxoSCeAAl24dxZIeb4qCgw+bL6VUWILXgqLnEOFBSEUzXC+KgUe1fOxq2dLCQhtaIp0tPmgbVHOo2CSKiN42Kpn/iWP+nJrnjEjH2/VX5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298722; c=relaxed/simple;
	bh=jOSPCYdHjY3mmUmNQsjMfcaCD0ekcqINe9k3tizI2lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmEhma0agoFf5J6LVTsOyRvfpAXWxF/5FnIp6ARwiCKL4zNObKXyDwMFvKq4TsU7bjrNY1RxxJbhvOg/1UQJrWsawHj8wef6DN49oVF+HfpcrtcoDzyrNhC/iaIgqRjwAHRNQBJS5IjoIeeUlpozgdR5NAm0/1bcVmmPFhg7Mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMeU78HF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298721; x=1772834721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOSPCYdHjY3mmUmNQsjMfcaCD0ekcqINe9k3tizI2lk=;
  b=kMeU78HFCsf/zl2842YYOr1vQvkkuaktp6fPBlQ36z98vjcM1n5NorAn
   DiB/kLzY8tvDVFrLeaVHsVrxlKN9YrmjlXd8chjDqj7ibasISEpnH04Rn
   ZNXYdgzIvvGEn8w10FiScAavZQF3F/4wddkZJiEnZhHwMZw3Z/qOdwcsF
   V1Myk8S8cTnCaZDrcsKiMKGcE5MuZ5AjatqPbKNvuGlN/fvbnEqHgzSpm
   CSIwo/BGZVeOb5Hqa6Oaww8tTy1vfHnMXqdJy0MXXuwEBWIevWspSsqtm
   UvQUyVoxE/I5DwC83+Qt9mhoe/SECP4li4NVy8K5VGlWJP+r2timVPEnM
   A==;
X-CSE-ConnectionGUID: BT915XbZTuSVJMZcgnID5w==
X-CSE-MsgGUID: bgAFNJDYTB6IiuL4uUAbPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474260"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474260"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:18 -0800
X-CSE-ConnectionGUID: HUV/cdbdSLicKoIJo+73Vg==
X-CSE-MsgGUID: E1/Xf9RtQ+GP6Rzfwj4vRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061880"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: iwlwifi: fix print for ECKV
Date: Fri,  7 Mar 2025 00:04:43 +0200
Message-Id: <20250307000213.86acda61ac76.I318fed724709f9ee7a0c369e1cf5e1038ddd546a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The print was obviously wrong. We are handling ECKV and not WRDD in this
function.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index b4438b1f8dad..386aadbce2a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -690,7 +690,7 @@ int iwl_uefi_get_eckv(struct iwl_fw_runtime *fwrt, u32 *extl_clk)
 
 	if (data->revision != IWL_UEFI_ECKV_REVISION) {
 		ret = -EINVAL;
-		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI WRDD revision:%d\n",
+		IWL_DEBUG_RADIO(fwrt, "Unsupported UEFI ECKV revision:%d\n",
 				data->revision);
 		goto out;
 	}
-- 
2.34.1


