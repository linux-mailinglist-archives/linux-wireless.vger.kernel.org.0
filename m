Return-Path: <linux-wireless+bounces-11527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020BA954452
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 10:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F3A28203C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA613DBBB;
	Fri, 16 Aug 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgtbtAOp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09E13DBA5;
	Fri, 16 Aug 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796803; cv=none; b=IRWyrb/4ibY2mzkUOE5+HKdsAjN2MUx/83vBNVrpoQusBZRRtW2ncHCG+0LV4u5j1+/Lu7epHF/bRj1zO9xaaHhf1wPgfw7ndW3Ii04H65YyB4ooRauvZoJw6RtJ+6Bat+0N6Cs3K6DBdKjQupxtbC8vj7eGTa6+RKf2YjXVPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796803; c=relaxed/simple;
	bh=5ikcztOYc3gzW8Il3p4V24J5xZfO6EdqRiPvi15rElM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=coYgqlTqgYDRNXlR2liZPRHaNJGe5IOfkh8FBN2tcxUNR/lXUdV5MbRkLIv6Qf32IWB9PDDfXRgqdViPouAT9YZxiMANwA6TqIIzUYdzb7xAGjLRDSYor4ayBecO29yJy4E7mMiAZYisIjPMRqqBLCFKHWwPea8JB+Q2TCsbVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgtbtAOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAE0C4AF09;
	Fri, 16 Aug 2024 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723796802;
	bh=5ikcztOYc3gzW8Il3p4V24J5xZfO6EdqRiPvi15rElM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RgtbtAOpiH+y/spQ6gWgAnLqBhhg9cXWVihT2rfsZDpCBEfYfdNBpShYeRutSCBEF
	 LwNKg5MkRKzDrtXirB7v6jeF5X3b5A2fT1XA1xcxtKNzBhBkVpKIzQnZUPo45m33Fl
	 l6/jHEZnnDgbaIOzQH9YLRNUx1Rsojw1Btw8HjXbiJwdCNRPiZ2HFwUt0os+YpSPJ0
	 2BGnPOAjeBi3yMYWsilO7e128zHSVFMDKl+S4G0XnYj/8XgXO5dx15tjhcmS4+RBuA
	 h7BUSakYiPQwCmc57V+h01UDRJHzMzv+qlOS+nForN4LU/06WLCkn7FdFcxpFYV+wx
	 VB4oBtniP5xNg==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  ath11k@lists.infradead.org,  linux-kernel@vger.kernel.org,  Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the
 inputs of the ath11k on WCN6855
References: <20240814082301.8091-1-brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 11:26:37 +0300
In-Reply-To: <20240814082301.8091-1-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Wed, 14 Aug 2024 10:23:01 +0200")
Message-ID: <87a5hcyite.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Describe the inputs from the PMU of the ath11k module on WCN6855.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - update the example
>
>  .../net/wireless/qcom,ath11k-pci.yaml         | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)

This goes to ath-next, not net-next.

> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
> index 8675d7d0215c..a71fdf05bc1e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
> @@ -50,6 +50,9 @@ properties:
>    vddrfa1p7-supply:
>      description: VDD_RFA_1P7 supply regulator handle
>  
> +  vddrfa1p8-supply:
> +    description: VDD_RFA_1P8 supply regulator handle
> +
>    vddpcie0p9-supply:
>      description: VDD_PCIE_0P9 supply regulator handle
>  
> @@ -77,6 +80,22 @@ allOf:
>          - vddrfa1p7-supply
>          - vddpcie0p9-supply
>          - vddpcie1p8-supply
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: pci17cb,1103
> +    then:
> +      required:
> +        - vddrfacmn-supply
> +        - vddaon-supply
> +        - vddwlcx-supply
> +        - vddwlmx-supply
> +        - vddrfa0p8-supply
> +        - vddrfa1p2-supply
> +        - vddrfa1p8-supply
> +        - vddpcie0p9-supply
> +        - vddpcie1p8-supply

Like we discussed before, shouldn't these supplies be optional as not
all modules need them?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

