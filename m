Return-Path: <linux-wireless+bounces-17090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A2DA01BCF
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 21:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF593A2880
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Jan 2025 20:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB74487BE;
	Sun,  5 Jan 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfMAJpT9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493C1DFF7;
	Sun,  5 Jan 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736109392; cv=none; b=vDkEWDc6ZDF+SE4SosL2JpLadJF4E5qdajjpLLwozPSDbJ2Uko4JkLtGigJczcIJcLRuYIl32DA5oO4OnEny7zf0Rqvu5LSbTU6ju2ktfg7OD0Q4EfyuwoDtLaxGleycveglsrGLVU/HekJ+I1yxyyzuEhy6nsxwqjnR09lzrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736109392; c=relaxed/simple;
	bh=S6PL9azbDLY3+boHvglzcBPv7gzG8yfk1zbtPE3W0Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=os77WvN52n851w0gHXpTX71LcIvh91xNz0K8xFyyHzE6DdSL1ug2wuH6aFBm42TopdEeB0KEJfY5xHuVMObwr02GY5XvkDtTbrrR5CVbVcVuG7R8qgO+G/rjFtR03TlWaHJQvyqJOjZjZpe7anxcP/Qa0uVWyhUqueYt5EhOtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfMAJpT9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862f32a33eso6241139f8f.3;
        Sun, 05 Jan 2025 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736109388; x=1736714188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwH3RZFe2BktFoy07d1gpQ7MnzbeUTFaBLZgq+R0qb8=;
        b=ZfMAJpT91nKmWapwTEbsCOk3bnYGJjZd5gMcTlqrrThNAzCk0SjE+TB1TJ/ErY6eJo
         Rd6hYteS91AJin5/Ub37QKWtCqqyTVHd/VSfDT56phdds4yM7+muRS3KRAPotMVFfeM9
         BjhxkPyLAQBzeIOVvDiYEXcs8WSU6x7+AuLBCPMzviRujbwQKHcEEbHcHNZ4zV7/xyhF
         DVvoWD4+Ug48A7u+pHTyjvv3bqH9ziqOqcpT/PzFPyrMTLK7K+TY/UZlx1luLLp3/X9F
         05P823jx4r4a1ULRD/P+vM6uPSGdEgTOjrioqNQIx+HM490CwjRV0DpsHAXPZZ6SRqmS
         H3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736109388; x=1736714188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwH3RZFe2BktFoy07d1gpQ7MnzbeUTFaBLZgq+R0qb8=;
        b=C1CEZ9cX4d6yPDlhfKbloI5hmMSXbhbeiIShSzyOg/QpF+BMRCayVrH35ZGdEzusU3
         CQTHsOiG+R5S3ccopUUtPlAF8taBnSTqW+yARwwTw8cRukmHJ99hr0UZq34HNCLNCA6A
         RDTzbL8fgw8XwuYSftIzXncBpVCpik7Tudd/vvSNKfWB/B4VmpxBY/zCvcxeQR+ICegp
         6f7FiKJV8tOygFEMJPEBDY0Jqi9julT86LaO5pl8zRdGyq5VK6H5T2FXFDQhhKlyt2nL
         KvZWWV5zhB6sKof8UpX05CLOFX5uRAN61j7ZYT3yfzRTWXvcqIy6D0h55uOAe4O2iTiH
         3LqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeQbNHKc6Gln02jgUVJOfeTcLQQ78wJz5m0SJakdD8ToTpfy0slG781zLFl3Xs2qpkJ5rlywAJ/ognS88=@vger.kernel.org, AJvYcCXDviPyw3krAaEeZjSAITJwFv4z0hj7QbzZxngwxyBejwUxHY5/Nx9WvRqSE7NEdtKtHq0gG86IWI8ti3gZG9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnOWfoZgHP8ZSXztxvvNIftl1pbTx77HPrJo0oix0Wq5tD5ng
	JHTyg58IMhoDsV2gsX7M8mMkFcPHVXYHGMS0iNBhb92AMQRQnrSF6aXF
X-Gm-Gg: ASbGncsrmsojV2FD1Xd66vwLvcF+nE1PCk91QHzIFdFILr3x2F7sV7Fw7pLW8BCfspk
	6xMEpuse9xtqlLbLVADRpIfm6Zce1NyRigypVnRKzS3lMFjrJhk3xrSaLUujj0SjBsDPfL5vEAD
	9NA1881jHyhou3NCys6IhIjSyLpRehOTC71p1MSoGL3ZRlf/GwTHnd62MxSfqoTpul6VdKB0iHS
	Uj0ESMGc8wDF4cPcmYdvDIpqv9C/WnhlELd43ifvwgnPkxkIN7jdZjw5NJeLfYXePzx8joBDYi9
	/DCSxLxm0hfGqaWFfXYb5NfKCvc=
