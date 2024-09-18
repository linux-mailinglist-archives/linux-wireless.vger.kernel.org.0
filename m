Return-Path: <linux-wireless+bounces-12961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522997BD60
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 15:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E05D282E2B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3018A94F;
	Wed, 18 Sep 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw6LNRz8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE6189B98;
	Wed, 18 Sep 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667656; cv=none; b=O2Kl/ntghPBKR08kf4FDBG60LrpJPWDSlRQrsRyLSWzBYg/qUBLvKbt1i4zIEbyiDrqZhZkE4d/pJj/gld7wI00LkyPXdiD7m3XhTJIuFapMk56vkJtoDI6C0j1tlvPT8RinQQOseEBL/UvQ+PdkZ9WFQlSawtA//dyw0pHVSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667656; c=relaxed/simple;
	bh=+Zh+djR7AX48cdY3rFqnD3jZEZXXjC49iXCG8eZYSeQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=no1CqK+8l58doy63KWB+Rpm5RlEBGtABr6pqrwzZlBGj6wZm8wO/Kek0Foz8xIFncVnqAHkb+iVfTi7Fd7K8reS1pSSq7wLN4JVfLyVy8st0mVPX0LYO0EHVwxPhXYeFfKmCnYJ99dhZOHbTN2b32M7PetcqvLlbK0xYgYCckvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw6LNRz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB6C4CEC3;
	Wed, 18 Sep 2024 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726667655;
	bh=+Zh+djR7AX48cdY3rFqnD3jZEZXXjC49iXCG8eZYSeQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nw6LNRz8J9W64qF/DfXUhAyHwC28qLffJN9zKZfGnAB/+4WgMSB8qZrvvUi/i0qR5
	 KyDVMXk3Mq8AkJNhbZh3zGmKCjXvecm+dEHDWypua9YjTdxAedFiKd8kxsGc4vXt3Z
	 VGeQsGAfQjdQYmfaoAF2lDlYOO/WorjYtPuwN6GVsgwDvSRXLt8sRZPD1LdgpvwQej
	 /7nygbP4u7B9ijApHNJu6TkMKqs7XMuHvexhh9T5TbvQ6PRYOJaRhAVew5GJKiQO5n
	 ELHYaXMykWl2r1VLrofuyR6jDYO8fdrSOhx5Pw50WNKAErP+RNn9y6L19IkGjl3Qsv
	 vUn+Jja8xj+ZA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v14 1/4] dt-bindings: net: wireless: brcm4329-fmac: add
 pci14e4,449d
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240910-wireless-mainline-v14-1-9d80fea5326d@wesion.com>
References: <20240910-wireless-mainline-v14-1-9d80fea5326d@wesion.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 van Spriel <arend@broadcom.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 nick@khadas.com, Jacobe Zang <jacobe.zang@wesion.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172666764990.3996465.9327030359445823508.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 13:54:11 +0000 (UTC)

Jacobe Zang <jacobe.zang@wesion.com> wrote:

> It's the device id used by AP6275P which is the Wi-Fi module
> used by Rockchip's RK3588 evaluation board and also used in
> some other RK3588 boards.
> 
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

4 patches applied to wireless-next.git, thanks.

97cb465ee6c1 dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
7ca3fac19541 dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
0ff0843310b7 wifi: brcmfmac: Add optional lpo clock enable support
ea11a89c3ac6 wifi: brcmfmac: add flag for random seed during firmware download

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240910-wireless-mainline-v14-1-9d80fea5326d@wesion.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


