Return-Path: <linux-wireless+bounces-33003-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJRJF8f1sWl7HQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33003-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:07:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E40C426B251
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 00:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60373069AD7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 23:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB63A169E;
	Wed, 11 Mar 2026 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="aVuilHIU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9194390C8B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270467; cv=none; b=vAPUPqsLkb47gdOzaUWDJwHzPiytwaQREGBzPPYSiHLb/Lkc8ZmSNRm4pL01KdJn6dgtOOYGr+LqcNtnn4NCLknF6pL7bZF3Q9o2reOwpP+fCR+39EZG8bbr+EkA4MZY+aiCtDiMP2Wn5wMnGLeLKLwI+o/95uGSL30l/jjFVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270467; c=relaxed/simple;
	bh=dQrP21XeCUe5KAVZOE/kb7roW3sCZoMge60mBQE1tns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0xraiwKWT/NLojuBqZ+50DYMpFgWtz9Mk876JCAyeRO4lOK2hSc5W3gzOqdbUbLNZ8tnfeumb2SsFUqJYugA8dRjy5H+eKs2Zd8LHxpiV/t8j2+S/ZmfOx32cCyzEFaXM0EXKkC5AWJljBaMWuVnYKJuDSOl9e1fsYQAEsubWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=aVuilHIU; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0B35F2C0080
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:07:38 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 53A3C13C2B1;
	Wed, 11 Mar 2026 16:07:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 53A3C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773270456;
	bh=dQrP21XeCUe5KAVZOE/kb7roW3sCZoMge60mBQE1tns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVuilHIUna1l0vbJLP0ZBjoHx3flkihi2FXn7cPAkVDQiA3p8Ug9sK1xx2rvBZLx/
	 1gRW1q3hm1O2+Iss4hiC4N2CdnXMivIfi7f8rs86sBQdWTn0TX2qZ4rU60AcFFJ5jq
	 DoTLQc0IqBe1GnN3Ww7OHo39+FhmqPwe0V9ptqIM=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next 01/28] wifi: iwlwifi: mld:  Check for NULL before lookup.
Date: Wed, 11 Mar 2026 16:07:03 -0700
Message-ID: <20260311230730.163348-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260311230730.163348-1-greearb@candelatech.com>
References: <20260311230730.163348-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773270459-Uk0_ybx3u53l
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773270459;Uk0_ybx3u53l;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33003-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E40C426B251
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

Do not call iwl_mld_sta_from_mac80211(sta) unless we have
verified sta is non NULL.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index 3bf36f8f6874..a757077b0a7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -194,7 +194,7 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 	struct iwl_mld_baid_data *baid_data;
 	struct iwl_mld_reorder_buffer *buffer;
 	struct iwl_mld_reorder_buf_entry *entries;
-	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct iwl_mld_sta *mld_sta;
 	struct iwl_mld_link_sta *mld_link_sta;
 	u32 reorder = le32_to_cpu(desc->reorder_data);
 	bool amsdu, last_subframe, is_old_sn, is_dup;
@@ -221,6 +221,8 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 		      "Got valid BAID without a valid station assigned\n"))
 		return IWL_MLD_PASS_SKB;
 
+	mld_sta = iwl_mld_sta_from_mac80211(sta);
+
 	/* not a data packet */
 	if (!ieee80211_is_data_qos(hdr->frame_control) ||
 	    is_multicast_ether_addr(hdr->addr1))
-- 
2.42.0


