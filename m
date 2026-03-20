Return-Path: <linux-wireless+bounces-33555-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDo3Oub0vGms4wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33555-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:19:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AED2D683F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121DC3031808
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 07:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C4274670;
	Fri, 20 Mar 2026 07:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HOsbeRkC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A846BF;
	Fri, 20 Mar 2026 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991140; cv=none; b=mgJxq0pEeZdUUF0Gmyn7cwma9QPcF2vEStQtg+CA1ICTScmy1RUZvBQVL5MJQ/DVJpYoWs5WCZ9EN/oy+KuF2zBt589ToFWeGrfeJdwqOHekNOoJVO2DaSzs9dzGiFo7t+KUlHovPByEtTkMDqcuwhkkjQ7VR3Gh8QSVzkUmDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991140; c=relaxed/simple;
	bh=AEqQPYUEZ4vsLq2WyrblhoJ6ilvfdqPVGj7c7wf970E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LjHcpjsaS+C8bVKYZcVodAawjPK6KzoO1hsUvtLZapzAWnxPE5RC4/a4jVCkuWCSAAkdW36Uk8XibaD90OyFGqHc6NbvsutegsG0QDr99vWK7wTCJjmOZ2sL7NpkEKNMVLC6KNeOBqzymhy5k2Opxb+1bvi0N3D+oapWyY51NmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HOsbeRkC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AEqQPYUEZ4vsLq2WyrblhoJ6ilvfdqPVGj7c7wf970E=;
	t=1773991138; x=1775200738; b=HOsbeRkCyI38PfSKlgARiOSsolpCLx91bGaZCoxW9dPN0rF
	IcizZ6V7uPHoY9bkEykUSAmFvF25bi1ddEACRfpbsImglT4WBkK4u96oaq5NyodWNUCyCkTuZtDtc
	PW7ZTLFf9xf/vAMjtVtwUltmYRsvOpRXCUDWgD9+g+Mi5fo1IL5jS1Ikl6R6bpy/LbyJDK2ODvrD+
	3i558hg2S5unTE/CIV08TBR2gwKPTa+hLGXFxHK30OYS//gAbxz2dBKmDc0AeZyEjhTTd8NvYOK81
	Tr1rDJab4XnSRHpVizLWWB4OqoWBIxFmipLR5LJVOXMr8fF4BMo6p+6GRNxlcC7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w3U8F-00000006T5W-2DnO;
	Fri, 20 Mar 2026 08:18:55 +0100
Message-ID: <7339202222542df9858308d3a42f438b4abf516d.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge	
 <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 ayman.grais@morsemicro.com, 	linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 20 Mar 2026 08:18:54 +0100
In-Reply-To: <x2c5mvplhtdfl7u2m54roosjtxjhzab2kq6tpqmehbmauiwvi2@gsktg3ztlhng> (sfid-20260320_073931_534695_7E5DC23D)
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
	 <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
	 <a04a91f1203609e89df97cc950bb2af37a66aee5.camel@sipsolutions.net>
	 <vttdls7sm4h3br7y5kcea5i4teqnuiuzgq3miswg6r45asvng7@jto3tksuvofj>
	 <1ca86ec4a1af1edfb791ca65023ab1979507c5bc.camel@sipsolutions.net>
	 <zcuk2lw4crrx77pel7rjzy6g4dae77psra3sfiytto4ap3b2nt@io3xv6gob7dz>
	 <888ab7ed9c72d19765e87f00b17dd95963cbca18.camel@sipsolutions.net>
	 <x2c5mvplhtdfl7u2m54roosjtxjhzab2kq6tpqmehbmauiwvi2@gsktg3ztlhng>
	 (sfid-20260320_073931_534695_7E5DC23D)
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33555-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 53AED2D683F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-20 at 17:39 +1100, Lachlan Hodges wrote:
> >=20
> Thinking about this a bit further, the initial items on the todo
> list are more or less as follows:
>=20
> 1. hostapd support (mostly unrelated, some minor tweaks to hwsim)
> 2. Rx reporting - mainly mac and cfg with some minor driver changes
> =C2=A0=C2=A0=C2=A0+ usermode aswell
> 3. iw and iwinfo support (again, unrelated)
> 4. extend regulatory support - this will be a big challenge and once
> =C2=A0=C2=A0=C2=A0again mostly cfg and mac
>=20
> So most driver work would just be plumbing through any required
> changes for the above, no large features in the near future.
>=20
> > which is probably simpler if I apply driver patches too,
> > otherwise you have to synchronise pull requests to when I apply patches
> > to my tree? OTOH, to pass the bot checks you already have to do that
> > anyway, unless sending cfg/mac/driver patches in one series, which also
> > isn't great since it ends to bury the cfg/mac patches.
>=20
> Initially that works with us if you apply the patches :)

Works for me too :)

> I have made an account with the user "lhodges" on patchwork - no
> issues with that.

Nice, thanks, I'll go request you be added as admin, so I can delegate
the right patches to you automatically.

> We haven't got a public tree tracking wireless-next
> yet. Nothing necessarily blocking that except internal processes, I
> assume there's no issue adding it later?

Indeed, no problem at all.

I'd still somewhat prefer to have the initial commit as a pull request,
but if you really don't have a public git tree now you can also send a
big single commit with all the right things to me in private, and then
I'll put it somewhere and send it to the list. We can figure this out
either way, no big deal.

Thanks,
johannes

