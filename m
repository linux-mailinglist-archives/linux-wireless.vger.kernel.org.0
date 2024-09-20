Return-Path: <linux-wireless+bounces-13043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01AF97D197
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E391F1C21FB6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55976291E;
	Fri, 20 Sep 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY6r1xny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A020ED
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816555; cv=none; b=evQyZqnGEzUTxD07wIATEVM2WposVkT9ABpkPhNLYWXWqW6b3pmHgRmbgCKjvW7YyTA5CQw5e/ASWTCn8xi08bCSqrdXboQppryXmgPc0Y8AdEqi991Lf81+GsKnHxLdpMBSQ55uLUvw64mTI1zBE9h1+T8Q1wlvuBDVUZSVHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816555; c=relaxed/simple;
	bh=FPGQ8E8HZYTDOC+9uMySrfs5joLN2aVSHVgH85YYIv0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fGGX3gubJus5m8dt9YJr8GCCuNnB/Wy8te+VPKMEyA4HpFYqjUc+ofqvQnuGRk3H2J7Q490Ct/yyo3sTyWEnqKY1E18S98ysTPiwvdNFBcvdjWKbLLQVZ/FBNpbGZA5MFLmfO+q982hdBkspgDXwZ1sIaV1Q5my/XhuU6JK5Eog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY6r1xny; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c180d123so1048178f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726816552; x=1727421352; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6izsneD2lGdAkFmb0KW0msuxjusdUXdIU29WvalOzw=;
        b=CY6r1xnygaXFp+m9LdXYEsdGEtYZABDmCifGZI9uV7sKtAksPbGpaltX5yLUG9AsUJ
         ko05MZ9oNjuGahCN6rjkYzYrZRdbXYZZuNqCuKQNtglDTk+n8v4oFmNen7EJpJrrWdZU
         Q8XX6kmDI9LCAdvERakUT2FcoEpWMo+b9EyaxNjPAjmPooZoxep/x/6/6q5kdY2m8qr0
         /rhVgHUTJwJHoZX9/v3pa0spcNsaMXjFsjyUfXCe15L88ICvNXPmtos8H1WibovDivqm
         Y/PPg6PgsoJDvPpebk7NwxnS6zHKuQZAT0eRSMu0rfD5caZqJDN7qCJUQ6rjzaV/X3M+
         Ftlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726816552; x=1727421352;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6izsneD2lGdAkFmb0KW0msuxjusdUXdIU29WvalOzw=;
        b=Xw/pN0V8O1Luh97SMmb7QYZulSTXBQ038+mkFaEfwGzmn8NAjNmILVi8bonW59pQfa
         anB/LqadY2t8zHKLxxjeVpZHxWx8RAL/dd/tKYw3SNRRzW+QU0qcPcki6CIgU2ThI4Zj
         Ymh2kSvKGQS8i9wVFxanWfDqyWUe8jO3+oeS7eeX5p8T8kRaUj8fDrk1ZyvKv/x4OFCR
         a8UGrw/gw/X8LhdZ9lTHD7sZ2O3MMUxqrrCMJ/nz5of5e/8NjFvxxSJo7rUYiv1auSw8
         WmoYYua+fYNe8VyVLYPCz76ESC8q/0jrW31chbFPUunnHwGxVfxDztvV7W9i2eiroIzv
         ItIg==
X-Forwarded-Encrypted: i=1; AJvYcCXfp1UNKf6yG8yndFgq03VfVzuGqNactkP4KYDRJFsx8uqejaCmuztHunUu5q4auz4JQpe+c1255WUQqV5u/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbQaHvxCLqyvY29by2OIaUnfJZz1gNtwjcWd08eP8gSXg1aEZ
	GLBDXJDMifAKaeTat5MUfFkYjXHqONJ1rNp3/pCb1rwroIgXbcND
X-Google-Smtp-Source: AGHT+IGKePSXh6HEhx5zysP1kcrf+8Jrq/9dNUeumETuu0ZNZwjbd+E+88QpLrjwhofA0h7AUHaUcw==
X-Received: by 2002:a5d:434b:0:b0:374:b6f4:d8d1 with SMTP id ffacd0b85a97d-37a4226543amr847180f8f.13.1726816551524;
        Fri, 20 Sep 2024 00:15:51 -0700 (PDT)
