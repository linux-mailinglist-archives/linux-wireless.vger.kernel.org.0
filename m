Return-Path: <linux-wireless+bounces-4919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E0880308
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 18:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803221C20326
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6412B89;
	Tue, 19 Mar 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="1Oi5hh76"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DE171A1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867965; cv=none; b=kN9Ge0QhQuQM1tDsPpJPo8rYT5Uh52wmcsH57e2HJwsU3T/Nv+0ewEzoWYkOoPrlOhAAR1fVnkvp6YebUlT+dr/kRYztqj89HjTwtNEuieWhJmd/r7b7CZQ9oVC3zE2oEhC6rLyNEqPq6hUAqDWXqn+Hrjm3EMm7o571kQUaev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867965; c=relaxed/simple;
	bh=vhV6zUtmAfy/vNP17fIk9V9xTd/09f0QdrKRBGrKG64=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GFU2Aid2LeL3mrbgGvTPX5sqFyrpNOBRHz4iz+RSjPm/zi02LIvsszBLTneg814KzfZYk/2fiyJ7caoueWs4qPckrPMflwdQ+hbyZKn/nd1z9lftpVRlJQkVdBunfWbWhSPE1l0PbBugkHARF9lFfGiun9NLMzj3NmZf+gX90G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=1Oi5hh76; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d228a132acso82404721fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1710867960; x=1711472760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhV6zUtmAfy/vNP17fIk9V9xTd/09f0QdrKRBGrKG64=;
        b=1Oi5hh764sTTbtaFJPqGqHAXW52NMM2TeV618mILDgAKDk8HM7VF8YKE9Tp5V/Df6J
         OKrBT5MwuzonxOh7985sbDg0jybKqhmTFvveW535tw5AwO39A4L+qDSvIavVytgJ4xRo
         x0TMiSSVhn2MJgMWhfIernp4I2iUeO2DbtY2lL67Cn5wiffTcVq/Oyl8YdSUM1892ifR
         IMx7X7dvXYx3UeDk3ZbpHaCoQXsfVOPgy0vI2HHXCcJfqQfDggOIhudwKfUFIrsL8pa1
         Nx0Beo5qYBtI7sBr2Nud1Z2qdhwaDT9AsrAE1JFX3cC5FrCgCxNpMr+nFSM4BVCAUt/d
         NHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867960; x=1711472760;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhV6zUtmAfy/vNP17fIk9V9xTd/09f0QdrKRBGrKG64=;
        b=DfI0On+5KsLGfadj4a2/PyTGBI+LUQAxjzpdL+ybe6Z7BOmU3FMo2Ula2WTspMVZ4F
         Yxz/jvPyudU/Xi9kdS0IF2aHbvjANn77VtYUQbsLUCzGqg1onPRZgdYNVkuFpOQPHOWz
         epsJN1GJwUJb/rDvb6062HyGBHr/y5QFPAPnKmI69hxXaCusUeDtOJX0H1psu4j0oZKA
         nutui4qignMSwZSbkuKOPoqe7nq3FvXrDpF+7mgQpTdk/6jXjGFPoyt3lyAr97moa+AM
         ccNOeAsvBnmmbIuVl0qaoqNfwnJR76/hmxSLUpr1SYbC5NNM8/DOL6N1PkrZBAX8EmmI
         tw6A==
X-Gm-Message-State: AOJu0Yx4Zr0yGlRy2YIBo9ldf9uXGNnlX0U7Yje3TTE5IzTBPZm6yDvC
	RXd5zM/3yiuLCtiH/Hf1fj7KqHvQ57XS3W4N2a8mWWrRSZcGjg62M5yVXIREFycmoniAgM8tIKA
	P
X-Google-Smtp-Source: AGHT+IHEtmX+QarKHP/fHEiIdq3PIxiOyRbGltyD0iu6IZMQAyPpmgbHVNBWPPYKrEZlewbLrYHffg==
X-Received: by 2002:a05:651c:1a23:b0:2d4:a8cf:e798 with SMTP id by35-20020a05651c1a2300b002d4a8cfe798mr2972250ljb.14.1710867959880;
        Tue, 19 Mar 2024 10:05:59 -0700 (PDT)
Received: from [192.168.108.81] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b004133365bbc6sm21924692wmo.19.2024.03.19.10.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:05:59 -0700 (PDT)
Message-ID: <e04b8086-ab76-4921-921a-fa01bfa4f312@freebox.fr>
Date: Tue, 19 Mar 2024 18:05:58 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
To: wireless <linux-wireless@vger.kernel.org>,
 ath10k <ath10k@lists.infradead.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 DT <devicetree@vger.kernel.org>, Pierre-Hugues Husson <phhusson@freebox.fr>,
 Jami Kettunen <jamipkettunen@gmail.com>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
 <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
 <f26dfcc6-5fd3-486d-b0f2-80168eb213c7@freebox.fr>
 <880e016a-d4d2-4bc9-8c75-bbe4848515ad@freebox.fr>
 <a1dd2944-5d20-4fbe-84f3-b03a0cd5835d@freebox.fr>
In-Reply-To: <a1dd2944-5d20-4fbe-84f3-b03a0cd5835d@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 15:39, Marc Gonzalez wrote:

> What a dweeb... bitten by the very bug I'm supposed to fix :(

Is there a kernel bootcmd to force the kernel to probe devices sequentially,
in order to get (roughly) deterministic kernel logs I can run diff on?
(Even if it slows down boot by a factor of 10)

Regards



