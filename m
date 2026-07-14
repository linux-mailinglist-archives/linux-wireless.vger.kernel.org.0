Return-Path: <linux-wireless+bounces-39031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7oCHE80bVmoMzQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:21:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A145F753D8B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 13:21:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=kI+chnvN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39031-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39031-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA473032755
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8038A706;
	Tue, 14 Jul 2026 11:20:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16734377559
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:20:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028031; cv=none; b=tEb9KLHviHDGJakFY8G5QPFdiU808kNmkcNfsF4uciCCoD/T9kUc8M4cRHzX1Kvz4JGSAuzEnJxc6yd3cVj25TXE26RDz1E564x/OzCmjLg4OMvP0UHpRsTS3W9mFBk24tIbDx96kAVrQRfwnpMTVlFbudGQA8q6+3lYCdiGPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028031; c=relaxed/simple;
	bh=7m8eHOjRd/4FqL/Zlmke/tT/sSbyNWV/A5mDFK8iu8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WIbjs7EEj8VmlJIJNWQTUOTDnG8TUMbqr3JTYJTnKkcAgbfp331wiW85kfKW8c61Nis6GT8SKUSl4OMzQnlg4S4+P12geLhm/D1MHOLpLNfpwTbtoayCGw02PnDazibnhapIHXaByV/541rteukZ/yAv7mf45udaZro8rYfO0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kI+chnvN; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028030; x=1815564030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7m8eHOjRd/4FqL/Zlmke/tT/sSbyNWV/A5mDFK8iu8M=;
  b=kI+chnvNJD5BT0mPnRmmduRIAs5aMhr2SyYYdo78wteWE6Qu559mymk3
   CShze+cLzti8G5OfJRxL1DBLrhwX0cthqZkhdQMUWgF9c++uaXXuUC1AJ
   YcwXLVvtc+xwTooKQqRwT+kmBOsqjFQbRY0fak7ErzAulayxtVOVG5i9x
   NYdoAKnVXjCQmXg/mrovjIHIDG2fXciL18st3rncZq1HN0mXI4SD+YqiI
   dBKPqgj4Hwnz9l0ztkwr2+Y0hlbjoQID4fXaKXhWv8etGRX87zfMmjrD/
   zkE1SR8iG9/vKqm6GK42MFY8Imy8C/6usXZNTooMfj7oLo15WkPpPX6rW
   g==;
X-CSE-ConnectionGUID: lqaLmsa6RAKS0aHs9poGOQ==
X-CSE-MsgGUID: +Jyg5LUvR7S8vbaQTaA+Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102200301"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102200301"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:30 -0700
X-CSE-ConnectionGUID: 5BsAcuFvQ8C8Yt1PCLp2vA==
X-CSE-MsgGUID: AnIFIw+sSTaoLka4wer2zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280250153"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-fixes 04/15] wifi: iwlwifi: mld: don't parse a notif before checking its length
Date: Tue, 14 Jul 2026 14:19:53 +0300
Message-Id: <20260714141909.c2f644919011.Ic579e9935b92a674c96ccc44713140b5b4bc5d10@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
References: <20260714141909.fdf31f494f1c.I70d01ed2023f6584fb23ea8ab344a93d222cc4c0@changeid>
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
	TAGGED_FROM(0.00)[bounces-39031-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[changeid:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A145F753D8B

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

In order to compure the size of the iwl_mcc_update_resp which has a
variable length, we need to know the number of channels.
In order to read the number of channels, we must first check the
payload is long enough to read at least that.

Add this check.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
index 8502129abe49..830c251f43af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
@@ -18,9 +18,15 @@ static struct iwl_mcc_update_resp_v8 *
 iwl_mld_copy_mcc_resp(const struct iwl_rx_packet *pkt)
 {
 	const struct iwl_mcc_update_resp_v8 *mcc_resp_v8 = (const void *)pkt->data;
-	int n_channels = __le32_to_cpu(mcc_resp_v8->n_channels);
 	struct iwl_mcc_update_resp_v8 *resp_cp;
-	int notif_len = struct_size(resp_cp, channels, n_channels);
+	int n_channels;
+	int notif_len;
+
+	if (iwl_rx_packet_payload_len(pkt) < sizeof(*mcc_resp_v8))
+		return ERR_PTR(-EINVAL);
+
+	n_channels = __le32_to_cpu(mcc_resp_v8->n_channels);
+	notif_len = struct_size(resp_cp, channels, n_channels);
 
 	if (iwl_rx_packet_payload_len(pkt) != notif_len)
 		return ERR_PTR(-EINVAL);
-- 
2.34.1


