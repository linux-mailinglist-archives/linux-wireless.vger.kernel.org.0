Return-Path: <linux-wireless+bounces-38422-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8XehE4o6RGqgqwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38422-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:52:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8086E83AB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:52:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BmvDpbkc;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38422-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38422-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A4503010CFA
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F52F7F06;
	Tue, 30 Jun 2026 21:52:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611701531E8;
	Tue, 30 Jun 2026 21:52:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856325; cv=none; b=CxM44oeg98246htN9MgPNYynvWkss5yQjTIlR2Hl80Ls79eW+yePOm9LYisePUouyejunvF1rKd0C8n7vhe+/EXRR6FYSr8KvRyUGD76Ess2Ga7xUq3Ci0ZYgcE1HVUQp1yo6hvTPfGDV+XnkGy2GhTes6l/qRrrw7PGWwP8Xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856325; c=relaxed/simple;
	bh=8JiTjT5Lrqsx/ou5nc3RDpYw9aXzkKLqhT9tlPUe2lY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Hu/WuUW63hHQ0L49db1ghT6T7DK3TmzEIahqwGFqu1iy4ZoEwq3GxbSbgy2IpxccS4DVV7oSYVgvp520dP1MAeMMy1jSOvHUFtbPzckhhlipXWB5uw/CoXNy6w26mD5U8qr+FRi1STeZr7jI9q9al1Tte+wm3JPN1Cj8FxsXD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmvDpbkc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D301F000E9;
	Tue, 30 Jun 2026 21:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782856324;
	bh=8JiTjT5Lrqsx/ou5nc3RDpYw9aXzkKLqhT9tlPUe2lY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=BmvDpbkclL7RvwJJXqL+tIOJ+TeLHCqo/H4wLUG/20aHB7tpTy8PyToDfQLJhuFvH
	 5ZHnNKih9HdLwy5NeqyUFQm1MJfKflHZWDPkpFKXFNdKGqRMYW8itbl48MThGDIT8r
	 UWJd8Iu8KQ86fNw8TX9JXxWVnqlNef9QAph5jiSQ3k98Mr/KBBIifL3SEUvsWYkk0O
	 kZXI7+lgIQ2sAwYyxsT6k9keBwmes2RIOpE5pYH4cYbyiIsTWtBDazAb6A25jOK7pa
	 DnqINSq6Z2yEqAvzd5DRja/g6Dv+ng/Gwdno6LA2Tczh8/cyzCD5Gax6xDzwgM+2rI
	 vjW/Iu7hldm+Q==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 23:52:00 +0200
Message-Id: <DJMPTIYEGQ6S.BYJ6RF0WWBX0@kernel.org>
Subject: Re: [PATCH 3/4] usb: serial: spcp8x5: don't keep usb_device_id
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@toke.dk>, "Johan Hovold" <johan@kernel.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <driver-core@lists.linux.dev>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260630-usb_dyn_id_uaf-v1-0-160a02be5ac2@garyguo.net>
 <20260630-usb_dyn_id_uaf-v1-3-160a02be5ac2@garyguo.net>
In-Reply-To: <20260630-usb_dyn_id_uaf-v1-3-160a02be5ac2@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38422-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E8086E83AB

On Tue Jun 30, 2026 at 1:38 PM CEST, Gary Guo wrote:
> USB probe functions should not keep usb_device_id for longer than probe d=
ue
> to presence of dynamic ID removal. USB serial does not support ID removal=
,
> however in this case only driver_data is ever needed, there is no reason
> keeping the usb_device_id in the first place, so convert it as well.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

