Return-Path: <linux-wireless+bounces-11787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33995B0A8
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A7285E95
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7D216A955;
	Thu, 22 Aug 2024 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8seBVz9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776E4CE05;
	Thu, 22 Aug 2024 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315825; cv=none; b=U9K69Ais+JONd385tvfXWWNHNju8Y0Ch8mP+Ph0KtgypbJb2wRYoRFBcguhL6s1UeTd4QdfPy2bQVkESMTN/WuCW1qUO6EtjIbe+Iop0uDBC8aPm40aS5V6Ac6Tn7zneeBtP9qvdStKyg95aZ9woU0vDVKfcjD3rsZzPodo5hbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315825; c=relaxed/simple;
	bh=WFWK/7hBRq0sgq5LtF/lL7FET0lw7shy9bkyokw1jIE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uG2aT2Fp6QKRT+2OjYO/B39TYfc9r98TZ9/JUNRiSn9ZnheCr3t4pa0G2Td0NuaTrRkqzPXNPhQPBGcAJFz91aI6rKlffxDVd/+OGEmDb3nWeAylKfBxDN/7rDJI6arcUCsKP7O9FLC889prpFKgAHTm4HtOT6NuqHx6bWVzUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8seBVz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7E3C4AF0B;
	Thu, 22 Aug 2024 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724315824;
	bh=WFWK/7hBRq0sgq5LtF/lL7FET0lw7shy9bkyokw1jIE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c8seBVz9aP+jB/1G1+A6YAFhBRALZoNAXa/tKULq5dJh/yqodmB3CLCCohRKfN+1I
	 LB66ZC00TmVH734Wwy54I4r0Hsklv8HGkLnFB04bXkNwEaWSrG/r7gV2vzgGT2qsUE
	 HK6SGI7O7+9Bb8DYecsLJSPBFNCS3P0jXTGYf2SXvgOKetWjKPl/MPUEWP5ZvC67XY
	 FRJ6N0JDp3S1sf9yl2w85RVlcY5ejvQcHJwCqe04SVWg4WgbK5Tf9EpKReA4Ecyhcj
	 RI0cRaDD04XGc4pIv8dkruBcn1Z/5vSyr+TeaM4/G64u22DsQgPMOZRE50Y9kaYu/t
	 mu8RHejQh+pXQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: brcmfmac: add support for TRX firmware download
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240818201533.89669-1-marex@denx.de>
References: <20240818201533.89669-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, Chung-Hsien Hsu <stanley.hsu@cypress.com>,
 Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>, Marek Vasut <marex@denx.de>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, =?utf-8?b?UmFmYcWCIE1pxYJl?=
	=?utf-8?b?Y2tp?= <zajec5@gmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Carter Chen <carter.chen@infineon.com>,
 Duoming Zhou <duoming@zju.edu.cn>, Erick Archer <erick.archer@outlook.com>,
 Kees Cook <kees@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mathias Krause <minipli@grsecurity.net>,
 Matthias Brugger <mbrugger@suse.com>, Owen Huang <Owen.Huang@infineon.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172431581868.2154344.15348672155352447310.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 08:37:00 +0000 (UTC)

Marek Vasut <marex@denx.de> wrote:

> From: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> 
> Add support to download TRX firmware for PCIe and SDIO.
> 
> Signed-off-by: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Signed-off-by: Marek Vasut <marex@denx.de> # Upport to current linux-next

Please fix the review comments, also Ping's comment that from and s-o-b
needs to match.

2 patches set to Changes Requested.

13767592 [1/2] wifi: brcmfmac: add support for TRX firmware download
13767593 [2/2] wifi: brcmfmac: add support for CYW55572 PCIe chipset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240818201533.89669-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


