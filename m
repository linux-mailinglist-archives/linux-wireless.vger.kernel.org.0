Return-Path: <linux-wireless+bounces-13597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3663992AF8
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3D8284B9B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B61D2F4B;
	Mon,  7 Oct 2024 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnYljDNU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48C1D2B39
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302492; cv=none; b=PYwCoqpYQXU+oP7lKqLhPAeX5wRUUctXTLJVv6L3oqb9VxsWo126N4YxIk2pSQiLG6Cs2yhO9pfobBjjbP5KshD+mLXPFCpM4xE9pm/B2pwyWd3A0z/ndMOR7lXuwVDlNbLsh4caqunq1QA8wGeUHMLXS27JqSn4Ojkp7bpat58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302492; c=relaxed/simple;
	bh=sz1jJWGZIVWGh2d3E1VE4q75kQifcZho8Lra4RoI/uE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMfE+wbCS+Wuogcbyj/XK5B+qXwoI40jUSX/0v8roX0mGrA102x1pJwCXW/DpGF9rG4DsPfXK293FrCL+pwWJTugAAh1x6nhkoEjJQSpEeO7uhPwHSQVKhFVJfKz2h53DLcLF8ZGduAy1RgiZHE3/0k6OKwOSiP6tiTKZCrJhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnYljDNU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302491; x=1759838491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sz1jJWGZIVWGh2d3E1VE4q75kQifcZho8Lra4RoI/uE=;
  b=mnYljDNUdK2N4KzRtMXvEaAJPI6q1auGUHzBYtbt4IH904DFV1Y13Gv9
   OYYtFpGomDk2gTfML5fWw1jqbYCcDrt1U3Avxnuwa+BzxT0vqJ9Z2Efgm
   yz5hdjDnZYEAZI6hthqJdh6DiMcSYQTe3UGR43AAJCeOBVKVIV4aEY6Z3
   2j4lGVn4mKGhVIdYUO7lm8r8PSrC3IFgBvCfAe2dv6Yc9tbfIy8Bq2s1H
   b63D2JrWerB+M/+aGm+MeW/vF9QBdUx7Ckbspdqm+byCUMpkvgH/naqkB
   zBhIzvtEZtuyb6cUkJktHFBuCDzlycpRLYNP9ko19PX5uut9SLQ+iW2IK
   A==;
X-CSE-ConnectionGUID: NlQM246eQp6j3wuyB+myfg==
X-CSE-MsgGUID: v/Lnb2lsQ1KXeo7CA91Njg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38099437"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38099437"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:30 -0700
X-CSE-ConnectionGUID: ZTRwZgF1QqGHh2E4O/1cew==
X-CSE-MsgGUID: LV4NUUNUSqKiHaf+YXbGcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75019282"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:01:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/14] wifi: mac80211: add an option to fake ieee80211_connection_loss
Date: Mon,  7 Oct 2024 15:00:56 +0300
Message-Id: <20241007144851.3b42e7547c65.I3bcbd51bec9ccfc7c08739450ec778722549c007@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
References: <20241007120058.1822752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This allows faking this function in KUnit tests.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 91ae0ff49bba..df935f814a80 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -31,6 +31,8 @@
 #include "led.h"
 #include "fils_aead.h"
 
+#include <kunit/static_stub.h>
+
 #define IEEE80211_AUTH_TIMEOUT		(HZ / 5)
 #define IEEE80211_AUTH_TIMEOUT_LONG	(HZ / 2)
 #define IEEE80211_AUTH_TIMEOUT_SHORT	(HZ / 10)
@@ -4182,8 +4184,13 @@ EXPORT_SYMBOL(ieee80211_beacon_loss);
 
 void ieee80211_connection_loss(struct ieee80211_vif *vif)
 {
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_hw *hw = &sdata->local->hw;
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_hw *hw;
+
+	KUNIT_STATIC_STUB_REDIRECT(ieee80211_connection_loss, vif);
+
+	sdata = vif_to_sdata(vif);
+	hw = &sdata->local->hw;
 
 	trace_api_connection_loss(sdata);
 
-- 
2.34.1


