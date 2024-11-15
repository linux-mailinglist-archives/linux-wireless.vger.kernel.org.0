Return-Path: <linux-wireless+bounces-15324-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9A9CDD10
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 11:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758F8B24CFF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325A1B3920;
	Fri, 15 Nov 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Lt6LSMoK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B3136338;
	Fri, 15 Nov 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668144; cv=none; b=Abxmzbb+KAIY0WLjADVha/K+a9PEkj2AHVQo7iV25hmwhpb+/vCSgm/nw1USGK/Nc7rAu86IsvTcQQ4A0U36MHVV/Ig4/f11UAwlXOvwaKfzBQOp+y/agT2MTG6N6Ys7Fa1RGL+WbnZ3nObOWG2nnbD52dXeTOOe5FwzC6ehvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668144; c=relaxed/simple;
	bh=7pJa2BsQ8b5xkSAQMM5pofcqK61ow5jhOB4wej/1srM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+JJqbcIo8SXl63V8MfQiQ0kYUHbA6lxjAYNBYEYNy8aixNtGsom0ysgvHpElX+f2YLNHm1PRZ6lidylPscU+KXiKH0jCLSOjzoD4wUaPfXMe1y0Rgi99kjsDl3YARmTNSSZDBNyB6+hppdjvopJ3TZb6jvbV2C2SXevnkP8OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Lt6LSMoK; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=7pJa2BsQ8b5xkSAQMM5pofcqK61ow5jhOB4wej/1srM=;
	t=1731668142; x=1732100142; b=Lt6LSMoKrF+HHJcBHi7hwxnvRpeeffNrChm3UNGeH2hbhsi
	7NlFVacaRYW5iWUTFf7bF8XJuPWgoE5JTnxLaQwiZz7Sm3OVMGswnznnh64B25bZ06RCfcLOx+eTo
	qvxdz30kzaxLhEGFFFG5oHYH5mjEqoqcgqvxBMICw1GGM5PjN19lq9wI45tH/O36zzDKjwLYQaL3u
	RyavIxeOAIuHvV6wrDmt7P3oAGLheD8CBkBMqkZ6taIkLEmRyxqo98qCaNEWAzL2DWgBsbFb1Ir+r
	vB9U1vRqFj6a7M+ZGfUKssz5apYzHxcyD8xO6rajc+sbRh/scvldJWrruATS0rRw==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tBtzG-0008Ij-PB; Fri, 15 Nov 2024 11:55:38 +0100
Message-ID: <3fac9b27-829c-4357-8d82-2b5789b35216@leemhuis.info>
Date: Fri, 15 Nov 2024 11:55:28 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrey Batyiev <batyiev@gmail.com>, linux-wireless@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Kalle Valo <kvalo@kernel.org>, Alf Marius <post@alfmarius.net>
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
 <87wmhg61yp.fsf@kernel.org>
 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
 <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
 <87ttcauv7x.fsf@kernel.org>
 <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
 <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
 <8a647709-8c33-4ac9-92da-bbf83ae2ed93@leemhuis.info> <87bjyhr1s9.fsf@toke.dk>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-MW
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87bjyhr1s9.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731668142;1df3a95b;
X-HE-SMSGID: 1tBtzG-0008Ij-PB

On 14.11.24 21:36, Toke Høiland-Jørgensen wrote:
> I understand your frustration, certainly, and I get that you are tasked
> with a thankless job in trying to improve the regression handling
> situation. However, I also agree with Johannes that by letting your
> frustration shine through [...]

Thx for the mail. Yeah, you are right, apparently my frustration took
more hold of me than I was aware of/willing to admit.

Apologies to everyone I steered up, I'll try to do better.

Ciao, Thorsten

