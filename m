Return-Path: <linux-wireless+bounces-12885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B318979BAA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 08:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03554B2120F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FD72233B;
	Mon, 16 Sep 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wBfaOY5u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA883CD9
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469874; cv=none; b=uzhGo3Z45Tle5fUF5WR6cwUVxwT02+i0WTgAvDE/BYw9dkPztZl38JQOKK/Us4lSfq/3NwPTmlTO+TVyQi/yD54woWzbNitPzheRJmOq2zU/0wRZQqPxyFJ+4rNMYl6WMDh6sQ0kTam8zGbSlZgZO39xzQCXyc2TbDdKsjmX/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469874; c=relaxed/simple;
	bh=uNK9XmZXhVeF2KW4iWp82OGOT1/fv+3mSx3VKWcXz40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nh9PMD9QuU8QOWGz98RJIGqeEjf/INHzRnSeV6EHyCgA01c6HKjw1O63YFzg6ZEGOSOSZaRgLsBQXjtD/ZewsG9GOVAmpiXML1Psmvhz2DPM8zLQUqJHLGPWjNQqqI0T5a4kceowNfUJYmID0nNBI5YyW5g9fGkAI0ds0OWdPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wBfaOY5u; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uNK9XmZXhVeF2KW4iWp82OGOT1/fv+3mSx3VKWcXz40=;
	t=1726469872; x=1727679472; b=wBfaOY5uD+PdCRVP3cWwLx+Ss/slZ6r0hWd0eNTh2GshiC8
	UQMUwmoB+n2gJdA2pegffAVUd9uZaU9VE+gcrZY6twFm02wGm6Vg6sLQWtVUwFkR9yDryzf8/hua3
	KJEJxHGazxPsfHNCAx4R6CHKi5F4jGFL+qU/JdapiDTZGW8P/NMK7CXghD3MGRBiDroeF63aktxIv
	gpTKsamqFG1I7Qk9g8/ZQbvU4XqlchPaDEKHjdvERzFwkIUoHW0W4omOlZoVo9qBf1njTAZ6Eungr
	5M3vk0uU48k2lboWboE0Vq8TbuQXO5h+74iyyDBs/fd6eCMzVfr7NyvEGiPjdbpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sq5gD-0000000A5Ho-32oF;
	Mon, 16 Sep 2024 08:57:50 +0200
Message-ID: <e8136b268dee6cc98542aa359058ce7fa3c9954c.camel@sipsolutions.net>
Subject: Re: {Disarmed} Two potential 1-byte BOF in cfg80211.c of driver
 MWIFIEX
From: Johannes Berg <johannes@sipsolutions.net>
To: Greg KH <gregkh@linuxfoundation.org>, Sherlock Fang
 <wf27@st-andrews.ac.uk>
Cc: "security@kernel.org" <security@kernel.org>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Mon, 16 Sep 2024 08:57:48 +0200
In-Reply-To: <2024091654-flagship-untried-1c23@gregkh>
References: 
	<AM6PR06MB55447E199A092E593B82986AA0672@AM6PR06MB5544.eurprd06.prod.outlook.com>
	 <2024091654-flagship-untried-1c23@gregkh>
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

Hi,

> > I have used static code analysis tools to scan the Linux Kernel of the =
latest build, and with collaborative help from Prof. Yueqi Chen, we have be=
en able to manually confirm the presence of two 1-byte BOF in drivers/net/w=
ireless/marvell/mwifiex/cfg80211.c

Not sure what "BOF" means in this context, I guess buffer overflow. Not
sure why 1 byte?

> > At both line https://github.com/torvalds/linux/blob/master/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c#L2679 and https://github.com/torvalds/l=
inux/blob/master/drivers/net/wireless/marvell/mwifiex/cfg80211.c#L2777, the=
 calls to
> >=20
> > memcpy(&priv->vs_ie[i].ie, ie, sizeof(*ie) + ie->len);

The line numbers are wrong now, but it seems this is in scan/sched scan
respectively.

> > are theoretically possible to cause a buffer overflow

No.

> > since the destination buffer is an array of bytes with a size defined b=
y MWIFIEX_MAX_VSIE_LEN<https://github.com/torvalds/linux/blob/master/driver=
s/net/wireless/marvell/mwifiex/ioctl.h#L416> of 256 bytes, which is the max=
imum amount of data that can safely be stored in priv->vs_ie[i].ie<https://=
github.com/torvalds/linux/blob/master/drivers/net/wireless/marvell/mwifiex/=
main.h#L483>.

Indeed, the destination array is MWIFIEX_MAX_VSIE_LEN.

> > The size parameter "sizeof(*ie) + ie->len" theoretically has the maximu=
m value of "2 + 255 =3D 257" given that len is of type u8 which has upper l=
imit of 255, and sizeof(*ie) is equivalent to sizeof(struct ieee_types_head=
er<https://github.com/torvalds/linux/blob/master/drivers/net/wireless/marve=
ll/mwifiex/main.h#L343>), that is just the size of two u8 field (two bytes)=
.

Yes and no. Your argumentation isn't completely _wrong_, in that
mathematically, indeed 2 + 255 =3D=3D 257. Also, you're correct in saying
that the sizeof() results in 2, and the maximum value of a u8 can be
255.

However, the value of ie->len cannot actually be 255 in this context.

Not to say that it might not be better for the code to be more
immediately obviously correct, and there's always a chance that somebody
might break the properties here pretty easily, but a complete analysis
of the data used here would have shown you that it cannot indeed be a
security bug, and therefore there's no reason to waste everyone's time
by treating it as some kind of secret.

johannes

