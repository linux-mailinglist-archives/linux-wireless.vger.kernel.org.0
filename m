Return-Path: <linux-wireless+bounces-38981-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZkIyH8b/VGqyigAAu9opvQ
	(envelope-from <linux-wireless+bounces-38981-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 17:09:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBBF74CD68
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 17:09:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gjnQN2Mb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38981-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38981-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A04D63088F6A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9A126ED4F;
	Mon, 13 Jul 2026 15:02:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA82EEE8A
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 15:02:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783954924; cv=none; b=DkrLTObME4Uow8UP5wrZ/aPQCrmd0pRGmQjm8fpGzmOxRa4CYgFsDvgob7WhODsDL5l7+CQLd1md41WIVuQcgot6wm7oQZFqUwS38zTnWCmAcGDslTCjMhxuF2fEF0CJWDLuYwhkstl2Z5AztONMAR7bYT3cyw9xN47DDo7ExQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783954924; c=relaxed/simple;
	bh=88RxX+JkWNZbQ2cIlHOd3evCkQ6J14mP3ECcOysTa0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGiWB1KRrc1HyxG7FhY0OiWH/BtlJ2rMRH/j4Wrwtwu52iD20OY4mFoKYFC8D1bMIeS0ItbvVVpahHJTyeGNXogSHFMAKi9PlNXabDFzgQxDev5fa7AwlvDKngRAt0HDDnWart3zlJwFpphqI5UZOneW8Dr8QMl5Gh1cugsQ7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjnQN2Mb; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783954921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88RxX+JkWNZbQ2cIlHOd3evCkQ6J14mP3ECcOysTa0w=;
	b=gjnQN2MbIJijGk1XnhC9Q4cuQytcZ0Dy1wwM0rBIj75kdW9AqDjlIhODxtmBN5/W06PVJR
	kEjK6Q9ycWs2Bh0odAfTlo+XtbXdFXDC11Cere7xa14hF0EAlhES9L3mMtjv9Ul8E6n7mp
	QLI8TAjY6S7Ibch3/4YwZ6927WKTsB4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-foHAshqCPpOhpbdRenkVsQ-1; Mon,
 13 Jul 2026 11:02:00 -0400
X-MC-Unique: foHAshqCPpOhpbdRenkVsQ-1
X-Mimecast-MFC-AGG-ID: foHAshqCPpOhpbdRenkVsQ_1783954918
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A66ED18009FC;
	Mon, 13 Jul 2026 15:01:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 763911956086;
	Mon, 13 Jul 2026 15:01:55 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: hujy652@gmail.com
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: ath11k: implement custom wake_tx_queue with flow control
Date: Mon, 13 Jul 2026 17:01:49 +0200
Message-ID: <20260713150151.2343583-1-jtornosm@redhat.com>
In-Reply-To: <20260711153336.542-1-hujy652@gmail.com>
References: <20260711153336.542-1-hujy652@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38981-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hujy652@gmail.com,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEBBF74CD68

Hi Zhi-Jun,

Thank you for the review.

> In wake_tx_queue:
> ring_id = txq->ac % ar->ab->hw_params.hal_params->num_tx_rings;
>
>In ath11k_dp_tx which is called by ath11k_mac_op_tx:
>ring_selector = ab->hw_params.hw_ops->get_ring_selector(skb);
> ti.ring_id = ring_selector % num_tx_rings;
>
> Are you sure ring_id will be the same?
You're right — txq->ac % num_tx_rings doesn't match
get_ring_selector(skb) % num_tx_rings on all platforms.
In v1 the ring identification was only correct for platforms where the ring
selector happens to coincide with the AC, but not for platforms.

I will send a v2 trying to solve this globally for all the platforms.

> Also mgmt frames use a different path.
Correct — management frames go through WMI, not the TCL data rings, so they
are not affected. The flow control applies to data frames, which are the
ones causing the problem since they use different TCL rings depending on the
platform's ring selector.

Best regards,
Jose Ignacio


