Return-Path: <linux-wireless+bounces-7526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975B78C3511
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5442B281CC0
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01DE208AD;
	Sun, 12 May 2024 04:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8L989wx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0D1EB37
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488308; cv=none; b=bmmeKcd301LxH+sI0qlr4rQcyasIdXItvMvzgAnMph0faZatPRd6SCaZbYcwZ9dqGQ5ATM+cqUz+29I1VZEtxmrHlUfQ+gwQGkWFe/OkBxkr+X9sHmhLC00pG3XWKkDO3sD1YrvfRpME13oBmWFd/NR+6/Kx+MG7UnVHk0NGxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488308; c=relaxed/simple;
	bh=t0K/uWPQqJua7x7knKr97pAvGWy1B5d06Qre1Rxe+1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6DXtOo93GyTyHx1q0pvfUM6JFa4wlGj8XaWEvqkmzYzhNAOSKBch9d8KvpSxM5GRnfRopRr+y3cqTQ9wkGnSsMVN8JZIObNuuTy3Nszh8U1KhI4pwxv9ed5p4k74AR5WjyK5p6/p29LsWgH3x+3j0aFAUxoT7Q39zFlzGjuvJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8L989wx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488307; x=1747024307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0K/uWPQqJua7x7knKr97pAvGWy1B5d06Qre1Rxe+1g=;
  b=I8L989wxsiTY8NSfDouvy7FK+RWoVHl0GsKA18raUm5pEteOJMQGLmGg
   Obnr4Oq9ADTLACncyEyu6Laoiq7f2xmHIet4dhortKE4oLwIVoVND1ptB
   LaMoP+aYfDDkCbdixCZdNTBLiORwnsT1L9c8vof8ywZjTc0do1Fyv9q/l
   mWsc8eBk63yaDwN2BxyMtYIC4AVU3JyIV2To1nAqiPR7X0fjIywwtzbOa
   F1Eflc/9KN5CGjm51uZwHl6e9qZUh6Y23BKRqav34sJg6ZMgQNj8I1g43
   ZIfMYCgbhU9XPeeMJD7MS0Sunx2hWfnJ5ehh63e/OC20RP8vczoO4t47j
   A==;
X-CSE-ConnectionGUID: mX6TqMb9RBecUYh3aqm17w==
X-CSE-MsgGUID: APE2kn/AQjKQCk5NTldl/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323872"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323872"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:46 -0700
X-CSE-ConnectionGUID: j5udjB2hQ5GO7rJyQikmbg==
X-CSE-MsgGUID: viOr3XYvQD6oODWqXuaOrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532201"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 15/16] wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd
Date: Sun, 12 May 2024 07:31:09 +0300
Message-Id: <20240512072733.f429f618a46b.Ie9b581652b74bd7806980364d59e1b2e78e682c0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
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
index 0f954e506d62..00dadd133ed3 100644
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


