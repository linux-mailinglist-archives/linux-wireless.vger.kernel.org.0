Return-Path: <linux-wireless+bounces-38615-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NiB4Ks+vSGqBsgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38615-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 09:01:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E1706E4D
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 09:01:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Gn0PZU4C;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38615-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38615-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A419D3012CB8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF51891A9;
	Sat,  4 Jul 2026 07:01:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53396273D77
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 07:01:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783148492; cv=pass; b=QgZZrubtxevQNO3vMUNq/2Se5uuVFW6Flm4K+/b+YBJkc1GhwfJOEO2nrIFCWfRsRoeFJFNaDh+NlPbdyUGm0a5MKRuxJlhKbbHhKeU9AU9bJIpg1WQ7jOvsqR5AKJDRTwX+O2tMI7n1AW5wUXn3htLoW3Kug/2mSi21FV+S51E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783148492; c=relaxed/simple;
	bh=pBEIZ/nwhmoAOubR1xU1kmLTiLeTFD78nYfb/Oh+Gu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8io+UP84gCRS6uGHwCrjTwLJj88C0ovf7BOvJULZSxxvqxzKS+C/W2j+gMjxjWBAlpha3i1Mum8J9QrDj0a0F7pdWCpdogrsepTlk/BesG79Ak3rOhGzyLojE6vxkzpgqHlkrr3ClsLq8UOu6C00vApG+sZHTjDsd98cJZbIZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn0PZU4C; arc=pass smtp.client-ip=74.125.224.44
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664ae993e4bso2297040d50.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 00:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783148490; cv=none;
        d=google.com; s=arc-20260327;
        b=WwOjErT+Hx1lh7AQSSAKahi9rlXiHRfSBogbCQN5HPfk+gOqTTIlPeCYGStQ8yrvdO
         skkYc5ijk/r/rmz8fDyjbjOMPNqvyLUY/NJNx24caMlUgunWNekF8JssxUP0Tp3semIR
         gH8tFCP+zesAkxAotSEbNs2RZvhbcV1uzgRwO06Iiu/RjIVbBS8SGNv68ivBi+kk+sSC
         E2v6f+3I3wbf+tBFRuIERRJgfxDlMnitCVN82p39WBJokmMsvEwTkOy+W59MlaPurNwJ
         kC28ZUSohpXMmbk4o5HTnImzguU//ff0/SfrU/Iea7sHft525Gnmva0TkBMIj+Y6p/ST
         5VKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SYJfTGhqS4Iz1C2Q3Kxs/9rX0FuHq9HAO6P7MPUlVhI=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=CInaOxD8jsFkD/JvqMeLhDaZV9Tq5/BoLjkgPFHmSQDh0YKz5htXYSbgbzqVcqr4MS
         6JDonHzBJj8TarVKxKnApobKttN2U8YLrDrZ8k6kneSVGdFP6+qfJlKP3tZbVkQgC1aM
         mcok2091S0LGmS0eN8M5mnjIRVCL+fiot8UqefhZXcbRw2aeZ2O4S1fnqONSQv0FgEH5
         WiXtfakknqzUIpjB+dNbmCXhYWMrEkDWkT1MdzoQCt4YAndpHrCrqTkK2tqMQs4Bd9ed
         NXT95IU0MY4WBKxn8509Kzi8iZTSAxwQhMXo2PCrvf0ImeJYHWT+3yi2P/NCxQFjjDU/
         sxcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783148490; x=1783753290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYJfTGhqS4Iz1C2Q3Kxs/9rX0FuHq9HAO6P7MPUlVhI=;
        b=Gn0PZU4CcvapJo5lZrHrjbBLDlMJq+h4lDOKLTJSn/L9DOQAzzOUNtcDLOoftpRxjR
         Ow5ymQgUG300KtubboYsNBsMfKEzUAGMAGiihXIlF4pP3iZr3pxchzA+zzFy9zKiOb3N
         UezQP2No78Xl+exfHAUJlFkm2BmZUT7+32htMXDM72Y98SXq/yzhDB7qFZLdqgM3cC3N
         TJtMBVPFfKFI+Ga8i3z3fWaDlXtshaeXas+biQ7S4jPLnIYMW9WNqg8dkRRXTt5Qa3Nk
         FfegEC6KvOHYWnXEAd/tdl6HurzmPr2KF6rs0a7ZMLwDeGn0BYWdiTVDjKy/IsaOEj8Q
         pczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783148490; x=1783753290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYJfTGhqS4Iz1C2Q3Kxs/9rX0FuHq9HAO6P7MPUlVhI=;
        b=N05ep89HOvPH38YsitWaemMAri4rN9ZkuHhSLxrRv6oh8vdTj/A+t6uCmI9sna8lwC
         1ZP9Ud3RIYOFJ71T9TYNpKzGzIs1utaR3TQ5KMQTOvRHdfvK025agW5zPia7MmDVy2iz
         M/3zQBIq0R+OlptuEh0NnU8V7ai7B70AUzV8La7SLcs6Onw9mwHlPPs5brBjj31yDcOJ
         Zr8GxNpvgsfAak/dGZWO33ZXQx24IM5tW+a25RZFac3JkqzUOuaK1LLUR/TqcdVfK59E
         RU2efnpElGe7NH9cuQdQPatWf0NDDe7W9OvaVJZiu4KWDxIvS/DkHDFQgRXUX73dd7hC
         a2Tw==
