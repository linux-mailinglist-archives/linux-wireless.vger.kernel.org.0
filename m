Return-Path: <linux-wireless+bounces-31839-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IvFGnHHkGmqcwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31839-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 20:05:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B813CFDB
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 20:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 715FA301AF62
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Feb 2026 19:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BE02556E;
	Sat, 14 Feb 2026 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="UM8zGDq6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE21624C0
	for <linux-wireless@vger.kernel.org>; Sat, 14 Feb 2026 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771095918; cv=none; b=dyXs9ozaWCvlq623AgTFCkvImQl9evunM7rErc2SoktsMh6INmzpaUWuP6Mw/cK+U3iNgRb6w/XYbRipJNPd5pxSfIr+DleQVrGyPruhbR9M/s+mJ4+bLrkUMPVyJcGbyZuWQgbUzieYrRj9lJPreUYxYNHguN0IRc/IL19RRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771095918; c=relaxed/simple;
	bh=0XXaomUiQ1faQhzj3UNJvlWQCn7h4akqm8Q+a3lSYdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svJ3vSXJMaZu/KHvoSvIDLoTE1V4n0sVk1nPMvtKZdw8lJYTXCK+A3b5q8GR92DqVNuRS6jExLlZtTqPJYxl/0NxhPy3OfSZtr4xNs7M1osM3BAnXY8Gb/R07PeBYnPU7Qkf8GdlqaJz9ocyzKiwKFT+eaJNADr/oVvLJ9aaFVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=UM8zGDq6; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DE0C12C0078;
	Sat, 14 Feb 2026 19:05:14 +0000 (UTC)
Received: from ben-dt5.candelatech.com (firewall.candelatech.com [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 1B51313C2B0;
	Sat, 14 Feb 2026 11:05:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1B51313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1771095912;
	bh=0XXaomUiQ1faQhzj3UNJvlWQCn7h4akqm8Q+a3lSYdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=UM8zGDq6hvvi/vummtDGwkVLXTj/U1NWCTLq6j8yBmciNkCXIxw9NhIIxMWhQMC8C
	 WKO6tKP9WEDUsadCWYC0g3kMN2OWsQPWVUaGNqC7nFQCH/2LvjoftFog/7z4sPYXug
	 5dFMqwnXhTAV+i+SSETgtnbhVpUbtM7+kq0e6fDU=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: miriam.rachel.korenblit@intel.com,
	Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi: Clean dangling pointer in tx path
Date: Sat, 14 Feb 2026 11:05:09 -0800
Message-ID: <20260214190509.2098565-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1771095915-Z-fQP-uc-2Gh
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1771095915;Z-fQP-uc-2Gh;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31839-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE5B813CFDB
X-Rspamd-Action: no action

From: Ben Greear <greearb@candelatech.com>

If iwl_txq_gen2_build_tfd fails, we return -1, which will cause calling
code to dispose of the skb one way or another.  Remove any reference to
that skb from the txq entries so that nothing will try to access it
later.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c
index df0545f09da95..f6db315658764 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/tx-gen2.c
@@ -773,6 +773,8 @@ int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 
 	tfd = iwl_txq_gen2_build_tfd(trans, txq, dev_cmd, skb, out_meta);
 	if (!tfd) {
+		txq->entries[idx].skb = NULL;
+		txq->entries[idx].cmd = NULL;
 		spin_unlock(&txq->lock);
 		return -1;
 	}
-- 
2.47.0


