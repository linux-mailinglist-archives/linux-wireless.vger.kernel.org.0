Return-Path: <linux-wireless+bounces-8798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD2903EE1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61911F22765
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A717C211;
	Tue, 11 Jun 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZTscaK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D0176FB2;
	Tue, 11 Jun 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116383; cv=none; b=BrksUrOFwDV+SuwzukfAa3neFBt/yc83yScIwEPEvbshnVr5mKzwhYGRDkuP6w6+CoyTDKRLlMTgMRUChte1Hr0oyuOeH0aSVFjPmuFwy3HBoMyxQFLKL9/ij/OgtA0Dfka5chQuO/+j4k+BIK21axJeV3Oud29ZP+/igU6E4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116383; c=relaxed/simple;
	bh=zdAYD5DzjJrkzdQ9VD9vzL5jNePC7fwaSOnKQWlbzrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcFbRCI79AnKVEk1ldWVW2VI6Q8qLN5217WAOLQMfBWYfWbUAznS2wvOz+r9F9LfR1H4/2VXduyqFVm0O+t8Fz7sjfdsP87t3CKyxm2MjNivwwt+j6Rn7b1tEfu/3aDeMC1RQacYze4VWtqHfdzP6u8p5vZjJSgnb9d36ttLSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZTscaK9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-627ea1da10eso4815297b3.1;
        Tue, 11 Jun 2024 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718116381; x=1718721181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq1zMet5zoQFjgFedk4L0hjmG3ZkCMwJk+FHVOETSAY=;
        b=nZTscaK9akLuerpi2WokQzwtimUZiUR9mn4UriJPqIqRib++e3tEaeYvcd8GAynqE7
         I/4YBD6Xf4sg8EsvcMy8uEn5Pag7Fi21exU9fYEnMWcu1pirSdktNBQ5NUuw3/epxz82
         9XseanACUPU0kV89SrE/++crEqDxrzGD1NsHN53+dFU5GzL8pg+Ob3jf4gSh4rB2Kwt3
         z8bTaAdfnjqfKNonxMJ9D+m1BPkQVCDptiIyDmgMDRw9t0isAf1HuB89aT43lAkv+Jvy
         p0N5OZ+jwYfwmiJB9wPT74vkdJsTi8LqeB+GaFltsfrWNn6kQKgHfw2qcHWAR0Ut1ztx
         ZYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718116381; x=1718721181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq1zMet5zoQFjgFedk4L0hjmG3ZkCMwJk+FHVOETSAY=;
        b=YlN+nQWjd+BkUbBKslAOtOu9nnicIyp1imLdlPR+xIaZIzb+5oU/m1Lq6HZL21NLVU
         kHfUYhIPIFgsnQdHf7JuyY3ABZOhNggRsXUF3jcR2g8O0vXQZCyf50Ju4yQIB8k6ONO0
         Df1UFkvn9mZou/waP6Zu6yudGYF0f9smD26ZdiFTDR3PIlPMFZBy1jUv0oslOuTNZkSL
         VG0hJvubIr9/cTXHreWIW9Xkt7VTB4ynf8R0HrWIlV8/jmQpmEz1fRmNLy0dusRVTFwp
         GHsMSU4XpC5Edt4y45CGqr+IQtFKTLrBE8zE8gFG7E0s8oAstc+FmflpC32reQZMbSEJ
         fFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvv53FF4KP+VTNUlg/6JjzeE0e9uY3d/+C75RwHNa7LQVOKW8tY4xTTW7esPhs5aFxfq50u2AGBKs7H/BDyJvbSimBWPoFDReXLw8Nj65/JouIkiMgkQlLnKdPf6DWRRYlEQWARiE4swmKsR4=
X-Gm-Message-State: AOJu0Yw4KN2UU2G2z0xabcv7jqMrwwvHAgz/JiTsCLkSBSoD9YNROuVI
	kL3JbpSarN8HuhX0AhgSG41WdhFbBOm0dUviZtIo/MKZkJlzVb0tpiam9l9aKpL4DrVdUEU/r3R
	xgLG+N0THni1/Mb7q3QJDtoJ7aJo=
X-Google-Smtp-Source: AGHT+IEUu9TVuBTqICMAmvzRn8uz+qY36sjsLQGGicLlZ1ClCP4ABSNweLfzGh4NAomvUuE+kG8yQ6mz3Dgo/sS1s80=
X-Received: by 2002:a81:9283:0:b0:627:89f6:7c02 with SMTP id
 00721157ae682-62cd546b9bcmr105747487b3.0.1718116380658; Tue, 11 Jun 2024
 07:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com> <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
In-Reply-To: <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Jun 2024 11:32:45 -0300
Message-ID: <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Johannes Berg <johannes@sipsolutions.net>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

I forgot to mention, but the Wifi device I am using is:

Intel(R) Wi-Fi 6 AX200 160MHz, REV=3D0x340

On Tue, Jun 11, 2024 at 10:54=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:

> > [    5.038174] rxb->offset is 0 trans_pcie->rx_buf_bytes is 4096
>
> so that looks pretty normal?
>
> Might be useful to see rx->page_dma too, supported_dma_mask should be
> 4095 or 2047 depending on the device, but I'm not sure how you could end
> up with a DMA mapping for a page that's not at least 11 bit aligned?

Here it goes:

[    4.344218] rxb->offset is 0 trans_pcie->rx_buf_bytes is 4096
rxb->page_dma is 4215433216 trans_pcie->supported_dma_mask is 4095
[    4.355936] WARNING: CPU: 2 PID: 135 at
/drivers/net/wireless/intel/iwlwifi/pcie/rx.c:269
iwl_pcie_rxmq_restock.part.0+0x15c/0x168 [iwlwifi]

I don't know what a typical rxb->page_dma should be.

Thanks

