Return-Path: <linux-wireless+bounces-18910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3176BA33B22
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 10:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFD51885050
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 09:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A4820CCC4;
	Thu, 13 Feb 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sginmXz6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54B1E376E;
	Thu, 13 Feb 2025 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438734; cv=none; b=Gxhyh91fdfKRvQog98G8xW4e2PzWV/+ZBbWKxDUq2SLXYLBIVV119wHUUFifq+14JO8ZR+gIGox/dICxdgKcNOs7cfhKHym9TAJMBbd9nIjqBYBs4rvlO+nJIV5jqP09IbfsDTH1jxLZ3Jt8WK5xjWtt/KkgqJ+GFKlvx+ILOGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438734; c=relaxed/simple;
	bh=38I1hCRodY+InrLjRVaigHjIIKw+PjXL6lLJvQekN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIUrsHl43Ds1EYPoqtlGg/pQNCI6O1GahUGG6xBFPhMwODjHWqkzjOz3FsSVzlyEeFkPxam+ttFQe37myuFRyoD0BUP0tLXwNtoo9GxNyWyzNciT/PjPohm/X5HrwSfeW1XTNTydGbA7nEnKVZ3adPTr7QAPpcQPoi0jwJaGDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sginmXz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259A1C4CED1;
	Thu, 13 Feb 2025 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739438733;
	bh=38I1hCRodY+InrLjRVaigHjIIKw+PjXL6lLJvQekN7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sginmXz6gdKXf7jVIfQ0FNV/ngeUfT/8xmJIzEGm4eWEnBbttHIEwzjevmFvIfpRN
	 Pd+aVA8YKEsxtvkAEIsmRuXcI2XmrfQ9mkiVyqYNu42bQ6Xx+6A33CVQB6BzeWgn36
	 JcAoSYUfAKjtHSWiXjyAzNibfZuwngivq41ju803wH/zi5OpIvQWu0LlpC6Y59ExR7
	 GremGc+JcHlVjDURRnp3PR3kWlKPDxYtxCg6+gLJHhbQ4Y3teq3AcMEyaexQ+uvsPm
	 QSdRe6v/Z6sOkkYI9K8GkLr08MYctWhZx0Cnfzjq508crSSSRD0gcwwL77xFfdwkkL
	 RAX0Sakwu6FVg==
Date: Thu, 13 Feb 2025 10:25:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Marek Vasut <marex@denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] dt-bindings: bluetooth: describe wilc 3000
 bluetooth chip
Message-ID: <20250213-chamois-of-unexpected-glory-dd3eab@krzk-bin>
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
 <20250212-wilc3000_bt-v1-1-9609b784874e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250212-wilc3000_bt-v1-1-9609b784874e@bootlin.com>

On Wed, Feb 12, 2025 at 04:46:20PM +0100, Alexis Lothor=C3=A9 wrote:
> WILC3000 is a combo chip providing 802.11b/g/n and Bluetooth 5. The wlan
> part is exposed either through SDIO or SPI interface, and the bluetooth
> part is exposed through uart. The notable peculiarity of this chip is
> that the bluetooth part is not fully autonomous: its firmware is not
> loaded through UART interface but through SDIO/SPI interface, so the
> bluetooth description needs a reference to the wlan part to get access
> to the corresponding bus.
>=20
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> ---
>  .../net/bluetooth/microchip,wilc3000-bt.yaml       | 41 ++++++++++++++++=
++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/microchip,wi=
lc3000-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/microchip,=
wilc3000-bt.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..2a83ca3ad90b26fd619b574bc=
343bee9654a1e43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/microchip,wilc3000-=
bt.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/microchip,wilc3000-bt.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip Bluetooth chips
> +
> +description:
> +  This binding describes UART-attached Microchip bluetooth chips. These
> +  chips are dual-radio chips supporting WiFi and Bluetooth. The bluetooth
> +  side works with standard HCI commands over 4-wires UART (with flow
> +  control)
> +
> +maintainers:
> +  - Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,wilc3000-bt
> +
> +  wlan:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the wlan part of the combo chip

No resources here and judging by the driver everything is part of wifi.
Either you wrote it to match driver or indeed hardware is like that. In
the first case, why this cannot be part of WiFi with phandle to serial
bus? In the second case, this needs to be proper hardware description.

Best regards,
Krzysztof


