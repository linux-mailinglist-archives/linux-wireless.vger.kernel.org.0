Return-Path: <linux-wireless+bounces-35399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBNADXi272mFEAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:18:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6C4792EF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BC93013A7B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 19:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B893E959C;
	Mon, 27 Apr 2026 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2x4Dmtb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4E3D6CD9
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777317442; cv=pass; b=LIf3nwd3maOpsuIxCPWrwGv7X5lnxE1aiEGdGghEpqbqmOOAD4xvP9gXCsGYXi5id9rKLYO5FN5awUcxIm05aIYvviOO8Se0nvH4Zy6th/KOQyfBcVbvz1eC6DRYXc/lC7q1NEwGyD0f8yj1jxkqOu6CxBJzgUCWOta13CbBeIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777317442; c=relaxed/simple;
	bh=3F8lak3aibVvF3EpcEo1ul2OoM98TrAYOLetRf4hJFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL99fgfedB3eD9rry3hmn99bqEpgMFGuD9yxZTiDSSpbpWxbtQts19UUpLfJQTApgro/DeJGTFCE5DDYxplRd8Blc+TsUy62lrJnPvQ3Ph9crTIVFFDdFrU8IzQbATU6QhGmQOj2FU8S2mi03NWs+KlbvKRgMJp3qP2hCsaeE0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2x4Dmtb; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5414503a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 12:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777317438; cv=none;
        d=google.com; s=arc-20240605;
        b=EXpsXO4v9O/erMsjG4pUazu6wfpfvoVSthYYHST7TPhVwcD5n7rux5VslVgfnr27k/
         VIdAy+gNVs4nfAywdx7aoh0Bqt5uentXCkz2oxGBOrx+rkYYmUegK3y6MUUq832oOH8J
         8Q0LtjaQIl7I5134ETr6MXMiqFxk+B15c58DCSn3liTe/Ixj06+ycY93U59utIHW1sz6
         l44vnAZZmP2IEoaa8IAALExPUoGGqOMjXnMW2pkqVDqKHa9WDWtYVCiIv0ds6tWf0RuQ
         +x17EoeA/9falwNJAISNEkiExW+3gTERh5AHJJPxP+iHJ/puSQyA5a0GRKUX4mxSZ/8J
         N30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QEwJ0lK1FRVhZ82nSuKWtqBlS4HOBMbpzPCG8GR79rM=;
        fh=II0xfuARQvd3KjSllQsukef48XrN7z9SZIVLVXGZ5B4=;
        b=MWExSDIlf5KxkpaEyn2akRqfbWwyRAq2C7FS5hxXzVPYzNDlR0DGdJK3qPw/E5l+kD
         t5TEJGt7dv5NVLlkMApfPrtQaIXBEHcsQnOBiFweWdWcIyNUS9rbci3m4DiB6h+b7/xM
         mV8K6+zugJ1tu4CmXteiVappA1GePjevM5xW1JXgvv1og2r5Mz0v6GK5HHGRFqrh5YYd
         KRvZfDJD5DgQHAYOOfcgUbPzHeuODTUjs7+2kjRMX/G/4uA/GSFheFq9hFD6oNvbkEEE
         UsRkmEe9rmwOQrAzgo5ZnxG61RuOleTJ+tujbnTgnKQ4nMyHgwnuaVoE2XPu66N5D3pi
         DQ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777317438; x=1777922238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEwJ0lK1FRVhZ82nSuKWtqBlS4HOBMbpzPCG8GR79rM=;
        b=V2x4DmtbUzEE6LipAMjIX10MJTDrcljW6jvVo+CtOCDnDHw06yacCIt1gQXlH4ng6K
         QILbneEbrakuY3JU2xUg052kUBzNj9/FNPavgQMUulKu1O9NLF8cD2eDZJDwBxcXk98v
         dx8W3WOzqXZQFmd6zwnZbxB7S8wv7eyLKaWgSwN7AiLnV9Q55A0+TMlxD5HwbP7/W++v
         XyL/E88xGCapUqB9/BvBAWt8SeENjKXhqWdSwTNAQHijE1YqmMcDe9MhD4l7sIB+QH23
         +XXpHvjInKudmh3az68Rcvd++VJO6BhmgPgR1wgFBbQjTY/hOERGiFvchkvFEyC57Mgb
         mR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777317438; x=1777922238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QEwJ0lK1FRVhZ82nSuKWtqBlS4HOBMbpzPCG8GR79rM=;
        b=FmdZfYIChlv/ibrP4BhDYknX0oYd3m9FTi6YfxqdzCSDkWptUV2rLsfI7xKDk77MOK
         6XLIhM8qWQapeyf8GZ62DvShdRItkwksqij3mGYWCx6KoCU5+UDBPnIRmKW6MMaPFG5k
         FowmxFYWmDb584U+7JkjnuPPNjwJ5irbFwcmPUxzrBUaqlsUq62RaLJOdbLkwy/V3wpe
         Zq+YlZMSCLVC6HI/OkO4amH5BfvDJNiDUW9me52S50j8pUOWQ/uW70GIsxTbzbSPz8zt
         WOzK1akpYZWqT42IrXytO5WemiwyuYAxUGSsSTnUb4x4ViSZep7Vef/+xVtOIooLdOHD
         OwUw==
