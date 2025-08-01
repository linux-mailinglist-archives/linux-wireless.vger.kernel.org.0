Return-Path: <linux-wireless+bounces-26079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1764B18413
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 16:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C9B5867AA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5954425743E;
	Fri,  1 Aug 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8MyRUMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71520260582
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059187; cv=none; b=h2+avOcN7TX8aETQyTP3cH2A6kK+7AsKKFz0gp9Rj6bySE2WJDmC+FXZzwJC23OS0YvdqJisvuz2BZgHEQq9GFLp3I8weMVfCpibSycL6QPKvri3NfvjmMHk4U/kNViyUAsk/hN3g27TM3QkIRftFMOJs/VGCm0+Tvwebg/NNDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059187; c=relaxed/simple;
	bh=10qzaNCcX5ki4jnRLfJpEfT+mNVZ/j6fn5po/Jeka7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cIFNmk8f3Ki1c9ETHov4E2Pv8pjvQ5fAwsqdXpLXJWhpTdIMTPxoeoQinXr6rY5xgEw7OJXpjGyJbx6o4asLowfF9yvjvtgdZXc3MV8h06N8dRxhGuosF4Pkcsp8NhHThdB77YrFr15/0DwH5GM9m7XgHgS5YPkAQw8lgkFPVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8MyRUMp; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <198e2e23-5e75-4223-8d85-fba255bc7fd2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754059181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pBSw0WKzweVkoY0V8iO+0CLsPj7VR3/t2uf23FoQNo=;
	b=n8MyRUMps6RxDyy4e9iIgPfhWSKll6lxWXcxNC6wQCjHaRNlNuRLyhJVwoRDtMHNMlnun6
	EcQkJuQdo6EmSbs+n/RLHxeoqP19kUJIP/f1eI3hTYXiJtuHQ6H5AtFFhUhxgmKVwg7x7a
	2+hrnkPMkzPgCBJVs18YaUPE3fVTITM=
Date: Fri, 1 Aug 2025 10:39:39 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] wifi: rtw89: Print just once for unknown C2H classes
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
References: <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com>
 <20250729204437.164320-1-sean.anderson@linux.dev>
 <c034d5cc40784bfa859f918806c567de@realtek.com>
 <7865d95f-a92e-405d-bc71-f1e1382ad24c@linux.dev>
 <d0f6162ab34440cab0c11667be092609@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d0f6162ab34440cab0c11667be092609@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/25 20:30, Ping-Ke Shih wrote:
> Sean Anderson <sean.anderson@linux.dev> wrote:
>> On 7/29/25 20:36, Ping-Ke Shih wrote:
>> > Sean Anderson <sean.anderson@linux.dev> wrote:
>> >> There are more unsupported functions than just LOWRT_RTY. Improve on
>> >> commit 3b66519b023b ("wifi: rtw89: phy: add dummy c2h handler to avoid
>> >> warning message") by printing a message just once when we first
>> >> encounter an unsupported class.
>> >
>> > Once I encounter an unsupported class/func, I'll check firmware team if the
>> > C2H events can be ignored. If so, I add a dummy function to avoid the message.
>> > If not, I should add code to handle the event.
>> >
>> > Do you want to see the message even though it only appears once?
>> 
>> I mean, maybe it should just be a debug? Are these messages useful for anyone
>> other than the developers?
> 
> Yes, this could just be a debug. However, developers normally don't turn on
> debug mask, so using rtw89_info is to clearly remind developers to pay
> attention on this lack of C2H handler. And, I suppose developers must handle
> this when they see flooding messages.

Well, regular users get this too. It is really unnecessary to print
thousands of messages when they are completely benign.

>> 
>> Maybe we should just print only the very first unsupported message at info level
>> and print the rest at debug.
> 
> I'm afraid developers will ignore or miss the messages. To reduce messages
> is fine to me , but more important is to look up vendor driver to see if
> the C2H handler is necessary. 

OK, so we should print exactly once for each class/func.

--Sean

