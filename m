Return-Path: <linux-wireless+bounces-14546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7BE9B089A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 17:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518931F25D44
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4781531C8;
	Fri, 25 Oct 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjDTNA5K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313201865E7
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870851; cv=none; b=V/F2gEUXh+thIp/qy4aqd9esqB6tCE+QPVolucb2mHNVqMsZZmKWYvMsPQXqonvhhKWKocje2CYyKKKE0E2pZkh2bUdkNQ47vz9dfOqcNCSUknBHqkNuwZkbtNRMczgIm4to3RTJaFUYBAtNbt48mwUT8S0/VCSfns4V47mxgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870851; c=relaxed/simple;
	bh=bucM69zhnxn5/hKlJK4fqgGKg509HVAnLVGWxMBxtFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lf9lMtiUQidjnmofMN3HO/klizF8XnYZmJKC4D8j9RRVctc01osQFnTwDqW1d9i/h8XpABNgd3aeEwEaa3k1uoMffY8x6tHsbPSTOOnoCYaIjBvZbJXU4yYelJlY+/+bm7iQ6xH1iKKq30LGLWE2pIh+R766K9sR8i2zXydCQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FjDTNA5K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729870848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzoMdLAmboBYe/1IRrBdZaOPlgpz2yyMsskVNx8zBnM=;
	b=FjDTNA5KeN/BqZ5XgpdYii/DwlF/2jpOd2Di4+pOqewT/B8ByOZg0TV6C02oZ1ef7wNVUe
	j3GDe2fLaN+vTm32UbAYqChtI7JBr9+Na4rWODM36RlF7Itf/D5j4Vc+/ECn0kNifC8l/Z
	RN9hTL779l4tz6xTX4B0DxGPr9viGK4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-TtcvmsNWNDqUOKWixzKdUQ-1; Fri, 25 Oct 2024 11:40:45 -0400
X-MC-Unique: TtcvmsNWNDqUOKWixzKdUQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c9465e3547so1613011a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870844; x=1730475644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzoMdLAmboBYe/1IRrBdZaOPlgpz2yyMsskVNx8zBnM=;
        b=b1n6v+HwGCgwZZRMLSOLCdWSiYTZrBcxcdMR0b6/JAiUlP9/WG3sXWetpCnwjOZ76y
         M9T9XsQ1Uf/Js7EHJCVqiyjDVvwbLWRTg4HLdEHmm9dgMVnhjezOBuCys9gsKbKVQAhZ
         1QmT/4TVQWQyq/kFsxZyVviAw2244pyj6ZkeBqiw6qmJOzwf2vzABNhZZ5GhZllXftCX
         FxjJCUkJMX/U0uOG3PDzgdcgOBEBLrHuuIPq8kTe1psAeWayuDO7FZ5EKFdsrRGumwKU
         4Virz3GnbAHclEcjDITBxcbHYlAVFQbbRN2gG0wXEfxbAtGRhdAzPqsbEL7gIj2W5z4G
         lpSg==
X-Forwarded-Encrypted: i=1; AJvYcCUd293jgEjqSDFRVc5QpejIIhzseAdu0+sb7N8nxQt4fj6aULQef/IDxWF7hF/zX6VU5w4jxTRweuRP5KP+OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAJhAxp6Fjx5+HYNOnYiZE2US9F6M0EJ2BQ7AvmINy4Vruld7v
	iDCJl8qZ/97HVmgHTECXiF8PhJl8SmrGbLmY11coPX0UQTKMamsRJAgwEPAkG582SLhu73jeyqV
	pyJXqWGue9EW916b1VRfUN5ZI+sQl3Rj45W+8G01lZTUeXY/XwinfNcFczBriqIgW
X-Received: by 2002:a05:6402:2708:b0:5cb:6718:660a with SMTP id 4fb4d7f45d1cf-5cba242fd48mr4898158a12.9.1729870843878;
        Fri, 25 Oct 2024 08:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Zcv+ZRlluNXU1aQ1MGYzlRmBIYaLWcpFVZkMbyXea+x6Kqw2wJYkAxS4CN0OGWslX2I1RQ==
