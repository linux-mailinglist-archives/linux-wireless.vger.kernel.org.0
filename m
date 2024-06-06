Return-Path: <linux-wireless+bounces-8613-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1858FE7CD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 15:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DF91F24D87
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 13:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEEF195FD8;
	Thu,  6 Jun 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olnGGMhd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7F2A1C2;
	Thu,  6 Jun 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680651; cv=none; b=XmsJf7SGvIlEtnk7zUaxRVeNf8ittc/uSJOcHywFzZMFYmT5OhK5Cn9L8VViFIYDAAXweTvyubNNf9Y/euicDmT8KttN1CrSJw4zp7zckPG4w7HdmbLtecQU2zN4Rw95uD4bWpE023XEdS5DtQETOz0zo/f73bFgL4KPhF8AJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680651; c=relaxed/simple;
	bh=Y6vvUZaqqNzDBcZyJb8uANrd/RPyO8bmsrI9Fy1N1Yk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R4zm549nCyL8PyqoMqoWmP0wX0e24e05/pd8XrdR5vvOuxcaS5GZaKphttRdQuOS/wrlDPvu1IOPTo7Qday24jDP8/cUHMLB3+5uQXs13kN8pIwmwTtso8lUPuK1l4dcXcmy87/w+qqZX0UJOaFP4Esq1Dx3GjOGR82jw/L343c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olnGGMhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5570C2BD10;
	Thu,  6 Jun 2024 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717680651;
	bh=Y6vvUZaqqNzDBcZyJb8uANrd/RPyO8bmsrI9Fy1N1Yk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=olnGGMhdtaecQNsV+bM/3zqTVm/RI0w4RRa9vWACB38Wf0uBEOySr6sdZhR8A9cj7
	 yn8cvLmk5kv2p75y9fLzVWJ/vXuSkXyq13NacoZehA7k/kRqH/S2FXD2W5V9XBK2zI
	 wlV/A0d3b5IiNLGD+vDOTKaq6oNRq6ZFgCPxgV48XlK9URr7ahXL/2plk3xiqsVlGQ
	 UBna/1PWchiqmOGgCkgELhFUs4TcihpzFBYACSfwQBoll0gaRt4abdXUNtkiHBZHOa
	 SPOLYbINwGLq1O0bJv0oqR4AHFDiY52YaK2cKdtVt3jo24KuCWOa1N+OfPkMll4EjR
	 GXpyN+IWu0hpg==
From: Kalle Valo <kvalo@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "David S . Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Jeff Johnson
 <jjohnson@kernel.org>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  devicetree@vger.kernel.org,
  ath11k@lists.infradead.org,  linux-kernel@vger.kernel.org,
  ath12k@lists.infradead.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: net: wireless: qcom,ath11k:
 describe the ath11k on QCA6390
References: <20240605122106.23818-1-brgl@bgdev.pl>
	<20240605122106.23818-2-brgl@bgdev.pl>
Date: Thu, 06 Jun 2024 16:30:46 +0300
In-Reply-To: <20240605122106.23818-2-brgl@bgdev.pl> (Bartosz Golaszewski's
	message of "Wed, 5 Jun 2024 14:21:04 +0200")
Message-ID: <87h6e6qjuh.fsf@kernel.org>
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
> Add a PCI compatible for the ATH11K module on QCA6390 and describe the
> power inputs from the PMU that it consumes.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[...]

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: pci17cb,1101
> +    then:
> +      required:
> +        - vddrfacmn-supply
> +        - vddaon-supply
> +        - vddwlcx-supply
> +        - vddwlmx-supply
> +        - vddrfa0p8-supply
> +        - vddrfa1p2-supply
> +        - vddrfa1p7-supply
> +        - vddpcie0p9-supply
> +        - vddpcie1p8-supply

Not sure if we discussed this before, but based on this I understand
that there can't be an DT entry for device pci17cb,1101 without all the
supply properties? But there are QCA6390 devices with PCI id 17cb:1101
which do not need these supplies and already work. For example, my Dell
XPS 13 x86 laptop is one. Or anyone who manually installs QCA6390 board
to their PCI slot and some of them might want to use DT, for example
setting qcom,ath11k-calibration-variant.

This is not a blocker for me, just making sure that we are not breaking
any existing setups.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

