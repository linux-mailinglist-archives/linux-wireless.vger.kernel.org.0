Return-Path: <linux-wireless+bounces-36657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DcrNr9WDGodfwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:25:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9665157EA19
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B235B303CD49
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D23D330D29;
	Tue, 19 May 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqC8VjHx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A24492502
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193507; cv=pass; b=nAgQZ825stTZWP4gUNSY4bXj7NC6/hs4k88pnhQIZIgiAE8rbj5rto3DDjwIZpcFy9VTdkkV4KQfTSLvdu/tAapee5EnmfUaL69Z/sMlcQKWwV/gjkFW691G2tVMHMPQAhT4vWaiDGHv/TjeDJANAI3KDzzqMwTnDG+VSd4yuEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193507; c=relaxed/simple;
	bh=lvqG6eoL3qJKLcCcaviGjWGA+2RgA2+ST8TjExcuoxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7Mx08U4whJp2Ie0LqaS4UazcsBw/0llOAODIVSJMydOPNmYsSym29icSGqH/jRPWHMPwDu8MAXPlBJmMWFxKjfhQGOwnIGh1nR4ztCnC/S55EK2fpL47jiTqytV/Ge36k+34ea2MCfZh4ShXHhv1VhI4/yvobgbWkZ88NKizX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqC8VjHx; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so6399151e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 05:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779193504; cv=none;
        d=google.com; s=arc-20240605;
        b=Szqpr2Gnkpe0lgHAB0xw3a/SCOv6kxC+yZRy9PQfVLDesS2HxZGwVJu/h6WmYnVTgZ
         uF0ec63xs8cokLdbMubtM0HQlU9tsoBC7+yreaTP2HsHSW1pKCVLIXvtZQiW5/tkL1+O
         3nhWwlfb4AVlvBcR2sdkikM33dG98ABTHxf/v4dUhYsTKnaCwyxI9QIxJYKsUORAPijB
         7rM07KwEOscZoUOGngt/l5J7W/RwcVaITxmwKV6bjAX5TVwAtGl5W6go7Zr8InpPyiVj
         2SSKlZ0PqSZADwqvZPGHfnKuu4QU4/BTTMOlegp8zzS6mZvzYReoo6+zf1V4sJZHvEz8
         Vsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8y5pq/3tUQo0gg+N0tZskaVB8fdmoWJdJrd4o2r5SVo=;
        fh=oJL2bHvlFUPFwbYVXuzFhui2IdVHTzg6CHFDIM4sVrk=;
        b=Y+hoIM7230VIMp9VVkMu8WctkOcJNYep1Afw80ARwfl07Hz9PfZcggKTKEZ8VYVQ1u
         q4IOmmArcYreGsIrtHfrVy9U6mUU4bvG9uoXnO73hRjXxx/Jh9x9Him+jTmH8krIWQfB
         hMiS7stIPe/6G5JqMiGWk5EbYQDKrT4vZV/ISzAyH29clDnOQxF9HDbgo3lVh+4Q9vFR
         R73CZslSyS3bOCT7KtuH9YHI6SwfkSAXsMpeYiXT+U2ClLsgwIHvxMDw4xuixdTl8EZM
         4zK01fhUrdQqMh1DpbcCDCNCEPROuQsXbw8/OXJotcAxOtf0myQJ9IFLHk8vcJnyEPVH
         FXQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779193504; x=1779798304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y5pq/3tUQo0gg+N0tZskaVB8fdmoWJdJrd4o2r5SVo=;
        b=eqC8VjHxFf65d77S05khnCwoLAgtYg7zKwF1po1MGBxFR06ag8+GqbzH0/OiLTKtOf
         /5BFDVYmjPmWBKOXmpALuUKTPdnpSonbC6kkQMhk/yMiDABHzNKhm3/0Zf064X7svwvm
         y1bcK8LKp1H8PL6Z1q1V1B+b6c/4M1wrINBWM3t6llX1z5T6SwSU8dRu/AWJF/fXTIm/
         UEmVRPK4jsv6mi+HZTTY2GXXeieaCCr3K7xPSf22UVPas7ARKYb9v4lbkX13YSxYdANn
         XK/dZ8D30+HuneoKTPfS14d0mt26BrC4oenXDophy6Q4Ux49q/nXyN/0FJDXXO35bSBq
         tGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779193504; x=1779798304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8y5pq/3tUQo0gg+N0tZskaVB8fdmoWJdJrd4o2r5SVo=;
        b=RKJCwk0UqZDchOfGIj+fksupYrx36UKXw2atAVmFhKuxS4kiRvCiw6fONsQ2N+Uv8r
         aUDZqDnNPgWOONClYUaPeKDKmrncDe8H8sBmdAneQmPed95QX4DGvkZ2lBcHjD3qBdh2
         pLjKc2WwlnHTgHZznt4i4uRevKJb8rlVAZ7uUjDnG1al4MyDn5tmiPPHruSiUNX2B99F
         9IL9cBq3hsN/Oe3h+LPFrWImC30CXZKyTqsGysg7cfKVCoRLLx0gC9l9+q54iZ8Poh2p
         gzP2HeQVD+mfTufK4VXw1RilE+GjNfHOFsEIdgYn22c/ssV8ooO5w9UFua3LwSAs8h1n
         7ozw==