X-Forwarded-Encrypted: i=1; AFNElJ8DP1zB91PvaytAok+vMivzZaaEQJbU0tzpTuHumqlZ/yOpKzrc0FvLPu8ekL8+YiQgrnjcd9gZVDAk1McRyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8ERX+JzUnvyRwe06BEYZyY4UERWZUyr8JChQ0EiWtT68Eegy
	7E60aNaSHVdG9y3/iwd1wOVNEBOlG4cGL5L2GpVQTQr2dKAZaF+8QcNqjTNsy06NriKxlu27Cch
	gTMfmEH8xKsx+5AomTLgSNmcEttB2Ebc=
X-Gm-Gg: AeBDieu9z+2LBVP192LrvPb7HAlOHvP3j1s8pBrnA9c8Oo8xRZZNgakujQJ9a9jJ1/h
	9QpCarFnfHgNyJzH3MI7LKPjVSKakHjr3u/QILU4uyGxBUG8ve/Uw+2cuZoSAHw3DiP0bi/YmrF
	R64Oy67OfRdjO24DOybW3pUnVTL6D4osSpxv1dzQBXrsx4sMiJNdOmLEq/cmolA6GDiSjwWzhm6
	zJvSflaJ248sFpbZWBD8KgMzMOq3W9PM5zWe+nzDXyGhyqgx15Q1kKE5Ry/uKdRA0KSxsjznG9G
	8j1rad9WYtkYuBcekkImDxZXCeRKw47EmuvN1BJpstqTogTpbwQfIUpfTdBjjASBcQFygtzETci
	sertHi/UaJfBhun2/zjlrTvFMiRzDwvpX4OdYtoTcN1ZpDcwM
X-Received: by 2002:a17:907:9453:b0:ba4:73da:c with SMTP id
 a640c23a62f3a-bb80530197fmr4956166b.47.1777317437558; Mon, 27 Apr 2026
 12:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427034427.881389-1-rosenp@gmail.com> <20260427034427.881389-4-rosenp@gmail.com>
 <20260427-hug-baboon-d60bb8fdfa51@spud>
In-Reply-To: <20260427-hug-baboon-d60bb8fdfa51@spud>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 27 Apr 2026 12:17:04 -0700
X-Gm-Features: AVHnY4JrG3QUmyGyx0Gb_wy-V9vfTB4Vk66pF2gttwnm5MDKbGyJbNEFCLFWIDI
Message-ID: <CAKxU2N-mhrhjDEc2MnOvDZC5PpMzj=vRgMemNK4qSQzNQ-=BPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] wifi: mt76: remove mt76_get_of_data_from_mtd
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:MEDIATEK MT76 WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 94D6C4792EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35399-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,sipsolutions.net,gmail.com,collabora.com,alpha.franken.de,lists.infradead.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, Apr 27, 2026 at 12:09=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sun, Apr 26, 2026 at 08:44:27PM -0700, Rosen Penev wrote:
> > mt76_get_of_data_from_mtd has been replaced by
> > mt76_get_of_data_from_nvmem in all usages.
>
> All users in the kernel, but what about other sources of devicetrees?
> Those built into firmware etc? Are there none of those too?
I'm actively removing those: https://github.com/openwrt/openwrt/pull/23113

