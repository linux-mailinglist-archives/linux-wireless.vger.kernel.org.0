Return-Path: <linux-wireless+bounces-39066-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +5vhOc9CVmqV2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39066-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42087755878
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=icjtxmou;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39066-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39066-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90BC31C9507
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05B37106A;
	Tue, 14 Jul 2026 14:02:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193C47CC67
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:02:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037772; cv=none; b=ctoXnuaHT48zTrNlhc5WLQoQysy+gFJyZfTYcAs8CixxQj0hj46ADY44jxh1H9eOk8eEVaXTB2FDU1MuMMeSjYB6kqmrAkxyfIwz7MD9t2fENaJS3zSaHhA4Z0eMX/1BhLdMizEvWurMwjBRFTilcqm8mbvt3VWTuTUBy744/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037772; c=relaxed/simple;
	bh=yQzFLuXXb5esbsiXt95Wyui4kgUfFUxblBFjlCdew/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+s1s1hcevnl/BfcuGh4aEXC4bJQ91f3p6koSIMI5E3tc3XqOR+P9+VpExhYeYvHFgLcaQdNPN1i6hdPc/jREXJ8iqyd5e1pumywBDAk5BLxqfbnmVIuw9mZquScx+SrV9tCIFV5GXN1WDQzKgvn3Lr8IIT4XWZjU49t12MQH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icjtxmou; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037771; x=1815573771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQzFLuXXb5esbsiXt95Wyui4kgUfFUxblBFjlCdew/s=;
  b=icjtxmouGcaSSsiXRFQhKVOn28vXD+Pb/9nH0vZRmxaLdd9N3M4M+sh2
   L5EGeFJ/XG93J4IguM2zQj0cyHDRjdatxKZtkEQgGiFaZA66jCort3ROq
   8P3//dWqFlzotWOhod+LpLETJLMyeXz+sisuhJ4tymfb5t/84bReTxP4+
   uiGjNwGoGmqacnDKJDTZb7JFeGkVDukfOMLNrczjImkElTz/ykxMN2dHc
   QFRFQ12BnY8HBq9eAGwOhbGP6x5xIzDpMMD1Ud0lsFcD+B/MmiX95Xy+J
   lJfS0dReyQm9QRrokwbfkHpMufM90bJVyJRHtQPl+VoS6EiJGqjjtY6/Y
   Q==;
X-CSE-ConnectionGUID: HychNuNxTo6+ZwOL2w8gUQ==
X-CSE-MsgGUID: 8hQOgSDWTkyyNe5zdCakhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855092"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855092"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:50 -0700
X-CSE-ConnectionGUID: pDkdWynJQG6l+5t5F2xn6w==
X-CSE-MsgGUID: e69fD8xrRB+9b5S+UOZpgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737861"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/15] wifi: iwlwifi: mld: treat valid BAID without STA as a FW error
Date: Tue, 14 Jul 2026 17:02:09 +0300
Message-Id: <20260714165826.4902f73de145.I2cec7133f2a2ec8c39dcfb36938aba2ea3d6be24@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
References: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39066-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp,changeid:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42087755878

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


