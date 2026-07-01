Return-Path: <linux-wireless+bounces-38460-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jPAJNB8gRWrC7QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38460-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 16:11:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5476EE8CF
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 16:11:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=clAgN347;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38460-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38460-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA05130683C4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E151D86E4;
	Wed,  1 Jul 2026 14:06:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397A28C5B1
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 14:06:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914796; cv=pass; b=ENt1doqswWXCoC733zUD0cW12fsBJm8suC1VK4FVHeZdJpVKXFLOd6kKC0aaoWLUKXCfFYORowGtAAHoediqRp/hCAiVFweYgSYZA6mmGH/G+hV8iJ+dNn3LSsonembhJ4EVI/6BxOGo1d/jMcuhSCg8mqxDKWErFnZ2ksf5lbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914796; c=relaxed/simple;
	bh=QIBU1idD9IUEBNfzbkMB6lHUOU+GcWI2gEOP8iWZBCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RO/AGIcH89+7d00NVzbj0oKgfo9iFgnYa6pE/plqXJmnku0xesi4elHAj25Gz2kpy4bY1QtyR6nTIId/uRaeSMtd1cG5uG+VIHfdseo25T3LRujRJfqQjbOqd832Gsm4Du0q/0GuWrSD1NqMVyI0LoyG15Yf4KVRNrEo1HmiozM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clAgN347; arc=pass smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664d7863920so659278d50.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 07:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782914794; cv=none;
        d=google.com; s=arc-20260327;
        b=dncuOuuhDBjYH+hubirA8Xb88Q86JYlyBazvD/yzQKoD0C+ewOXduLrvwwJPwjZRpP
         LNWq5rU2oF17L8GFoRd7DFZnia+9vZ0gbJycn7E7Bo45VV0Cx60Spg/pM38mraysR+1p
         UT7gDensWSPVMTSkk5dFffrvK3eS9DIcqfGlaKpnQYMB0KTwvvky2klGBIDGEN1FOR/f
         lgF5GL/XtII5TrSX8ksCgx8VbEk857CnLlboKAV77BgqhROU4ahuUqdxoun1pA1v7Vlq
         VyI4qOA0ghGxfvmq1g/SPJSEbJEcasOW8nN+bwO/lGMCanK9tkSgA1XrKIfKapbXVPKQ
         eLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wrxRc+vnLGraWIGJTwPU39JSi2e4EyxL9Vxd0vYPb+E=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=lr7JBl0b4m0up5ZYVTst9wkFXT5kQgxlaWj2xaw0dKqU2m0T4zTjzPkSSPfffm27WG
         vyu2w26NriUmLKZqAxvmJwRVtZvru+jZBq0PIodMfOxiKDHPqq8gN0CqToKOX4pK4nRn
         WlSwMnk+Qb+cOD6X0L4TzyoS1bjHBW4Pg664qxgP0M18bO0b2nDwLnJkmLKSEGloEB2Y
         MIUNm5T7spkDMc31NeyEqzC7Pr/K8kwC8lLZxCWJpWJbSlljHR9Y2HNmQp5iZKwvaCue
         tkrv5IH/uF7BLf/g0g24+lL3Z8RgntM5wxBDYc18cAce4WszfWI/P6Ap9fRV1Yf3yWL9
         0iXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782914794; x=1783519594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wrxRc+vnLGraWIGJTwPU39JSi2e4EyxL9Vxd0vYPb+E=;
        b=clAgN347iAKRoD4mCAjqZ7M0XxmVfxgcx9avyg21814Rlnk5ELZqTy/xNV3CISuHJW
         TcPgpZ5fc3sGIqFC8AgCxM8Zr7f5OHQ79CxjTaJqHKAmhAmiukbqYAUarhIoQnmKqJ1+
         rR5WZLRWCS0pGgymMAjoOWvZTA6TXrwciTY6ulDh9wC8cyV2dmeXePaVa5nasfmFcLOK
         m65GFi6H4X2yI4gJ5+h/K9hfImD3zbIhW3JRrW9wdCcUAH3og3U/LTXGDvSQXbm0wBJ4
         jTKXQEpOPU0vinAybarYD1zD0oEKMxePlTVMV42+3G8W5MMxvzoDefXAyuER1HyeJTL9
         gcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782914794; x=1783519594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wrxRc+vnLGraWIGJTwPU39JSi2e4EyxL9Vxd0vYPb+E=;
        b=KA99d4VwCVgoAwEyJBmVSw903gxt1PLCsQ96LghsyY/eXKwGI5w2VR4rIRq5wGp5z7
         kcsx7bjIYt/TqkNw15Du2gjRWO7Ta/58Yj+XwkY7HFuDkC5GgjXcj04n7f1gM8v53JMi
         i2HK7zeiWxuQUxhhVg/EbG+JXZid09FtLenN7Syh1D09dmrjl89SM27MhChHSHpKULKZ
         UeKnQGyCyXsAPAB2oXkodIz/ij4sF8no1zhw5SHSQOg45z++Z6W4qu7/MO1/S8OUxGqC
         BvikiDRVW2Cfq+vMUxKgJua9kAZnm5m5pAeBvV965ek/9J0GWhqmumMy4uvW1F5me/yW
         TDOA==
