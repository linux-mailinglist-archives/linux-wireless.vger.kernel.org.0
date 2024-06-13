Return-Path: <linux-wireless+bounces-8969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F520906A2B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA0F1F21411
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CA3140E3D;
	Thu, 13 Jun 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tP/qLcG6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF414262B;
	Thu, 13 Jun 2024 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275026; cv=none; b=ZdnUmmE7Vcugu3tz5cUvAu0mVP6fWswgQsPogys+V2oRLiYeVMV/Y+9d/e0OyjbzpKyjCHk0pN2G2ZoxVUN/SrqFmadntYkw0cv0SXtDcoe9D6iT+oYl2/sPYlO71urwyNMGq+aqgFKBL5LifqsYkl0Mufo5YUosp/lgmMIRBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275026; c=relaxed/simple;
	bh=uXc9YMgZvjPSnogTTkBnlabraBR7pN2hBx8kzpuQjsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0HCn08pIVrC4k2OTe8a8JYDT48dT+unawk6i6wlFGfq3DLxY8wiMtgCQy6mptES29NrpZYa6ZCh4yKihMe4VHvyc/V8g+UBXm+YwqU5Y0rx8ZUpp7I9zi3spH1BWXd6as0sI8OWjUx7BDrQ+0IS2saeaxEcLsgWPpXSMkLckFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tP/qLcG6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kR/M9fhOaHDFyEmiaJYa3IfzhmNFE97O5AlCdd5wYN4=;
	t=1718275024; x=1719484624; b=tP/qLcG6cPdUIbHI0amRWpEc7WI0uQNB5gSQqAxNmt1HCgU
	6yjWYT9uNH3duui+aM/+BmOvKHg9OzqQ/RyKJXFsdeAzUUr49FUVOpQqKrwEiki1nUHPUlfjEffhB
	bk+RGkoL9e/M6cJJXBv6maF0vBhcqxPFB89EUOb6YAID12GTV2fy2PaNCPmy6XQCGL8+3H6w5MTyW
	MgWQ2RFoo9H+rg6dps8GGRQ/ko0xhvvb+6fG81nG1pByJ0uA2PCNQ046MpVBRzm86xhsAhJM3PRmG
	YZP9xsDeU/MpALQO+9PsbxfVMzxbDdPRbaHS4+3MphPNmZoTxh1l0ZEOV0eOp0yA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHhpD-0000000BhFP-3cQ9;
	Thu, 13 Jun 2024 12:37:00 +0200
Message-ID: <6e556f7b6b769c4d70be3e248b98d8d09d51452b.camel@sipsolutions.net>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <quic_bqiang@quicinc.com>, Fabio Estevam
 <festevam@gmail.com>
Cc: miriam.rachel.korenblit@intel.com, kvalo@kernel.org, Jakub Kicinski
	 <kuba@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 13 Jun 2024 12:36:59 +0200
In-Reply-To: <35750452-e362-4dfa-803a-3360a4e16cd8@quicinc.com>
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
	 <50101085cba7fc089339c96f531f797e27c632ff.camel@sipsolutions.net>
	 <35750452-e362-4dfa-803a-3360a4e16cd8@quicinc.com>
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

On Thu, 2024-06-13 at 17:51 +0800, Baochen Qiang wrote:
> >=20
> > Not sure that means anything though, I really would have expected a 4k
> > buffer to be 4k aligned - why would you even want to map it across two
> > pages?
> IMO SWIOTLB manages buffers in a unit of IO_TLB_SIZE, it does not care ab=
out whether or not we are crossing page boundaries, no?

Well arguably it should have some 'natural' alignment guarantees?

> >=20
> > If it is SWIOTLB, shouldn't we get into this condition?
> >=20
> >         /*
> >          * Historically, swiotlb allocations >=3D PAGE_SIZE were guaran=
teed to be
> >          * page-aligned in the absence of any other alignment requireme=
nts.
> >          * 'alloc_align_mask' was later introduced to specify the align=
ment
> >          * explicitly, however this is passed as zero for streaming map=
pings
> >          * and so we preserve the old behaviour there in case any drive=
rs are
> >          * relying on it.
> >          */
> >         if (!alloc_align_mask && !iotlb_align_mask && alloc_size >=3D P=
AGE_SIZE)
> >                 alloc_align_mask =3D PAGE_SIZE - 1;
> >=20
> This is not present in 6.6.32 stable kernel.
>=20

Oh. So I guess try to pick up commit 14cebf689a78 ("swiotlb: Reinstate
page-alignment for mappings >=3D PAGE_SIZE").

johannes

