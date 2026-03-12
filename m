Return-Path: <linux-wireless+bounces-33142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BDIEBjysmlaRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741327651D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B9EF306BF2D
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43997396B85;
	Thu, 12 Mar 2026 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="pi4sX+d1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B23FBEBC
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334869; cv=none; b=Cgnahi8EmoLe/cwERETTSsz8YbSO7Nisg3ZL4YbxYIG3ac4eQn5RQ+YaJV7ceVksidojKC8gfdrJjoXz/kpJkIoEnWrdua8QBEtCohphDmj6cu2eiysj5Smg4IOsNCUaIhpkZBzpqvUU393Umq0qOL+M/dWKbIXfaEB8z8P4qTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334869; c=relaxed/simple;
	bh=VCaTw+3e5e9i/Vs/TIQN7VI6oLLEjVwiS3ZnSP7M4Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjlWT8Boe98qsXvYbwY+obbYjg/v48KGzmZ7Ic7mQvIFyWwBJkm9W53UosHE7mGQNiIT3pAmDq6v4YW+nQ9SELsAci3ueEdI7GOEyb1kUQeFRJKWRj5aosjK6W5pcOeJzhUTB/lJjh+EBry0QRh24bY7uTf4jpZMaOI9VGYDw+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=pi4sX+d1; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 80DE740008D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:01:03 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id DEBF313C2B1;
	Thu, 12 Mar 2026 10:01:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DEBF313C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1773334861;
	bh=VCaTw+3e5e9i/Vs/TIQN7VI6oLLEjVwiS3ZnSP7M4Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pi4sX+d1FZz8DjHdEhTTd1JFf0kiplcFbB7IOCN/D4WTA9NKs8C/m9APT4CE/l8Rm
	 31LUy5NnDTgUDSWexuc7mOYYo6BJdAX6Dis/a/H2HNDHfgTePibSC7nN/69GKvMn3A
	 PZU6FxHR7eVObbq8F6TfJegzrrZEaNjgpuhjv8PQ=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH wireless-next v2 13/28] wifi: iwlwifi: mld: Remove warning about BAID.
Date: Thu, 12 Mar 2026 10:00:11 -0700
Message-ID: <20260312170026.285494-14-greearb@candelatech.com>
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
X-MDID: 1773334864-ByhRCRTGuIDD
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1773334864;ByhRCRTGuIDD;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33142-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:mid]
X-Rspamd-Queue-Id: 1741327651D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ben Greear <greearb@candelatech.com>

It seems to be expected behaviour, and is seen fairly often
in testing in adverse conditions, so make it a one-line log
message instead of WARN splat.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index a757077b0a7a..23d55374ef8a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -216,10 +216,16 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 	if (baid == IWL_RX_REORDER_DATA_INVALID_BAID)
 		return IWL_MLD_PASS_SKB;
 
-	/* no sta yet */
-	if (WARN_ONCE(!sta,
-		      "Got valid BAID without a valid station assigned\n"))
+	/* no sta yet.  This happens fairly often, don't WARN_ON about it. */
+	if (!sta) {
+		static bool done_once;
+
+		if (!done_once) {
+			IWL_ERR(mld, "Got valid BAID without a valid station assigned, will not log again.\n");
+			done_once = true;
+		}
 		return IWL_MLD_PASS_SKB;
+	}
 
 	mld_sta = iwl_mld_sta_from_mac80211(sta);
 
-- 
2.42.0


