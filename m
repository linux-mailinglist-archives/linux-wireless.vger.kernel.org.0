Return-Path: <linux-wireless+bounces-11790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9295B103
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 10:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1991C22B2D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B46170853;
	Thu, 22 Aug 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtGcUdh3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AC16DEDF;
	Thu, 22 Aug 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317190; cv=none; b=k9qvAHrr11U238p9CdBXg+TEc7Ad0Hi2ba4XA3vW4wBqBBFnp4Qph60/Uw2uwegyyzyIV3CUYHY15iHvzr2VIJAguxGT/TIPd60XfL0zrXe3/qr294yff0EX1fIw/DkZhR3KarruszcwBkGVUSgnLI+tWByTdvCsF3gh/8UoNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317190; c=relaxed/simple;
	bh=6fPHVZW9Wl5MBlZ31WLLPB+2/SdWlcpVd1n5Ao7R3D0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=ShsQ2CP2/vfGVZFamh6mSq3EAZFghh9Vkze30c6R36cgemeTANZcOhQslVWS1uB2dhuwph2LKCjM3col4Rg3hNO52RjcXEY36C/OEssF2HSAVm9BMJwMzn11eCSuyQ/nmreFupKMnhZ8zHiV5//bTASmCQY6+d73YvmOnU89l0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtGcUdh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F545C4AF09;
	Thu, 22 Aug 2024 08:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724317189;
	bh=6fPHVZW9Wl5MBlZ31WLLPB+2/SdWlcpVd1n5Ao7R3D0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=mtGcUdh3FeNAFmY6+9OYrE0l+cei2CTF7LHHhtjK2eR6jjh7Vcdi8g8MlRpb41CN7
	 cZrtrKMsces6P865auobuLLB3sKlPdnGtM7MOcRWOGVfLwJjN+utXCOyNTNfbzjDb5
	 HWm2fSHa7xy8YTOzNp9gqJPYplbc1Qcv7lgbPTAIeH+lZVZZ9LcWspbpXFl0jocSM6
	 XzGQzkhMEGUTaB69+6zKn8aqtNdqSy3vGgQrxSgymZtGRB+vBWynMxJ8JyF2rtIz9w
	 OU7up2fvbfWC5aXFYoFdUaNEpTtsMZWmNK6SE0fE7jzdwoM1bduonK8/l7Xle/7/ka
	 Rj13DObKI6uAQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 1/4] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240816020635.1273911-2-jacobe.zang@wesion.com>
References: <20240816020635.1273911-2-jacobe.zang@wesion.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: arend.vanspriel@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, saikrishnag@marvell.com, megi@xff.cz,
 bhelgaas@google.com, duoming@zju.edu.cn, minipli@grsecurity.net,
 yajun.deng@linux.dev, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
 christophe.jaillet@wanadoo.fr, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, Jacobe Zang <jacobe.zang@wesion.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172431718274.2217900.9766315386587933045.kvalo@kernel.org>
Date: Thu, 22 Aug 2024 08:59:44 +0000 (UTC)

Jacobe Zang <jacobe.zang@wesion.com> wrote:

> It's the device id used by AP6275P which is the Wi-Fi module
> used by Rockchip's RK3588 evaluation board and also used in
> some other RK3588 boards.
> 
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>

Fails to apply, please rebase on top of wireless-next.

Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c'
Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: brcmfmac: Add optional lpo clock enable support
Using index info to reconstruct a base tree...
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
Patch failed at 0001 wifi: brcmfmac: Add optional lpo clock enable support

4 patches set to Changes Requested.

13765357 [v11,1/4] dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
13765358 [v11,2/4] dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
13765359 [v11,3/4] wifi: brcmfmac: Add optional lpo clock enable support
13765360 [v11,4/4] wifi: brcmfmac: add flag for random seed during firmware download

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240816020635.1273911-2-jacobe.zang@wesion.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


