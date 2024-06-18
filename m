Return-Path: <linux-wireless+bounces-9218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6AF90DA3B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 19:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CF9B272F8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0136446DE;
	Tue, 18 Jun 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhnlPuuX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF713D8AE
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730197; cv=none; b=eTs54O4l/ygJa+djzVcya/zM3pdWkgTCLrkvA+7CnDM7IGhTygYyWxq3QXzTUZ1J7HyMYr+JV/1oRYkQ7geYKD+s3KiVxnvvPKa4v40IgN9XlPtDiJeWAsVLoGbjnVec/o1b//ayIATUdDVdqCodX6y+CCX0Pm73R9q914lOcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730197; c=relaxed/simple;
	bh=MZcldRyTnCRMVaSC5A89IC1hb6o7NnlLnCidur0JvwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F3ykyC5cd3vbomT4KWK9xPC6nYxCmVR/reZ3+xXvH6wgx1ZWXwkQrAEZJsoEViYkHSdq88draXgNlH57YPMklvqWLNzrNwaGVBIgxY3gkIwy3CmWkQuSRaIqEZekjd+LlnsibZ67S90CMji9oezwWO5ELJUMmvVslLWBEHe8OLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhnlPuuX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718730196; x=1750266196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZcldRyTnCRMVaSC5A89IC1hb6o7NnlLnCidur0JvwU=;
  b=nhnlPuuXMd6TvyTKCgXxIHkub8HVRvJntFkJr9C1kUq4ce2uyiis1qFq
   4PeNqr/v8FiVSkPwQlT+BiZHn54gvo6PofrJ0auk+btnjPsq4WKtNViUe
   JCPqA4YX96j5A7laNie8O5szVxlJTwe98QnmgHSWzI2GnsRi5qw76g3Q9
   jxlRf/ibY/HJTh1he6uVU/C9nOmvnfpRmch7cc9ouqWVFADcqs5/NyX6W
   Aa/9TJKuTlGJPscpqCoJ/dHyBGKuhBVBoNOmOC3roMEjaSUhAQLWx096E
   cbnefmXvjnnE6wG29k3CMdaUkELahPgbqMmJTYb4HPKIhLdgYc5T3frmv
   g==;
X-CSE-ConnectionGUID: ODwoywWMRQ+ci0bISDIe4A==
X-CSE-MsgGUID: plVPTO8DSQCCTUbjqG87sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33094015"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33094015"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:16 -0700
X-CSE-ConnectionGUID: 49vrFl5fQXqRvUE+qX7cIQ==
X-CSE-MsgGUID: y16NSVN/QCeIEYJCbBNm4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46541789"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:03:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 3/3] wifi: iwlwifi: fix iwl_mvm_get_valid_rx_ant()
Date: Tue, 18 Jun 2024 20:03:03 +0300
Message-Id: <20240618200104.b7c6a320c7dc.I3092eb5275056f2162b9694e583c310c38568b2a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618170303.2438911-1-miriam.rachel.korenblit@intel.com>
References: <20240618170303.2438911-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Fix incorrect use of _tx_ valid ant data in the function.

Fixes: 4ea1ed1d14d8 ("wifi: iwlwifi: mvm: support set_antenna()")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0a1959bd4079..d73c71cf102e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1860,10 +1860,10 @@ static inline u8 iwl_mvm_get_valid_tx_ant(struct iwl_mvm *mvm)
 
 static inline u8 iwl_mvm_get_valid_rx_ant(struct iwl_mvm *mvm)
 {
-	u8 rx_ant = mvm->fw->valid_tx_ant;
+	u8 rx_ant = mvm->fw->valid_rx_ant;
 
 	if (mvm->nvm_data && mvm->nvm_data->valid_rx_ant)
-		rx_ant &= mvm->nvm_data->valid_tx_ant;
+		rx_ant &= mvm->nvm_data->valid_rx_ant;
 
 	if (mvm->set_rx_ant)
 		rx_ant &= mvm->set_rx_ant;
-- 
2.34.1


