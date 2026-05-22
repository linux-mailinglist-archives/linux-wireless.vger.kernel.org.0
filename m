Return-Path: <linux-wireless+bounces-36822-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG7BBmq+EGomdAYAu9opvQ
	(envelope-from <linux-wireless+bounces-36822-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 22:36:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA55BA1ED
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 22:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 274F7300D152
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8082BFC60;
	Fri, 22 May 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvfo+4J9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C972D0606
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482130; cv=none; b=IDdwELuLwHlGKmgAnCv5aTOqndQvG+3IwXYjtaE55nl2GEFR3QlMZdcmkpwNi5KGEcmhgRummdZgVoKYXXzJKvEF2ZzA6OE5ApZzdAD9d1rtqsOMskhf1uYtrph2wG1mhQcj5sc5FOQIIuG9WuRiOjj2/5ZQoQoyzjkDC4v/654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482130; c=relaxed/simple;
	bh=HSWy4+0KV+6X7j5AY6uI1iOsf+IiHOTKwgYzaBHne5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iqotv/KBfx+PVxbKP/HQk0V7Ub8E55wEkWWvxK8Rhqn1yurFVub7rajEGxE0jxMymBjd6m2evOUuj8MvDefn1sZZYN5VL7PRoR255IrgGHTQkbosPEYngeGC2kLhybdcpaLBl2eJOrXaM6gaHhvaPEkj+7q+NYsjpoEZlu1q0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvfo+4J9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08701F0155D
	for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779482128;
	bh=k6EyF5hhQO7eaC9zrEY9M5Jju+ePXXxpPReIjxWeQJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Bvfo+4J9k3zP83bx1tFCEXatTDWdPvgQkRpDVKEMjzmOW0xqlJ7GbNLtK0Q9b852d
	 6a1FiUxIZMZWMhQbGM2bqPRoBkwM4s/EO5BG69cuCeq7/stPWUZfjrO3VDTHR0XXHI
	 G2+icnxT0UA+aBVBjNDVXy0ySNvzRtgVF6+4l1AW8tVogg0Iw1AVLrylAKONQeKib1
	 7RxReWO34Zh9ID7EcnWPZJWtZ43RXt6VmeCjiLnPQu1ipmgg80fCufwPDR7KH5zswV
	 grHgjLEQQO25P4XF0Ka+asrVXjZDGW30XxNFnjOtuZ7GvihRicZPFInEYEiuGnixqC
	 ZXzZ1Fiox9SXg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393c93a01abso19409291fa.1
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2026 13:35:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Dq6o0mceFAuqWcc5n+xgQE+sY+GISswsjA5Yz5eqVwZsDbCfxfVQYEtBxKoBjdm4YDfPnwwy1k26Di8H5rw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdNjrgFwcoJ5HgJrxcHVd7sKONDhKCmfagrcRVAc24d7f/WNU
	ecINnC9aBEvoKzJAeX3nOWgYTYi2w1XQBc/2Gl5SMOaw0vJkNa1ufTS2ffFdhZsXD0GfqVwVclj
	9XP7ur6dsmCppaKkooqCjEKVKd4RZqMs=
X-Received: by 2002:a05:651c:882:b0:394:987:946b with SMTP id
 38308e7fff4ca-395d8c12399mr17897371fa.2.1779482127167; Fri, 22 May 2026
 13:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
 <agdJ1EtZjjWh2R1h@lore-desk> <CAHoxojJX2BRRTLMuM_QcJqMMmshxS4EAwrB1VjU3rsZ+0k2PAg@mail.gmail.com>
 <agsGiHKH6ly1afaf@lore-desk> <CAHoxojKeXCCnJoO7yBBmTM9euiTf38orujOhOK00X8bb3ctWuA@mail.gmail.com>
 <CAA2SeNJXv+8QO6zEOF=qB3wVCdEoSqx6fftp1i=aB-DKMFeC=A@mail.gmail.com> <1e1318a9230533c63c31aecbaddf520b6f68affd.camel@mediatek.com>
In-Reply-To: <1e1318a9230533c63c31aecbaddf520b6f68affd.camel@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 22 May 2026 15:35:15 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzq_EhW-YR2EM0Hr64pRTV5eqAj1bx0RLuYCuWMTGhcHSA@mail.gmail.com>
X-Gm-Features: AVHnY4IuzG8abYfmu1woK-eDo_ZET5-_JKn-20dhW4FE-eU_dJaCw-BZnzXQJqI
Message-ID: <CAGp9Lzq_EhW-YR2EM0Hr64pRTV5eqAj1bx0RLuYCuWMTGhcHSA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid memset overwriting tx_info->control.flags
To: Ryder Lee <Ryder.Lee@mediatek.com>
Cc: "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>, 
	"roychl666@gmail.com" <roychl666@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, 
	"lorenzo@kernel.org" <lorenzo@kernel.org>, =?UTF-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Roy-CH Luo <Roy-CH.Luo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-36822-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 75AA55BA1ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, May 19, 2026 at 3:43=E2=80=AFPM Ryder Lee <Ryder.Lee@mediatek.com> =
wrote:
>
> On Tue, 2026-05-19 at 14:24 +0200, Lorenzo Bianconi wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > >
> > > On Mon, May 18, 2026 at 5:31=E2=80=AFAM Lorenzo Bianconi
> > > <lorenzo@kernel.org> wrote:
> > > >
> > > > On May 15, Cheng Hao Luo wrote:
> > > > > > struct ieee80211_tx_info {
> > > > > >         u32                        flags;
> > > > > > /*     0     4 */
> > > > > >         u32                        band:3;
> > > > > > /*     4: 0  4 */
> > > > > >         u32                        status_data_idr:1;
> > > > > > /*     4: 3  4 */
> > > > > >         u32                        status_data:13;
> > > > > > /*     4: 4  4 */
> > > > > >         u32                        hw_queue:4;
> > > > > > /*     4:17  4 */
> > > > > >         u32                        tx_time_est:10;
> > > > > > /*     4:21  4 */
> > > > > >
> > > > > >         /* XXX 1 bit hole, try to pack */
> > > > > >
> > > > > >         union {
> > > > > >                 struct {
> > > > > >                         union {
> > > > > >                                 struct {
> > > > > >                                         struct
> > > > > > ieee80211_tx_rate rates[4]; /*     8    12 */
> > > > > >                                         s8
> > > > > > rts_cts_rate_idx; /*    20     1 */
> > > > > >                                         u8     use_rts:1;
> > > > > > /*    21: 0  1 */
> > > > > >                                         u8
> > > > > > use_cts_prot:1; /*    21: 1  1 */
> > > > > >                                         u8
> > > > > > short_preamble:1; /*    21: 2  1 */
> > > > > >                                         u8     skip_table:1;
> > > > > > /*    21: 3  1 */
> > > > > >                                         u8     antennas:2;
> > > > > > /*    21: 4  1 */
> > > > > >                                 };
> > > > > > /*     8    14 */
> > > > > >                                 long unsigned int jiffies;
> > > > > > /*     8     8 */
> > > > > >                         };
> > > > > > /*     8    16 */
> > > > > >                         struct ieee80211_vif * vif;
> > > > > > /*    24     8 */
> > > > > >                         struct ieee80211_key_conf * hw_key;
> > > > > > /*    32     8 */
> > > > > >                         u32        flags;
> > > > > > /*    40     4 */
> > > > > >                         codel_time_t enqueue_time;
> > > > > > /*    44     4 */
> > > > > >                 } control;
> > > > > > /*     8    40 */
> > > > > >                 struct {
> > > > > >                         u64        cookie;
> > > > > > /*     8     8 */
> > > > > >                 } ack;
> > > > > > /*     8     8 */
> > > > > >                 struct {
> > > > > >                         struct ieee80211_tx_rate rates[4];
> > > > > > /*     8    12 */
> > > > > >                         s32        ack_signal;
> > > > > > /*    20     4 */
> > > > > >                         u8         ampdu_ack_len;
> > > > > > /*    24     1 */
> > > > > >                         u8         ampdu_len;
> > > > > > /*    25     1 */
> > > > > >                         u8         antenna;
> > > > > > /*    26     1 */
> > > > > >                         u8         pad;
> > > > > > /*    27     1 */
> > > > > >                         u16        tx_time;
> > > > > > /*    28     2 */
> > > > > >                         u8         flags;
> > > > > > /*    30     1 */
> > > > > >                         u8         pad2;
> > > > > > /*    31     1 */
> > > > > >                         void *     status_driver_data[2];
> > > > > > /*    32    16 */
> > > > > >                 } status;
> > > > > > /*     8    40 */
> > > > > >                 struct {
> > > > > >                         struct ieee80211_tx_rate
> > > > > > driver_rates[4]; /*     8    12 */
> > > > > >                         u8         pad[4];
> > > > > > /*    20     4 */
> > > > > >                         void *     rate_driver_data[3];
> > > > > > /*    24    24 */
> > > > > >                 };
> > > > > > /*     8    40 */
> > > > > >                 void *             driver_data[5];
> > > > > > /*     8    40 */
> > > > > >         };
> > > > > > /*     8    40 */
> > > > > >
> > > > > >         /* size: 48, cachelines: 1, members: 7 */
> > > > > >         /* sum members: 44 */
> > > > > >         /* sum bitfield members: 31 bits, bit holes: 1, sum
> > > > > > bit holes: 1 bits */
> > > > > >         /* last cacheline: 48 bytes */
> > > > > > };
> > > > > >
> > > > > > According to pahole, the size of the control inner union is
> > > > > > actually 16 bytes
> > > > > > since the compiler adds 2 bytes of padding. Since
> > > > > > mt76_tx_status_skb_add()
> > > > > > meset to 0 just mt76_tx_cb size (that is 16 bytes) I can't
> > > > > > see how
> > > > > > control.flags is overwritten. Am I missing something?
> > > > > >
> > > > > > struct mt76_tx_cb {
> > > > > >         long unsigned int          jiffies;
> > > > > > /*     0     8 */
> > > > > >         u16                        wcid;
> > > > > > /*     8     2 */
> > > > > >         u8                         pktid;
> > > > > > /*    10     1 */
> > > > > >         u8                         flags;
> > > > > > /*    11     1 */
> > > > > >
> > > > > >         /* size: 16, cachelines: 1, members: 4 */
> > > > > >         /* padding: 4 */
> > > > > >         /* last cacheline: 16 bytes */
> > > > > > };
> > > > >
> > > > > Hi Lorenzo,
> > > > >
> > > > > The mt76_tx_cb is placed at status.status_driver_data (offset
> > > > > 32).
> > > > > It overlaps with hw_key, flags and enqueue_time in the control
> > > > > union.
> > > > >
> > > > > static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff
> > > > > *skb)
> > > > > {
> > > > > BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
> > > > >     sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
> > > > > return ((void *)IEEE80211_SKB_CB(skb)-
> > > > > >status.status_driver_data);
> > > > > }
> > > >
> > > > Hi Roy,
> > > >
> > > > I still do not understand since mt76_tx_status_skb_add() sets to
> > > > 0 just sizeof
> > > > of mt76_tx_cb, that according to pahole is 16 bytes, so it can't
> > > > overwrite
> > > > hw_key pointer (whose offset respect to the beginning of the
> > > > control struct is
> > > > 24, 32 - 8).
> > > >
> > > > Regards,
> > > > Lorenzo
> > > >
> > > > >
> > > > > Regards,
> > > > > Roy Luo
> > >
> > > Hi Lorenzo,
> > >
> > > The mt76_tx_status_skb_add() memset zero the 16 bytes starting from
> > > status.status_driver_data (please see the above inline function
> > > shared
> > > in my last response) whose offset with respect to the beginning of
> > > the control/status union is exactly 24 (32 - 8) instead of 0.
> > >
> > > Regards,
> > > Roy Luo
> >
> > Hi Roy,
> >
> > I can see the issue now, I was confusing status.status_driver_data
> > with
> > driver_data. You are right, we have an issue here. However, copying
> > all the
> > ieee80211_tx_info struct seems a bit overkill, what do you think?
> > Moreover, we have the same issue for various chipsets (e.g. mt7925
> > and
> > mt7915).  I guess we should try to find a global solution for the
> > problem.
> >
> > Regards,
> > Lorenzo
>
> What about adding an helper for cb operation?
>
> +void
> +mt76_tx_status_skb_cb_add(struct mt76_dev *dev, struct sk_buff *skb,
> +                         struct mt76_wcid *wcid, int pid)
> +{
> +       struct mt76_tx_cb *cb =3D mt76_tx_skb_cb(skb);
> +
> +       memset(cb, 0, sizeof(*cb));
> +
> +       spin_lock_bh(&dev->status_lock);
> +       cb->wcid =3D wcid->idx;
> +       cb->pktid =3D pid;
> +       spin_unlock_bh(&dev->status_lock);
> +}
> +EXPORT_SYMBOL_GPL(mt76_tx_status_skb_cb_add);
>
> And add this for each chipset.
>
> index 061ab66..d0b67a2 100644
> --- a/mt7996/mac.c
> +++ b/mt7996/mac.c
> @@ -1108,6 +1108,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
> void *txwi_ptr,
>         if (!is_8023 || pid >=3D MT_PACKET_ID_FIRST)
>                 mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb,
> wcid, key,
>                                       pid, qid, 0);
> +       mt76_tx_status_skb_cb_add(dev, tx_info->skb, wcid, pid);
>
>

