Return-Path: <linux-wireless+bounces-12377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321579699A2
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 11:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF624288B71
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B21AD242;
	Tue,  3 Sep 2024 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtlJufEw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B21A0BC6
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357470; cv=none; b=pQ0l7vEjtgPU6txNWLhKP1eDQrrKOqe1FjDqZmT0eUgL3gU4aA1o3hECBNV2ZzpIvxzsVWADZscncJJIWbCBnivsP/X3X6PaVeAjLJFVKv0iJ08RtotrUOz6yjehSv+KFOWypuR2J5rcsLrHMQZVUuxeggs9MO13ZX5m0n48rIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357470; c=relaxed/simple;
	bh=BYUKA5fiS99KEtxieh0O/08FrQm16PBeKf/VVMY2Ck8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPCiCJQW1FmKcKnS06iVGrx8NpGwOCL1Djy8wfUyjrI/0SUf4bd7TuXFhz6BndEMVBihCz7wUjfZj+GO+keSW5tn/wiRGhUUemXxvaalWrdtJG18kXZgWDrIXUxBW5k92o3VKRauMQHf8Y3Y1EJXmLJqd1xOfEQnc0NHi58zfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtlJufEw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a83597ce5beso816494566b.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2024 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725357467; x=1725962267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB8MDv5FaCjwyAMLsDObbG/PIMHmXizL+8dnJxb9JjM=;
        b=MtlJufEwaoSRjPF3dVQUNSbvj6j+j6W5m1i3w47yqNgbUrbVZASJM4rGxh+NtVVVdF
         zNzKoFitBuJ8xuufZukgxRvwSd6WdgeHrFKuSOf9gGaOZG+jzmmqy6rRfmsysIbz+rVC
         O9AC+CmB+DmyTYfUpd9ZgiNZmnhphn08J/oLWBDk3930doiaY8LomV3FRH+R6xwPxHYV
         ICBTC2SYCKR7owaWCRy7EGVpGhmJhnGjbvXPWX8+nr1CThcosiqGHDJuq7Xr9GHU2yYf
         /XeateqqBS+YN4mFdI5kN9MM6vgYkIFpeg2HRa+CqtyKiEglqfrhWDhWQWlxP23cEwhv
         h15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725357467; x=1725962267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xB8MDv5FaCjwyAMLsDObbG/PIMHmXizL+8dnJxb9JjM=;
        b=tc0HRHnNfCfQ8atQNoHNVF9Q4ResuX5JeKYX/+fAUhM79zbpmTxe3++Ob5A+YDMknP
         HPfmNKGk7Sra502XRtu00phh9TRXfVVtuXG60gAoP4TTCiY2NFx4rgOi2JKP2fV4i2DE
         L9E3twxjJkSS23TcUEAfOU3eenSL35F/V69hwsf4piRfbaJrbY4X7HEFgW4O8xBZodQv
         qY1/p4amNE9BPtwZUtpvnHCa+4+ALd4GLq/SPCjQxMhgnIN6/1hKMpgR6zVYSFAtyrQP
         wOrDRjY080/OIwpSYQzdTNVdZX3yTMIlC8u8VoScZnubWWY0wL5Lbo2zSXYZ0O89C3EN
         wfxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSL00Sm/OnUHnyv+GCKnYbcWrDe77o0WPTqrLyZkZEoPffh3wJT0kdK4lsQa6uetFf6MOnkXXeJgy0XgdLCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKm/LzM9y3OCBqVPDq8gNIOqSc9jefSLGi2HdEkstIh47tER+l
	25PEeZAwiknupb2sxzIm3fZ40oF05a//v0s3FOA5tr/sB61lOzJSj0FkTbY/g2Ht5hJQrHrZ9ZX
	69QkWgftT63AuAJgn6UiNlhRYwLc=
X-Google-Smtp-Source: AGHT+IFTFQv+73A7UbwEcb7IHwWlmFCklSOW7tm0esfMiQyxC0RVc3Th8S47OQCM675imQn77CvwVG+qmKDu4OON8qk=
X-Received: by 2002:a17:907:968e:b0:a86:8ef6:dc3d with SMTP id
 a640c23a62f3a-a89823c9d42mr1576709266b.8.1725357466382; Tue, 03 Sep 2024
 02:57:46 -0700 (PDT)
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
 <871q21kwk8.fsf@kernel.org>
In-Reply-To: <871q21kwk8.fsf@kernel.org>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Tue, 3 Sep 2024 11:57:35 +0200
Message-ID: <CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
Subject: Re: wcn7850 issues
To: Kalle Valo <kvalo@kernel.org>
Cc: david Atkins <david@3adesign.co.uk>, Baochen Qiang <quic_bqiang@quicinc.com>, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 3 wrz 2024 o 09:47 Kalle Valo <kvalo@kernel.org> napisa=C5=82(a):
>
> + linux-wireless
>
> david Atkins <david@3adesign.co.uk> writes:
>
> > ...
> >> >>>         Ext Tag: EHT Operation (802.11be D3.0)
> >> >>>             Ext Tag length: 8 (Tag len: 9)
> >> >>>             Ext Tag Number: EHT Operation (802.11be D3.0) (106)
> >> >>>             EHT Operation Parameters: 0x01, EHT Operation Informat=
ion
> >> Present
> >> >>>                 .... ...1 =3D EHT Operation Information Present: T=
rue
> >> >>>                 .... ..0. =3D Disabled Subchannel Bitmap Present: =
False
> >> >>>                 .... .0.. =3D EHT Default PE Duration: False
> >> >>>                 .... 0... =3D Group Addressed BU Indication Limit:=
 False
> >> >>>                 ..00 .... =3D Group Addressed BU Indication Expone=
nt: 0
> >> >>>                 00.. .... =3D Reserved: 0x0
> >> >>>             Basic EHT-MCS And Nss Set: 0x44444444
> >> >>>             Control: 0x02, Channel Width: 80 MHz EHT BSS bandwidth
> >> >>>                 .... .010 =3D Channel Width: 80 MHz EHT BSS bandwi=
dth (2)
> >> >>>                 0000 0... =3D Reserved: 0x00
> >> >>>
> >> >>> Are you saying the ath12k driver does not support these features? =
If
> >> >>> not can
> >> >> you clarify the issue so I can raise with the AP team.
> >> >>>
> >> >> ath12k/WCN7850 supports EHT, but with NSS only 2. Here the AP
> >> >> requires NSS to be no less than 4, that is why EHT connection was d=
isabled.
> >> >
> >> > Which field is requiring NSS of 4, I'm only seeing a maximum of 4, t=
he
> >> Qualcomm windows driver will connect to the same AP, we had assumed th=
at
> >> that ath12k would do the same.
> >> Basic EHT-MCS And Nss Set: 0x44444444
> >
> > My understanding of the spec is that there are maximum numbers of
> > streams though, are you saying the AP has to advertise 0x22222222
> > which would then prevent a 4x4 client (say an extender) from
> > connecting with 4 streams? I note that the Qualcomm windows driver for
> > Hamilton works with the AP and an Intel BE200 also works both of which
> > will be in at most 2x2
>
> Did you test Intel BE200 with the Windows driver? Johannes mentioned
> that ieee80211_verify_sta_eht_mcs_support() in mac80211 checks this so I
> would assume that iwlwifi also behaves like ath12k.
>

Yes, this is AP issue - hostapd fix required - advertise 0x11111 ...
In other case station  < 4nss will drop to HE only.

BR
Janusz

