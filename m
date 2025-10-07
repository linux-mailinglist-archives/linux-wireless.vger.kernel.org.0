Return-Path: <linux-wireless+bounces-27854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4FBC0EAC
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 11:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCCD19A0769
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 09:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA635972;
	Tue,  7 Oct 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gA3Ofk34"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2672EACE
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830485; cv=none; b=R9rH+Hl1K0ESqcyKarBXH0i/H9g5kWF/qO1rs2uwGlNNDfdWcbOeSzd+3Wexs2nsQFR62n9KBCFgD/JWxB72hkFmS2a+IhfMlzZj/CLyrtoXG3UlGRvK2L5c57/ufbw6AvmSFqGGfDt6d+PjoNF7Z264W/uoctOag2eseYPGyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830485; c=relaxed/simple;
	bh=ESNPMgVauHGt5LNHQfuPqmiQmv9atuTHTGaflBAXIqc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QRmzqDGXslpOhQwgI60TEL+rc607JjcpFm3ha//tjPUAgFiXVqUU6AaF8xBVFinRJFFHQ9SWDBejQOrfOJID06IqFbsQTh0Y6r7KYxKKO0sNbbOdaQbbp8ODawtAdi/VyTclwZa74PlVAi9OeybX27HIayzbj1KAf96ab6jjj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gA3Ofk34; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NQZda/eSt+eeBeRw8DbtB2hGAekas7XtUKreaVNQoTY=;
	t=1759830484; x=1761040084; b=gA3Ofk34Tm/88Q1gVKwdy1QTgt8Pg1NJKrLfnaLYsglLWbc
	zwAGwD8oCoOCe6xFrxFEUGj+WOJgQzAv7t6D7zyA2moAVbeR9yjAe8lIbaqcIWi2myfB3WXF4zFhA
	C00mr+NgKEFkv1QVkqGtdV2vC152hPuqH7TFzKPnAB7/NmDJlRwp5jejY4XDht2TXr9u5+nJiyCMa
	gBc/HBfCO5PirDyaEkHm3B7Pjo+BdvTED+qR4U4SgV6/Ljl9aSn5dRgQAKyag5/pPt5/YOnms4mWM
	SypMN3+I2JbaaeUN2PGKetOi+1TwNgsPViEvoOcOWetfCz37vopdUwO5ySB1upqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v64IU-0000000GFmK-1icn;
	Tue, 07 Oct 2025 11:47:54 +0200
Message-ID: <fd9f92ac554a3ca706023b8d917b58698bf6e930.camel@sipsolutions.net>
Subject: Re: Receiving broadcast data frames in AP mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Yannik Marchand <ymarchand@me.com>, linux-wireless@vger.kernel.org
Date: Tue, 07 Oct 2025 11:47:53 +0200
In-Reply-To: <af5a5fc2-a7eb-4cb5-ae7e-b9513a7c7153@me.com>
References: <af5a5fc2-a7eb-4cb5-ae7e-b9513a7c7153@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

> I have been using nl80211 to implement local wireless communication with=
=20
> a Nintendo Switch device. The current implementation can be found here:=
=20
> https://github.com/kinnay/LDN.

:)

> We have run into the issue that we are not receiving any data frames in=
=20
> AP mode. In station mode it works fine. Inspecting the traffic with=20
> Wireshark in monitor mode showed that the data frames are being sent to=
=20
> the broadcast address ff:ff:ff:ff:ff:ff. Some research suggested that=20
> the Linux kernel might drop these packets by design:=20
> https://github.com/torvalds/linux/blob/7f7072574127c9e971cad83a0274e86f62=
75c0d5/net/mac80211/rx.c#L4443.

Yes, a real AP will never receive broadcast data frames, since it
controls the BSS and all traffic flows through it. In fact, hardware or
firmware would likely filter them as well, so even removing this check
may not address this for all devices.

> Currently, we are wondering if it is necessary to switch to adhoc mode.=
=20

That might not be a bad idea, but then you don't have control over which
station is sending beacons - though I guess if you actually have
multiple Linux hosts it wouldn't matter so much?

> This would be inconvenient, as not all devices support adhoc mode,

Not all devices support AP mode either, and see above wrt. filtering, so
I think either way you don't have some devices.

>  and I=20
> am also not sure how adhoc mode can be used correctly. We do need to=20
> send beacon frames, and process association requests, but=20
> NL80211_CMD_START_AP and NL80211_CMD_SET_BEACON seem to be unsupported=
=20
> in adhoc mode.

I don't know what you need from the beacon - almost sounds like not much
- so might not need SET_BEACON rather than JOIN_IBSS. Managing stations
from userspace is supported for secure IBSS though, wpa_s implements
that.

> * Is it correct that there is no way to receive broadcast data frames in=
=20
> AP mode?

Well, we could hack out the check, but it wouldn't necessarily fix the
issue. So I'd say generally, the answer is yes.

> * Is there any documentation or example code on using adhoc mode with=20
> nl80211?

Only whatever is in wpa_supplicant for secure IBSS. I don't think the
'secure' part is really a requirement, but it's been ages.

> * Any general advice on moving forward?

In the past you could maybe have used 'cooked monitor' but we removed
that, so now I guess the best you could do in AP mode is to add a
monitor interface (you already say that's how some frames are
transmitted, though that doesn't actually seem necessary) and listen for
the data frames there? If the hardware/firmware actually receives them,
you should be able to see them there. If not, well, then it just can't
work in AP mode anyway.

(I suspect, for example, that Intel hardware generally won't give you
the frames, but I haven't tested it now.)


In a way the bigger question is what do the consoles expect from the AP?
Do they, for example, go into powersave and expect traffic to be
buffered for them? Because in that case IBSS won't work anyway, and it
seems a bit hard to imagine they wouldn't...

Or could you maybe simply not care and always make one of them the AP,
perhaps unless there's no real console anyway, and then you have no
powersave expectations on the Linux side from IBSS?

johannes

