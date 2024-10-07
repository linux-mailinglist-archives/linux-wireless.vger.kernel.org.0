Return-Path: <linux-wireless+bounces-13610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8999316D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 17:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC8F28692B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74561D8E04;
	Mon,  7 Oct 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgLjMt73"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD41D86DC
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315416; cv=none; b=qezd7VIi8AAoFceseKrLWZK5Y7he2AwZfWlAZ2jRDK3QgBva/1iJf+gAUwZ1sr/wTopFfhPWNXiOndusN3t6pLq4+iyR4vzyiCEm8Zr7ZNmsQ3zaMYks2aQg8JPhBJwsBgmzHpoPtJTRdbS2YcK1WeEhkwBoErMtfB/yoM0VKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315416; c=relaxed/simple;
	bh=mizogUoElqCNdpN609QZ/Wi+Sfr22lu49+xkWpZhyy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbV1v03jjWtoaemrZEb9D2tMhniB6sD5+g30QylE9+l2hk/bdQoqLkcCqA1RumLPF9OmggiXga4TCugTQaQjqaJWw7Fr/3BDHG0VV6ljEh69ufPEh7LBFeEXe+bk4h7or1HyVhCzjAKdBrjYR+4wV7ONM23JAFmr1jmYPz0Y4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgLjMt73; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e09f67bc39so3800376a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Oct 2024 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728315414; x=1728920214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BX+VbcYlbm0M/siPhF6PIc3XMMYf77ReOhn3qLkShA=;
        b=VgLjMt73HNaPvA763xGx2iDSctefvyIdphXWbMXIADxNaHGFPQHh9wf4locOKOgJQM
         11UwHzxEUtlo3hwuS1mMhWT9KQ40mpHC8ljVolw0626/A3OeVR0M5xCLBm4INdj7yubW
         wMT4kO1Nvj8uPIXxsBzBr05oyka2uqT8NJNp1nwJjuy5S2dLK27YOI9XOcMJVw0Rzs/n
         dXwh6xHCuG1A79XmvZkJ9880UT+21PuJUdrg1m4mohjjm8ojVANlhFLDKXJ5WaLxbG4w
         kAsKbXQKMkl+jXtYLoJBbKFy2X6i8apxC7MjYDRoU2OT+DKKf1DHK8Le19p/313bao81
         4QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315414; x=1728920214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BX+VbcYlbm0M/siPhF6PIc3XMMYf77ReOhn3qLkShA=;
        b=FCsrQ4CuDxWrcw1rIxglvdSma8ckrR0uA1k2ke7CjZxs+QdczxAFBgInxb3yj8tEdU
         7USeM2tPNKs8udlIQ4IjsCdw4rug/hFANdWuphHHuQ+MxbOByl35U+4cQindXZUez4Mr
         S1l7CqKNZqIMYbTlB9Y3shWWNlt7MyVVM1hsNoSa8lc8uRnRcZuhmBSd0hDWW0t1TxW8
         EYuVYtJNxB5JktIaqXYBGPYZgK7s6jv/GoVugXsPp83/ZME/rRMvOOcnAziPw6zdUO61
         zb2nd5PZ5NuqQkcSsuUjNyUrmAXACd3lpY4AVVsZ9U3BJgRC4gjM/SrpLQOJ9Nb/UOKU
         M93g==
X-Forwarded-Encrypted: i=1; AJvYcCWpZX8VCaznDHImGNK72ZDvuksMxjlcertKlPFYHX6cT1wwQiuEA9ucsiNQh45sK2MF0PLiOHvUw8S8EpaPjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCo5el+MBlI0AEu9Lvo7MBPbraL7T+H1reNkDjmOZR4BwGeT9v
	Y1mhpJVR5cLIt7mn7XNCWEQ8pyeqr0MKpdoh25cTIRLrPcp11Uw6xyFZFdaNH8upzuy4Ps4EPd1
	lhuVDR/el6lkkBliC/1Vq8R+AYtw=
X-Google-Smtp-Source: AGHT+IHED5KE17P2SIVe12eKhrSWZxRW4U7wLJ3evF8QAPobxP8FyVWs6VS9pgVnIUZ12Cr6PlEXIKLWhUvvhFYajLE=
X-Received: by 2002:a17:90b:102:b0:2c9:7611:e15d with SMTP id
 98e67ed59e1d1-2e1e629fa8cmr15909999a91.20.1728315414372; Mon, 07 Oct 2024
 08:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003180959.12158-1-zichenxie0106@gmail.com> <e116a42e-877e-439e-a83d-1afbaf35748b@gmail.com>
