Return-Path: <linux-wireless+bounces-23359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F50AC224A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 14:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D974F3AA81F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC382288D3;
	Fri, 23 May 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Zo0Djvu3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03755D8F0
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001598; cv=none; b=OwnO5rbF7G6mfxUW7SSCRx6vUbipyB68/SlVxlwgU41wTXQEbZw/xnlE+U+PL2+8jj63GMH2nQi6hljVjc20SpNPyX7IqAuLMxjyB2sL6COLJSJy0QnfCjIVSaOc5WO7PSbgOPFXNU9XyWRwZgh0d8rAMJKaVhr62SqkPTbnk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001598; c=relaxed/simple;
	bh=3gNJjPkWc2kRTTnLbGrvJloi3gzGTQgiA3rG1pEG+tU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZS7kFAVXLR7l8yj82HS5pjL8WniX82omd84V5/ft0Zk+N6eNiPvGpESQMusEvuZY2lxmOdNJg9hQs+J5ROgIs845LtX8TkwaR7bCJ8xHcPQUu4h+BW4+/gmz7Ois9gGBtqpKZ2GvvVWpb+xrQsugRDx8Jpc6Qp+jorUDrffLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Zo0Djvu3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=awHLW/0CnTpPGmLXXdEZLaf9bVff0wLAH0bYu6VdaX4=;
	t=1748001596; x=1749211196; b=Zo0Djvu36lGzVc6seuX6wPHLifcO12rYjBKfRqldJw88wes
	efa1L5VCR+b0ra1FbXo4+a8YmT7ijSXkvDtYrnljV3ljnELlJMZtDknxfeGTQjxn5wYEEzeFQkigg
	mMLcxInvsf2loUxeTw/Gs5ZgdZDd3TPIw3vwiLCOiJvPnpBRgnQQJAlJCt1hBOmFZvD1yea2tRco2
	ZBedbUhh2Hs+hB7viluK4YY8MjRenb+9jebCbFfwcJY6xcTitwi+6FgVtCFnoe0N4ZYXuuROPUWRT
	aVeEPihtK4IXsdMN00cXQPlUkCPPaI3la+hpsdUck7Z8aGTvXUOc4c9pN8Es9K0g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uIR46-00000001XRv-0n23;
	Fri, 23 May 2025 13:59:54 +0200
Message-ID: <2e1fdb77f2ed5f381323f6a493c62ea1bdec19a7.camel@sipsolutions.net>
Subject: Re: Association comeback delay behavior
From: Johannes Berg <johannes@sipsolutions.net>
To: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org
Date: Fri, 23 May 2025 13:59:53 +0200
In-Reply-To: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
References: <ba82ab00-ecf7-44fe-95db-355795c3520e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi James,

> 1. The kernel takes the delay in the association response frame and=20
> waits, but has no sane bounds for how long the wait is. An AP could send=
=20
> 0xffffffff and the kernel will just block for that entire duration.

For some value of "block", it's not really blocking in the (traditional)
threading sense of the word :)


> 2. The first issue would appear to be guarded by the fact that=20
> run_again() only reschedules if the new timeout is less than the current=
=20
> time remaining but only if there is an existing timer set.
>=20
> Looking at the code, the association timer gets set when we begin an=20
> association so it _should_ be set when we hit this comeback delay case.=
=20
> But through testing I found that it is not. Hacking hostapd to use 10000=
=20
> TU's as the comeback delay I see this:
>=20
> [=C2=A0=C2=A0=C2=A0 4.338185] wlan1: associate with 02:00:00:00:00:00 (tr=
y 1/3)
> [=C2=A0=C2=A0=C2=A0 4.340023] wlan1: RX AssocResp from 02:00:00:00:00:00 =
(capab=3D0x411=20
> status=3D30 aid=3D0)
> [=C2=A0=C2=A0=C2=A0 4.340409] wlan1: 02:00:00:00:00:00 rejected associati=
on=20
> temporarily; comeback duration 10000 TU (10240 ms)
> [=C2=A0=C2=A0 14.654103] wlan1: associate with 02:00:00:00:00:00 (try 2/3=
)
> [=C2=A0=C2=A0 14.657405] wlan1: RX AssocResp from 02:00:00:00:00:00 (capa=
b=3D0x411=20
> status=3D30 aid=3D0)
> [=C2=A0=C2=A0 14.658430] wlan1: 02:00:00:00:00:00 rejected association=
=20
> temporarily; comeback duration 10000 TU (10240 ms)
> [=C2=A0=C2=A0 14.848706] wlan1: associate with 02:00:00:00:00:00 (try 3/3=
)
> [=C2=A0=C2=A0 14.851596] wlan1: RX AssocResp from 02:00:00:00:00:00 (capa=
b=3D0x411=20
> status=3D30 aid=3D0)
> [=C2=A0=C2=A0 14.854269] wlan1: 02:00:00:00:00:00 rejected association=
=20
> temporarily; comeback duration 10000 TU (10240 ms)
>=20
> So the first association attempt waited the full 10 seconds, then after=
=20
> that the timer was presumably set, and we only waited the default 200ms=
=20
> (ASSOC_TIMEOUT).=C2=A0

That's not exactly how it works, run_again() multiplexes different
things onto the same timer by tracking the various sources. So the
_timer_ might be expiring again, but the actual "assoc handling" part
should only happen after 10000 TU.

> So to me, this feels like either a bug

Yes. I can't reproduce it though:

