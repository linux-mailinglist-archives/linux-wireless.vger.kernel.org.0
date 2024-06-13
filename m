Return-Path: <linux-wireless+bounces-8962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283EC906487
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 08:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF908284B20
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFD013791E;
	Thu, 13 Jun 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mlNVwXVV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB813774C;
	Thu, 13 Jun 2024 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261913; cv=none; b=RufVav4+8RJ3uxgCPAOUKCvD1frgs5X8Nn2Oq1LZyeRIW5kPBdA7IJwfveBbpRRLEU1+woailA/oenAbQZ8DRz9csMkKKgcxx2CDOkfCXx1SWk1s/6PGiuq0+2RWpsQaeipzhCtaSk5521cCdmVp/Cs+X/xNbLrj0Yu3PBWCyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261913; c=relaxed/simple;
	bh=HN1wwtBVy35X32AUdsGoFbGzH/EioFVhFzKk6+ZhAcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5GRQrj57WkEEVnbsfUUt9QRNZA3LGZdeV5KaZe3K/dsANzt+8MKFvAmlHNw7TbcS6sWi0kju4MIwoK4GY6ef8iH5zvPFSHolezIk41uDodys7VGofgZMEPU++0ndbe11y9nXYGGoHXiaPPCNd+39ydP9fPtfAcOPQlCJbBykpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mlNVwXVV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HN1wwtBVy35X32AUdsGoFbGzH/EioFVhFzKk6+ZhAcQ=;
	t=1718261911; x=1719471511; b=mlNVwXVVd4t/vEratSgTGrtI0jl5/50FXGg6VQkQApnZm7x
	JBvx23ttW5+5YbDXOwu/I6UDyDwJd0anicVD8GWaiSBva51Az7XI9NhawPE8lI2mnAT05rcQLEG5f
	yXQEyhS86bDRfSXH6lkR93mpk4hXXrHY3TZymMxn8DTma7P4tOrgCZPLcoOsGDMoa3N6+HSqc/G+8
	g8vUw3kobnYFLehGCyAqwaETsUBk24xUtpPRQfvdJbnWnOAHHMPVgAVysYGPpMeh4EoabOv+CJK3b
	wBq3cKFImiGbZFj1p1eGTroujjp3pWPDvcPU0vWDf4r+T7xda9/1hTjqbgkBIuOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHePj-0000000BTBT-1cjK;
	Thu, 13 Jun 2024 08:58:27 +0200
Message-ID: <82d2f2de67bf9284a124225b879c18790fb996ca.camel@sipsolutions.net>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, Jakub Kicinski
	 <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 13 Jun 2024 08:58:26 +0200
In-Reply-To: <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
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

On Wed, 2024-06-12 at 16:15 -0300, Fabio Estevam wrote:
> Hi Johannes,
>=20
> On Wed, Jun 12, 2024 at 4:10=E2=80=AFPM Johannes Berg <johannes@sipsoluti=
ons.net> wrote:
>=20
> > Strange. Is there an IOMMU involved on this platform?
>=20
> IOMMU isn't available on i.MX8M as far as I know.

Alright, so I don't know.

> Interestingly, such a warning does not happen with the 5.10 kernel.

Sure, but that's also _ancient_. There are >12k commits since then that
change arch/arm64/ alone ... And since we didn't change the driver, I
guess the issue is somewhere there?

But ... I see you're one of the NXP ARM64 kernel maintainers so you will
likely know better than me what's going on there :P

I guess you could also check the *virtual* address of the allocated
paged isn't also weirdly unaligned, but either way it's strange that the
arch/iommu/... gives an unaligned physical/IO-virtual address.

johannes


