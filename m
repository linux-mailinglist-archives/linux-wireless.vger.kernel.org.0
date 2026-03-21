Return-Path: <linux-wireless+bounces-33628-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MtbDp3VvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33628-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FC2E689C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28690301497E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8983D33D6FA;
	Sat, 21 Mar 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9vAqkJ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77734334C33
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114177; cv=none; b=m5GKOGlz05fRBfR5U1GE1huL5ZjqzSa01CafnMjqI4eUV5fPdISWUYVl+THOsj+NZMsxcRooZkB3TnXPEcRb0BGWPsiNhisfgC4QJf+2p/28ConlySMh6wB0HprCOcaYx0+pm2dSatus118XvNZo4yyG6InS3WVjfdCXuWSp7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114177; c=relaxed/simple;
	bh=9uTqZqpbkIOuqS5AMty+Y0ZsB4XLBBDuonNOYXE4n2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m85aobbXkE8/3ZemkIlda3vTMpFJuFaOiRjlX1Trumnerz6bKVWhi67eMRogc8f5UgGPITiBC5hLGj6N17WSUqmTquHXEyWiwo0EE3xFZhx0S+iueuAUoFsKPYsNc3wMmhEOxbphow8RyqWoqHqug6I7IOFC1FxpR3CB/S48eOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9vAqkJ0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114175; x=1805650175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9uTqZqpbkIOuqS5AMty+Y0ZsB4XLBBDuonNOYXE4n2Y=;
  b=T9vAqkJ0X1RdzUQ3y5vW1UtqMJV1M0K41gTJBJTmsNRpavEzXNTOqEkJ
   ZB490pEqjuOl3HMVus76znOYEVfGBRKhzqlrzbe7dve/+iPmI84GQu3Yg
   7X1xKUGOx7u3KXq4ibBP+cNvWwCSttFswTytKbz7QmuZZY8IHQqPo9fli
   JeeAz0XQ7h+oDLR8DTv03VLWGFgTwzVWEKmYfThRQyT+XcjFJz+2TvU6n
   kQqfNu83rIHhYBzVp+WrIfdctUiKRbzzxDft7C3kRKyTk5M5uat7pjXZy
   5ROpXB/CWbJOgUgOHO+PXf5g+TgIEWEn9v1Km0uz/X+Ndd4y+M0fXYIty
   A==;
X-CSE-ConnectionGUID: kaQ54SeyRPyVXtd2fOcWwQ==
X-CSE-MsgGUID: ZrtUjWLGRjam6a4RMVDiOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244585"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244585"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:34 -0700
X-CSE-ConnectionGUID: Cd0tbn0sR5+1h9y8qehetA==
X-CSE-MsgGUID: gV5fkL+IRdmIKv8hwe4EHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813563"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: rename iwl_mld_phy_from_mac80211() argument
Date: Sat, 21 Mar 2026 19:29:08 +0200
Message-Id: <20260321192637.b2cf8cfd5902.I9e0006481454445058b96ec3e7ae338e917e2c50@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33628-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 980FC2E689C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Calling the channel context just "channel" is confusing since it's
a different struct, rename it to the more appropriate "chanctx".

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/phy.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.h b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
index 0deaf179f07c..6887f9feaa5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
@@ -32,9 +32,9 @@ struct iwl_mld_phy {
 };
 
 static inline struct iwl_mld_phy *
-iwl_mld_phy_from_mac80211(struct ieee80211_chanctx_conf *channel)
+iwl_mld_phy_from_mac80211(struct ieee80211_chanctx_conf *chanctx)
 {
-	return (void *)channel->drv_priv;
+	return (void *)chanctx->drv_priv;
 }
 
 /* Cleanup function for struct iwl_mld_phy, will be called in restart */
-- 
2.34.1


