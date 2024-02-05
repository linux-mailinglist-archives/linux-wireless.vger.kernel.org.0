Return-Path: <linux-wireless+bounces-3123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80858493FB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 07:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E026B21770
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39529470;
	Mon,  5 Feb 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcirWRh0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364610A01;
	Mon,  5 Feb 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115628; cv=none; b=ZeQ6z6o6Lq093cqT9/l9j9L7rcUSopVTom1SAc8JZ6s3pJ5kk5LYqMsZZZe6DNj4ZTE/AgB/QaSkUD24kaOp4d9yryHt80se7sHiFuIsQVPGwajCHT3KbroMm8SjrLx4YKIdY3/ho6XTR4ptchIEEMI7j+Abzjj8/OPb35v7zPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115628; c=relaxed/simple;
	bh=Mh6q3wecDnnNR+I+giA4evuf5uybfb/YiS5cInRPXrA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=A4pk+yFVlBrgti3ApThTd8DnZIgsZ+QWRNhJDhPSM4kgLqDKwmEOInM7ktoy53vRIX7VDOWSldxKj2uxJll/PSt2+fYYRKAZjRFHMJpCaSPA8PTWQ/mciwq+LqGbF/uxK0KxZdY01No0H7z18og+tXyf/KgPEQ4e48sdvhrgAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcirWRh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF7BC433F1;
	Mon,  5 Feb 2024 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707115628;
	bh=Mh6q3wecDnnNR+I+giA4evuf5uybfb/YiS5cInRPXrA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YcirWRh0k+9sxyoaALUxlh53zP42tNLWMzeqN29bfhT1zuLr2SsV6n7PFTNoqhlsq
	 5ZflQp8GF8Tn4mlYWO8Sacf8jrHYV7zGkr3nWygF1i+mCdUox74sb1qreH1bmDqzOU
	 MiRoqZNnLsCFwJCgscfw9IkA7mhVhMymqdUleWFdhRwp71uAqzxYQexd6ardLRPzg1
	 +PkoZHy6EE4PksMBK6d8Qdr4gScpwHYvqxaQQzmEDs5n88TWCllUclugQeFMxMpNQG
	 4pP8iWmHyqi91HxB/rNKLwaJHCXymSJt04KRpd541jl6KlSDEwtyS7eMlWDPFWKWXI
	 ZVAXqeFGnf9zw==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "lkp@intel.com" <lkp@intel.com>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>,  "oe-kbuild-all@lists.linux.dev"
 <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 3/4] wifi: rtw89: fw: parse secure section from firmware
 file
References: <20240203003251.10641-4-pkshih@realtek.com>
	<202402040350.rRpOepoU-lkp@intel.com>
	<e645b875c771216f688ae106abd5be86aff59b42.camel@realtek.com>
Date: Mon, 05 Feb 2024 08:47:04 +0200
In-Reply-To: <e645b875c771216f688ae106abd5be86aff59b42.camel@realtek.com>
	(Ping-Ke Shih's message of "Sun, 4 Feb 2024 01:31:45 +0000")
Message-ID: <87wmrjs907.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Sun, 2024-02-04 at 03:22 +0800, kernel test robot wrote:
>> 
>>    drivers/net/wireless/realtek/rtw89/fw.c: In function 'rtw89_fw_hdr_parser_v1':
>> > > drivers/net/wireless/realtek/rtw89/fw.c:384:88: warning: format
>> > > '%lx' expects argument of type
>> > > 'long unsigned int', but argument 9 has type 'int' [-Wformat=]
>>      384 | "section[%d] type=%d len=0x%-6x mssc=%d mssc_len=%d
>> addr=%lx\n",
>>          |                                                                                      ~~
>> ^
>>          |
>> |
>>          |
>> long unsigned int
>>          |                                                                                      %x
>>      385 |                             i, section_info->type, section_info->len,
>>      386 |                             section_info->mssc, mssc_len, bin - fw);
>>          |                                                           ~~~~~~~~
>>          |                                                               |
>>          |                                                               int
>
> I looked for how to print out differences (subtraction) of points, and
> "%tx" is the desired format [1]. I corrected this by v2.
>
> [1] https://docs.kernel.org/core-api/printk-formats.html#pointer-differences

Heh, never heard of %td and %tx before. Thanks for teaching us :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

