Return-Path: <linux-wireless+bounces-17761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A79A17208
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 18:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C473218822E9
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176041EE036;
	Mon, 20 Jan 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VioYsZ1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFA1AF0A4
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394570; cv=none; b=npUEuk3d7aLMDswo9tIFI7inyj/idaUhRGYMWWNDyBjNt6HfjqGdO49pEW+4++r+c6o1i/tycKI6lVA2J63RN78ou9r3rRZ3GxCrfETGKm/MR1C64+GTZZ2wumCp9ftOA1AR0+B8/V6JT4DbqQWaQXt8g4WGrQsqvQBMBZ3ujkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394570; c=relaxed/simple;
	bh=OWjCs7c3Z3OCyI44BJJJ8m95UEV9C/WJxLxyxMRcTSg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gQMUHrR2kG/RzaEZBahWCxaqs0V9FFepxu1bmy6m3WCg5K74jtUIzsZlpGz7YFgzYhHyctVfED/wKDK8bFGLHZqOLnDASSnkykEd3CiS1VzRWsRTow7aDs13PdAnXRN+q+AkwfpUKK3LWp1vQtLCKcn9ZHVMJg0nvUJ/uDPd5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VioYsZ1+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso7165329a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 09:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737394566; x=1737999366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvc2Rz1m9N2wS2uwg8ORhL6LSIX/Tdz2W8B7SCeMhIs=;
        b=VioYsZ1+N6F0wrpAy1AWNBvW6NenXCPevAlIuZBYRf9WCTBGo9AIce//FSetRm2Q6e
         /aFvvEQkkD9cKz6DaLYlGocisa4m5hmq3kpJsC4L25qTFwsNkdNUm9H+0gr9Ef/dqGBE
         5HmzmrOD/hMjsiKaNmTcj9zdGNW1P5E3kUHPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394566; x=1737999366;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvc2Rz1m9N2wS2uwg8ORhL6LSIX/Tdz2W8B7SCeMhIs=;
        b=uZit8gO/+mCQO5ExuVRM7gj96wWZfqllacJ09H5cpfh4DaW70+x+WbtoivAZwbta/L
         HJIvtr5u4wJkQ2dA+TVunHLLpG+8y6/b9tKvHO/olanvlkOzPvUW5+F/BAIdRoip+Cag
         2aLWfT7RxIiRhkZEZuzYVj1bH7Ud6kUCiSF3VcXU6q4A8m+humEpPOHqQe2tFhhwBfmC
         D0k7mwwO+6h9WeEXArVsDKNW1ifWt0mekvqfnpW1DCEBBXzruzG8bUobQyO8ndHla7gz
         sW0suZv2KxO91SBpdCtX6uTXCz/K9U86q9GTfX7iuFTkelyeX9FUL1V3wPArDzRcnciO
         uF4A==
X-Forwarded-Encrypted: i=1; AJvYcCXqivfvJgkFlwB3jSy5/RrcL2U7k7w2TfwpxdAeyyL2A9ri2ZKtiLvFIWfTu0EM7yYDUqIwBseYJLG6KlaY1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyS51JjQs5HuMtzS15qXwEeCaplRlgBzfw18EOaCk2oIUCQxI
	/G54sKPHkBmYFUILvgnAczOkWFN/5sCsUpQcnDHQ7yRQcMIl5kKphfx6yLs8vg==
X-Gm-Gg: ASbGnctD925VggaXGK98rwHiSAcxjG7w5AAhw8R71tlLyfWxZMSEAY0cqJN8qDm0P8h
	Q96IZyfTyY2W5z89IKuMgg1ERn70M2w5pLx53ovGH2JeniJSyaMQuSmWfE87anCCHMdpUl7IxSM
	3vQPwyIX6Pg79sUMAZGtvEnKttLbXMSemrmsvZ3kcJfQQ4bS6qZZqiD6KoEs2I28WzL1NKDkdbT
	aXY4u/rPfrvDV1ARmwPZs+DHwbuaS40O/4cvqg6P1uyBzZBL1Ld6nLNJc/+yrw3rr03Kpx97wQC
	2hhjqRkEPxxUuUxkmwQHfkxNgu1tGLFa
X-Google-Smtp-Source: AGHT+IG/GC+9Wg4EHK7qW88A9verjSDjN9AnXNYY3WDTI+/nRQs9bdq159c3rac7fk9Bt77tDBIoSQ==
X-Received: by 2002:a05:6402:34d2:b0:5d0:e410:468b with SMTP id 4fb4d7f45d1cf-5db7d2e3c09mr11110000a12.2.1737394565880;
        Mon, 20 Jan 2025 09:36:05 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73684dd3sm5955145a12.46.2025.01.20.09.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 09:36:05 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Aditya Garg <gargaditya08@live.com>, Arend van Spriel <aspriel@gmail.com>, Kalle Valo <kvalo@kernel.org>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>
CC: Orlando Chamberlain <orlandoch.dev@gmail.com>, <stable@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Mon, 20 Jan 2025 18:36:03 +0100
Message-ID: <19484c927b8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
References: <47E43F07-E11D-478C-86D4-23627154AC7C@live.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH] wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364 firmware
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 20, 2025 5:50:56 PM Aditya Garg <gargaditya08@live.com> wrote:

> From: Aditya Garg <gargaditya08@live.com>
>
> Before 6.13, random seed to the firmware was given based on the logic
> whether the device had valid OTP or not, and such devices were found
> mainly on the T2 and Apple Silicon Macs. In 6.13, the logic was changed,
> and the device table was used for this purpose, so as to cover the special
> case of BCM43752 chip.
>
> During the transition, the device table for BCM4364 and BCM4355 Wi-Fi chips
> which had valid OTP was not modified, thus breaking Wi-Fi on these devices.
> This patch adds does the necessary changes, similar to the ones done for
> other chips.
>
> Fixes: ea11a89c3ac6 ("wifi: brcmfmac: add flag for random seed during 
> firmware download")
> Cc: stable@vger.kernel.org

Acked-by: Arend van Spriel  <arend.vanspriel@broadcom.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)



