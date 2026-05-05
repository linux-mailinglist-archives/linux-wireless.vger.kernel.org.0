Return-Path: <linux-wireless+bounces-35937-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E4tNr4e+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35937-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7334D1954
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A98D309F3C8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CB8494A18;
	Tue,  5 May 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVgE3c1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A7494A1F
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999370; cv=none; b=dF5mipLQLqPhs4tTkCwnCTiMurtEcJBcJitn+vceF3D7ir40vVTFarohXfHlC0HFUknI33IPWNu+EERv6h75cSATvY2Mjda/JAloZppQLoRMbt+K5KxO68EWuvEu1X7Mb6tk7+BD4b2Ktohhz7yeuFzbs1IMsjytU/lsW5NzZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999370; c=relaxed/simple;
	bh=tEuhaiP6evrf/CT+9To4WanyDgJ61jHZze8HD3kt4jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srFXnw5GjrkSlWnHYj044ah/x/XBU8dYGFEYyUGN3Ov1Xrx11nmxWB1rJ+qj6qoZWhwCy/mA28zRXGC9sREFf03745oJSS4TFjRjS3gMn30NQeHO9ndbcfr70YW5ydU5QHT0AzcHXKqe42W1fdFvDaP5Xln/QKU8Pp/XNCOY/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVgE3c1F; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999368; x=1809535368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tEuhaiP6evrf/CT+9To4WanyDgJ61jHZze8HD3kt4jw=;
  b=KVgE3c1F6oUt40hz5N7WxrE4bVcmYGFbdY+Aj1xCo3N6UbhpE4XizkC2
   zMCX/kh/p/px6qJt7Kbf8bvdDAJ3lLfKZKubhxl7dKh5prmIitV3/GL8N
   44XKp+O6WaEXo28vVzhi/7iWJs1v9qJQNoptRqWp+UX6JgokyiNKKiwUX
   vg16D+ScMa+0fKjcF2oYPo3crY0yeZf3sb/igYNCNehSeT8B2vMtlYtfz
   jF8gSa6kt1eYua5ksfHUtm1d6XgE27HBbVqNkhXglXedNLZENZq6bSD/l
   xoAPlg3cOKXQDhFDRTckm/CxIxFJzvUdpChWqzpFCD+8t+O88WCfXgY5M
   A==;
X-CSE-ConnectionGUID: 6k15nXFiR9mW3J5ko0ob4g==
X-CSE-MsgGUID: QSfwQ6UMRmKGTwyNxHWNTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898988"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898988"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:48 -0700
X-CSE-ConnectionGUID: v3xjXycKRUSCyLe3Z0nd2Q==
X-CSE-MsgGUID: lEicDQGAQ1KLkzHWn39tSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206434"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 13/14] wifi: mac80211_hwsim: Do not declare support for NDPE
Date: Tue,  5 May 2026 19:42:18 +0300
Message-Id: <20260505194007.4f633238ee9a.I9796410c0376f50a07259cc611428d76c51f180a@changeid>
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
X-Rspamd-Queue-Id: 9D7334D1954
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-35937-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


