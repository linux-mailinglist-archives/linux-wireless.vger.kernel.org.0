Return-Path: <linux-wireless+bounces-12455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9D796B25F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F4E5B24AE8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E481EC01C;
	Wed,  4 Sep 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW9W67NL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC113AD03
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433749; cv=none; b=kH7OxSA22yNP7JH8bapVNgAt0siJysK2b0xQLCNh9e9ePvlKn1fmQEb6Dwsf0gs5tcPrGQrn2BY5hMzJ4R/94//lODeSrb+eZdqd3PhEKgvkR/KDNe6XNF3KswK4AyeKYKVAvp4e9RTEv88AG2kKz1TTZQCVOLWo4+vS1PVLlIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433749; c=relaxed/simple;
	bh=gs/0SPBasjNuyHN1mYV2MsMLjbnspsQ5r+qeJG7eDTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9bFGkcAbZLaVEZX3iUAD6tU7B2Sl0ojLGdfT/dWbMJDUKz45FHsYbCnVGbFhubz9s7ufxwb4JBVCeUDYixm3uD+gDaQ/JEEpwhKlT8HHqgSjhBEtcyL8RYQavghjdXkMHcNSYowEmMZn8c/uVQ4I8iYdYcz8O3kDTAsgjDLiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW9W67NL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8696e9bd24so730778266b.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2024 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725433746; x=1726038546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAQ1XPeOuW1suoDPDn70c8OJsrNRAiX0NGHVqlphyVc=;
        b=IW9W67NL1jUp0hqEwlJpvnj/X1hs97DYdu47D7g2527m2UnsxtIkDuBo5uZwKrYIt+
         JKrJE181Z2vDlOaW7clUXNN+Kwk2MkcBWbxF7QjxIi/cwA4l+fIxq/4bR0PV6HNC1FH5
         8XLTYZ8uIHtxLgRbjXD3OMBLsqj0Ux4eTmcvq4fQUFQW31EJ5yNyUUBhon7SHMpa6oAv
         DXuNYcqkLKnSVg0kpkesnb/sVSiYKw4MkGJwmLtJ+Cy5MVSOnbZQJfV3F3RpHD+lOUPR
         GWBC/y9YvnQNmx2Yplp0cS+9uGxV+jpOX2Gdk90yWMuimCC2AvRzY6sARpc5+aKgbxT/
         jv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725433746; x=1726038546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAQ1XPeOuW1suoDPDn70c8OJsrNRAiX0NGHVqlphyVc=;
        b=JpE7rqzWoGGQz4OcgN7CmDs0IHkvX/fpYWkCXILFpKJO4aXD+nlfc9bpG1klYcNuw5
         StEZrLiJYFMNnMgRR+jSqLPpvcODB/z628vANKITaDH5SOpxNG5jQI5RjjsvXNHCotcc
         MQB3rizaXvW7Qoc3p17Td5d8a0LBImv/N+n71b+w13ibQId2gL5xqvIWGdTCshosOfng
         HDfAvlra9Z6/IcEzJgnPA5TCksS7V9+IPaUaLl/6jSNplwY8phVTL3NzPneo02sDM7W4
         rgZiAYsPBnnkvu5QJdfmZcl/rCyGBcPVmAjyQEVF2b2WxZVfT3wWkgl3K5XrHROL+56j
         PxSw==
X-Forwarded-Encrypted: i=1; AJvYcCWs/aORo16VV1o0d601BS1VbJDeoIg05z91BPjUJnmnI1h8m/E4NOVEIydMWL9dQZrpyF3+PenNUlxVW45IRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM8LlA3QQLf1kLF4IUWnDCKd2tJ0rf+E40AxQY0qbLZnRgbf7
	KGbhj47kdsJrrCW22SppmIUukgeCef5klx9zMqzrhr1NgKPTX6XbxFeVSeYOxUayEX4JYbUua0I
	d4eS0OtAAEeRpZIcA8H6S/1U8LV4=
