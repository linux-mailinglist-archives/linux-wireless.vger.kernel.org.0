Return-Path: <linux-wireless+bounces-12333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C609682CC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DF1282A80
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B53C152E12;
	Mon,  2 Sep 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SmHlB9r2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5646186E58
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268282; cv=none; b=XKUf7XgcLbZXfhj4LCg/2E4kiNyNFXH9m5gYhmnTA9jlU6SdjSzZOmdE3c3sCL8aJkaVFCOZTTUdxHskk7vQTqx9xxUMa6sRL7/NT2W8b9cg6XnU7krsXrnsmmI5ySRUv1SDaoQsiYeB2u1tHiaFcQbCCocHOcC6V0w2W/QSQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268282; c=relaxed/simple;
	bh=s4AuwdFhjeVbQsrDBiQgWwmBMtGrcUV1avrjaiZU5q0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHvRbkEn4P6iG90pICRBT/1pdxnyl8eclBJ3RSC9fpzhGU0zMjLdqskF0t22pQgFOLvbM1OR2wff/ROkZ3sZa4UjQUidP/w6Dtq4vOBrjDty5szP88aS0DG4O8orpJZMx+7zvS20CftcTFL7DPMJbZA+0MpoukEPXFcd5a9c/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SmHlB9r2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s4AuwdFhjeVbQsrDBiQgWwmBMtGrcUV1avrjaiZU5q0=;
	t=1725268280; x=1726477880; b=SmHlB9r2EKYHn7zRhHWjE9oVpJcP2b0F25aANAl0excmMf3
	ycX4CVqbjPQVR7Z1ZVC94PPBotX+X32vjtdHH4Y2+X5AXA3qRxc1e0F8Px7h+KVaLX+p1aVqF3hAL
	oy72sdm2yOd91itJxPamFBu9YRiWKmYAf5pM8SVbIpn/xXwuUYFmA/o2m4FHA4jXiNvyEwQ1GTru7
	2M1O3NUiexaH57doQ1u8OViSNiG5fSz9r35ndCT6OfkF0Hij/2KVNisa+g0JOX5BTA9s1KZTSl0lJ
	+oJN4PrSTx517NU6c3Ab6mOq4EEqsxq3H+1FA1zhP7aKF6xW8rJixa1LfmaGERdQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sl35c-0000000HUct-2Hae;
	Mon, 02 Sep 2024 11:11:12 +0200
Message-ID: <edb3a22af9246ad6b6d71d53844bf76249c77e13.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: wext: Correct spelling in iw_handler.h
From: Johannes Berg <johannes@sipsolutions.net>
To: Simon Horman <horms@kernel.org>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 02 Sep 2024 11:11:11 +0200
In-Reply-To: <20240902090104.GA77312@kernel.org>
References: <20240829-wifi-spell-v1-1-e0a8855482a9@kernel.org>
	 <dd8cac71a80e70352f4ce4c4da426721e02ff31d.camel@sipsolutions.net>
	 <20240902090104.GA77312@kernel.org>
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

On Mon, 2024-09-02 at 10:01 +0100, Simon Horman wrote:
> > But is it worth it at all? This stuff is totally on the way out, so all
> > the thing about "proven a reasonably good design", well, didn't really
> > pan out in practice...
>=20
> I think if the text is there it may as well be correct.
> But if you prefer to leave it as is, then we can drop this topic.

Sure, that's fair, I'm happy to apply patches updating the
grammar/spelling by itself. No need to go into full rewrite and/or
historic debates about the design :)

johannes

