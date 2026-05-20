Return-Path: <linux-wireless+bounces-36703-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGnZDbeeDWpO0AUAu9opvQ
	(envelope-from <linux-wireless+bounces-36703-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:44:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FCC58CDB5
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F7EC3145A05
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E963BE162;
	Wed, 20 May 2026 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1prUAur8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D23AFCE2;
	Wed, 20 May 2026 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276962; cv=none; b=RpN0J2vYKfDZ5Wn3fcZzCD5TcbdxviWW0o977RjKQ69rqeiz0CJE+FgKFRVvpgQYa5kZN2st+IJrkGrqBt9DWHFcSfnorvnkzgFpjMxuU7+yy+rgc9E571n2OX6ReK2F3aZaK+g0YO6kgWDNjbFyDyy/pfaqOOGZpu7v1fSUJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276962; c=relaxed/simple;
	bh=K1eb/e1DfVvZ9UO1JlGkbHieEXM3RZ16p7urCX1Yrlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUPY520EAx88ijdSuFLZ8HksiH9Ba4B7LZVSOckAt5R/0jn2vTQ/BQ7t1yuR2GGK3LN9TEd8iTpfLLQu65B5tcofC1RbTFDORCmANWtTDxTh4HDO0/k+atTwHmuZupfMuNipyo8AYKsxUvBk3wAYhrRDsRv0DU0KIAAKzZYT4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1prUAur8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E359B1F000E9;
	Wed, 20 May 2026 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779276961;
	bh=b1X9CMLRZ5OKrCex1XYZEBrE0xBYcTu4fMJjEZNvnmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1prUAur8F82bCjfyUnGJ/+POWwxsjyQqLSzUbUqe1lRscxkCzy4gmB3kqKgpk0x+R
	 DI7tx6/Vv2yiGTtxeFMT3eh4ShhY6+oFbRD8MaeL6h8pODshmqIoo4Y6BFckfVEG7X
	 3Lu1s1uscYoZSXr+mgBuNneyTtjX6mOPWYSwHb9E=
Date: Wed, 20 May 2026 13:36:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johnson Tsai <wenjie.tsai@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"sabae@valvesoftware.com" <sabae@valvesoftware.com>,
	Charles Lohr <charlesl@valvesoftware.com>
Subject: Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add hw_info sysfs attribute
Message-ID: <2026052025-daringly-prolonged-5b2a@gregkh>
References: <20260519072415.25746-1-pkshih@realtek.com>
 <efb61959e14e4f57b78fbd49a563398e@realtek.com>
 <83ddb427597663b947c49afd835014f2bc1033f2.camel@sipsolutions.net>
 <2026051957-refract-barge-b21e@gregkh>
 <b8640de28c5e4a94a3c2bbc3a101c1fa@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8640de28c5e4a94a3c2bbc3a101c1fa@realtek.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36703-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A5FCC58CDB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 09:41:46AM +0000, Johnson Tsai wrote:
> 
> 
> On Tuesday, May 19, 2026 20:23, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Tue, May 19, 2026 at 02:11:32PM +0200, Johannes Berg wrote:
> > > Hi,
> > >
> > > > > Example usage from user-space:
> > > > >   $ cat /sys/bus/usb/devices/2-3.1.2:1.0/hw_info
> > > > >   SN: 36 42 00 01 23
> > > > >   UUID: aa ec 2b 7c 0a 55 47 27 8d e0 b3 0f eb cc bb aa
> > >
> > > Sysfs has a "one value per file" rule (soft rule according to the
> > > docs, but harder in practice, I believe), so seems if anything that
> > > should be two files. Maybe a UUID should also be formatted as such
> > > with %pU or similar.
> > 
> > That should be 2 separate sysfs files please.
> > 
> > And yes, use %pU.
> 
> The v2 patch will use separate `sn` and `uuid` attributes, with `uuid`
> formatted via `%pU`. We also removed the spaces in `sn` to provide a clean
> string.
> 
> Example usage from user-space:
>   $ cat /sys/bus/usb/devices/2-3.1.2:1.0/sn
>   3642000123
>   $ cat /sys/bus/usb/devices/2-3.1.2:1.0/uuid
>   aaec2b7c-0a55-4727-8de0-b30febccbbaa

Wait, no, you are putting attributes in the USB interface device, which
is NOT the device your driver is creating.  Don't do that, it makes for
massive confusion.

> > And be careful about exposing serial numbers to userspace, some systems
> > don't like normal users to read them so be sure to get the permissions correct.
> > We had to add some USB code for ALLOW_SERIAL_NUMBER to make it so that
> > systems can handle this if they want to.
> > 
> > And shouldn't this just be the USB serial number to start with?  Why is there a
> > different string here?  We already have a sysfs file for this value.
> 
> Regarding the serial number and permission design, these are requirements 
> from Valve, so we have CC'd them here to provide the background.
> 
> Hi Elliot and Charles, could you please help explain the requirements and use case here?

The USB serial number is already exported in sysfs, why export it again
under a different filename?  That's ripe for total confusion :(

Also, where does this random UUID come from?  That's not part of the USB
spec, is it?  Why is it not just a USB string attribute like the spec
says to use for stuff like this?

thanks,

greg k-h

