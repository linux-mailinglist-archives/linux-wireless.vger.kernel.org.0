Return-Path: <linux-wireless+bounces-10860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C184C9458D3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 09:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAAE1F23327
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46D1C0DF4;
	Fri,  2 Aug 2024 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtU/VALv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A81C0DE4
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583779; cv=none; b=MNef1DiNKMpKqdvjNpUgwIopDdeQLIK7qHdfTk1nw4bEQDTrgRjvm6gfeF0+GwdZaaLj8w4aZ12Ml8sEShYGoWN4rzNn29Rd5A8r5rY/qUbxwpZRM6vSsePmvuARpzLklLTjP166HaTzMqzvf2GFnnTBkkdjb5o+ULNyu5oEQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583779; c=relaxed/simple;
	bh=kmHKuUnN63yG3N+YrvRBAAcfFf/g3Y5GX6lOVrX/vEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WP1O+HFdLmXZ64vb4uxf83ABbQCTwosazZfVu38Xe7Xix1Q2Vh9P6YCRP6Kcy75FIlojKKy18eJ8FGCppDMcfcnKX2gxUK++oSd3xluuz/SqrYMcn7sQlMZQl7pb7kHU8xc34RXbBMl818j/73MjcpZzEBpd/1WmwV8KqY9PGCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtU/VALv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722583776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oflud7+JAJ9QyEvfCkggZ4DJB6jzCHKS2M1exBnEcgI=;
	b=WtU/VALvsddbPtwhFI69Hs1Rxz2Gj3tqU2TAOaefDAAxi87kLCKqnbp8h/H4jThZKpgp37
	fU6IAUa1os1zkZ1r2RVOrPDo3TnovLgQRgGcQ29Ds+J3sSgZOubh0zdXQU3BTznF1AHQ7t
	j4OJl3DTHO333MnSlS/+7eJlwr8IUeY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-T9NwLvHfM9-dVY4euZA96g-1; Fri, 02 Aug 2024 03:29:34 -0400
X-MC-Unique: T9NwLvHfM9-dVY4euZA96g-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5af1a5a36feso935320a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 00:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583773; x=1723188573;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oflud7+JAJ9QyEvfCkggZ4DJB6jzCHKS2M1exBnEcgI=;
        b=ZCKXbpCAJXFwjmCyX0HIhxycJ9QTpIL7+1MHBwW3i/gKoOB/P17pNQhQ36qRcFSPxA
         u5bjL4LYTvg6nrOJWLtzlR+JdKiDJkHT1T8gRPv87DS1fUrk8SF7QAgB2ZclHKwRFSz4
         1cFFmsPHrW2XeiMt5rWbloDOa1QIxDmQvrTCSsTr5kH2fSM02QxoHG3P/lBZOn2etZoA
         DViyAYU5n2YNIfPM7pRyDt27K8irK4LQcB6ClSSJheB/K/zJdu6QKO/gw47PzavKWbAy
         8XtprD3laa7PobcvduBIcz1idebglOPL2wdBPc1UgzF7xvaHKalrFj1wPxrahihb+yCm
         QfTg==
X-Forwarded-Encrypted: i=1; AJvYcCWTI/+i8FR+gq+4w2k6Qw3yDOOBwHDJ1OMeSy7IGXredHnlhZI3RnL9k9ZDMqvDUdHTUVuD1YjkOrfaM3Eh4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7obCuLzbuBj3TPQqR+US8WqgnxIBwpvZDCz3NbIint6tqHv3
	mCAZOHIPbGvFskoUcKKV+5sdoIqhH68sFfeLv0cJ3vgvdehyKXf8QyOyEl9vK8QYKQQAy9c/5aD
	SOK0wQvZNgaynGxupZF89fg2jcPrjnvGXfYnf3I+rBEf/Y5Aj2qBUv1tMvFzcw8D+
X-Received: by 2002:a50:f69b:0:b0:5b0:c00:8e6a with SMTP id 4fb4d7f45d1cf-5b7f57f41damr1098589a12.3.1722583773125;
        Fri, 02 Aug 2024 00:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsji3VfhXPxlMrKr64Fn48CXyC0btftVqR91XWF6/2fd7ezeuTo6NKImFbFsMb8BsrTBId9w==
X-Received: by 2002:a50:f69b:0:b0:5b0:c00:8e6a with SMTP id 4fb4d7f45d1cf-5b7f57f41damr1098574a12.3.1722583772521;
        Fri, 02 Aug 2024 00:29:32 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d6c:8e00:43f3:8884:76fa:d218])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839610c77sm741802a12.9.2024.08.02.00.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:29:32 -0700 (PDT)
