Return-Path: <linux-wireless+bounces-36053-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIzZNmY6/GmUMwAAu9opvQ
	(envelope-from <linux-wireless+bounces-36053-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 09:08:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8034E3DE5
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 09:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2064301B935
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 07:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45F2E4257;
	Thu,  7 May 2026 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceJ7kW8d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E337A346AFB
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778137699; cv=none; b=iWvgU824VM8Q9rhI878Dp6vafrb5iRPeqIxrvKkGXTTWEJVE6tLevWnOhRIuRGaobKkxEuyXQcglIs77JH4iBJwIhfPjsXqa1HlBu5NiMEsfEO8dFjaehjMhWojUBCNNMB1Y4wO/Bw2eAzoi+s6pLalT8MJZSUErwxTnxeMzLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778137699; c=relaxed/simple;
	bh=szDG1yGf2JvHzzIARZ5fXBS4Y9Dri5eXAFqj1ClQZbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bH4v85cMl1ze4jT6L4iKLfiMVt6E1zxEZRUxDbHG7XxKgO+2jfBhkTDk3VUyySv6Ilvx10Db5rTcyJaEoNfxGW0wh205OY8+uJ1ENq+IaprJLkYLA8x7ZsbshXZEVWByBhk48lD9dvPq/6Tt9NeoAIwZmF8SXM6VIaZECWdpmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ceJ7kW8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778137696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szDG1yGf2JvHzzIARZ5fXBS4Y9Dri5eXAFqj1ClQZbA=;
	b=ceJ7kW8db2uHxCtIVXXD9sQwHia5n2daJUfYHKzGC/fClhKU+2J5fRNuZd6eQ1A+XkUPiQ
	C1GhcEuJC3JNZB6BEQuhc3qM3rc7+zgbxRvie3aRZPBZ6GmVUvA/5komi+J15pU5HxLiq/
	SJ7it068qGNSGXIWx7bZxwYzkZuVogs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-FaxXW4vKMHm-x5oZVn4pVg-1; Thu,
 07 May 2026 03:08:15 -0400
X-MC-Unique: FaxXW4vKMHm-x5oZVn4pVg-1
X-Mimecast-MFC-AGG-ID: FaxXW4vKMHm-x5oZVn4pVg_1778137694
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51528195608F;
	Thu,  7 May 2026 07:08:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.69])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EE961953947;
	Thu,  7 May 2026 07:08:10 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: rameshkumar.sundaram@oss.qualcomm.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
Date: Thu,  7 May 2026 09:08:07 +0200
Message-ID: <20260507070808.367442-1-jtornosm@redhat.com>
In-Reply-To: <005af843-da19-4df9-af67-2cd148b24d62@oss.qualcomm.com>
References: <005af843-da19-4df9-af67-2cd148b24d62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 5F8034E3DE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-36053-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello Rameshkumar,

The hardwre that I am using is QCNFA765, but I think it is something
related to ath11k driver and not related to some specific hardware.

I am running with the latest upstream kernel and I can reproduce it, so
I think it is not related with the problems that you comment.

Let me repeat this to try to clarify:

The easiest way to reproduce it is to run in a VM the default upstream
kernel (with this card using PCI passthrough), and since this is always
failing, just unbind the device (ath11k_pci).

The same problem was fixed by me for ath12k driver here ca68ce0d9f4b
("wifi: ath12k: fix warning when unbinding"), and I have seen the same
problem is also happening for ath11k driver.

Thanks

Best regards
José Ignacio


