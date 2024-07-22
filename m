Return-Path: <linux-wireless+bounces-10434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE260938E3E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6441C20EC3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB351EB3E;
	Mon, 22 Jul 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L3kDiMCp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF01640B
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648773; cv=none; b=YXKL08y+FVgmnvQFMIEbWJLfBZLTsxRuFdkEfMMo57JAOEQFSEUxMKSFuwTBepgij2BNdCu5aqZxTUtHHmC4PdAbixxE8g91iBsRPQDlCROCIVdZVzr/RuPK2tohD+7XJvu+IxLx30fSdgRNXfTMH41UNJv0jhvrhhTvIGrkdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648773; c=relaxed/simple;
	bh=QFPqCXkRfvDsCoE6rt+6l33wFNITGxHN7JPcB55rdgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=so18j1ivPFLm9XXK5zLQhluD/Z1WbbjY/e4R3QL99aqZXdi/WsYPXZyKL4H1tjHxyQ8SRsPxCt3HU00saznaS4sbBXV9+Gbz+P+1ErOIUEuJwTghR0i0JeSdOS3rQGNZYnMvSFFSxELddSxMqDbmBUdv0vdfjM8YbF5u/6TPfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L3kDiMCp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V8kojFy9TgFSqzicTw6CAF3uVihJVFyanMEowPlCvcE=;
	t=1721648770; x=1722858370; b=L3kDiMCpSOJbRQgWmYJ8yRIplC0Zbiq5p5WTunyKFn9Dklj
	mOqr7dfAKgCW/7Pazun2j8y22ITSkrGId73WogD0DpPbDRLNefhKAOd8FQJ+JRAX4v7VUlspo8HHF
	cp94kvEpe8XaEat3WEHQlNoh2NDPScoar49q4pykJgkVwtI9kO61DSihlBY1cKN9vyuKV3MgBJMQC
	igZpL2SJSp79ysDVR8Qk7yoUKDlOdLTQHcDkU2nC9/nO5zvg3iEp1T1k2rmoBX8kmlnjpfeqC66j/
	zsZvWuScJwu7SUb9cQ8ZVJYKgQKaWqynUnKK/Wd7PbJQbJnC934MZ/iPZssebY3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sVrUV-00000009ob6-2iuS;
	Mon, 22 Jul 2024 13:46:07 +0200
Message-ID: <32b7d6b4d0298684a5b14f6506365e5840c19548.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: rtw88: 8822c: Fix reported RX band width
From: Johannes Berg <johannes@sipsolutions.net>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Date: Mon, 22 Jul 2024 13:46:06 +0200
In-Reply-To: <67646f1a-250b-4939-9358-b0d076fa87f7@gmail.com>
References: <d3267712-e458-4a02-9408-f3d443185207@gmail.com>
	 <e4ff967f72cc2138b9171e81ccadc35488c45559.camel@sipsolutions.net>
	 <67646f1a-250b-4939-9358-b0d076fa87f7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-07-22 at 14:43 +0300, Bitterblue Smith wrote:
>=20
> > >  - Use Fixes instead of Cc: stable.
> > >=20
> >=20
> > For the record, if you want it backported, you really should have
> > _both_. Having the Fixes: is good, but will not necessarily lead to it
> > being backported when/where you want it.
>=20
> Oh. But my other patches were backported when I used Fixes.

Yeah, having a small commit that says it fixes something and has a
Fixes: tag is a pretty good signal for the AUTOSEL thingie, but it's not
going to go into the process directly.

johannes

