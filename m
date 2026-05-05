Return-Path: <linux-wireless+bounces-35935-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ilqnLDge+mmzJwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35935-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A774D1874
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B1093022065
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A3494A15;
	Tue,  5 May 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLah5lQA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610DA4949F9
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999368; cv=none; b=HQmMC0EMBZJDsfVcqe2xNE57b40OC7vWWXhK24M0Oa2GChG2nXpQOQA+h8hu6YG0DoenPW6jDnFSedXpscPcnzbnB6kcz2m0X4W8TxkvNO5Ma+Rj3ddsojU5iwJ9Mk6ZRPKPCPj2IqtZJsrL9bXu7sKWNArG/77L07NLLVegThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999368; c=relaxed/simple;
	bh=Djzq5u8Ia5TC/2Cz//2uVhLfoplFE4kTTdjIf4bYI2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdInOBkKFSFB2JODnQMAVm3myAQJutRTNmayxAonEEMTWzdaDwY85+ibBos14Tcu60PoLqzIFR9Qk6xcQTyAtyckSs9uVqR2NiJmnxW26INge3Pe0oTGNfbItk/u+fW8JoR3o0DzcMqfcRjLMfWebJ8sRpsyD04zyQE36qkN47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLah5lQA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999366; x=1809535366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Djzq5u8Ia5TC/2Cz//2uVhLfoplFE4kTTdjIf4bYI2o=;
  b=LLah5lQACFnpuxB7LslxFNOy9WRQ7PXpYlMMxlO4Lbwt9haU+19/BELs
   T9+A1XqIPNcQd98xK/7uUABPz+7nXGrXiAyS+rA6vK2ySfeCDxTuVWOoD
   CRij6slwh86ThNti5FdKMo4cj/iCRJxuGNHi6DekSEnCLOE542eVavqXi
   /PNojA9Mts87ULgEqXRiAsTmOkI0l5WrrAghXbU049Puttp2EJe8dniAU
   LZwKWRIEzXopZC6mcjTU+Yg8xIudN6hwDPSyiHr0htL/TUM3NL/ldNWnN
   vXI7tNBCokxKNggohKDkU8MyF9UJ07WBQ9HOQREFj97RjAkLZIxvKcFSX
   g==;
X-CSE-ConnectionGUID: f3QEViuZT/ytnS0SPfzflQ==
X-CSE-MsgGUID: lVlwBKpOTCWr92bjmOfqtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898986"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898986"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:46 -0700
X-CSE-ConnectionGUID: Vc2GutLbSueW7aWLWCP49Q==
X-CSE-MsgGUID: qanTFQPBQVOvU64IJJT9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206417"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 11/14] wifi: mac80211_hwsim: Declare support for secure NAN
Date: Tue,  5 May 2026 19:42:16 +0300
Message-Id: <20260505194007.86b40fec2340.I6993cc70c43579694ffd429f1afb971a73db2ae4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
References: <20260505164219.2806117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56A774D1874
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35935-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Daniel Gabay <daniel.gabay@intel.com>

Advertise NL80211_EXT_FEATURE_SECURE_NAN to indicate support for
NAN Pairing, enabling peer authentication and secure data path
establishment.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 66cc8c528c6b..2b228ae3029a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -5718,6 +5718,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			NAN_DEV_CAPA_EXT_KEY_ID_SUPPORTED |
 			NAN_DEV_CAPA_NDPE_SUPPORTED;
 
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_SECURE_NAN);
+
 		hrtimer_setup(&data->nan.slot_timer,
 			      mac80211_hwsim_nan_slot_timer,
 			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS_SOFT);
-- 
2.34.1


