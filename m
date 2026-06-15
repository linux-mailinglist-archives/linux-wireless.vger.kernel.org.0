Return-Path: <linux-wireless+bounces-37803-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TvYZAMeqL2pEEQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37803-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:33:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E02684391
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 09:33:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Tq1vqXc2;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37803-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37803-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12533014BF2
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jun 2026 07:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A03BED33;
	Mon, 15 Jun 2026 07:30:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC23BED0C
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jun 2026 07:30:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508617; cv=none; b=nmSHBdnSdOKeZOI7mPwMZ33NLdeYU1kmClU0Ir/usxwLuZ4Cjw7Ci7o0Q83JvUfMMiH5MxkEQ+B6TbusxLHvUhsPUTA3Iu7F35W28fse7hPVVgD/OVOEutzvgms4TMrGPgfWf1kYd5cXshS90dq/o+EuTHgpG1RrpslY3ngAGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508617; c=relaxed/simple;
	bh=fR0oi9v184iQOyv1BvHhYMt5snuytRuwX2/aefL9mLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7s34wlEy9QQ/s7kbZTfjUD4j+rfCRnpDi0ubT2Aw3MsVDCLXPXeIsNUPacPXmHotAirNdV/sGdr0HGyYv0CuKiyy6DCX2I5qW48ayZb5l6GJBrSBs/lj3ZwpDQLunD4HU6k1kPlJqf+J1HKAHJKKfi8/YnVz+98Cra5EPRTcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tq1vqXc2; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781508615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VlL+ld2zIBTp0Uov30L/svoU5nNy1BEIdafxq1tBX4=;
	b=Tq1vqXc2IcFfo4l5id6SpLDh7oDR/p1UEY2xrRc6Nw0J0ortN/b8msC2yICaH7K1ZFeu1J
	LquZDk2bcaU4GOaBxjFnm4clV3BpH494shXvLrcfNNTdK3vzdZS7s+bcJgpkQ82tPpycXC
	PNv/nnxxBhwK5dbvA8gmI/5dMBVs1Co=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-uW9eYI_rOsCmZdj76mUXtw-1; Mon,
 15 Jun 2026 03:30:12 -0400
X-MC-Unique: uW9eYI_rOsCmZdj76mUXtw-1
X-Mimecast-MFC-AGG-ID: uW9eYI_rOsCmZdj76mUXtw_1781508610
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5529B19560BB;
	Mon, 15 Jun 2026 07:30:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF602180056E;
	Mon, 15 Jun 2026 07:30:03 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: helgaas@kernel.org,
	alex@shazbot.org
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
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Date: Mon, 15 Jun 2026 09:30:01 +0200
Message-ID: <20260615073001.401330-1-jtornosm@redhat.com>
In-Reply-To: <20260612151749.GA603817@bhelgaas>
References: <20260612151749.GA603817@bhelgaas>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:helgaas@kernel.org,m:alex@shazbot.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:jtornosm@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mani@kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37803-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56E02684391

Hi Bjorn and Alex,

Bjorn's questions:

> I guess "bus reset" here refers to Secondary Bus Reset being asserted
> by the bridge upstream from these devices?  Seems a bit surprising if
> that doesn't work.  Or is it just that we can't use SBR because there
> are multiple devices below that bridge?

Yes, SBR. The devices I tested are alone on their bus (single device under
bridge), so it's a device-specific issue, not a topology problem. The
quirk_no_bus_reset patch addresses this for v7.2.

> I don't know enough about VFIO, but I sort of expected that VFIO would
> reset devices between reassignment regardless of how a VM terminates.
> I guess that's not true?

VFIO does attempt reset on every reassignment. Without a working reset method,
the attempt fails and the device remains in undefined state. With this quirk,
D3hot successfully resets the device allowing reassignment.

> Since the device claims to preserve internal state across D3hot->D0
> (and it sounds like at least BARs *are* preserved), is this a
> potential leak of state between VMs?  To play devil's advocate, how do
> we convince a customer that none of their data is ever leaked to a
> subsequent tenant using this device?

This is a valid concern. Testing shows device internals are reset despite
NoSoftRst+ (command register cleared, requires driver reinitialization),
though BARs are preserved. Given these devices have no other reset method,
this provides the only viable mechanism for VFIO reuse. We cannot improve
beyond what D3hot provides - the quirk works because despite advertising
NoSoftRst+, D3hot does clear sufficient internal state for clean
reinitialization.

> If we think this is a viable method, it seems like we should use
> pci_pm_reset(), which takes care of IOMMU and device readiness issues.
>
> We would have to change pci_pm_reset() to deal with the fact that
> PCI_PM_CTRL_NO_SOFT_RESET seems wrong on these devices.  Maybe we
> could cache PCI_PM_CTRL_NO_SOFT_RESET in pci_pm_init(), then override
> it with quirks for these devices?

I explored a similar idea in v2 (PCI_DEV_FLAGS_FORCE_PM_RESET to bypass
NoSoftRst+):
https://lore.kernel.org/linux-pci/20260508145153.717641-2-jtornosm@redhat.com/
(Note: v2 used driver names ath11k/ath12k instead of device-specific names
WCN6855/WCN7850, which Jeff Johnson later commented on in v7 feedback.)

Alex provided guidance on both approaches and indicated device-specific reset
seemed more appropriate here:

"Device specific resets are made for this scenario. Look at
pci_dev_specific_reset() and pci_dev_reset_methods[]. The supporting
evidence that this performs a worthwhile reset is still a bit weak, but
heuristically it seems better than nothing, which is what we're left
with otherwise. Reset via D3hot for a device that does not expose
NoSoftRst- is not something we should enable or endorse for any common
use case."

The device-specific approach keeps this quirk isolated to proven device IDs.
But I can revisit the pm quirk approach if you both prefer it.

Alex's suggestion:

> It would be better to extract the core of pci_pm_reset() to a
> pci_do_pm_reset() function that's used both here and by the
> pci_pm_reset() function.

Good point about the code duplication. In v9 I kept it as a self-contained
quirk to avoid modifying pci_pm_reset() and touching core pci.c code, trying
to minimize the change footprint. But I agree extracting a helper function
would be cleaner.

Once we confirm the preferred approach (device-specific vs pm quirk per
Bjorn's question above), I'll send v10 with the appropriate implementation
including the helper function if we proceed with the device-specific approach.

Thanks

Best regards
Jose Ignacio


