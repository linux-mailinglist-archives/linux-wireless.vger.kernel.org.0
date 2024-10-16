Return-Path: <linux-wireless+bounces-14069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B15B9A0772
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E51C23D7D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584ED206E78;
	Wed, 16 Oct 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiufRnGf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F01FAEFE
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074625; cv=none; b=OSEEoLqClDV7Efhj4QohsqqDamXyPb2qAgO2MJ5XK+H/ScUHAaq5utjxpLQ0P196in9ZyudETEfIWf2lwo9jm+1lZWARYAQlzAkHdLe5I34+Oe6iPVvNRyHMLh7O83zUUXyklKyhwNObL9u5Pu/JbCEpysfyUVkX+J+ND3BONo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074625; c=relaxed/simple;
	bh=cyr6m4C5QZsRM2pYWRxQJ3eSbG7DNnMjBSxrQH/7QT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiADA4ZNM0rEWqiZEmRvKTrFawwH38K8FQhOMXfmC3MDFitoL04oQW7cRJlTcxN7LDEsn0Ab7VC4Q09VxY3YVT8KKQbDbHwe4FJzR/koRL65bcGyIkP5oclT2Z6PfayGgp6CnQ+mwNf2exXPT2aYBgKP8LYcAuLCO1kcmGzPM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jiufRnGf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53a097aa3daso281970e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729074622; x=1729679422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQSFPeENDoENYpbyNxZoNIhCobJqeAT8wBO30SKoc+M=;
        b=jiufRnGfZ8HH1cfS5XrFdkyZrvWJojCRPhG+aej7liX8CkvOCpRdQ8LyLUjiBKnr82
         sBnqPXBxGWyy1ww2Dvfd6nVkd+26smWtFgqI9dCfCUkoMYquBdR82alERjMiOfKuGypY
         EIGGnVdsgFTP4Hw4i3us6dbQTWUhKPEOS3XJRQgD/fshZrBhhyFE5R3zS/X7QJp+AADM
         P3Y2vXnSS4Y+86X8avdMq9SUgjk04o5qDRLyVQC1Ny00T8gdkmEz1C3v7rgtO7gblVVc
         WrOa9L1nAN1PrLBla/tEcTNzJx7CJx5OBRl0qFtlhz06zNs8VXtq3ffvn1qiLqH6D2JE
         LmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074622; x=1729679422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQSFPeENDoENYpbyNxZoNIhCobJqeAT8wBO30SKoc+M=;
        b=vly2PLF0/8CHs/ePhVmMFKneAvPy1x2A07v7Uq+phSzeit76RmEvTuHDyHWuBivaV9
         FEo0Q8QxuQj1qfsCU8lMfuRhx/FVzJvTXliFZClhjqS5K7G/CraE8YP0NAMJx+m9+J08
         X7BRa7WcBN9lXqzUb4E3IL3jCsIORtkgvXbplGwdCtDDWTa3XbcWxrEE/lLeCYzDzEhu
         lPXS9olRu73t1zGIMNKpxpwcQypm4e/m/a0CB0RHv8k86tBLjaMAlsL/h2t/tV5Ysl5A
         RByGTmbEdtSWKjK9J99taK/qHlWFNl6396dEO5zpaKiIPGMoPyDnma17cge+2YgZmkOu
         NMPw==
X-Forwarded-Encrypted: i=1; AJvYcCWWm+AP77xo5qG+j2fTZHQ2i7/l08gRHUkM2XvyUZbXV5t9rE7kehnJuE/wJeTIjtX0S3fj3wVmovX+66Bv6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwehW4jtV/KB9UdSe9rZxFxb1h19rlpFQtR+NlLtQ/x6j6PVAB0
	UzzoeEAhS33sIZjD6WqHW0uQ943wU28WRWYAOV71uIQa9rMREPR+wsUMCJ3//KwubDQHCz0olkM
	clfk=
X-Google-Smtp-Source: AGHT+IFZU+MCWROhLS2WtO9kRlICAepTgZYo1pzmmsjqkteB1I5eUAuhrTa7pnapdJgkfLAB/FLp8Q==
X-Received: by 2002:a05:6512:a8e:b0:539:a924:74ba with SMTP id 2adb3069b0e04-539e574c7b6mr7157088e87.56.1729074621644;
        Wed, 16 Oct 2024 03:30:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffa9441sm418092e87.56.2024.10.16.03.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:30:21 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:30:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, 
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: add wifi node for IPQ5332
 based RDP441
Message-ID: <gnv7i3m5ooxtyi4ywgq4q5sq3wj6j7xtjx6puuixoulypeiwjo@65wfj657x5ug>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-3-quic_rajkbhag@quicinc.com>
 <ftvwsizfupm7veg662adnzc6jpulk5shga3xmvbtom3saclnf6@bmatmqw5lp72>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ftvwsizfupm7veg662adnzc6jpulk5shga3xmvbtom3saclnf6@bmatmqw5lp72>

On Wed, Oct 16, 2024 at 08:58:25AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Oct 15, 2024 at 11:56:17PM +0530, Raj Kumar Bhagat wrote:
> > RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
> > device.
> > 
> > Describe and add WiFi node for RDP441. Also, reserve the memory
> > required by IPQ5332 firmware.
> > 
> > Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> 
> Don't send one DTS patch in 22 patchset targetting different subsystem.
> Imagine, how wireless maintainers are supposed to apply their bits? 21
> commands instead of one command?

Huh? b4 shazam -P 1,3-22 should work. Or ideally the DTS should be the
last one, so applying all other patches should be obvious. As a reviewer
I find it troublesome to review bindindings / driver without an actual
DTS snippet.

-- 
With best wishes
Dmitry

