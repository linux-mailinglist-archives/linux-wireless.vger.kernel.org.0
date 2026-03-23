Return-Path: <linux-wireless+bounces-33688-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E+HGBn4wGkwPAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33688-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 09:21:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4DB2EE38D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9A3E300796A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D336DA14;
	Mon, 23 Mar 2026 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HVaF4llo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25329BD9A
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254102; cv=none; b=WYxtcCbW8QJZ6Npu1B+GURU3yYCO4A5Sn6bnO5rA5MnhG5S2KWZmohy8WiEm9Dm4Tjx1PJUiun3n859GcadM5/puWHzykHI0d9oYnmCsv7FsClu2ssti1rf+k8DFF0Dd5ef+htpxCwAKHqD3JwEPPCyxinM8t3EVkqUIfdg1N7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254102; c=relaxed/simple;
	bh=R0LArFFEdFDRRLrwgPM89Aqc4JJy2PcPnDWgs/JYPxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rqiU+b+L7Ctf56L9ZP/w+bqSZyzKhK6B5MzFJgEHUAL2Ld+MlFj65DrWtUKp7l2xAlPPXhn94Gh99PIA3Ddr0pyG/6iOVL5n3UwCGBC9b66XbR+I093sCc09J8Hs45tKJtMSmVzG1cVN5G54Kn5cOTxq92eaUNa3mAmMehiNQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HVaF4llo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=R0LArFFEdFDRRLrwgPM89Aqc4JJy2PcPnDWgs/JYPxw=;
	t=1774254101; x=1775463701; b=HVaF4lloUBsiOAtcNTmaEhEOuS/4qwgJ6tB0WwMsOi4j364
	JYxQIUk547l9aBhuN/LPealeJv9vIXga/ZYFZ7fNDchfj1VGLa6f8i4OUz5ngNxh2hNLEOr02j2e9
	OILgmTzcokJ6DOYTzegVsEkqAuxY97pypEz2uLq2ulx++CP+RN9mMUVbVQLC++m4LEfsA+GOxD0lQ
	Bat5F4TutTHuW2OMhMRaR8vAfWcGBf79JDkICNEg2t/d0XWb7oZF6ocQVF4Elc1ik3NzJb2MfxDtd
	k8X4N+pkC4qUUng9OWGWijyWi88rllIpdVspD74hY61euCztVTqcbrB7IxGp13zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4aXb-00000009dNj-1XGO;
	Mon, 23 Mar 2026 09:21:39 +0100
Message-ID: <31bc4e5e701190d1fb00908f521145dd00095f66.camel@sipsolutions.net>
Subject: Re: [PATCH 11/12] carl9170: skip cross-band channel changes during
 software scan
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 23 Mar 2026 09:21:38 +0100
In-Reply-To: <99567d484a37d7101ae51ea6f022f40ef469d81d.camel@sipsolutions.net>
References: 
	<AM7PPF5613FA0B68A6825857195D5EF51B59443A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
		 <73153743-e0e8-4f2d-8774-066f53460511@gmail.com>
		 (sfid-20260321_225837_658503_FA497F52) <99567d484a37d7101ae51ea6f022f40ef469d81d.camel@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33688-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,hotmail.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE4DB2EE38D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 09:17 +0100, Johannes Berg wrote:
> On Sat, 2026-03-21 at 22:58 +0100, Christian Lamparter wrote:
> > >=20
> > > When the adapter is associated on a specific band, scanning channels
> > > on the other band produces no useful roaming candidates for the
> > > current BSS.
>=20
> This sentence is so clearly wrong, I don't really even know what to say.

Well, actually ... I read "current BSS" as "current ESS" since otherwise
the sentence is true but nonsense, since roaming obviously involves
leaving the current BSS and joining a different BSS in the same ESS.

johannes

