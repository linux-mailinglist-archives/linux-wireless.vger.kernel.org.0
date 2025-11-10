Return-Path: <linux-wireless+bounces-28804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D6C47E66
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6790F4F8E52
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B178C283FD9;
	Mon, 10 Nov 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eX/reoi4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7128313D
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790943; cv=none; b=OJWZ8uueGlhUGQ3+mqNoYwCPjyffQeuXV5JGOY89EOq4bmZcvr7RmO9cRNZAgYv4m/zOF1pUT4wxlUcR0z2dJCzNvy+aI7anHZSWPNxYUvFRZ7DBoKBCJ52wXJodGRRHAozyKvva3kBPIFJHnVsemXLfq7o04HlhUObaVou0EKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790943; c=relaxed/simple;
	bh=HTLWTdxdGgRvV++AAYdCEleZPqZeGqzj5ZRNEg6RktI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3ZrFPNHxEPrJM/XNMPgBXsdgQ0N7JfcsN0gGS+BVdir1zL7Ce6F6vw6Iio7rheHuE8tOIP61KcJdyto3ovIwvW9h15pJsF5bgow0PuFXUjJ0LwagFFB41vvpu363xPBSv7o+qXr83xGuHQt8gxiSGrrJwHg5Ae81FbPaYtYuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eX/reoi4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762790942; x=1794326942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTLWTdxdGgRvV++AAYdCEleZPqZeGqzj5ZRNEg6RktI=;
  b=eX/reoi49WQ3YxAGbknywfVd8hvj+GuU8dMWjeHXrB2EPqFZrWbNQyqJ
   1zFaYjgtYLpeQOnqdLeoQwM7R+op3gxnumv8K6eqOPJ4ySjlG47KBCuQo
   lK/lZ+mTSykVnEGwnLHlXzypzJ8akwbpqEQEWXRWi/Ra8hiXnOQFA5M9p
   xVFDSA3N2si1JVKWc2/CtQeaXSUcc370kCW/T9efy68VtfSvYl/VUNSs3
   A2+XufMDH0vtB/kIwLfhBiyJKuwPhPy5lQR5qZLDeazB8FRpPEfzCaKMm
   qRj/J09U9CnI2dJqOHmeIb0MfBJIxN/UIobYaVwXwZEu9h1Kpi7dEULv3
   Q==;
X-CSE-ConnectionGUID: ftMoWGg9Q8Ov8oVeQaJpgQ==
X-CSE-MsgGUID: LN/xP1o0SI+1uFiRymzzIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64725164"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64725164"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:01 -0800
X-CSE-ConnectionGUID: QIH4TKCTQG6fx8v6rPAZAg==
X-CSE-MsgGUID: DQwfrSZ+ShaZ+EdQJzpUYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188877161"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:09:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next v2 2/6] wifi: iwlwifi: mld: Handle rate selection for NAN interface
Date: Mon, 10 Nov 2025 18:08:46 +0200
Message-Id: <20251110180612.72046f98f878.Ib784931fffd0747acd9d7bb22eabbbec5282733e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
References: <20251110160850.366979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Frames transmitted over a NAN interface might not have channel
information assigned to them. In such cases assign the lowest
OFDM to the frame.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 9af4d73e3444..546d09a38dab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -345,6 +345,11 @@ u8 iwl_mld_get_lowest_rate(struct iwl_mld *mld,
 
 	iwl_mld_get_basic_rates_and_band(mld, vif, info, &basic_rates, &band);
 
+	if (band >= NUM_NL80211_BANDS) {
+		WARN_ON(vif->type != NL80211_IFTYPE_NAN);
+		return IWL_FIRST_OFDM_RATE;
+	}
+
 	sband = mld->hw->wiphy->bands[band];
 	for_each_set_bit(i, &basic_rates, BITS_PER_LONG) {
 		u16 hw = sband->bitrates[i].hw_value;
-- 
2.34.1


