Return-Path: <linux-wireless+bounces-35936-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM9qBbse+mkJJgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35936-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F94D194B
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 18:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A7CE309D256
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6E4949F9;
	Tue,  5 May 2026 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnk16V9K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64B49219A
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999369; cv=none; b=GkzIBFQwOKyfiRm2y2CSRRnsJs4V2ecyRvNRqH7deiUl+3tKn1KHfW0P/Fyg/AufmlkSx7XvWVDmL+Hppj7XUTJvn/tiywhzyiTcR4r+bbyNujDk7PYWUTiMYm4XP2Ef6g/7tUZeHwUBJHc9TGmwYZAB4AL1ddh4Qzkv0kOP1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999369; c=relaxed/simple;
	bh=Tr/Bsjw6MLJDGuXQvBc/wnsfzNApCDid7MPEKTS378Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvyOhutO47tE2nKRPTY8fBSn92zv4wp31jck9++SQeraotZxnOzZVxvrxB/iAkqWkKWOwT8VyuKNEmm8uZM41zM1HBZa4MESfoJ3uefix+GihAp1dmIQ49f7YXYPXBFoztBqYeZRR4uuPfO3ESeITjQYMLyalhikSCsUxHD9k4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnk16V9K; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777999368; x=1809535368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tr/Bsjw6MLJDGuXQvBc/wnsfzNApCDid7MPEKTS378Y=;
  b=jnk16V9K7Ha2tqKiP0fwOSG5j13XTUOf4mfiTTl5CxG+zaY3C+vlXyiH
   4SHgG5vP1QYdZdROYCqLaODEgXuTimvIWJ/eQtADr4k8YI37o1p2XekAe
   yRtttO5Mf9+TOIeLBDNw1t0VN8CNVd9pxad4v2+ZBLsNgcUPvxll5R3Ix
   7RKHZbmbtyYJOpaa+E4qrALcHTvpHZz0inxWEO5YQVI7rdiGsp3s8Kboq
   D4I/K9Z0XZZcMUJtvydP9KuVP0CdZzX+t3ZcGxvWS1omcsCct4WT/DtaT
   z0JpqHUjmc63l7gfh3L4jnnl1UgakR4gmyyhzYze+D9mtHB9XpqRGa+IB
   g==;
X-CSE-ConnectionGUID: iwqtJAFsQwGDqgdKZy6N0A==
X-CSE-MsgGUID: JOjOgzAIT/eFprx4ESc7pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="77898987"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="77898987"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:47 -0700
X-CSE-ConnectionGUID: oRfHO9HpRCiOpeRekcpLEQ==
X-CSE-MsgGUID: +ZpNERfWQvmjs3jhr1leBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259206424"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 09:42:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH wireless-next 12/14] wifi: mac80211_hwsim: enable NAN_DATA interface simulation support
Date: Tue,  5 May 2026 19:42:17 +0300
Message-Id: <20260505194007.5b2c933d932c.I450087714bd55189242ab6a72ce6650be36edbcb@changeid>
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
X-Rspamd-Queue-Id: 7E2F94D194B
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
	TAGGED_FROM(0.00)[bounces-35936-lists,linux-wireless=lfdr.de];
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

From: Daniel Gabay <daniel.gabay@intel.com>

Enable NAN_DATA interface simulation support by adding it to the
supported interface types. This completes the NAN Data Path
simulation introduced in the previous patches.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 2b228ae3029a..bf45d48a3fe0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -6765,12 +6765,9 @@ static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 		param.p2p_device = true;
 	}
 
-	/* ensure both flag and iftype support is honored */
-	if (param.nan_device ||
-	    param.iftypes & BIT(NL80211_IFTYPE_NAN)) {
-		param.iftypes |= BIT(NL80211_IFTYPE_NAN);
-		param.nan_device = true;
-	}
+	if (param.nan_device)
+		param.iftypes |= BIT(NL80211_IFTYPE_NAN) |
+				 BIT(NL80211_IFTYPE_NAN_DATA);
 
 	if (info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]) {
 		u32 len = nla_len(info->attrs[HWSIM_ATTR_CIPHER_SUPPORT]);
-- 
2.34.1


