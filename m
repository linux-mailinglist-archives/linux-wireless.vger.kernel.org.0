Return-Path: <linux-wireless+bounces-13361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70098B6E9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B471F1C21793
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28D19ABA4;
	Tue,  1 Oct 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T8ZLj6ya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4EA1E4AF
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771301; cv=none; b=GDppdEo2ocqkB0IqXjuTpkFRmJzdDXzeoxGd1lrvk6oIGvBWkYffA4CldEZeh/BiGvI+t3T5yb852oxdJeBSjNwwY8kALu8vXt0gYwP88Jl5ra9S/kVxfSqgVcltPQg6an4emDkGM17KlOcLwnrYdhZeWUl2qVKn3z+4AFhbgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771301; c=relaxed/simple;
	bh=eWiHPKG7nokALxIXNWo90CDuihS1uRVjJN6sjqrRzx4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8dNfaAxcfcShn63r3rpM3jgiMQaePRhFYG5Wa7iFJQHfPFTnyk19JDzZ733ZsxoAWCcEhFMzUgMICOx1khPDEi82Sptr1ru6EJN58MWmHte6jxYv3X6EkPbhnYNXX/7htT0dC++3dIzm3Wxot7VjA2K5qmHs5NSBQFxrs/c8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T8ZLj6ya; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eWiHPKG7nokALxIXNWo90CDuihS1uRVjJN6sjqrRzx4=;
	t=1727771299; x=1728980899; b=T8ZLj6yanBTZem4/9EiQs0ODU299mYNgpxiV5HFOXM7G0m/
	b+OG8JCCRgIqkmBpyrGmE2nhpFLzeGspPs2RSGsfyJoo2V57bRiIZS9X2c2/8jcpxa0nuiTGqAuNn
	ecNR4wjzrl5Ee2Dt+HxeCvd5FcB+kvtrfkiqx5N76maEra7QI2CQ3wGbT1KWMF0BIS7Ni36Elllb1
	RM0rFFuBN7YZa8zD4NVZWxerasYys6EINXWBDXGlkiZ2I+4l64vfrncAlNfMZfEOjTPAltWF1xjsS
	NaDcMptGzp6kVwxYcM9i3AYg/TSxHZhX2yey6wGIiPAKLUfdiF7gND3U4Rh9Hrow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svYEw-0000000Efym-2LfX;
	Tue, 01 Oct 2024 10:28:14 +0200
Message-ID: <d66a63e31e55249bc88faa5731abb2859fa2a940.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 01 Oct 2024 10:28:13 +0200
In-Reply-To: <39b73ddd-5478-4599-a92b-00b274d2ce02@quicinc.com>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
	 <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
	 <fd731cac-7182-4de3-afd4-0fc5892a9440@quicinc.com>
	 <c103db90ed53a75cae10baba0ae52dae85bf1c3f.camel@sipsolutions.net>
	 <5fe9fdf2-ae5c-4d15-a095-0203a814e4ba@quicinc.com>
	 <16ad03533ab6aca65c3fe9db94ae53ad11fdb9d1.camel@sipsolutions.net>
	 <39b73ddd-5478-4599-a92b-00b274d2ce02@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-10-01 at 13:56 +0530, Aditya Kumar Singh wrote:
> Yes please that would be of great help. Let me send a next version=20
> having the changes as discussed above and then you could pick that for=
=20
> testing and let us know whether it is working as expected by Intel driver=
?

Sure. I suspect it'll work better if you do the ordering as you had
described in the comment.

> It would be better if other MLO based drivers could also test this? I=20
> mean if possible they could also test and let us know if this breaks any=
=20
> of their expectations! Or if not test, at least ack this change?

I guess they'll just have to speak up here too :)

johannes

