Return-Path: <linux-wireless+bounces-36423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOuCDjwmBmqmfgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:45:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D361F54675B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAB913027353
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EBF3A9618;
	Thu, 14 May 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyPGI2JM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13F39E9A0
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787895; cv=none; b=ckx3EbS8G6J1ymleLgKnHd1ksEUo5az+NQXL8NWog45Gxp4LcISTd340EAqXE/m1/bjXOjz1XvRkg7YqQfiJ8I82f6xJJL9fzUqEQFuQrLl9c6xxCUaj/EfA5DqMFDJPaUdCQMtgWqdOhrDDdfXXMeYiIXKsrMNfSAJqyeWFnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787895; c=relaxed/simple;
	bh=zM5rBB2IxBw1P8UNmXBzSsrFH3Fb246EKz5nYcGzce0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KnZfVqvnAQ8vSDC5UMBnmEPJADnuEmMb6MGLyVedNK1D8rX76DVKcVSIIP1DZhdPmipZN+N2Mw/daNWm5jqaflkUEHhJEM7+QgnxfcNcE1MeAwUjBmlfh2skmOZdg3vPBjeH1qziJ23r3Nv9kvx/VKBQhM0AzSrqVbkP5DlciC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyPGI2JM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778787894; x=1810323894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zM5rBB2IxBw1P8UNmXBzSsrFH3Fb246EKz5nYcGzce0=;
  b=XyPGI2JMD0xPPkUE1fPY8T1k8J/ZSjnTE1qSjWM4k1MiYSiBID8yc0gY
   9vAy2OptmH3+QlXIBzgMDPpBaKQQ6oadAhsmYDbXp+5yzgo6cpMS0BYcY
   gxot47pvjnOFAxpg+fLxHSZ0Q88M9ZK41WtO1bM/REqZTX0NgjXE0n+Q1
   t6gZCfkosCYaxu+rDdJbXf0PJiLONXFAUX0CBw6TyLCvYkM82ylh8Lr2W
   4l043+6FOOT5r3ttfNR+q5zU02RxDYA3CR10xxOQ6ReD4yI+OcAUgr0BM
   /s6HcZhuhAK3CHebwvGyjDERnQkn3x9bqZyOokL2oj0Ey6j9ad1w96nCC
   g==;
X-CSE-ConnectionGUID: pA5M9wRhSYy7S9bYPRq4rQ==
X-CSE-MsgGUID: VlXwzycSQG6JFErwma1kFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="83352579"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="83352579"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:54 -0700
X-CSE-ConnectionGUID: i+ZOzwWaQAWwhJx8EvxM0Q==
X-CSE-MsgGUID: 7wPZ3cOaRwOB2tviU63TYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="237616247"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 12:44:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: add UHR DUO support
Date: Thu, 14 May 2026 22:44:22 +0300
Message-Id: <20260514224230.c006eda0139a.I2b1b540c256d29b3b6af21f7eacbe1f549734e9f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
References: <20260514194434.401241-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D361F54675B
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36423-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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


