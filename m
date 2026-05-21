Return-Path: <linux-wireless+bounces-36763-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNaIIcwLD2omEgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36763-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 15:42:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382855A61F9
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 15:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5F03163B87
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C93DCD83;
	Thu, 21 May 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HvUk5Zck"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339FB3D5C20;
	Thu, 21 May 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369107; cv=none; b=VaTHgpFnF0sodPAHT3JVCUniGswb0X5zMvDqAygazOg8SY/php61MZAowC4EGDNDnb9UFltMkwl+7yvoXOC8wvRT9kYt8BjLAOFttZ1CqQhVhoMh6df14yMDWdwLYrDTIcIogCdxscqO8fdTQUJkI83zFsboKI/sMsQupQ+Y7Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369107; c=relaxed/simple;
	bh=veqHZLaXevlCrxIWhlnKaOFfJyE9olg3M6SYhFU6ruo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqX5h84dD7Fd94RBLoSmOwnbG2OOfitFvAzZTPtasvuWOBiwjhwu18dfH+tPFfoNfQvgVS8bBDQn+j6DW1BMoMW//sK3TVQCS+rrlVHyvx8p7ro6N7Rax5nyFg0nxfJ0/wBTXRXWoKw2sEwblmW+G6MwRAp3xSUmWyEKPA+HpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HvUk5Zck; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EDF1F000E9;
	Thu, 21 May 2026 13:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779369105;
	bh=dnbf+LT8LWdGG7wV3+ryTl9QR+eoJdzGQhPAQ9SkONw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HvUk5Zckks3w40ACBN5cIh7oikzrUgM5fMz+NFmHI+irXxXD2YQdpkEINo6312Af1
	 Aqf6vnFsRH0dvxX64fwoOU5AWcOvwMYcAEo1zWga8Ctq0GuYwV7nT8FFiHRyexsFCn
	 Pc0nP8IEWjRryrhWwQZMfxPgq2sj+BjDxN52g4ok=
Date: Thu, 21 May 2026 15:11:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johnson Tsai <wenjie.tsai@realtek.com>
Cc: Elliot Saba <sabae@valvesoftware.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	Charles Lohr <charlesl@valvesoftware.com>
Subject: Re: [External Mail] Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add
 hw_info sysfs attribute
Message-ID: <2026052142-backfire-afar-9587@gregkh>
References: <20260519072415.25746-1-pkshih@realtek.com>
 <efb61959e14e4f57b78fbd49a563398e@realtek.com>
 <83ddb427597663b947c49afd835014f2bc1033f2.camel@sipsolutions.net>
 <2026051957-refract-barge-b21e@gregkh>
 <b8640de28c5e4a94a3c2bbc3a101c1fa@realtek.com>
 <2026052025-daringly-prolonged-5b2a@gregkh>
 <9ce7404ea7bc480786b5ed0bb2182157@valvesoftware.com>
 <2026052152-pureness-blinker-9e5c@gregkh>
 <fe2a612385f8439a820272f442314d37@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe2a612385f8439a820272f442314d37@realtek.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36763-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 382855A61F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:06:09PM +0000, Johnson Tsai wrote:
> 
> On Thursday, May 21, 2026 18:58, Greg KH wrote:
> > On Wed, May 20, 2026 at 07:32:13PM +0000, Elliot Saba wrote:
> > > Hello Greg, Johannes, thank you for your time and feedback on this
> > patchset.
> > >
> > > The purpose of this information is to provide access to two pieces of
> > information, a serial number (also printed on the outside of the device, used
> > for product tracking, RMAs, etc...) and a GUID (random entropy that is
> > intentionally difficult to guess).
> > > We use the GUID to establish a direct connection between the USB network
> > adapter and another device.
> > >
> > > To directly answer your USB questions, unfortunately the ASIC used in this
> > product does not support customization of the USB serial number; all devices
> > have the same USB serial number.  Indeed, I believe there is no mutable state
> > on the device at all except for the e-fuses that are written at the factory to
> > write these two values.  Given those constraints, we're trying to find the best
> > way to raise this up to userspace, and we're grateful for your feedback.
> > 
> > Then where exactly does that "serial number" come from in the device so that
> > it can be read by the kernel, if not in the USB device itself?
> 
> The "serial number" we're talking about right now is not exposed through the standard 
> USB descriptors. It is obtained via a vendor-specific H2C (Host-to-Chip) 
> command, which reads EFUSE data into the rtw89 driver. 
> Both SN and UUID are stored as specific fields within that data block.

Ick, ok, gotta love custom USB commands :(

> > > This USB device is expected to operate on both Windows and Linux hosts,
> > on the Windows side we have a custom driver that allows our host application
> > (Steam) to directly query these fuses and setup the network connection
> > appropriately.  We're attempting to upstream this capability as much as
> > possible so that users running a vanilla kernel can take advantage of these
> > features as much as possible.
> > 
> > Great, why can't this driver also query the fuses?
> 
> Yes, the driver can query the fuses directly, similar to the Windows driver 
> implementation.
> In this RFC v1, the H2C implementation is intentionally omitted to keep the discussion 
> focused on the sysfs interface design and gather early feedback from the 
> community.

Great, put these on the network device that you create as they are not a
generic USB attribute, and properly document them in Documentation/ABI/

> 
> > 
> > > With regards to permissions, we'd really like to make this serial number
> > readable by non-root users so that the pairing functionality can work out-of-
> > the-box without needing special udev/tmpfiles.d rules to adjust permissions
> > to allow Steam to read this information, but we are simultaneously
> > sympathetic to the desire to limit trackable/identifying information by default.
> > Of course we can adjust permissions however needed for our own Linux
> > distribution, but in our effort to support the rest of the Linux ecosystem as
> > best we can, we'd like to do our best to find a solution that would work
> > everywhere.  We're open to comparing against any existing precedent for
> > devices that necessarily require identifying information to perform their basic
> > function, if you know of any.
> > 
> > My objection is the placement of random sysfs files in the USB device
> > directory, for something that is not a USB device-specific thing, but rather a
> > driver-specific thing.  If this is a driver/device bound specific thing, then put it
> > in the device that the driver creates and owns.  NOT in the device that the USB
> > core creates and owns.
> > 
> 
> We completely agree with your concern. Since accessing these values requires 
> driver-specific commands rather than standard USB requests, they should not live 
> under the USB device directory.

Great

> In the upcoming v2 patchset, we will move these attributes under the wiphy device 
> managed by the rtw89 driver. The paths will be something like: 
> 
>   $ cat /sys/class/ieee80211/phy0/sn
>   3642000123

Spell it out, you have almost unlimited number of characters for a file name :)

>   $ cat /sys/class/ieee80211/phy0/uuid
>   aaec2b7c-0a55-4727-8de0-b30febccbbaa
> 
> Additionally, these sysfs attributes will be strictly limited to Valve's specific VID/PID 
> pair and will not be exposed on generic RTL8852CU devices.

Great, please document it as such.

thanks,

greg k-h

