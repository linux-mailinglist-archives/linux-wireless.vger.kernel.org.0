Return-Path: <linux-wireless+bounces-36612-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM0qF15aC2oCGAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36612-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 20:28:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C17A5572410
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F263036CEA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A775382296;
	Mon, 18 May 2026 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKMub3Jk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777E380FF2
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128645; cv=pass; b=XKUPFz7giYQdL8okhbqMZP8yxt4WtaE6AJrdaz177KqD4LNq6oOR5eV1wXjzLuMDY5FaLlgR4fIoHjD1KW8nGpYUa8kbUTH71Y5oYfP95SX9AYHH9tC2qVlTO13LZJnOJO+aQTmWJEadioiv+1iahKmqmsgYXf9SeTIfcP5ftP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128645; c=relaxed/simple;
	bh=9BGJGdDGBwxuTjXu+vZPGTzZyWZz+B3c2qrTOIN7wUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaEhZb7Mioj7n6/TypVp1yqsNWPvwQiam8V4S29TVcHFSA+2dIetnlQnjHj6kp/uXXN19t/CB3BuKxIq0VBMkUprkvzPemI7FNkG5cF96GiuL9RUryfwK05pboC1BhNtrUewrqeHO7hNCBO3CYvc2yKaz9V0Xi6Ffy6zfvsy+TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKMub3Jk; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcd3c190f71so465333866b.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 11:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779128642; cv=none;
        d=google.com; s=arc-20240605;
        b=Rrn3S/NdxtpFbflO5tCnN7qCNsfe7/Ad1FecI7Do1ShJ+ph2EV2Mt0WhI1RMg4GLO6
         PF+WVQc+bZ2i57WxXTeWeIigcsW8DkDgwyu4QZUcPqN8xuu19BSIuoFgQpm8ifDzpt38
         qY1rvyC2ZXluydSsOZxxKzL5xs05Z56pblg4cUe/0B7ZljdLfijiDboJkk3j6dA5aNEB
         mAHKfhUrwWbWzcQTF6Vz1F0m51UEmCD0Gmkx4Hi1DtU7GSrpgBp2J6zro4HxS6oIiCAu
         /DLClUj+Fi9je0uwa5l1BTitG+kaxjNaXVKPlAf4v8ozqJ+DIVkEvZPCOfa+ItRxAh+1
         x5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MkRwRwwQI9Lvwqp+ZfDsXnx8pCUGF38PtuwOnzRf8PA=;
        fh=nhtPxshgUuizRTEqVVps+DZdW4ET4o3XZwuFF+LyPso=;
        b=BsRjIf4VDDjr5kNVD/zGfQBTKFwWuiy0ZySs4wyDENn30ENLeSUZdYMF+fQAGYaGUb
         cXJvsMwN2VA+2ckOfpt4TjRZ2F6JgGVtAweo9U2NfpZQjhuN65RE+7d+HNgfuMcgM4i8
         ewPtzPi+eHNUJZSXhQN5CRAfEL+Kn8j+nP3kftRDLl21jjqPx5qJ688S5K4X+luAWbrG
         UBOPQfZOxgdcPLyIeB+E12ZhknGXXK4+Jw8gI0tFhLtbL/xaeNRqhxjqYTmSTaqn6bDb
         XzFmFx6sD0KV31IxFN0f0MHe0nb/joWqJ9srIcJW8XrKZMJHYpPfT1tPyDEXiVZ8+HJm
         ebrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128642; x=1779733442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkRwRwwQI9Lvwqp+ZfDsXnx8pCUGF38PtuwOnzRf8PA=;
        b=CKMub3JkaRKCTxt9CBTESHE3emmVaRnTQGPLwJtFHfSxYizoQPTTXX36IK2uUwsMXl
         T3hQojB2DoIx9fEtGVDtMFnfmZ5Fy8OalqwPadQBsNTv0iVg3R776fypGwxBgR/BVHuo
         kGcpffYeFPK0KMZLb6b0Jnig9C/+Z4QUM8Xa2M9VjzuTtpAUzXZwff9pu+PYcjiBGdzF
         dm6cbpCjOnnYHcxHW9OVI3nqBU1Xi+J1fn4iyORoh/+q5Fw7O75qMl42uaGrXGd+u0yo
         ScD/7hrtmrU8HNasg9hp8swC6xp0nne66FdseF/idIj2HSKTcZM4071FR3NbS/msiKGR
         ZLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128642; x=1779733442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MkRwRwwQI9Lvwqp+ZfDsXnx8pCUGF38PtuwOnzRf8PA=;
        b=omwDfzIZBVlz7j9eDVoY2u9rMV2BcBInqvGivb18KTV29CkPOb/yaSR1TThfmXtDf4
         1cnbmThSXicezmD34vPXEjZ09XMRCahzFtoDZH+WobRHNGVhGaxzOLenO1LlNlZSPWs2
         lFA/+/Khq3StYiRnedBFGr4uyPt8032XRxoU4JhUyW/1o4KYqc9cP1h5sNTpOpAvGrUZ
         XrF+8QpVrTwHUs5dldI12jko9fTHgkl8+G91r5cpnZIIZRFr7B77YDryeODgLVv3YsZs
         ZGs2gzUyqEVP2/6nUTgBn3u3NmNWxEUv4vCe98/LTD73ayNxlCPEMQFCRQw6loSf7sKs
         o73g==
