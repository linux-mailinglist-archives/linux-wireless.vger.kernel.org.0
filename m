Return-Path: <linux-wireless+bounces-38420-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o4JnH2Q6RGqHqwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38420-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:51:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF796E839C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:51:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="m7A/Hc15";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38420-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38420-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B92843030115
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544DC2D739B;
	Tue, 30 Jun 2026 21:51:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F07266576;
	Tue, 30 Jun 2026 21:51:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856290; cv=none; b=ZrAUTAXDtB1dYOeaHOJJgNHJhT3UByBd6YJ84BmtF9xlpbMa8ho8kCMwfxTlQfIzkHTN5kSCpfqqo4OXgcYxX/0WpZZgKMxTjryAmD3MHbgu8gZ4C0Veq6XHsY+tpzTwbgyMbf2ljo1OCdMDnpBmpQ9dJjQl7wU89U0gUQCgE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856290; c=relaxed/simple;
	bh=edpMslYdQ4suQQYZ0fpPVhs3/NvftDGtLCzkTzvy+84=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=FPad9nBl62KobG22mSh8/pGqrI1/oh5gJ5AnONTNm1UM+SpF9+rgLChE051PDl49Z9j3mjrkWMoB6pYudqBZB5nj7hoLEKHk11+QP2lovQCZsXDWurq+1UszzhzzI3i9dVvoYMjF3CcTzryI9/gFt36op4RJ+Fb42RYKqtuO+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7A/Hc15; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267DC1F000E9;
	Tue, 30 Jun 2026 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782856289;
	bh=edpMslYdQ4suQQYZ0fpPVhs3/NvftDGtLCzkTzvy+84=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=m7A/Hc15Pch7waVVQKngS9RUrdfRy+Y28mzmEEV0fYso7nyI2LEg8JJDyIh+7Bqbd
	 zn/QkdLOYItfq9DetZPC4qNCVUh4irtsoHOIW3Fo+Jd4xbvNtsTFAOb403AJIv5DOc
	 X09FAz/TsOu1+kATHxURNSMVYD95h75E4OprToGt5G4ahyq81ZMvQMFGgbR9COG2B7
	 J7KIuJcfktkd34iqE85FervA9z5WOiLQzOUL+EGn3rRp1NJgEbe966LOL0c0/H8DT7
	 ZLb8gtC6rNHEwo1bd3F7gd7PNAavY/aid1LYSfM1asAIxr/dH7Qa1guBpqVOUH5GRJ
	 uSLaJuk60ixhA==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 23:51:25 +0200
Message-Id: <DJMPT2QY8TTO.39DLGWZ2Z21U2@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, "Johan Hovold" <johan@kernel.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <driver-core@lists.linux.dev>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/4] wifi: ath9k_htc: don't keep usb_device_id
References: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
 <20260630-usb_dyn_id_uaf-v1-1-160a02be5ac2@garyguo.net>
In-Reply-To: <20260630-usb_dyn_id_uaf-v1-1-160a02be5ac2@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-38420-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBF796E839C

On Tue Jun 30, 2026 at 1:38 PM CEST, Gary Guo wrote:
> usb_device_id is not guaranteed to live longer than probe due to presence
> of dynamic ID. All information apart from driver_data can be easily
> retrieved from usb_device, so just store driver_data.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

