Return-Path: <linux-wireless+bounces-32979-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC+/MSI9sWmAswIAu9opvQ
	(envelope-from <linux-wireless+bounces-32979-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:00:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2A261924
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 11:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 717BD3088EF7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEFF362141;
	Wed, 11 Mar 2026 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cfEu3QuQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9136C9C1
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222950; cv=none; b=K9na71BkETxIjjEMAT/ZrWJacvHBw0rgPYcRDAgIGQ9HDR8V+YVUpYzbpbfYL0XkclDODsNirM9sqQcsa2rgo+iKfAJgAK+eO7cqE66zsg5FDoTdhxsiQcGS3edd4LLnBb7x8xSg62RB9djxQJEN7ycgrPAQPPuxbdLwNZNgZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222950; c=relaxed/simple;
	bh=J9Yy1fu8gmb8SfspcDR/yyGwRqVEpLhted8Ej0YEKmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHgzzcaPGn1K89+DQ0+egbHecEH2UQcX8p+wmPL/q0EpLkLILQCX5kNFr7tjUbdGzckrjF+CJpVLnS9uy3rKlHYyWO171wG/up1wUwn+kbqFWQBgO7e2XeA24uynYKG3aVnYXG4Bgfym1j+spnD5pLHtI+BWqX6ubNWPncoXnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cfEu3QuQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vwxq554bUy7QYrvE7JbXJS5oDK3hznS+FcdYMtwvF1A=;
	t=1773222949; x=1774432549; b=cfEu3QuQfx0tQdwewKo6m7h2c5TLTGrTU5hvBVQS/xR5jcA
	CEkpxr2Hc2ZI+KSyBmvrSZrmDrt96azryKCyDrCSu5rUASllLOsCJVgglbf3s3Zt16SU/IqDzAery
	XEssG87ORsyW4LDpnNvX0maLWljhK4ITI8LY6P8+V/o2trhKvBKvg6D91nYIEFUotSbIQeKOAxH/S
	wEPhLoXPB0lRTHeLtCIWTm1H8uzzPRqJ+JMIfbvWykGMUR1JS8ZfIqc71n8/wtmJk4JciStDp6vsF
	LcnTBpPlWz8w7Oz0ggYw0h8z+8nGnfDpG8WAvq8yEn4Ozl4T8e0yQRdXyv3qcyyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0GI7-0000000Emx5-1WNY;
	Wed, 11 Mar 2026 10:55:47 +0100
Message-ID: <791eaf8ab04dcbe01e2d71612d162f71c61e573a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: init S1G properly when
 creating chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 11 Mar 2026 10:55:46 +0100
In-Reply-To: <20260311064339.524758-1-lachlan.hodges@morsemicro.com> (sfid-20260311_074401_065972_89BA6CE0)
References: <20260311064339.524758-1-lachlan.hodges@morsemicro.com>
	 (sfid-20260311_074401_065972_89BA6CE0)
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
X-Rspamd-Queue-Id: 15F2A261924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32979-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-11 at 17:43 +1100, Lachlan Hodges wrote:
> When creating a chandef, the initial width is determined by the
> chan_type argument leading to a default width of 20/20_NOHT/40 which
> does not make sense for S1G channels. Fix this by ensuring we default
> S1G chandefs to a width of 1MHz.
>=20
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> ---
> v1 -> v2:
>=20
> - Remove the mac80211-based wording in the commit message and keep it
>   simple.

Thanks :)

Now with more tea and all that, do we really want it to completely
ignore the width? Should that be documented? Almost feels like it should
WARN if you use it wrong, with an S1G channel but a regular width, and
mac80211 should be fixed?

johannes

