Return-Path: <linux-wireless+bounces-14356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62259ABEFB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA51F24C0E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960B14B07E;
	Wed, 23 Oct 2024 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+5xXC0D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0114A4E9;
	Wed, 23 Oct 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665513; cv=none; b=rm64pT5KLwWfmp8QYo0+/tf9Jwst6gIxwDU3CucXage6YSb9uf0E4Cz11DugC4yq/6gZlAyA/84734WIoYfFOPj0O0ejQqNs11VgLpk5jWfju6NxJV847It4sD5CF1Lf1VTXPRlXaSlhjTgFzE6gN+4dmotJyaT3++v5hji4vro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665513; c=relaxed/simple;
	bh=GcLjJLl4bdrbNEueEEx5BAkDjYYGI3kimT6+iC9naD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSFw297csPaDYOx7XpXyL5ucWKRTCOJJOY0QlbnBZChvfoeAcbGsomC7ya4o3c26+Wt2qwOASHWWiHqNgQSv9Rmr4B4Tx5PzeibTGM7HCl/AF/SJxZKjB3euFizbQnHdKlsLKnuBWK9NklaX/IBj6JccZtZM5sb3AR3+13JQk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+5xXC0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F10C4CEC6;
	Wed, 23 Oct 2024 06:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729665512;
	bh=GcLjJLl4bdrbNEueEEx5BAkDjYYGI3kimT6+iC9naD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F+5xXC0DTsSiKe5Qyyvp+1SHkcKEUk837rs9yH5REGtFZlLj0CtWrcVXXPD/QPxZZ
	 tb3Vogy29cEh82hPzaFouH+eUxzFn34avQkqIKf5bAnQi9JGSqt1PFTNFZ55QoCWmt
	 x49ELNvGETUxpKxO9ZXZ4IbIn8GsO+REVVDwbf5GYAytQdvIR7uU8POfaqSUsZfM1C
	 NH8QUr3XmU4ODcBQtax3eSWVrrF4DEF/ZFgRFb57i1zOzxoTPxzasic7BSj2smWGkF
	 kFFqgmMNooGALHHUuMjed4mJvWE0alZ9xAmWuG6MWGhSERlQnuZInbYNNbt0NHFXSx
	 miFuetex0tGLQ==
Message-ID: <b42da7f0-2034-467b-ab17-fb13ef7800c4@kernel.org>
Date: Wed, 23 Oct 2024 08:38:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] dt-bindings: net: wireless: ath12k: describe WSI
 property for QCN9274
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
 <20241023060352.605019-3-quic_rajkbhag@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241023060352.605019-3-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2024 08:03, Raj Kumar Bhagat wrote:
> QCN9274 device has WSI support. WSI stands for WLAN Serial Interface.
> It is used for the exchange of specific control information across
> radios based on the doorbell mechanism. This WSI connection is
> essential to exchange control information among these devices
> 
> Hence, describe WSI interface supported in QCN9274 with the following
> properties:
> 
>  - qcom,wsi-group-id: It represents the identifier assigned to the WSI
>    connection. All the ath12k devices connected to same WSI connection
>    have the same wsi-group-id.
> 
>  - qcom,wsi-index: It represents the identifier assigned to ath12k
>    device in the order of the WSI connection.
> 
>  - qcom,wsi-num-devices: Number of devices connected through WSI in
>    the same group ID.

You should have separate binding.

> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>  .../bindings/net/wireless/qcom,ath12k.yaml    | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> index ecf38af747f7..6c8f97865075 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
> @@ -19,6 +19,7 @@ properties:
>    compatible:
>      enum:
>        - pci17cb,1107  # WCN7850
> +      - pci17cb,1109  # QCN9274
>  
>    reg:
>      maxItems: 1
> @@ -50,6 +51,41 @@ properties:
>    vddpcie1p8-supply:
>      description: VDD_PCIE_1P8 supply regulator handle
>  
> +  wsi:
> +    type: object
> +    description:
> +      The ath12k devices (QCN9274) feature WSI support. WSI stands for
> +      WLAN Serial Interface. It is used for the exchange of specific
> +      control information across radios based on the doorbell mechanism.
> +      This WSI connection is essential to exchange control information
> +      among these devices.
> +
> +    properties:
> +      qcom,wsi-group-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          It represents the identifier assigned to the WSI connection. All
> +          the ath12k devices connected to same WSI connection have the
> +          same wsi-group-id.

Why it cannot be implied by compatible?

> +
> +      qcom,wsi-index:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          It represents the identifier assigned to ath12k device in the
> +          order of the WSI connection.

No, we do not have indices in DTS.

> +
> +      qcom,wsi-num-devices:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Number of devices connected through WSI in the same group ID.

Wait, why? Number of devices is visible from DTS. You are missing some
diagram showing this but it looks like you stuff multiple nodes into one
node.



> +
> +    required:
> +      - qcom,wsi-group-id
> +      - qcom,wsi-index
> +      - qcom,wsi-num-devices
> +
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -108,3 +144,28 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            wifi@0 {
> +                compatible = "pci17cb,1109";
> +                reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +                wsi {
> +                    qcom,wsi-group-id = <0>;
> +                    qcom,wsi-index = <0>;
> +                    qcom,wsi-num-devices = <3>;

So what are the other 2 devices? Where are they documented?

Best regards,
Krzysztof


