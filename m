Return-Path: <linux-wireless+bounces-17114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE6A02F60
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 19:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1401885306
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37E1DF27C;
	Mon,  6 Jan 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9JtwSRg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1E1DEFE8;
	Mon,  6 Jan 2025 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186497; cv=none; b=p/m+t+CamDYii04ECzke1yrxZlWkHH/NFTle4amHwG2eU+7PvPyRd9U6x4P2XreO+Rw3XLPh04esY5n9kPGL6QPM9T/ZtNNsh5Cm/Va2MkOwYDSVirix0H7ikVSBTrpVnn/Ihesz4O/V5cE8pQnPXC+2p2WpQqLENkyOt5mUugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186497; c=relaxed/simple;
	bh=25zFiJ9WjdEaOSKemZTpzQCKjyijqwYYUDaKfAMPw0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckS9Zi7tgaaMXbmz13J3S4aj0EmscgODMPJ6TVariiWNmbWfaovPCugqI3hFwfL4f69w2Af63TFjrKMAEcdd3PsQiCq3yunBUUEot3GyAOepv9JRjoy05vRM7//f8DBmDRI5HUToWQWV2yA+CvxlOG66Fyg23XTAnaxODyjr5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9JtwSRg; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29fe83208a4so7031194fac.0;
        Mon, 06 Jan 2025 10:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736186491; x=1736791291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2RF1hIS1QqUJA0GJuODmz1eNECfJRbd58h+IrA3gWc=;
        b=U9JtwSRgEVwRj0VRE7ftVXMcY5O/Zn2GeHcwnTnsJq9EetHbzTSiDVl88fedZCcd/4
         4mhreEUF0o9TuJhm1zwroaor8HEH36h/kBw/jjB4+nBqWFLffeajESsn4A7ZU465kHc4
         XQL3gnogxV/HDlasLLopdd6b41rqz4ZPkTH+HfKYGc0S/siZ1uSYAUBMSzrwsG8u9RF/
         KlH4rKixmHd9wloFRdEdCKzYP1YjvlUqZo+pTV4kp2DmD088cQPNnO3y7h+T3ClRvIyd
         rsXTpE0URGNH0vlUY+X8xcF4RDdl1JYOUdwjoHy8FNsjHGmcLyWC2gCS8mcDOO86rGSp
         wNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736186491; x=1736791291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2RF1hIS1QqUJA0GJuODmz1eNECfJRbd58h+IrA3gWc=;
        b=ZoMDY3HGdwf5JI9tTUVJBUHB0CoVYQJ74UCvT4FjdX+3+iCebrHPVXFnbj+ha61sWZ
         hSQvzdgSsmPeC8U6x/oCHxf6auuYNJ3NP0ESgb89hupvtMYS6/NKPtpFY7Nn160kmw4t
         v40cIT3eNKkQyjVP5QEprw3QmvGYwps9cqoDDL09WBzcavmeGvHh4SvQjmBhBoEx5Z/0
         9Td/SxOm63LaAZUn0CBg5LP3mHpv72RHuo4FhZR5vGZ6lfNwMngzcK8nc4I7D12O93rK
         EmeRMtsfx+uCutJXuxdWiJwVY5JHf6yihzoywbTcEJu1Ffbe9Pbx0GpMDplB7Kt0FEjW
         8J5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5A6hJnYZoN+EzVQg7JkvWPE7eROkkW6UGE8GK9pzvLUkhMAucr9CHumzlIsP1bQ8tDNuuLdTWAAoO8pEr1Q==@vger.kernel.org, AJvYcCWKrSP+XRWuoHYrdB+4GBbCPWr70iBu238ew0JZm848SNLkB3s5n7Jk61kkXr5B88kO0Uv+vEI+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzec7RERtdPFV7gHziJTrCAnb+BHNBzWHxsMTIndwLZJGokLgOx
	QeGyrpUImcikNoDoTpAXao7qDOFJjSl/y8EElrzzAs/17aNfKlGEzBkRLuwrP4OwnzqmUE8zUYE
	kkk0UMBXrYQ+e05zg/2nVaNXriC6HBA==
X-Gm-Gg: ASbGnctpC6qdisVTtj6zgs+3V1AjI0ECmhjt6PBz3E8BWTaFZQ7rKhrTZ9deo7rL1lN
	04xQiFOghgSK3lqW1Tn8kc4ctrY/RZxwfZRAF1s8yysWNANjKWPeHfT2KdsSOv8GH8OPRGP+K
X-Google-Smtp-Source: AGHT+IHMMQMkhdcjtXckGaDXHbmnwQmQ9zOSfOOKxy4QAUALfxddplOM2flNcf+B+K19MWN4bfFtInVgfHk9UzabP60=
X-Received: by 2002:a05:6871:53c6:b0:29f:c94b:3a06 with SMTP id
 586e51a60fabf-2a9eaaa6de6mr143701fac.8.1736186490022; Mon, 06 Jan 2025
 10:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106135434.35936-1-fiona.klute@gmx.de>
In-Reply-To: <20250106135434.35936-1-fiona.klute@gmx.de>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 6 Jan 2025 10:01:03 -0800
Message-ID: <CA+E=qVfEdGjDQOftmGfx4e+iw0an6x+ff=Eg_EjRkm-98Vw2Xg@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: sdio: Fix disconnection after beacon loss
To: Fiona Klute <fiona.klute@gmx.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Bitterblue Smith <rtl8821cerfe2@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:54=E2=80=AFAM Fiona Klute <fiona.klute@gmx.de> wro=
te:
>
> This is the equivalent of 28818b4d871bc93cc4f5c7c7d7c526a6a096c09c
> "wifi: rtw88: usb: Fix disconnection after beacon loss" for SDIO
> chips. Tested on Pinephone (RTL8723CS), random disconnections became
> rare, instead of a frequent nuisance.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com> # Tested on Pinebook

> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index 799230eb5f1..e024061bdbf 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -1192,6 +1192,8 @@ static void rtw_sdio_indicate_tx_status(struct rtw_=
dev *rtwdev,
>         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
>         struct ieee80211_hw *hw =3D rtwdev->hw;
>
> +       skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
> +
>         /* enqueue to wait for tx report */
>         if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
>                 rtw_tx_report_enqueue(rtwdev, skb, tx_data->sn);
> --
> 2.47.1
>

