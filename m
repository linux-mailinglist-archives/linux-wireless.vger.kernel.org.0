Return-Path: <linux-wireless+bounces-9883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E54924FE0
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 05:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFD01F21BA6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 03:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF3817C60;
	Wed,  3 Jul 2024 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRNXv2ta"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF18224D1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978211; cv=none; b=tknUqae+nsRTcpZggFr23I0+EUBgwuAP7dd9vPOoj2bkqn6d1YQSldNAtJLmdsMP7zT4u9HPnFsy7pdETEj6scMLNlpm4SmlEBJRT9nq8CqfKJJ/jZpGIcgdFXSS92jGWP8+q3h7yoE/HhCH50fBt2L8jz3BiG87hBRuUbrJqeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978211; c=relaxed/simple;
	bh=rxkY6yust3JXy2TrIqy/PaFaZ3iMSz4YF1gmAPLvUcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAow6HfeM1yJkcRmceBlFX+7+tAlaHRUlUhE9gYL5wbEbm5si4hS8+150j96PwaVv28VQ0ZV7RVlPlMReVrtP38g9LtQVeulMBsZ2826Q84iM/SngOyiyYDLaJcZUsO1DM0S5YRJvw6aIKAYWSrEo949Z5/On0d0oVugzSQhkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRNXv2ta; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719978209; x=1751514209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rxkY6yust3JXy2TrIqy/PaFaZ3iMSz4YF1gmAPLvUcI=;
  b=ZRNXv2taainZOjIyQywMAE/qRFUhYHVRP+uwHspwYyrOUl/xv/TQo5Io
   mOGgodw0ES3tS87/wYFRJqYcZFiuAYkmQZCia22xWgaGnmPa99OuZnYRx
   mNDuOGJz8PQ7ViCC9yxjW+XJnaGO6u7YOk0DceyyrQja6PKDJNwIkYojc
   QAVpoVb9bR54jtukC8hdfnsRzKhQi8+m596quFW+OYqrve1VoERPGdaJO
   GDkKr644RckYXcQSBJ5acqO2/rqxbtUc5aVJ8DVBGXoFQSs2N3KcLaotD
   9SPI8n75WqOCul+3xNE5XtdyfmNo7swihTQ5Rszehw1iFO649qmVm7RwU
   w==;
X-CSE-ConnectionGUID: 6YUFWa7ISDSiYHVyAb4nEw==
X-CSE-MsgGUID: QvYxt3qhRVW7lrk4+Pb2GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17304037"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17304037"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:29 -0700
X-CSE-ConnectionGUID: Xq6HUHqWTWK1CCMbtq4vjA==
X-CSE-MsgGUID: 4tUM46gBQGWzry9mnlMbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51291062"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 20:43:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 1/5] wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK
Date: Wed,  3 Jul 2024 06:43:13 +0300
Message-Id: <20240703064026.a0f162108575.If1a9785727d2a1b0197a396680965df1b53d4096@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
References: <20240703034317.595020-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

The WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK should be set based on the
WOWLAN_KEK_KCK_MATERIAL command version. Currently, the command
version in the firmware has advanced to 4, which prevents the
flag from being set correctly, fix that.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 18ce060df9b5..b1e6d4eee68d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -654,7 +654,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 		hw->wiphy->features |= NL80211_FEATURE_WFA_TPC_IE_IN_PROBES;
 
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_KEK_KCK_MATERIAL,
-				  IWL_FW_CMD_VER_UNKNOWN) == 3)
+				  IWL_FW_CMD_VER_UNKNOWN) >= 3)
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
 	if (fw_has_api(&mvm->fw->ucode_capa,
-- 
2.34.1