Anyway, irrelevant here.
>
> Conor.
>
> >
> > Remove it to prevent people from using the deprecated
> > mediatek,mtd-eeprom binding.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/eeprom.c   | 87 -------------------
> >  drivers/net/wireless/mediatek/mt76/mt76.h     |  1 -
> >  .../wireless/mediatek/mt76/mt7915/eeprom.c    |  4 -
> >  3 files changed, 92 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/=
wireless/mediatek/mt76/eeprom.c
> > index afdb73661866..092804323d81 100644
> > --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> > +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> > @@ -35,89 +35,6 @@ static int mt76_get_of_eeprom_data(struct mt76_dev *=
dev, void *eep, int len)
> >       return 0;
> >  }
> >
> > -int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int off=
set, int len)
> > -{
> > -#ifdef CONFIG_MTD
> > -     struct device_node *np =3D dev->dev->of_node;
> > -     struct mtd_info *mtd;
> > -     const __be32 *list;
> > -     const char *part;
> > -     phandle phandle;
> > -     size_t retlen;
> > -     int size;
> > -     int ret;
> > -
> > -     list =3D of_get_property(np, "mediatek,mtd-eeprom", &size);
> > -     if (!list)
> > -             return -ENOENT;
> > -
> > -     phandle =3D be32_to_cpup(list++);
> > -     if (!phandle)
> > -             return -ENOENT;
> > -
> > -     np =3D of_find_node_by_phandle(phandle);
> > -     if (!np)
> > -             return -EINVAL;
> > -
> > -     part =3D of_get_property(np, "label", NULL);
> > -     if (!part)
> > -             part =3D np->name;
> > -
> > -     mtd =3D get_mtd_device_nm(part);
> > -     if (IS_ERR(mtd)) {
> > -             ret =3D  PTR_ERR(mtd);
> > -             goto out_put_node;
> > -     }
> > -
> > -     if (size <=3D sizeof(*list)) {
> > -             ret =3D -EINVAL;
> > -             goto out_put_node;
> > -     }
> > -
> > -     offset +=3D be32_to_cpup(list);
> > -     ret =3D mtd_read(mtd, offset, len, &retlen, eep);
> > -     put_mtd_device(mtd);
> > -     if (mtd_is_bitflip(ret))
> > -             ret =3D 0;
> > -     if (ret) {
> > -             dev_err(dev->dev, "reading EEPROM from mtd %s failed: %i\=
n",
> > -                     part, ret);
> > -             goto out_put_node;
> > -     }
> > -
> > -     if (retlen < len) {
> > -             ret =3D -EINVAL;
> > -             goto out_put_node;
> > -     }
> > -
> > -     if (of_property_read_bool(dev->dev->of_node, "big-endian")) {
> > -             u8 *data =3D (u8 *)eep;
> > -             int i;
> > -
> > -             /* convert eeprom data in Little Endian */
> > -             for (i =3D 0; i < round_down(len, 2); i +=3D 2)
> > -                     put_unaligned_le16(get_unaligned_be16(&data[i]),
> > -                                        &data[i]);
> > -     }
> > -
> > -#ifdef CONFIG_NL80211_TESTMODE
> > -     dev->test_mtd.name =3D devm_kstrdup(dev->dev, part, GFP_KERNEL);
> > -     if (!dev->test_mtd.name) {
> > -             ret =3D -ENOMEM;
> > -             goto out_put_node;
> > -     }
> > -     dev->test_mtd.offset =3D offset;
> > -#endif
> > -
> > -out_put_node:
> > -     of_node_put(np);
> > -     return ret;
> > -#else
> > -     return -ENOENT;
> > -#endif
> > -}
> > -EXPORT_SYMBOL_GPL(mt76_get_of_data_from_mtd);
> > -
> >  int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
> >                               const char *cell_name, int len)
> >  {
> > @@ -163,10 +80,6 @@ static int mt76_get_of_eeprom(struct mt76_dev *dev,=
 void *eep, int len)
> >       if (!ret)
> >               return 0;
> >
> > -     ret =3D mt76_get_of_data_from_mtd(dev, eep, 0, len);
> > -     if (!ret)
> > -             return 0;
> > -
> >       return mt76_get_of_data_from_nvmem(dev, eep, "eeprom", len);
> >  }
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wi=
reless/mediatek/mt76/mt76.h
> > index 527bef97e122..f447ecac664d 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > @@ -1339,7 +1339,6 @@ void mt76_seq_puts_array(struct seq_file *file, c=
onst char *str,
> >
> >  int mt76_eeprom_init(struct mt76_dev *dev, int len);
> >  int mt76_eeprom_override(struct mt76_phy *phy);
> > -int mt76_get_of_data_from_mtd(struct mt76_dev *dev, void *eep, int off=
set, int len);
> >  int mt76_get_of_data_from_nvmem(struct mt76_dev *dev, void *eep,
> >                               const char *cell_name, int len);
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drive=
rs/net/wireless/mediatek/mt76/mt7915/eeprom.c
> > index eb92cbf1a284..c24e1276700b 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> > @@ -29,10 +29,6 @@ static int mt7915_eeprom_load_precal(struct mt7915_d=
ev *dev)
> >
> >       offs =3D is_mt7915(&dev->mt76) ? MT_EE_PRECAL : MT_EE_PRECAL_V2;
> >
> > -     ret =3D mt76_get_of_data_from_mtd(mdev, dev->cal, offs, size);
> > -     if (!ret)
> > -             return ret;
> > -
> >       ret =3D mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", siz=
e);
> >       if (!ret)
> >               return ret;
> > --
> > 2.54.0
> >

