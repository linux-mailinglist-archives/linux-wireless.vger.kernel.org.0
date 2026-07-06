Return-Path: <linux-wireless+bounces-38705-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h+0KG6cLTGpcfQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38705-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 22:10:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED3715509
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 22:10:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=cqMiRWq2;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38705-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38705-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90423290E25
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2653830C163;
	Mon,  6 Jul 2026 19:00:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054492EEE93
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 19:00:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364432; cv=none; b=K6lcj1IOswJhHKbqi13+ATYb+ZOBGt2dVpeGdnxHjTZguqSgAXNDnOiPLHYRQ0H4ZxEDn1LwX5BOLCJUAnYWEcz3lvCaEOmiZ1tRseO++Ot/UYAsl+AUNlJD/1Ysgk5duQCFdb2W74+phiz2VlRTEsnbItxRDhSsqOWnX6KoURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364432; c=relaxed/simple;
	bh=X4/h8GBbG2fpHq/yfHygZ2of0m3xFkwHFcyYsef0dpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZTWu2B1Bn5qlNhSdimCa4LlwIIlHIv3Teus1uzcehxBvfnFkh07HQzBOuhsVBt7qY4Y5IUv2/YsLApsbXwUkaQKwk9dIj+mC7jzf3MOy7NkbU3R1w93oE7s18GIqx5VilJ1foPLyA9Al0kkP7I2RmRVuWIDDYicG9l/VhhJ0chc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqMiRWq2; arc=none smtp.client-ip=192.198.163.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783364427; x=1814900427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X4/h8GBbG2fpHq/yfHygZ2of0m3xFkwHFcyYsef0dpg=;
  b=cqMiRWq2//Hva/WXoVqwFPLFsJzk9qtmtMFCYPUuDyqggow2ZYlZzdQs
   ezvzs9cZxASaY0DGkaMtYNH5Lmt26SKBPDPhYzr3K0naoFXqPepB4UegC
   SJ1M9hsoLfoGLXIo+bm/rj+WiUYrEB5DZW1y9RRuFnZdTzXXxjC8Trcwo
   Rf2LaSj5IrYrLyPj7DDL0e1B/tzVGH23pRwZXOe07XC/qdy/GmYWpV92o
   YJ7NSPis2vlOfwicdrMIkLjYJxrSzx3cPdYTVHOjLXHY0kmRm/kk6THb2
   Hj+ZD2nVEZrsuhm/NiAMM4oeCIMD/WH8fN5MoxHM22zdrV018BVdT8Zsm
   w==;
X-CSE-ConnectionGUID: X6czRkT4QUmqWPI7NsW4oQ==
X-CSE-MsgGUID: yCnaL6fTTByMiz6ZtGgFhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="82985424"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="82985424"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 12:00:26 -0700
X-CSE-ConnectionGUID: cOTfDHpXQAC+xLpi2i7q/A==
X-CSE-MsgGUID: Z8cYv2eNSHqUMmB49NUEEw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 12:00:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Shahar Tzarfati <shahar.tzarfati@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: recalculate rx_nss on IBSS peer capability update
Date: Mon,  6 Jul 2026 22:00:02 +0300
Message-Id: <20260706215954.422adfd57b71.I5a47f65c5e38a221712f5203e5c8040304b382b5@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38705-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:shahar.tzarfati@intel.com,m:johannes.berg@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDED3715509

From: Shahar Tzarfati <shahar.tzarfati@intel.com>

When IBSS peer capabilities change, rates_updated is set to true in
ieee80211_update_sta_info(), but rx_nss is never recalculated.
For peers with HT/VHT, this leaves rx_nss at 0 instead of the
correct value, causing drivers to use incorrect rate scaling
parameters.

The root cause is that the commit below moved NSS initialisation
out of rate_control_rate_init() into explicit call sites, but
missing the rates_updated path in ieee80211_update_sta_info().

Fix this by calling ieee80211_sta_init_nss_bw_capa() before
rate_control_rate_init() when peer capabilities are updated,
consistent with the other IBSS call sites added by that commit.

Fixes: e5ad38a9b261 ("wifi: mac80211: clean up STA NSS handling")
Signed-off-by: Shahar Tzarfati <shahar.tzarfati@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ibss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index d0fd6054f182..1e5414ee27c0 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1029,8 +1029,8 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 		u32 changed = IEEE80211_RC_SUPP_RATES_CHANGED;
 		u8 rx_nss = sta->sta.deflink.rx_nss;
 
-		/* Force rx_nss recalculation */
-		sta->sta.deflink.rx_nss = 0;
+		ieee80211_sta_init_nss_bw_capa(&sta->deflink,
+					       &sdata->deflink.conf->chanreq.oper);
 		rate_control_rate_init(&sta->deflink);
 		if (sta->sta.deflink.rx_nss != rx_nss)
 			changed |= IEEE80211_RC_NSS_CHANGED;
-- 
2.34.1


