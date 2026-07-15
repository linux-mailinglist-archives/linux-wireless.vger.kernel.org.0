Return-Path: <linux-wireless+bounces-39142-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pfXsNwWDV2rTUAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39142-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:54:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC175E5F6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=RZoHexWm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39142-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39142-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EA5030C4222
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C02478874;
	Wed, 15 Jul 2026 12:50:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64993477E42
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 12:50:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119832; cv=none; b=HdRV0pL9Yki79ahIMjB/Iu3ZWOU5SUAPesboe8qMWkI/asM31cNxaixcxkg1pYIVNFwWcMvJgHoN6Pa7fO7NlI422g9RRjIPNEOiuD9TMF/hQnJJ73BmErcaJUFgz2X1gEE6Y1dG7hU7EFehxcs+T/5yDAYwxchyBODiJ2Wuhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119832; c=relaxed/simple;
	bh=8IeHrcRtT77XznVLVnJwf8bqeVBCkYwCUDz3/xmCsjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCGI2Wu4i4a9mR7e9Xl5AWWmrmRyyj5TPT1slrgoPrb1KbqAmThpOknc/M3FDmAvMpEpcABvECsyrL0lPxQv2n3sM4tcN4IySaUCBGpbFFgierhyWbhRQzZHJ8SAMca1doJ1LftjU5I6CC6H0gEEPP6GzlFRMDdwTnSgpLPBT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZoHexWm; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784119828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=owMox2T0drHzdab6F2aSdDlHCCRxP5tdtmtldpaxuTo=;
	b=RZoHexWmVhpGGZKuPWPBzxDKx1vBVesPb+QpkXf+poiMHpN08Cc/Yd3cj5AoOG+XHOseVl
	RwuRnbdNny8MiMNyk+TLW9CZTFZ/zDb1PcyCH6pCB+05abF3YRnjeNcR0ochTTUbKN9xXk
	o+1WM2X2Gf60ADlpsle/6p5NXkMrGPc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-X86IZ6kWOuuUYG2ks2quDg-1; Wed,
 15 Jul 2026 08:50:24 -0400
X-MC-Unique: X86IZ6kWOuuUYG2ks2quDg-1
X-Mimecast-MFC-AGG-ID: X86IZ6kWOuuUYG2ks2quDg_1784119823
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0807E180059B;
	Wed, 15 Jul 2026 12:50:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB21D180036E;
	Wed, 15 Jul 2026 12:50:19 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2 0/3] ath11k/ath12k: implement TX flow control
Date: Wed, 15 Jul 2026 14:50:13 +0200
Message-ID: <20260715125017.277242-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39142-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ABC175E5F6
X-Rspamd-Action: no action

This series implements custom wake_tx_queue operations for ath11k and
ath12k drivers to prevent hardware ring overflow issues under heavy
traffic.

Without proper flow control, both drivers experience -ENOMEM errors
("failed to transmit frame -12") when the hardware TCL ring fills up.
Additionally, ath12k can hang under sustained high throughput. These
issues are more commonly observed in VMs with PCIe passthrough but
also occur on bare metal systems.

The implementation follows the pattern used in the iwlwifi driver,
checking hardware ring space before dequeuing packets from mac80211.
Per-ring locking serializes ring access while allowing TX completions
to run, preventing deadlocks.

Testing shows stable operation with eliminated -ENOMEM errors, no hangs,
and improved throughput under heavy traffic conditions.

Jose Ignacio Tornos Martinez (3):
  mac80211: add ieee80211_tx_peek API
  wifi: ath11k: implement custom wake_tx_queue with flow control
  wifi: ath12k: implement custom wake_tx_queue with flow control

v2: Address feedback from Zhi-Jun You:
    - Add ieee80211_tx_peek() API in mac80211 to peek at the next frame
      without dequeuing, enabling accurate ring selection before dequeue
    - Use get_ring_selector() on the peeked skb to determine the exact
      target ring matching dp_tx, fixing ring mismatch on multi-ring
      platforms (ipq8074, wcn6750, qcn9274, wcn7850)
    Address feedback from Tamizh Chelvam Raja:
    - Fix ath12k radio assignment: obtain ar from txq->vif through the
      arvif chain instead of ah->radio flexible array
    Move CRASH_FLUSH check inside the TX loop 
v1: https://lore.kernel.org/all/20260710155443.1761760-1-jtornosm@redhat.com/
--
2.49.0


