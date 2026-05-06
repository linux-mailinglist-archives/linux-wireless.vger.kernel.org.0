Return-Path: <linux-wireless+bounces-35979-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCoxLkG5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35979-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC614D5F77
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A12B3020C06
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620A2E7F2C;
	Wed,  6 May 2026 03:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TikErG4r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E852820A9
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039104; cv=none; b=g22XQmnrdSF5Yh/HHecVzjuOV88sJMkTSS5TEgdV6LSwTd/3joZMQ+ygAG8pw2qGc2Xr7gj7LVy+J9E+KKZEP4ILWTB4oyRxSelFNaMxPMx4f3ZnV2DnV5c9bPnieDwHwOjG6MnZB1JqArpEQWbrVDspacioWLMaJoyrZSOPb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039104; c=relaxed/simple;
	bh=tEuhaiP6evrf/CT+9To4WanyDgJ61jHZze8HD3kt4jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qlTpYT64Gz/7DBgQw8LNAm8Kaj4hwm12WCMMbGFDBQxFb8t/Sg/5FpiCgUA1K0N7Rxz5ikP+a00KixmlB5fWggChP60h6SB4M4x6Acf/081U2omqUYW1JwdTGgAKdd7QNTZuLSjc7RdrahirTz+qPRcnDZxg8ZBplyD85K1/5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TikErG4r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039103; x=1809575103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tEuhaiP6evrf/CT+9To4WanyDgJ61jHZze8HD3kt4jw=;
  b=TikErG4rGYHPrgoOdThiTLngvvfUnCmkQgq8ZD3Efs1MD3Z8XoE47chu
   /5yoWTSfSGpgaOGThoW+wCsXTOvHjPM0gunrwip/qIuQzShkOyXNhDAZW
   ubC4oVaRU+K5Eh2oydbka/4wMwTezxUgBVrNL56AIcxvA4FfrbQnN3U8n
   JklTiDXL09yKc3jfOKc3e3ptky6/XXGp5hgY8TCAhbngtmOp/3JSd4j53
   K6qsyZSyqaLXJfroP77DhRcKLuvOUHbRvgSpMnr0gAE4i8URVly+z9557
   mYzJLZU/d/WbylFGUGUEEcfqLoCzj/i3Wbc78MRG7lG8SGVaz06G/JPzO
   A==;
X-CSE-ConnectionGUID: Ot8jc1rQQk2/JzzUDg3q+Q==
X-CSE-MsgGUID: g6vjL+wmTrmbAIyvmi3khw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791306"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791306"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:45:03 -0700
X-CSE-ConnectionGUID: KSt2+uUsQ6enxE3YzFBBnA==
X-CSE-MsgGUID: zV7Fx64DQy20a/xGNj+w2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777890"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:45:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless-next 13/14] wifi: mac80211_hwsim: Do not declare support for NDPE
Date: Wed,  6 May 2026 06:44:32 +0300
Message-Id: <20260506064301.711c61538c8a.I9796410c0376f50a07259cc611428d76c51f180a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
References: <20260506034433.3328362-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FC614D5F77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35979-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Ilan Peer <ilan.peer@intel.com>

Do not declare support for NAN Data Path Extension attribute
as this is handled by user space and should be set by it.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index bf45d48a3fe0..a214a3a18841 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5715,8 +5715,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		hw->wiphy->nan_capa.n_antennas = 0x22;
 		hw->wiphy->nan_capa.max_channel_switch_time = 0;
 		hw->wiphy->nan_capa.dev_capabilities =
-			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
-			NAN_DEV_CAPA_NDPE_SUPPORTED;
+			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED;
 
 		wiphy_ext_feature_set(hw->wiphy,
 				      NL80211_EXT_FEATURE_SECURE_NAN);
-- 
2.34.1


