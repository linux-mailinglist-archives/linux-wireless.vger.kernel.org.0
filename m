Return-Path: <linux-wireless+bounces-11380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B695D950E38
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 22:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249E0B20FDB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 20:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435CE1A7049;
	Tue, 13 Aug 2024 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzFBZ6Yb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A244C61;
	Tue, 13 Aug 2024 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582776; cv=none; b=qPQEGzSMg+q3WRBLsN5uJJEDwST63KnoqE6Xb8zA+2TPPh8g/h3SMB9CBSeCoWj3SMuud8fwarqqimFluKPhkKCL2F5FrMYMKJvEXvju1eUDVnHkS38D7UdmQPJ82GzpLyPazjO3WtFVC3tzjhqpsbxRv1r25+B7kqiMxbaEglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582776; c=relaxed/simple;
	bh=n9dg36LXmN2upFJapMn9PpdzfL1juCkf2K9+76G+g80=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qTRqK3PRqAkFdFB5vMQOB/3P9iDCB1A0vSa9JNEdjKrAIIQs00Sn/oBA45ILrfWzFBfO4HU6VKuXZA9ygP3oDJ8xMTGa/Lv+1WCvvNKrUzVywuFJTFxZaIjUxr5Xi8FQFaxjEQOm/fHEqf2mFFaLOAqXL/EtFvoUttK0sdtd1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzFBZ6Yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CD4C32782;
	Tue, 13 Aug 2024 20:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723582775;
	bh=n9dg36LXmN2upFJapMn9PpdzfL1juCkf2K9+76G+g80=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NzFBZ6YbcMhvmgf7XIZ2DzmarlbrWhFmaDDbK97NoCOsjcPVuoabA2tAGqCPSNXyr
	 RYbEj6H/qTw36+dVpoEkPVD82k/KRXLkfMSUEsZBBYwAWgyGCBRsIPS43oPRw++9l8
	 kcYPGTN/HaOsDM164QtRaHiyZr7VSez2LjyjHiXxa7loxO2maFhTGSzb4QxVNGRwRR
	 Tlk/tIUXJ0FRLiM/l93r/cZtQo6iJdOEd94Ys/klshVHxgLOQkgF0i0mWS8TTfcuNY
	 dLd7sB42vcETMjCWuQO3/vF0e2lITU8fLY/1QgD+t4KxqGTybDOvo0adFSSRrdT84d
	 WJIPrhQYf2zVg==
Date: Tue, 13 Aug 2024 14:59:33 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, Kalle Valo <kvalo@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240813190306.154943-1-brgl@bgdev.pl>
References: <20240813190306.154943-1-brgl@bgdev.pl>
Message-Id: <172358277338.2007176.5717215982820920385.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: ath11k: document the inputs of the
 ath11k on WCN6855


On Tue, 13 Aug 2024 21:03:05 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Describe the inputs from the PMU of the ath11k module on WCN6855.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../net/wireless/qcom,ath11k-pci.yaml         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfacmn-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddaon-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddwlcx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddwlmx-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfa0p8-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfa1p2-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddrfa1p8-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddpcie0p9-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.example.dtb: wifi@0: 'vddpcie1p8-supply' is a required property
	from schema $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240813190306.154943-1-brgl@bgdev.pl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


