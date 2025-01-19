Return-Path: <linux-wireless+bounces-17678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA575A15F89
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 02:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1547165B7B
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 01:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365984C92;
	Sun, 19 Jan 2025 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen-moser.de header.i=@steffen-moser.de header.b="yy/3JrUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dd54106.kasserver.com (dd54106.kasserver.com [85.13.166.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001BDD515
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.166.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737248646; cv=none; b=Ytahp37UhOgMwxWEOEBjrrOdizEvjDSMAJXc3MAOKKFcgXuEN1xxs6CcTvhemP4TV0/rhTjwF6ff2EmPo7/vxbsXVePj7sFVo9eZUCFdGKcVawMJc9LTCVt4g8r4faMHTahdCXxCV9ruhjV9EfAkXz8lXTzzZmuRf3mNZRa+h2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737248646; c=relaxed/simple;
	bh=FLYolM5kn0CDNvaFWx54AxPFgB+G7U+WrPEKP6CG22U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCsF67EUISPRSGXHWd5yfcisN75MhmtHQ4HhsCEcWkNLu+TFAlOEWJfsprqVu8/gxdsj88sRt4Pi14sG9tgV4NtYcvZmkthxZdsqhnIAkdls4I9VMpxzCQwQ7KrNIz8w8RZMNwHK/rwWuydUzmtMC3zfTwuVYJ0TPA3wB8QlS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=steffen-moser.de; spf=pass smtp.mailfrom=steffen-moser.de; dkim=pass (2048-bit key) header.d=steffen-moser.de header.i=@steffen-moser.de header.b=yy/3JrUy; arc=none smtp.client-ip=85.13.166.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=steffen-moser.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen-moser.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen-moser.de;
	s=kas202408292216; t=1737248131;
	bh=8BOzZKmL8ZI+fceofBNwktY/tVagVG1zjtXb36neCH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yy/3JrUyv7QCVFWACNI03JU6bCnTaC2XjqTru4nNNY39jvr3terFKD6MlTEpcwLBB
	 khMJGnlV7pGc6+yf2balK+Lv9aXsnA9X1CznCdKMCNGKjYWrPUtym3q4fboj65/6cH
	 d7rCOWO02CHBzurqSgyiWDEhtrUBFzt6a5xp3uQnqike6kOPY98lD8Ma7Lcqw1AdQ0
	 YXLuX3DdKLdIpsB8KiW0q6WjUduf6O9bqVYb3IbjBvIeX/ktkPLAhf6QwPXqDXLFIN
	 jSaC87x9OCvD1YyF7EheRiZ74NYvxXhohgIAHkYuAPQ+A84W/CR+T/f/bO6g2ytom4
	 1Iwxz998YqNcg==
Received: from [192.168.1.101] (p54a37daa.dip0.t-ipconnect.de [84.163.125.170])
	by dd54106.kasserver.com (Postfix) with ESMTPSA id C5A3AE4A4EC7;
	Sun, 19 Jan 2025 01:55:31 +0100 (CET)
Message-ID: <a996f6bc-622f-4bf7-9c7a-84a1df504474@steffen-moser.de>
Date: Sun, 19 Jan 2025 01:55:31 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k with
 IPQ8072A (QCN5024/QCN5054)
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
 <Z2Q9POuV-6MIdzRf@pilgrim>
 <b18ede18-0c33-4d14-a7c5-0066cbec39c9@steffen-moser.de>
 <D6VX7M6MGZQB.3LU3FBYJK6CZH@gmail.com> <878qrkdsr7.fsf@kernel.org>
 <D74L8O64EGM3.2CXM7VKQA8O92@gmail.com>
Content-Language: de-DE
From: Steffen Moser <lists@steffen-moser.de>
In-Reply-To: <D74L8O64EGM3.2CXM7VKQA8O92@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++

Hi,

I’m not a kernel developer myself, but from a formal perspective, it 
looks good to me. Unfortunately, I don't really know what the patch was 
for originally. Maybe reverting it brakes something.

Best regards,
Steffen


On 17.01.25 8:17 PM, Nicolas Escande wrote:
> On Thu Jan 9, 2025 at 2:25 PM CET, Kalle Valo wrote:
>> "Nicolas Escande" <nico.escande@gmail.com> writes:
>>
>> > On Sat Dec 28, 2024 at 11:13 AM CET, Steffen Moser wrote:
>> >> Dear Remi,
>> >>
>> >> thank you very much for the pointer to the patch. Sebastian integrated 
>> >> it into DD-WRT. Now the DynaLink DL-WRX36 runs absolutely smoothly, the 
>> >> WLAN links are stable, the packet loss is gone. No weird states anymore, 
>> >> independent from the group key exchange interval:
>> >>
>> >> https://data.saps.uni-ulm.de/index.php/s/NLNpWqjc8iGsaEM
>> >>
>> >> So your idea was a direct hit! Thank you very, very much. Several months 
>> >> of debugging have come to an end...
>> >
>> > So this is at least the second time this commit breaks a setup.
>> >  
>> > @ath11k why isn't this pushed to mainline ?
>> > This seems to be a clear regression, so even if there is no need to rush things
>> > in the long run this still needs to to reverted mainline right ?
>>
>> Good question, I don't have an answer to that. Could someone (also
>> outside of Qualcomm) send a proper patch ASAP so that we can solve this?
>> And it's good ot include the link to this discussion and describe the
>> symptoms the revert is fixing.
>>
>> This is the patch in question:
>>
>> https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-the-keys-properly-when-DISABLE_K.patch
> 
> Not sure if I did it the right way but it at least is here :
> https://lore.kernel.org/linux-wireless/20250117191455.3395145-1-nico.escande@gmail.com/
> 


