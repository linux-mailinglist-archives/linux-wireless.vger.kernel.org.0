Return-Path: <linux-wireless+bounces-26597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E9B3494F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 19:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE5B17E960
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505183019D2;
	Mon, 25 Aug 2025 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTiyQ5Q8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C64C83;
	Mon, 25 Aug 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144144; cv=none; b=JRnpOoxsKGvR6Fhw8TQApFoy8F4tOfLCwegey5z66++07QA3ZbbzYVb5Wec0AGLaLtgbAbd5nOQ+QP7StIaEpfWBdeA2FAh2rj6EvEp/CpY8B9tCUQ4HoOCpYwjTPnSM0QY+wBJUZuI3Hl7Ut89eJbUMPEER/rWqH33Eqhm+ftc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144144; c=relaxed/simple;
	bh=XzHy9DjHZm9PQIObMTotkItM6UM2hrpGtBbLyV4Q+ic=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bNG5IzIDIbRf0ndQ1f+zLhsH3neHRmf6SondTRv8n2h4HV093Ue5vAUk67ZbUOjY6ItVOV7LRmEfVAo2PDoqMYpZ+CMxLK1kHXkfHC8bpTvXB9cDKp8grJ6D+4mNMBDxKFdAQBxzrLBMdMDjyrgCJlLv4zyg2/EJusEA3uhytKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTiyQ5Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD9DC4CEED;
	Mon, 25 Aug 2025 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144143;
	bh=XzHy9DjHZm9PQIObMTotkItM6UM2hrpGtBbLyV4Q+ic=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HTiyQ5Q8FSr42P9/TgICM3lFboZo2dAHuFQPR5/apAtVpoV/kN+5rDnlfgtZa11BU
	 20fNb+m/QtTXkUpT6v4nqBRcMP8laWGcq3UdZveORHjcFsLKhmmn/d75ingCXsWfN4
	 DbmBWHCjm5c2LqXEYf5UzK/MpAcE65GN3N4b627+TX2EloPzZOt9hOpTTimf1xWY8F
	 4wCy2yoygVRzcbr+QQwMGddiDO2Ukcip68MG7acBsc9fkQAPqSoRfn7Y056R7SggKQ
	 AXeUOjn3TIh7mBr/rBUK+dxnvxj9wh1gVZhEIvRaL8w51ofQoCdaKqost/E7UeVEy7
	 5cA0sXWvJPQbw==
Date: Mon, 25 Aug 2025 12:49:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-mips@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 linux-wireless@vger.kernel.org
To: Rosen Penev <rosenp@gmail.com>
In-Reply-To: <20250825044812.1575524-2-rosenp@gmail.com>
References: <20250825044812.1575524-1-rosenp@gmail.com>
 <20250825044812.1575524-2-rosenp@gmail.com>
Message-Id: <175614397908.4140594.10465132869450405336.robh@kernel.org>
Subject: Re: [PATCHv3 1/3] dt-bindings: net: wireless: ath9k: add led
 bindings


On Sun, 24 Aug 2025 21:48:10 -0700, Rosen Penev wrote:
> The ath9k driver has various pin GPIO numbers for different chipsets
> which are not always correct for every device.
> 
> Add bindings to specify the correct number and if it should be
> active-low.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:92.15-25: Warning (reg_format): /example-2/ahb/wifi@180c0000/led:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.17-94.15: Warning (unit_address_vs_reg): /example-2/ahb/wifi@180c0000/led: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000/led: Relying on default #address-cells value
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000/led: Relying on default #size-cells value
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250825044812.1575524-2-rosenp@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


