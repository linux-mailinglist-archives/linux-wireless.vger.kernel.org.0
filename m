Return-Path: <linux-wireless+bounces-4628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27A8797A6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 16:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3F21F21BED
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A17D070;
	Tue, 12 Mar 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q750xh3l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B507C6C3;
	Tue, 12 Mar 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257607; cv=none; b=Y0CPp9Gd6Ja6Lq2WCX3jwh+vndB3qRbYiiUMM3/wdQFQ/wYN/HDb6lQjDURwY0Ekh41/VABs3mwLO1cuKPzRRCSCCcL+gTJV7sd1twGGy9lzrwNwDEQ8EZ9JqRkxZexwSnPUPnPUSKkGdBGbdskfMV4o/gyDdGzgq7G6Tf4nr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257607; c=relaxed/simple;
	bh=ADO9yJE067s5VOKhJ4KMia+dY6MInz08bU/j0AUbkwo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=lfjWE3mvlFTmh8g+MMKaRSVRxSdSHA0v4dZyNY7UmAat4n6apn5MbUKPQKjxEbwBoFqmonsg6U/d/19gmvM63PLY/6DVVC02gGUdNQKKhYfONGpZkU11C74pm6IdtxsVCsoFd3rxowk/YBLlWcm0xtui2KBOvuyiRnA3UuS78tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q750xh3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AABAC433C7;
	Tue, 12 Mar 2024 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257607;
	bh=ADO9yJE067s5VOKhJ4KMia+dY6MInz08bU/j0AUbkwo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Q750xh3lLx/dpGU7uGJmUVsK0VZ9aN5V9cAWXP2G06BpGSvJ3/FTWzwycT5zPLAin
	 vHkSezewIemB0lMnY1w06wTOkhU7XtOZ7pecz67hXYqKXDzGqyX+OghwbIEe578gH8
	 F/4olkcOiweXnUAj0H1aZSzlJ5yLgrItqeFRIRyN0rgBVUETipDeiszJqoj3t163EC
	 +XYawMghRIDZym9B8jWhH6sGuUFw4sPQkDS9Rwi0NowT/nvrq3QGK30r8uofz8jQBz
	 y1AwhCNKOZFBVSnfT2fzqJALYH5U2hj/NbQZZ+s+HYRz1sid2uXlrQCuHJebPKg0NW
	 JFLtW5NGGdYkA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] dt-bindings: net: wireless: brcm,bcm4329-fmac: Add
 CYW43439
 DT binding
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240309031355.269835-1-marex@denx.de>
References: <20240309031355.269835-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
 "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 van Spriel <arend@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025760240.1969294.1528607875134063664.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:33:24 +0000 (UTC)

Marek Vasut <marex@denx.de> wrote:

> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon. The
> WiFi part is capable of 802.11 b/g/n. This chip is present e.g.
> on muRata 1YN module. Extend the binding with its DT compatible.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied to wireless-next.git, thanks.

086ba26d55dd dt-bindings: net: wireless: brcm,bcm4329-fmac: Add CYW43439 DT binding

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240309031355.269835-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


