Return-Path: <linux-wireless+bounces-27063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6816FB479E0
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25888189F749
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5CF374D1;
	Sun,  7 Sep 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8FCv4s5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2E21B9D2
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235108; cv=none; b=LUzFNzVX3dfVY3kt/2QwVCdnrVTBnACXWa0evKLTy1gFGKIA5cqGH06HipZhke0axmmZ9aPbEThi1807JMARMsXlZ+09d2sgVKKE0+9cUX1qezgsIYYWuPHq0gNHkohzo09vRIi+gtoo4aAsG1k2UGxEZ1euAtmy4QJfYTBeDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235108; c=relaxed/simple;
	bh=vZXzKERUIot+M/u1ehwfB0otro4DWna2iYwbR4HvXNI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwCQ88usN4/hKknwRdndxjPBU5rNA2GD/mK8u9Ol+LvvQ6SBjCCRulXZDf5fFfz+7JDGagRxw1L19soXaV/q69pczrthwhug3Xj5ny1/rYUii+bcSswoC+h1RgYtG9ZiTLEz8Gh1nbFHsldFefpN0nlW8AnvzOCVeTao7fpf3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8FCv4s5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757235106; x=1788771106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vZXzKERUIot+M/u1ehwfB0otro4DWna2iYwbR4HvXNI=;
  b=i8FCv4s5AdDXQbkAnsufGCRgLSYn5bEfxOWjpSMwoTV/dHn1jjpS5tA1
   f265X5+8c3EK9wtsWVRbpAVJbWKKZx5l1q3Mw2R/f4NUrp50M42CsIOCP
   8ZdKT/M5TZrR/EWm21lHSG/siQKkMM82QMfa6akLuibaboM8IZLL/onz+
   Dc9vd9PAPGhj5Y2XhpnX1UOhP4z4N3Vd1cRvblaeQSL4ZdLLvG45U/2rg
   AKXLBIUHny+45ax7k6iafSzPOWfMj0XOzTOFt8IsNtBT9rWfKJAaLGLOK
   Mv3nPHY3IIa7pLVJbGOesvT8GQZpGBH+Te0NHrcjONIWJDzpOIAx/wIFz
   g==;
X-CSE-ConnectionGUID: 1mykgO5KQi6X/eZmH5+87A==
X-CSE-MsgGUID: CZvjZd3NTy2ipO0nl1AyDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70136825"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="70136825"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:51:45 -0700
X-CSE-ConnectionGUID: fu/suCrcS5OcxpO79HpO2w==
X-CSE-MsgGUID: Bc64tEjxSuun70InpE978g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="173336795"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:51:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: Fix HE capabilities element check
Date: Sun,  7 Sep 2025 11:51:17 +0300
Message-Id: <20250907115109.8da0012e2286.I8c0c69a0011f7153c13b365b14dfef48cfe7c3e3@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The element data length check did not account for the extra
octet used for the extension ID. Fix it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 83a9986dd1c4..f73e3222981b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5725,7 +5725,7 @@ static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
 	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
 					     ies->data, ies->len);
 
-	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap))
+	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap) + 1)
 		return chains;
 
 	/* skip one byte ext_tag_id */
-- 
2.34.1


