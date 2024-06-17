Return-Path: <linux-wireless+bounces-9064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39BB90AD98
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F152845D1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749E194C66;
	Mon, 17 Jun 2024 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUVIWWat"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDA17FAA2;
	Mon, 17 Jun 2024 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626090; cv=none; b=ALfbxuyLvzX+D8Xwd0u+XkYyKauhmUkIowxOhitKfXYgy13rEGCvzqcbQrHJga5nBHck2OUmNjXrqKAPcIoB0/3K8M5q/RySgL827uxlqw0e75cVL+JGqJMes8B42fEfINWSzezPbVCRPxf8zytsD+RagyHyL+w6LAlJwRVIxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626090; c=relaxed/simple;
	bh=fWhPxtJJaYXwHziDk1H8768QKpvJvEh6G+oLsd2gWVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVQHFD0Ge6ghqtaH7Ti4lN9F7FJGkuw9RFEzzp/SCAX6BqvL7a2ljZcYdV5IrFCekuhgCG3N5egk4yhQIniAKqgunf8gqHofStrbezeaOKyOH1Vt8qXtsbcD1MR64FBedlVxwM4qfJnS266PLw1qz9rw2x+11MgwgcBnmrOuVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUVIWWat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2569CC2BD10;
	Mon, 17 Jun 2024 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718626089;
	bh=fWhPxtJJaYXwHziDk1H8768QKpvJvEh6G+oLsd2gWVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUVIWWatw7u2vRnYJ6xyj33UgNFqqP1poZ6O1wbS5mQdT4XEwTS8ROEB1riya3gA6
	 ySTXmAdSasnmFpjqRoVLHDzIK1WAoYGHsnSERhZ1gMfav47Z4MY2r1QD3gBaxk38et
	 F2RKm5+GaK3qDkZ3HjDxuqaiuRMNP+7sMzu1DsZ/NAY5jJsNmNNVbAJ69jKc/GL7N6
	 ALkl/jDXhhoSr4cbbdK4CWNk4FdWpQaaflE630QPcYbSme57U7xp7K+F8O5KqMRSPH
	 qW+LfV3f2nINw/xXAGou0QWwUNsjmnnVjMM8kNQti4aLQ0NSFLSv9GE5Kn6I0KeBmG
	 hMUaMg6JaFmhA==
Date: Mon, 17 Jun 2024 13:08:04 +0100
From: Will Deacon <will@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
Message-ID: <20240617120804.GA861@willie-the-truck>
References: <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
 <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
 <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
 <d49fcc32-bfa8-41d2-8666-af6256b7b4b4@quicinc.com>
 <50101085cba7fc089339c96f531f797e27c632ff.camel@sipsolutions.net>
 <35750452-e362-4dfa-803a-3360a4e16cd8@quicinc.com>
 <6e556f7b6b769c4d70be3e248b98d8d09d51452b.camel@sipsolutions.net>
 <CAOMZO5CN_kbPcEYsN9SqqfUyrJdq9yaDisfJKL+CnENVTPuq3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CN_kbPcEYsN9SqqfUyrJdq9yaDisfJKL+CnENVTPuq3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Fabio,

On Thu, Jun 13, 2024 at 05:15:03PM -0300, Fabio Estevam wrote:
> On Thu, Jun 13, 2024 at 7:37 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> 
> > Oh. So I guess try to pick up commit 14cebf689a78 ("swiotlb: Reinstate
> > page-alignment for mappings >= PAGE_SIZE").
> 
> Good catch, thanks!
> 
> After applying 14cebf689a78 ("swiotlb: Reinstate> page-alignment for
> mappings >= PAGE_SIZE")
> on top of 6.6.33 I no longer have the flood of alignment warnings and
> iwlwifi can be used again:
> 
> # dmesg | grep iwlwifi
> [    4.295064] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
> [    4.305459] iwlwifi 0000:01:00.0: Detected crf-id 0x3617, cnv-id
> 0x100530 wfpm id 0x80000000
> [    4.315440] iwlwifi 0000:01:00.0: PCI dev 2723/0084, rev=0x340, rfid=0x10a100
> [    4.346029] iwlwifi 0000:01:00.0: api flags index 2 larger than
> supported by driver
> [    4.353816] iwlwifi 0000:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ
> Version: 89.3.35.37
> [    4.363135] iwlwifi 0000:01:00.0: loaded firmware version
> 77.ad46c98b.0 cc-a0-77.ucode op_mode iwlmvm
> [    4.444427] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX200
> 160MHz, REV=0x340
> [    4.604918] iwlwifi 0000:01:00.0: Detected RF HR B3, rfid=0x10a100
> [    4.676138] iwlwifi 0000:01:00.0: base HW address: 3c:21:9c:4e:16:6x
> [    5.339929] iwlwifi 0000:01:00.0 wlp1s0: renamed from wlan0
> [    9.840136] iwlwifi 0000:01:00.0: Registered PHC clock:
> iwlwifi-PTP, with index: 1
> 
> Will, is it OK for me to ask the stable folks to backport 14cebf689a78
> ("swiotlb: Reinstate> page-alignment for mappings >= PAGE_SIZE")
> to 6.6 stable?

If you want to backport that change, then I think you should probably
take the whole series:

https://lore.kernel.org/all/20240308152829.25754-1-will@kernel.org/

(and there were some follow-ups from Michael iirc; you're best off
checking the git history for kernel/dma/swiotlb.c).

FWIW: we have this series backported to 6.6 in the android15-6.6 tree.

Will

