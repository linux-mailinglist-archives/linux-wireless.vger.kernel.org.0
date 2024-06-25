Return-Path: <linux-wireless+bounces-9543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A751916E7E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7251C222EC
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285C17BB28;
	Tue, 25 Jun 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QR0XLhRl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8417B439
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334307; cv=none; b=ovnDLuVhAatz6Jh+ispJeYhE7S713k5QOQM5Vj3yKfPNqb8KvcZgQI2kymMxdtru/XhRMR+vtBsUmfmzWmZxCl2dzgzuji+lRn7lo3uIq0UMZbyHnM5hBqJ6+tmytVmIeSTUZYDVJ1AGd6KIj/ZJIXkh/cOJLO5OCccE24ZMNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334307; c=relaxed/simple;
	bh=6GFHMLu87UCZyWsHi4peC8CYpod8umq5oJzJqtwEpqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMPQy8guU8nfDwoMvMo77Nl0mXwbTvRrypX5/ob33BmR7dHCi2UfNNtWFPIDeUvkJcSLIiuEWNPwbdukCVXGZP6HXMlLoqVe2/VyfQeaGicRMV0Zb1VOJSzjyKKQP673tcweTJ0+nmefL2KoPuCGSu6gHhHxSex4aqD9eeIXBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QR0XLhRl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334306; x=1750870306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6GFHMLu87UCZyWsHi4peC8CYpod8umq5oJzJqtwEpqY=;
  b=QR0XLhRlswq6eO5hVaP/4gFhgclPdIWZAQMSwaFeR69erVApQtyBC7WM
   a8WDqjd1/DL1TIBBNHPekMzFBymjYZTI64xbY4dRLG6fuNhigIZo8gODp
   r0SqdXTB4us23wFJYT8/v+DPF2sDyhxCkF+J3TLkuIKxrDVpWcoCCeaeb
   0euf3LXrXPE9tlnqcW8PoMzFX5L5pen9dKtF+deySjY+2mth4tjxlJTMb
   d4IJ7y2DBP9BA2/84Y7x8SqyOtQh2qO98LVcSrAAfkbKviYU6+x0Atk6v
   Zg2NBqyZ0+qGPW2Gp5Cbh+oxAioZVHoyW5vcFppSqVjtfk+fGjxBijgw5
   Q==;
X-CSE-ConnectionGUID: daeYUQG9TLeLgahcDNpSvQ==
X-CSE-MsgGUID: 0lcM3AV5Q6GKcqtmsNP2vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594749"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594749"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:46 -0700
X-CSE-ConnectionGUID: jbcqYZEeQX2YfKzCMTA9xA==
X-CSE-MsgGUID: n2ISf9dxSbOR+lPOikejiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632659"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Subject: [PATCH 09/17] wifi: iwlwifi: mvm: don't log error for failed UATS table read
Date: Tue, 25 Jun 2024 19:51:15 +0300
Message-Id: <20240625194805.306b7eed8671.I6e9294335378dab38ef957866a0d39ec1a2df7f8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This causes unnecessary error level kernel messages if the platform
does not have any UATS table.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1f27ed9c3886..08c4898c8f1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -506,7 +506,7 @@ static void iwl_mvm_uats_init(struct iwl_mvm *mvm)
 
 	ret = iwl_uefi_get_uats_table(mvm->trans, &mvm->fwrt);
 	if (ret < 0) {
-		IWL_ERR(mvm, "failed to read UATS table (%d)\n", ret);
+		IWL_DEBUG_FW(mvm, "failed to read UATS table (%d)\n", ret);
 		return;
 	}
 
-- 
2.34.1


