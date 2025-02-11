Return-Path: <linux-wireless+bounces-18756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF1A30951
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1B71886C7A
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403CA1B86F7;
	Tue, 11 Feb 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kge65SVF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED670807;
	Tue, 11 Feb 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271657; cv=none; b=pcP5TabIFcXeulU9SKkqtuzvtRno2J+kdxYhpwQ5gFD7pj4yfX/Sxbw1f7q1fHSAvshyv1NM5n8SWvoLsGDX4Et+jp5EakwnVSfZ9VyVWgDWWbXb5GX/wfVdQEbYSVWLsQ6y6GDXRzTeyBYf8bX9/4CIUs51DjkPNdepEqkWUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271657; c=relaxed/simple;
	bh=7wvY0RQorhdIfmC+K3tmG43duVgxeoRacgzWGsVFdCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1yyz136aBeVzTUcuGUdojuMcGwEQvmNZRp9KVIZE02k3NyEwQVYvPTudd9n4BT6bHWlSOM8+XW2hCEJa5Xig88h8LpU6mAvJMg/QmsKd081CbeHMwxyRrIVOidPszwjouEyG2bUuvhInzI+U8rOv+jRZDntDPTwxympkbwRKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kge65SVF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7wvY0RQorhdIfmC+K3tmG43duVgxeoRacgzWGsVFdCE=;
	t=1739271655; x=1740481255; b=kge65SVFlbNLlEw8Ogq4apNAk0DJzJUBGq6iHobAxvzUUwm
	Y6Mmtpc+h9OP9wdQ0WuhVpFtC2BG7Ni/6CzuJr0KLYNz/gzMt1thJSPaf31esMrd6chXrWsXQtDJP
	wgR380MUeBFEiE3pFEedaogn+HH/1uHzUbzUiEJIeWmguMpV5vxIpxdhx0iS9ktpoYEgMK+G5p7MW
	tp5YO+HICd75K23XO99bz2LUIgzW7KN89Wk47W0kvzgAEyZfas9r68dN86JoBEgFjTd+W+idyizJ/
	+dY+rFRfjn8gF4TVHPqLTPbBhT/8BOYtoVmyIzay5R5U1r1ZN/oOifhAUpXmbASQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tho0S-0000000AuCz-1IKl;
	Tue, 11 Feb 2025 12:00:44 +0100
Message-ID: <c901dd501301c6cbfd53b1f942f5f87b810d5ed2.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v4 10/10] netlink: specs: wireless: add a spec
 for nl80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, 	netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller"	 <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman	 <horms@kernel.org>,
 linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com
Date: Tue, 11 Feb 2025 12:00:43 +0100
In-Reply-To: <599a281f-d468-4b92-8b15-6f1292888dd9@redhat.com>
References: <20250207121507.94221-1-donald.hunter@gmail.com>
	 <20250207121507.94221-11-donald.hunter@gmail.com>
	 <599a281f-d468-4b92-8b15-6f1292888dd9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-02-11 at 11:59 +0100, Paolo Abeni wrote:
>=20
> Also waiting for some explicit ack from wireless.
>=20

I'm fine with this, for the record, with the prior agreement that at
least for now Donald will be maintaining it, where needed :)

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

