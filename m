Return-Path: <linux-wireless+bounces-4758-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DA487C16D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DF82838D3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F21E529;
	Thu, 14 Mar 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fTfSIDax"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095551A38D3
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434426; cv=none; b=FgYHWWdNZkmUsLc60B/znTOJnH6WwlEiC8gYP9ePy8n/trMu6ae6ZnrYsp5NZ9OKQ1sryvDksoHjlx+AQ4/QpI3jyv3ahNywd1akPtYaeoQ/lM1BR4VaIdHyDgF0F1sAhBALkKVrP6irp7u4bPOblbAwetOXNrCiLtKfgXMdoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434426; c=relaxed/simple;
	bh=fWUZWbEw+2XQpk/EYWnhghMEg9TPVP8WZT6OuIh7+z8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X4/DIcrFUqq94wwjeJth58ghN65CGRQAByaHuVzZ8AVvG1LsvUe8B8doMoZuJ/86BaKV9QZMeRV6t837QJ6mqDktosTVo5FvAAFQ/UlsLeu5s32kwpyyXrw9dssTGZsVMV1ufFwi8Nv0m/yoOTd6e/3s/enonpcelccbqu3Uk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fTfSIDax; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SImOeAnTaQXjHzU48ELqSSVJTwXG5901RooOWXq9JU8=;
	t=1710434425; x=1711644025; b=fTfSIDaxlC1QbLmWCoPy0jT9vVsJ/QNo8TrOwiTlbWJkaS+
	IjWQOM4o0kntFPoH/DV10VhMtr2EczkUgm3LX0W/tbOl98nPAKJhSs9YyiG7SyVyJU2M5XHr0qMd3
	RDu8J2MqbMVx1KtDFvCdC6YutAqLQq8FP3kqwPY6WTM144hKDMID8v+ST//D9zUv6RRdPcrj1K7we
	QyKQCwiNWCosJeGc1v83ZUn+WLpiXAu5KuiqnMsIAuRKIHA8xIi53nf4814li5IiIm7K96NNWjx6j
	AQ1Ts/oQ2veTISNabXNlj81uSj/b/t7xi5M9in51bdcF11opzL6MGW8ydoXWtV0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rko7y-0000000GgVH-0DOV;
	Thu, 14 Mar 2024 17:40:22 +0100
Message-ID: <db6a60e0dbd66f307a5890d958f67029ad5bcb4f.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, ath12k@lists.infradead.org
Date: Thu, 14 Mar 2024 17:40:21 +0100
In-Reply-To: <87plvwepjq.fsf@kernel.org>
References: 
	<20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
	 <20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
	 <87bk7g4x08.fsf@kernel.org>
	 <09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
	 <87plvwepjq.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-14 at 18:39 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
>=20
> > On Thu, 2024-03-14 at 18:08 +0200, Kalle Valo wrote:
> > >=20
> > > > -		hw->wiphy->flags |=3D WIPHY_FLAG_SUPPORTS_MLO;
> > > > +		hw->wiphy->flags |=3D WIPHY_FLAG_DISABLE_WEXT;
> > >=20
> > > I think we should add the same for ath12k, right?
> > >=20
> >=20
> > It's really up to you, I think. I'm hoping to even get this into stable=
,
> > FWIW.
>=20
> ath12k doesn't support MLO yet but I feel that disabling wext already
> now would be consistent from user's point of view.

Ah, you're in the situation where wext is still enabled now, but will
disappear when you enable MLO.

Agree then that it would make sense to disable wext right now so it's
not a software upgrade for the same hardware that removes it.

johannes

