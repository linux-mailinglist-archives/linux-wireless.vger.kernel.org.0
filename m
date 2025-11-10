Return-Path: <linux-wireless+bounces-28770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF55C46BE7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10CFC4E7860
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B6030BB95;
	Mon, 10 Nov 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLfmVKhW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76830FC29
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779758; cv=none; b=TNjHAKK61lNpzqZEpWXS4VqAUFhYMsbMvgyR7DhlW9HR3fAq5EyblqqPfFm7wOFLJoSLV3CsPEezqvpl04AArLjLN/C90xhjZIzW4i6U9aTkltv1+vtz9DX9o6Ph4H5CqBPytFpqUsTWvInToHz53zCw1hRaOCN/IDfH7DGAY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779758; c=relaxed/simple;
	bh=Hd2AbwYVH9SDXUl3evJfM7ry1ZiqJy4lrT0vNuqu3q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKRiaIKPBiSDEPats1isNHCLUSnptm+ai0cfrNcbNk4yptq4IKq9bgx43mBTlSWt4sOvNOOE15IWOTCgv4F8snESEq/xQZccNe80TQXotMIDeJje1EpAG9IQGuViba8TswqGH+87eYG0Qpgxexr62BGR7NDY7YwOBYlfJNRB52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLfmVKhW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779757; x=1794315757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hd2AbwYVH9SDXUl3evJfM7ry1ZiqJy4lrT0vNuqu3q4=;
  b=VLfmVKhW0bi8bU49EewE5F2GOozda+ngjjw7OmeBHoT1oCJghTnz8idI
   C47pGTokHMlbDenxMdWQnCquKwNruX7MPbWRq70SAP0sM4F59y56bxdNA
   Db6fyKSbcnKY12MFNw+uhR1g9HOMM8jfQDv1g/xDq/abS8ooi5LDn9yx2
   kPsDhuU0OvyIopMbj/trq5hFmO/zn8q9qcsNuS6HH6j3ugF9zUAW79+Gd
   0BhCdheYzyhX2KLxFyYQHMM/8wYZob9j0Y0CeIzxDoYITwlM/8/JAE/Lf
   3zL2H/JHwhOypDwmFKEovx24xrRMKSgayWKrJBAUbmFT9k8Ln5nKnIfxc
   A==;
X-CSE-ConnectionGUID: eVX39knCQku/DakuoZ3Kbw==
X-CSE-MsgGUID: lWGsfufrQGCp6D66q83uCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454873"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454873"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:37 -0800
X-CSE-ConnectionGUID: lLZ/YcMXSM+PeNAGT5mDGg==
X-CSE-MsgGUID: g0xwsyGKSeeag+xjEXnUGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928506"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mvm: Remove few redundant 6 GHz scan chan params
Date: Mon, 10 Nov 2025 15:02:14 +0200
Message-Id: <20251110150012.3b4f8ed30498.I014c098e64118fe3adaf6db07816e7df8ea4f79e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

- iwl_mvm_scan_umac_chan_flags_v2() computes channel params flags
  that are only relevant for 2.4/5 GHz scan, explicitly clear
  the flags for 6 GHz scan.
- n_aps_override[0] and n_aps_override[1] are not relevant for
  6 GHz scan, remove them.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index b588f1dcf20d..59331f1d144b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2568,16 +2568,16 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 					       bitmap_ssid,
 					       version);
 		return 0;
-	} else {
-		pb->preq = params->preq;
 	}
 
-	cp->flags = iwl_mvm_scan_umac_chan_flags_v2(mvm, params, vif);
-	cp->n_aps_override[0] = IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY;
-	cp->n_aps_override[1] = IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS;
+	pb->preq = params->preq;
 
 	iwl_mvm_umac_scan_fill_6g_chan_list(mvm, params, pb);
 
+	/* Explicitly clear the flags since most of them are not
+	 * relevant for 6 GHz scan.
+	 */
+	cp->flags = 0;
 	cp->count = iwl_mvm_umac_scan_cfg_channels_v7_6g(mvm, params,
 							 params->n_channels,
 							 pb, cp, vif->type,
-- 
2.34.1


