Return-Path: <linux-wireless+bounces-661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC59180CAAB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C1C28143A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5FB3D97A;
	Mon, 11 Dec 2023 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMU126Iq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF23D96A;
	Mon, 11 Dec 2023 13:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB4AC433C8;
	Mon, 11 Dec 2023 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702300778;
	bh=14b8MaU/hnBaYQlH8lI1a2ICpqFlCvxCCLO/vs+uke4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CMU126IqISHpe+SzvvYDAcxghaGz2CDphwzr1Tac6jVTZBK5HfZw8Dz85qvRyNyga
	 Ke/D7HhAZOau2OkzBpsKX/0gR9QnKKOZjOFO9rnsuzLGmui/92fYFvZ1BB90NOpVrj
	 y4e/2N+2t1GhEnJuxUPio5eENx/+L5rEyF3GmJIGBq4AvVYhYsQHYuo1SrzzkxebHJ
	 2XT5yba3fNNxm4fAs5QnQfzc1xTiKocFJXIFrvEUfCptyw2WK8VqnM8wbg7XpZZd8e
	 m4BgkXKi9IzZXsIg9ji5VjlEHxSgCe7KJfKI1dErIxBOJM4PL8+SdC5KNSX+4s6qJF
	 21o7/86+3i+PA==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh+dt@kernel.org>,  Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  van Spriel <arend@broadcom.com>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: wireless: brcm,bcm4329-fmac:
 allow local-mac-address
References: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>
Date: Mon, 11 Dec 2023 15:19:32 +0200
In-Reply-To: <20231209160505.237843-1-krzysztof.kozlowski@linaro.org>
	(Krzysztof Kozlowski's message of "Sat, 9 Dec 2023 17:05:05 +0100")
Message-ID: <87a5qgq3kr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Some boards come with local-mac-address property.  Allow it, and
> mac-address as well, to fix dtbs_check warnings like:
>
>   apple/t8103-j456.dtb: network@0,0: Unevaluated properties are not allowed ('local-mac-address' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml  | 5 +++++
>  1 file changed, 5 insertions(+)

Wireless patches go to wireless-next, not net-next. But no need to
resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

