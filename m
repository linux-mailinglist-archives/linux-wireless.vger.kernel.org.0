Return-Path: <linux-wireless+bounces-37040-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAKFDulOF2r7AAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37040-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:07:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4445E9EA8
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B978A309002C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC33B6354;
	Wed, 27 May 2026 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2DZRIjh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CC3B5DE9
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912349; cv=none; b=SIvLSEmbDivKjsF9dVGHISruGHvKW7wVqHKe39YukgrjArVN89lw0Gf2ibLbX6BO+Z6wl+R05u9DjuTes5UrpmubQQRMkyvdNnpVzYGT20+ltyAI1fE2LNdBUnhPM0JWUW0GQz1Lk/JfcxbL20Nqps4GOou7hXRyUv37wj9sJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912349; c=relaxed/simple;
	bh=ANOin8cCVM9ejScaOY80RGge1MDPkWcUaZLfbqBX6Os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YAVVrqocO+ipRgvL+fiLUsbBxxtk9zZeAifej4PlEQj48m+OgRDUHruvc6BInbiSKW2dtA4N2oWkHkcCTHWTOHT3Vhz49L2JCZ1MYfe4ixixUZyGgMuYaZ/EJoqPnGs3eQ4Z8G4kWAtYM3ZvPLScg8D6ztITHSIZguqM+YBr4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2DZRIjh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912348; x=1811448348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ANOin8cCVM9ejScaOY80RGge1MDPkWcUaZLfbqBX6Os=;
  b=T2DZRIjhGgelL3FsdaKi2bg+psUdMyU4bcTLUd81dkBO87Du8YgXWsZ1
   v2EivW+B7bz1/u30U0hq6WI7oa1P+Q/Ihyw+Y7kRP28W+bReiuEJN76Q3
   1fZAWE+VZTLNp4IoEbWteDKxVyjes/vuc8IK/Y1QKANq6aKnhsGLAeaJ5
   8DrML8NCFdhBONGV7dwaUv0FIJMElyEpv2p351to3bow7lteQgP1MLTpY
   AkJmFqLSJ7zP0euX1B2myN+bNLwGPM32kY7tqBFbyXCoISg+r9JiBDw/g
   xwDQpJTbP3GoAq0dKgTkh3F3ZxRXCj28VV4wUEeH4U61Q1ugW+vI+NQvx
   Q==;
X-CSE-ConnectionGUID: Fk+QobhRS2quAvb0IXARnA==
X-CSE-MsgGUID: atMq0FP9QiqGqCyqVSt2sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940881"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940881"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:48 -0700
X-CSE-ConnectionGUID: 3nwS1H9GSLWmlU9iQjyOjg==
X-CSE-MsgGUID: cmWE1Cu/QFC9mY2Pd6VStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286997"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: Require HT support for NAN
Date: Wed, 27 May 2026 23:05:12 +0300
Message-Id: <20260527230313.6274b222e849.If215f00f0cdb5eefb2507f8d0fb5734a65ce945f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37040-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9E4445E9EA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ilan Peer <ilan.peer@intel.com>

NAN cannot be supported if HT is not supported, so check that
HT is supported before declaring that NAN is supported.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/nan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index d34a9a2cbeae..dbe7a54a38b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -25,7 +25,8 @@ bool iwl_mld_nan_supported(struct iwl_mld *mld)
 	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(MAC_CONF_GROUP, NAN_PEER_CMD), 0) >= 1 &&
 	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(MAC_CONF_GROUP, STA_CONFIG_CMD), 0) >= 3 &&
 	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(MAC_CONF_GROUP, MAC_CONFIG_CMD), 0) >= 4 &&
-	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD), 0) >= 6)
+	    iwl_fw_lookup_cmd_ver(fw, WIDE_ID(DATA_PATH_GROUP, TLC_MNG_CONFIG_CMD), 0) >= 6 &&
+		mld->nvm_data->nan_phy_capa.ht.ht_supported)
 		return true;
 	return false;
 }
-- 
2.34.1


