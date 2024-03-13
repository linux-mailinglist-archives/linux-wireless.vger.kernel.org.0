Return-Path: <linux-wireless+bounces-4683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3287AAB3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 16:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF60DB21A43
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67FC482FE;
	Wed, 13 Mar 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFYjawc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C73481C6
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344937; cv=none; b=hG84u1OlfaMTWVTx2/MEmq5ysckGX44H2MBM0MBSfCg3uuQMwxDHinm2xU/ixyh353o1OJ/fRgvUC3qL00BApxmNUf8M9glBkXMd2QPF7xqX/R9MRo5BhISNHFSkCsezwY2GktaJGeBECVL+JUoUNunMHN5c417dkHbUE93V12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344937; c=relaxed/simple;
	bh=Zvgg9s54JQ66k5XEWGPZHQY1faeSamcPZ7cushNifPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy4aJO0dPH28MPpnAsBL61+xwxgjZzGaBgRGdaDJYIeaUWm7otEEielMHF/Fm6ibufLluQDR513Lle7k3UFHJTmCNSKQV/UJtGbh0MwYCcsarfXEkNrqN+Tt6a9YS6053zF85zGDpOdwVwJrGAUYo1z6XzV5QC9xc8tg7gLHQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFYjawc2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512f3e75391so5367222e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710344934; x=1710949734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3XCjorAqzhcxtTE1akOhucpm0x01G9s1mIo5Dg2lCY=;
        b=EFYjawc2JJUlj9cJtwdoMR94C2VccFeIYQuzpU6Y2/l3ZzCuTs4BGx2LrcvjZOMkcS
         XuXcnFt/rrntWH1N4IVLuk/U9nT+2tLnhS2tl8fb2Tf29NbpVtKR4QqC9hNPCvKsa+GR
         5iKkVew2ZLk0IZCzH76wm57+nm3I/khtVDbjGT2gAVe35th2dUxuHBO2BgJ3K5lzLs9U
         TAl7taV+aTPwPVoow7yG4z2MvPOfIof0whL/EN5zDj7SpkDEis1t6oyX8TQSBhoZsPBL
         Zx7rVoihLIwOUDs6IzXThOTKOjKU/XuUGQY+MS2XGIe+Lul2p2X3wStk+qVp2wIO+8qB
         hJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710344934; x=1710949734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3XCjorAqzhcxtTE1akOhucpm0x01G9s1mIo5Dg2lCY=;
        b=tGECl7hVBD7/IlnWkXswid3v5975iZOnZfVIIjEXKjX5GDk0339IXjWcwevCZrIwv7
         QJko4V68NtIP6bvq3nyCmMxFJz/GRmNJmxlEsOkT6iDkianrDdFrO1x+tqJQgBZJkCfq
         acT0LisDAWrrCIwDeTEbrhWGIGq03rtrsQLyU6TYrXYSA3ZSw1aJ9oNBF3MSV5oyiNmV
         FT4vN6kF2uHM/Y2ijTuvlAS92ZwFJqg8wg5mKgG0p3rqrazOi2pTRpX/GtEAdPNdHGQr
         74Ckqs3jC+Kzpq3MZmAOvNynSK5cHzqx3HfXxlXCRmpCJP7OW3Sh/mD7NT6ogh2VbwcB
         HiQg==
X-Forwarded-Encrypted: i=1; AJvYcCXuZhhaS/vFiMt8WDamO4f51xL4PWtquAjpw0Swf9E6UChMPciZH09jB6mVv+VcRkCSxrGkfdS95QVQMVvXi4nt32oN6GzwmoBBSJJnylM=
X-Gm-Message-State: AOJu0YzMYU9xAxnnP8LRT0LMR+eZvkVr8DjQCw3NGaora8Yu8lrftG1/
	mNaKr/PTwfgl2FJfAdXWgBriQ96WfRmEm3EXLCDv2EbztPy8lMm2YmW/ydfJ9Rs=
X-Google-Smtp-Source: AGHT+IHHLDk70u2yvkuLwHNM/FOf86eDOT5Ekd8mF4BEzMYEvlggbO2zOgvdld4YCTq7vDP+w97Lzg==
X-Received: by 2002:ac2:4823:0:b0:513:4705:a4f3 with SMTP id 3-20020ac24823000000b005134705a4f3mr3726441lft.65.1710344933982;
        Wed, 13 Mar 2024 08:48:53 -0700 (PDT)
Received: from [87.246.221.223] (netpanel-87-246-221-223.pol.akademiki.lublin.pl. [87.246.221.223])
        by smtp.gmail.com with ESMTPSA id u12-20020ac25bcc000000b00513c68b20e9sm470609lfn.188.2024.03.13.08.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:48:53 -0700 (PDT)
Message-ID: <111bc38e-aa9f-4be6-9415-9d510e66250b@linaro.org>
Date: Wed, 13 Mar 2024 16:48:50 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
To: Marc Gonzalez <mgonzalez@freebox.fr>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/13/24 16:09, Marc Gonzalez wrote:
> [ Dropping the DT fellows ]
> 
> On 05/03/2024 20:20, Kalle Valo wrote:
> 
>> Marc Gonzalez wrote:
>>
>>> I need to build a kernel + rootfs + FW to test the proposed solution,
>>> then I can spin a formal submission.
>>
>> Yeah, please do test this to make sure we are not missing anything :)
> 
> I used buildroot ( https://buildroot.org ) to generate a kernel + rootfs
> for my board (a variation of qcom/msm8998-mtp.dts)
> 
> Not sure if I must use the vendor FW blobs? Or if I can use the blobs
> from linux-firmware-20240115.tar.xz (as supported by BR2).
> 
> 
> All I see from the ath10k driver (with debugging cranked to the max) is:
> 
> [    0.539801] ath10k_snoc 18800000.wifi: Adding to iommu group 0
> [    0.541941] ath10k_snoc 18800000.wifi: snoc xo-cal-data return -22
> [    0.543633] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not found, using dummy regulator
> [    0.544002] ath10k_snoc 18800000.wifi: qmi msa.paddr: 0x0000000094400000 , msa.vaddr: 0x(____ptrval____)
> [    0.544271] ath10k_snoc 18800000.wifi: snoc probe
> 
> 
> # ip link
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
>      link/ether 34:27:92:82:48:ec brd ff:ff:ff:ff:ff:ff
> 
> No wlan device at this point.
> 
> I got shell-shock from reading these setup steps:
> 
> https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_835_(MSM8998)#WLAN
> https://github.com/jhugo/linux/blob/5.5rc2_wifi/README
> 
> 
> Jeffrey, Bjorn, Konrad,
> Has someone written idiot-proof (such as myself) steps to enable
> the ath10k core on a msm8998 board?

$ cat /tmp/x.json
[
         {"names": ["bus=snoc,qmi-board-id=stinkyboard"], "data": "board_stink.bin"}
]


$ ls -lh board_stink.bin
-rw-rw-r-- 1 konrad konrad 19K Mar 13 16:42 board_stink.bin


$ python3 ~/qca-swiss-army-knife/tools/scripts/ath10k/ath10k-bdencoder -c /tmp/x.json -o board-2.bin
board binary file 'board-2.bin' is created

I believe Kalle aggregates these boardfiles and then uploads a big
combined board-2.bin to linux-firmware nowadays?

Konrad

