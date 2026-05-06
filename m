Return-Path: <linux-wireless+bounces-35977-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIxwCXi5+mnASAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35977-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:46:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0CF4D5FC1
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 05:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1DC3062614
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 03:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022A72E424F;
	Wed,  6 May 2026 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fO9QAhrQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698C2820A9
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039101; cv=none; b=aTlfBR+29m+jJ8iuMZLwdUdNUJ7w1uP4fzFYp38DdbAnVBc5j37dA14PktJwi9L/kCnYf5nboRImCFD1sxGNhOSH0rEWXkEKF6h9lC+O9M5YfwGmjfDwK94pbC0wgyEIr8Qor+S1h/JCDXnlHDKQ5hGv0WgdhsWLgczgi1/5q2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039101; c=relaxed/simple;
	bh=Djzq5u8Ia5TC/2Cz//2uVhLfoplFE4kTTdjIf4bYI2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WO6gZJaDZA94iv8HVo+x51uA5/2SJHJx0Y4khB8W5lWsL1P+ZsfOEp3FwNJSIlhsNtty9i71YvWfFo9Z0pfz/6wpywxIGImo0BuBKvDARHdx2d9f0sX6oA0I2zq5pnwyDtUCD4laA7VApHXeMcLnn6doVYszEMp4KMwyckRNUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fO9QAhrQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778039101; x=1809575101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Djzq5u8Ia5TC/2Cz//2uVhLfoplFE4kTTdjIf4bYI2o=;
  b=fO9QAhrQ/f+avCYdBGDAIdCGxMiuhxn1e0x0EKIf10XDWspBVrrx175B
   dpF/apNKpo4Lerg88VcKoypXk9PZzQe6EhWl86JGL/VgeHbk6OGIEoJAw
   YCBvXp2xY8MqnqfH6Lo60jJOEO43Wmk9mNtypGx78mKYKj7dsUi++cMtK
   1wHHWQxgsXkWyaxHHdBZDDpl4+SltwgzC152iYgTmVVmeZRFS6iU/l9Zr
   KAqhaDe6dL31/4drIwhhLN/bIs77aSe1/y5iQGfsbqOLqTAAmnEeHezNc
   V8yAQM19mbhvHNK1bi1f7kHqjiNcBFqoQn9tZeTAUZkCUrvqfxn8eqq+B
   g==;
X-CSE-ConnectionGUID: MI+jjoElQsm+Vcg9tdfFMg==
X-CSE-MsgGUID: C3Wy4qaGR72tQzcJkqABzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82791300"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="82791300"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:45:01 -0700
X-CSE-ConnectionGUID: kUC+esOsSGaBuO0l2/03fQ==
X-CSE-MsgGUID: Pe3AQiYMTyePM/3Cujqghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="237777830"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 20:44:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH v2 wireless-next 11/14] wifi: mac80211_hwsim: Declare support for secure NAN
Date: Wed,  6 May 2026 06:44:30 +0300
Message-Id: <20260506064301.d3bcc26b4525.I6993cc70c43579694ffd429f1afb971a73db2ae4@changeid>
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
X-Rspamd-Queue-Id: BA0CF4D5FC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35977-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