X-Forwarded-Encrypted: i=1; AFNElJ9gQvq8rrflEE3A6YpL2Gp+XqqkuXnrf0Wxf/L1VEQjxhROV8taW4oZayKeQsSo4Iaq6SAK86rJEZ41q6Omdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiHn++o3on47tEGDF9yzL4UbY0OJpCi2oouXqEf3h6r4x50Bk
	7MGN1vj5eSNlFKv7eLarZEvk/x9l+3Cv8OMO2lOy4Agp0Fqpnv+6aFgw/P1PsTX1v1k7VrrouFv
	zYpDciu3IROHHFTvOCv2Y79I6WgqZUAU=
X-Gm-Gg: Acq92OGSA73hBUNABHhQhkbihez6hfNc/WTxigCYgvjRp6uotRQsZYReqQxK0DRHU14
	rG3Gj15F+cnpTfcngTd/qfyHYIflohMWw+BRWR4877aULzpim2/zRbQQHNZRkcIJ1oVW56cw6By
	20K8vrHpE+baFDQJ5JUyM/FjH4YeOl3nwsdXI7ibZZvL79hZjtc3Nn2fzlN0NKFkAIFh6QCMB8o
	QYeQQD5N56OHlGj5issqOV8mt0847jtrUFYFzpbk0Pr3IHebpjvYNLd+mfV2qrTbIDZNSucI1II
	8z0ocf4=
X-Received: by 2002:a05:6512:a85:b0:5a8:6cab:4866 with SMTP id
 2adb3069b0e04-5aa0e74a9b4mr5964361e87.41.1779193503535; Tue, 19 May 2026
 05:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
 <agdJ1EtZjjWh2R1h@lore-desk> <CAHoxojJX2BRRTLMuM_QcJqMMmshxS4EAwrB1VjU3rsZ+0k2PAg@mail.gmail.com>
 <agsGiHKH6ly1afaf@lore-desk> <CAHoxojKeXCCnJoO7yBBmTM9euiTf38orujOhOK00X8bb3ctWuA@mail.gmail.com>
In-Reply-To: <CAHoxojKeXCCnJoO7yBBmTM9euiTf38orujOhOK00X8bb3ctWuA@mail.gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Tue, 19 May 2026 14:24:52 +0200
X-Gm-Features: AVHnY4KaoxlMsOnP7ZY50hh_a8dZdUJo8i7PBx8_p8ryKTV2m-BiT8h1mMrMaXk
Message-ID: <CAA2SeNJXv+8QO6zEOF=qB3wVCdEoSqx6fftp1i=aB-DKMFeC=A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid memset overwriting tx_info->control.flags
To: Roy Luo <roychl666@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Felix Fietkau <nbd@nbd.name>, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, Shayne Chen <shayne.chen@mediatek.com>, 
	Roy Luo <roy-ch.luo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36657-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzobianconi83@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9665157EA19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>