Message-ID: <a1a7fbf3cca131955911c911e09f1b1d908a7c06.camel@redhat.com>
Subject: Re: [PATCH 04/10] crypto: marvell - replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,  Boris Brezillon
 <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>, Srujana Challa
 <schalla@marvell.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>,  Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jie Wang <jie.wang@intel.com>, Adam
 Guerin <adam.guerin@intel.com>, Shashank Gupta <shashank.gupta@intel.com>,
 Damian Muszynski <damian.muszynski@intel.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Johannes
 Berg <johannes.berg@intel.com>, Gregory Greenman
 <gregory.greenman@intel.com>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-ide@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Date: Fri, 02 Aug 2024 09:29:30 +0200
In-Reply-To: <20240801174608.50592-5-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
	 <20240801174608.50592-5-pstanner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-01 at 19:46 +0200, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>=20
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions()
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 14 +++++++++--=
-
> --
> =C2=A0drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 13 +++++++++--=
-
> -
> =C2=A02 files changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> index 400e36d9908f..ace39b2f2627 100644
> --- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
> @@ -739,18 +739,22 @@ static int otx2_cptpf_probe(struct pci_dev
> *pdev,
> =C2=A0		dev_err(dev, "Unable to get usable DMA
> configuration\n");
> =C2=A0		goto clear_drvdata;
> =C2=A0	}
> -	/* Map PF's configuration registers */
> -	err =3D pcim_iomap_regions_request_all(pdev, 1 <<
> PCI_PF_REG_BAR_NUM,
> -					=C2=A0=C2=A0=C2=A0=C2=A0 OTX2_CPT_DRV_NAME);
> +	err =3D pcim_request_all_regions(pdev, OTX2_CPT_DRV_NAME);
> =C2=A0	if (err) {
> -		dev_err(dev, "Couldn't get PCI resources 0x%x\n",
> err);
> +		dev_err(dev, "Couldn't request PCI resources
> 0x%x\n", err);
> =C2=A0		goto clear_drvdata;
> =C2=A0	}
> =C2=A0	pci_set_master(pdev);
> =C2=A0	pci_set_drvdata(pdev, cptpf);
> =C2=A0	cptpf->pdev =3D pdev;
> =C2=A0
> -	cptpf->reg_base =3D
> pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
> +	/* Map PF's configuration registers */
> +	cptpf->reg_base =3D pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
> +	if (!cptpf->reg_base) {
> +		dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n",
> err);
> +		err =3D -ENOMEM;

Just saw I messed that one up. err has to be set before printing it, of
course. Will fix that in a v2.

> +		goto clear_drvdata;
> +	}
> =C2=A0
> =C2=A0	/* Check if AF driver is up, otherwise defer probe */
> =C2=A0	err =3D cpt_is_pf_usable(cptpf);
> diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> index 527d34cc258b..e2210bf9605a 100644
> --- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> +++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> @@ -358,9 +358,8 @@ static int otx2_cptvf_probe(struct pci_dev *pdev,
> =C2=A0		dev_err(dev, "Unable to get usable DMA
> configuration\n");
> =C2=A0		goto clear_drvdata;
> =C2=A0	}
> -	/* Map VF's configuration registers */
> -	ret =3D pcim_iomap_regions_request_all(pdev, 1 <<
> PCI_PF_REG_BAR_NUM,
> -					=C2=A0=C2=A0=C2=A0=C2=A0 OTX2_CPTVF_DRV_NAME);
> +
> +	ret =3D pcim_request_all_regions(pdev, OTX2_CPTVF_DRV_NAME);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "Couldn't get PCI resources 0x%x\n",
> ret);
> =C2=A0		goto clear_drvdata;
> @@ -369,7 +368,13 @@ static int otx2_cptvf_probe(struct pci_dev
> *pdev,
> =C2=A0	pci_set_drvdata(pdev, cptvf);
> =C2=A0	cptvf->pdev =3D pdev;
> =C2=A0
> -	cptvf->reg_base =3D
> pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
> +	/* Map VF's configuration registers */
> +	cptvf->reg_base =3D pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
> +	if (!cptvf->reg_base) {
> +		dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n",
> ret);
> +		ret =3D -ENOMEM;

Same here.

P.

> +		goto clear_drvdata;
> +	}
> =C2=A0
> =C2=A0	otx2_cpt_set_hw_caps(pdev, &cptvf->cap_flag);
> =C2=A0


