Return-Path: <linux-wireless+bounces-18527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B30A28B03
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533953A815F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4122677F11;
	Wed,  5 Feb 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTN8dwSA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F677083A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760182; cv=none; b=hEAQM3zQD9T5OGGMVn41I1cHE6Q7cSkTMDeG2ZGUBakkCU5lt5S3g1Er2p/c+UQpWAtXcp+chcdBPQJpy7Y+YI5AZJ6RNv3MUobabNIPwT383Pk8npXqR2WZmoZGEczspJgtCdo5J2PKFiO1SEAYe8M90+fIY+OAgwRGBqCGLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760182; c=relaxed/simple;
	bh=dzXZCZFtvb7jdkESPWumD+qDu4bWaxKeoTIEjgpX0XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6rtYW4L6AQzs3ZpckQqc+RardkGfTB83uNaAavHd55Ok3aJpavuLwwpXbpAdI/x9Gd8W4i7SbNiBQKfR6PoTglUsNpjB8kKRUiMak8R5PibslPc5Xocq4XYbJMGQnQyxiG5XOTzAbo5VAsduzfxgTe/UtBc3AQR+NCZXAuQ15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTN8dwSA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760180; x=1770296180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzXZCZFtvb7jdkESPWumD+qDu4bWaxKeoTIEjgpX0XE=;
  b=lTN8dwSArYVsX8l+/D2j78vn4+P4OgG3UZLEOsl9Of1jGOWZUsBUfERc
   DTeo7sqENVBfixiX5K/TLmqsZDFdg8hoTUKgaC05fSk+djYpnXjFp3LCF
   0QI+tVNYu1CgefaRg2jyGA2K0Cpns3FoYsCm6su71Lj88YgwNOpMCSrYi
   Ajr2p+6s3uK4vlQJreV/kBSxlN80/n9UbKgKF/ZaxoLKBr/g4uL55t/Si
   GdHzcxhz5pn5IrltKMVAzsKQlD6OfW4CrBDXmDa7BC7Sa+IDciDmc7dKJ
   PaW7spNYx0lMWAOIis8ycEBPxDHGtKQfk7AxnULp+RIMcYcDXN0RGzg8H
   A==;
X-CSE-ConnectionGUID: sV4xK3wXTU6t7auDvDOfhg==
X-CSE-MsgGUID: dFp9cF8lRfi+5SwwUE0ohg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159197"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159197"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:20 -0800
X-CSE-ConnectionGUID: dyZ8CZY3TDulqgGksZBYrQ==
X-CSE-MsgGUID: DpK8c9/dSyaIjcNbhQbXLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745471"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 09/19] wifi: iwlwifi: Indicate support for EPCS
Date: Wed,  5 Feb 2025 14:55:38 +0200
Message-Id: <20250205145347.6b1c7cc8a958.Idd72ea53f70eb452d43d99e6c45ff21f891100bd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
References: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Indicate support for EPCS and unsolicited EPCS in the EHT MAC
capabilities.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
depends on commit "wifi: ieee80211: Add missing EHT MAC capabilities" in
mac80211
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 76259ac261cb..c381511e9ec6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -684,10 +684,13 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 			.has_eht = true,
 			.eht_cap_elem = {
 				.mac_cap_info[0] =
+					IEEE80211_EHT_MAC_CAP0_EPCS_PRIO_ACCESS |
 					IEEE80211_EHT_MAC_CAP0_OM_CONTROL |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE1 |
 					IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2 |
 					IEEE80211_EHT_MAC_CAP0_SCS_TRAFFIC_DESC,
+				.mac_cap_info[1] =
+					IEEE80211_EHT_MAC_CAP1_UNSOL_EPCS_PRIO_ACCESS,
 				.phy_cap_info[0] =
 					IEEE80211_EHT_PHY_CAP0_242_TONE_RU_GT20MHZ |
 					IEEE80211_EHT_PHY_CAP0_NDP_4_EHT_LFT_32_GI |
-- 
2.34.1


