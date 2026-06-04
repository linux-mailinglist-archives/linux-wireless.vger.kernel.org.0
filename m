Return-Path: <linux-wireless+bounces-37373-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id af0JNPwkIWqv/gAAu9opvQ
	(envelope-from <linux-wireless+bounces-37373-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 09:10:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9922263D89B
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 09:10:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=JTNf3R8Y;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37373-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37373-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB7E13028ACB
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB82DE6FF;
	Thu,  4 Jun 2026 07:10:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801493DB332
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 07:10:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557047; cv=none; b=UmzH7NwkyKxceayMthKM8c1Sjknm15tecL+is9u0f3dC9HcxzzKYrBQM1ybHrHa1L1yox5+PkWstIKQDvrxs9Z96J6Xyvw5Yd27oCdBscmNDKuYEVUM/xxKdf4edabLatuF1WeX3/eP6PL5k2W3PfImvqG6nyFWUGlM9DUg9t2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557047; c=relaxed/simple;
	bh=7CmgCK+8i1RhMflFWXTqEzDGsuIRmXaOuuz+fr00HmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UbMTd5NAz0doCWPQ/epGWT1VnzF6KwdJ5Ap+z+WeiZ5MgiTSb1bKe3+rizaUXF9N0Jwm0ltangPmSQgm3b1s9U2AMNIxndIfpNNQtSGsjaEs4Csocxh3cF5XoYKfzxHEWnMSfi4uckTzrbIL78vW3RfxXEEx5mY+q9RA11NDOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTNf3R8Y; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780557044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TTx7iJcEYQPNF0fLP9iIlrZJ+hGEW1AJgAn2YYrO6Tk=;
	b=JTNf3R8YAuODDvPGSIHak4uYHxRZ7kfeqfwmJkjZFugpm/IGsN4kpIvba3kguXANF1wHV9
	SSMlZ+YxziZ85jtg2hgX8Gqwyza4f/wpUZrsak3t2krYIy5uX1hDf2cri2SHgcEvuh4nMI
	j+r0KtjVBH5dvnyQtEEYNL1PrmSdbBA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-2myNmU-MPgSRWm_ZsUO4mg-1; Thu,
 04 Jun 2026 03:10:41 -0400
X-MC-Unique: 2myNmU-MPgSRWm_ZsUO4mg-1
X-Mimecast-MFC-AGG-ID: 2myNmU-MPgSRWm_ZsUO4mg_1780557040
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D88FB19560AD;
	Thu,  4 Jun 2026 07:10:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 291A830001A1;
	Thu,  4 Jun 2026 07:10:36 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Thu,  4 Jun 2026 09:10:32 +0200
Message-ID: <20260604071032.659009-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37373-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9922263D89B

When unbinding the ath12k driver, kernel NULL pointer dereferences
occur in irq_work_sync() called from rhashtable_destroy().

Two hash tables are affected:
1. ath12k_link_sta hash table in ath12k_base
2. ath12k_dp_link_peer hash table in ath12k_dp

The issue happens because the destroy functions are called unconditionally
in cleanup paths, but the hash tables are only initialized late in their
respective init functions. If the device was never fully started or if the
init functions failed before initializing the hash tables, the pointers
will be NULL. The issues are always reproducible from a VM because the MSI
addressing initialization is failing.

Call trace for ath12k_link_sta_rhash_tbl_destroy:
 RIP: irq_work_sync+0x1e/0x70
 rhashtable_destroy+0x12/0x60
 ath12k_link_sta_rhash_tbl_destroy+0x19/0x40 [ath12k]
 ath12k_core_stop+0xe/0x80 [ath12k]
 ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
 ath12k_pci_remove+0x60/0x110 [ath12k]

Call trace for ath12k_dp_link_peer_rhash_tbl_destroy:
 RIP: irq_work_sync+0x1e/0x70
 rhashtable_destroy+0x12/0x60
 ath12k_dp_link_peer_rhash_tbl_destroy+0x29/0x50 [ath12k]
 ath12k_dp_cmn_device_deinit+0x21/0x140 [ath12k]
 ath12k_core_hw_group_cleanup+0x6b/0xb0 [ath12k]
 ath12k_pci_remove+0x60/0x110 [ath12k]

Fix this by adding NULL checks before calling rhashtable_destroy() in
both destroy functions.

Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
Cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/ath/ath12k/dp_peer.c | 5 +++++
 drivers/net/wireless/ath/ath12k/peer.c    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index a1100782d45e..38045564e223 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -275,9 +275,14 @@ int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp)
 void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp)
 {
 	mutex_lock(&dp->link_peer_rhash_tbl_lock);
+	if (!dp->rhead_peer_addr)
+		goto unlock;
+
 	rhashtable_destroy(dp->rhead_peer_addr);
 	kfree(dp->rhead_peer_addr);
 	dp->rhead_peer_addr = NULL;
+
+unlock:
 	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.c b/drivers/net/wireless/ath/ath12k/peer.c
index 2e875176baaa..80fee2ce68f1 100644
--- a/drivers/net/wireless/ath/ath12k/peer.c
+++ b/drivers/net/wireless/ath/ath12k/peer.c
@@ -444,6 +444,9 @@ int ath12k_link_sta_rhash_tbl_init(struct ath12k_base *ab)
 
 void ath12k_link_sta_rhash_tbl_destroy(struct ath12k_base *ab)
 {
+	if (!ab->rhead_sta_addr)
+		return;
+
 	rhashtable_destroy(ab->rhead_sta_addr);
 	kfree(ab->rhead_sta_addr);
 	ab->rhead_sta_addr = NULL;
-- 
2.54.0