[    4.300000] wlan0: authenticate with 02:00:00:00:00:00 (local address=3D=
92:9c:4c:00:00:01)
[    4.300000] wlan0: send auth to 02:00:00:00:00:00 (try 1/3)
[    4.300000] wlan0: authenticated
[    4.310000] wlan0: associate with 02:00:00:00:00:00 (try 1/3)
[    4.310000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=3D0x401 st=
atus=3D30 aid=3D0)
[    4.310000] wlan0: 02:00:00:00:00:00 rejected association temporarily; c=
omeback duration 10000 TU (10240 ms)
[   14.560000] wlan0: associate with 02:00:00:00:00:00 (try 2/3)
[   14.560000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=3D0x401 st=
atus=3D30 aid=3D0)
[   14.560000] wlan0: 02:00:00:00:00:00 rejected association temporarily; c=
omeback duration 10000 TU (10240 ms)
[   25.440000] wlan0: associate with 02:00:00:00:00:00 (try 3/3)
[   25.440000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=3D0x401 st=
atus=3D30 aid=3D0)
[   25.440000] wlan0: 02:00:00:00:00:00 rejected association temporarily; c=
omeback duration 10000 TU (10240 ms)
[   36.320000] wlan0: association with 02:00:00:00:00:00 timed out


That last "timed out" should really come earlier though, oops. Let me
fix that:

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fa7cf3b8ad59..f4a5deedfaab 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6383,7 +6383,8 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee8=
0211_sub_if_data *sdata,
=20
 	if (status_code =3D=3D WLAN_STATUS_ASSOC_REJECTED_TEMPORARILY &&
 	    elems->timeout_int &&
-	    elems->timeout_int->type =3D=3D WLAN_TIMEOUT_ASSOC_COMEBACK) {
+	    elems->timeout_int->type =3D=3D WLAN_TIMEOUT_ASSOC_COMEBACK &&
+	    assoc_data->tries < IEEE80211_ASSOC_MAX_TRIES) {
 		u32 tu, ms;
=20
 		cfg80211_assoc_comeback(sdata->dev, assoc_data->ap_addr,


So now I see:

[    4.300000] wlan0: authenticate with 02:00:00:00:00:00 (local address=3D=
92:9c:4c:00:00:01)
[    4.300000] wlan0: send auth to 02:00:00:00:00:00 (try 1/3)
[    4.300000] wlan0: authenticated
[    4.310000] wlan0: associate with 02:00:00:00:00:00 (try 1/3)
[    4.310000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=3D0x401 st=
atus=3D30 aid=3D0)
[    4.310000] wlan0: 02:00:00:00:00:00 rejected association temporarily; c=
omeback duration 10000 TU (10240 ms)
[   14.560000] wlan0: associate with 02:00:00:00:00:00 (try 2/3)
[   14.560000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=3D0x401 st=
atus=3D30 aid=3D0)
[   14.560000] wlan0: 02:00:00:00:00:00 rejected association temporarily; c=
omeback duration 10000 TU (10240 ms)
[   25.440000] wlan0: associate with 02:00:00:00:00:00 (try 3/3)
[   25.440000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=3D0x401 st=
atus=3D30 aid=3D0)
[   25.440000] wlan0: 02:00:00:00:00:00 denied association (code=3D30)

>  =C2=A0- If the timer being unset is expected, the kernel should be limit=
ing=20
> this wait to something reasonable.

Define "reasonable"? I mean, sure, if it says 0xffffffff we'll even
overflow the calculation and end up trying way too early, and if it says
0x100000 instead to avoid the overflow inside the calculation and in
jiffies, we'll wait a very long time:

[    4.300000] wlan0: authenticate with 02:00:00:00:00:00 (local address=3D=
92:9c:4c:00:00:01)
[    4.300000] wlan0: send auth to 02:00:00:00:00:00 (try 1/3)
[    4.300000] wlan0: authenticated
[    4.310000] wlan0: associate with 02:00:00:00:00:00 (try 1/3)
[    4.310000] wlan0: RX AssocResp from 02:00:00:00:00:00 (capab=3D0x401 st=
atus=3D30 aid=3D0)
[    4.310000] wlan0: 02:00:00:00:00:00 rejected association temporarily; c=
omeback duration 1048576 TU (1073741 ms)
[ 1078.240000] wlan0: associate with 02:00:00:00:00:00 (try 2/3)
[ 1078.240000] wlan0: deauthenticated from 02:00:00:00:00:00 while associat=
ing (Reason: 6=3DCLASS2_FRAME_FROM_NONAUTH_STA)

Long enough, in fact, that hostapd forgot the STA even existed ;-)


> I also realize that CMD_ASSOC_COMEBACK was added and userspace gets=20
> notified, but this feels excessive to handle in userspace when the=20
> kernel could instead enforce a sane timeout all on its own without=20
> requiring userspace disconnect/reconnect when the AP sends an absurd=20
> timeout.

Define "absurd". Bigger than around what I was demonstrating above
doesn't actually work properly anyway due to the possible overflows, and
sure, 15 minutes is long, but doesn't feel "absurd".

I tend to think this is exactly right - the kernel will wait, but since
it's not doing anything else that doesn't really matter. Maybe it'll
work later (earlier tests above), maybe it won't (like when the AP
forgot about the STA above), but it's not like the kernel is holding
some important resource busy for all that time?

And userspace gets notified and gets a choice, so of course it can give
up on the association instead.

And yeah I did "iw connect -w" and it'd be hard to actually work around
it with that, but it could even make the assoc socket-owned and then
it'd probably stop when you hit Ctrl-C, and anyway nobody really uses
that.


> My main concern here is a rouge AP scenario that can then DoS all your=
=20
> clients that try and connect to it.

Oh, so you're just trying to sell us a missing implementation in iwd as
a kernel security bug? :-)

johannes

