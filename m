Return-Path: <linux-wireless+bounces-19883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB2A54835
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D3F3AC9A2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988DD204F60;
	Thu,  6 Mar 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7yrnf7s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2735209F46
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257832; cv=none; b=dN0EkPurmWvT8MqRRFV97PLjML6l0fUd1DuiE+cEuRfYb9P0VipGYAOy3jdIIZqTXR6BClLJR8/lW3Dt0CeQne3Rc9YAEG8VzJVI87CYJktm72IAFaKNaKXOMoGCcAImBVPYGJHTYud7im1bvoXCm2NW5IrsK5DsJtwtNPM72Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257832; c=relaxed/simple;
	bh=z9YiSsuR8tZfAE1pEAoxKoDCaDTLLV85kifjv5K9shM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iAQJlFoANsIOcvWWRrzf7XyEo9N7xsHFibTDrHq8hF8EFbwhngplgZa7wmlTJnUIu+2p8ynoInk7vOiYTVifzSQzpZr6lTv8RSdXIyRoNwfRi+PoNQkOxIBMTF4Rr+Db8jpbYxalowfxZULj/AiAUNAjG2R0JtDRDx8F4t+bRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7yrnf7s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257831; x=1772793831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9YiSsuR8tZfAE1pEAoxKoDCaDTLLV85kifjv5K9shM=;
  b=H7yrnf7swa76Y8mTmgKbcl2WMmUP4dg+jwSPbTp9iHmtgE5ih3KKTtGs
   T8L4Xb7ppFu4mDiBeWfeOPGEV8ZhmtlEjPmo8Hcq9H5MXmNFWpv4VSM7+
   bf7PaBhFg6NW45XQelC0RR1FcSqsxOUX+zfffc2U1N3Ce24hJd9PcZJXj
   FEM+rOqt1/RSh45TJjnrP2ll8D37y10z7N5pT/fiUGx5aIom4niHHj7bg
   VzXTPQ/KzL6xZ5ujS9d5nmt+dLlG7osLpplXHeC0Gmzgcahzzgf8+TRUJ
   E2ifDZshDUbZQzEOw/TWyXZp7wMkIEyjZ+8g1Y7/x+LOQ8VG9UpKfldMF
   Q==;
X-CSE-ConnectionGUID: zFMaOhamRyu/IQcdtCfQ7w==
X-CSE-MsgGUID: u0Ep6Fg7RyOYPtub0D5jkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844491"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844491"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:51 -0800
X-CSE-ConnectionGUID: bDVBgVgHROWoKhh0dM1p4A==
X-CSE-MsgGUID: k6+QRdMkSuGrnTewQ2u0Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797750"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: mac80211_hwsim: Fix MLD address translation
Date: Thu,  6 Mar 2025 12:43:19 +0200
Message-Id: <20250306124057.36bff11d7dae.Ic21592e1b1634653f02b80628cb2152f6e9de367@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Do address translations only between shared links. It is
possible that while an non-AP MLD station and an AP MLD
station have shared links, the frame is intended to be sent
on a link which is not shared (for example when sending a
probe response).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index d0d9dab7f11f..b426f3bfab28 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2025 Intel Corporation
  */
 
 /*
@@ -1983,11 +1983,13 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 			return;
 		}
 
-		if (sta && sta->mlo) {
-			if (WARN_ON(!link_sta)) {
-				ieee80211_free_txskb(hw, skb);
-				return;
-			}
+		/* Do address translations only between shared links. It is
+		 * possible that while an non-AP MLD station and an AP MLD
+		 * station have shared links, the frame is intended to be sent
+		 * on a link which is not shared (for example when sending a
+		 * probe response).
+		 */
+		if (sta && sta->mlo && link_sta) {
 			/* address translation to link addresses on TX */
 			ether_addr_copy(hdr->addr1, link_sta->addr);
 			ether_addr_copy(hdr->addr2, bss_conf->addr);
-- 
2.34.1


