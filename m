Return-Path: <linux-wireless+bounces-37368-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1oeEC729IGqS7QAAu9opvQ
	(envelope-from <linux-wireless+bounces-37368-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 01:50:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE8763BEB0
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 01:50:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="ocz8Dl/p";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37368-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37368-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C9A4302296D
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 23:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2494B8DC0;
	Wed,  3 Jun 2026 23:47:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CA44CAE0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 23:47:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530433; cv=pass; b=tSjcUz9TEPrYdktg0TUeYhMUkSVaWRbhSLoQ38WvUa0dMzocXWXYUyFxqbSRKyX3/e2sesVW8WPDUO2FrQKbmlvSaBen77OSh3KZ8gm4GOPRbzAkbTXU84FpAT39HWe2qYGXsfKPYrFIOSnLiwrVxGbeUGzuWJZqyXqhkf2Kx8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530433; c=relaxed/simple;
	bh=8SEDpvoiCYKjdtxkdOpE2kdb8M5UEbwBzeVXGTDeLSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6pDvne4um+UfxKJP1nwgU+ONu6AZFK9Qhutjn53T84juXOHpAjRiz6pKgOXR6JLT2KmZr5TDzNWIoMbQoyVgZmxwkkRWReCpqw0vBCI3TZKYOKf6lQQGFBrnizmX+5WfKUK6NYn5uM62uB1A8CJK4q4IsbautkUjhx/UXJ3xyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ocz8Dl/p; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-517654b8dd4so166741cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jun 2026 16:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530429; cv=none;
        d=google.com; s=arc-20240605;
        b=VC1q4GkR/xIu5BUDcviUOvROqU2fhsGA7Jh7MTyAhB2AeWS4sTXfDal5wB7rXWy7v+
         +YUS3Ubd/4gCMltJexu6No9OwDi6IOfB6a7rkqDQM/Dip7wA4HfE8OjEZdH66bdAwbqf
         nhXdYtsnve28SPHWYdNd+0hhjq1dcoRSgW6HljQVuQAFvl+lJqiVuv0p1pE0LjCDg33Y
         5cJLBR5vlIRSX2bTr8pD6KjvZzAjOd2IIWH2Wnnq9okRzllJ+ZWzYnMnRlTwKqoyxhqp
         IvdOg/0h7VfDEcQbYQua+hMVs2NBW0AmVkzrGi/Gx7IQvirCAnVCxqI+mFAqH2oYIeCi
         lrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IrsB5qlB9vbQ42mMffRvNtPBkwXix0VEJXwI5BRhHFo=;
        fh=WC22FxggZySstborvmjlc1z92TN7RkAElljzyKT1Eg0=;
        b=AV2YINuIiiRXhKRNZSC/x32qfQ2+zB5u0kavuDBPhEwB9vIrEAuXYbVX0d9OhleXas
         OoVwUy0iEHdB2b7d8AL07oqwTvuxvS5mj52DW4WW2zec1z91CVcYiarWSWjiNDkaXeKk
         jN1JZpO036QEibHSnYwGT3da1ZDuKbFz6uvSv3WTXRm46GRe9uH641+I2ohIVuFx98eQ
         wszxO04r+cPdxi0Rbxyyvqiz5J5w9zkVDbbE3i7xKa9xPZmmiA3sT18U+ZIBTXQVwgRQ
         CV8g1dl+pjTEv27Uw/JtiRir8IuATsvTMO1xXTmuKbTMurdKhOu5kV2KMwS+HZNA6W90
         cNhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530429; x=1781135229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrsB5qlB9vbQ42mMffRvNtPBkwXix0VEJXwI5BRhHFo=;
        b=ocz8Dl/pbXmb9qFeggCSP/tKkaZ1N1ncsDifE1KdKVLovM+8yz/DMilRyFjZSxbF5F
         SdJMQUNCsSeLax2GCo+Gc28m5qP330V+pD0CK9hbBoL9lcCQsNNk5pXRyScBJF31ovFA
         oI6ZIJKJ928zBkaPZDRcmPNrfLAl8yiTRlCjeWAHu6/E+tkrHO/16hH7l8WD2w9wLYRM
         7uhvIneTBgqrD9oPTMkQpnU5nCRefdlscU1zcrWklJUhA5bDOOo2RQPKAg8YTeQ5rRNB
         GibRlPde1Xgexbpzdf9fQ4Ju7KOeYS2SuwKYtlVluwqbZh0i9PC3Z97vLLhXAWw35Fw5
         VpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530429; x=1781135229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IrsB5qlB9vbQ42mMffRvNtPBkwXix0VEJXwI5BRhHFo=;
        b=Q0IlVsh1eHvdNPh1FgzEuvl64rgQVj8MeqzyxOWEr3Cgxmlm4Pm1tVntDzECsOnR8C
         ddFetBHzN8HR0JLFpqpr0Ocsc9rau5APx0LK5fFeGt59+GoCR9YdMtKm4AzSrnx42Xxg
         nUwfV9elXxi5/di83gTW14yy+DxRI7xpEWhRFurFxNDRLlYfygefnNP1kif7nyLSTvJp
         g+/fXaWtFmVji1duRciX+y3eLRZlff+Opb3sxdtynRcFVNF1UWu6sMlEKYeBPzVk6fNi
         5l4UmRFDqQzhMElLhWFMp+nn4QrBicnrPssJm990cm+RuH9JiV2eDiH45CSvu7Xv/+W6
         foKA==
X-Forwarded-Encrypted: i=1; AFNElJ+xZwFvQ/lcQGcez6raAnST3fcbCtBJE7QSr9JHTZUQpLIt1hhRb3ydkpTUfsP13PJVEmflho7GEvHpKLKiSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuT6GsMv4G/ht4OQVPqpa6Yg8QvPma+Kn0LGahgL7+alPEpw/B
	2MQrsYqKXCW/blC87yOGn1PqvRvxl2BaJehNk2DLjopvGM7vNmGa2Z/CuQRCrv7a4ManWNvlCyf
	kVRPYyNk64lDfnfjaBGibnIJuCXri+ns=
X-Gm-Gg: Acq92OFRClJnTL4CX4JREW0cKdpJrWc9wFpzizkCkzTZ/VJxbVoVl4bJROgRwx3Fhzl
	ihosbV6Ub3oE/WUpNoIVKfkjXGttWfeRjJYvzPNf2uaSNnaNNf/GF7gZFh9UAOU1qAk5pEgQdlp
	iBPhi+2kffw5e0jOLdD6p9SyYfsTi+/AdrWS9l8+3jb04BQgk3/Z6R0Jm3l+rt+TelWFP9R8mUS
	FWznPa00nfmvv5hq2Zgi7HGWqxyAU7/iITupCRbJfrm/CWKW0o38i9DIUryfFHFJx3cWuxfBTF7
	9snS2swnnHNDNzR73JXxj/hmjQYxcXkxdrWhJYjzWyeUkq8=
X-Received: by 2002:a05:622a:54f:b0:50e:6311:7380 with SMTP id
 d75a77b69052e-5178a00cdc1mr3981031cf.6.1780530429438; Wed, 03 Jun 2026
 16:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN6xzWcVDRLVTV-SQcs6osZjnfhLM728NP7+W8+sFcTDmeVipw@mail.gmail.com>
 <CAGp9LzrmUGQLK5giHVgOjJ5pzGNnfLaV02iWdodT7aDNBbNUqg@mail.gmail.com>
In-Reply-To: <CAGp9LzrmUGQLK5giHVgOjJ5pzGNnfLaV02iWdodT7aDNBbNUqg@mail.gmail.com>
From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
Date: Wed, 3 Jun 2026 16:46:58 -0700
X-Gm-Features: AVHnY4J9XV6wrdzDm41yteKNeBZCLKN_1ZB_hg37PDE9Gq8_o-lWRPTjxswvSgU
Message-ID: <CACjnFahYMyRc1yfb-yA-iiMk_SUOXPx0GrOBbDUEyMtbSqv9iA@mail.gmail.com>
Subject: Re: [bug report] wifi: mt76: mt7921: mt7925monitor-mode per-channel
 retune emits narrowband RF burst
To: Sean Wang <sean.wang@kernel.org>
Cc: John Henry <jshenry1963@gmail.com>, Javier Tia <floss@jetm.me>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>, 
	Nick Morrow <morrownr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37368-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@kernel.org,m:jshenry1963@gmail.com,m:floss@jetm.me,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-mediatek@lists.infradead.org,m:deren.wu@mediatek.com,m:morrownr@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bradpizzimenti@gmail.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,jetm.me,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bradpizzimenti@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,mediatek.com:email,nbd.name:email,infradead.org:url,jetm.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AE8763BEB0

Hi there,
Are all of these fixes going into kernel 7.1+ or introduced earlier?

On Wed, May 27, 2026 at 4:08=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wr=
ote:
>
> Hi John,
>
> On Wed, May 27, 2026 at 7:24=E2=80=AFAM John Henry <jshenry1963@gmail.com=
> wrote:
> >
> > Just a kind reminder of this issue.
> >
> > Please advise if this is already taken up in a separate issue I am
> > unaware of, but it is not directly related to the "iw set txpower
> > fixed accepted but ignored" issue.
> >
> > On products available in the market, e.g.  the Alfa AWUS036AXML
> > consumer product and the Netgear Nighthawk A9000, in Monitor Mode
> > there is RF generated when scanning through channels and we get to 5
> > or more channels in succession.
> > This does not seem to occur at all in managed mode.
> >
> > This means if we scan the 2.4GHz channel list, an RF Spectrum analyzer
> > will show a narrow pulse generated on each channel as we progress
> > through the channels.
> > This can 100% be reproduced using standard iw set channel commands as
> > shown below:
> > FACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
> > iw reg set US ; sleep 1
> > ip link set "$IFACE" down
> > iw dev "$IFACE" set type monitor
> > ip link set "$IFACE" up
> >
> > # This triggers narrowband bursts at channel center on each retune:
> > while true; do
> >   for f in 2412 2417 2422 2427 2432; do
> >     iw dev "$IFACE" set freq "$f" HT20
> >   done
> > done
> >
>
> I have thought about this issue for a while. A possible workaround
> would be to reset WFSYS / firmware after five consecutive `set
> channel` operations in monitor mode, then restore the current monitor
> channel context. The WFSYS reset may take hundreds of milliseconds to
> complete, which is the cost we would need to pay.
>
> > No special software required to reproduce.
> > I have shown that this occurs on all MT7921 based products, along with
> > MT7925 based products.
> > It does not occur if the channel list is set to the same 4 over and
> > over, no RF generated.
> >
> > There are no calibration channel commands going from the driver to the
> > firmware, so I believe this is a firmware bug.
> >
> > Best Regards,
> > John Henry
> >
> > On Sun, May 17, 2026 at 9:01=E2=80=AFAM John Henry <jshenry1963@gmail.c=
om> wrote:
> > >
> > > Just a kind reminder of this issue, has anyone been able to reproduce
> > > this monitor mode issue?
> > > When scanning through channels, and the list of channels is > 4, ther=
e
> > > is a large transmit tick/burst coming from the MT7921u and the MT7925=
.
> > > This can easily be seen on an RF Spectrum Analyzer.
> > > Confirmed on an Alfa AWUS036AXML consumer product and the Netgear
> > > Nighthawk A9000.
> > > This can be reproduced with simple scripts.
> > >
> > > Reproduction with stock iw commands (no custom code):
> > >
> > > IFACE=3D$(iw dev | awk '/Interface wl/ {print $2; exit}')
> > > iw reg set US ; sleep 1
> > > ip link set "$IFACE" down
> > > iw dev "$IFACE" set type monitor
> > > ip link set "$IFACE" up
> > >
> > > # This triggers narrowband bursts at channel center on each retune:
> > > while true; do
> > >   for f in 2412 2417 2422 2427 2432; do
> > >     iw dev "$IFACE" set freq "$f" HT20
> > >   done
> > > done
> > >
> > > # This does NOT (only 4 frequencies):
> > > while true; do
> > >   for f in 2412 2422 2462 2484; do
> > >     iw dev "$IFACE" set freq "$f" HT20
> > >   done
> > > done
> > >
> > > Bursts are ~800 kHz wide at the base, -30 to -50 dBm OTA at close
> > > range, brief (estimated few hundred microseconds), at channel
> > > frequency. tx_stats counters remain zero throughout.
> > > On Mon, May 11, 2026 at 1:58=E2=80=AFPM John Henry <jshenry1963@gmail=
.com> wrote:
> > > >
> > > > Bradley/Sean,
> > > >
> > > > Thank you all very much for the information.
> > > > I tested this on mt7921u based Alfa AWUS unit and also an mt7925 ba=
sed
> > > > Netgear Nighthawk unit.
> > > > I can confirm that the RF tick issue is present on both models when=
 in
> > > > Monitor Mode. I'm assuming it is in the base mt76?
> > > >
> > > > I attempted sudo iw dev wlxxx set txpower fixed nn where nn is the
> > > > minimum value, next few values up, and then a few near the max valu=
es,
> > > > and see no change in the signal strength of the RF Ticks when scann=
ing
> > > > through 5 or more channels.
> > > >
> > > > Please keep this in mind when attempting to resolve the known txpow=
er
> > > > 3dBm issue if possible, or please generate a new bug report for tha=
t
> > > > specifically so that I can track when it is patched, or in ??? vers=
ion
> > > > so that I can test here locally.
> > > >
> > > > Incidentally, I'd appreciate it if anyone could please attempt to
> > > > repeat using the scripts I had shown in the previous posts and conf=
irm
> > > > it is indeed seen by others.
> > > >
> > > > Thank you very much for your time and assistance
> > > >
> > > > John Henry
> > > >
> > > >
> > > >
> > > >
> > > > From: Bradley Pizzimenti <brad.pizzimenti@gmail.com>
> > > > To: linux-wireless@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
> > > > ryder.lee@mediatek.com, shayne.chen@mediatek.com,
> > > > sean.wang@mediatek.com
> > > > Subject: [bug report] wifi: mt76: mt7925: iw set txpower fixed
> > > > accepted but ignored
> > > > Date: Mon, 4 May 2026 15:04:35 -0700 [thread overview]
> > > > Message-ID: <CACjnFagN9zeSkwEv3-CSPJDUENPcEcOLjKyQoLQ91Yjn=3Drq5ww@=
mail.gmail.com>
> > > > (raw)
> > > >
> > > > Hi there maintainers,
> > > >
> > > > `iw dev <iface> set txpower fixed N` returns success on mt7925 for =
any
> > > > N tested, but the reported txpower never changes from a stuck value=
 of
> > > > 3.00 dBm. The kernel accepts and ignores the call silently in both
> > > > directions (above and below the displayed value), and well below th=
e
> > > > regulatory ceiling.
> > > >
> > > > I'm aware there's prior art on the cosmetic 3.00 dBm display issue
> > > > (Razvan Grigore's v2 series, Feb 2025; Ming Yen Hsieh's txpower ini=
t
> > > > refactor, Sept 2025). What seems potentially distinct here is that =
the
> > > > user-issued `iw set txpower fixed N` itself is silently no-op'd,
> > > > separate from the reported-value question. Reporting as breadcrumbs
> > > > in case the second observation is a separate bug rather than the sa=
me
> > > > one.
> > > >
> > > > Hardware
> > > > --------
> > > > MEDIATEK MT7925 [Filogic 360], 802.11be 2x2, PCI 14c3:7925
> > > > ASIC revision 0x79250000
> > > > Driver in use: mt7925e (in-tree)
> > > >
> > > > Firmware (from dmesg at probe)
> > > > ------------------------------
> > > > mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10,
> > > >                      Build Time: 20260106153007a
> > > > mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
> > > >                      Build Time: 20260106153120
> > > > Files: mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
> > > >        mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
> > > >
> > > > Kernel
> > > > ------
> > > > 6.18.18-1-MANJARO (close to vanilla 6.18 stable; not yet tested on
> > > > wireless-next or nbd168/wireless HEAD -- happy to retest if needed,
> > > > but flagging the data point in case it helps as-is).
> > > >
> > > > Tools: iw version 6.17
> > > >
> > > > Regulatory
> > > > ----------
> > > > $ iw reg get
> > > > country US: DFS-FCC
> > > >    ...
> > > >    (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
> > > >    ...
> > > >
> > > > Connection context: 5GHz channel 161 (5805 MHz), 80 MHz, VHT-MCS,
> > > > NSS 1. So we are on a band with a 30 dBm regulatory cap.
> > > >
> > > > Observed
> > > > --------
> > > > $ iw dev wlp1s0 info | grep txpower
> > > >         txpower 3.00 dBm
> > > >
> > > > $ sudo iw dev wlp1s0 set txpower fixed 100   # 1 dBm
> > > > $ iw dev wlp1s0 info | grep txpower
> > > >         txpower 3.00 dBm
> > > >
> > > > $ sudo iw dev wlp1s0 set txpower fixed 1500  # 15 dBm
> > > > $ iw dev wlp1s0 info | grep txpower
> > > >         txpower 3.00 dBm
> > > >
> > > > $ sudo iw dev wlp1s0 set txpower auto
> > > > $ iw dev wlp1s0 info | grep txpower
> > > >         txpower 3.00 dBm
> > > >
> > > > All four `set` invocations return exit code 0. The reported value
> > > > never moves.
> > > >
> > > > Expected
> > > > --------
> > > > Either:
> > > >   - The reported txpower follows the requested value (or, where
> > > >     capped, the actual applied value with extack indicating the
> > > >     cap reason), or
> > > >   - The set call returns an error rather than silently ignoring the
> > > >     request.
> > > >
> > > > Caveats
> > > > -------
> > > > - Not yet tested on wireless-next or nbd168/wireless HEAD. If a
> > > >   reproduction on a current dev tree would be useful, I can do that=
.
> > > > - I have not verified whether the actual radiated TX power changes
> > > >   in response to `set txpower fixed`; I am reporting only the
> > > >   user-visible behavior.
> > > >
> > > > Thanks,
> > > > Bradley
> > > >
> > > > On Wed, May 6, 2026 at 8:12=E2=80=AFPM Sean Wang <sean.wang@kernel.=
org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > The TX power reporting issue has already been investigated by Luc=
id
> > > > > from the Linux WiFi USB community, and there is a proposed soluti=
on.
> > > > > I think we can continue checking whether there are any remaining
> > > > > issues on top of that work. Please refer to the patches here:
> > > > > https://lists.infradead.org/pipermail/linux-mediatek/2026-April/1=
05726.html
> > > > > Thanks everyone for reporting and raising these concerns.
> > > > >
> > > > > On Wed, May 6, 2026 at 3:09=E2=80=AFPM Javier Tia <floss@jetm.me>=
 wrote:
> > > > > >
> > > > > > On Sun May  4 22:04:48 2026 Bradley Pizzimenti wrote:
> > > > > > > `iw dev <iface> set txpower fixed N` returns success on mt792=
5 for
> > > > > > > any N tested, but the reported txpower never changes from a s=
tuck
> > > > > > > value of 3.00 dBm.
> > > > > >
> > > > > > Hi Bradley,
> > > > > >
> > > > > > The 3 dBm display bug is a known issue we have seen when using =
mt7927
> > > > > > and a tested fix has been working well so far. The root cause i=
s that
> > > > > > mt7925_mcu_set_rate_txpower() programs the per-band SKU tables =
into
> > > > > > firmware but never assigns phy->txpower_cur. mt76_get_txpower()=
 then
> > > > > > computes:
> > > > > >
> > > > > >   DIV_ROUND_UP(0 + 6, 2) =3D 3
> > > > > >
> > > > > > regardless of the actual power level. The RF output is unaffect=
ed;
> > > > > > it is a display-only bug.
> > > > > >
> > > > > > The fix reads the effective TX power back from the rate power l=
imits
> > > > > > after programming the SKU tables and writes it to phy->txpower_=
cur,
> > > > > > following the same pattern used by mt7996:
> > > > > >
> > > > > >   https://github.com/jetm/mediatek-mt7927-dkms/blob/master/mt79=
27-wifi-14-fix-reported-txpower-always-showing-3-db.patch
> > > > > >
> > > > > > This is part of a series we are targeting for wireless-next; no=
t
> > > > > > yet upstream.
> > > > > >
> > > > > > > What seems potentially distinct here is that the user-issued
> > > > > > > `iw set txpower fixed N` itself is silently no-op'd, separate
> > > > > > > from the reported-value question.
> > > > > >
> > > > > > Agreed those are two separate issues. Our patch addresses the
> > > > > > display-only side: after applying it, iw will report the value =
the
> > > > > > firmware is actually using based on the SKU tables, rather than
> > > > > > always 3 dBm. Whether `set txpower fixed N` propagates to firmw=
are
> > > > > > to change actual output power is orthogonal and not addressed h=
ere.
> > > > > >
> > > > > > If you can test the patch on your MT7925 and confirm the displa=
yed
> > > > > > value reflects the correct power after association, a Tested-by
> > > > > > would be appreciated.
> > > > > >
> > > > > > Best,
> > > > > > Javier
> > > > > >
> > > > >

