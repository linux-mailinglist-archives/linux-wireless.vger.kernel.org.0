Return-Path: <linux-wireless+bounces-28749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B1AC4643B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C60184EE1A0
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E63309F1A;
	Mon, 10 Nov 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eISrl1yW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A00309DC0
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774019; cv=none; b=c+zx9oVHsQDLD8yrWaEr3OVA2BeXJUgS8Mhs6JN8ZSv54UCTCBeKmKaekMDsPeV+KrdB8kx9UXZkDV9VImhMCrBmXwVmjn/mbz3sHEWSd4d0LyFlCIVqQY/vIAu6mEG3TrQpDzgtojM86mP48augVkB99yAT5mz1NLhoKiiVshA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774019; c=relaxed/simple;
	bh=HTLWTdxdGgRvV++AAYdCEleZPqZeGqzj5ZRNEg6RktI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H570hPpfPab0kI41k1aBxKNKb8dta1Zvc0pLYe3FtXnPeWs8Zoe76jvgx03TYkesA/YNRxCe16aA4j7U6AAWLHpfwEu6qcoMCoY/osTz60YcwfK5wJtEoWpQdxf9fR6Z7LTQp+fpcOPUDn2taMoCdUa14O6Z/nqTd+m30WWgwmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eISrl1yW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774018; x=1794310018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HTLWTdxdGgRvV++AAYdCEleZPqZeGqzj5ZRNEg6RktI=;
  b=eISrl1yWJnQKN7q8IMmQG2Y+96eZUz7asZPEUer04ydZpi8xChaK+BYF
   VsyExJE4OOGe/zZyi0SB6OPFkMMZ74KLejuHcq78XsKikVqQK583kvc3b
   Q6QCNW2ttAU3xl4DwzJCn+ghxAGi2x3lmO7D5sdgG8Sm+w7Ih/zei/OlB
   63n+xFaCbV+tIYN13sxKbaC4HH/B2Vw7PcPi5eBtnUBy6yCNfKKJxCenu
   LpMeof/gq2WDXW6VokwT9HzRXa0CPN7PT//Ot5hLSflfPSO5/qeImild8
   8M2K6Yf/GiuWpG8ihQJUBaj/IA/ZmZWvKGk9MHcZFMrDQpu6dkhrbdA3W
   w==;
X-CSE-ConnectionGUID: rRxAhjDyRMej0p/1CaCubQ==
X-CSE-MsgGUID: ou1TMv+tRbukrClbR9B2fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64856415"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64856415"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:26:58 -0800
X-CSE-ConnectionGUID: psudv9duTUag122To343pw==
X-CSE-MsgGUID: mB0JCpS7TGOtlZCo3/B+aw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:26:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 2/6] wifi: iwlwifi: mld: Handle rate selection for NAN interface
Date: Mon, 10 Nov 2025 13:26:44 +0200
Message-Id: <20251110132506.72046f98f878.Ib784931fffd0747acd9d7bb22eabbbec5282733e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
References: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
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


