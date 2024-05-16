Return-Path: <linux-wireless+bounces-7744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8628C791A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 17:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E35B2303F
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1706814D444;
	Thu, 16 May 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etnhsLcF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95D14B97C
	for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872478; cv=none; b=kKhHZH7vubLay5FetJK+xl1Zqm4RVCo7ufRW1ugG20lTzZzLGGjmPBtyfi3T3qgSzOWg6yL3lA5ZsTUGfk53h6zo4wAzpUsotxm0peEpC95Gr0QNC5l2UFKQ7x0w7BQI1a9cJtB+QnlaIgdbdReHsD3zY9v1bNZi8PNOLm7hcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872478; c=relaxed/simple;
	bh=yTx9QCVjTc3cJS5gd5EI44g6bMiB26QiBpBqqOFmVDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcXEpU0kNcYQZC8U49h4iaMHhJEVYwt0HlDdOsy7IaxaSh+vZXeHWczAen0QQ2YOPXlBYjpcIgfQBXE7dJPSp+eo12WagXU8DplahFy9H8CWguiQMvwMVZvjH6H0KvbXUpOsOqE8p0fYTnXykS81Ms4bhG6sMoOvSB+AHjhDV5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etnhsLcF; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0e975f67fso230110a34.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2024 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715872475; x=1716477275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QHBZD0nHcCfyiw9Bbc4ONBnZONYpPi/1NYwOVue8Yx0=;
        b=etnhsLcFnfRaowSrf8PzISeLw9i/KuW9ygyft5gJwIQDy0p64Wa4YejcvWadWKr34g
         IjRJIlA2ta7S9XkDWDf0p9W0xay/2rBPPeYYgKpvKMuXtOr4SwICG7aJ29wANlPPo/TU
         Ri9lA+NOswMxxT0caulwvL1/+LmRlrIywHyvGt+kpWICeahv0HUwrOZV3GBdox9fYV0e
         omSLjqEC+ky890tEsGFLyNDoYEZYgcfvIoqIWQQUnMq1RevP1giJWJflHRHutPUzYybf
         j70W0TkWRgKChe66VNMnCIPhYA3YkE7/7sVpnE22cSUVUXHFebWof+RHfWzOvfSKFK1c
         ArcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872475; x=1716477275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHBZD0nHcCfyiw9Bbc4ONBnZONYpPi/1NYwOVue8Yx0=;
        b=Fz/r2RdcEwAsuTEFiRt0t/ktiPGprbdQCDfNJmTUoO1NwLyxoFNvbVQwsczA1207LZ
         1N9woQrCI16PDVQswXMbzaTdcGlGoLPicmGFOR4YPpz67xfz1WYMu5UNfJ2W9APZ/Bow
         2T/jj4n2KyRbYrzttPNhK98JD0dqXR4mRLLjxA8URrVAlibDNNd/8xvCZhzZFatNpxkq
         eD+NRmqvodSdFzEP+SpSHLx+z62u5Ls13zO2hZoda+dZfFR/uOETSjXElS9jRdRopzJi
         8zN8SC3KI4r9YJxZnJfXoKvcywjlZ7AkxBFcsvraX9Q3LliGmU5ExuIdVslw+UbHzqq1
         HG1Q==
X-Gm-Message-State: AOJu0YzAtnICI/wrEDDBhXUuPvUI01oGcRo+OQN+DXpf1F1XhnTHZ4hl
	/JdqZfjrlFq+wjwzUd4e4BPkELJLtLZ2ETlF1sPmakCnNpvDZ4HGEDzqdw==
X-Google-Smtp-Source: AGHT+IHliZgYzZsViYg4Qq+Lv4Hu9rk+BTidjstr9pt5viyIysmoL5oaXDHaraTQIm/h/52I4o0QlQ==
X-Received: by 2002:a05:6808:278a:b0:3c9:c755:a194 with SMTP id 5614622812f47-3c9c755a31fmr1056116b6e.59.1715872475104;
        Thu, 16 May 2024 08:14:35 -0700 (PDT)
Received: from [10.62.118.112] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c9a1e75459sm1773849b6e.32.2024.05.16.08.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:14:34 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <c97e2856-de5b-4bd2-987d-e40b15d748ae@lwfinger.net>
Date: Thu, 16 May 2024 10:14:32 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with 8922ae
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
References: <898f027b-bf08-4f6b-b0c7-623ca5c5f23c@lwfinger.net>
 <fec7536d76cd469e8fbc375219205d1b@realtek.com>
 <723e1eed-e706-4533-b33b-a880b9a46fd8@lwfinger.net>
 <a321afd48004484cb1a598fc4f54556c@realtek.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <a321afd48004484cb1a598fc4f54556c@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 8:16 PM, Ping-Ke Shih wrote:
> Recently we added WoWLAN and BT-coexistence for 8922AE. I think you didn't use
> WoWLAN features, so cause might be BT-coexistence. Maybe another try is to turn
> off BT if you are using.
> 
> I will setup a PC to see if I can reproduce this problem.
> 

Ping-Ke,

I am not using BT. I unloaded the BT drivers, and still got the warning.

Larry


