Return-Path: <linux-wireless+bounces-10955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C10DE9478FC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B61A28142F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70BD1547E9;
	Mon,  5 Aug 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O3TTsa+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBF1547E0
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852286; cv=none; b=T/wvJ+r6dmQG5ORtXyttMXQvqiMSToCy9dCo4mW6Yay6cAVVezoFVZlE+IFQNaWNKaP+JUfEDVtQQqX4Hat5D/aiFkpH6u2kyaoQrBwfgnEcTCsLCt5/tXkT3ji1a3LTdbcywjKLIqBS7/NtIOBdLcI+bTM7Y7xPCDbFJAkOq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852286; c=relaxed/simple;
	bh=NrP89VFBY7rsx7EbXcSXKLeYzXolWV8BMUaTDdNiuIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJtCXjVzduqNJCff8nHl3o0yAJlRbqvw4AjLKPvGJ/lIqZ3bmv85oI/v9XyVDPVF7CsFhUCQLNOfIiqvbcH4dSUKltJul3Z/mNMpRyFGr/yPncv0SFd8n1RS2E+yoR87aNrGyf8/evS1liXI7xnIJMyJfAVCO8P3nYm9UcD3PDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O3TTsa+D; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0878971aa9so3991333276.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2024 03:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722852284; x=1723457084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hSYGTPrpLH+BuhVL/Q/2E8uLKhl1KfRAsEdIshJ8Sjg=;
        b=O3TTsa+DOEhyRzwzJxdy1IBqByszFg6gCQwqgUQD/YS+eunwj3Okal63tnHQD3gFzS
         mklCASjot+6W+j97Q9xgl+oMyXSXffRPE8CpBS1WTM+6tDBfIZtqdT/xazSIL7wGnYi1
         z/lmgqcTj2hExLsPZ2dWUEHuNUmiVHEG1MlLjr0hxpxldcYNbiO+ACcjROcraZAdg8Av
         yEItCOtmHBCJCIez6ao8zHGxGWnbKuWU0un2VLkYOIVqKmybvzwzrIW6SvPANNZvR1v0
         Bn+AEWvutwS8jgZmVCDuKX0NDvqLA+PLLQDqsqk0KYPRn+J13KxhyrK/KuKNSL//s/tU
         kMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852284; x=1723457084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSYGTPrpLH+BuhVL/Q/2E8uLKhl1KfRAsEdIshJ8Sjg=;
        b=pY58E2apvFeGl+zcyk7nlpyCZJuOxfI8yOQ0I/qJSXJ6p2Bf5c9CgYTd8+9f2HIBRp
         P5iz5ug6lrk6E/2QULQ3k1gM5ENshMMCvrFlgUPZkFvHL84IJWa+FyUJMb7gjn+VNLtZ
         j6dROO7qgAhG7Tz3W096ncmsHdIYntpx+iYrwfpJlPODriD38VL+XHuugM50Wg4UoFhK
         uxHSxJvWJepFUunJ1GZGkQUzeHHvuTyyYe9wQuQvHRCqJAD0Ag+VJ700XQ+0KC7lb/5O
         vHZFjlmWigDfL6BPENuFAcf4N2gDDnoF4y7xVfemwHFLoQQfyNW7h9zp+pGfrx3fGzz6
         UK8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/DGw+Auasg4qeuDPSkqR2ujWApsJW1Q1hxR0E/VkGrqU6IoxrM43Et8kkZ8Bo11P1PYBS72VooQmNH0ImVuy+f4Z812yFu6dCWYbOZWs=
X-Gm-Message-State: AOJu0YzNdWIPv3GkYXMLbmkyQI3QLh5FVvLun5AkpaRORMWdS+/7Kkd8
	L18FFbfX5zoK38cNPnh2bHxCf+6k2glP4zapfMYC9nZQ8CN4pUrM98usxlIHRqxVJ007xOtDa6+
	scMuKY+LILmLNqv8sVj4wp9qN1B4ueJe7cyZauA==
X-Google-Smtp-Source: AGHT+IE28QvjYWO5xF3nlYl96xgvVqGoKpL4LpWlRu2pROebD4A3WQjuKfY14W5cvKLlfjChMzAEUCdDmxnejwKRHho=
X-Received: by 2002:a05:6902:2b0d:b0:e0b:bf20:4fdd with SMTP id
 3f1490d57ef6-e0bde8ee6f3mr10631170276.1.1722852284031; Mon, 05 Aug 2024
 03:04:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805040131.450412-1-felix@kaechele.ca> <20240805040131.450412-2-felix@kaechele.ca>
In-Reply-To: <20240805040131.450412-2-felix@kaechele.ca>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 12:04:07 +0200
Message-ID: <CAPDyKFqyRevbmPy6h8BsiTLBi6=J+9uRmSib43bzzZHFEmDSVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdio: add Qualcomm QCA9379-3 SDIO id
To: Felix Kaechele <felix@kaechele.ca>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 06:01, Felix Kaechele <felix@kaechele.ca> wrote:
>
> Adds the id for Qualcomm QCA9379-3 SDIO based cards such as
> the LITEON WCBN3510A and Silex SX-SDMAC2.
>
> Signed-off-by: Felix Kaechele <felix@kaechele.ca>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/mmc/sdio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index 7cddfdac2f57..63000a8f4b13 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -52,6 +52,7 @@
>  #define SDIO_DEVICE_ID_ATHEROS_AR6004_19       0x0419
>  #define SDIO_DEVICE_ID_ATHEROS_AR6005          0x050A
>  #define SDIO_DEVICE_ID_ATHEROS_QCA9377         0x0701
> +#define SDIO_DEVICE_ID_ATHEROS_QCA9379         0x0801
>
>  #define SDIO_VENDOR_ID_BROADCOM                        0x02d0
>  #define SDIO_DEVICE_ID_BROADCOM_NINTENDO_WII   0x044b
> --
> 2.45.2
>

