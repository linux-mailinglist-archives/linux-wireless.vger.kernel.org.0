Return-Path: <linux-wireless+bounces-39048-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B3AqACgfVmrZzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39048-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:36:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41787753F32
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:36:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ckoG6wPb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39048-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39048-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7484D314588E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263A134750D;
	Tue, 14 Jul 2026 11:33:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748D35C19F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028794; cv=none; b=mpYIiXUVb46eW7VWh634k4Uzu1ovcN94MQ3N6mkScejS2HywHAGB0x3bVwNBtaxdmRZu3d8uchcKpNL3trphFBvOgBt754Hu/ytjU9wouFCT4+8xWARSy3bxPA5K/zgSRfgKTTvwIttAXjd5gPOUGeCVI5DWnj+1nsxBqs5z340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028794; c=relaxed/simple;
	bh=yQzFLuXXb5esbsiXt95Wyui4kgUfFUxblBFjlCdew/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SznweOr96zP53z0t8DpT5pe4Y6Ij3RDsXoubLjPHDITySqpmXpDtuaw5M/GBwvYsNfBpg+tjWxhJM+1j4YZ2UPHCbwncJsGe2mjHUJuvD1QT5TIyftdjCLWceRuYpYRm3cQpFK4m1Sfrx3f4KivzSF7/lKzkPOXRwHuS2KJChGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckoG6wPb; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028793; x=1815564793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQzFLuXXb5esbsiXt95Wyui4kgUfFUxblBFjlCdew/s=;
  b=ckoG6wPbOgLSIEsENtRIw7XQyZn5QcsFwSrl0VUPWQd5+DiSXz4/QV3m
   iG17MiiZ2gFp0S9aGFbcfv0/YX/4u5+v1cuRJL8RvM8MkQq6o0Pc8sWEc
   14Hv88OirOulXolsHWYbm6V2N2vhGlDfwDxIyXiYrjgDvbnCULzfdULnz
   ki6aycNZu6Ik1OafdUcfAUedrp7PE1n22zTJ71uY/vn7hU+JWdBn9yoOO
   Fxc2aWT8mb7tqv7ixE0GpY7QEitLX3bMtrieedp8hWpQ12QabQ/xWEpWk
   U51/rv2aLSUqsuliAKE1p73HP31DswuvoKEVnU+AgIM4BmTbjYCaZZs31
   g==;
X-CSE-ConnectionGUID: bSf0en9GR+GC67fdu+sdmg==
X-CSE-MsgGUID: J641TFD1Tj2bsA7w7DrBSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469583"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469583"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:12 -0700
X-CSE-ConnectionGUID: HyuDpxp5Tw2EPKh7pmpUew==
X-CSE-MsgGUID: JBhWhBc5TuiG+sV62dMxjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882922"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mld: treat valid BAID without STA as a FW error
Date: Tue, 14 Jul 2026 14:32:32 +0300
Message-Id: <20260714143119.4902f73de145.I2cec7133f2a2ec8c39dcfb36938aba2ea3d6be24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
References: <20260714143119.a549b9499e3e.Id1a95bbbf92b5862862becaf57419bb9fe1385e5@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39048-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,changeid:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41787753F32

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Somehow, the firmware sometimes seems to have a valid BAID even if the
ieee80211_sta was not found. This happens in sniffer mode.
Treat those as a firmware error.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index e3627ad0321c..1aa30d2e8133 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -200,11 +200,11 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 	struct iwl_mld_baid_data *baid_data;
 	struct iwl_mld_reorder_buffer *buffer;
 	struct iwl_mld_reorder_buf_entry *entries;
-	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
 	struct iwl_mld_link_sta *mld_link_sta;
 	u32 reorder = le32_to_cpu(desc->reorder_data);
 	bool amsdu, last_subframe, is_old_sn, is_dup;
 	u8 tid = ieee80211_get_tid(hdr);
+	struct iwl_mld_sta *mld_sta;
 	u8 baid;
 	u16 nssn, sn;
 	u32 sta_mask = 0;
@@ -223,10 +223,13 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 		return IWL_MLD_PASS_SKB;
 
 	/* no sta yet */
-	if (WARN_ONCE(!sta,
-		      "Got valid BAID without a valid station assigned\n"))
+	if (IWL_FW_CHECK(mld, !sta,
+			 "Got valid BAID without a valid station assigned - %d\n",
+			 baid))
 		return IWL_MLD_PASS_SKB;
 
+	mld_sta = iwl_mld_sta_from_mac80211(sta);
+
 	/* not a data packet */
 	if (!ieee80211_is_data_qos(hdr->frame_control) ||
 	    is_multicast_ether_addr(hdr->addr1))
-- 
2.34.1


