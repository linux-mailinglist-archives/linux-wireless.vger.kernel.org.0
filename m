Return-Path: <linux-wireless+bounces-25127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E57AFF317
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259DC3AB67B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE5921ADA2;
	Wed,  9 Jul 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7d1CCyK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE92367AB
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093273; cv=none; b=FR0dSXqNWdvrgEMclShB4z5hsFCEYICR+V9cjgHFNYHSx8b12G7d50ZwCC2hTNninj4pdxRucurSMoFrt121tljAUKHJOlpE/dSD1bc72vVDGK/rBkebLQ2k0rgLE2J7e1hWiXNtpvNDzQL2bkRO559awnpXixiL4XY8CGWiNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093273; c=relaxed/simple;
	bh=VGPs5tZ4ma8dJ3sD4OskYleGf9bKv6EjpxqNQMKnLl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DR04YXPMbzJKg7PCupt5dAgaN6xYlLomhHM8uox6pE3NLvsyjRbUfWnfGbPEGAOn/oUnwF9ZEAwLytnk0iBu31oMGE2yPab+fszZyB/UV99Cd0gcFKwFdAlboOcc5d3ePVMXYr5Vsu0Gz2pMxsbwci5h/QgMwJImZjakzDf+2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7d1CCyK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093272; x=1783629272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VGPs5tZ4ma8dJ3sD4OskYleGf9bKv6EjpxqNQMKnLl8=;
  b=Y7d1CCyKTd24ZOj1wNcz0M554VuQsJ0MlNfOj4Bxn1z3v9gXlhf8JSz1
   tyPl28u318BH6QefCvFnpMfl/H/25qFqBvoyLfx1luO9Kjc13tq2VDk1+
   Ji1MeCzFeEMZ+lQw8QqRl6xQFZuM6ewD8GpQEH/LHwe9+unUXVyrMjtkG
   DxYrV/XmrFirxhtfjbCKZhgsIxCZc9Z9jwVK4kZkS54H/mFazWRoneUaX
   oy7+39wCldP9X/cWlFq/Yy4AgoR4dYPSLeHehDMq1fAOjv/eyklk6ver7
   EUWGGYwzAC60UKbxT6gfwZ33BFNZzP/W6wj2RnVjw4srd9LbKK1sYBMgl
   g==;
X-CSE-ConnectionGUID: P4y3EPigTcCSzSGkqaGdbw==
X-CSE-MsgGUID: Vdah7uvqQFaMtiAkz9gqaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974114"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974114"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:34:31 -0700
X-CSE-ConnectionGUID: YOErBT4IQGOCRUJKh5Rtzg==
X-CSE-MsgGUID: 5Gj+BawmTCWSsx2tBhLrZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="193077127"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:34:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: always initialize sdata::key_list
Date: Wed,  9 Jul 2025 23:34:10 +0300
Message-Id: <20250709233400.8dcefe578497.I4c90a00ae3256520e063199d7f6f2580d5451acf@changeid>
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


