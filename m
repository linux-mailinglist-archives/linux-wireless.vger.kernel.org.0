Return-Path: <linux-wireless+bounces-35367-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHS6OkI+72le/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-35367-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:45:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D24712BF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 12:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30D73006394
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B383B27CC;
	Mon, 27 Apr 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SdzJBeFX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2C3B4E95;
	Mon, 27 Apr 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286719; cv=none; b=cjty0UKFlRdhlW35piMz/mn2yUZ+tW8urTlvpmmzN8VLNX2GtUtCFo3a+pu6BkMTb7ZIUyl/deOiKrbfVOud+z//3KPwg6a+wUFviZEq2mk+pxSqpBcJA6YI1YOZkqeQm1zHjb+jPgLsjN3p9s02LnQaHCd/FYr6JZWph6e9wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286719; c=relaxed/simple;
	bh=VtYJLfmVNV6imQ6Hf9X2nZ0Fcb0X3ElNfPfbCeceXag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jl8ZVLZkq4rdR0HGwdcAGJlYPv1milTn3dwBX8Nxpz4p0MT2FhP3CIsctaM5dzGpr5q8MaCgm059UAuCZ4n+b6xwhzQWrix7GcmXNuARmwMIGD7VDr+gol5ZLeK7AJoB6vs/tHS8W8e3bXOmsvql6x5TewpuPIiSVVRC4jXJwIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SdzJBeFX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/bKZE4y2KFZC2IPINmQnEO4uSxgR9T4zPwb3LLP6btE=;
	t=1777286718; x=1778496318; b=SdzJBeFXJkuQl9yVorDMylhBx5DboO9u9XthjV0whLSDLom
	OsvXN5cv+LEF+IwNtLEM8EcnOOuQDJJCFpihFI1ZTmcdG06KDYEDkO31L5m71XiWkQi4wtKSh1XEg
	waqdzvrWjkLrr7ApSDn2MP+Q6R9olEm8/vhLyTCOM673Yo108hudOOpHhFd7QnXt7g1uLY6XVVrUN
	NUsCLUtVl51RJN/DoPoYYlQiO+EIHzSw1cjg4+XeejJIoAWSHI/TJxO1eN2Ru26A8a3ofN25zuq2H
	/bWFmFCsaa/Dd0ff1+kPG6lLyyuDqInBYrx8lnymdcUBzuErmgJIudMHqkrEzBJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHJSl-0000000Eqr3-3Hzz;
	Mon, 27 Apr 2026 12:45:15 +0200
Message-ID: <c2263e4917557cb1e07a56c3bfb9a0507bf81f00.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: rt2x00: check for
 of_get_mac_address error
From: Johannes Berg <johannes@sipsolutions.net>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Date: Mon, 27 Apr 2026 12:45:14 +0200
In-Reply-To: <20260427073206.GA2096@wp.pl>
References: <20260427051652.954059-1-rosenp@gmail.com>
	 <20260427073206.GA2096@wp.pl>
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
X-Rspamd-Queue-Id: 481D24712BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FREEMAIL_TO(0.00)[wp.pl,gmail.com];
	TAGGED_FROM(0.00)[bounces-35367-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wp.pl:email]

On Mon, 2026-04-27 at 09:32 +0200, Stanislaw Gruszka wrote:
> On Sun, Apr 26, 2026 at 10:16:52PM -0700, Rosen Penev wrote:
> > is_valid_ether_addr is already a check of of_get_mac_address, in which
> > case it returns an error if false. Just set a random MAC on all errors
> > except for EPROBE_DEFER.
> >=20
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Are you sure? I just randomly checked one caller to see what the
*eeprom_mac_addr would contain, and I see

        mac =3D rt2x00_eeprom_addr(rt2x00dev, EEPROM_MAC_ADDR_0);
        rt2x00lib_set_mac_address(rt2x00dev, mac);

so that case assumes it can get it from EEPROM and override with OF, but
if OF fails then it would still use the EEPROM address as long as it's
valid ...

johannes