X-Google-Smtp-Source: AGHT+IH8DRIxNELexKn1ec0F9xVaOEcsY/HJn4AZsJ8JApAOePnppTC4rgDGU5L8Z7UGOZNtFZiY9gh3goA8HXOQneE=
X-Received: by 2002:a17:907:6088:b0:a7a:bb54:c858 with SMTP id
 a640c23a62f3a-a897f84d6e0mr1521756766b.26.1725433745986; Wed, 04 Sep 2024
 00:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LO0P123MB4057D6C2F6FEFF335B30EE7CD6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <LO0P123MB4057122D4C7D07C7114F5ABED6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <be53813c-3edc-4734-b59d-83f43f14ea91@quicinc.com> <LO0P123MB4057C3085F445434F5E87B3AD6872@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <26bb8ec7-7170-4a09-ada3-c7c753c16e87@quicinc.com> <LO0P123MB40573F46A6D63145363C6B13D6812@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <cfe8e314-a28b-4ea3-85b2-9f5b4ac2db09@quicinc.com> <LO0P123MB405769E063E48B0F7AE18C5FD68C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <LO0P123MB4057E823BDB7B9ECCCD75840D6972@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <a6c609fc-150b-4779-b3f6-dddbd6ce93dc@quicinc.com> <LO0P123MB40578A6CEC43AEFE301F9ED8D6912@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <86bc1623-8845-43fa-9aad-a8a6066b1448@quicinc.com> <LO0P123MB4057266AFF389FA69FDC84B8D6922@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <fb455a66-b29b-4eb0-984c-254f9a1c5626@quicinc.com> <LO0P123MB40578B26075CD4C9C66D144BD6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <871q21kwk8.fsf@kernel.org> <CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
 <87seuhjbfn.fsf@kernel.org> <LO0P123MB4057552A6B51BCC3C75A0013D6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
 <CAFED-jnkQRV-_cfSuuOG5YxhA0O6Pxw7GyNyZ3AYoC+-Txn5yw@mail.gmail.com> <LO0P123MB4057091D9028417A192B0E60D69C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: <LO0P123MB4057091D9028417A192B0E60D69C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Wed, 4 Sep 2024 09:08:54 +0200
Message-ID: <CAFED-jnOLFp7VVJoscspeb7dYj_3Qxgd25ji78+7gx5uJdiaqQ@mail.gmail.com>
Subject: Re: wcn7850 issues
To: david Atkins <david@3adesign.co.uk>
Cc: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 4 wrz 2024 o 08:04 david Atkins <david@3adesign.co.uk> napisa=C5=
=82(a):
>
> > > > >> > ...
> > > > >> >> >>>         Ext Tag: EHT Operation (802.11be D3.0)
> > > > >> >> >>>             Ext Tag length: 8 (Tag len: 9)
> > > > >> >> >>>             Ext Tag Number: EHT Operation (802.11be D3.0)=
 (106)
