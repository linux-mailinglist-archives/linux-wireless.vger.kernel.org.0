Return-Path: <linux-wireless+bounces-5859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4E89841F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134EFB28879
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A5762CD;
	Thu,  4 Apr 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDIQIVuS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCCE745C3
	for <linux-wireless@vger.kernel.org>; Thu,  4 Apr 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223094; cv=none; b=LUP3q51vr22BlZ9Kq5f5cj4zChh/vVZ3icW91kSiNwHqcgF2bg4PNfMLb216Ai0hETsTQKJ49cXcQlMVKki1bJYsrR8rpHHtdZu5zrb3Ld57Hmp8406iFI0liV3UmXrvBbN4VHoj7RQcsBOr3haeLaMGxm/snPlVUHCli9B5ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223094; c=relaxed/simple;
	bh=eal+hbwuJR0GkxwgPiJg2NCYAvGM7tKiSJzcHq0j6dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGDu39kOOYYBTrgxVuEEeYsSH9NqfXMNATNNl/MffW/sO7CBxulMij+aD6K64wo2qV6NL802O00WeB8dPfbXtmV4kc1xHSOSq9gjJ/rGarkeG1cg6OjQcE2qn0QMciCWyAuylcxB9N0ZNT50RA3/WWEcUYctE+5T2CpuLf4ntt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDIQIVuS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61524d10f86so8883637b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 04 Apr 2024 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712223091; x=1712827891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJzdwgYqSiXBG2wAbt+70V3f0hLZ0hXphRY5qJD39hQ=;
        b=IDIQIVuSWzz/kI90Xib4W+1zCVY4pIjQCEiWSvoH9xAYiIDaC3HmgZPB70q3bF5Zqw
         J3hlygutFS16HiA6/H5LLfPmfDTCBbjjPvquHBCVt6NyvlAanqlqHijX2yXkcRe3AIla
         IqkOX86dse2kSa0XxKO16AsIJlq1Nr2gNhAb/1B8szRxoaYtoN5h+HzVlszju4xMaqGH
         sbsO+JX9Czpr9v77XztS15C4DFvS6264r57pKsESNJeR4wm0QUtUz7x3aG+KgmpY70d1
         SN7d2gEhfeHJW1sikNgHU/8J+An0bRPLQjOZS+9r+vRbn5mm1Zs4XCvjE4dAnkr+pwwJ
         5wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223091; x=1712827891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJzdwgYqSiXBG2wAbt+70V3f0hLZ0hXphRY5qJD39hQ=;
        b=HJOsR8FXvmw20hQFogrn7Xl/ZgKwlABRfk+rVkUw8F6DbMLIPuVznBuf8aia8TZPz2
         zGMQtTuiZ81FoNRxcY+k7MBe/K2Qp2nrQ3anpuIBUwDnkhDSUfH8Bo+21sV0Zhv+vR4s
         c5Vru8UKn7b8Qoem2NzY3/G988IjAbUlt3g0XAG+faUxDzZ4wNNaqVQvvy9u5D5RqQn1
         Uz/hUnlEPxqgpgzHSm5JilbwZ8OVdr8S++ZR3ErZ66bPxqrW4G4lvOriR4qAPCmyi805
         fvCxM7+znYupmcHeusll90Ku85m+HIw9+qlPznIgqRi6+puZC+/3ciobffjCGOrOAtgV
         +yHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9wDL4mixtiSJNHmzS3n651tL8JrnvXfx97GI3NIS8/JLKV8E/G4LFBQlHaL391HGd0KgXaHp+NV96cZkDMH2CwOZJ/7DBFXqog4e0A5M=
X-Gm-Message-State: AOJu0Yy8rVIoamV0R/HS5ml7UBc+nbBZNpMKyciJm73jEY7tCEZEr2m/
	p8NX8WX/kY64PU20R8n02Wx2wjP9qe2U6aQCloH32B7qiIIEF5uaRYP1pqlgVw+MvH1ygrIcrF1
	lZqhLaLomhVXfSBjXDg/VFQKUrjeWRV6bibekSQ==
X-Google-Smtp-Source: AGHT+IHTXtbKZV4PRrgxvlL/R1tUqcSFTjPcwK6//feDtYUO9NjrShijYYET6/+oeV22B9HIEQVjv5iZuw/cw+hBGTs=
X-Received: by 2002:a25:ac04:0:b0:dc7:423c:b8aa with SMTP id
 w4-20020a25ac04000000b00dc7423cb8aamr1828891ybi.12.1712223091503; Thu, 04 Apr
 2024 02:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 11:30:54 +0200
Message-ID: <CAPDyKFodTh-KN+=b1B3V+7aNEoR0SPo5-xjFaWu=gYEtsDy1pQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc/wifi/bluetooth: store owner from modules with sdio_register_driver()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 16:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v2:
> 1. Add "wifi: ath10k: sdio: simplify module initialization" patch, from
>    my other patchset to avoid conflicts.
> 2. Add Acks/Rb tags.
> 3. Drop applied SDIO patch, which was the dependency for the rest
>    cleanups.
> 4. Update subjects according to feedback.
> - Link to v1: https://lore.kernel.org/r/20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org
>
> Merging
> =======
> With Acks from Kalle, please take entire set via mmc/sdio.

The series applied for next, thanks!

[...]

Kind regards
Uffe

