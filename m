Return-Path: <linux-wireless+bounces-33122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GG5MvDxsmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:03:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224332764A0
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA867301B700
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427CA39A040;
	Thu, 12 Mar 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CMgp+OJD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EB39020A
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334864; cv=none; b=nnstchLnqHJVisirEclDs9EZbT368L+gFqPPBVfC+TwoQVYtCOMeyRp3UOdt2NwuirRc1YmzljB3D/zX6Tn0pYWLoS8XnpD7yFCfij2axTq54qg7xwLtcuGUsv4qhx+vmTLV4p85v5/8xYxcbhAl+5a+LeK+EQLp4J9Bn/GeTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334864; c=relaxed/simple;
	bh=dQrP21XeCUe5KAVZOE/kb7roW3sCZoMge60mBQE1tns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLhBJXCwVdnoI2jR9gQ1x2WEzuOpuLQYXXZlPc7MH/kfbm7HbVSDahBkMzehNttRmySUohddJLVOh+hFVR+7RJBpzEJEq/CJ4UMwzl6rkg14cfMLlZxYIUYzzBkzUrugCn3kR3PzCTg7EYgiVXLXmdOgqE1+UDd6Zfnm3LGMAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=CMgp+OJD; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ACC186C007E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:00 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 0EF8913C2B1;
	Thu, 12 Mar 2026 10:00:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0EF8913C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334858;
	bh=dQrP21XeCUe5KAVZOE/kb7roW3sCZoMge60mBQE1tns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMgp+OJDNyNnhoK73+prvH2zBf3TfytjOnzuJHB16gSuBUhRfxGxtX0rK37o+Sz7n
	 UG7SZvjtTX8R8cRfwvOPbI9EpGV3C5GZFjy2N3mVW11WMp4ZXIoaa8Fv7T1dgIJbBS
	 3CCDd2h6BxhHXwcuk6kIEb1rM5NVcwbYHDj2xkjE=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 01/28] wifi: iwlwifi: mld:  Check for NULL before lookup.
Date: Thu, 12 Mar 2026 09:59:59 -0700
Message-ID: <20260312170026.285494-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260312170026.285494-1-greearb@candelatech.com>
References: <20260312170026.285494-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1773334861-mh_LBtroxhYP
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1773334861;mh_LBtroxhYP;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33122-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[candelatech.com:dkim,candelatech.com:email,candelatech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 224332764A0
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


