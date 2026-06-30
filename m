Return-Path: <linux-wireless+bounces-38423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KDdBOGg7RGrSqwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:55:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C56E83CB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:55:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dCg0wK7L;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38423-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38423-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D0D3047061
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACB313E00;
	Tue, 30 Jun 2026 21:55:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782C224B04;
	Tue, 30 Jun 2026 21:55:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856549; cv=none; b=k1RVh0q59DP4nGsY7qMQL4gDNTtqct6wzASbZtmGj5n53JFBC3yZGLLhOTz0e6HUkm1p3vM27iW6L1BxSPU8Ct2wX5M06hinhYHtpHtPCf/7otSSCnQu/9oKUkkpNN3R7XgU381+v7W5yet3A+ERR3z6pPskcatse+jxHdA/Kg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856549; c=relaxed/simple;
	bh=AzgWfUadsxXXl91k1YepQX3sOGSydX+rniN6XnLDOWk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=b2oakdQdUltpWLWyABplN5YILrb+HuEZbP5KDE3tF1A+EW/eOp9lRHr4U5pu8GSZEYbMPbVL0K2W66CG5uWxeJxsgHgWvryFNcMFNPMLW8g6U4AgPXPtdMqGaS8gN269czppm0VTplk7azcOl9gVhW/TROEvieAG+jkkPkEsjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCg0wK7L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313291F000E9;
	Tue, 30 Jun 2026 21:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782856547;
	bh=srQ9IMbSxBsXUogcwFbDc7WcbubgWp0stEVi0zSwC6E=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=dCg0wK7L3bAkrxJoAbg45PoI34akiDZgSlNyyLIAamfVjDexyiIkIfvKLOe94+e3h
	 fYu1HtabqCs0J2HACQlB6vjzzMebaz+UPBSdWNfQ8fnzZlXcnqTCzsqly4aX6yNOGj
	 W17JJH8WW8KES68nl8XgWsN7nEuzreDQm11jUX0h/4hW6VrG95FrP52muTNxX3YRwP
	 mGttoi80U+NS9u07u+uup/j3Gn3/keNvW5kO89L0DeBkqxW8bSBoqew2mvdhntxVeV
	 uP/dY+tk138kjMIyqJRLDYu4+0jNMOTerwGREgg3YmQQrr/DY0nli4SRh60DZGMGWM
	 tlpozJ+B+IB9Q==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 23:55:44 +0200
Message-Id: <DJMPWDSKN8C3.1Z3RQ8WGH563R@kernel.org>
Subject: Re: [PATCH 4/4] usb: fix UAF when probe runs concurrent to dyn ID
 removal
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, "Johan Hovold" <johan@kernel.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <driver-core@lists.linux.dev>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
 <20260630-usb_dyn_id_uaf-v1-4-160a02be5ac2@garyguo.net>
In-Reply-To: <20260630-usb_dyn_id_uaf-v1-4-160a02be5ac2@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38423-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:toke@toke.dk,m:johan@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:driver-core@lists.linux.dev,m:gary@garyguo.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 561C56E83CB

On Tue Jun 30, 2026 at 1:38 PM CEST, Gary Guo wrote:
> @@ -320,7 +321,8 @@ static int usb_probe_interface(struct device *dev)
>  	struct usb_driver *driver =3D to_usb_driver(dev->driver);
>  	struct usb_interface *intf =3D to_usb_interface(dev);
>  	struct usb_device *udev =3D interface_to_usbdev(intf);
> -	const struct usb_device_id *id;
> +	struct usb_device_id id;
> +	const struct usb_device_id *matched_id;
>  	int error =3D -ENODEV;
>  	int lpm_disable_error =3D -ENODEV;
> =20
> @@ -340,11 +342,12 @@ static int usb_probe_interface(struct device *dev)
>  		return error;
>  	}
> =20
> -	id =3D usb_match_dynamic_id(intf, driver);
> -	if (!id)
> -		id =3D usb_match_id(intf, driver->id_table);
> -	if (!id)
> -		return error;
> +	if (!usb_match_dynamic_id(intf, driver, &id)) {
> +		matched_id =3D usb_match_id(intf, driver->id_table);
> +		if (!matched_id)
> +			return error;
> +		id =3D *matched_id;
> +	}

I think this could just be:

	struct usb_device_id id_copy;

	if (usb_match_dynamic_id(intf, driver, &id_copy)) {
		id =3D &id_copy;
	} else {
		id =3D usb_match_id(intf, driver->id_table);
		if (!id)
			return error;
	}

Avoids the unnecessary copy and also results in a smaller diff.

