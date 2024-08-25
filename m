Return-Path: <linux-wireless+bounces-11918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF295E44E
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E025281902
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926D8E56E;
	Sun, 25 Aug 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OifCq/TE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512616C69F
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602664; cv=none; b=MyntpuQq8D9l3i4RkPmMwrcTPYXoZ9Pf0TV+cTeM9Dzp8Esq9dTrf9KU3DdLs0cdSJjrWCF8ebk9S+tGtmE2JU8xl4fjbrhiH/uy6LzZgEq15bMwjNQ1zVvCcRL0ZNM7G02lBlGgVYL0ASkK72Eh6ocQc3w5/U/0VIlyICPn7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602664; c=relaxed/simple;
	bh=5+/5RQtPIdgaFLUsgktHurwx0SOYM+UCMdKn24w2oyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCMYTfpKkmovmuUfRUuWjSgWapFiuRZwIaUyb+yntK//5OwOFeUKssJXcpu3DLu5i1dNI3pJvGBIKEBMGMN8USYpc9y3P5vAjZc9X+ZepRbWs8zd7C0uulyXizacQn6TwkABB3dS5ER9W0Mqm76tUSH4wk4CEyRzZmgbpI+pmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OifCq/TE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602663; x=1756138663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5+/5RQtPIdgaFLUsgktHurwx0SOYM+UCMdKn24w2oyc=;
  b=OifCq/TEQimytRsx7sBachNAvd2Q2PGQpsd1/vsTPLbzx+ZICUi7uI09
   GtZAZZZzsdDTh8QRXZP8j0CT8Z7OCIt5yst3IXZGUBngDZAveeDMi13U8
   jO4+hvnFQ1u824bwgGykY1eTb+tjQ7K9M8wU/YQIhqw403xsoph2jCVeJ
   Ipv/8q2z1NbQODYJycQijdNyJjs8z+7YHuiUjlOqMGr+AlQwS4x+fmQsT
   JxFRCxErnemNKk6WaC7IRW0tHQArgytd2QGT5dFvOSO18zYDUhbzFqVaE
   P8YNHV9G5uyum+HK673xfoL2CWL6kvtb5wXae4zd1zqnP9JhbSYZfeZ1J
   w==;
X-CSE-ConnectionGUID: UNaR1QJcQTiV/sMjY2jAnw==
X-CSE-MsgGUID: kA50u9KRTlC3IXgbIXDLJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544145"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544145"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:42 -0700
X-CSE-ConnectionGUID: WbpRiNszTz+NR9R2zNmQCg==
X-CSE-MsgGUID: HPYfM5DyTOS+GlB1BdQZfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999777"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 13/13] wifi: iwlwifi: lower message level for FW buffer destination
Date: Sun, 25 Aug 2024 19:17:13 +0300
Message-Id: <20240825191257.20abf78f05bc.Ifbcecc2ae9fb40b9698302507dcba8b922c8d856@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

An invalid buffer destination is not a problem for the driver and it
does not make sense to report it with the KERN_ERR message level. As
such, change the message to use IWL_DEBUG_FW.

Reported-by: Len Brown <lenb@kernel.org>
Closes: https://lore.kernel.org/r/CAJvTdKkcxJss=DM2sxgv_MR5BeZ4_OC-3ad6tA40TYH2yqHCWw@mail.gmail.com
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index e63efbf809f0..ae93a72542b2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -89,7 +89,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 		}
 		break;
 	default:
-		IWL_ERR(trans, "WRT: Invalid buffer destination\n");
+		IWL_DEBUG_FW(trans, "WRT: Invalid buffer destination (%d)\n",
+			     le32_to_cpu(fw_mon_cfg->buf_location));
 	}
 out:
 	if (dbg_flags)
-- 
2.34.1