X-Gm-Message-State: AOJu0YzUrPKxv/sv+9/T7ZvnRKKbiAdoRzjqRvHx5LOOI5DQhCKLBSfx
	fMwKARw4kUi9DuQ0xGt3Oil3HrRak711GVxniisXHSYqDJR/cweGn9D4EDhD/ShKQz+Gs/EzGgV
	0hd2239l+uEMaGvupYZEK2DZpYB11moX8Nh66
X-Gm-Gg: AfdE7ckeCQCQpbMztS3i/hhbxHYVlvnKbwsWio9+ahxQ7p/7ykLtTHvE6xzKF40TxIw
	6cFpYD77fGwAOKAni9rzxzZZVfPB8K6R9LGMkq5bKWcw0z4Dc1xcmCIJbS3Hq1Jnm0CFMIqm+En
	S71Yth3Xlhn9SwR3IwOZ0dQb2UHMqYbChosFbjU+uLFPzV/LkJOPxlMJVEjt6yvCN2FOLa41p5P
	0mthgfm7i5fq+ZpKH58rY3zzLP5/IKPBv/lh0h7fTm6gURsksBU0yEO/aJl7kPpKkIvWWzGXA==
X-Received: by 2002:a05:690e:d43:b0:666:53bb:bc1f with SMTP id
 956f58d0204a3-66653bbc4eamr1619651d50.1.1783148490070; Sat, 04 Jul 2026
 00:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
 <54e7877f76944bd29e57d6eafe5e3811@realtek.com> <CAG0V13Qfp+eVCR6NjQJydN-fL8tus_EyJCWGQqQxTkKA9ZXBFQ@mail.gmail.com>
 <02d3be993ed84cf983cf995e53c86f1f@realtek.com> <CAG0V13T_Ujautadyaqxjy_8zqWFbz1JiRp9bpWO-T7Gy9O+mnA@mail.gmail.com>
 <CAG0V13Si0iPLm-2KxgcEs_i+Jm4W4pM7O2KQS49dPM8HW7gK5w@mail.gmail.com> <263dd9579f594178bccaf866e7c5db90@realtek.com>
