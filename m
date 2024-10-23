Return-Path: <linux-wireless+bounces-14368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53629ABFFD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 09:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1031F25C6F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873714F10E;
	Wed, 23 Oct 2024 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fi1UDVHZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890AB487BE;
	Wed, 23 Oct 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667872; cv=none; b=d9wOz/9kRdbZh/wBE+OpVTJ3q40LNy6/6xwZ2S2LsFBeMAKelcz2QCyspwzatCmi0PhUoNSQbRwTAFfNc+9M1Wg9vO34xyjOM/Ri5DHcVOC4J5g9vosHhLCapfR0oJXrBt48bENKvqjRlQogySLOGocksTpe7op+czD5bxJUiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667872; c=relaxed/simple;
	bh=afF8vglCtRROVzu7N2I6gpr2Sq2lHIAx4OXFxmgbOR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZnBfRcAo5U8Xsqrjni+WaTBzNm9uXVc+SG6JlV4TTy5kOAwcx7Y0Q1x97XLU5aFk+3EDMJr/fxtO9TwIfazOmzMy6F5P9aaxBPzX9TYjcmVjJOA/JQ34+CdFBXvd0aXxYPuWx/Dgy3Beg6c2lrNhHWSS0N0qHP4oUXCUjMAwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fi1UDVHZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=MDYSR9nkX+fsy3o0RMUtJjkmmskOadhB3i6RFGShFH4=; t=1729667870; x=1730877470; 
	b=fi1UDVHZIdxyURsZOm5YEbM+hfP9qnbTRSBnuX3pENJ7WvrevvlwkCKfkdvynSLr6c43cGuRxYv
	8MG1CvOBUm5EIiqLY6zHvZVlH/9NU07zCmpxjIMoFQtpwZdyO4xZcfuQsZgK/Yw4IVDI0t3amSPtq
	Kku+MgMGrX9RZ3mlSkXuLYoPZc6hq57K/An8F2h97Gju9sGGHCGw3wUCiK/9qJV7T6Jjjdb9ArrSq
	z6E6Vl55kmW4kE/EOZYLKDV1In1q3QzPOjGiXUEmCPzH1qTQVU6w5BCFf0VZM27p9LDjhUKGoYs2M
	OCnACIj2i7e8xwW770YUm6USeekkkNDJXYjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3Vcp-00000002Wso-1Tn5;
	Wed, 23 Oct 2024 09:17:47 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: iwlwifi: mvm: fix 6 GHz scan construction
Date: Wed, 23 Oct 2024 09:17:44 +0200
Message-ID: <20241023091744.f4baed5c08a1.I8b417148bbc8c5d11c101e1b8f5bf372e17bf2a7@changeid>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If more than 255 colocated APs exist for the set of all
APs found during 2.5/5 GHz scanning, then the 6 GHz scan
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
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 3ce9150213a7..ddcbd80a49fb 100644
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
2.47.0


