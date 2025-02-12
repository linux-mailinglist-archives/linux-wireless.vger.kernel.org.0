Return-Path: <linux-wireless+bounces-18866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69EA3321A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A574E3A95C0
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 22:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0AB2040B4;
	Wed, 12 Feb 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3uDUavh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34545204095;
	Wed, 12 Feb 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398135; cv=none; b=TA+/3l7JA+l/D2YHm8katm25KYS4tGyOTOq8rX23ROsPP3A+GZ1OgzqvmdHy/9jZunkQh85bwNlfgFHkgv+cvfrL1o5Ws9UcLmRfgvmClHdWL/1PM44nAs/z4awBsMS6dH7/uUN1OJr4WWFbUg4PkDpClKLHgdjD0tLXus5a4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398135; c=relaxed/simple;
	bh=RSxeycxN+OR2igWs7iCrFsgBzSuOib+ZW47/gosGsbo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=l5VtPGxfS4bqFGfcTONf/oAJ4BAsPis8Sod3438iboTYixdn+N+r/DTC1kWPIykTPoBN9LEUsRu5V/6nwlHseSR7hosgrVFNNSNumo1I70Z2PVhoy0HgGBeRlaDCRn8d3RtEOkj/VNf8fghrESlejxZfVCZNMswsZBMDjQtPRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3uDUavh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D87C4CEE5;
	Wed, 12 Feb 2025 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739398134;
	bh=RSxeycxN+OR2igWs7iCrFsgBzSuOib+ZW47/gosGsbo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=S3uDUavh3srVd/+ScWyYzIgrv9yfSjD3VWdiUs8F90WyBe+qeaVzl7rfrHgoMyJna
	 5O92+xsrNLpe8Wx74mhBcJRud9eVDTo0YFmFEk3RWeQroO9xJAnWW1X1GgvcQYHeDc
	 HpTA6edH7JXUog7PEVIKlfYfWRbVkXJR0GOFahCYDF8FksTcB+kh1HkuvX7BoeJPha
	 lntcn9Jr6Zsvj8tcwZKvZSWpgHDCaDHIcvwvqwnJxZj5OPg+BxwbdUrK9c5YcqPVgE
	 CgIAv9ML+/T+BA9G46HeWIU/vjVCmXh8IHjnpZBCDBE9yGB2T52Nf1ixzUnRR8Ct02
	 XkDycYYo+ykow==
Date: Wed, 12 Feb 2025 16:08:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 Ajay Singh <ajay.kathat@microchip.com>, Simon Horman <horms@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Marek Vasut <marex@denx.de>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Marcel Holtmann <marcel@holtmann.org>, Conor Dooley <conor+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
Message-Id: <173939808305.598743.2426492109317429179.robh@kernel.org>
Subject: Re: [PATCH 00/12] bluetooth: hci_wilc: add new bluetooth driver


