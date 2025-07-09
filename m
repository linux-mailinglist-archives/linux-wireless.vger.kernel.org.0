Return-Path: <linux-wireless+bounces-25125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801EEAFF2ED
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C233B918C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C2B242D7A;
	Wed,  9 Jul 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZvcmsxD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D721FF3C
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092700; cv=none; b=SqzO8vmG8iuahB/wAkgzrpq4f3jiUxQeWOzDK8BO63u1jSUkUwCQdjp5P48vVJEx4nQusozvdCbuIEjWYoHmDz+QHryOmFXcYpdR+04YqWsghwzTmDYgSqs+P8JuuHwSnZ+RLrMZ+sMoW2uHsobc57C9TD4E7h/yy8mmAggjLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092700; c=relaxed/simple;
	bh=VGPs5tZ4ma8dJ3sD4OskYleGf9bKv6EjpxqNQMKnLl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bw6snXCJMQwV+yUAl5akgMN/lDKio5HDWv/QVz3Kl0kLE8+OBUHJwyxZkzmcITib41tTNab34riGqvqyh2Wk616bpnlWHMEHmp2ydJG4ADJ2mZGTDRkSH+/R5guoVz/6q8OiG4YwoXkUCxtF2OJNP9dk26id6CAwO0qF1ja8hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZvcmsxD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752092699; x=1783628699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VGPs5tZ4ma8dJ3sD4OskYleGf9bKv6EjpxqNQMKnLl8=;
  b=YZvcmsxDueKUVgL14EBleQAals6ovpgiOyosTTIFeopJHFyh6ANdmwbW
   thSB3hns5JmlkHBYky7JjsJ+tjK8fda04TY6yvGXkYFnzQTGs5WNk6Yzw
   9iavj2y4c1janX40r8cAQ6E7WDWywblBCqaMgjwjRg3u8pTp8lVT5rbjq
   6CS5UXSomN9S4VmmeiCKji24wkJMWIIPKIzxIRpKoonMtusHRLq0UclSr
   xMFLxoM9jee1H/Lt8+StH9v3/B6uZ/+cIkLqb9Mrg4adfs5YJaCRCadPC
   wX2iVjS9ei6K6rMzdDAbRhtg9w4LB7tg7c4rjlg+QVrxgqoQKPvcTvwed
   g==;
X-CSE-ConnectionGUID: +a0J9NihSauJh24b5gbbfQ==
X-CSE-MsgGUID: iOkpx33jQ4GL+A1VSWevtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54509711"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54509711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:24:57 -0700
X-CSE-ConnectionGUID: GiA85M3jRVu2nXBNtbc2uw==
X-CSE-MsgGUID: cIddkLYsT5uC3TC5/M8/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="159897621"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:24:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: mac80211: always initialize sdata::key_list
Date: Wed,  9 Jul 2025 23:24:35 +0300
Message-Id: <20250709232419.8dcefe578497.I4c90a00ae3256520e063199d7f6f2580d5451acf@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is currently not initialized for a virtual monitor, leading to a
NULL pointer dereference when - for example - iterating over all the
keys of all the vifs.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/iface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7c27f3cd841c..c01634fdba78 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1150,6 +1150,8 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 {
 	sdata->local = local;
 
+	INIT_LIST_HEAD(&sdata->key_list);
+
 	/*
 	 * Initialize the default link, so we can use link_id 0 for non-MLD,
 	 * and that continues to work for non-MLD-aware drivers that use just
@@ -2210,8 +2212,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 
 	ieee80211_init_frag_cache(&sdata->frags);
 
-	INIT_LIST_HEAD(&sdata->key_list);
-
 	wiphy_delayed_work_init(&sdata->dec_tailroom_needed_wk,
 				ieee80211_delayed_tailroom_dec);
 
-- 
2.34.1


