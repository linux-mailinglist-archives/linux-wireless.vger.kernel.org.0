Return-Path: <linux-wireless+bounces-18668-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52E9A2DDD2
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 13:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4003A2F9C
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Feb 2025 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE7A74040;
	Sun,  9 Feb 2025 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8jvunm8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046421DC185
	for <linux-wireless@vger.kernel.org>; Sun,  9 Feb 2025 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104523; cv=none; b=G+yg8PUSmwWYCs6tZMFoU5nARhS7q5iUHUeHAPRD7uRlTc66aji7Gyol1VAz+5SnAh4y2+l5ttNcv+D+k80NYtpm3opV+nj1m5jYK4BTmEATNhkeNaMjelPEA4vgdHOkVug66I9J7LfvCfrViVWkmTw0njXwkiyfoI1vHT7vBVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104523; c=relaxed/simple;
	bh=o6JcCRkNJU3VVmD3zcdZDHs8mScML9JLHfhd0N26y+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CqkxVUUfs+ebkgHOP4FamuyXnyeVlUZKOqFgfpGq8jGhHcKYNS2zeVYhJHYaVecH/tnLFR+MWFNV3fbWSkzdbzafLGOB3/QrXL8uIqzlwowyC/sJKPRYySmnXj0Xe5NVMQZhV30MubT7chFHUIJ9cFM0Q+n+9aCUas/jSzoV3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8jvunm8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739104522; x=1770640522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o6JcCRkNJU3VVmD3zcdZDHs8mScML9JLHfhd0N26y+k=;
  b=H8jvunm8ZiNljkfJ6JrtfgoALCCVT1mE0Ah28ggx0t4XS5cQrvg/+fQS
   fl0fLGEI13401v+uol6cKMMpvzAscMqe/t2NL8opDrLn+88505ls56umb
   CzVKRPRZb75RMLPMONei81TmnpiZZN9EWX1UR9Xvt2xsjVTKwaDx2lD96
   6O+IpuolPOnOMQboLMWFlNikWQ6RdHt1GSxYoXil52wdgsKswILkbog3G
   nfrA8PtyD7oxc+KGO9WGLW/sXC5G/d+fSOxmqzXws7cGQMYPOt/a01GGk
   +ofkDoUhc+fzGJVneexm11MDf+PqUEOszTPcCMh1/UZbseDZLN9wN4k0m
   A==;
X-CSE-ConnectionGUID: XmgfAYwGRFqnIEHPXATxFw==
X-CSE-MsgGUID: ORYTNviwQduMdcMhVD+yIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51125986"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51125986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:21 -0800
X-CSE-ConnectionGUID: mpka5ml6R/WBE+fKU++fAA==
X-CSE-MsgGUID: P/x/5wPgSjirP/+k/ako8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111782459"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 04:35:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7/9] wifi: iwlwifi: limit printed string from FW file
Date: Sun,  9 Feb 2025 14:34:51 +0200
Message-Id: <20250209143303.cb5f9d0c2f5d.Idec695d53c6c2234aade306f7647b576c7e3d928@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
References: <20250209123453.2010013-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no guarantee here that the file is always with a
NUL-termination, so reading the string may read beyond the
end of the TLV. If that's the last TLV in the file, it can
perhaps even read beyond the end of the file buffer.

Fix that by limiting the print format to the size of the
buffer we have.

Fixes: aee1b6385e29 ("iwlwifi: support fseq tlv and print fseq version")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d3a65f33097c..352b6e73e08f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1181,7 +1181,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
+			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
 				 fseq_ver->version);
 			}
 			break;
-- 
2.34.1


