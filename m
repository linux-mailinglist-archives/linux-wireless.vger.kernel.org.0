Return-Path: <linux-wireless+bounces-7583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAA68C3EDD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2188F286DA2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5E14A4FB;
	Mon, 13 May 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilh7vR+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82314A0AC
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596046; cv=none; b=q5nAPgPhUMq7BnA6hLfn7OJ8VUttGLGA74qjkg3hpgJTuuCPFEbuAqKAcvJxKF6SLiYnB505xMR4eHUigXaRQYJU1YUbFw304Qzam3vJi6JMtv3cB5+3C6+JbK670Fid4VROZUtvBqEOqwRNYvmycAt64lH+HV9xerg7elPCWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596046; c=relaxed/simple;
	bh=lj1prPsxS5+5Xt0GC2Ocg0w7Ojiyx1sP5S8nBuEXtzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRtGcjIYPHM0sv+kO1YF/g6gkl4MNk59ZnEfL7/BWSnO0DDQsKm/bU6E7EQjUM8SKBozYjcNEEVGaKiwMjQtDEuRs8QqF7PsogtTwAkTQNUsZkNqskP+en4VCjnAftVS59RHHJhUM+3tUJVqzKSSnPllf2toRX2xJ7hkRFufTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilh7vR+T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596044; x=1747132044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lj1prPsxS5+5Xt0GC2Ocg0w7Ojiyx1sP5S8nBuEXtzc=;
  b=ilh7vR+TYNrZJ8uvzYpotJPinR9X0Xz52PGKlKXuR2DeXOMgo+HbhY5d
   u7uzcvQcnVyPsS3CMFDcLxeyNR+GnIWnGK6oB18sAB1YGUa3V4bPF2646
   8l8d1r5CKuoWq4U0AEyKG3xWiuWyFHvDdky9/9nSNlXekMjdBP4fIB3RH
   qiMz6LXwARzPJq3rxNsj5u0RXXaTvltVHJUSFnpY9PNC47ykQpKK9lHgW
   HMYrbL5WKilhVcpm7krccMlVSOgxYFQx7na/liZZS+gzfl0UxuQyqQ6zq
   3X+uj8AwbbBWMRPvFXJ9QhCqiRYAlO3M7qeM79khN95zOxjiTYct2or7a
   g==;
X-CSE-ConnectionGUID: 9RiTkLTeSCyUJwW6DglHDQ==
X-CSE-MsgGUID: uA5laOuMTlWBwtqKIyoSUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928650"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22928650"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:24 -0700
X-CSE-ConnectionGUID: ZTaTqHK8QjmUa12HJ/ARag==
X-CSE-MsgGUID: KTAUhH7mTLCZqJl7zIb1GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="53516403"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 2/7] wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd
Date: Mon, 13 May 2024 13:27:09 +0300
Message-Id: <20240513132416.7fd0b22b7267.Ie9b581652b74bd7806980364d59e1b2e78e682c0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
References: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

The BIGTK cipher field was added to the kek_kck_material_cmd
but wasn't assigned. Fix that by differentiating between the
IGTK/BIGTK keys and assign the ciphers fields accordingly.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 52518a47554e..30e0afe8914e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -595,6 +595,12 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
 					 void *_data)
 {
 	struct wowlan_key_gtk_type_iter *data = _data;
+	__le32 *cipher = NULL;
+
+	if (key->keyidx == 4 || key->keyidx == 5)
+		cipher = &data->kek_kck_cmd->igtk_cipher;
+	if (key->keyidx == 6 || key->keyidx == 7)
+		cipher = &data->kek_kck_cmd->bigtk_cipher;
 
 	switch (key->cipher) {
 	default:
@@ -606,10 +612,13 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
 		return;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
+		if (cipher)
+			*cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
 		return;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_CCM);
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		if (cipher)
+			*cipher = cpu_to_le32(STA_KEY_FLG_CCM);
 		return;
 	case WLAN_CIPHER_SUITE_CCMP:
 		if (!sta)
-- 
2.34.1


