Return-Path: <linux-wireless+bounces-16364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AC79F069E
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8FA282041
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275311AB52F;
	Fri, 13 Dec 2024 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP7cGcp3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB861AC892
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079375; cv=none; b=IAR1oPAjQd4oksFZiugxpDsQtEBgZZDi/Eisz1lLbsbyJSbCDDe583XPQYlmjVLMizLmG9kwAXRpJrQF4FolQh6cZBtRefFLLk0iNPlgngG0pQWxRfKL9lyXRq7PgFInXdzgEoThtJrXw9FBq9gM/1c/BCzA0nn2ZWhPw+/CsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079375; c=relaxed/simple;
	bh=rPIA282938bhxmtXC8OI2YuU1T7I6Cjavbu8TzwQmaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qur34I5LvJsnF+rGSP+Z1aGnl4zd2CKXZc0vYdDHYi74Oez2g2WM1wSnLWHMY5DWjy808ul0snqknRztsLzTjAmiOqpn/CgvEO3ZKaGDm8b7pzk+89meOl9nbAMR026Jp7GR8gWGMuT98sYyOEeOEzO5MJFLHeFg4nVEa7zCpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP7cGcp3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862d6d5765so946720f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 00:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734079371; x=1734684171; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9iFadcKV7NOuGMDoiou+96S+djlE3jUoskL0WXWoC0=;
        b=RP7cGcp3u4xUWfG1E8rpR6FxZEyxbPfdvXyfjAIo2+K0tFVOUXYaZ0z4t5BqbdOdVw
         idS+OwJdE2xEXRWOLpmo2DoQH/ExET4IB+NqSQXYpSp082doIOQjP9AAjKP1Uz+lylxO
         IqjV8Vv0B7ZtFmiB1Av1oeZkr/L3b8cSy+J0b8L/0eOVl1dt9Hmc6E721haX1LH04BYn
         VZC0A7bjHO5OEbnS583fC6+BiiE7QKTascuVkvbc10HNxQv7fvzr09wpijdZmmkSzqYB
         SFJgyuDvK5/gMYUJD3DaF2GkP/fUmoKqVks4Rp+kJF//+T5G1IxxyFyADYl4a/DB9+wS
         xANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734079371; x=1734684171;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y9iFadcKV7NOuGMDoiou+96S+djlE3jUoskL0WXWoC0=;
        b=wcfUmCi1gJRk7eGloN89m6OeJSY39vDxhsrp4CI8hV4gAij19VdnFbWwweTNEQ8hJx
         KUMkqcEI/ZXcAmM+o0/v4wWEdhjPiasszbWXfXVNM23QQP4M6D6UWOAvA0rvSLF2qLYI
         IqH/xq9XILDGzi7ydtXJ+JMLG473SeGPHoW0XweYyeydqUG4BbtUzst8jKzBtrdAsw6k
         JzgirbNNpP+EJeVDqeDvSromqvI7CVDDqai0/EBnLTbqxL0z3MeYQQ55L2duRYWlXYKD
         Vs+jIxogZbv2Dc1F+LZ+F5UbIrQNNzv+6E2W4PPJ3E1BRQXdMMGGwyiikal7ogF+/S4e
         w4FA==
X-Forwarded-Encrypted: i=1; AJvYcCUUbg5ERZ/yLVUZaHhd8j5FIAZVW8iDcWtnx+iiIZuCf9hIVwQPzgOk4fbHUux8w9jKvHRdlnczP9IjeY62MA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7m+c3HQXtGYJlMq5WFMXcKMkN7Ds0EXCI9eDb0IgFCOzS8S9U
	0xHfk13gmugS9sA6w4hcYtCvK2NrpDp+iEMODvNI5N4UvPzXGDLS
X-Gm-Gg: ASbGnct3Xk6Rkq+mQFMJl7Qj54+z3rgjBQE13F6TlVnBezxTlTUbndAQ8vu2o7zcDZK
	xhktGh0QcbH2lzJb2nwzouCdRQME9vrn6pnNpoiU4CyHntVuNdF3gZe0bIK83MGmMF7EVFvQcZ6
	+sqbWcCzfeQ0AaDVGVbUtecW9yz/ljPNpm/J2kBZ0U+DWt7VmyWewrPqpEW70LbMH6qcn5lxieB
	h84IInD/rnCt5bpoGKu8XGT2+Ug20kn7RzuZ7J24NRnBAN7qqK822arpDxA2CPppKNyadZTBy4=
X-Google-Smtp-Source: AGHT+IHWsvo9dkmgwdOTmI63/EvBCpV3mLlUvHDKrTxRlil6MeXplgqo4OSHVVx8B/x/waUcP2yoPA==
X-Received: by 2002:a5d:5f8f:0:b0:385:e5d6:130c with SMTP id ffacd0b85a97d-3888e0bf8bcmr1027733f8f.51.1734079371282;
        Fri, 13 Dec 2024 00:42:51 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824c8a6esm6363509f8f.59.2024.12.13.00.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 00:42:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Dec 2024 09:42:50 +0100
Message-Id: <D6AFU1A3PRGK.1I5GCZJV2BQ14@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Santhosh Ramesh" <quic_santrame@quicinc.com>
Cc: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 <quic_murugana@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: fix tx power, max reg power update to
 firmware
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <D41LUTO0MIC3.12475D2J3VNX3@gmail.com>
 <93d580b4-cf7a-471f-8f3a-673d456f726f@quicinc.com>
 <51afbe69-e770-0344-6ca0-0fe5cd721d2d@quicinc.com>
In-Reply-To: <51afbe69-e770-0344-6ca0-0fe5cd721d2d@quicinc.com>

On Fri Sep 20, 2024 at 6:43 AM CEST, Santhosh Ramesh wrote:
> "Nicolas Escande" <nico.escande@gmail.com> writes:
[...]
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

Hey Santhosh,

Unless I'm mistaken (which is very much possible) I didn't see any patch po=
sted
to fix that. Weren't you guys supposed to have done it by now ?

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

Thanks

