Return-Path: <linux-wireless+bounces-1280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3306381E0F3
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 14:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF856B20F08
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Dec 2023 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B73524A3;
	Mon, 25 Dec 2023 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IOVsXiXQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633A524A0
	for <linux-wireless@vger.kernel.org>; Mon, 25 Dec 2023 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=68N15PMvPC9IDOw8yCFsYMBFB0mBJurIK/pkQiUzWYw=;
	t=1703511664; x=1704721264; b=IOVsXiXQ+uw+kXodyBRo1/gUtLT/d1Y5uGzqGNJkWNHojg0
	UrF79cnICfcqM1koApBh1b2clutfMeU6tMV81o3zygPPvRYjBD8y8PBNkFI6lvD1cnL8WjzwkpOGt
	GFJmx6kFnC/DfPljoOI0/4+1uQ3WHmQPWPQH/DjweCkh55WbjjTINar2D9qT/HWyxpskBw+HCqdo+
	tpmz2cTliutMELNlJXaUGLgT9hKOVyn38vkUlEM4HsTbxZZByEpkSxQnMghxTPK4cCvzmbnIuYtGw
	O57DufbKsUtPSuM9hYmZMuea7QDjM4DtAJIDfu+kMic6Yhf8oHu+PWZ1BpuAKv5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rHlCR-00000008KFn-1Tcw;
	Mon, 25 Dec 2023 14:40:55 +0100
Message-ID: <dbe8a8334edc56e2488bacaeccf8474a79faae0f.camel@sipsolutions.net>
Subject: Re: mac80211: WARN_ONCE("no supported rates for sta ...")
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 25 Dec 2023 14:40:54 +0100
In-Reply-To: <92f0017d-7b1d-4562-984f-885179b50435@yandex.ru>
References: <92f0017d-7b1d-4562-984f-885179b50435@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-25 at 14:00 +0300, Dmitry Antipov wrote:
> I'm trying to investigate the following WARN_ONCE() observed at
> https://syzkaller.appspot.com/bug?extid=3Dfdc5123366fb9c3fdc6d:
>=20
> ------------[ cut here ]------------
> no supported rates for sta (null) (0xffffffff, band 1) in rate_mask 0x0 w=
ith flags 0x0
> WARNING: CPU: 1 PID: 2875 at net/mac80211/rate.c:379 __rate_control_send_=
low+0x6d9/0x800 net/mac80211/rate.c:379
> ...
>=20
> There is a (weird and completely unreadable) reproducer, the most recent =
one
> https://syzkaller.appspot.com/text?tag=3DReproC&x=3D10437de6e80000 matche=
s 6.7.0-rc6.
> IIUC it creates a kind of a virtual subnet of 'mac80211_hwsim' instances =
and then
> enforces an attempt to setup an incorrect set of rates. Since I assume th=
at
> this WARN_ONCE() shouldn't happen, there might be some missing check for =
the
> contents of rate-related fields of 'struct ieee80211_sub_if_data'. I've f=
ound
> that this WARN_ONCE() may be avoided one step later by silently dropping =
the
> (presumably invalid?) rate control packet in 'ieee80211_tx_h_rate_ctrl()'=
,
> i. e.:
>=20
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index ed4fdf655343..3ca1db6bb0fd 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -703,6 +703,9 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx=
)
>          txrc.reported_rate.idx =3D -1;
>          txrc.rate_idx_mask =3D tx->sdata->rc_rateidx_mask[info->band];
>=20
> +       if (unlikely(txrc.rate_idx_mask =3D=3D 0))
> +               return TX_DROP;
> +
>          if (tx->sdata->rc_has_mcs_mask[info->band])
>                  txrc.rate_idx_mcs_mask =3D
>                          tx->sdata->rc_rateidx_mcs_mask[info->band];
>=20
> but most likely this is wrong and should be handled in some another
> way somewhere else.
>=20

Yeah. I'd say rate_mask 0 is the problem, but ... oh, right. I think the
problem is that we apply the rate mask while scanning, that doesn't
really make sense ...

If you're making a connection on 2.4 GHz (band 0) then you need not have
a rate mask set up for 5 GHz (band 1), and so it's probably 0 by
default, but scanning will go on that band anyway ...

I think it stands to reason that the rate mask really should only apply
to the operation on the interface, not the scanning, which would
probably fix that?

johannes

