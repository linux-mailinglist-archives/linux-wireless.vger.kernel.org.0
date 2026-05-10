Return-Path: <linux-wireless+bounces-36174-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCefEXTvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36174-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F25065AA
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 229CB301B4ED
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E833D6ED;
	Sun, 10 May 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QfOmL3No"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA433F58C
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446150; cv=none; b=iruSRC5yBmaQTe2otlmLTjpozD9JVLFisGMuJmVe8hSIkXvL+5Zu6wdrhZpQgjnoqJcuoXFKpAJiEApxe8srkwNu/nnOahF95kadZ3aYetkellwlNEK3FycLnJ+lotIOJyJfoOoRDeIswWu2ydfdVjLVA7flzV9uXP9Qf0sDXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446150; c=relaxed/simple;
	bh=Gxr3JHMFbsZEodr4PHqAzE+WFvJ6BHvBOnGoX6P6urY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ih6GPNDlZLnPezPKcb1cRZdCvKY00zo5Sr0fV9lYjMtNV8/I7zNWWVgRmB5nyccFw0wDErAcJVrCIR1jEIgTuMoGp9Y0iSp8g6pYQG18xV7zcfkyy62wfSq8Vgl/qW1Gad8IrnSg+WgpvBAzrHY7pj05sFNScrSyymQUXo8m5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QfOmL3No; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446149; x=1809982149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gxr3JHMFbsZEodr4PHqAzE+WFvJ6BHvBOnGoX6P6urY=;
  b=QfOmL3No1pZ81iK+J/Qb3LLmaAM0j7lmtxcy+minF6zY4YUfaEgQaJ26
   WDriFAFCEHg5XIm8WUflviOwwKi1gXFU+9DKY2NSaumNnkVxKr1I4XVWC
   bBsv4eaVYqYo82pkwECqKftlZrM19iMD2O05qjQfRHhVolwWu1R/SzuRm
   yHv+zruDc1c6mmV5ORjg58hPlvF3fMz+0ERJsm0ByzDu0RWokcYoopmw7
   +3le0Ut+lg3g0EJcYobMb8Gi/vvYfqtuN6jxAn0ZAwCXfIQBxoRmbLadQ
   A7x/ihqUzKYO55v891Rx4BfadtMQfLZZMk7PPAPBE9L7vgQpZ2huZ48sw
   g==;
X-CSE-ConnectionGUID: EQhOZd4nRjuKV+gTdx3biQ==
X-CSE-MsgGUID: OZn1KHDyTi2yNA3occuUMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904760"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904760"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:09 -0700
X-CSE-ConnectionGUID: OESj7+IMRWemQBuh0GYIxQ==
X-CSE-MsgGUID: xO12NuUyTpaoOxx+7lPx6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095072"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 iwlwifi-next 12/15] wifi: iwlwifi: mld: Do not declare support for NDPE
Date: Sun, 10 May 2026 23:48:37 +0300
Message-Id: <20260510234534.a76eb7235116.I160f1232e51711d5e2c063f0e1539ef71db50e1e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
References: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 093F25065AA
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36174-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

Do not declare support for NAN Data Path Extension attribute
as this is handled by user space and should be set by it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 4ad1d55fd646..d5deb4a7fab4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -300,8 +300,7 @@ static void iwl_mld_hw_set_nan(struct iwl_mld *mld)
 	/* Maximal channel switch time is 4 msec */
 	hw->wiphy->nan_capa.max_channel_switch_time = 4;
 	hw->wiphy->nan_capa.dev_capabilities =
-		NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
-		NAN_DEV_CAPA_NDPE_SUPPORTED;
+		NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED;
 
 	hw->wiphy->nan_capa.phy.ht = mld->nvm_data->nan_phy_capa.ht;
 	hw->wiphy->nan_capa.phy.vht = mld->nvm_data->nan_phy_capa.vht;
-- 
2.34.1