X-Received: by 2002:a05:6402:2708:b0:5cb:6718:660a with SMTP id 4fb4d7f45d1cf-5cba242fd48mr4898108a12.9.1729870843339;
        Fri, 25 Oct 2024 08:40:43 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb613c3e9sm747217a12.0.2024.10.25.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:40:42 -0700 (PDT)
Message-ID: <415402ba495b402b67ae9ece0ca96ab3ea5ee823.camel@redhat.com>
Subject: Re: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
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
 <u.kleine-koenig@pengutronix.de>, Jie Wang <jie.wang@intel.com>, Tero
 Kristo <tero.kristo@linux.intel.com>, Adam Guerin <adam.guerin@intel.com>,
 Shashank Gupta <shashank.gupta@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Johannes Berg
 <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
  Gregory Greenman <gregory.greenman@intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, linux-doc@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
 qat-linux@intel.com,  linux-crypto@vger.kernel.org,
 linux-wireless@vger.kernel.org,  ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>,
 linux-sound@vger.kernel.org
Date: Fri, 25 Oct 2024 17:40:39 +0200
In-Reply-To: <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
	 <20241025145959.185373-7-pstanner@redhat.com>
	 <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-10-25 at 18:31 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 25 Oct 2024, Philipp Stanner wrote:
>=20
> > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Acked-by: Kalle Valo <kvalo@kernel.org>
> > ---
> > =C2=A0drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++--------=
-
> > ---
> > =C2=A01 file changed, 4 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > index 3b9943eb6934..4b41613ad89d 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > @@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct
> > pci_dev *pdev,
> > =C2=A0	struct iwl_trans_pcie *trans_pcie, **priv;
> > =C2=A0	struct iwl_trans *trans;
> > =C2=A0	int ret, addr_size;
> > -	void __iomem * const *table;
> > =C2=A0	u32 bar0;
> > =C2=A0
> > =C2=A0	/* reassign our BAR 0 if invalid due to possible runtime
> > PM races */
> > @@ -3659,22 +3658,15 @@ struct iwl_trans
> > *iwl_trans_pcie_alloc(struct pci_dev *pdev,
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > -	ret =3D pcim_iomap_regions_request_all(pdev, BIT(0),
> > DRV_NAME);
> > +	ret =3D pcim_request_all_regions(pdev, DRV_NAME);
> > =C2=A0	if (ret) {
> > -		dev_err(&pdev->dev,
> > "pcim_iomap_regions_request_all failed\n");
> > +		dev_err(&pdev->dev, "pcim_request_all_regions
> > failed\n");
> > =C2=A0		goto out_no_pci;
> > =C2=A0	}
> > =C2=A0
> > -	table =3D pcim_iomap_table(pdev);
> > -	if (!table) {
> > -		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
> > -		ret =3D -ENOMEM;
> > -		goto out_no_pci;
> > -	}
> > -
> > -	trans_pcie->hw_base =3D table[0];
> > +	trans_pcie->hw_base =3D pcim_iomap(pdev, 0, 0);
> > =C2=A0	if (!trans_pcie->hw_base) {
> > -		dev_err(&pdev->dev, "couldn't find IO mem in first
> > BAR\n");
> > +		dev_err(&pdev->dev, "pcim_iomap failed\n");
>=20
> This seems a step backwards as a human readable English error message
> was=20
> replaced with a reference to a function name.

I think it's still an improvement because "couldn't find IO mem in
first BAR" is a nonsensical statement. What the author probably meant
was: "Couldn't find first BAR's IO mem in magic pci_iomap_table" ;)

The reason I just wrote "pcim_iomap failed\n" is that this seems to be
this driver's style for those messages. See the dev_err() above, there
they also just state that this or that function failed.

I am indifferent about the message, though. Whatever the maintainer
prefers is fine.

P.


