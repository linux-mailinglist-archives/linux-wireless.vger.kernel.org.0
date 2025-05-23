Return-Path: <linux-wireless+bounces-23352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79F6AC1DBC
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 09:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EBC7B9B70
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6212040B3;
	Fri, 23 May 2025 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCEWWIyR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C9200BBC;
	Fri, 23 May 2025 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985698; cv=none; b=p1gqIAIs6lbxNhph6G00KB0pT7r1JsUeud5RpJTBVA17bKKc5U0H1sudBdLrsMWWdOYJJkT3XReCphfixQ3XB5nwFiue76N/21zG1TK3hsin1yMQwd8lb+T4+Tc2Qxb2PVx3vGnZGtlqpXsGq0cpP4tgYt9woUDkTOyhyZ00g1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985698; c=relaxed/simple;
	bh=EnQAKD8l/H9RmxSZrHWWWVsvsQ9y+wSNSH7iYmJpbco=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bAoMHGW47886M/leR5yLcbg0gyry9M12B8kFzKSUWzlSYNlqcr7QwZAh2XNGTN5Onyoeco15diGfEktBU0epmIB20Mujv+k/SK2WcTmHOh4gg9n886yLQUfl2dtjUDqzYDXcwBRMxMm6GYKMzEy49N2Pi2D9s3bx2DpNjRIQgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCEWWIyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900D5C4CEE9;
	Fri, 23 May 2025 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747985697;
	bh=EnQAKD8l/H9RmxSZrHWWWVsvsQ9y+wSNSH7iYmJpbco=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kCEWWIyRzlM9lR8MWsToN9kPatqBViQgFBudMpVrII1mcakeT30TAlOGghw/8tD9Q
	 wSLqukchbjNNdsjZuusj9FeFEqklCEscKUz0xgdzLUnr9JLilFaPh/GtqaiqjmaMlw
	 2qwe0pko2pG1sZVfa6OQ0Fw5qBr4/hwFr9iHJdYGOT8NKiiB8HACFlcJk2/xuEM+ZN
	 5/KVLbpE91OgmA+liadMCBzsw/MskaRHH1B++rLVO7NXdJ0tFgUu1Q1AHUJ8Qoqbw7
	 1ZSX56EavU//hYyX02FqxUxXedDDI2mGSt9UViS5MYbWXTQpj1VXjO/xq+BZ8MR5+M
	 oAtYcr8hMNSBA==
Date: Fri, 23 May 2025 02:34:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
 devicetree@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
 linux-wireless@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, nbd@ndb.name
To: Rosen Penev <rosenp@gmail.com>
In-Reply-To: <20250523063207.10040-4-rosenp@gmail.com>
References: <20250523063207.10040-1-rosenp@gmail.com>
 <20250523063207.10040-4-rosenp@gmail.com>
Message-Id: <174798569576.581215.14604917966107916722.robh@kernel.org>
Subject: Re: [PATCHv3 3/5] dt-bindings: net: wireless: ath9k: add WIFI
 bindings


On Thu, 22 May 2025 23:32:05 -0700, Rosen Penev wrote:
> These are for the wireless chips that come built in with various
> Atheros/QCA SoCs. dts wise, the difference between pcie and the wmac is
> 
> AHB > PCIE > WIFI
> AHB > WIFI
> 
> These will be used to replace the platform_device code with OF in the
> following patch.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/qca,ath9k.yaml      | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:90.13-41: Warning (reg_format): /example-2/ahb/wifi@180c0000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:86.11-18: Warning (ranges_format): /example-2/ahb:ranges: empty "ranges" property but its #address-cells (2) differs from /example-2 (1)
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:88.25-93.13: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000: Relying on default #address-cells value
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:88.25-93.13: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000: Relying on default #size-cells value
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: ahb (simple-bus): '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: ahb (simple-bus): '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: /example-2/ahb/wifi@180c0000: failed to match any schema with compatible: ['qca,ar9130-wifi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250523063207.10040-4-rosenp@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


