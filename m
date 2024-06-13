Return-Path: <linux-wireless+bounces-8966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F38906565
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 09:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0959286C1B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0436613C660;
	Thu, 13 Jun 2024 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lVO3WmtC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414113C3CD;
	Thu, 13 Jun 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264433; cv=none; b=ZDM6ofT640siLz3qBO2qkATpURdk5RPcGiTfKphkTHjP11uGsldgMdOdg/DO+6pQf5sk6FRhKPwU37Wtp1yhE0ka9fq17zhL1o/Qhexobn/4dv4GhlECEgUtyba7ocMwYmt40w8jP9BtvHkzp8zyN1LcGSkaog5LwOVL6KUf2rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264433; c=relaxed/simple;
	bh=vA7CkQV/uZWCqUet3+TkgnI8gkyk1M2E09VVDHS+x+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n1OA9ap5lXFaR7k8cgADyBdtHgGBRFtbr9v1YW3aLND+qE7hyrdvXxSoVVKvPenMPhPYSvC8j5Hwfnug5CfKq5Z4cQ74WENon9/Vj2kkLPDHr0f0n9arW6n8Q1cwkj0pT5KuBaU0BQWJoKrvKoyHeT7nET1DFReF5gzFGDrm+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lVO3WmtC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=b2tVk5gtyfcK3Xrbxsq8MRKsU3rezhDvNclVJ6CRAH0=;
	t=1718264431; x=1719474031; b=lVO3WmtCuoWMgaIbZZju02Lz9SW+Ku9X7vNqcfpH8y8yQOu
	qPDrV4vVayV/1Vpe5PzICnFJZ+gIvd2un9QZVtjMC6dI8q3D+aOC4pIEi/EB85HFFrhi7nlYL3fNn
	G4htzzvkDP4b221qRHKc4X8AR7YOXzYKjWPVShjWmEn4XHZuEyW59XnIsor4klw9DtJWlpD/jmWSX
	+2BpCiiOAZM4sBNvFDaK9u1+ru8puUEXKBhmsInl2jZ8bcIupz5pCrUF/ChTy8S9sd4iPQnXLhbcg
	Ui6goj1KIORl5y4dZb0/TqXOAnBVsrB9vMzQ1DBiQuDTG/DAfkL3aB4fQB4wvr5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHf4N-0000000BVam-2UwH;
	Thu, 13 Jun 2024 09:40:27 +0200
Message-ID: <50101085cba7fc089339c96f531f797e27c632ff.camel@sipsolutions.net>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <quic_bqiang@quicinc.com>, Fabio Estevam
 <festevam@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, Jakub Kicinski
	 <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 13 Jun 2024 09:40:26 +0200
In-Reply-To: <d49fcc32-bfa8-41d2-8666-af6256b7b4b4@quicinc.com>
References: 
	<CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
	 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
	 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
	 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
	 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
	 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
	 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
	 <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
	 <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
	 <d49fcc32-bfa8-41d2-8666-af6256b7b4b4@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-06-13 at 15:10 +0800, Baochen Qiang wrote:
>=20
> On 6/13/2024 3:15 AM, Fabio Estevam wrote:
> > Hi Johannes,
> >=20
> > On Wed, Jun 12, 2024 at 4:10=E2=80=AFPM Johannes Berg <johannes@sipsolu=
tions.net> wrote:
> >=20
> > > Strange. Is there an IOMMU involved on this platform?
> >=20
> > IOMMU isn't available on i.MX8M as far as I know.
> If IOMMU not present, likely the buffer is mapped by SWIOTLB.

Why? The device can do 64-bit DMA, so should be able to just access any
page in the system. Even older devices can do 36-bit DMA, but this is a
newer one. And if IOMMU isn't present, you have no protection anyway.

>  The iova 4215433216, aka 0xFB426800, is 2K aligned, which also supports =
such guessing. See definition of IO_TLB_SIZE.

Not sure that means anything though, I really would have expected a 4k
buffer to be 4k aligned - why would you even want to map it across two
pages?

If it is SWIOTLB, shouldn't we get into this condition?

        /*
         * Historically, swiotlb allocations >=3D PAGE_SIZE were guaranteed=
 to be
         * page-aligned in the absence of any other alignment requirements.
         * 'alloc_align_mask' was later introduced to specify the alignment
         * explicitly, however this is passed as zero for streaming mapping=
s
         * and so we preserve the old behaviour there in case any drivers a=
re
         * relying on it.
         */
        if (!alloc_align_mask && !iotlb_align_mask && alloc_size >=3D PAGE_=
SIZE)
                alloc_align_mask =3D PAGE_SIZE - 1;


Otherwise, not sure though how we could possibly fix this in the driver,
we really shouldn't do dma_set_min_align_mask() since on the TX side we
really have no alignment requirements, and swiotlb_map() uses 0 as
alignment.

johannes