> > > > >> >> >>>             EHT Operation Parameters: 0x01, EHT Operation
> > > > >> >> >>> Information
> > > > >> >> Present
> > > > >> >> >>>                 .... ...1 =3D EHT Operation Information P=
resent: True
> > > > >> >> >>>                 .... ..0. =3D Disabled Subchannel Bitmap =
Present: False
> > > > >> >> >>>                 .... .0.. =3D EHT Default PE Duration: Fa=
lse
> > > > >> >> >>>                 .... 0... =3D Group Addressed BU Indicati=
on Limit: False
> > > > >> >> >>>                 ..00 .... =3D Group Addressed BU Indicati=
on Exponent: 0
> > > > >> >> >>>                 00.. .... =3D Reserved: 0x0
> > > > >> >> >>>             Basic EHT-MCS And Nss Set: 0x44444444
> > > > >> >> >>>             Control: 0x02, Channel Width: 80 MHz EHT BSS
> > bandwidth
> > > > >> >> >>>                 .... .010 =3D Channel Width: 80 MHz EHT B=
SS bandwidth
> > (2)
> > > > >> >> >>>                 0000 0... =3D Reserved: 0x00
> > > > >> >> >>>
> > > > >> >> >>> Are you saying the ath12k driver does not support these
> > > > >> >> >>> features? If not can
> > > > >> >> >> you clarify the issue so I can raise with the AP team.
> > > > >> >> >>>
> > > > >> >> >> ath12k/WCN7850 supports EHT, but with NSS only 2. Here the
> > > > >> >> >> AP requires NSS to be no less than 4, that is why EHT
> > > > >> >> >> connection was
> > > > disabled.
> > > > >> >> >
> > > > >> >> > Which field is requiring NSS of 4, I'm only seeing a maximu=
m
> > > > >> >> > of 4, the
> > > > >> >> Qualcomm windows driver will connect to the same AP, we had
> > > > >> >> assumed that that ath12k would do the same.
> > > > >> >> Basic EHT-MCS And Nss Set: 0x44444444
> > > > >> >
> > > > >> > My understanding of the spec is that there are maximum numbers
> > > > >> > of streams though, are you saying the AP has to advertise
> > > > >> > 0x22222222 which would then prevent a 4x4 client (say an
> > > > >> > extender) from connecting with 4 streams? I note that the
> > > > >> > Qualcomm windows driver for Hamilton works with the AP and an
> > > > >> > Intel BE200 also works both of which will be in at most 2x2
> > > > >>
> > > > >> Did you test Intel BE200 with the Windows driver? Johannes
> > > > >> mentioned that ieee80211_verify_sta_eht_mcs_support() in mac8021=
1
> > > > >> checks this so I would assume that iwlwifi also behaves like ath=
12k.
> > > > >
> > > > > Yes, this is AP issue - hostapd fix required - advertise 0x11111 =
...
> > > > > In other case station  < 4nss will drop to HE only.
> > > >
> > > > Thanks. And Johannes pointed out that you had even discussed about
> > > > this
> > > > before:
> > > >
> > > > https://lore.kernel.org/linux-wireless/CAFED-jk8pJheJEViESnE54f-
> > > > K+JgRMiWoiCSa0GBt=3DRKaCn7sw@mail.gmail.com/
> > > >
> > >
> > > So this
> > >
> > > Basic EHT-MCS And Nss Set: 0x44444444
> > >
> > > Should be 0x11111111 ? and it defines the minimum number of streams
> > needed to connect?
> > >
> > > This the defines the max streams ?
> > >
> > >             Supported EHT-MCS and NSS Set
> > >                 EHT-MCS Map (BW <=3D 80MHz): 0x444444
> > >                     .... .... .... .... .... 0100 =3D Rx Max Nss That=
 Supports EHT-MCS 0-9:
> > 4
> > >                     .... .... .... .... 0100 .... =3D Tx Max Nss That=
 Supports EHT-MCS 0-9: 4
> > >                     .... .... .... 0100 .... .... =3D Rx Max Nss That=
 Supports EHT-MCS 10-
> > 11: 4
> > >                     .... .... 0100 .... .... .... =3D Tx Max Nss That=
 Supports EHT-MCS 10-
> > 11: 4
> > >                     .... 0100 .... .... .... .... =3D Rx Max Nss That=
 Supports EHT-MCS 12-
> > 13: 4
> > >                     0100 .... .... .... .... .... =3D Tx Max Nss That
> > > Supports EHT-MCS 12-13: 4
> > >
> > You mix different things:
> >
> > Supported EHT-MCS and NSS set  vs Basic EHT-MCS And Nss Set
>
> So the basic set is the minimum?
>

linux mac80211 check it as minimum - if not pass disable client EHT

OS hostapd set is as 0x00000011 but there is some TODO - so maybe
someone else should describe it more :)
https://w1.fi/cgit/hostap/tree/src/ap/ieee802_11_eht.c#n235

So, eg. OpenWrt/main EHT AP on mt7996e use 0x00000011, and Intel
BE200/WCN7850 connect using EHT

BR
Janusz

