Return-Path: <linux-wireless+bounces-9687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0D91BAA2
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 11:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823A11F24593
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8814F9D0;
	Fri, 28 Jun 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VlHNqXSp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4D614F9D9
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565255; cv=none; b=ArVKAVbkW160B0MhsHX9MAp7d4cGrcq7IXqb2VlX5ot1D5M6wNKUi/XQXxUpPG5H5E5TavkY0I+0RAkMI5fq4df8ZGHSXQrkdT3lne6Glh4gzeRgfRzdUB3Ci9ivr9v3qnA5piOKknw1/D4QEvCpnTUXQUCOft6QLVYndIa4tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565255; c=relaxed/simple;
	bh=qNaqaqM/rfizzAguCYHmtxf51OarNArMS3KK100xHQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIINxM8fp5CxVfjq/Mu0XXY3ZBtpdaStn7RcKMA3ZrRV8rLw91eO3+poyTGBgaXH96nJJfZSzLc//1CHCH3NmRuj6ipuzJmS2Y7VwHZ0d5+BFy4B/AVgO7bNX6rvkiwj4tHcAT0Kuw3DSYtMoMjAoQyJ+EUY82uZyMWbpuYbrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VlHNqXSp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qNaqaqM/rfizzAguCYHmtxf51OarNArMS3KK100xHQU=;
	t=1719565251; x=1720774851; b=VlHNqXSpf3kJm2pTDeh9tVAer2pxd/OQwVUVKGCMNO0VzyC
	wFnBdjxJDtsGtCjFyjTR9djZheGRr/h2i/XslAGvqcItAhuaIADR9JEfguItASIqNyZo0V7RVWDI5
	joaY9S7+XodNVegMa2q9U0cR1It06LqPTB6mB3iFNajA0NhUOmInsTOdXsyTMiBFFpsq4PPRjW5jX
	b/i5Lup0LySVyrTsOTqF5mzpST41B0EMit7FPnqXQUcWSZD0WJNAiF1MXs+cs58cUKlMevAGE+bkz
	8cTJkb4IfsxylOInelSr3PGljIkeCNklbdTICfzHj6xgA2kize+fCdhB2pZ9lySA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN7TL-00000009aR2-3bm9;
	Fri, 28 Jun 2024 11:00:48 +0200
Message-ID: <4719e2dc79a3c423f28664e263e038ee2103bb71.camel@sipsolutions.net>
Subject: Re: [PATCH v2 9/9] wifi: mac80211: abort active CAC while freeing
 the links during MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 28 Jun 2024 11:00:47 +0200
In-Reply-To: <0fe59d00-e911-4eea-af37-e8cdde116c69@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-10-quic_adisi@quicinc.com>
	 <2670d8e27e9c296e3c0de0572f6387aa9ea3ff93.camel@sipsolutions.net>
	 <0fe59d00-e911-4eea-af37-e8cdde116c69@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-06-27 at 09:47 +0530, Aditya Kumar Singh wrote:

> > Not sure I buy that argument though, it feels wrong. Clearly you should
> > be able to stop this from even cfg80211, it tracks whether radar
> > detection is running, so whenever the link is removed, you can also sto=
p
> > it there? Doing it on free seems much too late.
> >=20
>=20
> Actually if cfg80211_remove_link() is called, then it is aborted during=
=20
> stop_ap handler. So that path is fine only. This was done in situations=
=20
> where properly interface is not brought down or abruptly brought down.
> For example AP is started and then directly iw wlanX del is issued.

Still cfg80211 should clean up the link and call stop_ap() etc. If
that's broken we need to fix it.

> Ideally the normal deinit flow should have taken care but just in case=
=20
> if still somehow by passes it then ultimately while freeing the links it=
=20
> will be aborted. May be should I rephrase the commit message?

I think we need to fix the cases where it doesn't clean up properly
instead.

johannes