X-Gm-Message-State: AOJu0Yya3mzhUzdNYyPKqVelPcesxXHx2WuVH69nHkt79UrMcQ1zhHUn
	k01B/HgQTMJ85/8/aEqV5pZA4l6CRQg+SfEBFTgTxaJIrB/aYuf7BbXqh/sLdyVdsebPUqWvLAx
	J70Bli/Mv0FadPtDKN8AMD2apkw7pfU5QlrPE
X-Gm-Gg: AfdE7clY/5p4WLopgl9v5bAEEbU8FRh0hYGZSrI5caXPG8vNIPF7Fo8YFOBLldwSXgd
	udkO26JVGsYfcQLjbjZYyGRMjmXrCH3wZR2oAft56PekEbMLAsoBuuGlld3mT6rgsbkJcHuGEw5
	IXqmmhsiGLKPbHKKYU08NNHfXohZtbBGm0YhAR7QrrfsSIErOpt2izwQ3x55qw/qHtBPo4PueT5
	FPjXEmjEIy6CXRDYbCudkqMAzYyi2d3Om1AXbt5sfpx8E9gi4jqInzu/JxzwEEawPF2arIhsg==
X-Received: by 2002:a05:690e:1512:b0:664:dbfc:e468 with SMTP id
 956f58d0204a3-665916765femr864770d50.9.1782914794181; Wed, 01 Jul 2026
 07:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
 <54e7877f76944bd29e57d6eafe5e3811@realtek.com> <CAG0V13Qfp+eVCR6NjQJydN-fL8tus_EyJCWGQqQxTkKA9ZXBFQ@mail.gmail.com>
 <02d3be993ed84cf983cf995e53c86f1f@realtek.com> <CAG0V13T_Ujautadyaqxjy_8zqWFbz1JiRp9bpWO-T7Gy9O+mnA@mail.gmail.com>
In-Reply-To: <CAG0V13T_Ujautadyaqxjy_8zqWFbz1JiRp9bpWO-T7Gy9O+mnA@mail.gmail.com>
From: Doug Brewer <brewer.doug@gmail.com>
Date: Wed, 1 Jul 2026 22:06:22 +0800
X-Gm-Features: AVVi8CdaNS9_5D0Ik7LAUXRRlnkOXHLaec8Gv7MYWAgbCoUQRm7CBpq5tllNSR0
Message-ID: <CAG0V13Si0iPLm-2KxgcEs_i+Jm4W4pM7O2KQS49dPM8HW7gK5w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-38460-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brewerdoug@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F5476EE8CF

