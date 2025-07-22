Return-Path: <linux-wireless+bounces-25782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C840B0D06F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34A2543E89
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BD28C034;
	Tue, 22 Jul 2025 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJnsZ5QP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D228B7E5
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155712; cv=none; b=j7KuZI69Hmyzs71qDHApi2AAbYVRjnileKjPqei5yGfVg+1lJsKLU2U324uO2iv7dlqclPc2jwYi///rX2Ge/CYhHRRDHDCl09qcMbX8nt4lFBkrhmMuTNpEkp1b/aWqyB09zUZNaS7lLgFKtplRV8WVybQifd8vDcEa3r6pp/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155712; c=relaxed/simple;
	bh=RMdDiuuvHQH36u7xg86ICkL0gF5hR/CGa7ifbowG2f0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u59Zm99gz2ewA9iQA2Zo/JPECzb5JBvSOaNVvkLNBMoYDx48p5aFckeI74VY9xzZpbWKNLNJkEfTcJ6bjfHJmLs6cYMb2yuad0yVrf3tzO6gAU7LM4+QkPWRnG21mqP1j8Pt5BB3AuRsIBzGSlnblRZOdUwUUROSW1pBy5DBxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJnsZ5QP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155711; x=1784691711;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=RMdDiuuvHQH36u7xg86ICkL0gF5hR/CGa7ifbowG2f0=;
  b=LJnsZ5QP12oWr1onZwGKaka9efJNg/x+rI1Uesqammnc7KTOb2877Lux
   U+SWCK5clTukkXOKriwI1430wDGUnPG2QwHtx8gZ5y3L2UCQ+DA2n5Y6h
   QLVYyiYYwx0nQqhcQQF7c0YYF/4Zj0zNpKJgcvDu7xX+Bw98y52sX6UER
   TTJSm1YXCxBzupvkXb20bDTaY7n2cOKhY4ToVSPI6jdR3O3du+5+qrVPk
   SJiBHz0/CXnN0dT1JKr1CkkkcriVl+xQqG5L7BTsOaVjDFTrO2djYiR9Q
   irLih3rPTgFAjRP/fgpQOLum5cBkMEuZVAVC485KMt9eedr/Dz6y3X90q
   Q==;
X-CSE-ConnectionGUID: UxY+vtMpSe62uNgz5xhb0A==
X-CSE-MsgGUID: 5+jvSZhNRTiX85SpVOrDKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006154"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006154"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:51 -0700
X-CSE-ConnectionGUID: F/Gcj6W/SRKCV8UImdB2og==
X-CSE-MsgGUID: t+L+09nsQx+G115QRSnBoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338061"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: disable RX aggregation if requested
Date: Tue, 22 Jul 2025 06:41:13 +0300
Message-Id: <20250722063923.e0555330d8e9.Ibf5877df76ea2f1eee614166b3194843fd9898cd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The user can request to disable RX aggregations via the module parameter
enable_11n.
Honor this request and reject addba.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 59be9923c3b2..d929cf2e73fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1918,6 +1918,10 @@ iwl_mld_mac80211_ampdu_action(struct ieee80211_hw *hw,
 
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
+		if (!iwl_enable_rx_ampdu()) {
+			ret = -EINVAL;
+			break;
+		}
 		ret = iwl_mld_ampdu_rx_start(mld, sta, tid, ssn, buf_size,
 					     timeout);
 		break;
-- 
2.34.1


