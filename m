Return-Path: <linux-wireless+bounces-38435-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lvJJI3q2RGpyzQoAu9opvQ
	(envelope-from <linux-wireless+bounces-38435-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 08:40:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243E26EA48C
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 08:40:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qGXQ1I98;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38435-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38435-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FB783016B74
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CAE3A0B05;
	Wed,  1 Jul 2026 06:40:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECB2DB78C
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 06:40:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888055; cv=pass; b=pV5Hir4n5j7ZNm60QrYsyyZ5uvOjd/7ObspKAkOsyW3GmC8lTmqFt4ymiNyKn1Afvgh1fQsogoiKryjSLPQWOmYSn9IzLilrNdxcKEzGSX0ACEIbP4lgTb8j/xTz2pM/mAq/FXCGnY/lWlhgDpxoppDgO/FX/lJ63pfkIurbfmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888055; c=relaxed/simple;
	bh=FkNGGK5Qpt8V6OC8b3p1VUkIQC8dqra/rirLMLLz5Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/sxBU8Ai7ieeBLdftXQRdWV0ykRYPyWBAbjavnCfdi/7wqep65YHEps0tBkCrVGXkGMeHVUq0XF0aClG5nqM9t31nfw7WebyBe31cfkYXHgsKSKONzHymM65//MXXpAhCRzNhVJmmY6ekcot7Cdl4qw7eInxUyG6slGzlcTdD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGXQ1I98; arc=pass smtp.client-ip=74.125.224.54
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664a10cd4a4so291791d50.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 23:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782888053; cv=none;
        d=google.com; s=arc-20260327;
        b=ExPp4V8RD14K4RtgUq96XiBcBE3vfU8+Cada13qNxnslACJ4HJGV0r5deJu0Py9SaA
         TIreHQKYUvnTIwt7xBTylY5olbDlhPmTyk9qcudpCqZ4+skw6JALnt+FOAraZ7l9m0Yj
         0EtpdvoZYlz++wCR6+q6xNxhLGpLJDnVhIFtIzal1yN6dzWq7iMfliS74b9m0H1I9qag
         nAhuX/BV5hdxJO3qzqqr1PS5kuU0hotHRSrajWqI/nzHLMN+yJ5cxeF219ERINCFcgax
         cMslEmdkPYJ75nuQCDzBKcpNuLNr6KEijcebOepmUc6Oh4ux4+1yvp8Y6MJfgQtsa59x
         VJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wq1zL5FeNn6UHLWkir6u/GW66JHQsFkG2l3gRlEawnk=;
        fh=zFCB9yj6tbPtiNOgT9n/qK9LnQKfgtX1AWhCxXtoerY=;
        b=Qu4naivvPq6xFoaDz1X8j/7Txbgv4yKT2q9bk0EiPVej3ISPpfoT9a373fjKKcQGGE
         Ya0kSmf1IjMsbzxXzU+Pnvwsvn3asgU8GPPPl7DDUaTnx527d71kyoLrUTnBUfWDW9Vb
         pIhPRzDvCqaRZB/9WOIa8qlzf8SD2Hmqe8DaneYFZn2kTwg4y/ZnVPCPXYDlNLNfKbVp
         GX+fryjV3BXsi43zjKneFe6IvOpr9lUWPtYzAGEf91MDwChzk33CIGqN5+xSESU2AIxw
         VQ3Ma0aQAk4XAEFWjQzH4ZgmvYu4QEdtxpRAlzS4/wSIBt1dP7DUCqvrmTkWmKnqbGC0
         oU5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782888053; x=1783492853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq1zL5FeNn6UHLWkir6u/GW66JHQsFkG2l3gRlEawnk=;
        b=qGXQ1I98RcXronLqAkxcYIHNG1nVRJm0piX368sXTfzIB3n+2PmZNYVIFW9VCIg/aH
         VzNpOx8hLtX8B4T7b7C8WPj3pb4rrULkm9L6QqQx0GW9wXW+4ea0uTAtOJEn74lzB9m1
         KDpO462MlICIfM8QgtA6v0mMb95dIm1wBaBZAj1ldWhHKD5Ypv6oZ+ofWRjWix6Fihsj
         q3haldFYsk+uZW/Lf2AhNTSPI7+kff4E86eww5qniNFppjlO4zsZbb8X09QLq9oyGWAP
         Kh/mrPMjFiqm4c8+/9Tos2vCyXc2qWrEXjzXHEXt4O8rPunH0L6Pho//9a20wCKgrirO
         3dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888053; x=1783492853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wq1zL5FeNn6UHLWkir6u/GW66JHQsFkG2l3gRlEawnk=;
        b=pJTIGn6b5id1UYkNxDUnbqA2TlHC2ujI6hE1umRaVS1uQDNtjev1ifMll6WA7r47w3
         w88YSFyas6b/IoHPKZnhUWS+aVEexZl3WEV9bTp6SUuwKaRhCB3PUmn6nVkaFr6WTJEI
         uxv5pFxbciN36sDoVlOQHH8cF5/EAxPGlAblhtGAveu+vjkyEzzR+ze+vykucYWH1XLb
         znwlA2txSkC8lpDOyeXWLffR3seaa0QPFYOCYbjRnlxtFS0ubz2Zb1qh6ysEBujMZAKi
         JokLKeaopqQvy27W0GzwXu9gWUA/B+6DqfTgpA8AwxGFiYWG1earE/xHqjdDnp2lHdbI
         6QJA==
X-Gm-Message-State: AOJu0YyJcEp9MAMegd9N/U371Pe0GOW5fsErywLVjxa7My/OMttyUdPj
	7+9mtDEaOjvwW6KwYIXxFjz4MfvVXnNKTA5AV60qYOpyPWf5aIxOl4kaJp+vF9R5ioD/modDO6r
	qSHlROMPjXHNFRaeA1PpUWcRVTroUhis=
X-Gm-Gg: AfdE7cnR5K2kr7w7aZ2HYvIhsIs8CxFfsNtRpjV1XGTXp/y0FsjhJ8wpxTmvl6jPmmy
	goa4YI7cTxF9HfsbhLgF1aZ3oTAx0ri+Lnqy/+H5krZNzLQdaHGHW5hHy695Mu5M2QLgaZozeXM
	jEn+rz1y2c8I45yLKeu9iWx7HqBR/zYjZQGAv7CM1UY+2f5zaW+s+xHi2ugHhYD+XEzSGo+sRIi
	ql6TVnkC5y7aWHM5hD3RtY2Otfid1+PZKOTqujBiIelE5m3Xcu+oYJs49ViUA2hfFAaJyzOVX8+
	Oz7Dn54=
X-Received: by 2002:a05:690e:12c4:b0:664:be82:2b6a with SMTP id
 956f58d0204a3-66521be5e28mr365289d50.38.1782888052633; Tue, 30 Jun 2026
 23:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG0V13TRHzXtoMY=XZMOd=WjzS58Cu=aePFCz8mY6UoGYm5dXw@mail.gmail.com>
 <54e7877f76944bd29e57d6eafe5e3811@realtek.com> <CAG0V13Qfp+eVCR6NjQJydN-fL8tus_EyJCWGQqQxTkKA9ZXBFQ@mail.gmail.com>
 <02d3be993ed84cf983cf995e53c86f1f@realtek.com>
In-Reply-To: <02d3be993ed84cf983cf995e53c86f1f@realtek.com>
From: Doug Brewer <brewer.doug@gmail.com>
Date: Wed, 1 Jul 2026 14:40:41 +0800
X-Gm-Features: AVVi8Cf0Ra2ygHuJWnVvYfl-pIPebv2AJD81DqNephy4zMcFTd9rQ3vtjcWDqG4
Message-ID: <CAG0V13T_Ujautadyaqxjy_8zqWFbz1JiRp9bpWO-T7Gy9O+mnA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-38435-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brewerdoug@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 243E26EA48C

On Tue, Jun 30, 2026 at 8:51=E2=80=AFAM Ping-Ke Shih wrote:
>
> Doug Brewer  wrote:
> > On Mon, Jun 29, 2026 at 10:10=E2=80=AFAM Ping-Ke Shih  wrote:
> > >
> > > Doug Brewer wrote:
> > > > Hi,
> > > >
> > > > I'm experimenting with Wi-Fi Display (Miracast sink) concurrent wit=
h an
> > > > STA connection on an RTL8852BE (PCIe) using the mainline rtw89 driv=
er
> > > > (kernel 6.18.37).
> > > >
> > > > iw phy reports:
> > > > Supported interface modes:
> > > >    * managed, AP, P2P-client, P2P-GO
> > > >    (no P2P-device)
> > > > interface combinations are not supported
> > > >
> > > > In practice this blocks the standard P2P flow: there is no P2P-devi=
ce
> > > > iftype for a dedicated discovery context, and no advertised interfa=
ce
> > > > combination for managed + P2P-client coexistence.
> > > >
> > > > My questions:
> > > > 1. is P2P-device iftype support planned for rtw89 on RTL885x? Is th=
ere a
> > > >     known technical blocker, or is it simply not yet implemented?
> > >
> > > We are planning to add P2P-device iftype. It needs to consider the ca=
ses of
> > > channel context, conditions of power save, and etc. It will take some=
 time.
> > >
> > > I think it would be okay that you use STA interface to do P2P negotia=
tion,
> > > and then create P2P-client or P2P-GO iftype then.
> > >
> > > > 2. would advertising a managed + P2P-client interface combination
> > > >     (single channel) be feasible on the current rtw89?
> > >
> > > This is a SCC which is supported.
> > >
> > > > 3. is MCC (#channels > 1) on the roadmap, or considered out of scop=
e?
> > >
> > > Current support MCC as well. However, we are cooking new firmware to =
support
> > > hw_scan with two operation channels -- which doesn't matter if you do=
n't need
> > > to do scan when MCC is operating.
> >
> > Thanks for the suggestion. I tried using the STA interface for P2P
> > negotiation, and wanted to share what I found.
> >
> > With the STA connected (2.4GHz ch11) and an active p2p_connect, a
> > wpa_supplicant -dd trace shows GO negotiation getting fairly far:
> >
> > Peer's GO-NEG Request is received
> > send the GO-NEG Response on ch11, peer ACKs it (TX ack=3D1)
> > State goes GO_NEG -> CONNECT
> > then time out waiting for the GO-NEG Confirm, status=3D-1
> >
> > I select ch11 as the P2P operating channel (same as STA, SCC), while
> > the peer's operating preference is 5GHz ch149. It looks like after we T=
X
> > the Response, the radio doesn't stay on ch11 to listen for the Confirm,
> > so the frame is missed -- presumably because the single radio is servin=
g
> > the STA connection.
>
> So, peer doesn't stay ch11 to complete he negotiation, right?
>
> What is the peer device you are using? Can you setup another RTL8852BE?
> I suggest running simple scenario first to dig cause.
>
> 1. two peers make P2P group without any STA connection
> 2. RTL8852BE with a STA connection, and peer without connection.
>
> >
> > Aalso tested with the STA on 5GHz (ch149); the result is the same
> > GO-NEG Confirm timeout.
> >
> > Is this the channel-context issue that P2P-device iftype will address?
> > And with the current driver, is there any way to keep the P2P listen
> > context on the operating channel during GO negotiation while STA is up?
>
> Before P2P negotiation completion, there is only one channel context.
> The second interface (GC or GO) is created when the P2P role is decided
> by P2P negotiation.
>
> You need to check supplicant log about channels on both peers. I think
> remain-on-channel is the method supplicant switch channel to send
> negotiation frames and to stay on listen channel.
>
> >
> > (FWIW, passing an explicit freq=3D to p2p_connect is rejected with FAIL=
,
> > whether or not it matches the STA channel.)
>
> Not sure why. In our side, it seems work.
>
>
> I'd share a pair of wpa_supplicant .conf and wpa_cli commands we are test=
ing
> for reference.

Great progress using your test conf and a second RTL8852BE. Results:

Two RTL8852BE peers, no STA =E2=80=94 P2P connects fine (GO/client, group f=
ormed,
4-way HS completed).

One RTL8852BE with STA on 5GHz ch149, the other RTL8852BE with no STA,
also succeeds. The GO comes up on ch153 while the STA stays on ch149 (so MC=
C),
group formed, client connected. Both sides confirmed via iw dev
(GO on ch153 + STA on ch149; peer client on ch153).

So STA + P2P coexistence, including MCC, works fine between two 8852BE peer=
s.

p2p_no_group_iface=3D1 in your conf may have contributed, P2P runs on the m=
ain
interface instead of a separate group interface.

Thank you very much for the test conf and guidance.

> Peer 1:
> ctrl_interface=3D/var/run/wpa_supplicant
>
> network=3D{
>         ssid=3D"ap_x"
>         key_mgmt=3DNONE
>
> }
>
> update_config=3D1
> device_name=3Dmy_p2p
> manufacturer=3DRealtek
> model_name=3DRTW_STA
> model_number=3DWLAN_CU
> serial_number=3D12345
> device_type=3D1-0050F204-1
> os_version=3D01020300
> config_methods=3Dvirtual_display virtual_push_button keypad
> p2p_listen_reg_class=3D81
> p2p_listen_channel=3D1
> p2p_oper_reg_class=3D81
> p2p_oper_channel=3D1
> p2p_no_group_iface=3D1
>
>
> wpa_supplicant -i wlan0 -c p2p.conf
> wpa_cli
> > p2p_find
> > p2p_connect $SUT_MAC_ADDR pbc (freq=3Dxxxx go_intent=3D15)
>
>
> Peer 2:
> ctrl_interface=3D/var/run/wpa_supplicant
> update_config=3D1
> device_name=3Dmy_p2p
> manufacturer=3DRealtek
> model_name=3DRTW_STA
> model_number=3DWLAN_CU
> serial_number=3D12345
> device_type=3D1-0050F204-1
> os_version=3D01020300
> config_methods=3Dvirtual_display virtual_push_button keypad
> p2p_listen_reg_class=3D81
> p2p_listen_channel=3D1
> p2p_oper_reg_class=3D81
> p2p_oper_channel=3D1
> p2p_no_group_iface=3D1
>
> wpa_supplicant -i wlan0 -c p2p.conf
> wpa_cli
> > p2p_find
> > p2p_connect $DUT_MAC_ADDR pbc (freq=3Dxxxx go_intent=3D1)
>
> Regards
> Ping-Ke

Regards,
Doug