On Wed, 12 Feb 2025 16:46:19 +0100, Alexis Lothoré wrote:
> Hello,
> 
> WILC3000 ([1]) is a combo chip exposing 802.11b/g/n and Bluetooth 5.
> Support for the wlan part has recently been integrated upstream ([2]) in
> the existing wilc1000 driver. This new series aims to bring support for
> the bluetooth side.
> 
> The WILC3000 chip is controlled through a SDIO or SPI bus for the wlan
> part (similarly to wilc1000), and uses standard HCI commands over a UART
> bus for the bluetooth operations. This work is based on the code
> available in the vendor kernel ([3]), in which bluetooth is managed
> directly in the wireless driver, and relies on user to trigger the
> hardware configuration (chardev manipulations + hciattach). The series
> brings a new dedicated bluetooth driver to support the bluetooth feature
> from the chip, without relying on the user to perform the device
> bringup. However, getting completely rid of the wlan driver dependency
> is not possible: it is still needed for early BT CPU configuration and
> BT firmware download, so the new driver still have a dependency of the
> wlan one, with an approach similar to the one used by the rsi driver.
> 
> - Patch 1 brings the new dt binding
> - Patch 2-9 prepares the wlan side, either by exposing the needed
>   functions to initialize BT, or by mitigating behavior which would
>   prevent BT and WLAN from runnning in parallel
> - Patch 10 brings the new bluetooth driver
> - Patch 11 updates the device tree description for sama5d27_wlsom1_ek
>   board (which I used to validate this series) to use the new driver
> - Patch 12 adds a new entry for this driver in the MAINTAINERS files
> 
> This series has been tested with WILC3000 both in SDIO mode (with the
> chip embedded on the sama5d27_wlsom1_ek) and SPI mode (custom wiring on
> an SPI on the same eval board, with a WILC3000-SD).
> 
> Since this works needs new code in both the existing wlan driver and the
> new driver, I have included both linux-wireless and bluetooth mailing
> lists, while keeping the entire series for clarity, but let me know if
> you want to proceed differently.
> 
> [1] https://www.microchip.com/en-us/product/atwilc3000
> [2] https://lore.kernel.org/linux-wireless/20241004114551.40236-1-marex@denx.de/
> [3] https://github.com/linux4microchip/linux/tree/linux-6.6-mchp/drivers/net/wireless/microchip/wilc1000
> 
> ---
> Alexis Lothoré (12):
>       dt-bindings: bluetooth: describe wilc 3000 bluetooth chip
>       wifi: wilc1000: add a read-modify-write API for registers accesses
>       wifi: wilc1000: add lock to prevent concurrent firmware startup
>       wifi: wilc1000: allow to use acquire/release bus in other parts of driver
>       wifi: wilc1000: do not depend on power save flag to wake up chip
>       wifi: wilc1000: remove timeout parameter from set_power_mgmt
>       wifi: wilc1000: reorganize makefile objs into sorted list
>       wifi: wilc1000: add basic functions to allow bluetooth bringup
>       wifi: wilc1000: disable firmware power save if bluetooth is in use
>       bluetooth: hci_wilc: add wilc hci driver
>       ARM: dts: at91-sama5d27_wlsom1: update bluetooth chip description
>       MAINTAINERS: add entry for new wilc3000 bluetooth driver
> 
>  .../net/bluetooth/microchip,wilc3000-bt.yaml       |  41 +++
>  MAINTAINERS                                        |   7 +
>  .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi   |   8 +
>  .../boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts |  10 -
>  drivers/bluetooth/Kconfig                          |  13 +
>  drivers/bluetooth/Makefile                         |   3 +-
>  drivers/bluetooth/hci_uart.h                       |   1 +
>  drivers/bluetooth/hci_wilc.c                       | 333 ++++++++++++++++++++
>  drivers/net/wireless/microchip/wilc1000/Kconfig    |   3 +
>  drivers/net/wireless/microchip/wilc1000/Makefile   |  11 +-
>  drivers/net/wireless/microchip/wilc1000/bt.c       | 345 +++++++++++++++++++++
>  drivers/net/wireless/microchip/wilc1000/cfg80211.c |   7 +-
>  drivers/net/wireless/microchip/wilc1000/hif.c      |   2 +-
>  drivers/net/wireless/microchip/wilc1000/hif.h      |   2 +-
>  drivers/net/wireless/microchip/wilc1000/netdev.c   |  14 +
>  drivers/net/wireless/microchip/wilc1000/netdev.h   |   5 +
>  drivers/net/wireless/microchip/wilc1000/sdio.c     | 101 ++++--
>  drivers/net/wireless/microchip/wilc1000/spi.c      |  43 +++
>  drivers/net/wireless/microchip/wilc1000/wlan.c     | 154 ++++-----
>  drivers/net/wireless/microchip/wilc1000/wlan.h     |  23 ++
>  include/net/wilc.h                                 |  19 ++
>  21 files changed, 996 insertions(+), 149 deletions(-)
> ---
> base-commit: 95f6f2d73dc40ab53a94756689ce5cfd2f23361a
> change-id: 20240828-wilc3000_bt-fa452f2a93ad
> 
> Best regards,
> --
> Alexis Lothoré, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for 20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com:

arch/arm/boot/dts/microchip/at91-sama5d3_eds.dtb: nand-controller: #address-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dtb: serial@200: Unevaluated properties are not allowed ('bluetooth@0' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#






