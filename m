Return-Path: <linux-wireless+bounces-12452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBAF96B054
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E554B24389
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00803433C8;
	Wed,  4 Sep 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTbAbcya"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E32A1BF
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426529; cv=none; b=qd9xBbwUrUnlTYkS/PhBfSj7MZAzM1Fz5/I6ypkNHmpMJMSH5x5AfpImaAf4g1u1gBkG7bUK2lmA6B2YUfpnACmq2x/2vc4NVbdUKJIKIHixSsXBfxz4gqWMXLbhn/UBZw4DyDI1tCv1zdGPPt3/JGUGtjWjsZ5DbRbnU9Ko3kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426529; c=relaxed/simple;
	bh=/RrsMGJVFzO4lIWG4KeNCzOLrC+x9LR/jZfLf+XMhnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxCu+iRSEcVnlJ1dfVeqR+Bu7IfNp2AVE3iNPoBJLI5ErPZ4TauJoJYT8FovnIUtyMUHF2WZPg/2swhSEJ6N9A8onJrIaDLTKu0+x51FNrnVS2Wk9grfROop8AiRZvvQjh8O+Asp7T2Zh2mxG28Z82CnA80LU/zP7J50k+UI0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTbAbcya; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86b46c4831so698065466b.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2024 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725426526; x=1726031326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avL8mOO62vjNFMqqKGoxcJZeevfPDxVOotwDzcMmWcw=;
        b=jTbAbcyaHaYGbSUAokAA9DF5O0LP7eCjx3GB/6p5Ve8HRzQSLaoGwu7lxGMpqZhoIx
         2Z/kr+NOa+c5oqlT4uIMn/o2ydpyLzQZdN5Q0cYir0vE5/nu64jK7hiqzQI5q7vvBtuT
         jdBG3f2MXRMvGaVnmW1sRz/2BPt9VmlwV0/25ZpoBHnuisqmxQUmcrzVN9fbzd1Rs9ba
         MSTgelwWS0yuHRf97W/zEea2Chzcdj2+X9a3YPeKLg4VRTBDQWkvaVU0TkVg/SHx2W86
         9L+3bzjQj6iK/J/FUde494rGG3uwU0CW1aEY8i8Ec7Er2ZYdIEhCSKW6o+aaaUxtBnjB
         TZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426526; x=1726031326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avL8mOO62vjNFMqqKGoxcJZeevfPDxVOotwDzcMmWcw=;
        b=w6MJX/khGHPUHs+gIhHG+E8sY8IfKaH6stw28kTYzHhJzG9Gp2XQIkaw+QDTABNuev
         x8dythMsrv8XZ7IQVll1sDPwjENSPyM4VaARE0qcoO+N+qoCelryruvYWV34pPkEPy9L
         JSOLyBJwaqdUw6i3fqTPaCsCQ1SfmxMVAcXeAhccQDScsjamplkZAf8jpi1AEWKUzjzL
         +YV9uy9L129TsB3vD/SG0Yb6t81FRLgB8GKMutHZVn/IaeTJQ36PuHahKZIJeYeosNHd
         j24x0tKm3H0Jczy67FNKVHyuGQmgR9LzrJwK4zad/8FXuC6Hq9sVGPQPnrLMkQ2AcvQT
         O25A==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9AAZ1xWPBf7NkBGcxk2SGr7eUVtEVFg7rm6quV8IpQyVY2rTelZwUDEYSH57HjZKhHVBHlJu45bWKxeTOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsJH8y8r0wKboBhvA4dKkaWPtKzQ+Q0THm2HgpNGJLPR2P98A
	MkTJg0Y7HaxJrgz990ulqPKlQK+k+eeSJ+CCHptwvqjS4ZFZzUV983rgo3dPlkunbKk5DG7p+cj
	JC4VJHTWfuJgXAZckpfSNPbgwDJ0=
