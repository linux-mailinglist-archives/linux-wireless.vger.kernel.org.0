Return-Path: <linux-wireless+bounces-36157-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ex5HjrRAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36157-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACE0505BDD
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDECD30055C4
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDB7313E00;
	Sun, 10 May 2026 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1AneaKL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF593128DF
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438407; cv=none; b=mx1S8gC8ItpZKw1b6awxoEIegEQ/z2iW5Ge4GzIX6ayjyS1+q48ScPBxQRvZ4qS8Yh8AovyEJc509dgkGYbgEGK9prrIRmoghVUoeCaQeKG3PVR43oKo0t83WqKnjDJ91SRIxdK6PsjZu/anmOdvRjMRbObT4I/LXx+DU2sxXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438407; c=relaxed/simple;
	bh=Gxr3JHMFbsZEodr4PHqAzE+WFvJ6BHvBOnGoX6P6urY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnLv2mJK8Z4yqLswS7dBS4LpxZl8d/B834hXgKSmWOd2hzDTf9eKpD13/xr32m4Tq8A7nOycOU0diRGFm2e7Z2pw8mMilsO6dLP4DHJbX7pFVF7emciQOSx0D6KzZhM9MtUOqQlwXK8wLEyESN7Qq+ODtAlvNNcUX/FSDtIw8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1AneaKL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438407; x=1809974407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gxr3JHMFbsZEodr4PHqAzE+WFvJ6BHvBOnGoX6P6urY=;
  b=E1AneaKLXpUpjKs/t4Q1im6VqecANkTr7DJrokamnjAYdmORGs4zpaDD
   r9u2AiXFoy4pm4+GbwHPx9Z5tVa3p1Jp1ONxPRqdhcUl3DVH+344seARF
   R/i2fWiWFkzNIqW2XzMGB0l87mCsmof3ioMhEZA/L6/UePVX80uRpg43V
   DLGLz0T9jG8XiWDOTxytqBCqFxufGmTeBsqxXQ/0P1nQfR9zUOR1IC2ET
   r3HHR+PN09Y8pUa9UgCeEgPZk4cQLxux2e6Upj/tyAZetvTPYhATeir9F
   jHtYVHUXyLhuDsNFLATUvNfJqy/ZBo5HhOY3u1qFOBDbRMifxChBGOg5k
   Q==;
X-CSE-ConnectionGUID: x6YLl52HR/WGe5wyOeH22g==
X-CSE-MsgGUID: Q7PPKC4BSsap825OCspHPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208985"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208985"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:07 -0700
X-CSE-ConnectionGUID: Wz9FOL/nTmSml2T8e5QRKA==
X-CSE-MsgGUID: vIXswtIJRyOIm9uKKA4GhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626837"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: mld: Do not declare support for NDPE
Date: Sun, 10 May 2026 21:39:35 +0300
Message-Id: <20260510213745.29df303b4ae1.I160f1232e51711d5e2c063f0e1539ef71db50e1e@changeid>
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
X-Rspamd-Queue-Id: 7ACE0505BDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36157-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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


