Return-Path: <linux-wireless+bounces-38246-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FEiGHm75QWplxgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38246-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:49:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1166D5ED3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 06:49:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="S1EqWfu/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38246-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38246-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88E7D3002B11
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 04:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1261DF25C;
	Mon, 29 Jun 2026 04:49:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E012798EA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 04:49:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782708588; cv=pass; b=je2Sw/glTLAwWKo40sMfonj9jWIe5HYkCwBN6h8yh5Ea8r2Mj06xqL/5fIBn81mjfPgkBmo/+HH3yh1XyZoOu0bWdDptCr/AEBdJCkERmbwf3au1pf+yGb6StzJyN7+Q4wMbZCf8djsXwCMzk8L+ImNYy+AMa/dO12aK4Bxo/p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782708588; c=relaxed/simple;
	bh=2U3jbST/yXNq5yJ4Fo3VOVNi0mY2lJnH91PVzl9XUmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/5VDc4nO9Vk80nb19aelsqfsUDz1zSUao2Y4agnzHV4CT9iHk757hYR80hVZowPQv7wd7tFbUZ3c7VvAkCw35N56kyjLwAf6/2iKMc5nzv6EzqojxTCFqn2XqX9vQGO4rzOI0NHn7vXpULFZGvWn8YBuIuYN/Ke/NvVBVb9CX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1EqWfu/; arc=pass smtp.client-ip=74.125.224.45
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664d7863920so441832d50.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 21:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782708586; cv=none;
        d=google.com; s=arc-20260327;
        b=TwB4v17+PiCKkIi6+31U5ZYznwMZsMQM45FHeexbm9HBNTamctYxzoRTzcXa/idFlc
         VTfXGzBvyBITkXN0FI3INd6OFhI5rSfKLGN3ITRCMMZg8lX6r7l55UQcG1MIZRn3PZ7D
         tulnoe6LZuKFieyA08pIWbx1GOXJgPwJsumZoyF+gQe+/g+v75AZYra6MmjF/70yTxFB
         N08gI4vvRUl1yStE6ulBZj9hjg/kkCJ5Tpa+4XCpaoE5kp5rVv4WGMF84f3EpKMxPfbl
         nor5mRarVYvoWRslavB9e1WRxPznoJL8mt7aRhx9nPl4Q0an3TtjZQs2nAXJvGsa5WVS
         ExFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AzrHTLYzx+kSaBUmu3n7B2NoCgJP51OBDGoIJ6PKR0I=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=rZCMnSh6faSxDay8cTsVCzVv+YYxHvOm+izuQVrm+6Lpj4VIbSovp+6HLjz+lH1GAy
         fhByfPQsVxre364BhVvkW7t72e6pgo04mU8HpOTSvP4jJUAb/UeHFqzIzp0L32IjjuTp
         YkYKy+b3wqCZu1eaj98gE6SBNRTIdvMH5hkUEnhpiRM0Z5maabKvIwGKBhyP9hJsPZdC
         LyGlWl4Z6CojeLEDrcH7GG/tDjxoHQCw7IT+1XCmxXwlK0FUs8hzbnK3KfEgDKf6UwGb
         Efj/WNGHMRnoxgxqSXMxAnB4KrDiTSaQ4qfJGL8z5vHhttSD+S+yVIBQy1qlx+kTBZhM
         UxLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782708586; x=1783313386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzrHTLYzx+kSaBUmu3n7B2NoCgJP51OBDGoIJ6PKR0I=;
        b=S1EqWfu//kDNWsyImvzUSCm5vpSkUuZy6pODYXO4ZTbImwdyprKi3X4sGc8AumIYoo
         3W9TLLr8QksX87d6+YzgkIXrKjmkkDDRMKvQBfzynkF3JHdgFQngRQb0Bu3LJgxf1wXJ
         BVHfKGwS7JD/uDHBLKMD0fFYMB/Y502YB+YoN56jgsfWkli165RGuqykxhwa3hUbndvs
         WiNiF150o+2ldqw2Jqn6smFU3HmjFBwmt47H80T1NDk40BMk6zvVTbqDXkWZMBefubqS
         okrTYsi29yYlf/MXEy4JDTi1NoPT2ZFc75kHO2fmC9uhUpStHYX63jsEu1yTSdRG+ody
         LoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782708586; x=1783313386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzrHTLYzx+kSaBUmu3n7B2NoCgJP51OBDGoIJ6PKR0I=;
        b=D5W/DsqrF0daLWgAjo9kBVXHBSx30awNEi5r06ORd3oZoUHgjssQhgmfqSutUaUB33
         i6FfVRFhwUkT0NImKSrCu/PzJxuQk4h4rJJCHAWWwd52oP3nU/xA9y/5ftoK3M465Zv7
         Cl3exwltvO+S/GvMAdMD0Eogg42rS67vEExD/QBI2nknyQ0OgYyyXJsWeziC0c6k1P76
         lYhl74vflwre9+7ALwTIBfvu2e6rTi52gxSrAYJYeizHlyRVTMq46CxkINJ0n39gZfxI
         amsgV+DwcD8go7Qw2AV7ztHyuUBUWPnM/JJzYyb1zhDkv2MEUhoQy5eZhCZM+nm4CIq+
         WbBQ==