X-Forwarded-Encrypted: i=1; AFNElJ/mGAC4+bMaklAqi805q+H9RRZOmwZ2tzDL6szX8eHzeHUF9BD3OSc2IPTW7SX5nMXmOXLanQWuB0yv6p9jWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9BM9+CIgTHa0ySrATplCV2yDg7xiVQxczYJicLevYbjKcjfth
	VxEv6QvnYlE8XR05MfTeFuiQtH2ZI/01xfB7i2kjI3RA5xCD8Lfi3Pb6U+JNgg3UR/2hL9tLrF8
	pCzyaY8n5D0LVibTCFh5pCNKHJZ+zCNY=
X-Gm-Gg: Acq92OFtM/aqNjmiRFH0Epz0yqOefdZn5+DoGX15jkLNm2yrQljutAExDUjeNPHU0w1
	uw68AMDtDxFh0nXg7HzJhoantC80f1Hx8x5lV5eU82JO7iX7QLJ3Bou9FxoZuCEO8QZH2ysq1Id
	6W6uLSxjj2SoeLL+RdFVNf+XD8/DTEwGrZm88oux4QF26O90m3oyqJEPQQc7vLI61fBa9i0ivCU
	1pcxv+quSI3IatSW0ufx1Sh/hyXKD+DoCh2HsHe2RT1K5QnLlxaHxwsgU7Faa6ZFP0VuZXarZPA
	J9DW/7x6HgrBHJFdCmYAEEarEpBmek8g88//BMJChN4O4WaVjqM=
X-Received: by 2002:a17:907:c50e:b0:bd4:f3e5:b0f6 with SMTP id
 a640c23a62f3a-bd517964d1fmr901741666b.28.1779128642168; Mon, 18 May 2026
 11:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5ecac6a9b7d29526e8438dea105b58f5487c93aa.1778521232.git.ryder.lee@mediatek.com>
 <agdJ1EtZjjWh2R1h@lore-desk> <CAHoxojJX2BRRTLMuM_QcJqMMmshxS4EAwrB1VjU3rsZ+0k2PAg@mail.gmail.com>
 <agsGiHKH6ly1afaf@lore-desk>