> On Mon, May 18, 2026 at 5:31=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> >
> > On May 15, Cheng Hao Luo wrote:
> > > > struct ieee80211_tx_info {
> > > >         u32                        flags;                /*     0  =
   4 */
> > > >         u32                        band:3;               /*     4: =
0  4 */
> > > >         u32                        status_data_idr:1;    /*     4: =
3  4 */
> > > >         u32                        status_data:13;       /*     4: =
4  4 */
> > > >         u32                        hw_queue:4;           /*     4:1=
7  4 */
> > > >         u32                        tx_time_est:10;       /*     4:2=
1  4 */
> > > >
> > > >         /* XXX 1 bit hole, try to pack */
> > > >
> > > >         union {
> > > >                 struct {
> > > >                         union {
> > > >                                 struct {
> > > >                                         struct ieee80211_tx_rate ra=
tes[4]; /*     8    12 */
> > > >                                         s8     rts_cts_rate_idx; /*=
    20     1 */
> > > >                                         u8     use_rts:1; /*    21:=
 0  1 */
> > > >                                         u8     use_cts_prot:1; /*  =
  21: 1  1 */
> > > >                                         u8     short_preamble:1; /*=
    21: 2  1 */
> > > >                                         u8     skip_table:1; /*    =
21: 3  1 */
> > > >                                         u8     antennas:2; /*    21=
: 4  1 */
> > > >                                 };                       /*     8  =
  14 */
> > > >                                 long unsigned int jiffies; /*     8=
     8 */
> > > >                         };                               /*     8  =
  16 */
> > > >                         struct ieee80211_vif * vif;      /*    24  =
   8 */
> > > >                         struct ieee80211_key_conf * hw_key; /*    3=
2     8 */
> > > >                         u32        flags;                /*    40  =
   4 */
> > > >                         codel_time_t enqueue_time;       /*    44  =
   4 */
> > > >                 } control;                               /*     8  =
  40 */
> > > >                 struct {
> > > >                         u64        cookie;               /*     8  =
   8 */
> > > >                 } ack;                                   /*     8  =
   8 */
> > > >                 struct {
> > > >                         struct ieee80211_tx_rate rates[4]; /*     8=
    12 */
> > > >                         s32        ack_signal;           /*    20  =
   4 */
> > > >                         u8         ampdu_ack_len;        /*    24  =
   1 */
> > > >                         u8         ampdu_len;            /*    25  =
   1 */
> > > >                         u8         antenna;              /*    26  =
   1 */
> > > >                         u8         pad;                  /*    27  =
   1 */
> > > >                         u16        tx_time;              /*    28  =
   2 */
> > > >                         u8         flags;                /*    30  =
   1 */
> > > >                         u8         pad2;                 /*    31  =
   1 */
> > > >                         void *     status_driver_data[2]; /*    32 =
   16 */
> > > >                 } status;                                /*     8  =
  40 */
> > > >                 struct {
> > > >                         struct ieee80211_tx_rate driver_rates[4]; /=
*     8    12 */
> > > >                         u8         pad[4];               /*    20  =
   4 */
> > > >                         void *     rate_driver_data[3];  /*    24  =
  24 */
> > > >                 };                                       /*     8  =
  40 */
> > > >                 void *             driver_data[5];       /*     8  =
  40 */
> > > >         };                                               /*     8  =
  40 */
> > > >
> > > >         /* size: 48, cachelines: 1, members: 7 */
> > > >         /* sum members: 44 */
> > > >         /* sum bitfield members: 31 bits, bit holes: 1, sum bit hol=
es: 1 bits */
> > > >         /* last cacheline: 48 bytes */
> > > > };
> > > >
> > > > According to pahole, the size of the control inner union is actuall=
y 16 bytes
> > > > since the compiler adds 2 bytes of padding. Since mt76_tx_status_sk=
b_add()
> > > > meset to 0 just mt76_tx_cb size (that is 16 bytes) I can't see how
> > > > control.flags is overwritten. Am I missing something?
> > > >
> > > > struct mt76_tx_cb {
> > > >         long unsigned int          jiffies;              /*     0  =
   8 */
> > > >         u16                        wcid;                 /*     8  =
   2 */
> > > >         u8                         pktid;                /*    10  =
   1 */
> > > >         u8                         flags;                /*    11  =
   1 */
> > > >
> > > >         /* size: 16, cachelines: 1, members: 4 */
> > > >         /* padding: 4 */
> > > >         /* last cacheline: 16 bytes */
> > > > };
> > >
> > > Hi Lorenzo,
> > >
> > > The mt76_tx_cb is placed at status.status_driver_data (offset 32).
> > > It overlaps with hw_key, flags and enqueue_time in the control union.
> > >
> > > static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff *skb)
> > > {
> > > BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
> > >     sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
> > > return ((void *)IEEE80211_SKB_CB(skb)->status.status_driver_data);
> > > }
> >
> > Hi Roy,
> >
> > I still do not understand since mt76_tx_status_skb_add() sets to 0 just=
 sizeof
> > of mt76_tx_cb, that according to pahole is 16 bytes, so it can't overwr=
ite
> > hw_key pointer (whose offset respect to the beginning of the control st=
ruct is
> > 24, 32 - 8).
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > Regards,
> > > Roy Luo
>
> Hi Lorenzo,
>
> The mt76_tx_status_skb_add() memset zero the 16 bytes starting from
> status.status_driver_data (please see the above inline function shared
> in my last response) whose offset with respect to the beginning of
> the control/status union is exactly 24 (32 - 8) instead of 0.
>
> Regards,
> Roy Luo

Hi Roy,

I can see the issue now, I was confusing status.status_driver_data
with
driver_data. You are right, we have an issue here. However, copying
all the
ieee80211_tx_info struct seems a bit overkill, what do you think?
Moreover, we have the same issue for various chipsets (e.g. mt7925 and
mt7915).  I guess we should try to find a global solution for the
problem.

Regards,
Lorenzo