In-Reply-To: <263dd9579f594178bccaf866e7c5db90@realtek.com>
From: Doug Brewer <brewer.doug@gmail.com>
Date: Sat, 4 Jul 2026 15:01:18 +0800
X-Gm-Features: AVVi8CdDyJIfIRADiV3RC62flxVa4rp3GNPQ-WKTYeqq0hJVneUypT2jrh5USsY
Message-ID: <CAG0V13QZ=2p672h0K3JeeDDCJ3c-NPmDY9YoPe8AL-b5gig6PQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-38615-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brewerdoug@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 158E1706E4D

On Fri, Jul 3, 2026 at 8:43=E2=80=AFAM Ping-Ke Shih wrote:
>
> Doug Brewer <brewer.doug@gmail.com> wrote:
> > On Wed, Jul 1, 2026 at 2:40=E2=80=AFPM Doug Brewer wrote:
> > >
> > > On Tue, Jun 30, 2026 at 8:51=E2=80=AFAM Ping-Ke Shih wrote:
> > > >
> > > > Doug Brewer  wrote:
> > > > > On Mon, Jun 29, 2026 at 10:10=E2=80=AFAM Ping-Ke Shih  wrote:
> > > > > >
> > > > > > Doug Brewer wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > I'm experimenting with Wi-Fi Display (Miracast sink) concurre=
nt with an
> > > > > > > STA connection on an RTL8852BE (PCIe) using the mainline rtw8=
9 driver
> > > > > > > (kernel 6.18.37).
> > > > > > >
> > > > > > > iw phy reports:
> > > > > > > Supported interface modes:
> > > > > > >    * managed, AP, P2P-client, P2P-GO
> > > > > > >    (no P2P-device)
> > > > > > > interface combinations are not supported
> > > > > > >
> > > > > > > In practice this blocks the standard P2P flow: there is no P2=
P-device
> > > > > > > iftype for a dedicated discovery context, and no advertised i=
nterface
> > > > > > > combination for managed + P2P-client coexistence.
> > > > > > >
> > > > > > > My questions:
> > > > > > > 1. is P2P-device iftype support planned for rtw89 on RTL885x?=
 Is there a
