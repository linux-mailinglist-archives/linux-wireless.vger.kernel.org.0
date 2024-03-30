Return-Path: <linux-wireless+bounces-5640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F631892C61
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 19:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05EE1F21D5E
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Mar 2024 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25FD3CF6E;
	Sat, 30 Mar 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="El9dfnN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C63BBD8
	for <linux-wireless@vger.kernel.org>; Sat, 30 Mar 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711822994; cv=none; b=U2va/F3++5n7lA/P0M8ej/kWFGAl5XmvVp8NGXUyDaQFsl190L1PLv+EkQ2baq5bIJb5ZPuhKoStZU/w4Jqpqbkr0M6eLHQpKs7zFYz/eGrkuvUFLa+zqKyoQK5BEXSNs6KjoyQbL/+Idx+24W1tvb4IwPSiuT9X6zFXGE+6NLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711822994; c=relaxed/simple;
	bh=fGQOXOBSGPf73ucijJIGbMZd65e2Fh0d8qbofUqwDSs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kiFxxIhegewJ1zGZB7NJIpqkWUoGv517EGADDqFv/Pwn5uWru9lB5Qh7E5pIG8+C81bFaBdgXllelwnxkmUPTdtCnhF6Wki77teQ3xLAGxl+ls1ZSP4N7Q4N8GM/nf213dqXheZy8O2RY9xK71sxyW/OljoQKSl3HLZWNJxiixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=El9dfnN5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so1924153f8f.2
        for <linux-wireless@vger.kernel.org>; Sat, 30 Mar 2024 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711822991; x=1712427791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XWw0ZP7kBFk0KoFs8ftkXTic4hSGa1QLT0sqvHHSYPs=;
        b=El9dfnN5Iy18N/TopXmhZWoG9Rw7QaFbbAweo+heUJfTUWsEJ2ztW/AP8g+/d0RAsV
         GVjit+TXFvR+HApWiRlH3ShlELpddeSXUDJwd8+zMA/upFPWKCW5ClA3TQNL6p7Wp/na
         fyqhJXhgUtj+imGq0YZlfsFATawPmHP+tXOySFSSF//VDM4jMArCOfzXTX48VxJvA3Hr
         ocZLXB+PHV4J24bviPqYGJKl/9pGZljDZoKOKGbQMSLLA1YOcCrgwaoprK6KJlZ/DSGv
         m7ITzOCfJjTGHPKgSxTuIEZcWOfXq5kKuTbgqvV+inXYBVZj0B9c1k+71ipJQxhw78zt
         vD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711822991; x=1712427791;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWw0ZP7kBFk0KoFs8ftkXTic4hSGa1QLT0sqvHHSYPs=;
        b=TxuKdccs7qmvgDJPBstP+p4/Ir5XaJShFjjbtEopjx1D9sbrSrbfCb3kYXIHVnmUEn
         NgW+8oa+eIYUjbJwSsc/o5mCz5u2NaTSRNVnmoGmAnQ+16AnNov1mdBfTnMNSlzqZ534
         fE4k+6jeh/xXeiJfDWfOokCZVSW8eQFva3S1QKh/CBFhAn8TXZQOAPiTvdDFdYYjAdve
         PoYPsLHDq4en4UyiUZfB27ThPrGjLoUdSyq9RCDVxX8Iyt1U+lE7Mz0YtWDvkexeYNfD
         f+JKf/H4xqfEK7P29HEUsiqL77DOSh9o2Z/gcFPl853A8C7Et1pZ0DLp1xhhSl+lyCMP
         oQxw==
X-Gm-Message-State: AOJu0Ywi/vK89DYqISf24T3dlXhZxpTmbuz4wlUYfQhBU76U2J7TrV7S
	UQ4Ho6Sxa8Xk/q8Ibp+ExX4emDEFiYdqBh/gtV9D/uuUhN8wlAbqk++3gD1bO2k=
X-Google-Smtp-Source: AGHT+IGdAY5ScaZx1aVnvKHNMZiMDx+Uiiu9YBiOw0GIR9m2Q0k+cx1tZrLYMWlRMTQiMUCky+BQhQ==
X-Received: by 2002:a5d:484c:0:b0:33e:75d9:75cf with SMTP id n12-20020a5d484c000000b0033e75d975cfmr3405876wrs.52.1711822991293;
        Sat, 30 Mar 2024 11:23:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x14-20020adfdd8e000000b00341b451a31asm6968812wrl.36.2024.03.30.11.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 11:23:10 -0700 (PDT)
Message-ID: <6bd3db0f-2e18-4ad1-abc2-f59c6acc8037@linaro.org>
Date: Sat, 30 Mar 2024 19:23:08 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>, Arnaud Vrac <avrac@freebox.fr>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jami Kettunen <jamipkettunen@gmail.com>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
 <84f20fb5-5d48-419c-8eff-d7044afb81c0@freebox.fr>
 <72c162cc-45e0-48b6-8d90-d59fac299375@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <72c162cc-45e0-48b6-8d90-d59fac299375@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/03/2024 19:20, Krzysztof Kozlowski wrote:
> On 28/03/2024 18:36, Marc Gonzalez wrote:
>> The ath10k driver waits for an "MSA_READY" indicator
>> to complete initialization. If the indicator is not
>> received, then the device remains unusable.
>>
>> cf. ath10k_qmi_driver_event_work()
>>
>> Several msm8998-based devices are affected by this issue.
>> Oddly, it seems safe to NOT wait for the indicator, and
>> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
>>
> 
> This is v2, so where is the changelog?

Expecting reviewer to dig previous discussions will not help your case.
It helps reviewers if you provide necessary information, like resolution
of previous discussion in the changelog.

I dig the previous discussion, since you did not mention it here, and it
seems you entirely ignored its outcome. That's not a DT property.

NAK, sorry. Please go back to v1 and read the comments you got there.

Best regards,
Krzysztof


