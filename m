Return-Path: <linux-wireless+bounces-31541-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJIlLXJPg2nglAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31541-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 14:53:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C483E6B17
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 14:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58A430156E4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C440757F;
	Wed,  4 Feb 2026 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Cnq1KaNE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E53A0E8C;
	Wed,  4 Feb 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213122; cv=none; b=ua4GneV7sNhhcyVkPRRfqq54WI6hxoJywVuUvRgvzrjPZzzVX7kULBoe86bTFiLgz4I8qHFZiyIr3M1Iqleb+sEFkD3lHGgbJ05vjEDfO3MevdUiG1BlwaRUeoDgxIJHnpdY224Hd9MakhIYio1hQeOE72VfzFFvn3hxFbaiSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213122; c=relaxed/simple;
	bh=AsQa8W6KnKJ7vVh4W36ji+1sTPnT2pkn89GFbzErC2o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOHicCokLe1X7q389h6PPdQ9kJqi6oxb65JmdrVWUcXhCjUEWc4TryqspUj7bLU1Gf2clJEZHplcRNmVOSGVKo79p5VztKtPXAwKotOZuhvw20n9d3m4U7CiUvjj+cDJkU6K+BT7uihihDmxwhnALyULAQlUQ5Bp6tV3UYGzJIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Cnq1KaNE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AsQa8W6KnKJ7vVh4W36ji+1sTPnT2pkn89GFbzErC2o=;
	t=1770213122; x=1771422722; b=Cnq1KaNEv9DG6pjQw9+/F4NStAE2iOPkSZWL8jLWwnu5xdz
	n/+kOnIGJaQ5ld8zrQ42woDOs2Uf5sx3GXF9SOvrwfJxcpD4Y4Tn922sSZh4ivbq0zBp1BZ7iqKIr
	DNinJCpvF6xZGeqaugkkaSBWBLLbWrqhA7MjS0om7pRGoZ8JvQfJLsvc+T79i8XzEYPqO/HrDwvmx
	1NH96rDca5AK5TpoMXqjrRmiREyOD2hxacADWRSnu7x0rHD3RnMPXX2MQNuPeE1fUXBA6jDWUDKbA
	46Dgg+zP5/xyyaz2qrt6a9cETVVRkIpIYjNH1tsCqo1Tp5J6j5LUsArHUg78R8Sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vndIR-0000000EPxD-1SEs;
	Wed, 04 Feb 2026 14:51:55 +0100
Message-ID: <f3ef31b332a5f28a20054d5e55e6024421f14dd1.camel@sipsolutions.net>
Subject: Re: PCI ID conflict between ipw2x00 and i40e
From: Johannes Berg <johannes@sipsolutions.net>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Stanislav
 Yakovlev <stas.yakovlev@gmail.com>
Date: Wed, 04 Feb 2026 14:51:54 +0100
In-Reply-To: <CADkSEUhXO-01yaNUawo58MQ=xOC5bCDHWCFrCwe6TX2D+WVR=w@mail.gmail.com>
References: 
	<CADkSEUhXO-01yaNUawo58MQ=xOC5bCDHWCFrCwe6TX2D+WVR=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31541-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C483E6B17
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 02:15 -0800, Ethan Nelson-Moore wrote:
> I have written a script to find device IDs that are claimed by
> multiple drivers in the kernel. It has found that the PCI ID 8086:104f
> is supported by both drivers/net/wireless/intel/ipw2x00 and
> drivers/net/ethernet/intel/i40e. I assume the i40e one is correct,
> since that's what the ID is assigned to in the pci.ids database. Can
> anyone at Intel confirm this?

FWIW, I wouldn't be surprised if both are correct, and we just forgot
about an almost 30 year (I think) old device ID assignment ... I'll try
to figure out who even does these assignments etc., I don't know right
now. Let's see if I can figure out anything for the ancient WiFi IDs,
but I'm not very hopeful.

If we knew the subdevice IDs we could perhaps match on that, or add some
code to have ipw2x00 reject PCIe devices, and i40e reject PCI devices,
or something like that ...

johannes

