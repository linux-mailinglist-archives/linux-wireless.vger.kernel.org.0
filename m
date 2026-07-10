Return-Path: <linux-wireless+bounces-38845-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2u6KQ6fUGoh2gIAu9opvQ
	(envelope-from <linux-wireless+bounces-38845-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 09:28:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4E7380BE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 09:28:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=WRiwlenz;
	dmarc=pass (policy=none) header.from=dolcini.it;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38845-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38845-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E54FE306643E
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 07:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405A390C8D;
	Fri, 10 Jul 2026 07:21:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72C399897;
	Fri, 10 Jul 2026 07:21:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668118; cv=none; b=sH3fo02QY/mpe+Ne7vfj0eqVAKP3VjitIepQ7cr4S+i048NOkcVs18W6DmLR9U4t0fWLzcP05s2N8BEkfMSVQ0eIsphGRX/r4BZXl4vVZ41yLrSTQ4Oo5JY4CAJltAh2LgCiVIOHwrgrToDik7gZGYQ+m6DajCeEcVU7J39FXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668118; c=relaxed/simple;
	bh=uU9BCEeNLaY2/FaO7XUYT2Buvtu/Ccj7D8yRIZWVqjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+6c0QghkQ4CkBd4u3uUBl7GMn09E+INjaf6PdUnJsgvwF+Z6HWCOhfrFEtnHEXcn11MdpQarHgUO/GznKGbJVZyGjL0JTLxTWwK1gsOJwtpPhu/svPSMOA+CE/lTxYCDA8QWeWApOfPVlu2V/jd0tvn7WLn5MfoO9FpCgXWdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WRiwlenz; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (2-224-10-13.ip168.fastwebnet.it [2.224.10.13])
	by mail11.truemail.it (Postfix) with ESMTPA id DAF9122D89;
	Fri, 10 Jul 2026 09:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1783668105;
	bh=LxRI6Fmp0TeW1aH+Cx22+HIlW4OpT07Exwi65OCIuXo=; h=From:To:Subject;
	b=WRiwlenzEGDT/RqHU0R2aGfQyfX3wzfTiDFEWKAeaBk1gJxCVF3+wHOF4DhkVE6J3
	 w0g0HgZbbTyLx0e9NoO02uXIFCF8GagvIho1DSfRu/cByc/JECVzeJffwyWrOBszy2
	 0qrMhRHruEBt01ZTxEDTXTN7xdNcP0dYNvFRAkZ3BdS5rEMLh3WWA9Sq6dc/WGY7tx
	 oniTwQ2Tp+b9wz39RruNYtOJUyIxY/2jPh/Gx8XAAyrLKQfGCKAz7D2UyEnm/4Ryx4
	 f0D5e3zKusowSMCSb7s5Et6YArDA/6zHj6X/Sd8Lc2pTlwL4/umTNLrIpsTPBsTs/y
	 GjDZFYwTAHUYw==
Date: Fri, 10 Jul 2026 09:21:40 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>,
	Brian Norris <briannorris@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: bound uAP association event IEs to the
 event buffer
Message-ID: <20260710072140.GA17790@francesco-nb>
References: <20260629120333.94222-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260629120333.94222-1-skyexpoc@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skyexpoc@gmail.com,m:briannorris@chromium.org,m:johannes.berg@intel.com,m:francesco@dolcini.it,m:miriam.rachel.korenblit@intel.com,m:kvalo@kernel.org,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,chromium.org,intel.com];
	TAGGED_FROM(0.00)[bounces-38845-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,dolcini.it:from_mime,dolcini.it:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CD4E7380BE

Hello Brian, Johannes

On Mon, Jun 29, 2026 at 09:03:33PM +0900, HE WEI (ギカク) wrote:
> mwifiex_process_uap_event() handles EVENT_UAP_STA_ASSOC by exposing the
> (re)association request IEs that the firmware copies into the event:
> 
> 	sinfo->assoc_req_ies = &event->data[len];
> 	len = (u8 *)sinfo->assoc_req_ies - (u8 *)&event->frame_control;
> 	sinfo->assoc_req_ies_len = le16_to_cpu(event->len) - (u16)len;
> 
> event->len is supplied by the device firmware and is never validated,

I think we received a few patches that are validating the data received
from the firmware (including this one).

I did not review any of them yet, what is your opinion on those?

Should we consider the firmware trust-worth or should we validate
everything we receive from it? Is there some agreement on this topic in
general?

Francesco


