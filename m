Return-Path: <linux-wireless+bounces-37817-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8iHVJTDgL2pIIQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37817-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 13:21:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0D685AF5
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 13:21:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fnqxDsqy;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37817-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37817-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D13B30098BB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486033E44F6;
	Mon, 15 Jun 2026 11:21:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0263E4519
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 11:21:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522479; cv=none; b=Qm4wKlavDtI5fSn8VPkdBgTaoFgp1dnNIFEczG1fNWCjHckMkXgFOmMgdihv/wCnXdL2I5R/YfE6PB5AN5vS2AWGADtdzn2PZH141/DblIXjSD7iGqFWiiP2uvZL7T45hXzBUw74WP4gtVvZpX/mQpPtgHNBmCggO/hLgul5U3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522479; c=relaxed/simple;
	bh=5U6hRboFmaA2jOHsVIjiXeUUhlJIyvz1/OH/G0G51GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/CmTRRr29bt5XAHlaM4lzuMpFQWRBaZadPhhJg8icelmNun67QJTmIJlSK5Xxc2wIkU7fGy9RQgLKxOehs+BdakCsbrk5gJWyFaV2rwxW2EwvhNjkHXfQhKEOcJn47oW05w2YVeZOvw/MR4ebzyMLwUeFZIhPS9xRIZEPtFj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnqxDsqy; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781522476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B6WQlP4LsP1BC2/D9rOcFasJgBtWxq+pQN34qv7/LvI=;
	b=fnqxDsqyZioOP3QBSVDgK6aLnZwYY2HgIrinuGQ58rWjjuJBSQO3oX/8auOE7tTyhF91+O
	+ZupOGMlzedeR/E4/EtQW1lslGCnDLfCpLxo7NgH0kqy45bQdz1K/0/M5UumgponrqWj+n
	1JW8gGXbTpOmezD8hvNKCqxvpzRwAx0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-jMW5aiWeMYq1zjUJVUtulQ-1; Mon,
 15 Jun 2026 07:21:11 -0400
X-MC-Unique: jMW5aiWeMYq1zjUJVUtulQ-1
X-Mimecast-MFC-AGG-ID: jMW5aiWeMYq1zjUJVUtulQ_1781522470
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F239E19540D3;
	Mon, 15 Jun 2026 11:21:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.61])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD5291774;
	Mon, 15 Jun 2026 11:21:06 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ath12k: fix NULL pointer dereference in rhash table destroy
Date: Mon, 15 Jun 2026 13:21:03 +0200
Message-ID: <20260615112103.601982-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	RECEIVED_SPAMHAUS_CSS(1.00)[54.186.198.63:received];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37817-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,10.30.177.95:received];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FE0D685AF5

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

The NULL check approach was chosen because the rhashtable pointer
serves as the initialization state indicator. The init can fail at
various points, leaving some components uninitialized. Checking the
pointer directly is simpler than adding separate state flags that
would need synchronization.

Fixes: 57ccca410237 ("wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base")
Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
Cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2: - Use guard(mutex) instead of manual mutex_lock/unlock with goto in
    ath12k_dp_link_peer_rhash_tbl_destroy (suggested by Jeff Johnson)
    - Add rationale paragraph in commit message explaining why NULL check
    approach was chosen over state flags
v1: https://lore.kernel.org/all/20260604071032.659009-1-jtornosm@redhat.com/ 

 drivers/net/wireless/ath/ath12k/dp_peer.c | 7 +++++--
 drivers/net/wireless/ath/ath12k/peer.c    | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c b/drivers/net/wireless/ath/ath12k/dp_peer.c
index a1100782d45e..ab3e3e107782 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -274,11 +274,14 @@ int ath12k_dp_link_peer_rhash_tbl_init(struct ath12k_dp *dp)
 
 void ath12k_dp_link_peer_rhash_tbl_destroy(struct ath12k_dp *dp)
 {
-	mutex_lock(&dp->link_peer_rhash_tbl_lock);
+	guard(mutex)(&dp->link_peer_rhash_tbl_lock);
+
+	if (!dp->rhead_peer_addr)
+		return;
+
 	rhashtable_destroy(dp->rhead_peer_addr);
 	kfree(dp->rhead_peer_addr);
 	dp->rhead_peer_addr = NULL;
-	mutex_unlock(&dp->link_peer_rhash_tbl_lock);
 }
 
 static int ath12k_dp_link_peer_rhash_insert(struct ath12k_dp *dp,
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


