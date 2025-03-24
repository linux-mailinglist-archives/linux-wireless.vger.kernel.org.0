Return-Path: <linux-wireless+bounces-20788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A6A6E71A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 00:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999C316EED6
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 23:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D181EB5E2;
	Mon, 24 Mar 2025 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOttCeAU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB018C930;
	Mon, 24 Mar 2025 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857517; cv=none; b=JCtPps9wJila+pQpzNyBal6TRHXEZFUmh/ezrQrOqEvhT6PbVMVePs7xm+cmUFHS+vxjZIlPms/qrIrWNZ9HkL11oI1fithm6ntHSLyLiJ5551D5pV+4r0/rKXquPEjbsWbUNGrR/vVdKIrHAqIH5umkTLhxthePG+0DFXZzxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857517; c=relaxed/simple;
	bh=OwYsfyuskTjApvW7yDAsLEh534saPHvQL2Nj5uhaC7o=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DAgujjjFn2Kah0A4d1GRtkDuliEj95dFnTKJN+xZKvBb4YumyL1qfqKyOyuncKRqhiuUOmgW590oCNybCy9sfLSt/ydA2njNVhQN5m978uvq99jFQgyuseKx+NTzR7vRh/z/+fSwBmsXAM4McDdXfLUXX3RgZvqgyrjgHTvv9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOttCeAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BCDC4CEDD;
	Mon, 24 Mar 2025 23:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742857515;
	bh=OwYsfyuskTjApvW7yDAsLEh534saPHvQL2Nj5uhaC7o=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=NOttCeAUxLlixkV9Vnff6ulrU6dN74p5cj4stKxcM6MH+LLMK2yVnEAQMLZGyivJ4
	 E6hR0TkLH/k5tNkFZ/iInBTuwzROybHTYO+pKeoDkRd1NPyD0ALGoxK4BBW7Fch2jR
	 pUXz3u0ChL8hZZFaXUfj+JIfazklTlrzHDrnrD9R9BGw5P2fabyft1jNh/f9hZkeQb
	 MGWmPklbOmY+hs0Oz78poCp91lYRvUugocTsDXD105Mt0d9DT4r44104DvKgiAUhWj
	 DUnTLXr4TqbwgltuSBy0D7iZhRm6aRCnw+em4SBuVL3v315K/6Ka0LDcr/tjzFj/E6
	 GuhQXK5Hi3KFQ==
Date: Mon, 24 Mar 2025 18:05:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Jakub Klama <jakub@conclusive.pl>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Wojciech Kloska <wojciech@conclusive.pl>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Ulf Axelsson <ulf.axelsson@nordicsemi.no>, linux-wireless@vger.kernel.org
To: Artur Rojek <artur@conclusive.pl>
In-Reply-To: <20250324211045.3508952-3-artur@conclusive.pl>
References: <20250324211045.3508952-1-artur@conclusive.pl>
 <20250324211045.3508952-3-artur@conclusive.pl>
Message-Id: <174285751372.1003267.5777705239972389695.robh@kernel.org>
Subject: Re: [RFC PATCH 2/2] dt-bindings: wireless: Document Nordic nRF70
 bindings


On Mon, 24 Mar 2025 22:10:45 +0100, Artur Rojek wrote:
> Add a documentation file to describe the Device Tree bindings for the
> Nordic Semiconductor nRF70 series wireless companion IC.
> 
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
>  .../bindings/net/wireless/nordic,nrf70.yaml   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml: properties:compatible: 'anyOf' conditional failed, one must be fixed:
	'req' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml: properties:compatible: Additional properties are not allowed ('req' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250324211045.3508952-3-artur@conclusive.pl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


