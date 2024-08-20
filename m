Return-Path: <linux-wireless+bounces-11666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365995861E
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C701C23C00
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4918F2D6;
	Tue, 20 Aug 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDuasytX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D118E768;
	Tue, 20 Aug 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154653; cv=none; b=nIhnlNup9HMcs0fZ7ROyH8Btwj0ZlK85BDP4cMtLMgX44V0D5rWsGyuGzGrcslS9LpjbST0QPcLYvYbolhqhw1LtqwGHizg1Fes9TKUjzg95QJ1OolpiO5kxUcLfWUXPP2hcc+RMfTFvCu+Dg2oNqRxVqaCel05mmtTkR/JNYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154653; c=relaxed/simple;
	bh=vZys4aaILtjelGWZ4iPUGqMroiGwmWJuaZmIRsfRdKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXly58ciwzM7vFrPb1YBFHvNLSghXsuWG4f77qmhJgt+uUrKyiDXg0C0OWDQgPPEPS4wCoVb8yvJdKA3ccYhJ4jzdtLrrU1bcs+JIYDv4ze+Jfu9DVHvKu5aopX746yVK4mIgS3mTQbaFCxqRITR2BGcpXJGS86d7NbfNxACUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDuasytX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4E1C4AF0F;
	Tue, 20 Aug 2024 11:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724154653;
	bh=vZys4aaILtjelGWZ4iPUGqMroiGwmWJuaZmIRsfRdKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tDuasytXliXnP0VwI4s4qhq+Jaipe5KYPNhFTSrJVjHfAVzIKic+ycXcW9svs1PvX
	 n73R3ApO1uHqxEkTk7iuCZHnVXvB84AcTiY9+Jc06ZdqfWSI7tVawpA3Nzhgt5wg6g
	 np+0/NCVXt6Smh21ue/GOFWkxFcsvvj4lVtmZmlMmUBoFjSZxSaFEw0O/HZvnDrX7X
	 pbL2U/A2NwpNfh4xm1OUqz83D0PDDilwbDSa7OO+BpttbvsM1eN/sRH0W7zacOr8WF
	 L2asgEi5byI5ZxaPTGltvyUIQaPHCt6DwessrVMHtTZQrO9ye9RbPjSdsHtrwRWtnu
	 gZ6A3CBgDG90g==
Message-ID: <8d74380c-0090-4209-963e-e7dde57c4235@kernel.org>
Date: Tue, 20 Aug 2024 13:50:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: wireless: restore constraint for
 brcm,bcm4329-fmac compatible property
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
 brcm80211@lists.linux.dev, asahi@lists.linux.dev,
 Hector Martin <marcan@marcan.st>
References: <20240820101216.355012-1-arend.vanspriel@broadcom.com>
 <20240820101216.355012-2-arend.vanspriel@broadcom.com>
 <172415246911.849656.16484336903356408566.robh@kernel.org>
 <7a5e37f0-4830-43f8-84c9-62b6614efaca@broadcom.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <7a5e37f0-4830-43f8-84c9-62b6614efaca@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 13:43, Arend van Spriel wrote:
> On 8/20/2024 1:14 PM, Rob Herring (Arm) wrote:
>>
>> On Tue, 20 Aug 2024 12:12:15 +0200, Arend van Spriel wrote:
>>> When extending the bindings for Apple PCIe devices the compatible property
>>> specification was changed. However, it was changed such that for these
>>> devices it was no longer necessary to have "brcm,bcm4329-fmac" listed as
>>> string in the compatible list property as it was before that extension.
>>> This patch restores that constraint.
>>>
>>> Fixes: e2e37224e8b3 ("dt-bindings: net: bcm4329-fmac: Add Apple properties & chips")
>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>> ---
>>>   .../net/wireless/brcm,bcm4329-fmac.yaml       | 19 ++++++++++---------
>>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>> ./Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: [error] syntax error: expected <block end>, but found '-' (syntax)
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml: ignoring, error parsing file
>> ./Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: did not find expected key
>> Documentation/devicetree/bindings/mmc/mmc-controller.example.dtb: /example-0/mmc@1c12000/wifi@1: failed to match any schema with compatible: ['brcm,bcm4329-fmac']
>> make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dts'
>> Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml:48:5: did not find expected key
>> make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dts] Error 1
>> make[2]: *** Waiting for unfinished jobs....
>> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
>> make: *** [Makefile:224: __sub-make] Error 2
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240820101216.355012-2-arend.vanspriel@broadcom.com
>>
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
> 
> Thanks, Rob
> 
> I will have to setup my environment for that. Will take a while to get 
> it all working.

It's just two commands:
pip install
or pix install if you use newer Ubuntu (no magic here, just like every
other Python package)

and then `make dt_bindings_check`, optionally with arguments. There is
no environment needed, you can do all this in the same place you build
and test kernel changes.

Best regards,
Krzysztof


