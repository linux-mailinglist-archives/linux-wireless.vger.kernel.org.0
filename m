Return-Path: <linux-wireless+bounces-25136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3DAAFF32A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073AC4E4F3C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA282494ED;
	Wed,  9 Jul 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ey4X1Uim"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272EB248879
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093514; cv=none; b=Eq0gPDvF0K68/y/k65bB0UNuRs8hSw0SNx6Sg2G79IO3VbcJ6jwaI7rYLTssaGFKqK30ajUn6idKcN6DZUCexIr5bwanAa7xqW1OTxTz3VyGhUjvZAafPyFaFzt9i+EWiu59nULftdO0XDhuX16TKTfg+SbRN7ssjMGm5JAMWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093514; c=relaxed/simple;
	bh=th0688r0D0nENIWOT/CdanGqGZI7tLCZP7XCNBFb9IU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1xTLbVjFCRDWRP42QTvq/uoP0L3mopAP8SfZPBkA4oyHWt+9RHMkDOhCNULbJtaKNeKtXc33tKkGL63M6GDs+FKccIbP6deNul8SJ4z5Xu0TbtvdCnmkQ2zGiZhqEYErqY7/nnZcPjdwWKRnXu0RQt8xrFov5ufKkpdMwbW24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ey4X1Uim; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093513; x=1783629513;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=th0688r0D0nENIWOT/CdanGqGZI7tLCZP7XCNBFb9IU=;
  b=Ey4X1UimuL2FIbxrsx+fnKihjp1Okhi8/lOE+txqDEjPJh83mLeN7b14
   zxT1dgwYBhOT7JJU/vKnC/40tIxysNYAfo5aGAE7Jgmx9SZ7gwDhbPdfs
   rFtdzthaTlmy5pRu8pRm4kUrW/KPQWgwEpT6o2pbvrhaJVJQ4d20+3QKt
   CYSF1CsC3NVqR73wRruKXfQlJrcnxFGyN2yeZ7GePztI3tSXIcZ4nCx54
   JJQuFwx5PYKY0/NgoJvwsiLO/eTRRhj970bEthX28s/ZG8eqZ0nYXJ3IV
   hAO1ymDOpUcUEmViwbLQxzl/jg0XE9H1CHAsys9s9WvX2gugwaFcadyzt
   Q==;
X-CSE-ConnectionGUID: 5TFpdeEQS32gb1ivbFF7Lw==
X-CSE-MsgGUID: y9VBbfj/R4K7YXkc0N7Ewg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974449"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974449"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:32 -0700
X-CSE-ConnectionGUID: Oo3Mh0MGQiWc6UDSovvfYA==
X-CSE-MsgGUID: Lec63J1CRHyLuVOAl5Lohg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161533021"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 07/11] wifi: mac80211: only assign chanctx in reconfig
Date: Wed,  9 Jul 2025 23:37:59 +0300
Message-Id: <20250709233537.6245c3ae7031.Ia5f68992c7c112bea8a426c9339f50c88be3a9ca@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

At the end of reconfig we are activating all the links that were active
before the error.
During the activation, _ieee80211_link_use_channel will unassign and
re-assign the chanctx from/to the link.
But we only need to do the assign, as we are re-building the state as it
was before the reconfig.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 73a590598934..c9cea0e7ac16 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -910,7 +910,7 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->hw.wiphy->mtx));
 
-	if (conf) {
+	if (conf && !local->in_reconfig) {
 		curr_ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
 		drv_unassign_vif_chanctx(local, sdata, link->conf, curr_ctx);
@@ -930,8 +930,9 @@ static int ieee80211_assign_link_chanctx(struct ieee80211_link_data *link,
 
 			/* succeeded, so commit it to the data structures */
 			conf = &new_ctx->conf;
-			list_add(&link->assigned_chanctx_list,
-				 &new_ctx->assigned_links);
+			if (!local->in_reconfig)
+				list_add(&link->assigned_chanctx_list,
+					 &new_ctx->assigned_links);
 		}
 	} else {
 		ret = 0;
@@ -1932,7 +1933,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (ret < 0)
 		goto out;
 
-	__ieee80211_link_release_channel(link, false);
+	if (!local->in_reconfig)
+		__ieee80211_link_release_channel(link, false);
 
 	ctx = ieee80211_find_chanctx(local, link, chanreq, mode);
 	/* Note: context is now reserved */
-- 
2.34.1


