Return-Path: <linux-wireless+bounces-39069-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JqoXBd9CVmqc2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39069-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE475588D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:08:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Whxpqp5z;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39069-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39069-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB36D31D5C2B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9547CC72;
	Tue, 14 Jul 2026 14:03:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E843F8C1
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037795; cv=none; b=Z04YbciEFHHXCHyZO3Ir9dPxCrK/4o4SI7opOnt7HLALISe07TQkeaMnIvjWyGKMZ5DFw6Vv+0x3t+4x+NZARLAIg1dzj1gmQRgAhmbTNRfPgx5uEd+8+Js3wCFWdzKgZHwrLBw0YKgqJ2R1J/TKhBgOKAOf0PxGLs7tk+h5o7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037795; c=relaxed/simple;
	bh=1HvxOKRoC2RgvIRDOh1hcHySWgqC2hYScovbLBQf7MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oCfeDjyqbcw1OHtedW4i5iike8S16SqObx/XFJbDQekVoyWJdkL9yBUvOTVEwDIu28F9P/RJco5nTV0eroEqN9d+ueymdnC/C8bLrg2oLl77x2ueWEM9ONF3gInaLMUUjpeX9qFJZYCOO/nZv28t1yNV1l8Ze3D6rju7IGi4jzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Whxpqp5z; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037793; x=1815573793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1HvxOKRoC2RgvIRDOh1hcHySWgqC2hYScovbLBQf7MM=;
  b=Whxpqp5zwafGFiiNFsRBbkMfRUn0HoCBsEsXQMdRWMGXXeOWNHyvpYUs
   4G2XuX1dIZmAzJsPTEl+J9pv5oGsahqol5CNIYJgxMts0aJFoCdNbbb1Y
   xMiP+piIWKbQiDr/N9v5e/OBRG33pFUsOysUwmJMr5kjWFNmphwd8GH0P
   UR38XXQLgaLSJpaHM/Mz53FplTKwx3D1xSVMpxMzoH3qgyh9BecJhoF6w
   GE3MWhoUsJU78o+To3QUfeGMb1Q3BRSxgG8PpmAwkxR0QO0uwIqzEWMR3
   Mf1duDBuL9Gik7f+mjQdcbX/Vhs87lEijmtv1MeMZtYJyUnKIS1bzpZL6
   Q==;
X-CSE-ConnectionGUID: XdsIOfFST0Cbet2bBQ5KYg==
X-CSE-MsgGUID: KQ0Arsx1QImOCeAMt/BJRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855118"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855118"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:55 -0700
X-CSE-ConnectionGUID: rEnHxhCbTECy0wgZZl03HA==
X-CSE-MsgGUID: DRTkyj4ZRT2K+LfLIfVqnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737881"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 09/15] wifi: iwlwifi: mld: validate D3_END notif size
Date: Tue, 14 Jul 2026 17:02:12 +0300
Message-Id: <20260714165826.db2df8b6b6bb.I6163bbdf433379bf1dbf9eb46fb9562892217bd7@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39069-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:dkim,changeid:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42DE475588D

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


