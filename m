Return-Path: <linux-wireless+bounces-14608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122D9B33CF
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 15:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FEB2B20C38
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7EB1DDC39;
	Mon, 28 Oct 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BJJbRpVT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BC1DB350;
	Mon, 28 Oct 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126399; cv=none; b=HHeV20ZXWm951QD4S6Yi0lpt3huED3DAsXjIk9Dn64+TuKFkxGG048XCzi/RLlkxm4F7zmTVx8sy3QAqmX5Mv/lFwGsTnu5T2qO8BTUkY2FHinEXW/i3bSTvVPpVwXxEYoK9gGwC9xXRPd3xgwJfq196jCxIqiOnzWX92hzV4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126399; c=relaxed/simple;
	bh=E+CTjqbOgsVd7Q+yuf2w4U33hEJIAOKyzwWAl68X3nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRfjIxhmlhAM1DC11JGAcQ+zX4VKjt4/Nk8UotYsgqxF53S/4sPZBqVOC4Pz/4OmBtwHaueUgmKbnd3JPhhd6jrFZVX5a7JF5187XppIOJi+i427bkVyhuHZDwugltuS3ZHHG+rIC+4QXMpuHolrQFj/rG1IZitUvgehlZ+a1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BJJbRpVT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vRww08Q3DwcVMPJumShFmx9sBaWYzBTGKTpUIyGlJDk=; b=BJJbRpVT9nXvKzcjb4B8eSwP5Y
	97PvsLJ9mqqOapFRjsEnVncllq8dmY5GR9I4YoAe5hSjioT7LhxTfhB6APNf8AKnXjnyJeoU7z/Oy
	5SkTmYauN+6NQbKFreNjmp29WHS0mCNW7QSAR85AP2fPC74G0kugsntZY+4Xh2S7NDtjVvPKVPG8X
	aWBKfAglmnEmSbMetwFYhSqnN7c4ByaHc7FNXROtWyXgrC8qXxLzE4sRcpICn+vtOYKPHZ2NtwycS
	E7k5XH4KqlDljWWJKMI29pEB5WuxADkHY9lMXUkjqUF+G1ddLy8iLkceZ+K0QCUwBzrv3RB+nscwi
	sCOy5e9A==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5QuL-00G7DH-P7; Mon, 28 Oct 2024 15:39:50 +0100
Message-ID: <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
Date: Mon, 28 Oct 2024 11:39:42 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
 <ed8114c231d1423893d3c90c458f35f3@realtek.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <ed8114c231d1423893d3c90c458f35f3@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2024 22:44, Ping-Ke Shih wrote:
> Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>>
>> This procedure for reading efuse bytes relies in a loop that performs an
>> I/O read up to *10k* times in case of failures. We measured the time of
>> the loop inside read_efuse_byte() alone, and in this reproducer (which
>> involves the dummy_hcd emulation layer), it takes 15 seconds each.
> 
> The I/O read of 10k times is to polling if efuse is ready, and then following
> statement is to actually read efuse content back. For USB devices, I/O is
> slow, so it might be fine to reduce retry times. But For PCIE devices,
> I think this will be risky without testing with real hardware.
> 
> Possible way is to use "rtlhal->interface == INTF_PCI" to keep original times
> for PCIE devices, and only reduce retry times for USB devices. But USB can
> operate on USB-2/-3 modes, so maybe still need experiments with real hardware 
> to get reasonable retry times. 
> 

Thanks a bunch for the review and extra details Ping-Ke Shih!

The idea of guarding with "rtlhal->interface == INTF_PCI" is very good
and I can implement in a V2.

But can you help me on finding a USB adapter that runs this path? If you
know a commodity model that uses this specific driver, could you point
me so I can buy one for testing?

Meanwhile I'll try to find a model based on some kernel reports online,
hope I can!

Cheers,


Guilherme

