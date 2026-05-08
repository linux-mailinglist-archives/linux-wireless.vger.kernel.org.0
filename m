Return-Path: <linux-wireless+bounces-36115-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAGALvDj/WmOkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36115-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 15:24:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD34F6FE1
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D832A307B8CE
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43063E3DB2;
	Fri,  8 May 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvCpTpO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763291607A4;
	Fri,  8 May 2026 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246451; cv=none; b=H6cLA6fXJDe2OQcATRYqyR24BInYqLyDzt4LBSVvU0rqotBP85oVyRveEkq9FVdYyZs975+fzRDkqQEfswY3FLNE/N5Iq3Wsa5nOMu6kg0RX9YEDspPN29ctOikXRz1o2NahmFxDHuQYh63Dc4oG9qWDJW3Z9nQrZ67y+Tj49jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246451; c=relaxed/simple;
	bh=nOPD9atbWThJNMmMoHB5sxyB+Zz+gBrCfQ8sDAbxWfs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgBuyLLSddX4gbaPwguXIVfFwQqu9t7+NIMXWlmZzMFh1R3Zq2xPglaiR176V2Ye5v1iKk21a/jZ98OK5YGON68AFxqIrRuYml76ITtom06Qf0Wi0l7KRCjrnf0RKgU2KJHzGziFpJ7n+O5DJhlO5LXoYy8DC9rCAOa9U+Tqy68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvCpTpO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C78C2BCB0;
	Fri,  8 May 2026 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246451;
	bh=nOPD9atbWThJNMmMoHB5sxyB+Zz+gBrCfQ8sDAbxWfs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=uvCpTpO4REXkncNMBiNLPHMkLEABizVJIybZSKgueZ4IaHUHavnLFzv8P+NLJzgPD
	 56mAOXlI9nEg2TxsBRdamOk/G6RgaGfgclVMiMBk4VzWSh6B/UAarPqlvWcraWZJXy
	 jCuzmip8H9tWuqWjWk0hYvRJ3cEuCB+w1yxeHSYw6eamGP8ZuLPDQexOjiAx8jgYsg
	 GxsXWeadcSEiVfnwQTHBIyBWfSp3POF7V0KIVSt38axnzkQo/Wn9sz/rRMHJ4inVSS
	 DLv7iX+VtDuDuXZ/g5upJqVAmV0nY7PxLtjLUXfjhjudd6i7+M6Ud41q0VPGIObm/9
	 TDJJCCo63qNCw==
Date: Fri, 8 May 2026 08:20:48 -0500
From: Rob Herring <robh@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-usb@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	ath11k@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-wireless@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org, linux-i2c@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	ath10k@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: Fix phandle-array constraints, again
Message-ID: <20260508132048.GA1170714-robh@kernel.org>
References: <20260507201749.2605365-1-robh@kernel.org>
 <177818942584.2803269.2192622854542354589.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177818942584.2803269.2192622854542354589.robh@kernel.org>
X-Rspamd-Queue-Id: 7EAD34F6FE1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-36115-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,renesas,netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 04:30:25PM -0500, Rob Herring (Arm) wrote:
> 
> On Thu, 07 May 2026 15:16:00 -0500, Rob Herring (Arm) wrote:
> > The unfortunately named 'phandle-array' property type is really a matrix
> > with phandle and fixed arg cells entries. A matrix property should have 2
> > levels of items constraints.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > v2:
> >  - Add proper descriptions for 'qcom,smem-states'. Thanks Krzysztof!
> >  - Fix i2c-parent warning
> >  - Fix extra blank lines
> > ---
> >  .../rockchip/rockchip,rk3399-cdn-dp.yaml       |  2 ++
> >  .../bindings/i2c/i2c-demux-pinctrl.yaml        |  1 +
> >  .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml     |  7 ++++---
> >  .../devicetree/bindings/net/qcom,bam-dmux.yaml | 12 ++++++++++++
> >  .../devicetree/bindings/net/qcom,ipa.yaml      | 12 ++++++++++++
> >  .../bindings/net/wireless/qcom,ath10k.yaml     |  8 +++++++-
> >  .../bindings/net/wireless/qcom,ath11k.yaml     |  8 +++++++-
> >  .../net/wireless/qcom,ipq5332-wifi.yaml        | 18 ++++++++++++++++++
> >  .../bindings/pci/toshiba,tc9563.yaml           |  5 +++--
> >  .../remoteproc/qcom,msm8916-mss-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,msm8996-mss-pil.yaml       |  7 +++++++
> >  .../bindings/remoteproc/qcom,pas-common.yaml   |  6 ++++++
> >  .../remoteproc/qcom,qcs404-cdsp-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,sc7180-mss-pil.yaml        |  6 ++++++
> >  .../remoteproc/qcom,sc7280-adsp-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,sc7280-mss-pil.yaml        |  6 ++++++
> >  .../remoteproc/qcom,sc7280-wpss-pil.yaml       |  6 ++++++
> >  .../remoteproc/qcom,sdm845-adsp-pil.yaml       |  6 ++++++
> >  .../bindings/remoteproc/qcom,wcnss-pil.yaml    |  6 ++++++
> >  .../devicetree/bindings/sound/samsung,tm2.yaml |  8 ++++++--
> >  .../bindings/spi/st,stm32mp25-ospi.yaml        |  5 +++--
> >  .../bindings/usb/chipidea,usb2-common.yaml     |  2 ++
> >  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml  |  7 ++++---
> >  23 files changed, 142 insertions(+), 14 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.example.dtb: i2c-mux3 (i2c-demux-pinctrl): i2c-parent:0: [2, 3, 4] is too long
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-demux-pinctrl.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.example.dtb: i2c-mux3 (i2c-demux-pinctrl): i2c-parent: [[2, 3, 4]] is too short
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-demux-pinctrl.yaml

This needs a fix in dtschema I have not yet pushed out.

Rob

