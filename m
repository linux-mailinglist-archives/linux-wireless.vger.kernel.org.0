Return-Path: <linux-wireless+bounces-33583-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAmVEXMDvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33583-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:21:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3D42D7206
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E64E03014693
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9A36EAB7;
	Fri, 20 Mar 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/OvAnJi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6172DC769
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994853; cv=none; b=qaOA010RDdNizIPmfm/Oyz6dLYhAlIw7a+tm7owZJSWNSOYGgLH0aNnIIyR9xcD4UfMB0ywor0DhawF8sFouGd7On97w0j9caxBxLT3cBnm/Msq6zN6jXJAmabOcZOlzRpQ7SY45668FzrRAD+Hjn9phAdlwVhJvzG1gjmIdW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994853; c=relaxed/simple;
	bh=SM3FswrKtLYi4uqAlCbF0m8vBWwOlO38PIskXHEK7oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LC6vqArxPQwZMF2Ks3DbwBzb1Zaqug/Qul1F0sMAHk67QFFOh5OLBLoxmH5udYJKMDwEL02R6JLus0qzuG+RwgnLaf23j1gOZJ6RPAAlNjpLEa5fNwAEKzOsMRrTgoEm82EFFHFYvi/oyCXH6JvHRXicc8ZWeSwXwrQ8rrthJBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/OvAnJi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994853; x=1805530853;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SM3FswrKtLYi4uqAlCbF0m8vBWwOlO38PIskXHEK7oQ=;
  b=G/OvAnJiGcu3N5p49sacztBkkQv9hotK28GyM5jE6oEEdUh0yL7OxWPZ
   dMSV+s+XEqlbUvzL4U/FTrSGap2JcSWvYXvv1SFWdd1BX1rRQFFNdb8D5
   dj9jCtqLyRZV/T4305mr30zuo6ZD89rF8dI4ZFP4iM1nEMJ+qDmW0r7Lt
   ZAepVav8T16vS6dx0rqsBcr8Ay5afYpuYZQRbeO9UfDJtwtRAisz1PpTV
   trIZY3oZhCH1elP3Zo2e5t4xJCeNwuLjXRVc2O7EJyeT1ag/VMCnelQM5
   7CfmrP4L7cg2bdspX5Isy69DeMMIODbK4/tBqbENRuHRqw41LNlTvd930
   A==;
X-CSE-ConnectionGUID: upIE3nyZQV22+TNd6PDyDQ==
X-CSE-MsgGUID: ZkWxuTAfRra5pF5Zdimmog==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74958892"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74958892"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:20:52 -0700
X-CSE-ConnectionGUID: D25uqr6eSpmWxP8/1tCNBw==
X-CSE-MsgGUID: Gn4vJ1nqS3KhpLFzhSUcrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="217134912"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:20:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: support UNII-9 channels in ieee80211_channel_to_freq_khz
Date: Fri, 20 Mar 2026 10:20:40 +0200
Message-Id: <20260320102034.efcb7ea1de3c.Ifa4b75a24466de2a1d5707181c9c487618236e4b@changeid>
X-Mailer: git-send-email 2.34.1
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33583-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: AD3D42D7206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Devices that support UNII-9 will call ieee80211_channel_to_freq_khz
with a channel number that can go up to 253.
Allow the new channel numbers in ieee80211_channel_to_freq_khz.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 0a0cea018fc5..1a861a6ea380 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -90,7 +90,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 		/* see 802.11ax D6.1 27.3.23.2 */
 		if (chan == 2)
 			return MHZ_TO_KHZ(5935);
-		if (chan <= 233)
+		if (chan <= 253)
 			return MHZ_TO_KHZ(5950 + chan * 5);
 		break;
 	case NL80211_BAND_60GHZ:
-- 
2.34.1