X-Google-Smtp-Source: AGHT+IGXqNAJ9aXtoywYwJuAXbJLTkD+p2ntac6RUSI7KpEbTsKXg98pZgtoHmMOAFLsPuTQh+j+qO63AixkNGi38uw=
X-Received: by 2002:a17:907:12cd:b0:a89:f171:8dc0 with SMTP id
 a640c23a62f3a-a89f171926fmr477284566b.11.1725426526087; Tue, 03 Sep 2024
 22:08:46 -0700 (PDT)
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
In-Reply-To: <LO0P123MB4057552A6B51BCC3C75A0013D6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Wed, 4 Sep 2024 07:08:35 +0200
Message-ID: <CAFED-jnkQRV-_cfSuuOG5YxhA0O6Pxw7GyNyZ3AYoC+-Txn5yw@mail.gmail.com>
Subject: Re: wcn7850 issues
To: david Atkins <david@3adesign.co.uk>
Cc: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 3 wrz 2024 o 23:15 david Atkins <david@3adesign.co.uk> napisa=C5=82(a)=
:
>
> > > wt., 3 wrz 2024 o 09:47 Kalle Valo <kvalo@kernel.org> napisa=C5=82(a)=
:
> > >>
> > >> + linux-wireless
> > >>
> > >> david Atkins <david@3adesign.co.uk> writes:
> > >>
> > >> > ...
> > >> >> >>>         Ext Tag: EHT Operation (802.11be D3.0)
> > >> >> >>>             Ext Tag length: 8 (Tag len: 9)
> > >> >> >>>             Ext Tag Number: EHT Operation (802.11be D3.0) (10=
6)
> > >> >> >>>             EHT Operation Parameters: 0x01, EHT Operation
> > >> >> >>> Information
> > >> >> Present
> > >> >> >>>                 .... ...1 =3D EHT Operation Information Prese=
nt: True
> > >> >> >>>                 .... ..0. =3D Disabled Subchannel Bitmap Pres=
ent: False
> > >> >> >>>                 .... .0.. =3D EHT Default PE Duration: False
> > >> >> >>>                 .... 0... =3D Group Addressed BU Indication L=
imit: False
> > >> >> >>>                 ..00 .... =3D Group Addressed BU Indication E=
xponent: 0
> > >> >> >>>                 00.. .... =3D Reserved: 0x0
> > >> >> >>>             Basic EHT-MCS And Nss Set: 0x44444444
> > >> >> >>>             Control: 0x02, Channel Width: 80 MHz EHT BSS band=
width
> > >> >> >>>                 .... .010 =3D Channel Width: 80 MHz EHT BSS b=
andwidth (2)
> > >> >> >>>                 0000 0... =3D Reserved: 0x00
> > >> >> >>>
> > >> >> >>> Are you saying the ath12k driver does not support these
> > >> >> >>> features? If not can
> > >> >> >> you clarify the issue so I can raise with the AP team.
> > >> >> >>>
> > >> >> >> ath12k/WCN7850 supports EHT, but with NSS only 2. Here the AP
> > >> >> >> requires NSS to be no less than 4, that is why EHT connection =
was
> > disabled.
> > >> >> >
> > >> >> > Which field is requiring NSS of 4, I'm only seeing a maximum of
> > >> >> > 4, the
> > >> >> Qualcomm windows driver will connect to the same AP, we had
> > >> >> assumed that that ath12k would do the same.
> > >> >> Basic EHT-MCS And Nss Set: 0x44444444
> > >> >
> > >> > My understanding of the spec is that there are maximum numbers of
> > >> > streams though, are you saying the AP has to advertise 0x22222222
> > >> > which would then prevent a 4x4 client (say an extender) from
> > >> > connecting with 4 streams? I note that the Qualcomm windows driver
> > >> > for Hamilton works with the AP and an Intel BE200 also works both
> > >> > of which will be in at most 2x2
> > >>
> > >> Did you test Intel BE200 with the Windows driver? Johannes mentioned
> > >> that ieee80211_verify_sta_eht_mcs_support() in mac80211 checks this
> > >> so I would assume that iwlwifi also behaves like ath12k.
> > >
> > > Yes, this is AP issue - hostapd fix required - advertise 0x11111 ...
> > > In other case station  < 4nss will drop to HE only.
> >
> > Thanks. And Johannes pointed out that you had even discussed about this
> > before:
> >
> > https://lore.kernel.org/linux-wireless/CAFED-jk8pJheJEViESnE54f-
> > K+JgRMiWoiCSa0GBt=3DRKaCn7sw@mail.gmail.com/
> >
>
> So this
>
> Basic EHT-MCS And Nss Set: 0x44444444
>
> Should be 0x11111111 ? and it defines the minimum number of streams neede=
d to connect?
>
> This the defines the max streams ?
>
>             Supported EHT-MCS and NSS Set
>                 EHT-MCS Map (BW <=3D 80MHz): 0x444444
>                     .... .... .... .... .... 0100 =3D Rx Max Nss That Sup=
ports EHT-MCS 0-9: 4
>                     .... .... .... .... 0100 .... =3D Tx Max Nss That Sup=
ports EHT-MCS 0-9: 4
>                     .... .... .... 0100 .... .... =3D Rx Max Nss That Sup=
ports EHT-MCS 10-11: 4
>                     .... .... 0100 .... .... .... =3D Tx Max Nss That Sup=
ports EHT-MCS 10-11: 4
>                     .... 0100 .... .... .... .... =3D Rx Max Nss That Sup=
ports EHT-MCS 12-13: 4
>                     0100 .... .... .... .... .... =3D Tx Max Nss That Sup=
ports EHT-MCS 12-13: 4
>
You mix different things:

Supported EHT-MCS and NSS set  vs Basic EHT-MCS And Nss Set

