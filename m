Return-Path: <linux-wireless+bounces-29598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A7CCAD889
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 16:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7F413010CF9
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 15:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B615CD7E;
	Mon,  8 Dec 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViFWu2vm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583C7082F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765206445; cv=none; b=hxDHIsTtlnn/yHeEYMN39ZOyM1tvqnut2OU9T4W2TZ68+Eq/z5IFg0QUp/lqjh0EDb3/hswA4diceVLjSZvwbGr3a+Mvu4wXtjF9QgXptaEjf4nfbw/IPj2qadXCLyuhuTrvdz2DDMfnY7kfO/KPqfA7q/o8Z/ED4YKG9SGwH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765206445; c=relaxed/simple;
	bh=0N8qr2tR/Jmwr9AJe8Nvx1QR8bewMp0AM660+pCBOHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/OqL122I63Cc7Q/1+m31kk2s5Me7jHMbnnHIdPNXzUM2PLwh7gywzN/ZR2VawR/mzqKS9UlidtlmXfC/gCvr3RTwR7YJkuzCBU1+Z6atNIypEgDMKcsQugTu3qq6z3027lxquKniwmfeY12q9WLpZh7O7thIcjALJ4VzKHy1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViFWu2vm; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6443bc360bdso3743871d50.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 07:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765206443; x=1765811243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koYXwoTEJsoPLyEPiz9nEdjQYdWChY6O9/DUrMalYaU=;
        b=ViFWu2vmoAy8p3QtMUQ5HAbefoMri5pw4V/WilUGggyq1XKJGfvKRB1p83eDyGjiOc
         ELMhCm5W2ALg3ws/lCyKSKyV0ky4WIRMjxcLsxrk7plAEal4hDCc9ZDyEofwmv3X4fnO
         fY8y7nxtY0OL7fQfKQ7fQwkvObDx5AHBRr3CMNOMQsKmspFHON/83Y31FfJhvVmIuQ7c
         54WkcgG9uBXfaPhJuOZIbWqkhUBG3hVI4h9cB7VC76h4W1sxG9Go9U6DxL33ZdI0x2H5
         LWw9P2vOzLbxbJzYJAVDxhObhQMzNUbVSJkYneNb1GJCsZJAcC005wQqoWCpJVT73kax
         AApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765206443; x=1765811243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=koYXwoTEJsoPLyEPiz9nEdjQYdWChY6O9/DUrMalYaU=;
        b=Q6UXueUzWzA+Oxtw/4nRxaNiqT4Ofe+KTzJpn6/iaJSfJgQ+DuSavC3vDurMIjlqh9
         YlWyT07HVfIhgahDchg8gVjEYBA2a0sh0gFt3o+4jsMgnd0QOoYDIMPNFzR1Oy0Ndt3Z
         ZYOYRXD+W1I37pA7P2OZxThkNbLsDLCw0JFTQDegbUxa05UlEgbsM5ADG8+MQ/MUb+XW
         U5GR9z4w3Qif1s/2WPrVK1qGexAgj/48/o6xQ3ZDJf31T4cvu89cz0q3FfmnYldA2IHk
         flj/aKkbUFarXixzRJzz2kQrv79tg1bLI7fI3/OOKvmZHvKhtpjsVMO6ZY++4ROE7aMo
         qPfA==
X-Forwarded-Encrypted: i=1; AJvYcCVzEhSMpc8R5f3PJk1hlAcwu3ZxIgsOoSUUutPPfzaWNi51+4s7STfVmSJ/PG2z3HwT0tYlRS36Ulwu+CGrog==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrrxu5nT+wK8uREvPKr7yV9VX/icKKzfvq6Gx6jMk8IuVJ/Hwh
	KRdZ59RhIoZVnX8u5vGdq84WwMOKY3QklT8i5R/sruGV3biPCqrayXYFW0c8tJLznzT37fLb+Nt
	QDpZB8Dd01EdUJgDxpDTpRKvCBgeLl8I=
X-Gm-Gg: ASbGncvnARKywtFOUhzzWpH2MMcDaeaMmm6Swy6EiiEeMIM28EWvcO4lY/xoKfz9KR2
	xn/YsKtsx1EDI2t8aprZzmFaPM5OJVALMzUAZ9S2VzgQ4CcvOBBlvplcIzRDN9LLbOV9clvP3T0
	5aLHJP1WaCBUTQFs2faVq25xd7HlRrFbqKOnH0sznntxm814cvV7cXjSq5T6cBQbdfqpLNeg3qp
	mcBo1apdTRm8JwNAHiEa2gs2YBOsirZoXRelaIs3N8ZugZzsOmvENn5v6Bh9kWbEIOUVQniMQ==
X-Google-Smtp-Source: AGHT+IGYRXraUxNnTs25uPKI9qFKKJh9msu75YD1kNeHN+uqbvLo7zPFytcHo2xWkyYJWdyrK6Tt95u9MkZVGc/NOaA=
X-Received: by 2002:a05:690c:46c1:b0:78c:24d2:8e46 with SMTP id
 00721157ae682-78c33b641a6mr128823087b3.23.1765206442917; Mon, 08 Dec 2025
 07:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207123447.93233-1-madhurkumar004@gmail.com>
In-Reply-To: <20251207123447.93233-1-madhurkumar004@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 8 Dec 2025 16:07:11 +0100
X-Gm-Features: AQt7F2pKE5CQRUA_xL32Yk7vUOwJ69Im78h8OWjd5vaMan4AvHfoEZP3-zr1coc
Message-ID: <CAOiHx=n8osZ=b=MVNsxAKEtxDvNgt1ESohLNMWoz43c9RwNfOA@mail.gmail.com>
Subject: Re: [PATCH] drivers: net: wireless: Replace deprecated PCI function
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.or, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.co, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 7, 2025 at 1:35=E2=80=AFPM Madhur Kumar <madhurkumar004@gmail.c=
om> wrote:
>
> pcim_iomap_table() and pcim_iomap_regions() have been
> deprecated.
> Replace them with pcim_iomap_region().

The patch subject is wrong, please read
https://wireless.docs.kernel.org/en/latest/en/developers/documentation/subm=
ittingpatches.html

>
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index ec9686183251..5a82c3bf471f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -284,10 +284,6 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>         if (ret)
>                 return ret;
>
> -       ret =3D pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> -       if (ret)
> -               return ret;
> -
>         pci_read_config_word(pdev, PCI_COMMAND, &cmd);
>         if (!(cmd & PCI_COMMAND_MEMORY)) {
>                 cmd |=3D PCI_COMMAND_MEMORY;
> @@ -325,7 +321,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>         dev->fw_features =3D features;
>         dev->hif_ops =3D &mt7921_pcie_ops;
>         dev->irq_map =3D &irq_map;
> -       mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
> +       mt76_mmio_init(&dev->mt76, pcim_iomap_region(pdev, 0, pci_name(pd=
ev)));

You are effectively removing the error checking by directly passing
the result of pcim_iomap_region() to mt76_mmio_init(). You need to
first make sure that pcim_iomap_region() succeeded.

Best regards,
Jonas

