Return-Path: <linux-wireless+bounces-36305-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF7NLr27AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36305-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:33:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E0A51A20E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0916B3066794
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B233EAEC;
	Tue, 12 May 2026 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yo9IOdj2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CF3876CF
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563419; cv=none; b=J8+BczW+aWOK/Y+D84aq1svtk8N4R59A8OJdCSu+7aSMj3OvlznLGg/gQVEIfbElXvCHvRcHl0v6dhzhzdVemY8LSZHPf0feYeETy1stvuAoQ1xeeaVcg4DGpYce2sjrONxiSFOpeT9lelqkkyj5OCb5A0nTvaQJgHx/8SCtaJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563419; c=relaxed/simple;
	bh=PVgoteBG8r9dQNMGKurp9Tsta/R44wb+bpaY/S5CZ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VYDIBLyN4e7IKN6Ge1iBO7h4IG7TqV/t4g9P/oeGY2RFU1GRbFyawcDEBio1tuB9oariGAPdNae+FFj58QfYy+FflMS9dew+Ui8Hf0eUFMZEd18o+YhKyfaTok8rItvfbos2pZjer3DgMue/fnuBaTZv3XzxSnxSfE0hvh2kCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yo9IOdj2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563417; x=1810099417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVgoteBG8r9dQNMGKurp9Tsta/R44wb+bpaY/S5CZ5k=;
  b=Yo9IOdj2gj2Xaj6BnXp7N6I4V7eAKgyaLvtTsyrBUDkWsX+AI2/7Desy
   zZkmQyLjuYbs10IOSE3QO/Hg+xhx6z/hp/1G9vGCB7jONm02dz7/RCW70
   dxyia7mSEobfhN8IKo0blsAMvLq3sNrnLlvfPVeQRYpDOL4uPg0QW1e/a
   UVKIgHuZ8Emb1xnkwcWt6KDlvtANITlpj24fBoVHRji8uaZI0/W7eNwdS
   hcRmdqbvPCQnoKxk1P430zKu75WTubWymy3PygVgjmBaLVYsPPV1nLuws
   eWhwNjMOiZwPMsHt6mMOisPbdoZeOPxgBjzf97wwiYZRAkA/zK6SQpVKW
   Q==;
X-CSE-ConnectionGUID: mPIbkPnMQeC5RQq21ipUIw==
X-CSE-MsgGUID: 8LsXZ4idTbyuNX6HxTEd0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495105"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495105"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:37 -0700
X-CSE-ConnectionGUID: 6qL9eFjmRRmEz8cPyV8S6Q==
X-CSE-MsgGUID: gKpMwhs1T3GpKWLStjSc5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187592"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: stop supporting TLC_MNG_UPDATE_NTFY_API_S_VER_3
Date: Tue, 12 May 2026 08:23:06 +0300
Message-Id: <20260512082114.36dac3f3589c.I8aee18f323c5f3bbcc02dfc2e0c08be6b8943986@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5E0A51A20E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36305-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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

The oldest core iwlmld support is 101, which has version 4. Remove
version 3

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/notif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/notif.c b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
index fc6550bea155..4e9f3768c381 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/notif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/notif.c
@@ -309,7 +309,6 @@ CMD_VERSIONS(tx_resp_notif,
 CMD_VERSIONS(compressed_ba_notif,
 	     CMD_VER_ENTRY(7, iwl_compressed_ba_notif))
 CMD_VERSIONS(tlc_notif,
-	     CMD_VER_ENTRY(3, iwl_tlc_update_notif)
 	     CMD_VER_ENTRY(4, iwl_tlc_update_notif))
 CMD_VERSIONS(mu_mimo_grp_notif,
 	     CMD_VER_ENTRY(1, iwl_mu_group_mgmt_notif))
-- 
2.34.1


