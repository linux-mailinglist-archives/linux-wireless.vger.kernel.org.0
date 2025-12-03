Return-Path: <linux-wireless+bounces-29480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D9CA1BD0
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Dec 2025 22:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C518307A21C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Dec 2025 21:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1D2DC766;
	Wed,  3 Dec 2025 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TpsGPBE5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B72D6E4D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Dec 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798659; cv=none; b=bvA+J/IvTpaWpnOIxgCzZFx/1Y39dLqVfAk+5s0LhorgliBzvMdMrF5MxI/Hu3CUnBxHHO14x/efcfqJSg0ExsEa01E3Fxo72Yv9HanvAXFVOEtI+jiTXi3497l975i5I7ig9Cje9WsyM3m1jRJRj2ERrxPkw33WJt9R+uIHoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798659; c=relaxed/simple;
	bh=PZj3jANR6/nSU6UkeOQuWgGLC3q5F/VtSyt7tbEpauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWLjH38XH/1rqyFudf6oqBF9NXwSjXH5Wxh8khqHO4wUbH/oqrfdIFU3oXdYSGUWV23Q/1suPHvXdK+3iOCym0PEBQcsJK6OI4gqEsosh9dzT366MaGU392ZOpB4mMKcznw3IutOnnnrqwTirZQZC/WgtRwZi5uNOg6lx55czYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TpsGPBE5; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2a45877bd5eso2026683eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Dec 2025 13:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764798655; x=1765403455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6chODghEB4z80xHdOkemzEluE/IBI6XrITBvqfM7dE=;
        b=TpsGPBE58rbo5KCTYqgujRkIIMkBKqs4f7u/+pa25FqLzR0iQEdN6Ey5UXF7eF/LAf
         P0mYb4NZguqkp5XJDbG3yufvHhEewGXSKauLxZXmScxmytiaKSAKQTfce2RRpSrfvYYH
         7yrLIw7FDmVwlDdo0eXJRDB+0RkQVbDVYKS5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798655; x=1765403455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6chODghEB4z80xHdOkemzEluE/IBI6XrITBvqfM7dE=;
        b=AaZB0GfSIxSPqdSJHfjYXyk4w7u6Jp4jMAxPyTjFQ9JERklQmE2uJ9bHw2RAB/CNtt
         bUpz0ChSsxEyGXqpGcXj3SDWbr8kN2Xc0sPwpXKX6oXw/McKyOfYcR+8wKsq4QAI2Rg+
         6MSDMchEyy/CtjRrypllRFKFsNnucs/VgjJobYtM7U60hlozyhJ2OV1hjl5b+ibwG24/
         Yeia4IQvayJ8E20oJBDjukmIh30QrWf5wDwxSpzi1fxcYw6AWFbg5CfPTHSzCrVq1SLu
         nJCiSKd58XqbRXYKMbTVKer2fAKGPO4uaqWXmjZcpD2HzAUVdITl+Bt+PVn3Vrjd3rON
         fjWA==
X-Forwarded-Encrypted: i=1; AJvYcCXM20MepgEESWM7OcmbYdxro3WXVQplaNCihyMKZCgkc/2vx3Yl3r7DBvhyhQw7PIv3Yz0CPeAv4aHkTOkOow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPO4qvHXuAm0O8UNfod+vJ7u0qkiKCU3+722iPRJ35XAAP+yBv
	BW65hTanRQ/223rq/I/Z1oJI8QK60eDP95Qo3vT6M3GWdgLZkGAMay/6aBDRwsnCyA==
X-Gm-Gg: ASbGncsCne8krs1HoJRFqG2m/bt4n9EoyiM0aTmIVg1ZkVc6/V8JVcL8wjzwNIdsjDB
	u7wTxs1MAH4lKBN+jsjKjyNmjBcM+1RPvCPDgknWl5UdAz/viQnQpAdsl5jxSzcNhSkUCa8wNY7
	GvOZhs6wCNndL0zlKRyCfuPYgYdvcGLiq0Kqpm3xYUnq84I4Z7fqbPikfPkonQvzb1TV1l0U9fP
	B15COc6/8N0JRbvxOJWsjlr/2lL1n1o24yjtUAUKCWILPFmLl84Oqo7qG0257eSjmyq9mFj6vVA
	gqp9vasSqjV2aceLlSd56l6PsKAH3lKIL8FkwA5qkkJQqfd1qGXvIa7W4QjMeytHqoohEqb+IOj
	JCq3m5oX4gmDq7MbzIMKfPQrBCWAlbvPu6Dxgg40EVHYYdUJh1FCHFpNad5c2dAA6yHh3gNZDtg
	1kn94zftH/1yYankQswgYsXxNPjgc1diPaKGM2l4MNwlsNTmOwUw==
X-Google-Smtp-Source: AGHT+IEIEIBW08OkV8WK/jMyO0yClG6Glkh0kZ5O3uJlxkndo5BOSqM+ZQ1/IXiO+9a7SW6sezHK1A==
X-Received: by 2002:a05:7301:60e:b0:2a4:3593:cca7 with SMTP id 5a478bee46e88-2aba3394a44mr820588eec.4.1764798655218;
        Wed, 03 Dec 2025 13:50:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:e953:f750:77d0:7f01])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a965ae9d06sm69699431eec.4.2025.12.03.13.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:50:54 -0800 (PST)
Date: Wed, 3 Dec 2025 13:50:52 -0800
From: Brian Norris <briannorris@chromium.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [DONOTAPPLY RFC PATCH v2 1/4] dt-bindings: mwifiex: document use
 with the SD8777 chipset
Message-ID: <aTCwvFBE6IF6WT1d@google.com>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <20251026182602.26464-2-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026182602.26464-2-balejk@matfyz.cz>

On Sun, Oct 26, 2025 at 07:20:38PM +0100, Karel Balej wrote:
> Document the corresponding compatible string for the use of this driver
> with the Marvell SD8777 wireless chipset.

Device tree bindings aren't supposed to be about "drivers". This can
just be:

  Document the compatible string for the Marvell SD8777 wireless chipset.

On the bright side, it's totally legit to describe HW bindings even if
there isn't driver support yet. So:

Acked-by: Brian Norris <briannorris@chromium.org>

> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../devicetree/bindings/net/wireless/marvell,sd8787.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> index 930b700b73d0..d31ff38f57d1 100644
> --- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> @@ -18,6 +18,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - marvell,sd8777
>        - marvell,sd8787
>        - marvell,sd8897
>        - marvell,sd8978
> -- 
> 2.51.1
> 

