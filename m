Return-Path: <linux-wireless+bounces-33638-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNRWMaXVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33638-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A92E68AA
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605113014411
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB2E32C923;
	Sat, 21 Mar 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmKRpAjm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103D2836BE
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114189; cv=none; b=d/g+1iokTlrSxXKmeU4cYKaxsgkbelAv9y6YsMcm7rngf+MI+eQfQsk89y6g655WA6cvmD4Qb+6WKfCefaw4j3Px/zNuq9hRQyHFcJUe5UatxEwjVZqkvQofePhVAJltDktlQnJhO22ZHif/J1lT1CIPDY7bpxGMCkBh84mNGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114189; c=relaxed/simple;
	bh=TAyjkIrPZHtdbMfK7i3+Vo8Haugqj/zICOsha6//udY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMEJqjtEn76CnkLAtozT9lEwavFOVCry2PBIWip7FXW0fJldndMPh917Y1cus33ZnWk8czK998kVKXTGaB+Xda3wpmZrif7PTEGf09Ku/ocqiYrdeUlrrIz4DJZ/QJzUBgNi3ADPyaDCvHtUqYZjM5r+I5JVmBvEUFdDHlI4ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmKRpAjm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114188; x=1805650188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAyjkIrPZHtdbMfK7i3+Vo8Haugqj/zICOsha6//udY=;
  b=WmKRpAjmPj4ZZRKjSSA469osx8J2HF3Is9dPyjEiKzVLIDxU146jycU+
   FMEI3tvJSKBklfrfpyac1jdXyLU29IDFOa8jqx84r8RAVpmd3zMhu1841
   u8EB6LJsm3MQd7LEss8LdMBk1crDhjcaTZCpKtl2bou+WhUVVVg+F9q4V
   z5MhhVwkBqevLrfnQKHcGK3b5Uk5KvSAjxaQe71xBoH01n6TcUCMNDHzJ
   zbeZ2926Rl4Lv5+GecaXyMxCeQl2FKr/Sh7W0fVbdnbUmRLrAVWZpbb/Y
   lblEOoDN2jU7thAesVom84OIaAgoRXzWfarPhU07dYvuhp7bkQHcV8t7A
   g==;
X-CSE-ConnectionGUID: 3dpffDZ8TTeBdID8wid2kQ==
X-CSE-MsgGUID: ViMMlU13SiGhI3oTdwkazw==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244595"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244595"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:47 -0700
X-CSE-ConnectionGUID: +3+iRs9IRx6l9Necj8PYcQ==
X-CSE-MsgGUID: vhjWfyY8RB2ONu3qjBS1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813604"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: block EMLSR during TDLS connections
Date: Sat, 21 Mar 2026 19:29:18 +0200
Message-Id: <20260321192637.c1376b0259dd.I016587eb1570f7a7a64c0c95e0636e955a640350@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33638-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 443A92E68AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Bhatt <avinash.bhatt@intel.com>

TDLS (Tunneled Direct Link Setup) requires single-link operation
for direct peer-to-peer communication, which is incompatible with
EMLSR (Enhanced Multi-Link Single Radio) mode where the radio
switches between multiple links.

Block EMLSR when the first TDLS peer is added and unblock when
the last TDLS peer is removed. The block/unblock APIs handle
exiting EMLSR and triggering link selection automatically.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 21 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  3 ++-
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 3e106c93f0db..0857ae28be8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -33,6 +33,7 @@ enum iwl_mld_cca_40mhz_wa_status {
  *      there is an indication that a non-BSS interface is to be added.
  * @IWL_MLD_EMLSR_BLOCKED_TPT: throughput is too low to make EMLSR worthwhile
  * @IWL_MLD_EMLSR_BLOCKED_NAN: NAN is preventing EMLSR.
+ * @IWL_MLD_EMLSR_BLOCKED_TDLS: TDLS connection is preventing EMLSR.
  */
 enum iwl_mld_emlsr_blocked {
 	IWL_MLD_EMLSR_BLOCKED_PREVENTION	= 0x1,
@@ -42,6 +43,7 @@ enum iwl_mld_emlsr_blocked {
 	IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS	= 0x10,
 	IWL_MLD_EMLSR_BLOCKED_TPT		= 0x20,
 	IWL_MLD_EMLSR_BLOCKED_NAN		= 0x40,
+	IWL_MLD_EMLSR_BLOCKED_TDLS		= 0x80,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 897602e5f9e7..da6fd7471568 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1759,10 +1759,19 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 		if (ret)
 			return ret;
 
-		/* just added first TDLS STA, so disable PM */
-		if (sta->tdls && tdls_count == 0)
+		/* just added first TDLS STA, so disable PM and block EMLSR */
+		if (sta->tdls && tdls_count == 0) {
 			iwl_mld_update_mac_power(mld, vif, false);
 
+			/* TDLS requires single-link operation with
+			 * direct peer communication.
+			 * Block and exit EMLSR when TDLS is established.
+			 */
+			iwl_mld_block_emlsr(mld, vif,
+					    IWL_MLD_EMLSR_BLOCKED_TDLS,
+					    iwl_mld_get_primary_link(vif));
+		}
+
 		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 			mld_vif->ap_sta = sta;
 
@@ -1908,8 +1917,14 @@ static int iwl_mld_move_sta_state_down(struct iwl_mld *mld,
 		iwl_mld_remove_sta(mld, sta);
 
 		if (sta->tdls && iwl_mld_tdls_sta_count(mld) == 0) {
-			/* just removed last TDLS STA, so enable PM */
+			/* just removed last TDLS STA, so enable PM
+			 * and unblock EMLSR
+			 */
 			iwl_mld_update_mac_power(mld, vif, false);
+
+			/* Unblock EMLSR when TDLS connection is torn down */
+			iwl_mld_unblock_emlsr(mld, vif,
+					      IWL_MLD_EMLSR_BLOCKED_TDLS);
 		}
 
 		if (sta->tdls) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index f693f92e42b4..9362e02d9e76 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -13,7 +13,8 @@
 	HOW(NON_BSS)			\
 	HOW(TMP_NON_BSS)		\
 	HOW(TPT)			\
-	HOW(NAN)
+	HOW(NAN)			\
+	HOW(TDLS)
 
 static const char *
 iwl_mld_get_emlsr_blocked_string(enum iwl_mld_emlsr_blocked blocked)
-- 
2.34.1


