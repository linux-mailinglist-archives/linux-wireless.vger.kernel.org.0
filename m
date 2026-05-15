Return-Path: <linux-wireless+bounces-36468-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNSRDb0bB2rnrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36468-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:12:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A2550432
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 478D1307B24E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274F1A285;
	Fri, 15 May 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWD/1UHT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B047A0DB
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847009; cv=none; b=Xx3J5CyI8WMei1wHx2Hj4QU9Hd0O/StJi4+W6sr0BkQEr2Grb2gxgVbi/GQ3x+qEKjOBX+lSwAdkDrANc/cYK+ZGlE5Zpi0BTWgDbqVvPa6Oj8IczOjckA1g92bf002vHWc6Pd2Y1W62k5Hz+wnkmKXR+Ys+sJnsxlMWvb3KOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847009; c=relaxed/simple;
	bh=zM5rBB2IxBw1P8UNmXBzSsrFH3Fb246EKz5nYcGzce0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JtmRX6TLesuzUd5iOwnuWNGHc9VGYhnMvwSYIJHOggrIEOemCo4RtASQk9JY9Y98du8rFpUSzot+OGgW3KhF3UvW7MD9YbJdz/bMVVwwXsiKoxLSlNyp/qcalPC2v/REnvIz65+5LjKMcQxMvpRcHO4P3M8H95xvzexR0+9TjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWD/1UHT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847008; x=1810383008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zM5rBB2IxBw1P8UNmXBzSsrFH3Fb246EKz5nYcGzce0=;
  b=AWD/1UHTDAIIMCuST4UqbgA5QEnGq+MQCusw7P7ErD9JU0DT79Mb3ASO
   1KfcNheCydOJTWwCOxxUOzP1g+e7jrzmFhwEFtyutsebndz4dnsOORBO/
   skZ/TadTVXpwCGz8YsO5WZKr8QwE6IbmkPUwy4OXIfNqf+2MLXwdmVger
   wrdhukh09Vt3MbIWcFD+sDtKOTD/bMlGnKNARS0WzVVXTD52wGC28/0VK
   Qzy8cjPCblkPaq7wWYYpgchvgzsqK5HCeZSfv5WwELCv+FaWQPl856Bem
   xSbkhksSX5IGlVG+C7/3HRKFGikeIuzarAnP0dHygmU3WP5z9IBaYYXC8
   w==;
X-CSE-ConnectionGUID: 55Bues75R66lI51SqNzWpA==
X-CSE-MsgGUID: f05onqC1QtKORIBmsb2QrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185671"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185671"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:07 -0700
X-CSE-ConnectionGUID: fJH8PBJTThuyg5ZJXORT/w==
X-CSE-MsgGUID: CqefsQRtS1S/rajCIyrVwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243649972"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:06 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 03/15] wifi: iwlwifi: mld: add UHR DUO support
Date: Fri, 15 May 2026 15:09:36 +0300
Message-Id: <20260515150751.c006eda0139a.I2b1b540c256d29b3b6af21f7eacbe1f549734e9f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E82A2550432
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36468-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

The firmware needs to know whether or not DUO (assisting) is
supported by the AP, and we should claim DUO support ourselves.
Implement this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 2 ++
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c       | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 09f869b5be0c..dd69687a4e48 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -556,6 +556,7 @@ enum iwl_link_ctx_protection_flags {
  *	of threshold
  * @LINK_FLG_NPCA: NPCA enabled
  * @LINK_FLG_DPS: AP is a DPS assisting AP
+ * @LINK_FLG_DUO: AP supports UHR DUO
  */
 enum iwl_link_ctx_flags {
 	LINK_FLG_BSS_COLOR_DIS		= BIT(0),
@@ -564,6 +565,7 @@ enum iwl_link_ctx_flags {
 	LINK_FLG_NDP_FEEDBACK_ENABLED	= BIT(3),
 	LINK_FLG_NPCA			= BIT(4),
 	LINK_FLG_DPS			= BIT(6),
+	LINK_FLG_DUO			= BIT(8),
 }; /* LINK_CONTEXT_FLAG_E_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index f29de029c709..7027bca249a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -698,6 +698,7 @@ static const struct ieee80211_sband_iftype_data iwl_iftype_cap[] = {
 			.mac.mac_cap = {
 				[0] = IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
 				      IEEE80211_UHR_MAC_CAP0_DPS_SUPP,
+				[1] = IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
 			},
 		},
 	},
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 3c1825ba2b86..4ac2740dd8a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -347,6 +347,11 @@ iwl_mld_change_link_in_fw(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 		    link_sta->uhr_cap.mac.mac_cap[0] &
 				IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP)
 			flags |= LINK_FLG_DPS;
+
+		if (link_sta->uhr_cap.has_uhr &&
+		    link_sta->uhr_cap.mac.mac_cap[1] &
+				IEEE80211_UHR_MAC_CAP1_DUO_SUPP)
+			flags |= LINK_FLG_DUO;
 	}
 
 	cmd.htc_trig_based_pkt_ext = link->htc_trig_based_pkt_ext;
-- 
2.34.1


