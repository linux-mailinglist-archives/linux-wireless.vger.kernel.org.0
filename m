Return-Path: <linux-wireless+bounces-21947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA8CA99F83
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 05:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2EC3B01F9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 03:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00781741;
	Thu, 24 Apr 2025 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULYR+vUf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3F9460;
	Thu, 24 Apr 2025 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465033; cv=none; b=sC9W/1H/AfHgJwA3LuvHzjoydOj0sXnSZujD5s6d6rSS3Wy+z53etcyzp0hllsUtqKidoYcu+c4bvCdvTczwHAig1FkfD6nSN01Y36vBaFf870kqw3I+gXJ5DCwaN9m9XaxYHA2L1YFra1QXkZ1AvlKLTk37p1gySPGZweptRcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465033; c=relaxed/simple;
	bh=P7IDOSDSeq2YXVOxTkIixmo3fIAp2ltZ79X4aODDyuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg0vjFzNhlY/h2fGxYAsOYOQNtpL4CA47SUr1v43C2nbhUwh+GsFdyY41BPxlpsYfUeHOLaXpE5ifXrGKF+IeBBOqwUSoIJP1iK9D0E2nI8YCyX4zexlsUTFAJlC9fYLbpWkov2zQdBRxKEBCnXWNZ2zRD3Ltn4IBuaHwASn5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULYR+vUf; arc=none smtp.client-ip=209.85.208.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-30db1bc464dso6146421fa.0;
        Wed, 23 Apr 2025 20:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745465029; x=1746069829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm6fgchcfVrIoTbYF8HjVQc55WI83UqWvrYwf6Qmcoo=;
        b=ULYR+vUfCIFnTcmTch+fdzhwtxE+pVxMT6qkSuV/OvGllg1wvbjERtqiR2g9NKxofk
         ZMdSyfXnCWaLwLHw9e9JN8YW8maThw6Uf2RIrpsY8lBBxWgauGvzdWxXI1/ctYjP79qh
         wu4j1WRJPy1NuWyM2D3rqgkxbkGwMpGHjY9lVzXFEAELvm0l3gTmbd4NpQ6BpQJj6qnG
         kvbOn2eBZVY+wtTY+ceebJGW156btGn4G5ayf4gJO5Et//FnArn4tB6CMQiDShu7YHW8
         DwmwKPvBBVJpEZDbrKyTw755lJsodrQ9kC5SlS4z6/pg71RvOtjfYOVwFXpF5u8/cRqa
         xVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745465029; x=1746069829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm6fgchcfVrIoTbYF8HjVQc55WI83UqWvrYwf6Qmcoo=;
        b=Yu1/hd4Ob8n0AsHkj01mhXNFdurLiG0wfi+VOXKkbOmboW/32LfRFxuoAC3iPio9Ey
         /GmDQNiHo6NfxyBcLCRinT0SpcBxMSYQlvzC2mnE6u8MR/jH8UaQwnFQBEB6UkKmcZ6I
         K6yxY1i4+USVe/kNLGF+P0FBOOO9NTf88r5vlZOfc/X0R8874lgXEPpxskFOowYmGfXQ
         zZS9wnz22w6i0wKgce+pXwFJlGHhgZAWcruPy/2Yg904fhLPMxNWmGgDtNnJO+UXo4YG
         vIOYMcimaMsI+9mPu/yCqhQ88OrqHmHw/eiF8KvjdRZihgGEFQH4aZoP7th9m8acmurH
         Pwkw==
X-Forwarded-Encrypted: i=1; AJvYcCUDoaTkwg/uK1FpZy9UC3UPL2qrF0uid7Z4ALDJs/7LvJk26j0Z+uC5E4a8e1pv6eWh+rGE5Qk+cwzJYvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGd/u6gIcu8q/zG1J7xV+yi+rQNRl1xjHRfttvNnBCxrJ4yRU
	pisvYdiy41QZgHQRkeAEdIuHMPpbXPqQqNZRb4jIiMZvdWLUcBfLK9jlf/vIyO4gQXrJm4pkcdD
	/XAIT5zjLNVYj0O7ZkN3HbEJ/C6U=
X-Gm-Gg: ASbGncvq90s3r2bqPzdS8/fYKpfpdCMNqnYlCNC82HeVI2SlKGs2y0MWkZ7UWapvLSf
	erg1lJqV6/NORB0mm4Q8RWkLxTCe41/QWbt8TLJo3ERSErcEmLWMukOPEpPw6iOldCGw6S/wnK+
	kvZ8xhumXoN7wEh79nRmjdSxDVyVGvEom5
X-Google-Smtp-Source: AGHT+IHpA2IlBQgHwPHIfvZ0vrqa0XeHqBHX/F/8jy+/sFcXwLmevs5nk9hDPwg0SpLGxpuTEIuCYu/XuIPdjNdHMlE=
X-Received: by 2002:a05:651c:1603:b0:30b:c96a:775 with SMTP id
 38308e7fff4ca-3179e5e3f4amr2733571fa.14.1745465029230; Wed, 23 Apr 2025
 20:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407032349.83360-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20250407032349.83360-1-bsdhenrymartin@gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Thu, 24 Apr 2025 11:23:39 +0800
X-Gm-Features: ATxdqUEHu3299Lh20GzTqgUT9Pu1Hxw92kjaOjVxuPDzebfVP7Ppk-ZRHXIQRRQ
Message-ID: <CAEnQdOrroDzrz+Y4ch8EGTP6T798-zwLpMJi5eNaW_S+Ew+BtQ@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: mt76: mt7996: Fix null-ptr-deref in mt7996_mmio_wed_init()
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, chui-hao.chiu@mediatek.com, 
	bsdhenrymartin@gmail.com, rex.lu@mediatek.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I=E2=80=99d like to kindly follow up on my previous patch submission to che=
ck if there
are any additional feedback or suggestions for improvement. If there are
further changes needed, I=E2=80=99ll be happy to address them and send a v3=
.

Please let me know if you have any comments. Thanks for your time and revie=
w!

Best regards,

Henry Martin <bsdhenrymartin@gmail.com> =E4=BA=8E2025=E5=B9=B44=E6=9C=887=
=E6=97=A5=E5=91=A8=E4=B8=80 11:24=E5=86=99=E9=81=93=EF=BC=9A
>
> devm_ioremap() returns NULL on error. Currently, mt7996_mmio_wed_init()
> does not check for this case, which results in a NULL pointer
> dereference.
>
> Prevent null pointer dereference in mt7996_mmio_wed_init()
>
> Fixes: 83eafc9251d6 ("wifi: mt76: mt7996: add wed tx support")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> V1 -> V2: Add a blank after the check and correct the summary.
>
>  drivers/net/wireless/mediatek/mt76/mt7996/mmio.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/mmio.c
> index 13b188e281bd..af9169030bad 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
> @@ -323,6 +323,9 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void=
 *pdev_ptr,
>         wed->wlan.base =3D devm_ioremap(dev->mt76.dev,
>                                       pci_resource_start(pci_dev, 0),
>                                       pci_resource_len(pci_dev, 0));
> +       if (!wed->wlan.base)
> +               return -ENOMEM;
> +
>         wed->wlan.phy_base =3D pci_resource_start(pci_dev, 0);
>
>         if (hif2) {
> --
> 2.34.1
>

