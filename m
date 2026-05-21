Return-Path: <linux-wireless+bounces-36760-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO12JUHoDmopDAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36760-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 13:10:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA275A3C4F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 444B630A6257
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 10:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F883ACA70;
	Thu, 21 May 2026 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C2PgYbTW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BC7385D9E;
	Thu, 21 May 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361062; cv=none; b=gz7u/K/wn+PuBLBaF08DBkoR3D9FgjDFGQtcpir7mqUWDqcpnksH1RFQPHWnbOfEZzeMrgkglziv/AfvZsQhklN8lAa/wtq07CdoKvCvr1Vv5/h4yPJR2FYf0MO8TDBeEwT+5Xqye5x8mxV2Pqvho6AKSMcBWtxzSIreblnHP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361062; c=relaxed/simple;
	bh=bPSw3rQUd5ThqwO4nSsvJOhJieCC7zrqPZfbkVxMrNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLNcydKB3o+Vbr6b0Ko/biTB6EXRRmF3FOJxhlC35MIQZmhovWKBDgXQV3FkNr+oSp6pmdMLiJvhn0WU4BzppHS5nhDEa+lTGkR94DUVl/Aq1zb8RdCqDWvhh40Kg6QwO++upvoJiX6QJZGnGiXwJM8wTtA+NPtFv/mrkx88H1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C2PgYbTW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302BE1F000E9;
	Thu, 21 May 2026 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779361061;
	bh=27akLTsRSgP7ogQAxJhqBgzdTNpBKT8E1KbP/a65xnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C2PgYbTWBAYgfUiOkuED7Fqh31DAfCDpd2btf+7P6gkBCF5ua/XOJxa6+gCRqm0Qj
	 HG74RnBW66E/2v2FSaEDftzT//lpnEgx2mCuUxFzBPHyu6eQmcnJO6igsXL85mYtIy
	 PHdhMtqo8vEvO/XlyOULPB8fn8KcegTek19fWja4=
Date: Thu, 21 May 2026 12:57:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Elliot Saba <sabae@valvesoftware.com>
Cc: Johnson Tsai <wenjie.tsai@realtek.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	Charles Lohr <charlesl@valvesoftware.com>
Subject: Re: [External Mail] Re: [RFC rtw-next 1/2] wifi: rtw89: usb: add
 hw_info sysfs attribute
Message-ID: <2026052152-pureness-blinker-9e5c@gregkh>
References: <20260519072415.25746-1-pkshih@realtek.com>
 <efb61959e14e4f57b78fbd49a563398e@realtek.com>
 <83ddb427597663b947c49afd835014f2bc1033f2.camel@sipsolutions.net>
 <2026051957-refract-barge-b21e@gregkh>
 <b8640de28c5e4a94a3c2bbc3a101c1fa@realtek.com>
 <2026052025-daringly-prolonged-5b2a@gregkh>
 <9ce7404ea7bc480786b5ed0bb2182157@valvesoftware.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ce7404ea7bc480786b5ed0bb2182157@valvesoftware.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36760-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DAA275A3C4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 07:32:13PM +0000, Elliot Saba wrote:
> Hello Greg, Johannes, thank you for your time and feedback on this patchset.
> 
> The purpose of this information is to provide access to two pieces of information, a serial number (also printed on the outside of the device, used for product tracking, RMAs, etc...) and a GUID (random entropy that is intentionally difficult to guess).
> We use the GUID to establish a direct connection between the USB network adapter and another device.
> 
> To directly answer your USB questions, unfortunately the ASIC used in this product does not support customization of the USB serial number; all devices have the same USB serial number.  Indeed, I believe there is no mutable state on the device at all except for the e-fuses that are written at the factory to write these two values.  Given those constraints, we're trying to find the best way to raise this up to userspace, and we're grateful for your feedback.

Then where exactly does that "serial number" come from in the device so
that it can be read by the kernel, if not in the USB device itself?

> This USB device is expected to operate on both Windows and Linux hosts, on the Windows side we have a custom driver that allows our host application (Steam) to directly query these fuses and setup the network connection appropriately.  We're attempting to upstream this capability as much as possible so that users running a vanilla kernel can take advantage of these features as much as possible.

Great, why can't this driver also query the fuses?

> With regards to permissions, we'd really like to make this serial number readable by non-root users so that the pairing functionality can work out-of-the-box without needing special udev/tmpfiles.d rules to adjust permissions to allow Steam to read this information, but we are simultaneously sympathetic to the desire to limit trackable/identifying information by default.  Of course we can adjust permissions however needed for our own Linux distribution, but in our effort to support the rest of the Linux ecosystem as best we can, we'd like to do our best to find a solution that would work everywhere.  We're open to comparing against any existing precedent for devices that necessarily require identifying information to perform their basic function, if you know of any.

My objection is the placement of random sysfs files in the USB device
directory, for something that is not a USB device-specific thing, but
rather a driver-specific thing.  If this is a driver/device bound
specific thing, then put it in the device that the driver creates and
owns.  NOT in the device that the USB core creates and owns.

thanks,

greg k-h

