Return-Path: <linux-wireless+bounces-24859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F43AFA82E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 00:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA73B8C8E
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8874A1EF36B;
	Sun,  6 Jul 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaIqaj+b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C755846F;
	Sun,  6 Jul 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751840989; cv=none; b=HYr87vCEgaDHM7IhQv0eyxT0GRRY9Ncxfmh56YURSAS42sSSQQ3/SnVUqGQH1veZ497AIA6O06C0+MR74ypw5Sg38z785orOnyPPtp9ETlzg/imYGeyAtmtfb1G/H/TH700ZHvnpj9kdnjd2ROB56R/XzVDH5GWZGlrbU5dZA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751840989; c=relaxed/simple;
	bh=+FqcxieyCSl/BmyJUx6uOpbHQwdGTCBbRvnIJVsyPnQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Lh+QP1I4C6Skgtuw5c4mDZCit3r5HQuM1jEnHR2udsQ21w/oACqJKPYpi9ucFqcuvhm6lAqfDMSGEujRMtEPxDnnc1eA8Ul0opZaRwhqmKdTwAfXUalKGLL/PtZftCxmDhn0U2b8w6zeHyUlviYzgjkHAteElmYxUHQlD8Cw3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaIqaj+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD28C4CEED;
	Sun,  6 Jul 2025 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751840988;
	bh=+FqcxieyCSl/BmyJUx6uOpbHQwdGTCBbRvnIJVsyPnQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=UaIqaj+bE2PNvlzxHFsU8bKx/TvQ3nxBydLq7fyxyT/z8TiiGRP9154ikYh0K54sb
	 Z4EZ6WP+xlLWwTRPFvI279+Mu0sNBBWRDyf93thd0x4XgRbRAi9/899cayp1axI3Qq
	 EX4yMhpZd/Sy8d7UosGDsR4TuLoxLRVpwwKSuDeFL1+akM2+E1ByWZ4LcnDzOzltDM
	 hTeuVRd+gUQpuOtJ8lda/i58I8WztFNzGk0pcu9nmY2i4NZ116tt+L4mOTB4wA4T13
	 B1BO2f0YH9Xirjm5Vwyc9JwduiRJwc5yaCwXeqfw6fTuID9y6HlDM1XEm5tFvl3eg0
	 U+xUMsY5ribCA==
Date: Sun, 06 Jul 2025 17:29:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mips@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, ansuelsmth@gmail.com, 
 Conor Dooley <conor+dt@kernel.org>, Stanislaw Gruszka <stf_xl@wp.pl>, 
 linux-mediatek@lists.infradead.org, 
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, yangshiji66@qq.com
To: Rosen Penev <rosenp@gmail.com>
In-Reply-To: <20250706214111.45687-6-rosenp@gmail.com>
References: <20250706214111.45687-1-rosenp@gmail.com>
 <20250706214111.45687-6-rosenp@gmail.com>
Message-Id: <175184098772.672740.2328928098872646704.robh@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: net: wireless: rt2800: add


On Sun, 06 Jul 2025 14:41:10 -0700, Rosen Penev wrote:
> Add device-tree bindings for the RT2800 SOC wifi device found in older
> Ralink/Mediatek devices.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/ralink,rt2800.yaml  | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml:43:5: [warning] wrong indentation: expected 2 but found 4 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml: ignoring, error in schema: examples
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml: examples: 'wifi@110180000 { compatible = "ralink,rt2880-wifi"; reg = <0x10180000 0x40000>; clocks = <&sysc 16>; interrupt-parent = <&cpuintc>; interrupts = <6>; };' is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml: examples: 'wifi@110180000 { compatible = "ralink,rt2880-wifi"; reg = <0x10180000 0x40000>; clocks = <&sysc 16>; interrupt-parent = <&cpuintc>; interrupts = <6>; };' is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml: properties:interrupt-parent: False schema does not allow {'maxItems': 1}
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
Error: Documentation/devicetree/bindings/net/wireless/ralink,rt2800.example.dts:19.5-6 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/net/wireless/ralink,rt2800.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250706214111.45687-6-rosenp@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


