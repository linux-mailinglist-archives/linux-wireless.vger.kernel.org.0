Return-Path: <linux-wireless+bounces-30650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C542D0F856
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB6C3047950
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8775349B17;
	Sun, 11 Jan 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ne4buOMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690D34BA24
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153178; cv=none; b=Ns85yTXWQ4t5O+0oYT7rOkUa/ez/RP6YIaTkpVlIg15LVfg5BAZWat+znF79ezlBU1ZuTE2JaqjXMqR4zIKkuHMJSpGwHkZPqMUBKD1YWz5Bc9G1hgTdh46BqdIWE3vkyjCMKvrHPbTKfKjKGrIN4uJomvrvFfnWHOUeEnQacCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153178; c=relaxed/simple;
	bh=iRqCjzmd86L/Ni01DIZXeAlkyTAyKXMOMjoQapr9vDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+6ebugTx707zNcyuO3QoLAsTgKvQ+0/6TaIxZmq4Q+GzPoHJgNffYfWadAmik/vwlMUGw1QEOwc1tF8eKROcIBSHqEZatrZrKeOkEEDrbXdn+a9yjInRVdE5p5SrBaR7OPJPyhwLijeG6BsVYJDu1SvzyckATVxqyHns5XtC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ne4buOMI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153177; x=1799689177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iRqCjzmd86L/Ni01DIZXeAlkyTAyKXMOMjoQapr9vDc=;
  b=ne4buOMIb7Id8Y0HTwiMXSgIopqXWxkVpcM3PrlAKBp6MMvGHRmvk/jH
   /AF4l/zgrHsb36Tx3ZhEjYCbTimBEFdBFCfPvklOVptzBn/OpZJvlshoG
   WPX/9Ygzd793E5jVyb0mayBEe4mdj14/XDo3H6FH86n+gRsvTqUIkA5aV
   FPlX1GqZn7fRkirq5YBuUBN0k9le/g5FCSiQDS8Ho1IcAKt8JjYDEC9ZZ
   nL+l+3mB+5nAdnGCq7qJDE8OQ5H0PR07X6R2lnOZ5IGbDeqQ34eOqgKCG
   9Z+FJ7J00qoXZROJo9JJ5Mjo07IBLunoMFnDb/f43gbCt8rg9U9oDzUQ7
   g==;
X-CSE-ConnectionGUID: V8RT2WeDQqeQNNUGaCP2vQ==
X-CSE-MsgGUID: U5RiVvP0RBiIs3LxpArLYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521081"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521081"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:37 -0800
X-CSE-ConnectionGUID: x7n90B5RTnqddU2os95rQA==
X-CSE-MsgGUID: 27gKv4wVQYOn5LEefVtyBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393772"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:36 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: mld: fix chandef start calculation
Date: Sun, 11 Jan 2026 19:39:12 +0200
Message-Id: <20260111193638.2138fdb99bd5.I4d2e5957b22482a57b1d6ca444e90fcf73bf2cab@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

A link pair in which both links are in 5 GHz can be used for EMLSR only
if they are separated enough.

To check this condition we calculate the start and the end of the
chandefs of both links in the pair and do some checks.

But the calculation of the start/end of the chandef is currently done
by subtracting/adding half the bandwidth from/to the control channel's
center frequency, when it should really be subtracted/added from/to the
center frequency of the entire chandef.

Fix the wrong calculation.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index c6b151f26921..1efefc737248 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -844,9 +844,9 @@ iwl_mld_emlsr_pair_state(struct ieee80211_vif *vif,
 		if (c_low->chan->center_freq > c_high->chan->center_freq)
 			swap(c_low, c_high);
 
-		c_low_upper_edge = c_low->chan->center_freq +
+		c_low_upper_edge = c_low->center_freq1 +
 				   cfg80211_chandef_get_width(c_low) / 2;
-		c_high_lower_edge = c_high->chan->center_freq -
+		c_high_lower_edge = c_high->center_freq1 -
 				    cfg80211_chandef_get_width(c_high) / 2;
 
 		if (a->chandef->chan->band == NL80211_BAND_5GHZ &&
-- 
2.34.1


