Return-Path: <linux-wireless+bounces-13600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E135992BDA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F32E1C20311
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1891C3F36;
	Mon,  7 Oct 2024 12:33:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from IgnazServer.ignaz.org (IgnazServer.ignaz.org [37.252.120.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BAA1E519
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.252.120.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304405; cv=none; b=dGfzwKN1lGC2u42IWuSywgS2gYC1VF1HRGlvn1xsfa5a3U+mm3ws7OFIt8488yDJCgFfjBMKYO3GdJRP0hIAaGjOREnV7I+9E+D3iqVRb6EAf4j2rwOQI2xJRYEIOH0BTDUFLnawA3AagcsOpnYbhaIwnvsJOAkWH/zI+VroAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304405; c=relaxed/simple;
	bh=Y4JoxDTrrN788jGFl0A7n810QkY4yiyHIyTqYGlwCqo=;
	h=From:To:Cc:Subject:References:In-Reply-To:Message-ID:Date:
	 Content-Type:MIME-Version; b=DrelHKV/lZjx6jKG9v8bCsNF2nq69z1h0sl1L5d2JbGyLouSL1hKhsLAAJUlSAPHdfb0GQ29G7JwhKNPc3KmGRTGIfl/mLWWrxcNUgpGIh4cLYTQ/EDflkmZ/prTs2FBa47HE3m1VvGbC+wYmynrP+21iKIbxPeqH9kNGHpTp1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org; spf=pass smtp.mailfrom=ignaz.org; arc=none smtp.client-ip=37.252.120.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ignaz.org
Received: from ignaz.org (ignaz.org [37.252.120.146])
	by IgnazServer.ignaz.org (IgnazServer) with ESMTPSA id 3F02A4421F;
	Mon, 07 Oct 2024 14:25:25 +0200 (CEST)
From: Marcel =?utf-8?b?V2Vpw59lbmJhY2g=?= <mweissenbach@ignaz.org>
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtw89: pci: early chips only enable 36-bit DMA on
 specific PCI hosts
References: <87a5fs81pq.fsf@kernel.org>
In-Reply-To: <87a5fs81pq.fsf@kernel.org>
Message-ID: <20241007122524.Horde.2JAdlkKXx-zqmJFI4TBIqZH@ignaz.org>
User-Agent: Horde Application Framework 5
Date: Mon, 07 Oct 2024 12:25:24 +0000
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi there,
 
just wanted to kindly ask in which Kernel Version this patch will be implemented (given it is not yet).
 
I assume it did not make it into 6.11.2, or?
 
"Kalle Valo" kvalo@kernel.org – 2024年9月28日 20:19
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > Ping-Ke Shih <pkshih@realtek.com> wrote:
> >> 
> >> The early chips including RTL8852A, RTL8851B, RTL8852B and RTL8852BT have
> >> interoperability problems of 36-bit DMA with some PCI hosts. Rollback
> >> to 32-bit DMA by default, and only enable 36-bit DMA for tested platforms.
> >> 
> >> Since all Intel platforms we have can work correctly, add the vendor ID to
> >> white list. Otherwise, list vendor/device ID of bridge we have tested.
> >> 
> >> Fixes: 1fd4b3fe52ef ("wifi: rtw89: pci: support 36-bit PCI DMA address")
> >> Reported-by: Marcel Weißenbach <mweissenbach@ignaz.org>
> >> Closes:
> >> https://lore.kernel.org/linux-wireless/20240918073237.Horde.VLueh0_KaiDw-9asEEcdM84@ignaz.org/T/#m07c5
> >> 694df1acb173a42e1a0bab7ac22bd231a2b8
> >> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > Could you please queue this patch to wireless tree? Because RTL8852BE becomes
> > unusable for some users. I assigned this patch to you in patchwork, if you
> > don't think so and have other suggestions, please let me know. Thanks. 
> >
> > The user has reported this patch works as expected [1], so add his tested-by:
> > Tested-by: Marcel Weißenbach <mweissenbach@ignaz.org>
> >
> > Also, I think this should Cc stable, so
> > Cc: stable@vger.kernel.org
> 
> Ok, I'll add all that.
> 
>

