Return-Path: <linux-wireless+bounces-36463-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGFuDncMB2oLrAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36463-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:07:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28754F144
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA90F3222A33
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08D436346;
	Fri, 15 May 2026 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNg+SmKT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC738425D
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844503; cv=none; b=KFduLMG48/a3V8a9q8WcWDeskuoEaeU2F8dvApbckNIXurU2+cnUwbW1ofGH1NZwwOVP7poClIPTK5qVprsCynSreuJOujYH0vrnzi6Z5UKwTHzDCsUZgUkBBuCRKthx6X2qce13iQaASYW4yTG7yjmdJt3s4YACDtgJTo9B2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844503; c=relaxed/simple;
	bh=1jyHj16GQck6/P85Sk8E38gjHLJVnFTSFrWlMKs+yDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K59mCsLNzvXGC5qnnMwW9D09/J6QaB5rZYOHPnJ5Ss5IixP3Db7jcxpEVTnzbEU0cA4meGMNxlViNDnhK6FOX01uMNIoSjnZIe5Kw1YNwgSu6HWKnchg/4imczXIlZaJJPDO/vpS4oFxp7gVSbl/jsUNgQ5sV1MKqHE+njyEXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNg+SmKT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778844502; x=1810380502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1jyHj16GQck6/P85Sk8E38gjHLJVnFTSFrWlMKs+yDw=;
  b=PNg+SmKT1IPZeIXa2W+GEINQOO6SbJs4YdNJIWUQ5L7ez3tLQYK4x667
   NnfbPK5dbFlsBcW/BKd0QBrZmzsEmXNRoppVPnN9PBIrYPuYeEia5dQjv
   z25Zzu29QscOibphwaAv2jSLGMZmvCovubHsILuWdYBhDdiJGqfixhXlk
   /3qIrVH/EIvOQqYvsqU+SPvuf3ZL3qFDH23kgGJtWDdcA5k18MW7kTRMG
   f8q37dRTZefQ5asx0tIza+6pwZ1be6uNHFLoAdoWPcGhlWb1S5SVbbSUW
   kQ9HhID1SvlZlN1W3JGRogrbfsZ/Fz6VzLT70mkAwSWfXVslC2mSa8iz9
   A==;
X-CSE-ConnectionGUID: Y0EtEaW1QxixkCw7Wq8OOw==
X-CSE-MsgGUID: vyoerM+sTda25y9/gBpWGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90902493"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90902493"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:28:22 -0700
X-CSE-ConnectionGUID: 4u/MEO1jTuy6bVKc4ZRPRA==
X-CSE-MsgGUID: eujwTsK6RhqA8IS0efVH1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262190550"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:28:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: allow cipher change on NAN_DATA interfaces
Date: Fri, 15 May 2026 14:28:06 +0300
Message-Id: <20260515142736.3188a47a23bf.I5fba3a111ffe054b46928aefa5c2d763fef51d4d@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D28754F144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36463-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Daniel Gabay <daniel.gabay@intel.com>

ieee80211_key_link() rejects pairwise key installation when the
cipher differs from the existing PTK. Per Wi-Fi Aware version 4.0
section 7.4, the ND-TKSA between the same NDI pair shall be updated
when a new NDP requires a stronger cipher suite.

Exempt NL80211_IFTYPE_NAN_DATA from the same-cipher enforcement so
the PTK can be replaced with a different cipher.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/key.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 4b8965633df3..11c666bbbdb2 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -867,11 +867,16 @@ int ieee80211_key_link(struct ieee80211_key *key,
 		alt_key = wiphy_dereference(sdata->local->hw.wiphy,
 					    sta->ptk[idx ^ 1]);
 
-		/* The rekey code assumes that the old and new key are using
+		/*
+		 * The rekey code assumes that the old and new key are using
 		 * the same cipher. Enforce the assumption for pairwise keys.
+		 * NAN Data interfaces are exempt: Wi-Fi Aware v4.0 section 7.4
+		 * requires upgrading the ND-TKSA when a new NDP negotiates a
+		 * stronger cipher suite.
 		 */
-		if ((alt_key && alt_key->conf.cipher != key->conf.cipher) ||
-		    (old_key && old_key->conf.cipher != key->conf.cipher)) {
+		if (sdata->vif.type != NL80211_IFTYPE_NAN_DATA &&
+		    ((alt_key && alt_key->conf.cipher != key->conf.cipher) ||
+		     (old_key && old_key->conf.cipher != key->conf.cipher))) {
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
-- 
2.34.1


