Return-Path: <linux-wireless+bounces-9598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF00918022
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F799B2175C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C917F4FE;
	Wed, 26 Jun 2024 11:48:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE5139D04;
	Wed, 26 Jun 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402535; cv=none; b=UcQBNZEleeelt63Jw1kUifXo/BHK5B7QUir5gCkqe1ADZNqcTm711tc4tOoAIlJDsLP18i3joI6px4Y29T4BKqThBWF8mmMA39lcdgXJrwQOUIbSCPiekgARk9/U5OgdBhSL1xppuaSDHt0CKvD+iEkWhAF4p6s7QfcDT5Q2fjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402535; c=relaxed/simple;
	bh=Vqkr6hGfHad+QM7GE0b8RRg3bQ8TXlXIDdAK+Y7C94A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJOXWOv5eHp/hKzO0Gsc/1kH3PEcHNb9qzcvfCBF7wHSbOy0wkwkajpSxe7eFutHnA2lF3VK73eguBOxa2Fiaqv1y1jYMkEMHdbhvKd0fcBghtQ4UE9yZOLaPJTg4r43tto1iTT+fr+BEpX1vTWqjSGe9gLd+8nJ8yfiP5NI4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 58C2561E5FE07;
	Wed, 26 Jun 2024 13:48:02 +0200 (CEST)
Message-ID: <d19d520c-547b-46c1-b59e-748c2cccaf53@molgen.mpg.de>
Date: Wed, 26 Jun 2024 13:48:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
 James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Hui Wang <hui.wang@canonical.com>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
 <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> <87iky7mvxt.fsf@kernel.org>
 <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com> <875xu6mtgh.fsf@kernel.org>
 <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
 <082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
 <878qyshuud.fsf@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <878qyshuud.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kalle,


Am 26.06.24 um 12:16 schrieb Kalle Valo:
> Paul Menzel writes:
> 
>> Am 26.06.24 um 10:53 schrieb Baochen Qiang:
>>
>>> OK, there are two issues here:
>>> 1. invalid HT rate: "ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2 mcs 7".
>>> As commented by Wen quite some time ago, this has been fixed from
>>> firmware side, and firmware newer than [ver:241] has the fix
>>> included.
> 
> I assume this means that the firmware version
> WLAN.RM.4.4.1-00241-QCARMSWPZ-1 or newer has the fix.
> 
>>> 2. invaid VHT rate: "ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9".
>>> After checking with firmware team, I thought this is because there is
>>> a mismatch in rate definition between host and firmware: In host, the
>>> rate for 'nss 2 mcs 9' is defined as {1560, 1733}, see
>>> supported_vht_mcs_rate_nss2[]. While in firmware this is defined as
>>> {1730, 1920}. So seems we can update host definition to avoid this
>>> issue.
>> 
>> Looking through the logs since May 2024, I have four different logs:
>>
>> 1.  invalid vht params rate 878 100kbps nss 3 mcs 2
>> 2.  invalid vht params rate 960 100kbps nss 1 mcs 9
>> 3.  invalid vht params rate 1730 100kbps nss 2 mcs 9
>> 4.  invalid vht params rate 1920 100kbps nss 2 mcs 9
>>
>> I believe it’s only happening with Cisco networks. I am happy to test
>> a patch.
>>
>> By the way, is the firmware version logged by Linux?
>>
>>      ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1a56:1535
>>      ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
>>      ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp crc32 bf907c7c
>>      ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
>>      ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
>>
>> Is it 4.4.1-00288?
> 
> Yes, that should be WLAN.RM.4.4.1-00288-QCARMSWPZ-1. But I don't know
> why 'QCARMSWPZ-1' is not printed by ath10k, maybe we have a bug
> somewhere.
> 
>> How can I find the file in `/lib/firmware/`?
> 
> It should be in ath10k/QCA6174/hw3.0/firmware-6.bin.
> 
> All firmware releases are available here:
> 
> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware/-/tree/main/QCA6174/hw3.0/4.4.1?ref_type=heads
> 
> And more info here:
> 
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/firmware

Thank you. It looks like the latest firmware version is 309, and Debian 
sid/unstable still ships version 288 in *firmware-atheros* 20230625-2 [1].

Unfortunately, there does not seem to be a change-log for version 309 
(or any version for that matter). I am going to manually copy it anyway, 
but it’d be nice, if I knew what to expect. ;-)


Kind regards,

Paul


[1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1074308
      "firmware-atheros: QCA 6174: Newest version 309 missing"

