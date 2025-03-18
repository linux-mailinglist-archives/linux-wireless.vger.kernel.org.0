Return-Path: <linux-wireless+bounces-20493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83425A66FCF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 10:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712B919A22E2
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5E1FECC6;
	Tue, 18 Mar 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DFk2SsE3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329711EF362
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290230; cv=none; b=Za9lb8UCl6A8Wk3i0JLiAhw1pIxNKOgcuk0ClL8wchvn1bRv06D16wObTTLtASNwTnWxscbKE1Ua5ZOGqwxXg6BUdHh2aWcWiGeQUnDwrW435jMMUyV6QMKYPG8+CZZ1u0qrCbACffpbYsJ94yu4hw3I/o2vXk8YQpVsdRq3zuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290230; c=relaxed/simple;
	bh=vDI3ChbCXhMo6c9IZtiHrXoWEID4pH8zAT3KiwivZBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU+IQwkteboLw7Bg3PMT4NKp8DuivuVZf18v5pvmBGG/Wmz7O7yrabyBym3J2ZI+bI0h2wY/584qWVW/jSE79gqwwF6ypYmcNwl5BrZ97EUXQ9uBJy0kO5m3zGmsbZRrGiGMTj4m7BXUqprht86DgEY999kRNOg8GEFEx3U2Uc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DFk2SsE3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=46ZcAyaWBG+s57DeRkrZL68XcLx2USy7Gd0nzXHTKHI=;
	t=1742290228; x=1743499828; b=DFk2SsE3Tz0sckad4PTF8r64j6Thc3QtR0fbBWInS593J7G
	I6q4c97qeWiSWw1bJN8kmOvL4SVd212UFkObli2zzk+pZSA/vDmkz19v6LcIuLyN0DapdPvO44giM
	sRyKA/b2QpVjjBNcA5X8e1ntGjOAQlgnfGk3wdZHbmx2rSwdBfqJpSGgl8Cxqw895VSTfZNCDRLsR
	hbxLR7Zh6++SDNJbh/gANQBhrf/nh7PgMNeCm6pD9XZWDFdqkvNV/8gVy+qpbEGm+Q/oQaRS3GpEL
	JjLcPACPAqwZDv91eUj5Iqzg/ed1Y+4il5r+YeTeGE3NBE+ok9GK7In5TrF2rLPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuTHF-0000000FBmW-0bEl;
	Tue, 18 Mar 2025 10:30:25 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: iwlwifi: do not use iwlmld for non-wifi7 devices
Date: Tue, 18 Mar 2025 10:29:44 +0100
Message-ID: <20250318103019.df6df96df826.I0020ca9f6c6c928caa78721666df131a692c6186@changeid>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318093019.185216-4-johannes@sipsolutions.net>
References: <20250318093019.185216-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Roll-back to use iwlmvm for those devices. iwlmld will support wifi7
capable devices only. The firmware for the non-wifi7 capable will soon
be frozen and we don't want iwlmld to have to support devices that will
require the old APIs.

Fixes: d1e879ec600f9 ("wifi: iwlwifi: add iwlmld sub-driver")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 15d2211e565c..d36837501e08 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -174,6 +174,11 @@ static inline char iwl_drv_get_step(int step)
 	return 'a' + step;
 }
 
+static bool iwl_drv_is_wifi7_supported(struct iwl_trans *trans)
+{
+	return CSR_HW_RFID_TYPE(trans->hw_rf_id) >= IWL_CFG_RF_TYPE_FM;
+}
+
 const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
 {
 	char mac_step, rf_step;
@@ -1730,10 +1735,12 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 	}
 
 #if IS_ENABLED(CONFIG_IWLMLD)
-	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION)
+	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION &&
+	    iwl_drv_is_wifi7_supported(drv->trans))
 		op = &iwlwifi_opmode_table[MLD_OP_MODE];
 #else
-	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION) {
+	if (pieces->major >= IWL_MLD_SUPPORTED_FW_VERSION &&
+	    iwl_drv_is_wifi7_supported(drv->trans)) {
 		IWL_ERR(drv,
 			"IWLMLD needs to be compiled to support this firmware\n");
 		mutex_unlock(&iwlwifi_opmode_table_mtx);
-- 
2.48.1


