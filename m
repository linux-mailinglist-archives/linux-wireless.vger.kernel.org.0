Return-Path: <linux-wireless+bounces-12413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09E96A8C9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC6285A26
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A31DCB0F;
	Tue,  3 Sep 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgjZxlVe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D51DCB0D;
	Tue,  3 Sep 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396169; cv=none; b=iVFKxoOvtqOYo33+o9pJ3/6tsy02WHGIsBHI4AD4WN8O2TOpQN79TybTfBCWuHOoY/rkFpt/kpsMMQkHUIc2g2zTqLUC+pTOyM1oBksphI0MyeEv6vDzQdSinnZTGnCe+cvmBj4o0wYHAImTcztFkHSGa0Mh+LKrTzQNbeKHGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396169; c=relaxed/simple;
	bh=9GXGzmat0e4B5JG9QZsmkvibkwcoxUaOZC0NSGYFrGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQS7iQwAE3bmkUcVCAo3EmbqZVGLddAcGhC2KKAcQOOWi65RzveQ3djxmK1pIaaE+iNU/87w8daFv/ZCo9lGlNwdVxMrpoSVASO+L2GLendiLCCmCYgUtZDKpc5IlU46OJ9wo48y2beUZSWg1rdmOGsH1PZN63Up0pHUx42LmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgjZxlVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223FBC4CEC5;
	Tue,  3 Sep 2024 20:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396169;
	bh=9GXGzmat0e4B5JG9QZsmkvibkwcoxUaOZC0NSGYFrGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgjZxlVeXwhagq0ATcydpsyMIyPKA8UwKJEoTlblX8dGU3Mwe818yT+u0Eo3nT9rt
	 Zg/aticCVC9toW0WGORgH7Q+3MrZ+0FcxPWahJ89NjXKsYVr+KTj9wVmFbboAoA33v
	 DKiuYcqaG6ygTrC20rqMrRbKVK9ySVwg8luchn0S7/EvBUlUHuKDYSyfVBVRFJ5d3e
	 V/NbuIr+k/JcIXEUGNTaTS+moR1FPsjSk6+MxImSa0TNd30juJdGtZI4vw4H4zLVza
	 XhIGbTRWwqm8XlfLD+n/eRW7imWpchfd9L773+wbJjnqSmg1POBk/WjmRTXInnGc6Q
	 xbgw3r1eJ4DYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ayala.beker@intel.com,
	benjamin.berg@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 18/22] wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()
Date: Tue,  3 Sep 2024 15:22:05 -0400
Message-ID: <20240903192243.1107016-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192243.1107016-1-sashal@kernel.org>
References: <20240903192243.1107016-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.7
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit 916a5d9c5354c426220a0a6533a5e8ea1287d6ea ]

Driver creates also the WFA TPC element, consider that in the
calculation.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20240825191257.e710ce446b7f.I2715c6742e9c3d160e2ba41bc4b35de370d2ce34@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 4f04df509029e..f19f8ce431eb8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -48,6 +48,8 @@
 /* Number of iterations on the channel for mei filtered scan */
 #define IWL_MEI_SCAN_NUM_ITER	5U
 
+#define WFA_TPC_IE_LEN	9
+
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
 	u32 max_out_time;
@@ -303,8 +305,8 @@ static int iwl_mvm_max_scan_ie_fw_cmd_room(struct iwl_mvm *mvm)
 
 	max_probe_len = SCAN_OFFLOAD_PROBE_REQ_SIZE;
 
-	/* we create the 802.11 header and SSID element */
-	max_probe_len -= 24 + 2;
+	/* we create the 802.11 header SSID element and WFA TPC element */
+	max_probe_len -= 24 + 2 + WFA_TPC_IE_LEN;
 
 	/* DS parameter set element is added on 2.4GHZ band if required */
 	if (iwl_mvm_rrm_scan_needed(mvm))
@@ -731,8 +733,6 @@ static u8 *iwl_mvm_copy_and_insert_ds_elem(struct iwl_mvm *mvm, const u8 *ies,
 	return newpos;
 }
 
-#define WFA_TPC_IE_LEN	9
-
 static void iwl_mvm_add_tpc_report_ie(u8 *pos)
 {
 	pos[0] = WLAN_EID_VENDOR_SPECIFIC;
-- 
2.43.0


