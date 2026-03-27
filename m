Return-Path: <linux-wireless+bounces-34058-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNBMBPJpxmmkJwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34058-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:28:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A36434371D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92C2C301CC88
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001963E3C47;
	Fri, 27 Mar 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npyekksz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC33DC4A4;
	Fri, 27 Mar 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610921; cv=none; b=q5iyFZtTHqB6fkA40b2g5eEp+33ifgqA21cpJxBH+Bu3NMrd7VIMU6y7yw6Im1p0TiVEB0HqwQMhDOMxd2bY3ynaDlp8FTEUqxptFOMyDIVH201xD/5QCp/J1CnUqGEnALwLIQCHar7HD+fDHmt+DuXN806SYP1FakztXiMyjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610921; c=relaxed/simple;
	bh=iasJ4QWocp2ZzX8ajhF2a0x2zaj/ryj6nhV9m0U9Orw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfUICchYwnuZuGw1y77ZdN9djCFJ7bSbizG1SMUH//sfGZNeXhNhuXtA8FSHF8ltwE77m8Sw3rrxhA3NY+JUTVq1Rv5b4qL5An8ETb9vatyYwzWAtCi+HTf/Y02qE1uVsYf+V2e8YaKri1Wnf9kbOi8Lr2E3OmM4l2drIOaAmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npyekksz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6ECC19423;
	Fri, 27 Mar 2026 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774610921;
	bh=iasJ4QWocp2ZzX8ajhF2a0x2zaj/ryj6nhV9m0U9Orw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npyekkszAMo/Q1yUelVG3+xe7sV/JPxwyW/XinuhHGlU+njuBoNHF4jZVGZTs14u6
	 CJrFPDX6Ns5RyfT7pG24ibaM78TolkQeO0lVq2gbhlaNRhaHS7tQ+A+2B5UKH0R7p9
	 oennoKctGnvUyIwbAW1o0eYRo6vC8MUutztmvF+VRK54h8LEkwMkIczyWnbKzsQc8W
	 A9hsLlDlRLGVTwm1RRv4sqEt6ZigPtJbEKYQC3FmsNyYmZTa8rJUIrar3iwbTvsNpv
	 LvHo+MKmIHmF49brQGjBi9/Qr6pCMM4CSwp+NQz8JYFiWLJSGOMZ79a538HPn9TXz2
	 CXGsGdzTKpAMw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w65Mk-00000005VeL-33oV;
	Fri, 27 Mar 2026 12:28:38 +0100
Date: Fri, 27 Mar 2026 12:28:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Subject: Re: [PATCH] wifi: rt2x00usb: fix devres lifetime
Message-ID: <acZp5kY0U_dTfbD_@hovoldconsulting.com>
References: <20260327104726.1310327-1-johan@kernel.org>
 <20260327110730.GA16592@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327110730.GA16592@wp.pl>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34058-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A36434371D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:07:30PM +0100, Stanislaw Gruszka wrote:
> Hi
> 
> On Fri, Mar 27, 2026 at 11:47:26AM +0100, Johan Hovold wrote:
> > USB drivers bind to USB interfaces and any device managed resources
> > should have their lifetime tied to the interface rather than parent USB
> > device. This avoids issues like memory leaks when drivers are unbound
> > without their devices being physically disconnected (e.g. on probe
> > deferral or configuration changes).
> > 
> > Fix the USB anchor lifetime so that it is released on driver unbind.
> > 
> > Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
> 
> Fix tag is wrong (and also cc based on it). Tag should be:
> 8b4c0009313f ("rt2x00usb: Use usb anchor to manage URB").

Of course, thanks for catching that. I'll send a v2.

Johan

