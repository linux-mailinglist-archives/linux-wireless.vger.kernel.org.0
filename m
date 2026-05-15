Return-Path: <linux-wireless+bounces-36462-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKd8FqgGB2p+qwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36462-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:42:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D154EA5A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D64CF313E50D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC91A4F3C;
	Fri, 15 May 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+q2eBMP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4947A0C7
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843732; cv=none; b=JLg0rHV/AzGLX/Apm+60fJszTa09jdldMqokYGOiDJtP88LLbkvqAolUGJRwC1JVweil7NpNdaDlA622AJ28XnRmhXZDsC+zz87e3Sp1+wDQc7VM0rIemU9POhVNzYomlV+zSj0hXtQqpA5W7ig+F4Q8Nw+D2caNWhy9pFjD1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843732; c=relaxed/simple;
	bh=wgl3D2ZhsYpbgMgKn9QJIJ3vT/u2hJLifclMt5mD+c0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HW0H6wSZt1k6M4z/mfBczPRnhXgk7ApNTNWDTdOJvbjIRr9Fvc8kgDHKIBGCyzVpYsP7ZFw3564h7YLEH1UorLtRMmPnIIRnIpPN4qLqVsaY8m8O9eh4U0YlOpOydGdMeH47Xz9k9594zQvnp1eu1AhnfZQgKMRUWxBEdvptAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+q2eBMP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778843731; x=1810379731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wgl3D2ZhsYpbgMgKn9QJIJ3vT/u2hJLifclMt5mD+c0=;
  b=M+q2eBMPKhVGi7vHN8FW4MJqn8rG3BULB5l69PVOfDya6PvwzJICzQd5
   tFyzDIWpvJnsgaCdsTOhnkr2ObOjtOA3u3d3n5Zt8b/ffriRM1SfmuFHc
   sCJtdfL61bh/b5bmOJ060GgcoagB+3dmnDhqyMr+YQUwzknZrG+sLU37b
   T3A8F5whA8s6Ot9TDb9anuw/nY10gb7sBXErtdcs9gJm4EG9Opn5F8YYW
   WHhX+jyB2VO1ziv3dmwS9lqLfxvR5Ati7BNg9xAbD+O4Dw8t1MugwmCYr
   DclGxks5F3piHnGBqZRFr8bnP/fLKmRGUOsfnt18XUdLVfE882LW8C9Y7
   Q==;
X-CSE-ConnectionGUID: vAkavoYqR9WzxMExLYFeww==
X-CSE-MsgGUID: JtOYVm75TYCTz06Z8oqAvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90901446"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90901446"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:15:31 -0700
X-CSE-ConnectionGUID: WwuLIoq+RTSnahTpRNP/5Q==
X-CSE-MsgGUID: XcG9zU8bS42w9VpmWRIAOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262187832"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:15:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: Do not declare NAN support for Extended Key ID
Date: Fri, 15 May 2026 14:15:16 +0300
Message-Id: <20260515141442.365ca3ab29f9.Ib435168dcc1d7d8719a5612109035ca1950967ed@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E48D154EA5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36462-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

Do not declare support for Extended Key ID for NAN, as defined in
section 7.4 in the WiFi Aware specification v4.0 (in order to support
security association upgrade).

Fixes: eaa7ce66c3e2 ("wifi: mac80211_hwsim: Fix possible NULL dereference")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index dc9775cd9f54..d23b50b1ce86 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5714,8 +5714,6 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 
 		hw->wiphy->nan_capa.n_antennas = 0x22;
 		hw->wiphy->nan_capa.max_channel_switch_time = 0;
-		hw->wiphy->nan_capa.dev_capabilities =
-			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED;
 
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_SECURE_NAN);
-- 
2.34.1


