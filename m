Return-Path: <linux-wireless+bounces-29471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B81E7C9EAA2
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 11:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 203D94E26E7
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6F2E7F1C;
	Wed,  3 Dec 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VwLlUnkP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E52E888C;
	Wed,  3 Dec 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756820; cv=none; b=XfROR2a2L6CQ20j4st2DjKxhtH+zwTe+GqgUKlabjJJh2AQjSl9hn3lo7BBjFlm/I6rNEQfKzWPBSDvIWeYmauW5pMG59PpSbpnW3IqrHj+esGXzx3pMC8krgJ5JFdon+gVEeofA3gaLef1qQAsyTedJFQk94Nq8AYKhVtt629s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756820; c=relaxed/simple;
	bh=NTM1KmWbQdARk4K5AKsKvddVwmZZIFFrjw78YXGgnqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IE9kY9ROzoY0jN+5n7JK6IuEgKI18KUJb/RW8cid3yEI0Ktj+BctF5Q3DAuZIzbLM3nNOzedExxivHdeL172WBv884YqZuTdhrWCWNtqu8Nmj8YR02d2pU+T7EFrLUXqzXIM8fECwPkYst7sVksq8FZ6MYfE5R6RPx5+ZtXOs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VwLlUnkP; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764756777;
	bh=5VfsePXfK/pS5Ytd8Ld+IYlJCYn/zYPgRIqaDjm44iM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VwLlUnkPZaSh7FUBg4+FeXamLgy7MIPGXmOvtWXSDDfd2KzXtEFbyS0OizVl4W8uK
	 ZfcsV6RcKh4FebU3bLRhnXzG45zg0MZgmnBon1mgnlO1ivy+euSf+GLADvHwsal1PD
	 6P7EqJ6NVO3jYBhD6jTnMrsk29Y+5cGVEYoM++bU=
X-QQ-mid: zesmtpgz8t1764756771taa55a6ec
X-QQ-Originating-IP: Mv4Rdtrjlzh+bSyWSRT5cms7a5Dr17o1KqrZ630EHys=
Received: from aosc-cryolitia ( [61.242.135.10])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Dec 2025 18:12:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18005684337878457378
EX-QQ-RecipientCnt: 7
From: Cryolitia PukNgae <cryolitia@uniontech.com>
To: rtl8821cerfe2@gmail.com
Cc: he.zhenang@bedmex.com,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	yt@radxa.com,
	Cryolitia PukNgae <cryolitia@uniontech.com>
Subject: Re: [PATCH v1 6.14] wireless: aic8800: add support for AIC8800 WiFi chipset
Date: Wed,  3 Dec 2025 18:12:29 +0800
Message-ID: <1B7E52A5DC7D1CFE+20251203101229.91783-1-cryolitia@uniontech.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <0d807f54-7579-43a2-99c7-2a19cf715ec3@gmail.com>
References: <0d807f54-7579-43a2-99c7-2a19cf715ec3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OKKvvo6f47/bsgkYmdYt3XTxuRUNnjfH3Y9mGaydEfeu68gnhU4LViBb
	HP8EvxGGJQEeZ8pTNTxlbKMuT+tLlizp4rTPhEEAE6p3kAeMFtUHONdlpwDwFMLSFy7ysJc
	IpZ/wJoPqyDuyiKDN60DLwL9QPa8gDqLtbcfqC9r/McHZmmqEHize4K7vTtzfyQVaTSwtc5
	OJe/nMXif+ebkj7mdxvxUv6/A0HYcFpmcB/qMYlL/EreHGFcGTPMyJHoh+ZZCDbxC6e1Ojg
	ZKpsqUuU81PopEu+kv/hLE0IAuqemwmvEbR6VCtar3xVprxnLzaAqMoSNUM9i7gcreDxh/b
	ilOC7ojXxxWKQYMqDaAxlprsVKcdy76i5ctQyhcc6jS73YAL/GbiGPA3XV/3jGlGe2jkspE
	+mwtwSYcF6YQBfC2YkwboNYePuIoxpfCiFMKmBmIy0Q/rMc8AMkpKXoQOULgjpKqh4JrXd9
	SdLguEDWmhS9zRLjIa/Rv3Dr+6YA7rhJ1UyPPw+/7kmT1ZIq9WmSRap1nEb/TkXnz6auQkJ
	n3qmrOOyxNWI/zb/NBMRoqCK+HRdre1MiID3JXdc+VRqoqsVqp+UMNn82JUcnNQObDho7F0
	RfUBF1dPN6alMFWsWsUl3M9m8GsrWVNnPlXwoRjqbdP8t3XOpEtLoKs3Tkdn6gXLQUiFro+
	xVrAPtX9/jYv7TYH+O75pDElWzhyvTh+1oKVaXOeO948YgV7F6G4ZVlIzfTyqxDHXF7RS90
	vTwoYNtE+iW0vUZCNluPV7/a+JZjYFCX6XovPi7pWQwllskLH4AzYmY7vmue7/udjTLCdQ+
	wgxip/vNYXh/VORUPzMPS9Acc8/rq52HXSbQXyz15qX15BiNp/T5n6rMMh1iRU+IL6Mz5G7
	OTI72gI6JIU3U2wcdQ6/mESYLAZnnrvGAxoHLLbN5jLD0s6tQkIzbm9yEjEdFfhi0nMENpO
	feT128Ckzi5bUQLL/a0n7lSRqjtr/DfRwnKPZtdH6qSqmya4mxFGHGKPd2c3jrff7vsKsOE
	F6MwZjDgwXQ0F3HyCO3xTJ4UTrinTRiVLKAITYpmUpATiKZia/
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Tue, 21 Oct 2025 00:27:21 +0300, Bitterblue Smith wrote:
>On 20/10/2025 12:21, he.zhenang wrote:
>> Add driver support for the AIC8800 WiFi chipset family.
>> 
>> Driver features:
>> - Supports 802.11ax (Wi-Fi 6) and backward compatible modes
>> - PCIe/USB/SDIO interface support
>>- Hardware encryption offload (WPA3 support)
>>- Enhanced power management for mobile devices
>>- Integrated Bluetooth coexistence (if applicable)
>> 
>> Signed-off-by: he.zhenang <he.zhenang@bedmex.com>
>
>I have two USB adapters from Brostrend with AIC chips. It's
>nice to see someone try to add support. However, there are some
>problems with this patch.
>
>1) Where did the source code come from? The driver provided by
>Brostrend doesn't have any license information in it. Only the
>files aic_br_ext.{c,h} have a license header, and that's because
>they were copied from a Realtek driver. Presumably Brostrend got
>the code from AIC. So then I wonder who added the license headers
>we can see in this patch, and did AIC agree to that? They did
>write MODULE_LICENSE("GPL"); but is that enough? Also, a good
>chunk of the code published by Brostrend is actually Copyright
>(C) RivieraWaves, not AIC.

Leaving aside Realtek's involvement, Radxa, one of AIC's downstream
vendors, claims that AIC clarified to them that the entire AIC8800
driver is licensed under GPLv2.[1]

We (deepin) and several downstream vendors are working to clarify the
redistribution license for the AIC8800 firmware, and this remains
unclear to date.

1. https://github.com/radxa-pkg/aic8800/issues/54

>https://linux.brostrend.com/aic8800-dkms.deb
>
>2) Who will maintain this new driver?
>
>3) AIC has several chips. Which ones did you test?

Best regards,
Cryolitia PukNgae

