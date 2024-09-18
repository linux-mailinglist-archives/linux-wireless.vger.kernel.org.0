Return-Path: <linux-wireless+bounces-12954-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51CD97BBB7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D811F21F97
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA5189502;
	Wed, 18 Sep 2024 11:47:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from IgnazServer.ignaz.org (IgnazServer.ignaz.org [37.252.120.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1C1891D1;
	Wed, 18 Sep 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.252.120.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726660041; cv=none; b=RjN8BR6MnoUGBrOuwFT0Pb8j1KE2FBwMfIInZ/Nbt31B43R1+2gYINGYYcdZ3ZaeheGwivgdDz/A4e1PmxDbSj1QcEnp1ZmKGzkwUMc8ux5Do6cjmMR1/fND3cDVHvEZjKL6sYpFTgtiMCkUvvhRarENCwMdzmFk9NDNW/eEuCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726660041; c=relaxed/simple;
	bh=tXfQxu9o0kTobDRH0kn6VMSl6eo2i9H/kFSAbxk8rYI=;
	h=From:To:Cc:Subject:References:In-Reply-To:Message-ID:Date:
	 Content-Type:MIME-Version; b=fzOc3luvyRU2LlbhdwAb+90bT7XC3Lx68PzntVPBGctvJprhwdcBtKNjgJV9ek/hZp01T/j79btUTR6+ZHRgwu3AvFGrAWxX0UjYbosXp0bj+ZsMufCINZPxDrpPVhpyVTloHN41eEZJEGoOZRpUpAHW+PwudHX0sHRez72Z65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org; spf=pass smtp.mailfrom=ignaz.org; arc=none smtp.client-ip=37.252.120.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ignaz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ignaz.org
Received: from ignaz.org (localhost.localdomain [127.0.0.1])
	by IgnazServer.ignaz.org (IgnazServer) with ESMTPSA id 0CC1642B74;
	Wed, 18 Sep 2024 13:47:18 +0200 (CEST)
From: Marcel =?utf-8?b?V2Vpw59lbmJhY2g=?= <mweissenbach@ignaz.org>
To: stable@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Cc: regressions@lists.linux.dev, linux-wireless@vger.kernel.org
Subject: RE: RTL8852BE wifi no longer working after 6.11 upgrade
References: <63a3ef5acd70454e9f8db114204e2e2d@realtek.com>
In-Reply-To: <63a3ef5acd70454e9f8db114204e2e2d@realtek.com>
Message-ID: <20240918114718.Horde.TpiB1MVH0uadLCQXUbR5WtB@ignaz.org>
User-Agent: Horde Application Framework 5
Date: Wed, 18 Sep 2024 11:47:18 +0000
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, thank you so much for your time and work!
 
I hope i don't cause any confusion and this question may be based on my lack of  understanding the patch, i almost don't dare to ask, but does this quirk only gets into affect, when someone uses the same mainboard i use? Is this an rather rare case that probably won't effect other people?
 
I can't judge that so please don't get me wrong, but i feel a bit uneasy about this. I assume that most fist time Linux users that have similar (but not the same) platform, where this quirk will not get applied and they end up with non-working wifi, just notice that wifi doesn't work and give up on Linux and remember it as "My Wifi even didn't work there".
 
As a long time Gentoo user, i have the capability to build my own kernel and provide feedback that can help fix this issue, but i assume most users don't. I would assume an Ubuntu users will just remove the Ubuntu partition and calls it a day continuing using Windows. I am a bit worried and wonder, if there maybe a way to fix that, that is independent on my specific hardware/mainboard.
 
Of course, feel free to correct me if i am getting something wrong here, im neither an Kernel nor C expert and thank you for your time again.
 
"Ping-Ke Shih" pkshih@realtek.com – 2024年9月18日 18:00
> Marcel Weißenbach <mweissenbach@ignaz.org> wrote:
> > Setting ret to -1 did the job, wifi works again as expected.
> > 
> > Here is the output of dmidecode
> > https://ignaz.org/nextcloud/index.php/s/tZdjYYdyeWpHPH4
> > 
> 
> I wrote a quirk according to your dmidecode [1]. Please try if this can
> still work to you. If yes, please help to reply a Tested-by tag there.
> Thanks. 
> 
> [1] https://lore.kernel.org/linux-wireless/20240918085551.54611-1-pkshih@realtek.com/T/#u
> 
>

