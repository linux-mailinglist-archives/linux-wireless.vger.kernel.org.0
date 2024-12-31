Return-Path: <linux-wireless+bounces-16940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EFB9FEF3F
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 13:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A253A2FD8
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF4119D881;
	Tue, 31 Dec 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fh6OYBxS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAD19D89B
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646382; cv=none; b=Sejg9JL0fkw5B5q2PvLPBYEXVaAo9slSjgf8PM12QYE46z32a2+awwCAFQvH428x5WlvWCZQtGBxFEXd7i0DP9pjwK85Aq/wpL6SGfGzOa4BGbEIUz43wto8xABIqoLYZv3hHcloKzv0m+YH2Eq+GmifBuKmr+CZrCxX6CVvSzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646382; c=relaxed/simple;
	bh=Xjxgoyp3B4ias7Aayk4NrbbwAkhBCzOheSoeWTZkG20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joQHsSQoiFXFbEvAyF868Bz9KvFj0LqL0UK7zTJNeBD4QCeUQLBITb25l0ET+/scfAB0UBVt2AUJHSesAYzl8wlfnc/l12XU5Yh7g1H4ri/LrggNPrvKrdBhMUl+H/m0JzDqAdyDqM+livL5CgppoTqrvXgOa8phXagnmFqWjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fh6OYBxS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646381; x=1767182381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xjxgoyp3B4ias7Aayk4NrbbwAkhBCzOheSoeWTZkG20=;
  b=Fh6OYBxSp4h1XzgxQgOxTBGK9by8bGYde/RWEqIVTEpmt75BsmRijpkR
   wxEy19fGknUBjG13Y6cW9E+fN/8vG3zO35zm0/hiSp0ffAvrvDYXbgB+C
   z7EPBW3h+3vRX0KXc3GYN2m4nV87ZZ3N+8wosMKSj1zPCJAjvZaNDimWB
   BDZEhmSSPHcfdpWQTkZ07oFLE+LgBNEZ5RqG0p/EFo6JFON0Xq51MTnFr
   grBC6VjIoVMu4FYDcFTrWc7mFTQ0MBYZuubw371kgdy0W+JuSIq0n0qCG
   x55p6ukqMwb5n7605X20duhxD3sQXsRUDQsyPGqyrjA2ra9DpQQAXWWxE
   w==;
X-CSE-ConnectionGUID: U+J5Mx7xTt+gSE9tRUuFBg==
X-CSE-MsgGUID: vNbSv2LlR/6GWyXwNpJ//Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330181"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330181"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:41 -0800
X-CSE-ConnectionGUID: N3nUv91KSpe/7tc4mhGnZg==
X-CSE-MsgGUID: sHJxaqCySa6KKSjAEBPHcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380305"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 08/15] wifi: iwlwifi: add WIKO to PPAG approved list
Date: Tue, 31 Dec 2024 13:59:08 +0200
Message-Id: <20241231135726.d2ba5aee512a.I529cfefabd04c64d801895d6a274e3225a952090@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add WIKO to the list of the OEMs that are allowed to use
the PPAG feature

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index bc359a336fd6..27423202a864 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -101,6 +101,11 @@ static const struct dmi_system_id dmi_ppag_approved_list[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
 		},
 	},
+	{ .ident = "WIKO",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "WIKO"),
+		},
+	},
 	{}
 };
 
-- 
2.34.1


