Return-Path: <linux-wireless+bounces-26759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76F9B39EFC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 15:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A44170D39
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3786F310628;
	Thu, 28 Aug 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQFcZuAe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777930F7E6;
	Thu, 28 Aug 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387826; cv=none; b=hInv6nxwnk129HZ0YbwyAq5wIZUmo1l9DLwArf5ApR3uhqLo/Ofgu4EFZhaZY+bGunv2HotPVhgrsXIi7X09lCya0aIeBjw5YXlHmP2//pm1KGVs6uh00Xa+GIBnSLtU7Wf6WRTz7yO3Oa+z/8wOhvLgDF0WN4jgxB7MiNIaOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387826; c=relaxed/simple;
	bh=PxEep1c4CF+Tc8cos7oMoyl+CrwSHJTT/SjzKqYUkYc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JQdXEEPujnknPa2o5rkc8S0gsY790bQ7BmuPUKuw6Q9Zxd+jFZzpENB8a6pIHYjGfQH6F1eVDdWP8AZvo0PnQhgreoKBEz74XRWdA9h+rTNqCIcvf0d1U+ssxYeXaIp51X+YgvPBbH+1gOeUxl6R9bDXEK/ZV41aWNVIJjMy97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQFcZuAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C626C4CEEB;
	Thu, 28 Aug 2025 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756387825;
	bh=PxEep1c4CF+Tc8cos7oMoyl+CrwSHJTT/SjzKqYUkYc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=bQFcZuAeqFrlrhjvEdn38U+z5iKQHrIPvWn727CQWJGOp5bP/+wwZx4SMQ3v0K2TT
	 hq8SmBp4eJAObgotbKYBNthTJayUsahN+92YFuWfLQwaq5Qo5b/EB1V0R0O1CjFAt7
	 Vq+bNLtitkBMUiBmboQWB+R/aBlfp3SY3EP9t+EBRA3eARhHjj88BdilEpUvaOgf8Z
	 a45QlNOPl2PZSAsgz1sCi2OKeXUKpmNRf0shxAypHmc/MVN1KK4BoeIvt38JL7UZhx
	 5Qlss/DhKrxNtSXlJk5XHZLFl4Cx5T+HfPWF+FRkdqKTjkA6svfHFLaW5vFFt0ySvA
	 k6W1uCuSXUmmA==
Date: Thu, 28 Aug 2025 08:30:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-mips@vger.kernel.org, linux-wireless@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Rosen Penev <rosenp@gmail.com>
In-Reply-To: <20250827005658.3464-2-rosenp@gmail.com>
References: <20250827005658.3464-1-rosenp@gmail.com>
 <20250827005658.3464-2-rosenp@gmail.com>
Message-Id: <175638709817.1370637.10754263567298002001.robh@kernel.org>
Subject: Re: [PATCHv4 1/3] dt-bindings: net: wireless: ath9k: add led
 bindings


On Tue, 26 Aug 2025 17:56:56 -0700, Rosen Penev wrote:
> The ath9k driver has various pin GPIO numbers for different chipsets
> which are not always correct for every device.
> 
> Add bindings to specify the correct number and if it should be
> active-high.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/qca,ath9k.yaml        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250827005658.3464-2-rosenp@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


