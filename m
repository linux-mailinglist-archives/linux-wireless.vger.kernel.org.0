Return-Path: <linux-wireless+bounces-10689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44719941903
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 18:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FE11F23855
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 16:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003711A6160;
	Tue, 30 Jul 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTAr9yz7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FF1078F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356876; cv=none; b=OgS7CW/8ij0hZGLV4UXXv3lqEGoEnTAauLGlhEPj7Y9mX50p52wCeLBXyLC28Cfkkk4a3jw6fKK7B+G9krmd0JDsBentXGulOj8bmrq1UKT47zUg+vkyT1NqQGvyw//C/52ZV+YE1L8CtETs0by5LpCXWudQLmtoiWrODcdS7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356876; c=relaxed/simple;
	bh=8PygYswFZPPTs/7xvBnDe8rF1GuAYw8rgs9nScBZjEM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZTzu/dKhN4SQxQSNGYc3vtkjJpNep4qplghZdMfUin3oJdFuzSMMPKw37oOLdWShouJhLEJbsnP++CNPsJf3FbEEojezkNzDjqGt+aJVfaKRtsx/16rWtEYcb3ftIB4gIGoT4QV5X5dy+4w2XJja2N6YFr3JBnSiZKtgvf9OeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTAr9yz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF6C4AF0A;
	Tue, 30 Jul 2024 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356876;
	bh=8PygYswFZPPTs/7xvBnDe8rF1GuAYw8rgs9nScBZjEM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gTAr9yz7Eu64uTXqh3ZSgtzVTUA2250p6OdFw50Aw9Oty2yaD2GLn5bbx+KH522U5
	 /KtYW4KVCVfi6O2W/OO6lAqJA9ONruIfPX1GMgFfuarjkyCjSLXP6tyh9HiCHICLmH
	 zwxxR5nU1DZYcnGCvN1Bnv+IlK4haN3mZtA/i0HDda4RdIec9LVPks6zzarOuIf2lv
	 UtXAftWZ5m+DQY5AkI22JtUf56XRtiWFhuDfDolEULxvRBejUER+NCyIlyuDYkU7d1
	 hgIfC1r6Rwp/2Uy0LsCh/aJDDw1z335SgSw32BWVasKu8cbxv4Rcf0VaVQ/iZjuB1v
	 Lo4NKXKMxJhCQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: Re: rtw88: The debugfs interface reads registers from the wrong device
References: <e28bbf72-678a-438b-b5dc-d4ae8b8f71f0@gmail.com>
	<77b8adc4-daa9-4869-8773-c5de9eb84299@gmail.com>
	<1d00170b5f0a39bdff6f759de300a402209ace03.camel@realtek.com>
	<cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com>
Date: Tue, 30 Jul 2024 19:27:53 +0300
In-Reply-To: <cd6a2acf3c2c36d938b40140b52a779516f446a9.camel@realtek.com>
	(Ping-Ke Shih's message of "Tue, 16 Jul 2024 02:56:03 +0000")
Message-ID: <87o76elu9i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Tue, 2024-07-16 at 01:19 +0000, Ping-Ke Shih wrote:
>
>> On Mon, 2024-07-15 at 14:26 +0300, Bitterblue Smith wrote:
>> > On 15/07/2024 14:05, Bitterblue Smith wrote:
>> > > Hi,
>> > > 
>> > > To reproduce the problem, you need a computer with two wifi
>> > > devices supported by rtw88. It's especially easy to notice
>> > > the problem if one of the devices is USB and the other is PCI,
>> > > because the PCI device will have various values in the
>> > > registers 0x300..0x3ff, but the USB device will have all
>> > > 0xeaeaeaea there.
>> > > 
>> > > 1. Let's assume the driver for the PCI device is already loaded.
>> > >    I have RTL8822CE.
>> > > 
>> > > 2. Mount debugfs:
>> > > 
>> > >    # mount -t debugfs none /sys/kernel/debug
>> > > 
>> > > 3. Check page 0x300:
>> > > 
>> > >    # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3
>> > >      00000300  f7138000    33330000    ffffb000    00000000
>> > >      .....
>> > > 
>> > > 4. Plug the USB device. I used RTL8811CU.
>> > > 
>> > > 5. Check page 0x300 again:
>> > > 
>> > >    # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3
>> > >      00000300  eaeaeaea    eaeaeaea    eaeaeaea    eaeaeaea
>> > >      .....
>> > > 
>> > > 6. Bonus: unload rtw88_8821cu and check page 0x300 again to get
>> > >    a null pointer dereference:
>> > > 
>> > >    # rmmod rtw88_8821cu
>> > >    # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3
>> > 
>> > I forgot to say: my kernel is 6.9.8-arch1-1 from Arch Linux.
>> > The problem also happens with kernel 6.9.8 plus rtw88 from
>> > rtw-next.
>> 
>> This limitation is existing since initial driver.
>> 
>> To read a range of large registers area, for example, we need to
>> a range via write operation and store as a private data, and
>> then use read operation with private data to read registers.
>> 
>> The limitation is because the private data is static variable.
>> A possible solution is to duplicate static variable into rtwdev.
>> Not sure if it is worth to adjust codes for debug purpose only.
>> 
>> Another easier solution is to avoid creating debugfs for second
>> adapter. How do you think?
>> 
>
> Think a little bit further. I will try to duplicate static variables
> to support multiple adapters. 

BTW in drivers all static variables need to be const just because of
issues like this. Static non-const variables are a big no.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

