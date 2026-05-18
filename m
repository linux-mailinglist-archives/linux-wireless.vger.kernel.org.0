Return-Path: <linux-wireless+bounces-36603-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCJEFn8JC2o0/gQAu9opvQ
	(envelope-from <linux-wireless+bounces-36603-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 14:43:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D156CE98
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 14:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73797302483F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517640626F;
	Mon, 18 May 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5pZHm2O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155B330D50
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107467; cv=none; b=Fs4nWVoUSzFW2GbdOCm+j2B6fd1G8BoxFJcQWkfSMHkkCTbdAe7REdN+RrvI5RYdFZidNLabOxJBGcqoWloK70o96r43g+wbd+fqOQXQqEiE6rznXwK2YBoOqkzFC052DAjirLDzp/7OR27PChI+29UVvEMcpZOZhlc2sHCMEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107467; c=relaxed/simple;
	bh=m07W1s/IuDdUfINCVtXHnkSwedXnpSOYDhP4PdcOAos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ4sam0vpz2nxcvX2WnRoBMgsFI6qYyw4t12XzPVYc+7o65j54jM53fN9ycWeT7BklTDVG7kzphuowqfzTZBh1sDsLz3Yv/y5Lw1I8Dd6xoFLCQKxSi7oQ+IHuNymRFQHdEkN7AgwnLfVKPZCM1L24uQF4+da+byDryU3xdIxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5pZHm2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5ED4C2BCF6;
	Mon, 18 May 2026 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779107467;
	bh=m07W1s/IuDdUfINCVtXHnkSwedXnpSOYDhP4PdcOAos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5pZHm2OzFgAD7P7m8X7gcnm4OOnlV4uVr1O+9Jx0La9i+8oQuQZKa20Ps9nwGbla
	 n6ZZm+pC6/jH65V5ndiQ/1+9r6THlkd2E6+FSfV2Qa5f04BfU9i+LiYFHqChUIl9NK
	 MA8zTsQ19LMQYA3HzYhO1IzEB80XhvNA21akpGV+19FpVHhaxRcHPitzIi/2Dqddkr
	 g7+TKsgxEgtk/0vc9v6NDy+1lXfYBEDMcg1CB+IsggG4MN/4ntobXbRKJlVyQjIUXX
	 eBlRge4SK7HdDb2nhfhErDUgIpJ+3VnvCTGnqMhCcg0ziPGLIlFz36DgHX/lztKbX7
	 wXpHqo0h1mDIQ==
Date: Mon, 18 May 2026 14:31:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Cheng Hao Luo <roychl666@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	Shayne Chen <shayne.chen@mediatek.com>,
	Roy Luo <roy-ch.luo@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid memset overwriting
 tx_info->control.flags
Message-ID: <agsGiHKH6ly1afaf@lore-desk>
References: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
 <agdJ1EtZjjWh2R1h@lore-desk>
 <CAHoxojJX2BRRTLMuM_QcJqMMmshxS4EAwrB1VjU3rsZ+0k2PAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9gATnpVnUl0KDMgx"
Content-Disposition: inline
In-Reply-To: <CAHoxojJX2BRRTLMuM_QcJqMMmshxS4EAwrB1VjU3rsZ+0k2PAg@mail.gmail.com>
X-Rspamd-Queue-Id: 645D156CE98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-36603-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--9gATnpVnUl0KDMgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 15, Cheng Hao Luo wrote:
> > struct ieee80211_tx_info {
> >         u32                        flags;                /*     0     4=
 */
> >         u32                        band:3;               /*     4: 0  4=
 */
> >         u32                        status_data_idr:1;    /*     4: 3  4=
 */
> >         u32                        status_data:13;       /*     4: 4  4=
 */
> >         u32                        hw_queue:4;           /*     4:17  4=
 */
> >         u32                        tx_time_est:10;       /*     4:21  4=
 */
> >
> >         /* XXX 1 bit hole, try to pack */
> >
> >         union {
> >                 struct {
> >                         union {
> >                                 struct {
> >                                         struct ieee80211_tx_rate rates[=
4]; /*     8    12 */
> >                                         s8     rts_cts_rate_idx; /*    =
20     1 */
> >                                         u8     use_rts:1; /*    21: 0  =
1 */
> >                                         u8     use_cts_prot:1; /*    21=
: 1  1 */
> >                                         u8     short_preamble:1; /*    =
21: 2  1 */
> >                                         u8     skip_table:1; /*    21: =
3  1 */
> >                                         u8     antennas:2; /*    21: 4 =
 1 */
> >                                 };                       /*     8    14=
 */
> >                                 long unsigned int jiffies; /*     8    =
 8 */
> >                         };                               /*     8    16=
 */
> >                         struct ieee80211_vif * vif;      /*    24     8=
 */
> >                         struct ieee80211_key_conf * hw_key; /*    32   =
  8 */
> >                         u32        flags;                /*    40     4=
 */
> >                         codel_time_t enqueue_time;       /*    44     4=
 */
> >                 } control;                               /*     8    40=
 */
> >                 struct {
> >                         u64        cookie;               /*     8     8=
 */
> >                 } ack;                                   /*     8     8=
 */
> >                 struct {
> >                         struct ieee80211_tx_rate rates[4]; /*     8    =
12 */
> >                         s32        ack_signal;           /*    20     4=
 */
> >                         u8         ampdu_ack_len;        /*    24     1=
 */
> >                         u8         ampdu_len;            /*    25     1=
 */
> >                         u8         antenna;              /*    26     1=
 */
> >                         u8         pad;                  /*    27     1=
 */
> >                         u16        tx_time;              /*    28     2=
 */
> >                         u8         flags;                /*    30     1=
 */
> >                         u8         pad2;                 /*    31     1=
 */
> >                         void *     status_driver_data[2]; /*    32    1=
6 */
> >                 } status;                                /*     8    40=
 */
> >                 struct {
> >                         struct ieee80211_tx_rate driver_rates[4]; /*   =
  8    12 */
> >                         u8         pad[4];               /*    20     4=
 */
> >                         void *     rate_driver_data[3];  /*    24    24=
 */
> >                 };                                       /*     8    40=
 */
> >                 void *             driver_data[5];       /*     8    40=
 */
> >         };                                               /*     8    40=
 */
> >
> >         /* size: 48, cachelines: 1, members: 7 */
> >         /* sum members: 44 */
> >         /* sum bitfield members: 31 bits, bit holes: 1, sum bit holes: =
1 bits */
> >         /* last cacheline: 48 bytes */
> > };
> >
> > According to pahole, the size of the control inner union is actually 16=
 bytes
> > since the compiler adds 2 bytes of padding. Since mt76_tx_status_skb_ad=
d()
> > meset to 0 just mt76_tx_cb size (that is 16 bytes) I can't see how
> > control.flags is overwritten. Am I missing something?
> >
> > struct mt76_tx_cb {
> >         long unsigned int          jiffies;              /*     0     8=
 */
> >         u16                        wcid;                 /*     8     2=
 */
> >         u8                         pktid;                /*    10     1=
 */
> >         u8                         flags;                /*    11     1=
 */
> >
> >         /* size: 16, cachelines: 1, members: 4 */
> >         /* padding: 4 */
> >         /* last cacheline: 16 bytes */
> > };
>=20
> Hi Lorenzo,
>=20
> The mt76_tx_cb is placed at status.status_driver_data (offset 32).
> It overlaps with hw_key, flags and enqueue_time in the control union.
>=20
> static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff *skb)
> {
> BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
>     sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
> return ((void *)IEEE80211_SKB_CB(skb)->status.status_driver_data);
> }

Hi Roy,

I still do not understand since mt76_tx_status_skb_add() sets to 0 just siz=
eof
of mt76_tx_cb, that according to pahole is 16 bytes, so it can't overwrite
hw_key pointer (whose offset respect to the beginning of the control struct=
 is
24, 32 - 8).

Regards,
Lorenzo

>=20
> Regards,
> Roy Luo

--9gATnpVnUl0KDMgx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagsGiAAKCRA6cBh0uS2t
rP8qAQDen40n2jOyttCRZP/6p99yO/f15imfyLqutyAyZHcI5gEAmo3YTyaI8B2A
Y1ZUjTx974vEx3I2UtSnHHo/h5zwIAE=
=yxB8
-----END PGP SIGNATURE-----

--9gATnpVnUl0KDMgx--

