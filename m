Return-Path: <linux-wireless+bounces-3937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF885FC94
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 16:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C642862AE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53297135A67;
	Thu, 22 Feb 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8+5+kRH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3514D43C
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616329; cv=none; b=gythWEce1LixIB5NVTErXZW/q07IsRJZtbCsyTK+amf4w0QT0Z8lwmDYmWK1a2E2BixchxtEU/h6n/7t0Slwz2uKmH9c+0Bu+GzmORC4WGIXaAKaR9SQB4R8kA/sp6csAVVN+jY8Vl8t5TLUk+uihMXGrK13qMrCnJA2P7ukBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616329; c=relaxed/simple;
	bh=992swvzV61h5oD0LoSVP5h5meaqVbfkRfDzPDMCj/WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jrg+tp882OeroBJkoLLxoPK9IYdnQjKI52dWRfRuyk7wFPohC6cTjQ4NHg+HvrVzJGtQRfyLTQiRbC53BspHEH4ruUCIl0ue4DmL0q4WK2Td8VzAsv21Lre1emSh5fwUuzS7Oyn2lvP5E4ZptCpDJ+pxeULGKP9X6Tra+1f1ifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8+5+kRH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1549316a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708616327; x=1709221127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgiwPF0aDe9yj5CzJjlZKdJuiYIbrJDtCrpJLyrGsCk=;
        b=E8+5+kRHcmXhOQdgpbLMLb0p0tuVtXEb8oZiJ/+Z23GH1pP76lNHs3G8RKgaOUgdxV
         wxdu/WT6sjH7jyVSeCcfQ2p3Tv44s2QIBwUH3xTvEur4MtJXQ42x+wFQRQD2YkWnT8GX
         0uysQyiLhRRJxXcoF+lkdFSI3MKDBJmurenoewxTQQ6gqQhCA7KNNPo4KEABJ97fELAT
         OacuupnCU3uMyY7DVBZwwV7Ii3qeZ3sHgUg96OVlXku7o7YLUCS1V7b7w0CvzkgPhxsz
         fhZDEPcQLIQcyw7AbfokKt/9ks8j/NpwSh/nRpovA6MqxS2B0hGPTMH9tR6e+IfYoXiZ
         cNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616327; x=1709221127;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgiwPF0aDe9yj5CzJjlZKdJuiYIbrJDtCrpJLyrGsCk=;
        b=oBTj0fVQ8sqlIHKpvmRq7mwB3xl6drHEX65bqcFo7SLAuA83J1r4HDMbHi9r0R6fhe
         hsKOAB/BzqfoOs1B+PpuaA0iLUtIE1ViacHoocxOxpz/C2praVw6SmfF6VcZNY1+q5rd
         eeqOxHD1JVkdIIJUqaVAdUO1z5Pre/2mqJOQTFvj35UYpvxfuoOcawElpSpJOvLWGKeC
         gtvOKkc60c1PaHLxl8iwtOdu1cZdAShrOnATrj7HytMNyh8ipvP7V4ipTqM17oJRD1p9
         FNJsk0MlF2I2bRJkiXQBmeCtdwgffDcysogTaiBE741sL+/8V2JcmwP+wu6NfWb6lsXY
         w9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUOVeontW7GT2xbCi/0vy30ZOokyFmaWuqIzIIDMd6DpefH0bqVRpDbwR7PpHN1CHDR9UIqoZL7PtPjt8FxQPli2U3HW7be3LkBfQihAiY=
X-Gm-Message-State: AOJu0YynfvNg98PGjWrr8MQrDT7Qz11wdCofMgyd6AwA1ZiKutWfz1N4
	DWQXKZy6QKBPOQGzLf/XQAL1U1dbsCVtTbIlsKPTOlVrMJmPr1YZKJ+Ijlzk
X-Google-Smtp-Source: AGHT+IE1VLtTaQqTb9bDv83/VhdyBtgAzckhiW9A65DY59qzo6Awfa/BtWlp5LxDbKF/i24C+Z1vjQ==
X-Received: by 2002:a05:6a21:3183:b0:19e:a9e6:c05 with SMTP id za3-20020a056a21318300b0019ea9e60c05mr26816890pzb.43.1708616326926;
        Thu, 22 Feb 2024 07:38:46 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id e8-20020aa798c8000000b006e45a0101basm9302539pfm.99.2024.02.22.07.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:38:46 -0800 (PST)
Message-ID: <0e8ad2c2-cc39-4903-97f7-c3ffb525e61a@gmail.com>
Date: Thu, 22 Feb 2024 07:38:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
 <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
 <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
 <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
 <7a62031b-ad1f-4da2-8217-19a5d7fdc0f4@gmail.com>
 <f363f179-b41f-4bea-882f-e4aacb8ad519@quicinc.com>
 <eaeb8e9b-3809-4f89-a5b2-7949aa01fbde@gmail.com>
 <026d9ba3-525d-4a12-8d03-5fece818330c@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <026d9ba3-525d-4a12-8d03-5fece818330c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Baochen,

On 2/21/24 6:26 PM, Baochen Qiang wrote:
> But you are using monitor mode, not station mode, on ath10k, right? 

No I'm using station mode. It looks like ath10k creates a monitor device 
to receive these frames (that was already done before my patch), but the 
interface I'm using from userspace is a regular station interface

Thanks,

James


