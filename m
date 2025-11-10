Return-Path: <linux-wireless+bounces-28754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C8C46421
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC04189852B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754830BBBF;
	Mon, 10 Nov 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJQ1xHHV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35E3074A6
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774027; cv=none; b=foYZRK6wT6KaAqOoL/DXfVZ+q6eoHk60Iel7kG8XE279JCQN/X2fnZVg0+PVIlVHhaQNPiBM+nQFgb0iYxt0YPkQ83kfhStPDh7HfNjyz0KX3xFGMMhyREC68tPo9V68WKUHvAanq8WIQL3sR8KE6xVsYQvx6ty909yEGCH0QMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774027; c=relaxed/simple;
	bh=wWxnX5MR9xXeY1uHZxdd1DRMKCZFBzMJal93C5rWwso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpsCwM9XUQyWf209JLx3CV589DZgQC6xui1QF70LRXRDcE1ZGL/XxIwA/QcST59kjhdQ6VY1O/C0TZZgCfkblhlXrWBgK0bbUoLmbn+a/TWdc8mhXsFk146yuhetL1Y8xRNo0d/wWhqiz64FOfdDG1sx6JtWTqtMfqezTqMiDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJQ1xHHV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774026; x=1794310026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wWxnX5MR9xXeY1uHZxdd1DRMKCZFBzMJal93C5rWwso=;
  b=OJQ1xHHVGnX/u2oMCsbrdCYYq1sv0rzn2P75+m4QMBWhBw3hjuoPyO3h
   l9W/mTYBK19fcIyXaVwLq1WOYEfu86+F+rDoEXL/U2MwE89rfP8jtI+/v
   6BxhAidS8tJvlSIoyoB/Aypji3Cf883tNr2+x288a+cnDy/oXNoCR7HQL
   +X5todFUePQyEV2VK1BJKPYcZUPD/Iuh57KGwy6PF56fa2dXGYddt8lKG
   KCje/5ccW8Dk/iYqQWwH1aFVk3r7+kJkofHMzeHMr1/0YB4dMDWgFOYpc
   l/rvQ/kCzC+bC/v4gBysS0x3+XeCyorrtsroi7mU/YV1D677HrTbHgP7U
   A==;
X-CSE-ConnectionGUID: QELvCiLZQ4Cd5vnvFXfedQ==
X-CSE-MsgGUID: TsyEmMQ7Tgi3gpbxc1UsLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64856421"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64856421"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:27:03 -0800
X-CSE-ConnectionGUID: 5M+zKjbsTcCe/Ne7i85Veg==
X-CSE-MsgGUID: 7fXPNYe7TDKDdyKXQq0hUQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:27:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 6/6] wifi: iwlwifi: mld: Advertise support for multicast RX registration
Date: Mon, 10 Nov 2025 13:26:48 +0200
Message-Id: <20251110132506.cc5c664bc8b8.If6f423bcf0a426e662041a4b310ce81485f1af03@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
References: <20251110112648.4149049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

While this is not needed for configuring Rx filters, without setting
it some multicast action frame registrations from user space would
fail, specifically, NAN multicast action frame registration (SDFs).

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 05ab6246eb17..8466345d7f21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -377,6 +377,8 @@ static void iwl_mac_hw_set_wiphy(struct iwl_mld *mld)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_MAX_CHANNEL_TIME);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_OCE_PROBE_REQ_HIGH_TX_RATE);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MU_MIMO_AIR_SNIFFER);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT);
 
 	if (fw_has_capa(ucode_capa, IWL_UCODE_TLV_CAPA_PROTECTED_TWT))
-- 
2.34.1


