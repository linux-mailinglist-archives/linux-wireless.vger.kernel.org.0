Return-Path: <linux-wireless+bounces-34806-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LoJIi+z32lCXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34806-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:47:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2537B40614A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8745F303C535
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA8A3E0C71;
	Wed, 15 Apr 2026 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FmwtUiDv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EC54654
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267777; cv=none; b=senmyLRLJOsBfTk6W4lzGYM84/EdSQspHOFStyt/lB2N93C1xj/KBoesAFmjNSCkNCfBIhMKPDBwA8ma6Qj2FfdgTagcLLsqpHwRWJP0MBjKE2LxOV2WjLEYpoWtW1pte2C7pie1OD66/JiNwP8ctscmuEYFsuf5L2YEGpdHVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267777; c=relaxed/simple;
	bh=irTGmatTrTINJVCD4G9wJ1Ty5ok5Iw7O0G+YO5FwrJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mifTdKnGZxnwUVSnb29AlrkBZXA6uIAbQJ1OIKUWdIj5/meeOeHzUuVtrIXSSgw+96pLRBDb+qEBjgif0tNSJ7L9xdzCw9UryJHQ241RAWun82wEOeHJy/cp8fLoO8SnNBAo2Yc+s4XPsEzZApb+IdT4k5bvEc2xKz045L7KSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FmwtUiDv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=irTGmatTrTINJVCD4G9wJ1Ty5ok5Iw7O0G+YO5FwrJ0=;
	t=1776267776; x=1777477376; b=FmwtUiDveg065jP+Yh3ruXcLikiEaqeVMXvotYgeo5k2Lcr
	2ouLL5+flxvuP+FbPD7EKw2xTkJw3dDg1Y+iEknPXrzwHKZY+qxZmpgYFLI3jjeHzmqb6+X5NXC6V
	GzVJzB/BdwqcxqvLa16NYEH82xRVPdJmZTjAqGmYT3Kb27j9cwWlDKWoCzlKAAkqiWzIOYXwpywz1
	OlL/MAiUF3tE2tjuAi+N5wI/tEq0PFC4aNbxe5eSRR0Eg9l/tbBEaUEKwIcgcErgYTA7XzLVmTNKF
	1QVyqzqNxMBXxl+nY+DaNlCQH/9WAJSUqI+xFglhtoM9ScJBtUly6+jUCQCbC8pw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wD2OE-00000006UYK-1eU8;
	Wed, 15 Apr 2026 17:42:54 +0200
Message-ID: <b5a0822b7ebf8e816e096e6a628db6b21fad40ef.camel@sipsolutions.net>
Subject: Re: [PATCH 17/20] wifi: cfg80211: provide HT/VHT operation for AP
 beacon
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>, 
	linux-wireless@vger.kernel.org
Cc: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Date: Wed, 15 Apr 2026 17:42:53 +0200
In-Reply-To: <ddfdac5d-602f-4f67-80bf-d41924b0b7e7@freebox.fr> (sfid-20260415_172238_311476_04A5EB08)
References: <20260415124514.284345-22-johannes@sipsolutions.net>
	 <20260415144514.32ad98454543.Ia9692671b699164edcc0bdaf4fdbdbefc50b18f8@changeid>
	 <ddfdac5d-602f-4f67-80bf-d41924b0b7e7@freebox.fr>
	 (sfid-20260415_172238_311476_04A5EB08)
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34806-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 2537B40614A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 17:22 +0200, Pablo MARTIN-GOMEZ wrote:
>=20
> > + * @ht_oper: HT operation element (or %NULL if HT isn't enabled)
> Might be some nitpicking you can ignore, but HT operation element is opti=
onal when HT is enabled. With the current comment, someone might (wrongly) =
deduce that if `ht_oper` is NULL then HT is not enabled.
>=20

Not sure how you mean that, but not really? If the AP has HT then it
must have HT operation, otherwise the clients can't use it?

johannes

