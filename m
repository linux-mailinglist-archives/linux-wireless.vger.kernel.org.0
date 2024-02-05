Return-Path: <linux-wireless+bounces-3176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AC684A6DE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D871F290A3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625E59B53;
	Mon,  5 Feb 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhfX1YC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D812A59B6F
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160930; cv=none; b=pmw/bzBMdB+Cs6osIz5s691hd+tr86fuicG81n1l/yrotuvyAi2j98g3HXQ5muts67wmQz6EPGutokBWy7UgziazbYgXLVeo5reknfWG0Ch5FjWVCUhWeenHm+3EBcyZSQvTxCtgPF3LxLqYKBzsXORK03VcTQLf3WMXdSPbZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160930; c=relaxed/simple;
	bh=U6JmBSTA+cPxOrE5UZi6Qm6HMiUOtHM2GE+gWFZlD4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ef5uZTxTLru/hzj5lgOlg6zcYjoj/ujQdEUklHjRVYAshKsxP7VmjTgUt7CF/OChBy1wWJPIuobJtm94fGP8kWbirqyBVspnW2s2OZ2YuFuOQRRZ6K9bf8ZYpZTRl7Lz9ZKjejx8E6aUAL3Mr8XqT5UHh3jHzTyONL8IRI360tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhfX1YC7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160929; x=1738696929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U6JmBSTA+cPxOrE5UZi6Qm6HMiUOtHM2GE+gWFZlD4Y=;
  b=bhfX1YC7l3AHshODsqPXAXEk5ixpNJgstjEoe1I8uHmGZjcddWjsvCUk
   edBpnGVPOVofu3IFRmkAnz5huiAB7vq5GvM7aiSUj6kFpk/pmFxWCK7Mf
   kYh2dHLqb2fwRdBlH+ofUfE463AFZVyCPNRXYroYOXOJzxjUdV2ppIpoJ
   5UNH/fUDnvNO2VULWDy1+cRj886V5yEy6Q8Is3wjOIR1Xood9JWNJYzIR
   KqYfiMGjYePAijbsTfdzrtNYcF4agbn4zEOabkh8CiN8OhrC1CxQy3ELD
   nSaiB7rc2HVwU9jvhtH8trr+6uMmSRWh76tJxA9gZ3mVIdkXVjqXBUKjv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381660"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381660"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403192"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:08 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shaul Triebitz <shaul.triebitz@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: avoid garbage iPN
Date: Mon,  5 Feb 2024 21:21:13 +0200
Message-Id: <20240205211151.2be5b35be30f.I99db8700d01092d22a6d76f1fc1bd5916c9df784@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Shaul Triebitz <shaul.triebitz@intel.com>

After waking from D3, we set the iPN given by the firmware.
For some reason, CIPHER_SUITE_AES_CMAC was missed.
That caused copying garbage to the iPN - causing false replays.

(since 'seq' is on the stack, and the iPN from the firmware
was not copied into it, it contains garbage which later is
copied to the iPN key).

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 89030647e639..5bc08c1d207a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1866,9 +1866,12 @@ iwl_mvm_d3_set_igtk_bigtk_ipn(const struct iwl_multicast_key_data *key,
 		memcpy(seq->aes_gmac.pn, key->ipn, sizeof(seq->aes_gmac.pn));
 		break;
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	case WLAN_CIPHER_SUITE_AES_CMAC:
 		BUILD_BUG_ON(sizeof(seq->aes_cmac.pn) != sizeof(key->ipn));
 		memcpy(seq->aes_cmac.pn, key->ipn, sizeof(seq->aes_cmac.pn));
 		break;
+	default:
+		WARN_ON(1);
 	}
 }
 
-- 
2.34.1


