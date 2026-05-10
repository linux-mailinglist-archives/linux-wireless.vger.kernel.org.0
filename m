Return-Path: <linux-wireless+bounces-36159-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKayLhjRAGoxNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36159-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F89505BA9
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1BBE30022F4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA131A7E2;
	Sun, 10 May 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvw5rs01"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E193002A0
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438410; cv=none; b=RJvTOwtAeWJRHkhHnAw7nsCiKGsuBwysAcc+UHSVCm7VAxP/iJAxg+GTeRVV7NHvTLiV5So8lPIin23UgrkZXyYgcmym+cdOhYyivdFruAEjWaIxiTDKdVtLLb6JvcODu8GUGON0e6K/D/fhlsKKSdn52rJqFKeIKaN2vVaz0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438410; c=relaxed/simple;
	bh=7FUFODScREFExGIdy40kjUxN2o5F7kFC6qP3mGIkKYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WfOMSxlr+qx2D2+hVrp5VPhgJxf9cptPFS3TxhKm+TsH3iAc7w91dAHsAVPfr4x1ETtACqzh2kwpK3thm5QR9FbS9Jg2ciAvheLWlI1LVC4fN/zlYXvfSyS7kC7IEcxXQcHRX+HRKP3nDhZnHPZzIePe4r8J2AG6M5qpNjxzssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvw5rs01; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438409; x=1809974409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FUFODScREFExGIdy40kjUxN2o5F7kFC6qP3mGIkKYU=;
  b=nvw5rs01n1Kery4zIvTIqQTUjzMkmo3omRpkhHqLIW7TZaAjGUeVHGv2
   C1llGX5jxUddN4bdMevf+sV6jjSo0Pjyz+Lm50FUZjZXhoKA0pjnFSKXE
   8x2Qz5xMqqaASbilKyXWTRVAZqksNdozRTpnm2QQIc3wzeCoykH25rAtM
   S8fGGorOrl0dYkYwQFsYxThwqRSbaDxLoZpsgj2YPZMQeRaXCABHciHG6
   bM4Ow6C/LZZGRnkB0RZlGGwqkaNiYJqbygK2cS43ZvijegycquS57eeOF
   vDzz5/S+AroHbTHkXd1lA4vmLEf+NVSBb54YUDAXre1qY805oVisnLAXb
   w==;
X-CSE-ConnectionGUID: KJp3F4L8TV+Gzws1TkUg2g==
X-CSE-MsgGUID: VgoUIJvIQsqD6IOd9ufjiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208988"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208988"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:09 -0700
X-CSE-ConnectionGUID: vS+k9KfNRgGXmlVwbWM6zw==
X-CSE-MsgGUID: MdOALHFqSKGHPwqsejXyMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626856"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Israel Kozitz <israel.kozitz@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: fix NAN max channel switch time unit
Date: Sun, 10 May 2026 21:39:37 +0300
Message-Id: <20260510213745.f0d2606d8939.I89d9f336aaf388c6e48769de5fe1e5db19295057@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
References: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 85F89505BA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36159-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Israel Kozitz <israel.kozitz@intel.com>

The max_channel_switch_time in wiphy_nan_capa is in microseconds, but
the value was set to 4, which is only 4 microseconds instead of the
intended 4 milliseconds.

Fix by using 4 * USEC_PER_MSEC.

Signed-off-by: Israel Kozitz <israel.kozitz@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index cad10f011072..49c75d4ee9a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -298,7 +298,7 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 		 NAN_DEV_CAPA_NUM_RX_ANT_MASK);
 
 	/* Maximal channel switch time is 4 msec */
-	hw->wiphy->nan_capa.max_channel_switch_time = 4;
+	hw->wiphy->nan_capa.max_channel_switch_time = 4 * USEC_PER_MSEC;
 
 	hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
 	hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
-- 
2.34.1