I would prefer to split the cb init logic out of
mt76_tx_status_skb_add() and add a dedicated helper:

  /*
   * Must be called only after all TXWI/TXP code has consumed
   * IEEE80211_SKB_CB(skb)->control, since this switches skb->cb to the
   * mt76 tx status tracking overlay.
   */
  void
  mt76_tx_status_skb_init(struct mt76_dev *dev, struct mt76_wcid *wcid,
              struct sk_buff *skb, int pktid)
  {
      struct mt76_tx_cb *cb =3D mt76_tx_skb_cb(skb);

      memset(cb, 0, sizeof(*cb));

      if (wcid)
          cb->wcid =3D wcid->idx;
      cb->pktid =3D pktid;
  }
  EXPORT_SYMBOL_GPL(mt76_tx_status_skb_init);


Then

  pid =3D mt76_tx_status_skb_add(...);
  ... write TXWI/TXP while info->control is still valid ...
  mt76_tx_status_skb_init(...); to fix all drivers under mt76/

  Reasons:

  1. The helper does not need its own spinlock.
mt76_tx_status_skb_add() already protects the idr/list update with
status_lock; this helper only initializes the skb-local cb overlay.
  2. wcid can be NULL on some paths, so the helper should guard against tha=
t.
  3. mt76_tx_status_skb_init() should be called after
mt76_tx_status_skb_add() and after all TXWI/TXP write helpers in each
mt76 driver. The same skb cb aliasing issue can potentially affect all
drivers that consume IEEE80211_SKB_CB(skb)->control after calling
mt76_tx_status_skb_add().
  4.  The comment is useful because the ordering requirement is easy
to miss: mt76_tx_status_skb_init() clears the skb cb area used by
  IEEE80211_SKB_CB(skb)->control, so it must run only after TXWI/TXP
setup has finished reading that control data.

