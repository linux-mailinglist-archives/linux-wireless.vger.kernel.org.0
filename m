Return-Path: <linux-wireless+bounces-38009-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1xjEGtuCOmq2+gcAu9opvQ
	(envelope-from <linux-wireless+bounces-38009-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:58:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DD6B742D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:58:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EJcxsHRE;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38009-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38009-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDFD43064049
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F402D23AE62;
	Tue, 23 Jun 2026 12:57:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC223E35F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 12:57:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219477; cv=none; b=fq2y4CeOTIWJ9CZlDkA6wDJmdUbyYXF6AsjEXGnzLJ00oYmbYxabQRzMa40vhhtCjYFxm6JTnXrVJn85pFqUo+Nhzdvc5Oucxpn+1MrvCMAV5rwaAgpG5vL3BpMB+nLdtX/4xysS52NWSCNz1TrcFqe2yyIjHt7dyMrymksVAmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219477; c=relaxed/simple;
	bh=m0c4tLuBDb8dVN7iShZ9BiQoIw7SYRkSb2UZsD6lR2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p96XK6x1rRzakATDHBnkd9aOqUHlCqEoPy+PYMJzUIyHRlPYbeP4vO7Nf7oTZ/cQzBudqBdb5afVcETw0LEqXGBxUtf4zPZrVVJxCYH/7WKko2B31Xz5XKw3Egftj953gPdD3pjfvudcieb984Q6ESURwxdMYWrkddTjEO3ndSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJcxsHRE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782219475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0c4tLuBDb8dVN7iShZ9BiQoIw7SYRkSb2UZsD6lR2k=;
	b=EJcxsHRE0IIMdRLcDM0Zk0Mj7Sxbn0HURMYUGBetcNKVi4Q58zWY6SRaXm8/9cZq8TdEg1
	7LbRYOjK3QDOWVpaHO06keCmRjMlOmdf+yHFFgeoDvBLrUDnn1PlNXzbyirpqYlKvmhICk
	EmPstzi/mEZdz6gKODdmq0e+KaYOwRs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-vj2Kf3YuNxC8J4DH6BZXUA-1; Tue,
 23 Jun 2026 08:57:50 -0400
X-MC-Unique: vj2Kf3YuNxC8J4DH6BZXUA-1
X-Mimecast-MFC-AGG-ID: vj2Kf3YuNxC8J4DH6BZXUA_1782219468
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAAB11955E8E;
	Tue, 23 Jun 2026 12:57:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F06618005A2;
	Tue, 23 Jun 2026 12:57:43 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: baochen.qiang@oss.qualcomm.com
Cc: alex@shazbot.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mani@kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Date: Tue, 23 Jun 2026 14:57:41 +0200
Message-ID: <20260623125742.1188945-1-jtornosm@redhat.com>
In-Reply-To: <5abb5812-cdd8-47d4-b5a0-33f7351589ea@oss.qualcomm.com>
References: <5abb5812-cdd8-47d4-b5a0-33f7351589ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38009-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:alex@shazbot.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mani@kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D28DD6B742D

Hello Baochen,

> what is the difference between a clean VM shutdown and an unclean termination?
> specifically, will pci driver's .shutdown callback be triggered during the clean VM
> shutdown, and not be triggered during a unclean termination?

Clean VM shutdown: The guest OS shuts down normally, so the guest kernel
calls the driver's .shutdown/.remove callbacks. The driver can properly
deinitialize the device, leaving it in a clean state.

Unclean VM termination (crash, force-off): The guest kernel never runs, so
driver callbacks are not triggered. The device remains in whatever state it
was in (DMA active, interrupts enabled, etc.). At this point, only VFIO on
the host can interact with the device to reset it before reassigning it to
the next assignment. Without a working reset method, the device stays in this
undefined state and can't be reused.

That's why VFIO calls pci_try_reset_function() - it's the only way to clean
up the device when the guest driver couldn't.

Best regards
José Ignacio


