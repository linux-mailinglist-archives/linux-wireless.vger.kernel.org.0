Return-Path: <linux-wireless+bounces-37019-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNKfBFlJF2r0/wcAu9opvQ
	(envelope-from <linux-wireless+bounces-37019-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:43:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CBC5E99A2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11FED30210F9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75638229D;
	Wed, 27 May 2026 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBe5KwI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC95314D18
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910995; cv=none; b=IjOZ+Sh6vODFLEnJetf38+vaDMl4MUxIwhNrX9Yv8W0YDFuVlAhxwu15EJZFZZ3e9kZaC4iBdS9sKZfxapLl+GZ7uYtMjp15K9aWJhJD9gYDKvryWMZrB5wCX0lBHtJCNCttmb9TkTimzrd7aCsLQOVfIEbKmm1ZrWi32PjK/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910995; c=relaxed/simple;
	bh=zjz4yXaBwBPcv77Q9AKn5PPsm2GrGPVxZWi2hLt82jY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUjY72j0CbAZqU0iemm+DKRiq9j3LMnpKTbBJfO7cCvr2zKxd63FKbXQHIm7/MVsQck3BGx+ndatgnCasuoiGqqnOzs4+ZcDKyNCPy/0kGRq56qmLPmJqWRzrWAHuJpBoYyuV9v6XycrSDta+wCk8XLZwc12mERtY+QSDeiXNg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBe5KwI+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779910994; x=1811446994;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zjz4yXaBwBPcv77Q9AKn5PPsm2GrGPVxZWi2hLt82jY=;
  b=HBe5KwI+Ymb2+PBcPsrDSsJir98prg60j7JacQG6CDaY0XHDn+OlPLel
   hiLkqlPrkhgOcFimHtp0k+AAD38saXp54VjBmsOx0u69w2OXJX2SFrB6b
   aQs5mk0uKwqd+QlKbMsHHadhcGCl0xJ4EALPFhOnB5XH3GROVVqz8lcCb
   3TeMhdMCk38hAsQP0lXH8E2/ZFnam9k79ka38+HKuNu2U/0lmHVTkS6DH
   hBPYRNlAoLr4swUM320Mt7DgNn1U8+ZJ+c/qjOUY1nFuIGy5EIqTS93w4
   S/WTFj3uFmQYA6xvYw4MMBuZrzPgxm+TTs935leCUunE8W+9OK9Ii9xxo
   g==;
X-CSE-ConnectionGUID: juxF5tj4RPS6fTreA/jV7w==
X-CSE-MsgGUID: Hud5WTQWR4GbzYtG43wMhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84611764"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="84611764"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:43:13 -0700
X-CSE-ConnectionGUID: F2F9eLt1R1W+c1ILR5pjUA==
X-CSE-MsgGUID: lQk3xesZRAGF6UuzA4fuOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="265940787"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:43:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: add debug messages for link changes
Date: Wed, 27 May 2026 22:42:40 +0300
Message-Id: <20260527224151.b22a048abc7c.Ief2132c5c4bb67fa56e90eb8e7d59dfd9f2b9378@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37019-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 07CBC5E99A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

It's useful to be able to see the link addresses when the
interface links change, so add some prints to hwsim for the
vif link change callback.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 67a33e5e7d54..af9b0d957ad0 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -3505,8 +3505,13 @@ static int mac80211_hwsim_change_vif_links(struct ieee80211_hw *hw,
 	if (!new_links)
 		add |= BIT(0);
 
-	for_each_set_bit(i, &rem, IEEE80211_MLD_MAX_NUM_LINKS)
+	wiphy_dbg(hw->wiphy, "%s:\n", __func__);
+
+	for_each_set_bit(i, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
 		mac80211_hwsim_config_mac_nl(hw, old[i]->addr, false);
+		wiphy_dbg(hw->wiphy,
+			  "  link [%d/%pM] removed\n", i, old[i]->addr);
+	}
 
 	for_each_set_bit(i, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf;
@@ -3516,6 +3521,8 @@ static int mac80211_hwsim_change_vif_links(struct ieee80211_hw *hw,
 			continue;
 
 		mac80211_hwsim_config_mac_nl(hw, link_conf->addr, true);
+		wiphy_dbg(hw->wiphy,
+			  "  link [%d/%pM] added\n", i, link_conf->addr);
 	}
 
 	return 0;
-- 
2.34.1


