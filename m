Return-Path: <linux-wireless+bounces-37869-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 27YtNnnTMmqw5wUAu9opvQ
	(envelope-from <linux-wireless+bounces-37869-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 19:03:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF369B8F1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 19:03:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hbuXaWAm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37869-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37869-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F1F304FA66
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D44ADD9C;
	Wed, 17 Jun 2026 16:55:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7C3C1400;
	Wed, 17 Jun 2026 16:55:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715341; cv=none; b=PaDjRVQvboN48M427gYlD73S0KhL0m33IwElXJjZKU3h8PQoUfZ6Oo6XwlqEDcXQ5/7xk9Hi5BxTQlf4NntAboKnQ4R9UR7BFrCB4hb3lrI/mJS+wXhapwFg7Ca6oMPof2AL579WHclIqsW/pVtXEKbF277L337mwhfLoG8vIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715341; c=relaxed/simple;
	bh=2FpnBmUlMqSXmFCIwcN+TiEWl0Qe/Dy0WbHbTjWhmYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQzRNHAdpluXfppH7Z9wsjniY4Gk6sPz15adooK4/O4Vq8JtcRB0u4TQTQUd879f70wqRceiHTSeV22CqFvCFHaPmjnHXrhRFYoPp8MG6oIQJnGetdHXOWyzauoj464RV5tx6vWo6F//LPfTIv1Kio/D0+1L7gJnQPbk+1qI9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbuXaWAm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FDA1F00A3A;
	Wed, 17 Jun 2026 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781715338;
	bh=JAaKztVtAjTEh5iAYKxqFq8EDcZvRu/sAfJLhlyALxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hbuXaWAmadyEloMTRkxwYTceWjSbsRB709unQQIxxZzdYO4DtDwS/hyfSV8WMimN7
	 12twiOzWkcbSAQAyaMSjfJ3MoeMx9SBSJciSR9gGWqqngog5vBgL4VZTHE2XMrEIdx
	 AjFDYa1YkDVoo1S7vkUFwxwdxNXcmg6qyToMdYkWJQ6Q3f0kJIi+kw19hZEQigcoaW
	 l2xNblS91FLQeHs+3XrJWq4GEFmjlEMViRnTT/rB6hbgEbEmJHxT7lt9820bVCXo88
	 q9j0nf5A/o/WO6BLLR/ACPrfUgi/RjWQvXp6TQtvmDcSzS+iwJjs/i6H3MzpcfFjce
	 cy2EYCpvUA8Kg==
Date: Wed, 17 Jun 2026 18:55:30 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, bhelgaas@google.com, jjohnson@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mhi@lists.linux.dev
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <n3maiuu5cctivlal4fozysz37ir6ecdfws5u2xxw2neclsfdfj@nsvwvlh7b4j5>
References: <6nivb5fncfd5dwqkzlxwhtgbsiqvifazcbgpsgukp44iib45ke@65qpwgrvtkgn>
 <20260617154709.186286-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617154709.186286-1-jtornosm@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:alex@shazbot.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:bhelgaas@google.com,m:jjohnson@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:mhi@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37869-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nsvwvlh7b4j5:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52BF369B8F1

On Wed, Jun 17, 2026 at 05:47:04PM +0200, Jose Ignacio Tornos Martinez wrote:
> Hi Mani,
> 
> Thank you for the internal clarification and sharing this information.
> 
> I understand the behavior is firmware error recovery, not a proper reset.
> However, these devices are widely used, and the inability to use them in VMs
> is a significant problem. Could we explore options to achieve safe VFIO
> operation?
> 
>   1. Are there ANY alternative reset mechanisms besides D3cold? For example:
>      - Device-specific registers or commands?
>      - MHI bus-level operations?
>      - Firmware commands that could trigger proper reset?
> 
>      If such mechanisms exist, I'm willing to implement whatever is needed.
> 
>   2. If firmware error recovery is the only option available on platforms
>      without _PR3, could we add software steps to make it VFIO-safe?
>      For example, before/after the D3hot transition:
>      - Explicit MHI state teardown?
>      - Firmware commands to clear sensitive device state?
>      - Additional verification or cleanup steps?
> 
>   3. The practical challenge is that _PR3 support is not available on most
>      platforms where these devices need to be deployed (desktops, servers).
>      Additionally, the general d3cold reset method has limitations and
>      remains unimplemented due to the concerns raised earlier (ACPI
>      portability, bridge issues, runtime PM complications).
> 
>      If D3cold is the only proper reset but requires _PR3, and no alternative
>      mechanisms exist, could we consider accepting the firmware error recovery
>      behavior as a last resort - clearly documented as a platform-specific
>      workaround?
> 
>      Currently these devices have no reset capability on most platforms,
>      making them completely unusable for VFIO. Even an imperfect reset is
>      significantly better than no reset at all.
> 
> My goal is ensuring these devices can be safely reassigned between VMs.
> I'm open to implementing any of the above approaches - or others you might
> suggest.
> 

Can you share the exact steps that you tried for passthrough? I'm curious to see
whether you unbinded the MHI host/WLAN driver from the device or not. For the
modem devices, the MHI Host driver's (drivers/bus/mhi/host/pci_generic.c) remove
callback should've quiesced the device and moved the MHI state to RESET if the
driver was unbinded before binding the device with vfio-pci.

I certainly feel that the MHI/WLAN driver should be able to reset the device
during unbind. But I'm not sure if that reset will affect only the firmware
state or the device's config state also. This is something I need to
investigate.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

