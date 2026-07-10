Return-Path: <linux-wireless+bounces-38854-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vQz9EtkVUWq//AIAu9opvQ
	(envelope-from <linux-wireless+bounces-38854-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 17:55:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3236C73C67F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 17:55:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BGgUvZeV;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38854-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38854-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53C88300253B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 15:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BDC3FADFD;
	Fri, 10 Jul 2026 15:54:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB63C4154
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 15:54:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698899; cv=none; b=pCsbLtwPQI7YnDHuvIwQIDm2rlAmROnPIitmmG1W+YNK3FJ5ILcXxMhqouyMgj/RnKNkxpU1CgC5mzbxbuQd2naHzKgAAp8UZfq//Qmo6I6X2Klyq+3xSQezLF8gWbBehvNXV8mICCeyxg3+virYPjDrbuo8v7H3ffWe+aD6uRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698899; c=relaxed/simple;
	bh=PT2IfD69KHWtSfNcq3axdvI9lUVielXn1p9BUxgRi2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqkBP5Qp6J6AVCi01Fi2py0iwv5QCJXPt0CemIX6JNemm88X74wA+TW1ZYqZUumD6OZ6Omm3B+VsOin2qFc+znHRf7SE6bXRlcUeUNLlHQpUnzdTcqYJOz4CqpoFzgcV5OPEK8dcDgf/dYGK3L2VRyjiFlLLAZVepIcRRuIDn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGgUvZeV; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783698897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bjiyv0lirhfy7+vrSMfYOoDKtgGzU0tRvcCRuYupkas=;
	b=BGgUvZeVPxLDIg7u38qmYapS1cyM+hC9yEpPTEz9vJkSlbwVxUe3S6gb9stAOEjLMpQtcS
	OZi5WEQaMi6a9y2zQf2BtEUgbUEW+SH+h4Tx+799f104GW1+WCnsiyjI2nirHRdmDcqlEz
	HEF9wayowkgDfIn3o0TukPGZhP46NIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-HavAsTw3O3uLypCFXCWu5Q-1; Fri,
 10 Jul 2026 11:54:56 -0400
X-MC-Unique: HavAsTw3O3uLypCFXCWu5Q-1
X-Mimecast-MFC-AGG-ID: HavAsTw3O3uLypCFXCWu5Q_1783698895
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4308E1955EBC;
	Fri, 10 Jul 2026 15:54:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE9591800480;
	Fri, 10 Jul 2026 15:54:51 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH 0/2] ath11k/ath12k: implement TX flow control
Date: Fri, 10 Jul 2026 17:54:41 +0200
Message-ID: <20260710155443.1761760-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38854-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3236C73C67F

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
Per-packet locking serializes ring access while allowing TX completions
to run, preventing deadlocks.

Testing shows stable operation with eliminated -ENOMEM errors, no hangs,
and improved throughput under heavy traffic conditions.

Jose Ignacio Tornos Martinez (2):
  wifi: ath11k: implement custom wake_tx_queue with flow control
  wifi: ath12k: implement custom wake_tx_queue with flow control

 drivers/net/wireless/ath/ath11k/dp.c       |  1 +
 drivers/net/wireless/ath/ath11k/dp.h       |  2 +
 drivers/net/wireless/ath/ath11k/mac.c      | 49 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/dp.c       |  1 +
 drivers/net/wireless/ath/ath12k/dp.h       |  2 +
 drivers/net/wireless/ath/ath12k/hal.c      |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 50 +++++++++++++++++++++-
 7 files changed, 104 insertions(+), 2 deletions(-)

-- 
2.54.0


