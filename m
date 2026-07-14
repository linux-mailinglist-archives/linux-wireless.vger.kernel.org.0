Return-Path: <linux-wireless+bounces-39051-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MhuAGEAfVmrfzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39051-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:36:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A64753F46
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:36:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=WUT+WJPV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39051-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39051-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 575413149EEE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39B181334;
	Tue, 14 Jul 2026 11:33:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B9270552
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:33:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028798; cv=none; b=XsCcQedKL+zfHEPy5sP1IsJ42+/ZqB4PQS45KlRgKuZU8a1iHZN1hMfLam6voCKS5+c08iPMYCNfjny7MQTSZSIDLTbnAEvTgCKK8Eu5GmMt1fF5pCD765mse600qLSHnMHgzcmrHvP4NEVbTj5zoPRZ1pf74DyeMaUhufA889U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028798; c=relaxed/simple;
	bh=1HvxOKRoC2RgvIRDOh1hcHySWgqC2hYScovbLBQf7MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBNl8nGZY4ty1Hgow8df544uB+c9gwxnOcmXB75JM8oPZ11fzhKnZKPujzWJIN3m8j1dwsTCktyCQHgywR+i2aYqooVSiLGiYZmhNKwixNCF18VgXp05WVQ3X4xMMgITckuCTfHsuZspRBDW+3sDyErIFdpQzzw+xkdGJuFB+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUT+WJPV; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028797; x=1815564797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1HvxOKRoC2RgvIRDOh1hcHySWgqC2hYScovbLBQf7MM=;
  b=WUT+WJPVOXqeHcmQVRVE9orDz+aPm1sSCnKcqVVmPIxT1mXLg9lOnuM/
   hZkirGXsbnhCb4Lw0FlGQPt3JMmRMKaoE9BVa1LzjKHtdKkjNyY7lwaUM
   hB3ehzC4EEag4/dP+NYgl3+de94ccQaueqnU4XJmk8fFpIe9EHva7zDy0
   hXXC2MqkwzXBsWLEZrA2/7RYTvygRiujwlzt/5bqeo/RVDxhxsRraYF/H
   18lI153zMu40tJmt7qgHNwkTGxEoFLHSzhwZLQEaMnFVqG6uslSdtVcD0
   eKDX1kQK5RKYNr11AAY/AunM7ObCiMlnAHiWsWOvWlrRYH2L1qhiqSkgp
   A==;
X-CSE-ConnectionGUID: +z6s8gSASNapAGfufGIePA==
X-CSE-MsgGUID: XH0wMTddRyqpUsgL26AS5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88469600"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="88469600"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:16 -0700
X-CSE-ConnectionGUID: zR7D9USPTzKIlcgrnNhKMw==
X-CSE-MsgGUID: wYoVj/NjS8+k2dIssahf5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="255882947"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:33:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: validate D3_END notif size
Date: Tue, 14 Jul 2026 14:32:35 +0300
Message-Id: <20260714143119.db2df8b6b6bb.I6163bbdf433379bf1dbf9eb46fb9562892217bd7@changeid>
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
	TAGGED_FROM(0.00)[bounces-39051-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: B8A64753F46

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Check D3_END_NOTIFICATION payload length before reading notif->flags.
On short payloads, mark notif handling as failed.
Avoid out-of-bounds reads from malformed notifications.

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index 458a668ba916..b5fed6090340 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1449,8 +1449,16 @@ static bool iwl_mld_handle_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	}
 	case WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION): {
 		struct iwl_d3_end_notif *notif = (void *)pkt->data;
+		u32 len = iwl_rx_packet_payload_len(pkt);
+
+		if (IWL_FW_CHECK(mld, len < sizeof(*notif),
+				 "Invalid D3_END notification (expected=%zu got=%u)\n",
+				 sizeof(*notif), len)) {
+			resume_data->notif_handling_err = true;
+		} else {
+			resume_data->d3_end_flags = le32_to_cpu(notif->flags);
+		}
 
-		resume_data->d3_end_flags = le32_to_cpu(notif->flags);
 		resume_data->notifs_received |= IWL_D3_NOTIF_D3_END_NOTIF;
 		break;
 	}
-- 
2.34.1


