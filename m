Return-Path: <linux-wireless+bounces-25003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52587AFD9E3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 23:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BAD16E992
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151712417E0;
	Tue,  8 Jul 2025 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWHMAc3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AC1DE4CE;
	Tue,  8 Jul 2025 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010136; cv=none; b=VXktC0n8/XJnyvxkA4MEDiPVf9T+gV1psPVYETsq6Zkzms1IpCC7pt8TvfXdMlE9meKAXvXoFgXrjePqW6XgnzbKHhx/wJRyztLwymsmE6q0+nisi1jkwQONY6Qp5HaEVrwGCTIVJb5DzH6ELTqh78cm3Wyp1W0OC7CPVovw4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010136; c=relaxed/simple;
	bh=/FVYZTlnzmURxTAnDhSQXnN1fi5/lPABhioS/jIPt2g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=bsQLVs0S8ZuxQq7KMoeusFlXCL2z4XPfe9eh41K+vy3Azvx0VE8fJ8/3mPNqfgzQT6j7mqlkt4OKRlE2WWSNwp40Gner/T2FatYG8xmn4CqIeNhcoHI2W9IEURxjyvuwWFvro3IqY7AuOtF8WkJZ1aQYKj+GFf0G45LxvOZ2JFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWHMAc3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396BFC4CEED;
	Tue,  8 Jul 2025 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752010135;
	bh=/FVYZTlnzmURxTAnDhSQXnN1fi5/lPABhioS/jIPt2g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RWHMAc3TJrBaVRWru5ozRY2k4hVQ2tLqRowlKtIBjXEDfJae5jLn0kKMpcdn5Roql
	 uPKVv1iXpSqCuSOuUCl594+js6ZeZcykvFfgbT+De0MqFLOgd7YvTT5DkjXjfIlYGB
	 9Z8ela6qK+E86ZoGNdsQQwYnBPtnp4N6enoEozYzD54u/yLl8QwpEC7wZJoS7UaUys
	 WSkcCi9ZMxlsVHYtxW8UD2e8a++3/7NhIW9MltZCWUulZk7EoxK8u+Ac8Wd+WYTOA5
	 ewRDNe1wXqUnOur3EjV3lqbxHvfTdvTjWjF1EZa2F5+v82jozl4lWu4O367R8m3QNb
	 xCW//ZHBJsu1A==
Date: Tue, 08 Jul 2025 16:28:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Stanislaw Gruszka <stf_xl@wp.pl>, linux-mips@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>, devicetree@vger.kernel.org
To: Rosen Penev <rosenp@gmail.com>
In-Reply-To: <20250708201745.5900-8-rosenp@gmail.com>
References: <20250708201745.5900-1-rosenp@gmail.com>
 <20250708201745.5900-8-rosenp@gmail.com>
Message-Id: <175201013411.1121693.17824456704959772294.robh@kernel.org>
Subject: Re: [PATCHv2 wireless-next 7/7] dt-bindings: net: wireless:
 rt2800: add


On Tue, 08 Jul 2025 13:17:45 -0700, Rosen Penev wrote:
> Add device-tree bindings for the RT2800 SOC wifi device found in older
> Ralink/Mediatek devices.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/ralink,rt2800.yaml  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/wireless/ralink,rt2800.example.dtb: /example-0/wifi@110180000: failed to match any schema with compatible: ['ralink,rt2880-wifi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250708201745.5900-8-rosenp@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