> > > > > > >     known technical blocker, or is it simply not yet implemen=
ted?
> > > > > >
> > > > > > We are planning to add P2P-device iftype. It needs to consider =
the cases of
> > > > > > channel context, conditions of power save, and etc. It will tak=
e some time.
> > > > > >
> > > > > > I think it would be okay that you use STA interface to do P2P n=
egotiation,
> > > > > > and then create P2P-client or P2P-GO iftype then.
> > > > > >
> > > > > > > 2. would advertising a managed + P2P-client interface combina=
tion
> > > > > > >     (single channel) be feasible on the current rtw89?
> > > > > >
> > > > > > This is a SCC which is supported.
> > > > > >
> > > > > > > 3. is MCC (#channels > 1) on the roadmap, or considered out o=
f scope?
> > > > > >
> > > > > > Current support MCC as well. However, we are cooking new firmwa=
re to support
> > > > > > hw_scan with two operation channels -- which doesn't matter if =
you don't need
> > > > > > to do scan when MCC is operating.
> > > > >
> > > > > Thanks for the suggestion. I tried using the STA interface for P2=
P
> > > > > negotiation, and wanted to share what I found.
> > > > >
> > > > > With the STA connected (2.4GHz ch11) and an active p2p_connect, a
> > > > > wpa_supplicant -dd trace shows GO negotiation getting fairly far:
> > > > >
> > > > > Peer's GO-NEG Request is received
> > > > > send the GO-NEG Response on ch11, peer ACKs it (TX ack=3D1)
> > > > > State goes GO_NEG -> CONNECT
> > > > > then time out waiting for the GO-NEG Confirm, status=3D-1
> > > > >
> > > > > I select ch11 as the P2P operating channel (same as STA, SCC), wh=
ile
> > > > > the peer's operating preference is 5GHz ch149. It looks like afte=
r we TX
> > > > > the Response, the radio doesn't stay on ch11 to listen for the Co=
nfirm,
> > > > > so the frame is missed -- presumably because the single radio is =
serving
> > > > > the STA connection.
> > > >
> > > > So, peer doesn't stay ch11 to complete he negotiation, right?
> > > >
> > > > What is the peer device you are using? Can you setup another RTL885=
2BE?
> > > > I suggest running simple scenario first to dig cause.
> > > >
> > > > 1. two peers make P2P group without any STA connection
> > > > 2. RTL8852BE with a STA connection, and peer without connection.
> > > >
> > > > >
> > > > > Aalso tested with the STA on 5GHz (ch149); the result is the same
> > > > > GO-NEG Confirm timeout.
> > > > >
> > > > > Is this the channel-context issue that P2P-device iftype will add=
ress?
> > > > > And with the current driver, is there any way to keep the P2P lis=
ten
> > > > > context on the operating channel during GO negotiation while STA =
is up?
> > > >
> > > > Before P2P negotiation completion, there is only one channel contex=
t.
> > > > The second interface (GC or GO) is created when the P2P role is dec=
ided
> > > > by P2P negotiation.
> > > >
> > > > You need to check supplicant log about channels on both peers. I th=
ink
> > > > remain-on-channel is the method supplicant switch channel to send
> > > > negotiation frames and to stay on listen channel.
> > > >
> > > > >
> > > > > (FWIW, passing an explicit freq=3D to p2p_connect is rejected wit=
h FAIL,
> > > > > whether or not it matches the STA channel.)
> > > >
> > > > Not sure why. In our side, it seems work.
> > > >
> > > >
> > > > I'd share a pair of wpa_supplicant .conf and wpa_cli commands we ar=
e testing
> > > > for reference.
> > >
> > > Great progress using your test conf and a second RTL8852BE. Results:
> > >
> > > Two RTL8852BE peers, no STA =E2=80=94 P2P connects fine (GO/client, g=
roup formed,
> > > 4-way HS completed).
> > >
> > > One RTL8852BE with STA on 5GHz ch149, the other RTL8852BE with no STA=
,
> > > also succeeds. The GO comes up on ch153 while the STA stays on ch149 =
(so MCC),
> > > group formed, client connected. Both sides confirmed via iw dev
> > > (GO on ch153 + STA on ch149; peer client on ch153).
> > >
> > > So STA + P2P coexistence, including MCC, works fine between two 8852B=
E peers.
> > >
> > > p2p_no_group_iface=3D1 in your conf may have contributed, P2P runs on=
 the main
> > > interface instead of a separate group interface.
> > >
> > > Thank you very much for the test conf and guidance.
> >
> > One more update. Two RTL8852BE peers (STA + P2P) work reliably, as
> > reported.
> >
> > However, with a Samsung phone as the peer, GO negotiation is
> > inconsistent =E2=80=94 using your conf (including p2p_no_group_iface=3D=
1), the same
> > setup sometimes completes and sometimes fails with GO-NEG Confirm timeo=
ut
> > (status=3D-1).
> >
> > Do you have any suggestion for this case with a real phone peer?
>
> I'd suggest the simplest use case which your Samsung phone doesn't connec=
t to
> an AP, and remove all STA networks from the phone. That means the phone o=
nly
> has one interface working on P2P.

Your suggestion worked!!! Thank you very much.
After removing all saved Wi-Fi networks from the Samsung phone
(so it runs only P2P, no STA), the GO negotiation became reliable,
and STA + P2P now coexist on rtl8852be.

> If you need to dig the problems related to P2P channels, I suggest you ca=
n
> setup RTL8852BE sniffer to capture packets on two channels simultaneously=
.
> One method is to install two RTL8852BE in a computer, and use single one
> wireshark to capture two interfaces (setup the two channels manually).
> The other is to setup two computers to capture each of two channels,
> and then merge the sniffer files (note that you must synchronize the
> host time to merge the files properly).
>
> Ping-Ke

Regards,
Doug

