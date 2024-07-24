Return-Path: <linux-wireless+bounces-10475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16193AF21
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 11:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC2D2831E7
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E745336B;
	Wed, 24 Jul 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="C7aT2+oI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B613DDC2;
	Wed, 24 Jul 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813801; cv=none; b=NtA/c6ZCxEB74H0aSAtVJd9lskm1J1sj7vh4iYeCvZ+ylHGul+xeyzjCI057091mOg1O1+V3xHNCb0kIacq7nuHn8qcBOU7vTDylXfqlQ7to8pEah6uIvvZxUWhBQ1q1nfTrb4xXdPu8vA8IZH5+ANxdswTCUFS+hZLhc0NJkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813801; c=relaxed/simple;
	bh=La77EI5N5q2GMTwHDJWq5kA72eNXvF1GPhtzwQ0NKxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6jN3kwT6hLbzJ94f7BXvvnyeCWsR8wXltMkjwq61eWvwU8A4aibEmflnVjd+CKMMj0OEw+jTDeHOYVYMfr+T6RP7ThAS4+wx12EqHvLglalPe+mcUE7LshuPCr84VrKIvDG3GXvBQ6LuFbzIZkFsikRQXl+iI8qAbdcs3w1ED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=C7aT2+oI; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=hjn9u+OdaMy0APR3lesVd6VwainbD/Tq9CR8YxQHmzo=;
	t=1721813799; x=1722245799; b=C7aT2+oIsCEbHEuEaNUH1Iv7ZeXsz0M07Uxe7TeTSN1Qmwx
	pJSKeLxX7RU/e5/OKuqWyN6h7shZN0YXUsdIwgcONBspW4dzwe2VBqLPiT733LlVNo3OFRu2g0pDt
	60K8cxmRfnEBc2qNOzb7FkXvMwZA+IzFlmb40SyhPwKSuCLId7tyUL/exBV5HSCLAHzTXdF/83kWB
	nVHAF+tzSv1s1PhCTcIOxFAJpg867nCPSlx5gIqsr9xh5jx0hlekk62V526ZXVQBlaUzXVpKLY4C1
	uUdBf8ld+LrI8kOy3MK4N6q2FdNAb+ivX0558wga6b0KIgs7ILo49bsnwDk19fIQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sWYQB-0006Zs-8l; Wed, 24 Jul 2024 11:36:31 +0200
Message-ID: <0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
Date: Wed, 24 Jul 2024 11:36:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in
 mt792x_mac_link_bss_remove
To: sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Bert Karwatzki <spasswolf@web.de>,
 Mike Lothian <mike@fireburn.co.uk>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240718234633.12737-1-sean.wang@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240718234633.12737-1-sean.wang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721813799;26d02e41;
X-HE-SMSGID: 1sWYQB-0006Zs-8l



On 19.07.24 01:46, sean.wang@kernel.org wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix null pointer access in mt792x_mac_link_bss_remove.
> 
> To prevent null pointer access, we should assign the vif to bss_conf in
> mt7921_add_interface. This ensures that subsequent operations on the BSS
> can properly reference the correct vif.
>
> [...]
>> Fixes: 1541d63c5fe2 ("wifi: mt76: mt7925: add
mt7925_mac_link_bss_remove to remove per-link BSS")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/linux-wireless/2fee61f8c903d02a900ca3188c3742c7effd102e.camel@web.de/#b
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

TWIMC, Mike (now CCed) ran into the problem and on bugzilla confirmed
that this fixes the problem:

https://bugzilla.kernel.org/show_bug.cgi?id=219084
https://lore.kernel.org/all/CAHbf0-HOS-jdRGvJOBmEgaaox3PDbDSTgnnZkZF9pz37Bmh2iw@mail.gmail.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