On Wed, Jul 1, 2026 at 2:40=E2=80=AFPM Doug Brewer wrote:
>
> On Tue, Jun 30, 2026 at 8:51=E2=80=AFAM Ping-Ke Shih wrote:
> >
> > Doug Brewer  wrote:
> > > On Mon, Jun 29, 2026 at 10:10=E2=80=AFAM Ping-Ke Shih  wrote:
> > > >
> > > > Doug Brewer wrote:
> > > > > Hi,
> > > > >
> > > > > I'm experimenting with Wi-Fi Display (Miracast sink) concurrent w=
ith an
> > > > > STA connection on an RTL8852BE (PCIe) using the mainline rtw89 dr=
iver
> > > > > (kernel 6.18.37).
> > > > >
> > > > > iw phy reports:
> > > > > Supported interface modes:
> > > > >    * managed, AP, P2P-client, P2P-GO
> > > > >    (no P2P-device)
> > > > > interface combinations are not supported
> > > > >
> > > > > In practice this blocks the standard P2P flow: there is no P2P-de=
vice
> > > > > iftype for a dedicated discovery context, and no advertised inter=
face
> > > > > combination for managed + P2P-client coexistence.
> > > > >
> > > > > My questions:
> > > > > 1. is P2P-device iftype support planned for rtw89 on RTL885x? Is =
there a
> > > > >     known technical blocker, or is it simply not yet implemented?
> > > >
> > > > We are planning to add P2P-device iftype. It needs to consider the =
cases of
> > > > channel context, conditions of power save, and etc. It will take so=
me time.
> > > >
> > > > I think it would be okay that you use STA interface to do P2P negot=
iation,
> > > > and then create P2P-client or P2P-GO iftype then.
> > > >
> > > > > 2. would advertising a managed + P2P-client interface combination
> > > > >     (single channel) be feasible on the current rtw89?
> > > >
> > > > This is a SCC which is supported.
> > > >
> > > > > 3. is MCC (#channels > 1) on the roadmap, or considered out of sc=
ope?
> > > >
> > > > Current support MCC as well. However, we are cooking new firmware t=
o support
> > > > hw_scan with two operation channels -- which doesn't matter if you =
don't need
> > > > to do scan when MCC is operating.
> > >
> > > Thanks for the suggestion. I tried using the STA interface for P2P
> > > negotiation, and wanted to share what I found.
> > >
> > > With the STA connected (2.4GHz ch11) and an active p2p_connect, a
> > > wpa_supplicant -dd trace shows GO negotiation getting fairly far:
> > >
> > > Peer's GO-NEG Request is received
> > > send the GO-NEG Response on ch11, peer ACKs it (TX ack=3D1)
> > > State goes GO_NEG -> CONNECT
> > > then time out waiting for the GO-NEG Confirm, status=3D-1
> > >
> > > I select ch11 as the P2P operating channel (same as STA, SCC), while
> > > the peer's operating preference is 5GHz ch149. It looks like after we=
 TX
> > > the Response, the radio doesn't stay on ch11 to listen for the Confir=
m,
> > > so the frame is missed -- presumably because the single radio is serv=
ing
> > > the STA connection.
> >
> > So, peer doesn't stay ch11 to complete he negotiation, right?
> >
> > What is the peer device you are using? Can you setup another RTL8852BE?
> > I suggest running simple scenario first to dig cause.
> >
> > 1. two peers make P2P group without any STA connection
> > 2. RTL8852BE with a STA connection, and peer without connection.
> >
> > >
> > > Aalso tested with the STA on 5GHz (ch149); the result is the same
> > > GO-NEG Confirm timeout.
> > >
> > > Is this the channel-context issue that P2P-device iftype will address=
?
> > > And with the current driver, is there any way to keep the P2P listen
> > > context on the operating channel during GO negotiation while STA is u=
p?
> >
> > Before P2P negotiation completion, there is only one channel context.
> > The second interface (GC or GO) is created when the P2P role is decided
> > by P2P negotiation.
> >
> > You need to check supplicant log about channels on both peers. I think
> > remain-on-channel is the method supplicant switch channel to send
> > negotiation frames and to stay on listen channel.
> >
> > >
> > > (FWIW, passing an explicit freq=3D to p2p_connect is rejected with FA=
IL,
> > > whether or not it matches the STA channel.)
> >
> > Not sure why. In our side, it seems work.
> >
> >
> > I'd share a pair of wpa_supplicant .conf and wpa_cli commands we are te=
sting
> > for reference.
>
> Great progress using your test conf and a second RTL8852BE. Results:
>
> Two RTL8852BE peers, no STA =E2=80=94 P2P connects fine (GO/client, group=
 formed,
> 4-way HS completed).
>
> One RTL8852BE with STA on 5GHz ch149, the other RTL8852BE with no STA,
> also succeeds. The GO comes up on ch153 while the STA stays on ch149 (so =
MCC),
> group formed, client connected. Both sides confirmed via iw dev
> (GO on ch153 + STA on ch149; peer client on ch153).
>
> So STA + P2P coexistence, including MCC, works fine between two 8852BE pe=
ers.
>
> p2p_no_group_iface=3D1 in your conf may have contributed, P2P runs on the=
 main
> interface instead of a separate group interface.
>
> Thank you very much for the test conf and guidance.

One more update. Two RTL8852BE peers (STA + P2P) work reliably, as
reported.

However, with a Samsung phone as the peer, GO negotiation is
inconsistent =E2=80=94 using your conf (including p2p_no_group_iface=3D1), =
the same
setup sometimes completes and sometimes fails with GO-NEG Confirm timeout
(status=3D-1).

Do you have any suggestion for this case with a real phone peer?

Thank you again for the guidance.

Regards,
Doug

