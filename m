Return-Path: <linux-wireless+bounces-17938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D93A1C52D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 21:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568F71888CDD
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526CE13E02D;
	Sat, 25 Jan 2025 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxx1nNrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97838134AC
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737836605; cv=none; b=rNklhzO7H7pjHYvPJenBi32RrexUf89WvhJwNK5ax2cjkLNKU+lNAOSsZourv5CwVc4h6SXIikaE3DhUWXdSwgwHgf/81PXrNmjYyUzs+OAZ7xLRGjbZwILPekJs+czmSZy2OMwR8qSxwsaBI18InFo0Et3Fll8+DFyyO9q8f5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737836605; c=relaxed/simple;
	bh=dejM2pVhbH3cRZV+qO2a49sZ/LlbFOIsCPpw3y0TkzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eRpx2BCcLS2aY8YYlBT8g/CXapThpiTL4mgwweqcwdIdOYyLQx+PCmRr/bXXdFqnxDjplf6VrtJY5tlMadfw0U8hZ86n+ffbHJohJMl9nQ9v/YOTqQRzTPg+q4Z4tC8Q3bvd/QvE3u5h7dw05qn0pPYvzpf0iKyTAGpA+DlLawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxx1nNrY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43621d27adeso21163275e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 12:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737836602; x=1738441402; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dejM2pVhbH3cRZV+qO2a49sZ/LlbFOIsCPpw3y0TkzE=;
        b=Dxx1nNrYkoDph/fuKHMv3jFiU9Icp3KVi07onb82wGIy9BTQvzYCWaSyo5eReRzt0i
         VGKtPZ2hlJkcFQdxoHQZyFrnevatLakH8ZcJ9EOYB8mGvZD6gz7hvlMA3fMZcqXwMMkS
         nrxLGSZyUVO6xZiEg8o545eNsIAgu4G7fPB1BYilA7cLz9yVFIzyAEN76rfpZF8MqDbZ
         nFnAfxSJDIu6g6zU7SzibyMH7ertpJq4lM4G/2wIjvDmAfpc9ROixAXiCbRDIurau+/r
         pVNXUepFaBcJ9gMXWENC74EBdLwWIXMdMnRNFCHSQFID9k+ZwryTXEKjiLD1UqFRZPbp
         gblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737836602; x=1738441402;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dejM2pVhbH3cRZV+qO2a49sZ/LlbFOIsCPpw3y0TkzE=;
        b=TUXMNvFH+yxO9c3GYSehU7dLp5DKP4p11UcWWZZmW4/V6UeutlDUclGZrtZEG69jvv
         OicXk+EuuwHRm+8ZusI+CmAVG+mlXfottAWzDbI6y3lQmHar67RXwk2FAnQkRQXdz4SY
         y/1VvaJrtpjQDuQdS2YOHBP8YjrD4wvotqwigOdWBmaR1SK147j1juYxhCN7OLHxNPy4
         8hMQ2/KcL4Vj288PkEhTuAm8uXAa4pmJNt8wp5QaVzDQoHBGWhrWPM0dYeKe0BBWk2VM
         PVRihy/+nmut46HC8jmOVWxFZlD8ZXMYjn1tzwmFjbhpuPQkyyGroBYvCvw8DE4u27om
         9Xnw==
X-Gm-Message-State: AOJu0Yz02eypnNTo7k4Pji94NEwIFiL4q8IWQT+gdaPd7yICLrwPRz/h
	5xxNviHCPbgkMPboNsg793kWUZdN2YjxHLdSobKqRT12gQFe25lS
X-Gm-Gg: ASbGnctW//Tss2a0C7clc+ejT8Huj2V+boKoc/QROtpn+RRv+5n2C3s/bHd/LwESVf1
	LMiv7vUb74o0bb2t3zWODhoKOCrbokgd656OKtCtLp3Fh4DURqTtryHA4Y0R9KQSBpwuFs6RP2t
	VNLE3fk4QCITg7BrO01qTuW2JQiyjyzxXq6hkpNqXLvDyITzLUiZmee++dmHlL46yBPLuFjF+T/
	auKROyoXNcRGlbrU+HHL4eFZ4hhCB4LIqCoGUkZyD0fMw2XrIQtkyIGEInkGuLWB9US8Nl8FlLU
	p1WjLze2cfk1pDdDWVJyKm0=
X-Google-Smtp-Source: AGHT+IFh6bS896E6LufJZVkOiiVhAbtDqyNUA9TCia+B9toEquYH5HwBGuWERXDfR9ceCO/ZKtSpaQ==
X-Received: by 2002:a05:6000:18a8:b0:385:f69a:7e5f with SMTP id ffacd0b85a97d-38bf57a9a86mr41646771f8f.38.1737836601605;
        Sat, 25 Jan 2025 12:23:21 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a18859asm6359027f8f.42.2025.01.25.12.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 12:23:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jan 2025 21:23:19 +0100
Message-Id: <D7BFNSFK7P2Y.1MHPLEN8MNDLC@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Nicolas Escande" <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250124113331.93476-1-nico.escande@gmail.com>
In-Reply-To: <20250124113331.93476-1-nico.escande@gmail.com>

On Fri Jan 24, 2025 at 12:33 PM CET, Nicolas Escande wrote:
> When AP-VLAN was added, we did not add HTT_TCL_META_DATA_VALID_HTT flag t=
o
> the tx_info's meta_data_flags . Without this flag the firmware seems to
> reject all the broadcast (ap-vlan) frames. So lets add it same as ath11k
> did it in commit 5e8a373c8699 ("ath11k: Add support for dynamic vlan")
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>
> Fixes: 26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>

I left a 'fbx' in the title that needs to be removed here. I'll send a v2 i=
f
need be, but feel free to remove it yourselves if you take the patch as is.