X-Google-Smtp-Source: AGHT+IGl1KFrG8GqB0lzghJS7nLNBPOCQzLF3a2WrKlpRdfTmJxuVbGClwL+KJqS99DeDbrFVfsP7w==
X-Received: by 2002:a05:6000:188e:b0:385:f840:e613 with SMTP id ffacd0b85a97d-38a223fd52dmr41095373f8f.51.1736109387181;
        Sun, 05 Jan 2025 12:36:27 -0800 (PST)
Received: from ?IPV6:2a02:810b:f13:8510:e2f9:74c0:93aa:b442? ([2a02:810b:f13:8510:e2f9:74c0:93aa:b442])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8289a0sm47510488f8f.7.2025.01.05.12.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 12:36:26 -0800 (PST)
Message-ID: <3f47bf7d-c8b1-464e-a824-406c4f66ee0a@gmail.com>
Date: Sun, 5 Jan 2025 21:36:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: brcmfmac: of: Support interrupts-extended
To: Luca Weiss <luca@lucaweiss.eu>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-kernel@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
References: <20240622215416.659208-1-knaerzche@gmail.com>
 <4660783.LvFx2qVVIh@g550jk>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <4660783.LvFx2qVVIh@g550jk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luca,

> Hi Alex,
>
> On zaterdag 22 juni 2024 23:54:16 Midden-Europese standaardtijd Alex Bee wrote:
>> The currently existing of_property_present check for interrupts does not
>> cover all ways interrupts can be defined in a device tree, e.g.
>> "interrupts-extended".
>>
>> In order to support all current and future ways that can be done, drop that
>> check and call of_irq_parse_one to figure out if an interrupt is defined
>> and irq_create_of_mapping for the actual mapping and let it be handled by
>> the interrupt subsystem.
> This commit seems to break WiFi on qcom/apq8026-asus-sparrow on 6.11.11
> release, and I'm guessing also other apq8026 devices that I have.
>
> dmesg looks like the following on this board:
>
> [   33.699503] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
> [   33.811445] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
> [   36.565674] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> [   36.565725] ieee80211 phy0: brcmf_bus_started: failed: -110
> [   36.565777] ieee80211 phy0: brcmf_attach: dongle is not responding: err=-110
> [   36.575930] brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
>
> After reverting this commit it works well again:
>
> [  141.299739] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [  141.355040] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [  141.364695] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [  141.469042] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
> [  141.612365] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
> [  141.730597] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
> [  141.730661] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob available (err=-2)
> [  141.731778] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/1 wl0: Jun 23 2016 21:14:35 version 7.10.324.google.security.test (TOB) (r640416) FWID 01-495ddd98
>
> Would you have a different solution apart from just reverting this commit?


it's very likely that the interrupts are wrongly defined in the device tree

and nobody noticed it yet because the driver didn't pick them up before
this commit.

In particular, looking at qcom-apq8026-asus-sparrow.dts: I would guess that
the IRQ_TYPE_EDGE_FALLING trigger doesn't make much sense if this pinctrl
is set to bias-disable.

You could try changing this to IRQ_TYPE_EDGE_RISING. If changing the IRQ
trigger flag doesn't help, you should check if your board's wifi interrupt
pin is really connected to gpio46.

(Please don't forget to submit a patch if you can fix the problem)

Regards,
Alex

> Regards
> Luca
>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>> Link to v1:
>> https://lore.kernel.org/all/20240621225558.280462-1-knaerzche@gmail.com/
>>
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> index e406e11481a6..fe4f65756105 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
>> @@ -70,6 +70,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>>   {
>>   	struct brcmfmac_sdio_pd *sdio = &settings->bus.sdio;
>>   	struct device_node *root, *np = dev->of_node;
>> +	struct of_phandle_args oirq;
>>   	const char *prop;
>>   	int irq;
>>   	int err;
>> @@ -129,10 +130,10 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
>>   		sdio->drive_strength = val;
>>   
>>   	/* make sure there are interrupts defined in the node */
>> -	if (!of_property_present(np, "interrupts"))
>> +	if (of_irq_parse_one(np, 0, &oirq))
>>   		return;
>>   
>> -	irq = irq_of_parse_and_map(np, 0);
>> +	irq = irq_create_of_mapping(&oirq);
>>   	if (!irq) {
>>   		brcmf_err("interrupt could not be mapped\n");
>>   		return;
>>
>
>
>

