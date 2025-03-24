Return-Path: <linux-wireless+bounces-20787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C237A6E6F3
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 23:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B28616AADE
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 22:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB111DA628;
	Mon, 24 Mar 2025 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvgPWPRc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C391198A34;
	Mon, 24 Mar 2025 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857193; cv=none; b=FaPSe23ou30lB53ANY0e/FJYIZ4k4sf7JemGs34N6arH0aOnbCAcApYae43pPE+vfKoxkVn4AjNEFsE+gC7ZFmMxsCNrfY+c1OoEub9AfoWdkD6Eu0GRHrOg2SNY3jH01VnL3tFMbxpfYW/AY4A4hZ9rBHm2SJ1wPkIOYIDoJwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857193; c=relaxed/simple;
	bh=Lw1mP4qAeaD2JWWbT/o7f/jVHtDLVrGkTT7I1/dyG1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbD3CNdzw42mLaz/rAvA4hUm0fva3wA1OORWSUzUlNkZwrrONIscvAYQG0bp6hqJxIFgF61CZqKQCS3dugEgNhfgQhmKbqM73+qoxk3jShgqJMrsaFE6Tc2khme5z2+LYhnCV6KJ14Yynft40wO0evrH4a4suAhNJVFGnWY7CEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvgPWPRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1063C4CEF0;
	Mon, 24 Mar 2025 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742857192;
	bh=Lw1mP4qAeaD2JWWbT/o7f/jVHtDLVrGkTT7I1/dyG1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kvgPWPRcCAwczrYTg8HGdP9ePFv0PUMVMuiEiNTNBR6BagvCuXvhR8IwKaWnDyueA
	 CqOQ1FAfY3znCDXqVmMxVTcDf+Mj9r7oXP9qIuQSq6ODFViw6fyqqQFZlBq3Wk84ML
	 GuH4WqrqCKcMF1hItKbNJFHn+nHfkfVnzgWCEuugSG38PzZx1DlMck2TXf57CvyKZ7
	 48uUi/LbipSHxBT8JK4fsqHZoIr07kjWT/oQx2VZWXeVtJQrrnvlK8U77ikuZPPrw2
	 crgLVAI1xUj1LZSTa+7vX3QKEszseKJH9lDTsus8JdombMXir9gX7udJSBWXy0OZiX
	 GTWYCU8z8BZAA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso7384943a12.2;
        Mon, 24 Mar 2025 15:59:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjLK1QykkOH1bBS4H+3eJS35Bt20MTXB11UqwUeXj3Cu6bowEG2Xa+TwGLY+wlGawJ135fyXHEJw6tl2My@vger.kernel.org, AJvYcCVqGio8g587gbSRl8K9TBoXMwO3itOgl7bbak4t/+VYq0znrwe0pYGBNfZwiQfyzzEnsRI5QxeWctquiVHUcw4=@vger.kernel.org, AJvYcCW20IMCF++9h1mR3/jDPQaE/jqCRilwOK+OpuvQLYurwYGb98BjjdH7kauqnlgULrjpUSuRTSLBrOmEZjZtkQ==@vger.kernel.org, AJvYcCWMnE4qHNf07O2pPvt7FZYEGalkhCqoXcYMlIp6nR1b1oCG7mzRWTbU4MYWTRvtVy5PxKD+84XD@vger.kernel.org, AJvYcCWSYXFVHEWLNXUkfupe65Plc3GK7fLsivBoA0POroTTqxekuk7BTP1HYGcHZ4W5IfXCAohZA1yexo8XuvZIBuY=@vger.kernel.org, AJvYcCWel3+sfxmz1ZwITc674B/3zkEod87Kzou5qpIGIfUriNvUjHLoiAlaHEVgQZQWslQf1NGr0/DtIpB+kw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+TPpx4XP5yO/9BzmRuaKTVBBrTwTS5z25DpkUZdEu+78bMwH
	WE8mDdsNpjVhdVXXHkpqVJ7e6Y+8idm+TVrSd47+LQdWvWuhRcVQdXYkaTFTH7ezOU+sRadf2hV
	ek1yGG57glbtLoguKCd2Z9fcEsw==
X-Google-Smtp-Source: AGHT+IGMI1Cl7DYidw+DSHuEV1LN/O9iU02wqw1tml5Iu5KEnu3G+HWexYp+f0u6TjbJC81n8Ym/RO+LHqMzqmOjC8w=
X-Received: by 2002:a05:6402:13d0:b0:5eb:9673:feb with SMTP id
 4fb4d7f45d1cf-5ebcd4f8250mr12537192a12.25.1742857191292; Mon, 24 Mar 2025
 15:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-dt-bindings-network-class-v5-0-f5c3fe00e8f0@ixit.cz> <20250324-dt-bindings-network-class-v5-1-f5c3fe00e8f0@ixit.cz>
In-Reply-To: <20250324-dt-bindings-network-class-v5-1-f5c3fe00e8f0@ixit.cz>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Mar 2025 17:59:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJt-3mA4mnfMkS10pbPoAPKJ=Q4P3r0P0fzTZDLX+H5NA@mail.gmail.com>
X-Gm-Features: AQ5f1Jol00ghFWSCxCHKge5D28bVFmC4YsOFGlu-gViPVE2B_vZ9pKfwkJkFqNk
Message-ID: <CAL_JsqJt-3mA4mnfMkS10pbPoAPKJ=Q4P3r0P0fzTZDLX+H5NA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: net: Add network-class schema for
 mac-address properties
To: david@ixit.cz
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	van Spriel <arend@broadcom.com>, =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andy Gross <agross@kernel.org>, Mailing List <devicetree-spec@vger.kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 12:41=E2=80=AFPM David Heidelberg via B4 Relay
<devnull+david.ixit.cz@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> The ethernet-controller schema specifies "mac-address" and
> "local-mac-address" but other network devices such as wireless network
> adapters use mac addresses as well.
> The Devicetree Specification, Release v0.3 specifies in section 4.3.1
> a generic "Network Class Binding" with "address-bits", "mac-address",
> "local-mac-address" and "max-frame-size". This schema specifies the
> "address-bits" property and moves the remaining properties over from
> the ethernet-controller.yaml schema.
>
> The "max-frame-size" property is used to describe the maximal payload
> size despite its name. Keep the description from ethernet-controller
> specifying this property as MTU. The contradictory description in the
> Devicetree Specification is ignored.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/net/ethernet-controller.yaml          | 25 +-----------
>  .../devicetree/bindings/net/network-class.yaml     | 46 ++++++++++++++++=
++++++
>  2 files changed, 47 insertions(+), 24 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

