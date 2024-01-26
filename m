Return-Path: <linux-wireless+bounces-2573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249A83E130
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 19:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945D51F24BB5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD3620B24;
	Fri, 26 Jan 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkYlTdww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78E1DFD2
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293213; cv=none; b=rCZtJIkEBP0BCYO9w/0pslHToBvshBWiZ9Ri5NdlMHk3xJJpNFcpqmGarBf4UXTWXTxN20Edfu8+/ImsgoMRS9xojhlPp5pq3ydBnR0IDvCFSoaGTxRYXBQz7bRXPS2hEPk8t8NvYIxr39OR6eb6ojHlvy9zeCgpEcTEw4aIhp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293213; c=relaxed/simple;
	bh=hFJ3UGImZ8axLxtaU4WHj7lOwaAKBx1sukbz9R0pchs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSbbmF5auDQO9l63JKrZxrxfTrwK0PfmH9f5U3+BBEsETH2dtfQn0J9CUw1nLhi5rEN4vLza68MUlTKf8r9yJGeFjg8IZMPUG8kwP9BQqGD73J0JpMM24Nqx85DST6BkVTlpd8DsStgHq3qFxIErEJiSQt8jxEgzrtutEkM8p6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkYlTdww; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7838af983c1so42978885a.3
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706293211; x=1706898011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B52crvW+pF4rOt/HhWqKjjZjJneCdMaxYBv6KgCO1Dc=;
        b=dkYlTdwwkwFgxg2jG7HpZeB2wvYZBxt8CGWGvzSHmHfuzQJVrbHhGXLD8Z4TSa9Wp1
         BckMuUB6jZf9PlLymcqQrl3cWGsonWUi1BLLOQxDMGE18GThiE+l5CsFkDmJ6uwNyKHV
         hdR7dNPdT0ot03TUq9RNh/F70KlFTQulYQbq/NOc7FFPr7mvi8uWjbtDQU2hKaAmStej
         DTZT3nIaN5uldl4etyKgoSqtxyN4Ged7Ga6uGdtkg3PNWxELkujhsy3cYLuG84hTVA/s
         2gJzCq7fD1hy4oz3SYQkN25TxhdPnfEp3wZlPleMMCB1jAWrZoQHrwV1E944x70TBihj
         4C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293211; x=1706898011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B52crvW+pF4rOt/HhWqKjjZjJneCdMaxYBv6KgCO1Dc=;
        b=Zj8VBK2mLERjmksIh86oIhzaF98IbuWXmJkTEKuHJITD8HZY999DYpG8As0GiGxOhr
         002w/XekbdkmjxV+3K5+/Ip9+kMMAlWVnh0mgf2jHMp4d4HMlHSTvcxE37YPp4Lfe72j
         gPYas0ONDetL9XY+F6wpeuMQlVt2q72M5VuWywsILFkcvtrPTENYOPSiwfTYwGVQasS3
         r0K1C4gJRD1mi63d4LNXpDzvg7W6iCtH9V7MZq6xFj5D10NopdPrsq3gpyxWFoyH1ms5
         AkTLfLZWgvSHxRzKW+MAA3pTApzHLaSfE4iJ17ngL24pMolcD2i2wcTW5e3E56i0SmN0
         mWwA==
X-Gm-Message-State: AOJu0Yw3KKReC71BbLOtWlJ54YW3FqU61g/JMXniH7dvwrMJ/tVyeT/2
	u9ZwDmAfpLZsmKDXqb+qXEPjQrwtU/rAS/vAtN1JyjPoEWvzkNU7WomTrnWeiKo=
X-Google-Smtp-Source: AGHT+IGgPhyNLioUANs7Ur2Pxv3+d7AKhqa5n5NJGrXQSfXMwsNFwman8zKAtICBRKi+lN59w4thfA==
X-Received: by 2002:a05:620a:2f0:b0:783:b593:519d with SMTP id a16-20020a05620a02f000b00783b593519dmr222042qko.71.1706293210878;
        Fri, 26 Jan 2024 10:20:10 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id q14-20020ae9e40e000000b007836720b96asm790634qkc.24.2024.01.26.10.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:20:10 -0800 (PST)
Message-ID: <8b938c5f-a8c1-4fc5-aaf5-501f097a1db0@gmail.com>
Date: Fri, 26 Jan 2024 10:20:07 -0800
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

Hi Kalle/Baochen,

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

It appears this hack isn't a reliable solution long term. It did survive 
several reboots but then I was back to the same behavior. Looked at the 
MSI vector and it had changed:

It went from fee00558 to feee00538

But at least I can just modify this and get it working again.

Thanks,

James

>