In-Reply-To: <e116a42e-877e-439e-a83d-1afbaf35748b@gmail.com>
From: Zichen Xie <zichenxie0106@gmail.com>
Date: Mon, 7 Oct 2024 10:36:44 -0500
Message-ID: <CANdh5G4mnj-N1gV=O=OiFFrZYFP+nzjte2dZTCAobzBHxSdhpA@mail.gmail.com>
Subject: Re: [PATCH v5] wifi: mt76: Fix NULL Dereference caused by mt76_connac_get_he_phy_cap()
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org, 
	angelogioacchino.delregno@collabora.com, johannes.berg@intel.com, 
	quic_adisi@quicinc.com, deren.wu@mediatek.com, chui-hao.chiu@mediatek.com, 
	mingyen.hsieh@mediatek.com, howard-yh.hsu@mediatek.com, 
	StanleyYP.Wang@mediatek.com, allen.ye@mediatek.com, 
	benjamin-jw.lin@mediatek.com, Bo.Jiao@mediatek.com, evelyn.tsai@mediatek.com, 
	meichia.chiu@mediatek.com, krzk@kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	chenyuan0y@gmail.com, zzjas98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

IMHO, using operator "&" for a NULL dereferenced pointer won't cause a
crash. 've' will only be assigned to a invalid address.

So we can put off the NULL check after
'const struct ieee80211_he_cap_elem *ve =3D &vc->he_cap_elem;'

Best Regards,
Zichen

On Mon, Oct 7, 2024 at 9:23=E2=80=AFAM Matthias Brugger <matthias.bgg@gmail=
.com> wrote:
>
>
>
> On 03/10/2024 20:09, Gax-c wrote:
> > From: Zichen Xie <zichenxie0106@gmail.com>
> >
> > mt76_connac_get_he_phy_cap() may return a NULL pointer,
> > leading to NULL Pointer Dereference.
> > Add a NULL check for the returned pointer.
> >
> > Fixes: a5c372f77aa7 ("wifi: mt76: mt7925: extend mt7925_mcu_bss_he_tlv =
for per-link BSS")
> > Fixes: e6d557a78b60 ("mt76: mt7915: rely on mt76_connac_get_phy utiliti=
es")
> > Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi=
 7 (802.11be) devices")
> > Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> > ---
> >   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 5 +++++
> >   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 ++
> >   drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 ++
> >   3 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/=
net/wireless/mediatek/mt76/mt7915/mcu.c
> > index 87d0dd040001..762be3a37228 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> > @@ -551,6 +551,8 @@ mt7915_mcu_bss_he_tlv(struct sk_buff *skb, struct i=
eee80211_vif *vif,
> >       struct tlv *tlv;
> >
> >       cap =3D mt76_connac_get_he_phy_cap(phy->mt76, vif);
> > +     if (!cap)
> > +             return;
> >
> >       tlv =3D mt76_connac_mcu_add_tlv(skb, BSS_INFO_HE_BASIC, sizeof(*h=
e));
> >
> > @@ -1145,6 +1147,9 @@ mt7915_mcu_sta_bfer_he(struct ieee80211_sta *sta,=
 struct ieee80211_vif *vif,
> >       u8 nss_mcs =3D mt7915_mcu_get_sta_nss(mcs_map);
> >       u8 snd_dim, sts;
> >
> > +     if (!vc)
> > +             return;
> > +
>
> That will already blow up at line:
>          const struct ieee80211_he_cap_elem *ve =3D &vc->he_cap_elem;
>
> This needs some more code changes.
>
> Regards,
> Matthias
>
> >       bf->tx_mode =3D MT_PHY_TYPE_HE_SU;
> >
> >       mt7915_mcu_sta_sounding_rate(bf);
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/=
net/wireless/mediatek/mt76/mt7925/mcu.c
> > index 748ea6adbc6b..55e4cda2f20f 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> > @@ -2508,6 +2508,8 @@ mt7925_mcu_bss_he_tlv(struct sk_buff *skb, struct=
 ieee80211_bss_conf *link_conf,
> >       struct tlv *tlv;
> >
> >       cap =3D mt76_connac_get_he_phy_cap(phy->mt76, link_conf->vif);
> > +     if (!cap)
> > +             return;
> >
> >       tlv =3D mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeo=
f(*he));
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/=
net/wireless/mediatek/mt76/mt7996/mcu.c
> > index 6c445a9dbc03..55bb2d0e67e5 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
> > @@ -798,6 +798,8 @@ mt7996_mcu_bss_he_tlv(struct sk_buff *skb, struct i=
eee80211_vif *vif,
> >       struct tlv *tlv;
> >
> >       cap =3D mt76_connac_get_he_phy_cap(phy->mt76, vif);
> > +     if (!cap)
> > +             return;
> >
> >       tlv =3D mt7996_mcu_add_uni_tlv(skb, UNI_BSS_INFO_HE_BASIC, sizeof=
(*he));
> >