X-Gm-Message-State: AOJu0YzHOrwNR5v8cBiJtPHCbUjJSSYAFSfGBnTXDOmwk/dV+xP1yc1d
	CGysbHydCFDXPDLG5TOimXVyTMcS0Tzapm7dXGqX92Mv2oX5whqFVwQfN/Mlp24sHeLTOSAl+E9
	bsjl1omioCJVtIy1ytH2Ed/erv0OzfRGX0M1v
X-Gm-Gg: AfdE7cm5JyT1DSqlhTBfl3KUvo8JqVvfwwZO6+Mq0tvACzzRtn5OkfXBzpj491eh3ve
	zmH10yCljd8d36eM6+ec1y5LlSMUh5sY+E+2IOlU1++AZhQbSq4Oclzau6GQaX2EN+wc1Bn4bqv
	vwsXbx4hVrWuYBUyr4FU8BzYmJ4ePG4FrqWExgaQ6Md/prBl2SRoXs2Uv7N+iQIpLOirsAqPPU3
	88qShKTjrvBlH6XjLmxFYMWOsoT8zbJL4JlNpOaFiGhUn9Da7plQ5nRPAM59/xvpfTrkExJlWY5
	rO1edcc=
X-Received: by 2002:a05:690e:124a:b0:65e:5110:a60e with SMTP id
 956f58d0204a3-66487fb14a9mr12896601d50.41.1782708585645; Sun, 28 Jun 2026
 21:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
 <54e7877f76944bd29e57d6eafe5e3811@realtek.com>
In-Reply-To: <54e7877f76944bd29e57d6eafe5e3811@realtek.com>
From: Doug Brewer <brewer.doug@gmail.com>
Date: Mon, 29 Jun 2026 12:49:34 +0800
X-Gm-Features: AVVi8CeuYheUktFsL_DgfjhEnTeG6oY7UbuQvoUauA9VJsz43QHxFTExZoP_7Wc
Message-ID: <CAG0V13Qfp+eVCR6NjQJydN-fL8tus_EyJCWGQqQxTkKA9ZXBFQ@mail.gmail.com>
Subject: Re: rtw89: RTL8852BE P2P-device iftype and STA+P2P interface combination
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[brewerdoug@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38246-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brewerdoug@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B1166D5ED3

On Mon, Jun 29, 2026 at 10:10=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> Doug Brewer wrote:
> > Hi,
> >
> > I'm experimenting with Wi-Fi Display (Miracast sink) concurrent with an
> > STA connection on an RTL8852BE (PCIe) using the mainline rtw89 driver
> > (kernel 6.18.37).
> >
> > iw phy reports:
> > Supported interface modes:
> >    * managed, AP, P2P-client, P2P-GO
> >    (no P2P-device)
> > interface combinations are not supported
> >
> > In practice this blocks the standard P2P flow: there is no P2P-device
> > iftype for a dedicated discovery context, and no advertised interface
> > combination for managed + P2P-client coexistence.
> >
> > My questions:
> > 1. is P2P-device iftype support planned for rtw89 on RTL885x? Is there =
a
> >     known technical blocker, or is it simply not yet implemented?
>
> We are planning to add P2P-device iftype. It needs to consider the cases =
of
> channel context, conditions of power save, and etc. It will take some tim=
e.
>
> I think it would be okay that you use STA interface to do P2P negotiation=
,
> and then create P2P-client or P2P-GO iftype then.
>
> > 2. would advertising a managed + P2P-client interface combination
> >     (single channel) be feasible on the current rtw89?
>
> This is a SCC which is supported.
>
> > 3. is MCC (#channels > 1) on the roadmap, or considered out of scope?
>
> Current support MCC as well. However, we are cooking new firmware to supp=
ort
> hw_scan with two operation channels -- which doesn't matter if you don't =
need
> to do scan when MCC is operating.

Thanks for the suggestion. I tried using the STA interface for P2P
negotiation, and wanted to share what I found.

With the STA connected (2.4GHz ch11) and an active p2p_connect, a
wpa_supplicant -dd trace shows GO negotiation getting fairly far:

Peer's GO-NEG Request is received
send the GO-NEG Response on ch11, peer ACKs it (TX ack=3D1)
State goes GO_NEG -> CONNECT
then time out waiting for the GO-NEG Confirm, status=3D-1

I select ch11 as the P2P operating channel (same as STA, SCC), while
the peer's operating preference is 5GHz ch149. It looks like after we TX
the Response, the radio doesn't stay on ch11 to listen for the Confirm,
so the frame is missed -- presumably because the single radio is serving
the STA connection.

Aalso tested with the STA on 5GHz (ch149); the result is the same
GO-NEG Confirm timeout.

Is this the channel-context issue that P2P-device iftype will address?
And with the current driver, is there any way to keep the P2P listen
context on the operating channel during GO negotiation while STA is up?

(FWIW, passing an explicit freq=3D to p2p_connect is rejected with FAIL,
whether or not it matches the STA channel.)

Thanks,
Doug

