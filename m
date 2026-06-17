Return-Path: <linux-wireless+bounces-37867-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AhJ4FBK0Mmpm3wUAu9opvQ
	(envelope-from <linux-wireless+bounces-37867-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 16:49:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28D69AAA0
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 16:49:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nu+Iipjn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37867-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37867-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6616310A501
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2026 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD24611F4;
	Wed, 17 Jun 2026 14:48:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC6F451056;
	Wed, 17 Jun 2026 14:48:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707690; cv=none; b=pP8aZfAFsIXRVZQPs8igNOCQKrtMDQ5dKkvy5wsZDX4k2Ve/akHJsfMl/V/WcBcbrkWGLwP2w5lQDSPfpuLmBtJLrqZcTwuah3bFiR55vzuYuZCs0S2WXW4ldipl5f6bKtp8k+gizX+6E7dqb6V/YdvIN+FusUBVK8h6W8C6l5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707690; c=relaxed/simple;
	bh=qUjx9MgPIq17Ua7gnKrtPrBAOEw/n9cpYdl1TteOLGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAHKLUbxuf+L1ZOzxdwWwm4Blj8hiU2K8Jx8xCxtbvqrN5l26Pb54O+AbNGRJDdPtqX6feP+XcUBC6yQNH0xEYyurMiOMDWrXGzZx4V4+5aK81NMQAQQbxfO8p7UcvL+5fElHVHH9SMtvePOho+lzA82vMQM9dma17jFpex/U0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nu+Iipjn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5594E1F000E9;
	Wed, 17 Jun 2026 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707687;
	bh=Gcy/EaAZ/pJ1qaeNy3eriBsvPASZl+M9Jg5BLs22CGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nu+IipjnxThO/KXMaqoJz6F2xpNAmVTnfMkZOXjRxKvtE9gFfupf6rXNAaomX60F7
	 5nzo4GUh9tYxRjp9dd/C1YD2YXCNY5LUu8MgaMgguQjZmvM+Xt4nfXrOx7yHjSeeEj
	 r3gZwjJoS6LOoxyRXfqN9wqhvMUbOfCV0/PaCD39EpH1uSrLOG3nOj0rWJUBgt8+n7
	 L14QWpOIDCM0BZUKXGWTFDTF5rIxJJ/baN22qjH4ar4zyODmDnXsrqtOdJNsZv61z/
	 nwlpwt55agoKXxja49kLE8IQbgyxHjfyoSPGBkIi2xTUwHdmqxbgwzxNlsDgPw/6Rk
	 A+2Q4Avt+3JUw==
Date: Wed, 17 Jun 2026 16:47:58 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: bhelgaas@google.com, alex@shazbot.org, jjohnson@kernel.org, 
	linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, mhi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] PCI: Add device-specific reset for Qualcomm devices
Message-ID: <6nivb5fncfd5dwqkzlxwhtgbsiqvifazcbgpsgukp44iib45ke@65qpwgrvtkgn>
References: <20260612142638.1243895-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260612142638.1243895-1-jtornosm@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37867-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[65qpwgrvtkgn:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD28D69AAA0

On Fri, Jun 12, 2026 at 04:26:38PM +0200, Jose Ignacio Tornos Martinez wrote:
> Some Qualcomm PCIe devices (WCN6855/WCN7850 WiFi cards, SDX62/SDX65 modems)
> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.
> 
> The problem manifests in VFIO passthrough scenarios:
> 
> - WCN6855 WiFi card (17cb:1103): Normal VM operation works fine, including
>   clean shutdown/reboot. However, when the VM terminates uncleanly
>   (crash, force-off), VFIO attempts to reset the device before it can
>   be assigned to another VM. Without a working reset method, the device
>   remains in an undefined state, preventing reuse.
> 
> - WCN7850 WiFi card (17cb:1107): Same behavior as WCN6855.
> 
> - SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
>   on first VM assignment without proper reset capability.
> 
> Add device-specific reset entries for these Qualcomm devices using D3hot
> power cycling. Testing shows that despite advertising NoSoftRst+, D3hot
> transition provides sufficient reset for VFIO reuse, particularly after
> unexpected VM termination. While not a complete reset (BARs preserved),
> it provides the only viable reset mechanism for these devices.
> 

I checked internally within Qcom and I was told that these PCIe devices retain
the context during D3Hot to D0 transition and that's why they advertise
No_Soft_Reset.

The partial reset behavior you are seeing might be due to firmware handling the
transition as an error state. All these devices use MHI bus and when the MHI
state doesn't match the PCIe device state, then the firmware will treat it as an
error and will try to torn down resources. This could be the reason why you are
seeing partial reset.

Nevertheless, these devices do not support any form of Soft Reset and only way
to reset them would be by doing D3Cold. But that depends on platform support
though. So it would be inaccurate/wrong to assume that these devices support
Soft Reset during D3Hot to D0 transition.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

