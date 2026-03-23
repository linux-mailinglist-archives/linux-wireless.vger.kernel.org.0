Return-Path: <linux-wireless+bounces-33687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PS3AYr4wGkwPAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 09:23:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AEB2EE3B2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 09:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC2D301494B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF38371870;
	Mon, 23 Mar 2026 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n90NPObo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C783E36EAA8
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253887; cv=none; b=ZMSB8wlnXuxThslQqoN81YnDlGMjyJ21yPRSsoEfjViZSV/EvKT5uX8PLzOiiMUHEUAxJpE+ovoaX4LsHZwSG1UaXkEORiZfrHVuhEPP2oz5NX1ZIeAbq3fg8/1YEof1umj0IFwxUYUKEQdXRkf7iWP+zeQ0E4+qGpGFCSitgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253887; c=relaxed/simple;
	bh=Td7+EKOiNHjXxN7wHmlTfOg1CFWPKcCO9svWUymt38Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YoT5d/ylmvNtNmi72x1UxCcpw2ZPsCBZ8PwDUB7pXkki6/fVaunQjO2D+8YxC6VCwB0vCVGMuAu5dHdrrjH8xL4MrWhGukFJjinTtoPPSUx55Wse7+3lr1P6VUrp7CX6vrzK1t9GLzcNdNmNtcrBKmgZZ849rMunTn2VhrA70G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n90NPObo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Td7+EKOiNHjXxN7wHmlTfOg1CFWPKcCO9svWUymt38Y=;
	t=1774253884; x=1775463484; b=n90NPOboHxxi7hiHLZXlgR18qkO5UBEnVEMUTDwM3GDUmkL
	KuSesbbNEpXepfL37/1UxiElt+Vv67T47RdLCA8M4rdfH43R3r/qvZMd6smqvmWArwzOlTyFp6yqM
	Vfj7nL1t/L2Os13blVLg9M1DiXV3JACyYCZE6No3EnP25kIzEHBwm5kjOSzh7Jo5V8o9ZSH1Xor0Y
	uzjlESx8cPDT5Osmo6wCrQoGcdv90oaQ8C9COWomj0WSEY46743FxlV+s1mJDuTuLwAviGrM3TYk3
	AwFOMNP9iCqEik9qQ4pzxHPFSSQX4g3rb74k6E9RyXrTjd7RRdcHRO8aLKr9as6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4aU0-00000009dHr-0P9r;
	Mon, 23 Mar 2026 09:17:56 +0100
Message-ID: <99567d484a37d7101ae51ea6f022f40ef469d81d.camel@sipsolutions.net>
Subject: Re: [PATCH 11/12] carl9170: skip cross-band channel changes during
 software scan
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 23 Mar 2026 09:17:55 +0100
In-Reply-To: <73153743-e0e8-4f2d-8774-066f53460511@gmail.com> (sfid-20260321_225837_658503_FA497F52)
References: 
	<AM7PPF5613FA0B68A6825857195D5EF51B59443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
	 <73153743-e0e8-4f2d-8774-066f53460511@gmail.com>
	 (sfid-20260321_225837_658503_FA497F52)
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33687-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,hotmail.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 61AEB2EE3B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-03-21 at 22:58 +0100, Christian Lamparter wrote:
> >=20
> > When the adapter is associated on a specific band, scanning channels
> > on the other band produces no useful roaming candidates for the
> > current BSS.

This sentence is so clearly wrong, I don't really even know what to say.

> @Johannes: Is this "stay within the band" something the driver should do,
> or could this be moved up to mac80211/cfg80211?

It's something neither should do.

johannes

