Return-Path: <linux-wireless+bounces-11653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6779581F1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC021C20A63
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E818B468;
	Tue, 20 Aug 2024 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIOPiq+V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF418A95B;
	Tue, 20 Aug 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145477; cv=none; b=Z1hXmkUEBU7DfhpGeoVEuO78JKQ7zADxo7wkEFjtJa/lTxAIbIAo3JXWa2RNDNhenCk0mecj4kby++/RSFXSlfOrkCpVz/cHrgMNaSMHlqjrvUZ7LqyL5DRzVV7s6pAv+hY/TydDX3+YXSn1uswLnCnplDOwiAVnztHVuusQpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145477; c=relaxed/simple;
	bh=D1PblbAhDtG6zJFqDLsx5Mo/b+pVrfHqprGLRoQp7jQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gOdfveig0k7YcrEDez6Gu3h3jH1pd/zUS3UY06GC4GA9KnvG0LYK4meEx+qYvNs7SzDOFB5fSogP1fdY3EQQ8XbqJIPnCCFLlWunAaQVDXcDFj3e8editQc0uUqYKdfAwdVFtugnUi+mct7TEbN11YgKEe0E7sxg62xol5t5J5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIOPiq+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C558FC4AF0B;
	Tue, 20 Aug 2024 09:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724145476;
	bh=D1PblbAhDtG6zJFqDLsx5Mo/b+pVrfHqprGLRoQp7jQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=MIOPiq+VjVknGOfFscs8z9icMzZJT62JmZJS9BR75KMj4V2ds5+4ObHiuwPzMBTAB
	 NVK58WTPXrQ0/hyiK9+Lwq+JbDGW3mHkSvDN8pC4Jr9sZG7kC3uvk4Y7WX4u2TpPZO
	 DPzRGpj6ndUeBuBdeYmA4kdTJraf4PD5SN0BXqn8xqsnOonJppt3m6C4CgsKkcGaN2
	 ECVxXu9440DPvn3XJsJo0HOBRX2sZEDA8TOGfQ3VJeEGRs8emp26jOc3Rl++5q5K9z
	 /oFLSXGf/n0eSjLYacul4N4+JaNti5sPIgMdsyoTDlpo2wyZDcuzk02EjTm1nZ8o42
	 Hmz436P9x5kaQ==
From: Kalle Valo <kvalo@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Frank Li <Frank.Li@nxp.com>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  "open list:NETWORKING DRIVERS (WIRELESS)"
 <linux-wireless@vger.kernel.org>,  "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>,  "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>,  imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: net: wireless: convert
 marvel-8xxx.txt to yaml format
References: <20240816171203.143486-1-Frank.Li@nxp.com>
	<ZsPccHaCMRgbNk4L@google.com>
Date: Tue, 20 Aug 2024 12:17:51 +0300
In-Reply-To: <ZsPccHaCMRgbNk4L@google.com> (Brian Norris's message of "Mon, 19
	Aug 2024 16:59:44 -0700")
Message-ID: <87seuzwo1s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brian Norris <briannorris@chromium.org> writes:

> Hi Frank,
>
> On Fri, Aug 16, 2024 at 01:12:01PM -0400, Frank Li wrote:
>> Convert binding doc marvel-8xxx.txt to yaml format.
>> Additional change:
>> - Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
>> - Remove mmc related property in example.
>> - Add wakeup-source property.
>> - Remove vmmc-supply and mmc-pwrseq.
>> 
>> Fix below warning:
>> arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
>> failed to match any schema with compatible: ['marvell,sd8997']
>> 
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>> Change from v1 to v2
>> - Add Brian Norris <briannorris@chromium.org as maintainer
>> - Remove vmmc-supply and mmc-pwrseq
>> - Add wakeup-source
>> - rename to marvell,sd8787.yaml by using one compatible string, suggestted
>> by conor dooley at other binding doc convert review
>> ---
>>  .../bindings/net/wireless/marvell,sd8787.yaml | 93 +++++++++++++++++++
>>  .../bindings/net/wireless/marvell-8xxx.txt    | 70 --------------
>>  2 files changed, 93 insertions(+), 70 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
>> 
>> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>> new file mode 100644
>> index 0000000000000..c6647672b7b1e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>> @@ -0,0 +1,93 @@
>
>> +  marvell,caldata-txpwrlimit-5g-sub0:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Calibration data for sub-band 0 in the 5GHz band..
>
> You have an extra period in this line.
>
>> +  marvell,caldata-txpwrlimit-5g-sub1:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Calibration data for sub-band 1 in the 5GHz band..
>
> Same.
>
>> +    maxItems: 688
>> +
>> +  marvell,caldata-txpwrlimit-5g-sub2:
>> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>> +    description: Calibration data for sub-band 2 in the 5GHz band..
>
> Same.
>
> Otherwise, this looks good to me, so feel free to carry my:
>
> Acked-by: Brian Norris <briannorris@chromium.org>
>
> (Sometimes Kalle will make trivial fixes like this when applying. I'm
> not sure if that means you should send v3 anyway, or see if he'll apply
> this on his own soon enough.)

For wireless-next patches I can easily edit commit messages but not the
actual patch, so please send v3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

