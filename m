Return-Path: <linux-wireless+bounces-11643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8F9957A2D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 02:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AEAB223B1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 00:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A871E3CBB;
	Mon, 19 Aug 2024 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuZeGlNT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0D16133C
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724111990; cv=none; b=d/+auDgBCpXinSyQxRjQwt66LB5fXlGE/pGh9b6N5hGG3BrKTdu2sygHttmn9grr0u8iJtPSsJ9h4UZXfLQRpdAdtZRy1HayI4N+tMOZeE/9wuCGSY+TT6Ttft/bOckAFKMoTPd5lC+oarr5Z7e6lA7ZgkxSUwzUmY6yhyQjVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724111990; c=relaxed/simple;
	bh=bYGkLaGQIKKpIurG7KT++3ABazri0PYOu/DJ7PB8sgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD+uB2Xkqdyv8F++hyWSbMzFtYf79bX6Woj1GlgdzRpYLuHFEbX0/gvSxM0Nzrt4lkr2DBXYdT40EF9HlVnIOo1vfuh2oY5cl6kROKtdiNe0PEh8PmkeRgNbF0ywAEWyC/Mk4FUsV9FFdvnDtF0CBi6H8+V5+YptS29yvdvIuRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BuZeGlNT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso3588467a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724111987; x=1724716787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjABo7s3VKOBABg1ESnYjtcKOR4+Ado7alcRhqBh7E8=;
        b=BuZeGlNTjQIsRAlZO+hJKgR77LbpB31ApwZ4nqT2AxZsbOfBcRD23nXCvm3kDTokYo
         i5qF2A6F9zprAchoa6xF3ywQKxrxbjpGxVKwmCLf4RqpyECr83WMsOTMUn79cfooVyDO
         EPgk7URSPnevuRxlI1eyMoCh0tyc/ZbApxKFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724111987; x=1724716787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjABo7s3VKOBABg1ESnYjtcKOR4+Ado7alcRhqBh7E8=;
        b=rWfk1sHuLGyzRQy7ny/ZAgzXeB5KHC3UsqrEDGuEWPBpKWHGm9yhZFEe+W7F6dmIeq
         ubqfwP0ti7dL2b4w4rObGEPvbUKXKTw/Y4uuvSB6PSoy3P7tvVue+DJUYXdVC7naZ5EH
         M/YIOfabY5WbE1z8bUEvUTeFu3oHlqsT0AW8P0M9St7hIT4PZMpHgwXCwi0h7N3pFwaT
         /YXkbJkEBm7wtxiktTqLxrUXUSUlLoaZercTm2GujK/+G8s5MnQQpCmTnc9j+BFFjFSH
         riJO/BEXPG4vUGOjHAqIBduQkc/9g0AdYrKLfBLv9RTjVCksCh+Re73Z0zd6MCYdpywv
         cLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpdI46Kq1btZoGejpNz14UPJ2DlABQnIvFAY+KAsqjM9QpjwBVxTZ4mxfx5HujBhiFonsZe9z9dF5tfLauiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v5RCn+Zv2Ef+PvqGpKEY3joOHzIkFeXdrpL8BafeVI473kA/
	pP/bcddl0CMYQ8GldSJeewtpVyN3zVquM5j78JazYfMp/dZAoliJZWfZugp07g==
X-Google-Smtp-Source: AGHT+IFSEcFmKUg3XiTqxX1M+k4JhQXhtjsl3FmnrLps51L58VtAENMFX3m5ZUuTFgjG76CV4pxDyA==
X-Received: by 2002:a17:90a:4d82:b0:2d1:bf48:e767 with SMTP id 98e67ed59e1d1-2d5c0ea8a13mr723064a91.29.1724111987241;
        Mon, 19 Aug 2024 16:59:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:917:3d68:a539:4ba4])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d3c8839392sm9451229a91.56.2024.08.19.16.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 16:59:46 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:59:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: net: wireless: convert
 marvel-8xxx.txt to yaml format
Message-ID: <ZsPccHaCMRgbNk4L@google.com>
References: <20240816171203.143486-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816171203.143486-1-Frank.Li@nxp.com>

Hi Frank,

On Fri, Aug 16, 2024 at 01:12:01PM -0400, Frank Li wrote:
> Convert binding doc marvel-8xxx.txt to yaml format.
> Additional change:
> - Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
> - Remove mmc related property in example.
> - Add wakeup-source property.
> - Remove vmmc-supply and mmc-pwrseq.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
> failed to match any schema with compatible: ['marvell,sd8997']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - Add Brian Norris <briannorris@chromium.org as maintainer
> - Remove vmmc-supply and mmc-pwrseq
> - Add wakeup-source
> - rename to marvell,sd8787.yaml by using one compatible string, suggestted
> by conor dooley at other binding doc convert review
> ---
>  .../bindings/net/wireless/marvell,sd8787.yaml | 93 +++++++++++++++++++
>  .../bindings/net/wireless/marvell-8xxx.txt    | 70 --------------
>  2 files changed, 93 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> new file mode 100644
> index 0000000000000..c6647672b7b1e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> @@ -0,0 +1,93 @@

> +  marvell,caldata-txpwrlimit-5g-sub0:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Calibration data for sub-band 0 in the 5GHz band..

You have an extra period in this line.

> +  marvell,caldata-txpwrlimit-5g-sub1:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Calibration data for sub-band 1 in the 5GHz band..

Same.

> +    maxItems: 688
> +
> +  marvell,caldata-txpwrlimit-5g-sub2:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    description: Calibration data for sub-band 2 in the 5GHz band..

Same.

Otherwise, this looks good to me, so feel free to carry my:

Acked-by: Brian Norris <briannorris@chromium.org>

(Sometimes Kalle will make trivial fixes like this when applying. I'm
not sure if that means you should send v3 anyway, or see if he'll apply
this on his own soon enough.)

Brian

