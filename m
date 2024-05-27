Return-Path: <linux-wireless+bounces-8085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B28CFE0F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 12:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B61B23D1C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30513BAD4;
	Mon, 27 May 2024 10:25:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2CF13B2A4;
	Mon, 27 May 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805540; cv=none; b=LkqSJR9H+Nx3XOTvlWt9aai9N4Q3byrpARvLJFt62wvhakE+/aWFQBD8Zu57pcf1UV1CTmYoRUwzMmoGMZXrTYo/tiQS5x01WTx9yo573LuRAC2ybW1DFRSFbvIvXiSlIjIHVtfdB6L3UCRCe2iiBu7AvhwdmMHl2wneZjq1PP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805540; c=relaxed/simple;
	bh=IZP9GwLFHYwsUxISgzy2RcJobADfDP06LD39FBZVelc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbXOLTpKH4QJ70egzY+NlMkLfEphLfaMLwsbH4Ixcd7b8AMtBEHmwRYhVFUiBvisklbJ6SS2XJ1VUUmSFPyzDq4ze6S8XqPMrcabFesb6MLQi2iiQXOt3Od6WXmzNEtpaHRcLiu1X0ZQjE1J8SGYDKuEayNIv3cDo2awjauj1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.56] (g56.guest.molgen.mpg.de [141.14.220.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A5E861E5FE01;
	Mon, 27 May 2024 12:25:00 +0200 (CEST)
Message-ID: <96828117-2cf8-4a34-a8e6-78ace96b32d3@molgen.mpg.de>
Date: Mon, 27 May 2024 12:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k_pci 0000:3a:00.0: Could not init core: -110
To: Kalle Valo <kvalo@kernel.org>, Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 James Prestwood <prestwoj@gmail.com>
References: <0c544b16-5c0d-4687-9f96-8ff1f3269f79@molgen.mpg.de>
 <e1bc0bb8-a66e-4e03-bc22-3dc506b6fb59@quicinc.com>
 <87sey38vte.fsf@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87sey38vte.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kalle, dear Baochen,


Am 27.05.24 um 11:10 schrieb Kalle Valo:
> Baochen Qiang writes:
> 
>> On 5/27/2024 4:42 PM, Paul Menzel wrote:

>>> On the Intel Kaby Lake notebook Dell XPS 13 with
>>>
>>>      3a:00.0 Network controller [0280]: Qualcomm Atheros QCA6174 802.11ac Wireless Network Adapter [168c:003e] (rev 32)
>>>
>>> with at least a self-built Linux 6.9-rc5, on April 26th, 2024, and
>>> Linux 6.8.11, today, May 27th, 2024, the error below happened, and
>>> the device couldn’t authenticate to a WiFi network until reloading
>>> the module *ath10k_core* and *ath10k_pci* (didn’t check just
>>> *ath10k_pci*):
>>>
>>>      $ sudo modprobe -r ath10k_pci
>>>      $ sudo modprobe -r ath10k_core
>>>      $ sudo modprobe ath10k_pci
>>>
>>> ```
>>> [   49.441618] ath10k_pci 0000:3a:00.0: wmi service ready event not received
>>> [   49.523814] ath10k_pci 0000:3a:00.0: Could not init core: -110
> 
> [...]
> 
>> Are you using a distro kernel?

The 6.8.11 is Debian’s current Linux kernel in the suite *unstable/sid*
(*linux-image-6.8.11-amd64* 6.8.11-1).

>> Could you check if below patch merged in your kernel? if not can
>> you merge it and try again?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath10k?id=e57b7d62a1b2f496caf0beba81cec3c90fad80d5
> 
> Paul, if you are feeling brave to try out an -rc this commit is in just
> released v6.10-rc1.

Thank you. I haven’t found out yet, how to reproduce this. I’ll keep an 
eye on it.

As the commit message says:

> This results in timeout issue if the interrupt is not fired, due to
> some unknown reasons.

There are reports from 2016 to 2021 with similar symptoms. These were 
supposedly fixed with 
`/usr/lib/firmware/ath10k/QCA6174/hw3.0/board-2.bin` [1][2]:

     $ md5sum /usr/lib/firmware/ath10k/QCA6174/hw3.0/board.bin 
/usr/lib/firmware/ath10k/QCA6174/hw3.0/board-2.bin
     cb37c63d9ca28f53fea1ff09ad7c7a82 
/usr/lib/firmware/ath10k/QCA6174/hw3.0/board.bin
     651e921b372848b3928621e6f1d34b01 
/usr/lib/firmware/ath10k/QCA6174/hw3.0/board-2.bin


Kind regards,

Paul


[1]: https://github.com/kvalo/ath10k-firmware/pull/2
[2]: https://github.com/linux-surface/linux-surface/issues/41

