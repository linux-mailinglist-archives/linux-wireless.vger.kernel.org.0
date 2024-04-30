Return-Path: <linux-wireless+bounces-7040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD758B7328
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB4A1C2317D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B8612DD83;
	Tue, 30 Apr 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="Sbg5ZNGr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159912D77D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475747; cv=none; b=ewktJtl3s1useOew9c8dmvD0WSj5M2oL8w8ieYzs2pGfFMUdPhYlROmVVDIUmWMpVt1iBwVy4BPLPq5CbIMOn7Ga9GZZAfbh5t2fRlkbPQReaPlWjTYpV7rsVUFd8FKDCLOYo1UlM80jD7rWAkjLyo1NWOoQr5vwZ/ZKnvpuX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475747; c=relaxed/simple;
	bh=QqYTK9YTfNjwsAqsh2I4pBktmmQMA6Z0sfpg5SrkUqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDYR5dKdO/rSBJ2qBGyLtNsjxa4H3xONB4VwuxNkFLVzM6mhwCbTx3CRHhUupPA8K5sc/9aGqHqCC0B6BgE8cseRVzEWVAg/iOEqxoqE5ssNmVVL7UEkKoihwJbEaZRFFFxZoamh+NcCU2fk7FVtxMWxW5ob7ni25C+Ng7FPmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=Sbg5ZNGr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41c011bb920so14695515e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1714475743; x=1715080543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fmDNtKNAUj+EAe14afk12YEoJlqoF5/CO+cJg8bHSIE=;
        b=Sbg5ZNGrT7EgCbv25Y44+zLzPP/zQUkveCJXgMYZ6hLbN5swvAIvs+usTBcnpl1Bv6
         Nv7HI13Vuhj6QAusSZu0j8+OP58y1l0F2S+pcfYTJBysZiqrigt7gQLKnNKgEDOaMdJm
         SDtGiyF0K2Bb3u4zSgiwWxZ6UcNyqirSojbdQFqK9UW2CTwqS1aMQ73GfbmYuLB1uDL0
         wwKO8WWdXPH6zQVne3UJUuMF9MU+8IYo/qOqdcc2XN0pGQOU+ywu+AmUzYIbthHp9h7r
         M5AwMs0R0nhyXMaMhKiXC1D32w3iP39zSzi7aI0rv5CmAO8DC6fgQbiEPUCH4lM4veeA
         5fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475743; x=1715080543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmDNtKNAUj+EAe14afk12YEoJlqoF5/CO+cJg8bHSIE=;
        b=b8iH3d1CoA4GrsU4h1ews166IVxFwFMlJftjIacwCjyWQsG8yKAAdD0bbZU4QTx0WT
         KERbk7ZiGoXHLx5D0Cw+IqDyfh4zpIsyae6KH3vFhTPk0B7owhE2koaXGJTjIrviSicE
         IiWfBs9ehFnw6BcQLLOpl9OZzwspFLeNjtwoD1dHzvHUS/WaJDYnKS+ofOFPI/hd+4fP
         BhtUMsfYZoamyNolaWGkAUxdjlxr7GwjTK2ct8R7HSxOrqAhVPYu4RUhspL+Vl2KyFPf
         BfqJL3nmc3eLSDZy9+WhbkVoId2MkUDlibbXGtrUztwOIVk1CirdCxisNbCSQt0ffNdB
         ci/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbtYbEHMVnGHsdEPqBGNPeW7irsUeNEaihgzPbMq3vOfKDjuA0Jhvnvj0B02K/kGRZx+aeThMHL12Hk59ecceR0kSWT1vohVjCuzgNhYE=
X-Gm-Message-State: AOJu0Ywem6mSX2cW379XkVCqlCtMPGZaOgMfcsflqcMgIo/KC2hODRyp
	YRv4mx+QFl2Ftp1B7h0YLhjnbYESTJuqDD1HchxZZet3JQXrxZtMnTKcHTfe0+o=
X-Google-Smtp-Source: AGHT+IHEFMtXAH/YKrNwQKlXxkPWH5Zf/6vTdgXFkM/G+vP1WzEEk5r/knMRdxIagzjU3f1WjQovVA==
X-Received: by 2002:adf:a792:0:b0:349:bb17:6e60 with SMTP id j18-20020adfa792000000b00349bb176e60mr1941881wrc.2.1714475743585;
        Tue, 30 Apr 2024 04:15:43 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d6ac4000000b0034c3d1e1391sm11786111wrw.42.2024.04.30.04.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 04:15:43 -0700 (PDT)
Message-ID: <0a242bc1-fe8a-439b-96cb-bebdf2ada7d7@freebox.fr>
Date: Tue, 30 Apr 2024 13:15:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: ath10k: do not always wait for MSA_READY
 indicator
To: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>,
 wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 MSM <linux-arm-msm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
 <23540303-5816-45d5-a1af-5f09d645a73b@freebox.fr>
 <ZjBWUvdEI6aq4s6M@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
In-Reply-To: <ZjBWUvdEI6aq4s6M@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 04:24, Bjorn Andersson wrote:

> On Mon, Apr 29, 2024 at 04:06:29PM +0200, Marc Gonzalez wrote:
>
>> The ath10k driver waits for an "MSA_READY" indicator
>> to complete initialization. If the indicator is not
>> received, then the device remains unusable.
>>
>> Several msm8998-based devices are affected by this issue.
>> Oddly, it seems safe to NOT wait for the indicator, and
>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>>
>> fw_version 0x100204b2
>> fw_build_timestamp 2019-09-04 03:01
>> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
>>
>> Jeff Johnson wrote:
>>
>>   The feedback I received was "it might be ok to change all ath10k qmi
>>   to skip waiting for msa_ready", and it was pointed out that ath11k
>>   (and ath12k) do not wait for it.
>>
>>   However with so many deployed devices, "might be ok" isn't a strong
>>   argument for changing the default behavior.
>>
>> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
> 
> As with patch 1, please address the s-o-b and accept my:
> 
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

As with patch 1,
I typed this patch all by myself with my grubby little paws.
You can drop PH's S-o-b.

Regards


