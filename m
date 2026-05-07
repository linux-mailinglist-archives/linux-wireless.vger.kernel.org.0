Return-Path: <linux-wireless+bounces-36095-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PivHjkF/WnkWgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36095-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:33:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B964EF5A0
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 23:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B291230B8A3A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A60346760;
	Thu,  7 May 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP+tRaG2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1530EF88;
	Thu,  7 May 2026 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189428; cv=none; b=NuOvzp7frk3GgNeRdJNT8Xq6LkUeynhIh0hFKAckeXTdCHEmfs2fwq40KCuN5y5WMziK5AIoSjjgw5IqkAS2Oc7F1ZE1eRcMulYOPhmiP+jv8cQ8JX8LYG5OZ3EVWABcPISvFHWx/BDM+XbhyKByZzGt7oEaXFx0jhWTuLCNCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189428; c=relaxed/simple;
	bh=7E4rp+S4dqE0OVdstaoROQZLQNR9BomvZCyTiVcToKw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tD8iW099RBtNn81zRqNKVobqbtKCfUIxFyljkOWb3sfYMPgeD3WyyHgxY7othUJsIcCJzuRyd/njvBobxn7uMUytAy2pPk9yLtsKF9453iUXFsgj9QAf8IMuiEMmxwadWZv/5IU7Fu3YZkB/zWgolamdfClht7ALzLhJM4kbhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP+tRaG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD30C2BCB2;
	Thu,  7 May 2026 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778189427;
	bh=7E4rp+S4dqE0OVdstaoROQZLQNR9BomvZCyTiVcToKw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JP+tRaG2NL8qdE5D6PVSpQ5I6vDQosXt9S2m2W0CXsjlSr61fgsBw3lRkOY6nwgdb
	 lAhuVEpOL9n+h7bqzbfWCW0GUj4vReohE2r1IoVRn/vZvx6lgxIV/+hd8+HfKTujre
	 hLmsHYSk0vbcj2jqokpp8rUQ2w7UZprVGEN4ONUcJBIAjb+pWB4efRRM93IjwNMS8D
	 8SeYJgiqBdZIF4vbGYROv1EahDoxf1wJlCJUlA6LMxJoh52W6DTcjLuv4QmDl2H7xo
	 IfHOwegNi9DrpP8JSPFkQx44XYkneIdfHWzf5WRgH+GudQdILoxHaNytMrBgR00J+D
	 4i4mqR6bL8tow==
Date: Thu, 07 May 2026 16:30:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
 Bjorn Andersson <andersson@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Jeff Johnson <jjohnson@kernel.org>, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-usb@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 ath11k@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-wireless@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
 netdev@vger.kernel.org, ath10k@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20260507201749.2605365-1-robh@kernel.org>
References: <20260507201749.2605365-1-robh@kernel.org>
Message-Id: <177818942584.2803269.2192622854542354589.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: Fix phandle-array constraints, again
X-Rspamd-Queue-Id: 20B964EF5A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36095-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,renesas,netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Action: no action


On Thu, 07 May 2026 15:16:00 -0500, Rob Herring (Arm) wrote:
> The unfortunately named 'phandle-array' property type is really a matrix
> with phandle and fixed arg cells entries. A matrix property should have 2
> levels of items constraints.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
>  - Add proper descriptions for 'qcom,smem-states'. Thanks Krzysztof!
>  - Fix i2c-parent warning
>  - Fix extra blank lines
> ---
>  .../rockchip/rockchip,rk3399-cdn-dp.yaml       |  2 ++
>  .../bindings/i2c/i2c-demux-pinctrl.yaml        |  1 +
>  .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml     |  7 ++++---
>  .../devicetree/bindings/net/qcom,bam-dmux.yaml | 12 ++++++++++++
>  .../devicetree/bindings/net/qcom,ipa.yaml      | 12 ++++++++++++
>  .../bindings/net/wireless/qcom,ath10k.yaml     |  8 +++++++-
>  .../bindings/net/wireless/qcom,ath11k.yaml     |  8 +++++++-
>  .../net/wireless/qcom,ipq5332-wifi.yaml        | 18 ++++++++++++++++++
>  .../bindings/pci/toshiba,tc9563.yaml           |  5 +++--
>  .../remoteproc/qcom,msm8916-mss-pil.yaml       |  6 ++++++
>  .../remoteproc/qcom,msm8996-mss-pil.yaml       |  7 +++++++
>  .../bindings/remoteproc/qcom,pas-common.yaml   |  6 ++++++
>  .../remoteproc/qcom,qcs404-cdsp-pil.yaml       |  6 ++++++
>  .../remoteproc/qcom,sc7180-mss-pil.yaml        |  6 ++++++
>  .../remoteproc/qcom,sc7280-adsp-pil.yaml       |  6 ++++++
>  .../remoteproc/qcom,sc7280-mss-pil.yaml        |  6 ++++++
>  .../remoteproc/qcom,sc7280-wpss-pil.yaml       |  6 ++++++
>  .../remoteproc/qcom,sdm845-adsp-pil.yaml       |  6 ++++++
>  .../bindings/remoteproc/qcom,wcnss-pil.yaml    |  6 ++++++
>  .../devicetree/bindings/sound/samsung,tm2.yaml |  8 ++++++--
>  .../bindings/spi/st,stm32mp25-ospi.yaml        |  5 +++--
>  .../bindings/usb/chipidea,usb2-common.yaml     |  2 ++
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml  |  7 ++++---
>  23 files changed, 142 insertions(+), 14 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.example.dtb: i2c-mux3 (i2c-demux-pinctrl): i2c-parent:0: [2, 3, 4] is too long
	from schema $id: http://devicetree.org/schemas/i2c/i2c-demux-pinctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.example.dtb: i2c-mux3 (i2c-demux-pinctrl): i2c-parent: [[2, 3, 4]] is too short
	from schema $id: http://devicetree.org/schemas/i2c/i2c-demux-pinctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260507201749.2605365-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


