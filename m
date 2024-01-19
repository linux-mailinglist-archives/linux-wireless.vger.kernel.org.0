Return-Path: <linux-wireless+bounces-2275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9349832EA1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 19:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137791C2473C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC8955777;
	Fri, 19 Jan 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHZEV3Ob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2602524B3
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687675; cv=none; b=i5DZ6Bl1Xs78YnJgCzmOF4JbSOlLxnn2yjOqQYwIuPD50VBIFSk6CJhiT0Rx9/c5cX/R4cb/Y5Lm2Onn1uzN+RodHOose4fdGi9MLEWilEvoP6ii/HWrMpH6a04mSPsMtu83pTqCk2yLzHgdVGX653jmGqmc22YIbMjhVUVqokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687675; c=relaxed/simple;
	bh=uicVqSnE3R747Gw5dZh5icsv5vOFFguGux1+suuxBus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUsYSu2jGN+TvNZ1rpgzfcVdl/osvzDMhichVGNIFRNjctk2DItsHnAXCmxGcGv49cDp8acAkD3xZcj80FLzeFJsZjd+pQ69qC1mCzMjlZN2V15mtjhx09YBtM4lePvdgfyqRLb00BmMLs+psJWN+gI9E3dZWXMG/aNTwpkLtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHZEV3Ob; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7beda6a274bso41582939f.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705687673; x=1706292473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OouLsUncXdro84LkucUunUlvqGOy/RT1zxKH4rfrFVI=;
        b=YHZEV3ObkASzkKNFakNbKKBoLV4bMzNTbUnNYKy0Zqe+/hbzfkKal6gCED5zCfE+0x
         toFJU3g0J/6jb7B6ZGcYSGEA6K2dQj/XCBJqvZ04Lln4KFn6OHaGnNPzt5MLKi/Ubejt
         aj1kbEsDtplzeyjLJS0ctusv41KY+wtA2kgELon30u04coLlcerit2elbl2Md9wbV4w9
         QV7Fnm+/9LRffGXGC3j07dYsjVQTtbeytvMPSPwe4jfrSGwCHwoXPrGBJmwwJNTxV1V4
         rnn2W9v/usDuK2FVHLa5c37wCmIPDHLx7qEl8yEaaknBlSeje+6xHy1JXG3XJvo0RxOF
         0uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687673; x=1706292473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OouLsUncXdro84LkucUunUlvqGOy/RT1zxKH4rfrFVI=;
        b=I2X0whzlc092sqU6xtg48VzTx4I8cytRdmT7MiUAyxhMhzKTxhO7hUje3q10KzHomH
         H8dKvzMgidWHOXQwm/voFm54+AmmjmzgOI2H0EgnsaPxWxiI92Qpnq7SHqip5jnc+Yfm
         QpdAINm7QeURw6nkznkxuRVE6ySPOu3D9tpEldxzBmU2WO2qcUiTyi3Iu3efnZ6GwJqR
         aCXHb2knJaBsBzDvfbmbn6jy7Rs33+qBFAY9ipzlipf8j/Q/j8oSyoDWIEg7YGc6EvnQ
         D1QZr8nve1Z6b6UglFRnt3Ju3kkcRbraB1WzaFidTpQRUgUITV3NREXjNxLpwletPsEI
         atew==
X-Gm-Message-State: AOJu0YxnTMDKjNkefmUPTJXFahKL6BxFjlDXY/BurlO/LrJp6ongh1v0
	CRWjFyN7mgXLkFqat2I8pSjnG3oQVVq2y+Mc8o3A/q8X0r+J03mYHC8lV0hE
X-Google-Smtp-Source: AGHT+IEFXRi1LmbdEEQsUtYNN0rpYkaNjeeD5bB3vQeaTSmSWQ/ruYV3YLUoYLuqLWEREmJh9xoxQA==
X-Received: by 2002:a6b:e608:0:b0:7bf:1c0b:db43 with SMTP id g8-20020a6be608000000b007bf1c0bdb43mr84290ioh.38.1705687672876;
        Fri, 19 Jan 2024 10:07:52 -0800 (PST)
Received: from [10.100.20.9] ([50.225.159.98])
        by smtp.gmail.com with ESMTPSA id a6-20020a02ac06000000b0046dfd35b042sm1693277jao.73.2024.01.19.10.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 10:07:52 -0800 (PST)
Message-ID: <26aba780-d175-46ff-9943-c36625e7757a@gmail.com>
Date: Fri, 19 Jan 2024 10:07:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k and vfio-pci support
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <8734v5zhol.fsf@kernel.org> <87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
 <87r0ipcn7j.fsf@kernel.org> <356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
 <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
 <87mstccmk6.fsf@kernel.org> <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org> <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
 <16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
 <cdec259a-b779-4856-8585-f285179e3671@gmail.com>
 <21e925bc-ee3e-4421-949b-b3839d2abdef@quicinc.com>
 <08457e37-49f4-4c51-998b-e577731c8022@gmail.com> <87o7dh2oky.fsf@kernel.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87o7dh2oky.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kalle,

On 1/19/24 9:57 AM, Kalle Valo wrote:
> James Prestwood <prestwoj@gmail.com> writes:
>
>>> Sorry I should have made it clear:
>>> step1: start qemu and load ath11k without changing anything, then
>>> you get those errors;
>>> step2: keep qemu running and ath11k there, don't unload it. Then
>>> check lspci output in host to get the MSI vector.
>>> step3: Back in qemu, hard code MSI vector to the one you get in
>>> step2, then rebuild and reload ath11k.
>> Thank you for the clarification, this worked like a charm!
> Very nice, huge thanks to Baochen for finding the workaround! James, let
> us know how it works for you in the long run. This would definitely help
> automating ath11k testing so I'm very interested about this.

Yes thank you Baochen!

You mean using PCI pass-through? Yes, its immensely useful for testing 
kernel changes. No swapping host kernels/reboots and you can build a 
very minimal kernel, mine takes ~10 min to build initially then 
iterative changes take ~10 seconds.

We have also integrated this into IWD's autotest framework so you can, 
in theory, run tests you normally run using mac80211_hwsim but using 
real hardware (assuming you aren't needing to modify frames). I did at 
one point have a system set up with 4-5 wifi cards and could run python 
tests against them, bring up an AP, connect, etc. It was pretty neat.

Thanks,

James


