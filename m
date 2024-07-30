Return-Path: <linux-wireless+bounces-10658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14C94062D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 06:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A298B21EBF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 04:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4A1823DD;
	Tue, 30 Jul 2024 04:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wTJ+sKxc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3E184E;
	Tue, 30 Jul 2024 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722312082; cv=none; b=u9OOmWBF7qN1cX9d+4AljxbmWgIjN2fbAy9TgLV5x0L77DkViQB3mznrV5psjtntQFkKAcu6CG3O+9NyIkbmM57DN80qK6nk4keBXNEQUmaeKMLqLfjZfsVCkAC7qvzbG47a5S4Gn2vIXu7D7AY6H5jc2wmHnAc64a9uvzQxKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722312082; c=relaxed/simple;
	bh=+7u4Qk5PpNJLrMNEg3kLn/xI1892L6+FF2GIJcgew1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rompip7G3OyqLPIFSjAI2zTF87uPUUcELBctMCA6qHT70L4QDAomqK5ZAmzQyBGRiQ2X9c0CEsNEbZO9KWIewyukUtiWRxvnOIo9nFFkKSfeXajpmr51QhxOGOXektwuEn3sc7a1uXSDZycPXAGQoQfSuOfFj5qB4ivFj09YYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wTJ+sKxc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ZBu6EYNwcKhKeD73QyQcdim5UvsLsLAtRFTtQkPnU+M=; t=1722312080;
	x=1722744080; b=wTJ+sKxcqVcmdMsR18XQMRpQwmMNu5JVb1wtmRuZY/QUvaI1wiPQf0xY1re11
	ls+RjMaaRsed/8LtJYSdibDN5drrGLnszIQvzk1oGZ0pGT6OSF6X925qh1UgbyoVee5LOllr8+c3q
	/XCGdYZvAQ12vDtyhCiWYSpfCyQi5+9yCfZmhqssoRqIYqXVTRfnLbZko04Wq/0oZUjrIpKq3o6p+
	Hr4rTVgXHn093YjZhQ3vaMvn8FaFkk6cNhsRl2moDLjRmIDtxCogswc1fKsa/DCblCe2eJahwKg4L
	Zsn5tRB1aHzZhnYfkfbbH7jbXypVEwZZs4HP7czZ50nBl0mjrw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sYe31-0002b6-T6; Tue, 30 Jul 2024 06:01:15 +0200
Message-ID: <6e647420-ad2a-42d7-bcd3-4a498888e9e7@leemhuis.info>
Date: Tue, 30 Jul 2024 06:01:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.11/regression/bisected - commit 1541d63c5fe2 made my system
 unbootable (general protection fault, probably for non-canonical address
 0xdffffc00000000a9)
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, sean.wang@mediatek.com,
 Felix Fietkau <nbd@nbd.name>,
 Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsNkU=2wh9v4NpkhHhsZatTxFmzQpc81yMZG8WkADYJS3Q@mail.gmail.com>
 <CABXGCsNb4e5k4BOU_=aUG_KxrHoqTCOL2jG8o8JbrXsjM4e4LA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABXGCsNb4e5k4BOU_=aUG_KxrHoqTCOL2jG8o8JbrXsjM4e4LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1722312080;8b8230ad;
X-HE-SMSGID: 1sYe31-0002b6-T6



On 29.07.24 21:51, Mikhail Gavrilov wrote:
> On Sun, Jul 21, 2024 at 10:20 PM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> The second Fedora update
>> (kernel-debug-6.11.0-0.rc0.20240717git51835949dda3.5.fc41.x86_64) with
>> the 6.11 kernel made my system unbootable.
>> The trace looks like:
>> Oops: general protection fault, probably for non-canonical address
>> 0xdffffc00000000a9: 0000 [#1] PREEMPT SMP KASAN NOPTI
>> KASAN: null-ptr-deref in range [0x0000000000000548-0x000000000000054f]
>> CPU: 1 PID: 1472 Comm: NetworkManager Tainted: G        W    L
>> 6.10.0-rc5-10-1541d63c5fe2cebce85b2af84a2850a302ffda9c+ #683
>> Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
>
> [...]
> 
> Excuse me, but I can't continue testing 6.11.
> This is a blocker bug for me.
> And it is still not fixed in 6.11-rc1.

There is a fix for the culrpit that will be in -rc2:
https://lore.kernel.org/all/20240718234633.12737-1-sean.wang@kernel.org/

From a quick look the symptoms appears to be different, but the fix
talks about a race, so maybe it is the same problem after all. Worth trying.

Ciao, Thorsten