Received: from localhost ([2a01:e0a:0:2100:375e:67e3:3e7b:d99d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afe38e6sm14313365e9.34.2024.09.20.00.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 00:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 09:15:50 +0200
Message-Id: <D4AXDNUEYII0.P1ZRMOBR4EPS@gmail.com>
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 <quic_murugana@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Santhosh Ramesh" <quic_santrame@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <D41LUTO0MIC3.12475D2J3VNX3@gmail.com>
 <93d580b4-cf7a-471f-8f3a-673d456f726f@quicinc.com>
 <51afbe69-e770-0344-6ca0-0fe5cd721d2d@quicinc.com>
In-Reply-To: <51afbe69-e770-0344-6ca0-0fe5cd721d2d@quicinc.com>

On Fri Sep 20, 2024 at 6:43 AM CEST, Santhosh Ramesh wrote:
[...]
> >=20
> >> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wirel=
ess/ath/ath12k/mac.c
> >> index 137394c36460..6d7a005d83b4 100644
> >> --- a/drivers/net/wireless/ath/ath12k/mac.c
> >> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> >> @@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif =
*arvif,
> >>  							chandef->chan->band,
> >>  							arvif->vif->type);
> >>  	arg.min_power =3D 0;
> >> -	arg.max_power =3D chandef->chan->max_power * 2;
> >> -	arg.max_reg_power =3D chandef->chan->max_reg_power * 2;
> >> -	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain * 2;
> >> +	arg.max_power =3D chandef->chan->max_power;
> >> +	arg.max_reg_power =3D chandef->chan->max_reg_power;
> >> +	arg.max_antenna_gain =3D chandef->chan->max_antenna_gain;
> >> =20
> >=20
> > For what it's worth, I already got a similar patch from QCA a few month=
 ago, and
> > it fixed some tx power problems when scanning so I know there is truth =
in this.
> >=20
> >>  	arg.pref_tx_streams =3D ar->num_tx_chains;
> >>  	arg.pref_rx_streams =3D ar->num_rx_chains;
> >>
> >> base-commit: 903aaf66edc97dd5b9e3118d19677291051a9c40
> >=20
> > But there also was more in the patch:
> >=20
> > diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wirele=
ss/ath/ath12k/wmi.c
> > index a97e1399eeed..87e3ae49afa5 100644
> > --- a/drivers/net/wireless/ath/ath12k/wmi.c
> > +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> > @@ -2563,6 +2563,8 @@ int ath12k_wmi_send_scan_chan_list_cmd(struct ath=
12k *ar,
> >  						  WMI_CHAN_REG_INFO1_REG_CLS);
> >  			*reg2 |=3D le32_encode_bits(channel_arg->antennamax,
> >  						  WMI_CHAN_REG_INFO2_ANT_MAX);
> > +			*reg2 |=3D le32_encode_bits(channel_arg->maxregpower,
> > +						  WMI_CHAN_REG_INFO2_MAX_TX_PWR);
> > =20
> >  			ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
> >  				   "WMI chan scan list chan[%d] =3D %u, chan_info->info %8x\n",
> >=20
> > It seems that ath11k has a similar piece of code in the equivalent func=
tion
> > ath11k_wmi_send_scan_chan_list_cmd . Isn't this needed ?
>
> This change is in a separate patch, which will be sent for public review =
soon.

OK

>
> >=20
> > Also I see that in ath12k/reg.c in ath12k_reg_update_chan_list we also =
send to
> > the firmware:
> > 			ch->maxpower =3D channel->max_power * 2;
> > 			ch->maxregpower =3D channel->max_reg_power * 2;
> > 			ch->antennamax =3D channel->max_antenna_gain * 2;
> >=20
> > As it is in a different wmi message, I guess the units are different. 0=
.5 dBm
> > increment in struct ath12k_wmi_channel_arg right ? Or should we remove =
the '*2'
> >=20
>
> Yes, the firmware expects these values in 0.5 dBm increments, so we multi=
ply=20
> them by 2 in the ath12k_reg_update_chan_list function.
Good

Then good news this gets mainlined by the way, but it's a shame it takes th=
is
long (like 10 months or so...)

Reviewed-by: Nicolas Escande <nico.escande@gmail.com>

