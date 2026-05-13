Return-Path: <linux-wireless+bounces-36387-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPk5I32LBGqvLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36387-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 16:32:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D05351D5
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A0D530AFF64
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56641B346;
	Wed, 13 May 2026 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLb2sEdi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C71133D6E1
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682281; cv=none; b=KE9YrDJ+wiJoxBuziCR1GAPeAC6sH2rBFhK7seqga9d4l67b/ZFzP1s3qrRWHuWCWnsU8CbrNu1eqjJBWcsBq9vyNEaRnSia3d7hNlYn9DOSZXcoZKfxF0OPZagI1JnCBOgAtnRnLui+P8gfW1xLZygwT8R+vJj8Sdm8G3DaTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682281; c=relaxed/simple;
	bh=uVUo77H0bjGtSnzoIrRwR0Iu0tx67qbhk4wc5XH6gUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ar5DUXO1M1Qqhm5JxZWfLdrWWCqBLv7AERjFKjt1Zowhkkub05loH0sdgD+BknQENMFKk3zC2w2PTqeMqe4oq++CuDMd5EdfUga6GJLYgUue+a1hN7EEhXAnVa3qcn767n388tB4/dqf4NAtuBpx4Pmrs1JGTbKjX/7YNzO+48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLb2sEdi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778682279; x=1810218279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uVUo77H0bjGtSnzoIrRwR0Iu0tx67qbhk4wc5XH6gUg=;
  b=kLb2sEdi69zyeb0TcfxApbtyBdGGQtMvswataf0/ko5Ag0dOoEJ56obV
   LXbWBbcSRX5SADS87VK7Fyb4bEtNFkMLlK0b2sWCTMUFDsogwujXr3UAn
   kDqMdvCsYPV0r+Rj7xIKZ3CN70ejO1HhMVGqcNC5nZic+ZrHqxItImow1
   66DqfWQy6RTBegyz0CuFCecmiI5zbhjCq5mOqG2dNI2siGHj0oqkncdAU
   vVd/olH7M604E2ozHVwfD/qcGpayA6clIqPOyMF7rgK2eiqoNBn4WXsa4
   TI7AGGWtAcmjEZKXKPgn/oD4RBXHdH/FrFSxVUzvJ47saYguWxtZkiR5f
   g==;
X-CSE-ConnectionGUID: lSvUHS4EQwmsFWHBk7Wkwg==
X-CSE-MsgGUID: V25NhRLGRMKfFwzBo5rUdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97179307"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="97179307"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:24:38 -0700
X-CSE-ConnectionGUID: MRxAQY52REiYleNleNQhHg==
X-CSE-MsgGUID: T13gWfmHQ8uoKlH0Gauv+A==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 07:24:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: Allow per station GTK for NAN Data interfaces
Date: Wed, 13 May 2026 17:24:22 +0300
Message-Id: <20260513172418.37a8e259e611.I39bb9f3c1a65a8184124f531c18e121dc123d411@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD4D05351D5
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
	TAGGED_FROM(0.00)[bounces-36387-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Ilan Peer <ilan.peer@intel.com>

The WiFi Aware specification (v4.0) requires that NAN devices that
support security would also support per station GTK. Thus, allow
per station GTK installation to the driver on NAN Data interfaces.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/key.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 4b8965633df3..3030bd40bca0 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2008	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright 2018-2020, 2022-2025  Intel Corporation
+ * Copyright 2018-2020, 2022-2026  Intel Corporation
  */
 
 #include <crypto/utils.h>
@@ -150,11 +150,14 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 	sta = key->sta;
 
 	/*
-	 * If this is a per-STA GTK, check if it
-	 * is supported; if not, return.
+	 * Allow installation of a per-STA GTK if per-STA GTK is supported
+	 * by the driver or the interface is a NAN Data interface (as
+	 * per-station GTKs are required to be supported if secure NAN is
+	 * supported).
 	 */
 	if (sta && !(key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE) &&
-	    !ieee80211_hw_check(&key->local->hw, SUPPORTS_PER_STA_GTK))
+	    !(ieee80211_hw_check(&key->local->hw, SUPPORTS_PER_STA_GTK) ||
+	      sdata->vif.type == NL80211_IFTYPE_NAN_DATA))
 		goto out_unsupported;
 
 	if (sta && !sta->uploaded)
-- 
2.34.1


