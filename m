Return-Path: <linux-wireless+bounces-37623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rvO5NHM4KWpRSgMAu9opvQ
	(envelope-from <linux-wireless+bounces-37623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 12:12:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC1668276
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 12:12:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ny4yXhvR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37623-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37623-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3690C304F9F4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09B53E9C2A;
	Wed, 10 Jun 2026 10:01:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29C3E5EE3
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 10:01:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085675; cv=none; b=LR1jIfG7SqdXvjjgE/d+C6y+LH7E7f+56XuHd5HyakZyIzj+JEGayJoU7e3D0ca/ZPLbaZihx34sbik/fE985tyEt+3ZH5nz4wRRmQOR18GdiYZmXvf7sNSammJ4pmw2Uv4ZRqm+u/hG/e3KigZQvQi4YOr6Pc4AtBRgSmQhAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085675; c=relaxed/simple;
	bh=NXj8s/f7UZBoXS9eyuxmfRgMWd0CvdIZLbRTYsC+3F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGlAWB08l7Hw8ekuN+Y2XeUllsrhv+h5IKmIU36IAWP+box8fi4RCpyRFionaLGsF8vPOVKaa4DnbiHKj6sL3EYAGnHoZC87i9Oo7raigyWVVN5aN78jvLfcT2NH0Mt4YriPsFThWAuFVNHjiN2hlSfV5DKaNU7Opp6C7CKDYfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ny4yXhvR; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781085673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0u3YOlBGasTqI/efMg4dbBFjH2Jdl45+ZYBRiUMwLY=;
	b=Ny4yXhvREisRrmevv9RAPnMShts7kihTDRyvhPDrzGCVUBtvaSehcUXlpn0dSfrF5SEVEA
	S9YcI7guUiDI6JLaE0q/FNQIL7tVOPSyMpDzFp+S4eL1HE0iYBAzUwxdxltgL/jRXIOUVm
	Ppwu9vYv98ZPCgoCZWVD/QU0iTQMR4w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-kRo-Y_WdOd6I7y7utJw08Q-1; Wed,
 10 Jun 2026 06:01:09 -0400
X-MC-Unique: kRo-Y_WdOd6I7y7utJw08Q-1
X-Mimecast-MFC-AGG-ID: kRo-Y_WdOd6I7y7utJw08Q_1781085667
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 505BB1845575;
	Wed, 10 Jun 2026 10:01:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E818C1800599;
	Wed, 10 Jun 2026 10:01:01 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: alex@shazbot.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	bhelgaas@google.com,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mani@kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v8 2/3] PCI: Add device-specific reset for Qualcomm devices
Date: Wed, 10 Jun 2026 12:00:59 +0200
Message-ID: <20260610100059.19235-1-jtornosm@redhat.com>
In-Reply-To: <20260609115352.32acb6fe@shazbot.org>
References: <20260609115352.32acb6fe@shazbot.org>
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
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37623-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mani@kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1DC1668276

Hi Alex,

> My only complaint is that this is positioned a bit generically...
Ok, I'll make the comment of the function more specific for these Qualcomm
devices.
  
> Has each of these devices been tested on a platform where D3cold is
> actually achieved through this method?
No, I don't have access to platforms with _PR3 support. All testing was on
M.2 adapters (D3hot fallback only). Since D3hot works reliably and D3cold
is a stronger reset mechanism, the approach should work - but I cannot
confirm the D3cold path through testing.

I'll send v9 with the updated comment.

Thanks,
Jose Ignacio


