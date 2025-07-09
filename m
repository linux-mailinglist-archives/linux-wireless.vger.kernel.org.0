Return-Path: <linux-wireless+bounces-25131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44EAFF325
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6940A1760EB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43F245005;
	Wed,  9 Jul 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+MWpCs8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1524466F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093508; cv=none; b=fgPX/DKaAeWQJy2oLMEAD3k9H3YNLXX49yEmmep8yrEaJAU7DVyJ/otuNbsqgS5tqFGcDQ7A6uCRJpyKeAk1Q21zACFV+SrSyH7I0HaT2ocVZxE1BT1ToHMbaZUerOMPUueiFSSXJPeABjksXq6rxUrE9g/Wf58ED5xtve3U3CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093508; c=relaxed/simple;
	bh=U69tivKEJ7OqKkVtwEsG/c1oKq7isy9VceF1/31ZHFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjZAJwfCdfkLKPXhxe0WwxTikOV7U8F39rJb82t0Dm5PbU970vV/T4QKv1zFoMDKhGddn9GVrL9vYqlbrosSyImnqxaMBPt5e11bdyr0JHp4eVe2Q6i27b/O+LG5oagj7AytpxT3UBjGG/f29jVMSAFVBcX6EDg1/xlhmNBpVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+MWpCs8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093507; x=1783629507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U69tivKEJ7OqKkVtwEsG/c1oKq7isy9VceF1/31ZHFc=;
  b=T+MWpCs8v7AvNaZKUKo7caP17FKx0BFNcyTL5ekcYqzcWjWON8Fu/Jwx
   Omh6ZqJldW3Gr+0N1a1kG3ch/XdURpzguUPs39JnNydFnJVFXnujseWZn
   +QdL+ym+DidgPUZyy2i68/HNn9/yAX7EeycL1om0tFcy8rxiQ+8zuDiwC
   7aKG3b5xcr5aYv/KiSn2I6F/mS/WNzvAQOD29AKTRL3w5+3km1AV/mxiM
   W3XwIrLFyrhovdj83BBsqFM4Q9k+NyM5XYRHHO3pNyUC7AGlNt3T/smb0
   uiAxNUgipbSGxhOxj/1HyDm8h7OHzDXFcuCrSDDZnANfQqxN8TSJpjhQF
   w==;
X-CSE-ConnectionGUID: /2yxnjjHT9+fsGaUWm0fQw==
X-CSE-MsgGUID: qu4bkLZkRFKibsSxxKbeeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974438"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974438"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:26 -0700
X-CSE-ConnectionGUID: 3I2hm5wtR0ylWWoW83LpZw==
X-CSE-MsgGUID: 9+imc84/QVqEPUbkERFO9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161532706"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 02/11] wifi: mac80211: remove ieee80211_link_unreserve_chanctx() return value
Date: Wed,  9 Jul 2025 23:37:54 +0300
Message-Id: <20250709233537.5b436ee3c20c.Ieff61ec510939adb5fe6da4840557b649b3aa820@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

All the paths that could return an error are considered
misuses of the function and WARN already, and none of
the callers ever check the return value. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c        | 8 +++-----
 net/mac80211/ieee80211_i.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 4bcbcf9d98b5..73a590598934 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1108,7 +1108,7 @@ void ieee80211_link_copy_chanctx_to_vlans(struct ieee80211_link_data *link,
 	__ieee80211_link_copy_chanctx_to_vlans(link, clear);
 }
 
-int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
+void ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chanctx *ctx = link->reserved_chanctx;
@@ -1116,7 +1116,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (WARN_ON(!ctx))
-		return -EINVAL;
+		return;
 
 	list_del(&link->reserved_chanctx_list);
 	link->reserved_chanctx = NULL;
@@ -1124,7 +1124,7 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 	if (ieee80211_chanctx_refcount(sdata->local, ctx) == 0) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER) {
 			if (WARN_ON(!ctx->replace_ctx))
-				return -EINVAL;
+				return;
 
 			WARN_ON(ctx->replace_ctx->replace_state !=
 			        IEEE80211_CHANCTX_WILL_BE_REPLACED);
@@ -1140,8 +1140,6 @@ int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link)
 			ieee80211_free_chanctx(sdata->local, ctx, false);
 		}
 	}
-
-	return 0;
 }
 
 static struct ieee80211_chanctx *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec68204fddc9..142b547ca606 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2697,7 +2697,7 @@ ieee80211_link_reserve_chanctx(struct ieee80211_link_data *link,
 			       bool radar_required);
 int __must_check
 ieee80211_link_use_reserved_context(struct ieee80211_link_data *link);
-int ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link);
+void ieee80211_link_unreserve_chanctx(struct ieee80211_link_data *link);
 
 int __must_check
 ieee80211_link_change_chanreq(struct ieee80211_link_data *link,
-- 
2.34.1


