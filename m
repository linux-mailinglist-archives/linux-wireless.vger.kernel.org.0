Return-Path: <linux-wireless+bounces-9500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895D914A1C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 14:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95AB1C20F6C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1614137767;
	Mon, 24 Jun 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw7s0ZJr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD71E4AE;
	Mon, 24 Jun 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232325; cv=none; b=oNQ5aFhjUrlFU4VeUxjWwweBl+hrp1eQRaT7kV9O3EO2YQhqDI0oaJ+eal1sEgSJA34qasMSzEQcOIiOXhsoJjUcD4iZDRW8CXNvkNFQuo0g1uSxRD9QosoB9sh+7k1wpAnr5Bc28bx+ZXoO4Hw5DIAACUSo+CfCQIn82SXKBWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232325; c=relaxed/simple;
	bh=P58O4w8GCsYfN/lsqRtNfm8lTDDHx3RLixon4iT2WNs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=s7b8//D6rnFMADOHsCgtL4Rqlkqwhw5F5a7+4s6n8EptNoYjQmlkaP9SouOrNcD7tR7/iJp97K7HVwgDC0yZYlV7QCdBEWG2iXPTk3pvWOqc8RbDEihkZF7rwOocVnWs9kHQcSb3ym31Qik24btUb3Mxsb+LflmQqEU8p5G5kTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw7s0ZJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD863C2BBFC;
	Mon, 24 Jun 2024 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719232325;
	bh=P58O4w8GCsYfN/lsqRtNfm8lTDDHx3RLixon4iT2WNs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kw7s0ZJrnV+q3yeBmE3Uy8JDyd7CGT2ow+O+mI6/JhD+czDEkcfpNp8hZjP0Uj1TI
	 xBGiXRh2Rrwl8qq9ztJ19C2C/ZnpgPinTFKYaIvih3TiuR6G4ZNUkJL5He46EdIXns
	 pXc9xZzfpZLJ3sPPefn8C7mLZSvkk3ve/LnrXJ4wgx/+WMfPWOANpq7mrCxjA96kpH
	 0FVPtovoqu03zlq8aXFrueWHzHW26RwFdRFH6ozkht5SXhh2JqOv8SBgaRF7jmgN7T
	 Mir6Lt7ZOBVeCNVc7ZertF8kvbfwhOgQVdegKdmPRdxHRO+1LV8mB7vW6SG+RpGr9O
	 i5MQDWIGBwMww==
From: Kalle Valo <kvalo@kernel.org>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: arend.vanspriel@broadcom.com,  duoming@zju.edu.cn,  bhelgaas@google.com,
  minipli@grsecurity.net,  linux-wireless@vger.kernel.org,
  brcm80211@lists.linux.dev,  brcm80211-dev-list.pdl@broadcom.com,
  megi@xff.cz,  robh@kernel.org,  efectn@protonmail.com,
  krzk+dt@kernel.org,  conor+dt@kernel.org,  heiko@sntech.de,
  nick@khadas.com,  jagan@edgeble.ai,  dsimic@manjaro.org,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] net: wireless: brcmfmac: Add optional 32k clock
 enable support
References: <20240624081906.1399447-1-jacobe.zang@wesion.com>
	<20240624081906.1399447-3-jacobe.zang@wesion.com>
Date: Mon, 24 Jun 2024 15:31:58 +0300
In-Reply-To: <20240624081906.1399447-3-jacobe.zang@wesion.com> (Jacobe Zang's
	message of "Mon, 24 Jun 2024 16:19:03 +0800")
Message-ID: <87wmmeiksh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacobe Zang <jacobe.zang@wesion.com> writes:

> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver.
>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>

The title prefix should be 'wifi: brcmfmac:'.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