In-Reply-To: <agsGiHKH6ly1afaf@lore-desk>
From: Roy Luo <roychl666@gmail.com>
Date: Mon, 18 May 2026 11:23:51 -0700
X-Gm-Features: AVHnY4I8XXaA-Ix7yIv2zNLRgB6T4AcoApIY86IDAvHLUZ-cOoSi0nKs1Qxz7eM
Message-ID: <CAHoxojKeXCCnJoO7yBBmTM9euiTf38orujOhOK00X8bb3ctWuA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid memset overwriting tx_info->control.flags
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Shayne Chen <shayne.chen@mediatek.com>, Roy Luo <roy-ch.luo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36612-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roychl666@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: C17A5572410
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 5:31=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> On May 15, Cheng Hao Luo wrote:
> > > struct ieee80211_tx_info {
> > >         u32                        flags;                /*     0    =
 4 */
> > >         u32                        band:3;               /*     4: 0 =
 4 */
> > >         u32                        status_data_idr:1;    /*     4: 3 =
 4 */
> > >         u32                        status_data:13;       /*     4: 4 =
 4 */
> > >         u32                        hw_queue:4;           /*     4:17 =
 4 */
> > >         u32                        tx_time_est:10;       /*     4:21 =
 4 */
> > >
> > >         /* XXX 1 bit hole, try to pack */
> > >
> > >         union {
> > >                 struct {
> > >                         union {
> > >                                 struct {
> > >                                         struct ieee80211_tx_rate rate=
s[4]; /*     8    12 */
> > >                                         s8     rts_cts_rate_idx; /*  =
  20     1 */
> > >                                         u8     use_rts:1; /*    21: 0=
  1 */
> > >                                         u8     use_cts_prot:1; /*    =
21: 1  1 */
> > >                                         u8     short_preamble:1; /*  =
  21: 2  1 */
> > >                                         u8     skip_table:1; /*    21=
: 3  1 */
> > >                                         u8     antennas:2; /*    21: =
4  1 */
> > >                                 };                       /*     8    =
14 */
> > >                                 long unsigned int jiffies; /*     8  =
   8 */
> > >                         };                               /*     8    =
16 */
> > >                         struct ieee80211_vif * vif;      /*    24    =
 8 */
> > >                         struct ieee80211_key_conf * hw_key; /*    32 =
    8 */
> > >                         u32        flags;                /*    40    =
 4 */
> > >                         codel_time_t enqueue_time;       /*    44    =
 4 */
> > >                 } control;                               /*     8    =
40 */
> > >                 struct {
> > >                         u64        cookie;               /*     8    =
 8 */
> > >                 } ack;                                   /*     8    =
 8 */
> > >                 struct {
> > >                         struct ieee80211_tx_rate rates[4]; /*     8  =
  12 */
> > >                         s32        ack_signal;           /*    20    =
 4 */
> > >                         u8         ampdu_ack_len;        /*    24    =
 1 */
> > >                         u8         ampdu_len;            /*    25    =
 1 */
> > >                         u8         antenna;              /*    26    =
 1 */
> > >                         u8         pad;                  /*    27    =
 1 */
> > >                         u16        tx_time;              /*    28    =
 2 */
> > >                         u8         flags;                /*    30    =
 1 */
> > >                         u8         pad2;                 /*    31    =
 1 */
> > >                         void *     status_driver_data[2]; /*    32   =
 16 */
> > >                 } status;                                /*     8    =
40 */
> > >                 struct {
> > >                         struct ieee80211_tx_rate driver_rates[4]; /* =
    8    12 */
> > >                         u8         pad[4];               /*    20    =
 4 */
> > >                         void *     rate_driver_data[3];  /*    24    =
24 */
> > >                 };                                       /*     8    =
40 */
> > >                 void *             driver_data[5];       /*     8    =
40 */
> > >         };                                               /*     8    =
40 */
> > >
> > >         /* size: 48, cachelines: 1, members: 7 */
> > >         /* sum members: 44 */
> > >         /* sum bitfield members: 31 bits, bit holes: 1, sum bit holes=
: 1 bits */
> > >         /* last cacheline: 48 bytes */
> > > };
> > >
> > > According to pahole, the size of the control inner union is actually =
16 bytes
> > > since the compiler adds 2 bytes of padding. Since mt76_tx_status_skb_=
add()
> > > meset to 0 just mt76_tx_cb size (that is 16 bytes) I can't see how
> > > control.flags is overwritten. Am I missing something?
> > >
> > > struct mt76_tx_cb {
> > >         long unsigned int          jiffies;              /*     0    =
 8 */
> > >         u16                        wcid;                 /*     8    =
 2 */
> > >         u8                         pktid;                /*    10    =
 1 */
> > >         u8                         flags;                /*    11    =
 1 */
> > >
> > >         /* size: 16, cachelines: 1, members: 4 */
> > >         /* padding: 4 */
> > >         /* last cacheline: 16 bytes */
> > > };
> >
> > Hi Lorenzo,
> >
> > The mt76_tx_cb is placed at status.status_driver_data (offset 32).
> > It overlaps with hw_key, flags and enqueue_time in the control union.
> >
> > static inline struct mt76_tx_cb *mt76_tx_skb_cb(struct sk_buff *skb)
> > {
> > BUILD_BUG_ON(sizeof(struct mt76_tx_cb) >
> >     sizeof(IEEE80211_SKB_CB(skb)->status.status_driver_data));
> > return ((void *)IEEE80211_SKB_CB(skb)->status.status_driver_data);
> > }
>
> Hi Roy,
>
> I still do not understand since mt76_tx_status_skb_add() sets to 0 just s=
izeof
> of mt76_tx_cb, that according to pahole is 16 bytes, so it can't overwrit=
e
> hw_key pointer (whose offset respect to the beginning of the control stru=
ct is
> 24, 32 - 8).
>
> Regards,
> Lorenzo
>
> >
> > Regards,
> > Roy Luo

Hi Lorenzo,

The mt76_tx_status_skb_add() memset zero the 16 bytes starting from
status.status_driver_data (please see the above inline function shared
in my last response) whose offset with respect to the beginning of
the control/status union is exactly 24 (32 - 8) instead of 0.

Regards,
Roy Luo

