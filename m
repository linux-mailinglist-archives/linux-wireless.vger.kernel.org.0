Return-Path: <linux-wireless+bounces-22215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFFAA1BA2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 21:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25161B61F46
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 19:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117F263F30;
	Tue, 29 Apr 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksI/kJHE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99A25A2A5
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956460; cv=none; b=rcHMLOxBqshMz9+x8EcNfzqEEkcxMkWb6iy0tGgvxDjAdX/pKfwap2m9fko+Fgz7K4bRBO3mj2ZYPIY0WIYsXUNurA3gXkYLIVMe7jVkrd4kPOCSWJffuntiE57HwdhQfVWFcNPuHOkyJ6esbE+YuV/dkylBuG7s++TZjoTAKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956460; c=relaxed/simple;
	bh=RNWr15s1yp0pQdXSY+oIUFhcj5NB1Q83TUvb9X8v2MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pwIeegGGkrtAzDV/GcCYHtvATbQYElDapATztihPgpzKepAO3ONsg/YaZfIFmyrSdp9iKVNxf/qNLwxZ0I+7by/yrM58LH5lBg/FM4XgFUB519+m54L+9t8PYC9Ry13pYFXFpUBzaJzsVLM3yk0Gywv8Ef705YeGmn9wtUqA4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksI/kJHE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745956459; x=1777492459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNWr15s1yp0pQdXSY+oIUFhcj5NB1Q83TUvb9X8v2MU=;
  b=ksI/kJHEtSO0PNYnA6m0m1QudqdKZSF34nB17zHeIlYzH4qbFqaUSfHZ
   JDI+TSOSQa58SjSObHWIzqPqkZJUAT48gBYqKF0CX33d4/68O6h0ma0B7
   YfMRlpJlcE9mN59OJSIyUI630xkUN09v5PZoOAn6d297pX+MzfIqXam8R
   Vl6LrP/0+oSo/2N+7g2eacXzoR8orcownZZUJMWygUaSNCTxR3CPV1/tm
   tileGACr4nd6d5nEjdfSUsBsNRYggz6tY41pfIlrr2saM4vyzy5GutI3A
   QwvOUySlpjXb9RDkwDiEZya2H9uimFcLSdgq0d24tC/aerFJATJfDbP/N
   Q==;
X-CSE-ConnectionGUID: Yev1dfKRROO1BsQlxif3iw==
X-CSE-MsgGUID: rD2VBiq6Q2e2t98wqu8bBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="46713592"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="46713592"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:18 -0700
X-CSE-ConnectionGUID: IJrRA56sTrunw6uzz/X61g==
X-CSE-MsgGUID: qbnj8WbvRZ6TXxb9d0bD2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="171155021"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 12:54:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/14] wifi: iwlwifi: mld: check for NULL before referencing a pointer
Date: Tue, 29 Apr 2025 22:53:40 +0300
Message-Id: <20250429224932.06b2ccc35eb9.I1bb72836dab17895a2e39910e4493d667db0fa80@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
References: <20250429195344.254957-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Errors can happen, and it is better not to risk with a NULL pointer
dereference.
Make sure that the links-to-remove pointers are not NULL before
dereferencing it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 03ef9b33c2d2..284599abf8c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2450,7 +2450,7 @@ iwl_mld_change_vif_links(struct ieee80211_hw *hw,
 		added |= BIT(0);
 
 	for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		if (removed & BIT(i))
+		if (removed & BIT(i) && !WARN_ON(!old[i]))
 			iwl_mld_remove_link(mld, old[i]);
 	}
 
-- 
2.34.1


