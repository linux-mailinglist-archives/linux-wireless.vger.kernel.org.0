Return-Path: <linux-wireless+bounces-5744-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7789511A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 12:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDC4B26517
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06FC79DC5;
	Tue,  2 Apr 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyggrUQg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1F79B9C
	for <linux-wireless@vger.kernel.org>; Tue,  2 Apr 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055468; cv=none; b=Hs3ZhOqqziACY7NRVQ26sRCB90/BE8Z1rFazsKwbe6OXk20ckvyht4LtpPRo4xX58NFIAOkBUImNpd8lu16Sy3PN4zzRst995zLlu5+TgLCdTGPB6b3ZAEIAe3qnhsg2MaUusD/aRXkfB92feASTprSegm+YI+qh7x+aBXc4qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055468; c=relaxed/simple;
	bh=Hr7Xp50rW+8exIfPBdNB+2gt14zjJGKAfeBvyG31h3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNyKZfuuwN7SLLesEGSy2idfTKCrnjBw3JeQS1KBkXUTfJcrgDOq5vCCmz/UHK4fc7sRrGgnw+Lnv5CB/RiLede4QAA/0snM0FTqqPycn21eX+ABLfL0AyuNZNBZnTU7ZGgC2Y6a14IfBtn0YG0ep9L9qQwfT5OTawhMBD2Lqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hyggrUQg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6153e169066so1170827b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 02 Apr 2024 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055466; x=1712660266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=heR2AZ16RGjephYYk3nVkJQSU4kssIE/CVztHg4PbLw=;
        b=hyggrUQgPnmeMneJ2liKSXdae8XB3vszf+yzwwLoMQbrbQ1dP1eS48Y+tyYwbmBrc/
         ytyVyVA0dBnb9mLjmfVG+gUnkYPGMis+KyO02sGIoVbpd83ivPNUATWHBbvrto3XlA9F
         821l34KnzZKYkUahoCGLnK0HYEtCqZ/jiqtkF01hfcqRVzNEgCN5/wSX7CYqg0teMdwn
         BnMPqSPFuT+9LwQED1xHAVFj8Ktw59J3mhouSp3Ei2RcCyBjA1BSBXEWfeDJy39xl3Jk
         RouzQAqKFJ2fmZ61DJ6tNXohSnKkTbj9owNvyJF0ep6UyTdy+BygpGJtJjgLo+TFKfD5
         nh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055466; x=1712660266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heR2AZ16RGjephYYk3nVkJQSU4kssIE/CVztHg4PbLw=;
        b=Ka+SUgIz3u9gV93PajTvsH57n/z5UPUQkcVo3mEuuqRuvjxe6+MvHr4CRl3YzX4Fjo
         UaHZkysiq22UKNd1l7Fc6b/9Ews5R7+mzmebkWtu8JjcL6XGeIZwQgBMFbAKqWobcae7
         a48u94wjTHARTMdz1QCssO37T4p+tlFcO9oH/35mAgef3xn/zJFp6Ms03oEkePQ7U6ZD
         rKIhNwBBnZl0dIpm6Xdr3FNR4yahS2fQerP0PL1Yag16rjxu3VDNAxRngmoHTPlteQoJ
         HWnI/U0veOZAY9RfdhVOiWJRSGX++2DgSP0KK5iQiqmxPMZG9qqLIUUi2eXWLg3lmwrM
         JThg==
X-Forwarded-Encrypted: i=1; AJvYcCUzi57ekvBEQ7m36YfbOkvnDLwUF4ZQMOA2BcPJHJC8z20qYuDCvX6/S3x+FcWyD12LhN1iiNnPShBr1Pa9tvXeQV3OKR7oobiZivBSiDs=
X-Gm-Message-State: AOJu0Yy4n1m/LkBY6Gvq/14vveVx+eGJs46T/CWVjmk/3sN1ctYJk9Ks
	DKUikaMH3zqhN2Z/l3LjLQKMVAHzqMYznQ0dEQa8LyAnG6QYc0415SwZNq2Nat/qi9jKrKT7Rq2
	YYMG5W+rXyZPV00RikNZADug5gVACcqeP4LaZYQ==
X-Google-Smtp-Source: AGHT+IG0hl043sikYSStWfJMtXPIZPLFFTefeWAq9LsJotUVsTuh5FFEl/udwTnzeyfi+7Th8cC2dNNikPb4b1WN2ok=
X-Received: by 2002:a81:5d45:0:b0:608:e133:7ece with SMTP id
 r66-20020a815d45000000b00608e1337ecemr11694233ywb.36.1712055465511; Tue, 02
 Apr 2024 03:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
In-Reply-To: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:57:09 +0200
Message-ID: <CAPDyKFqct4ZV3UbTzWKO08MzDTm_BX6K02kefV26mEain0SXqA@mail.gmail.com>
Subject: Re: [PATCH 0/7] mmc/wifi/bluetooth: store owner from modules with sdio_register_driver()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Brian Norris <briannorris@chromium.org>, =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 18:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Merging
> =======
> All further patches depend on the first patch.  Everything could go via
> one tree, e.g. MMC, or the cleanup patches removing owner would wait a
> cycle.

Patch 1 applied for next, thanks!

I can certainly pick the remaining in the series through my mmc tree,
but waiting a bit to queue them up to allow some more acks to be
received.

Kind regards
Uffe


>
> Description
> ===========
> Modules registering driver with sdio_register_driver() might
> forget to set .owner field.
>
> Solve the problem by moving this task away from the drivers to the core
> code, just like we did for platform_driver in commit 9447057eaff8
> ("platform_device: use a macro instead of platform_driver_register").
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (7):
>       mmc: sdio: store owner from modules with sdio_register_driver()
>       bluetooth: btmrvl_sdio: drop driver owner initialization
>       bluetooth: btmtksdio: drop driver owner initialization
>       wifi: ath10k: sdio: drop driver owner initialization
>       wifi: brcm80211: drop driver owner initialization
>       wifi: marvell: mwifiex: drop driver owner initialization
>       wifi: silabs: wfx: drop driver owner initialization
>
>  drivers/bluetooth/btmrvl_sdio.c                           | 1 -
>  drivers/bluetooth/btmtksdio.c                             | 1 -
>  drivers/mmc/core/sdio_bus.c                               | 9 ++++++---
>  drivers/net/wireless/ath/ath10k/sdio.c                    | 1 -
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c | 1 -
>  drivers/net/wireless/marvell/mwifiex/sdio.c               | 1 -
>  drivers/net/wireless/silabs/wfx/bus_sdio.c                | 1 -
>  include/linux/mmc/sdio_func.h                             | 5 ++++-
>  8 files changed, 10 insertions(+), 10 deletions(-)
> ---
> base-commit: 087c142b2b04898c897aa77938d05a93907150e5
> change-id: 20240329-module-owner-sdio-abd5de3f1d74
>
> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

