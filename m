Return-Path: <linux-wireless+bounces-11661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6198E958589
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3067B22C5B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0118E779;
	Tue, 20 Aug 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLXbdz5Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77518E76B;
	Tue, 20 Aug 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152473; cv=none; b=dkByTncKSeKYtchkLpcxhJpjp8qdDZd3TGVFd0PdZkoz4nWl8pByzGO/JHLqikqAgFq1R6on2fb6ava5zsx9vWkscOsbxIMNOH1ttHpgsTkEHKiG3r/jSWdgALTI0FnC5/KFgdCjevQ4YEhNxq4iGB6c9dGlRnUXWn4aXHMW5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152473; c=relaxed/simple;
	bh=hmU4IFbSNARZ/K1Exu/70jEBVVczxBk8iddFVrrAdn4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=b9RxOhCZSz3cOT7bWVFXRdUBx79YKxYpK53s75uKSW+drtOND9tkQzocVTgZzjSKzbZ0FLtswd1CVsEL3tI8XNTCA+zjpKjFJoRRevapFVyYYajF3xlwaRD1WFfnvOZ7/KnrjBLJlE5bfJOKPEIBTDUF1Tyndsti+V/Y1a7D8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLXbdz5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447CEC4AF0B;
	Tue, 20 Aug 2024 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724152471;
	bh=hmU4IFbSNARZ/K1Exu/70jEBVVczxBk8iddFVrrAdn4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WLXbdz5YecmGmIaSsROPk2y1ktThaAJTXThNS/RbdO9RIQ4jd2UpBKTSjFUb2VvKE
	 sMOLCTh2M5n3HVDJivMcOvzUYkXPAzls9DShdtm9koHKwv/xCoRni2B4xaSt0ye4Z+
	 +kn4fy1MCaXwDWOuo4y6viTvJ76ZRAa852klJH/nZjRpM+7KUErCYtwmn4AoxwMFQ/
	 9kgRDYNvBLd7PFpmCsMBfFDKXFfQXWZmxypPeDMnS3L4r1GB/LCDxEPAPF5M6jWj8J
	 NL9RlsABSneNzhZsq1VFa0aNZjrz0bi9dxSPNwtMEBl21oiKAOduP4z09G/WkvYNFx
	 FQpO+i5bFctUg==
Date: Tue, 20 Aug 2024 06:14:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
 brcm80211@lists.linux.dev, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
In-Reply-To: <20240820101216.355012-2-arend.vanspriel@broadcom.com>
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-2-arend.vanspriel@broadcom.com>
Message-Id: <172415246911.849656.16484336903356408566.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for
 brcm,bcm4329-fmac compatible property


On Tue, 20 Aug 2024 12:12:15 +0200, Arend van Spriel wrote:
> When extending the bindings for Apple PCIe devices the compatible property
> specification was changed. However, it was changed such that for these
> devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
> string in the compatible list property as it was before that extension.
> This patch restores that constraint.
> 
> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips")
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: [error] syntax error: expected <block end>, but found '-' (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: did not find expected key
Documentation/devicetree/bindings/mmc/mmc-controller.example.dtb: /example-0/mmc@1c12000/wifi@1: failed to match any schema with compatible: ['brcm,bcm4329-fmac']
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dts'
Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240820101216.355012-2-arend.vanspriel@broadcom.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


