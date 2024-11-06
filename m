Return-Path: <linux-wireless+bounces-14946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 596359BDBF1
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32DF1F25C40
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC255192B7C;
	Wed,  6 Nov 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfaJ/vJ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226718FC84;
	Wed,  6 Nov 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858969; cv=none; b=gBetxuC1+4hqDQbsRFwDnOk3U/1ztNVGc1yayGbqN9t/7+yr1rDfehxqjIdsq2ugrng/AtoNqKz5cOHml2uauSzaexKCSBrHrH0Z+I/S+/ojPhJfJEFCPb0hc0k/bUgt1xKQX0dFw8QRn57A0FxH8m1soQ4bwlKVfNG6qELyANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858969; c=relaxed/simple;
	bh=pzPy2AymgTet41TuBvckhGh6NcwJxAzsOOgSMIQvJg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQsAdCRFfyGeFL/pN9h687rfxl8KhfP9YFN99RwO86vfPTmHetyDSg0F/kGz4xo1GzPlTOHWuMZRO3zTaI8Rapwgm03xeu7iWbV+dyrMOr+6L7pYKYu3V/k/hbnG4H7ifBAGoSk3rhdpbRv2Rg692JIn9dRYyC78yFDt8TLZVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfaJ/vJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E1DC4CECF;
	Wed,  6 Nov 2024 02:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858969;
	bh=pzPy2AymgTet41TuBvckhGh6NcwJxAzsOOgSMIQvJg4=;
	h=From:To:Cc:Subject:Date:From;
	b=DfaJ/vJ56ECR1EP2rM/YnkiadQjHdUsZeOiZZ5wVnKWXjj4irIDon9bF2rYcx/oyo
	 DElo5wsJGMGlEHRyWk/fC1jtmBLoLTwCyte8/BClhcRVis+UkmBskynrzHNcwBcwqW
	 pjxmJG855nV8/p2ZzibTpuNV4HgGE4d3bU255UF6phphxx0SF8kwWm30e8IaUlxFeB
	 yvlmYTgldEUj/XFEvW3AOJ66ZwsWahK0BNdwdOh1uU7e7iZ9eJ2gGBbtvZj3C0/LG4
	 DDfkP9VU6GkA8vbZKdGAHNTkVbOcvzSDwvdLiQScYOWC2SPjICfHNI4Sb1wcNdamBY
	 5d8KGFiQVBQwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "wifi: iwlwifi: mvm: fix 6 GHz scan construction" failed to apply to v6.6-stable tree
Date: Tue,  5 Nov 2024 21:09:24 -0500
Message-ID: <20241106020927.164821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7245012f0f496162dd95d888ed2ceb5a35170f1a Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Wed, 23 Oct 2024 09:17:44 +0200
Subject: [PATCH] wifi: iwlwifi: mvm: fix 6 GHz scan construction

If more than 255 colocated APs exist for the set of all
APs found during 2.4/5 GHz scanning, then the 6 GHz scan
construction will loop forever since the loop variable
has type u8, which can never reach the number found when
that's bigger than 255, and is stored in a u32 variable.
Also move it into the loops to have a smaller scope.

Using a u32 there is fine, we limit the number of APs in
the scan list and each has a limit on the number of RNR
entries due to the frame size. With a limit of 1000 scan
results, a frame size upper bound of 4096 (really it's
more like ~2300) and a TBTT entry size of at least 11,
we get an upper bound for the number of ~372k, well in
the bounds of a u32.

Cc: stable@vger.kernel.org
Fixes: eae94cf82d74 ("iwlwifi: mvm: add support for 6GHz")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219375
Link: https://patch.msgid.link/20241023091744.f4baed5c08a1.I8b417148bbc8c5d11c101e1b8f5bf372e17bf2a7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3ce9150213a74..ddcbd80a49fb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1774,7 +1774,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 			&cp->channel_config[ch_cnt];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
-		u8 j, k, n_s_ssids = 0, n_bssids = 0;
+		u8 k, n_s_ssids = 0, n_bssids = 0;
 		u8 max_s_ssids, max_bssids;
 		bool force_passive = false, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
@@ -1799,7 +1799,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		cfg->v5.iter_count = 1;
 		cfg->v5.iter_interval = 0;
 
-		for (j = 0; j < params->n_6ghz_params; j++) {
+		for (u32 j = 0; j < params->n_6ghz_params; j++) {
 			s8 tmp_psd_20;
 
 			if (!(scan_6ghz_params[j].channel_idx == i))
@@ -1873,7 +1873,7 @@ iwl_mvm_umac_scan_cfg_channels_v7_6g(struct iwl_mvm *mvm,
 		 * SSID.
 		 * TODO: improve this logic
 		 */
-		for (j = 0; j < params->n_6ghz_params; j++) {
+		for (u32 j = 0; j < params->n_6ghz_params; j++) {
 			if (!(scan_6ghz_params[j].channel_idx == i))
 				continue;
 
-- 
2.43.0





