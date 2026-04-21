Return-Path: <linux-wireless+bounces-35187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EfBITTt52mhCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:33:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1A43FC2D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8197E306434D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 21:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6A3DCD8D;
	Tue, 21 Apr 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfEYijh7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DF2F4A05;
	Tue, 21 Apr 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807212; cv=none; b=Zej1RspqZqcTNA2mbdXSbX5f34XMtajp+x1dAESkweSDIGZiBvs2GJwRm5dygFUMNHxG2JuA3WS/mas+1SnM28kMDbcevNWU61qR5LymuziDZs1YlZ0VrYYGpTtG4oHwlQhteRVSL9vp2banEGXKRf2jbvDaLzD+P1epPWnlAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807212; c=relaxed/simple;
	bh=vatupuq4WrABpSuEUMYUtujivXgVDiHk3e1MmNVxM+Q=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=e1kkqojvvb7JKiyHcSlbBsam7OTIMBBZQS6ktaBp07FzxRJ+3rBhtw0Dv8FXXsQBEUiwlwc2CLnacNUxdPuAJ5Ocy8zyq/z+XSHghqguR+xsIvSi1ug384x3X+rnZ5AWH85zkZtAcmQlrZes8q6xS7T0aJ1i6xB0cPa0OZWuDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfEYijh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D63C2BCB0;
	Tue, 21 Apr 2026 21:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776807212;
	bh=vatupuq4WrABpSuEUMYUtujivXgVDiHk3e1MmNVxM+Q=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RfEYijh7XhOIIxtCBiZK1gn5IXNLv5qcn5amQw5CqC2XQ0mRjsWMy0SwC/jKxN8Ha
	 +lGNHgaycbYUVz/8qUQTAV87+keU8WY1I1fe4qL/Cubm0CmcRljTFyT4oCGT3XsCWG
	 21JAOI+XCTuLyqtAQ0JY89PQj9ztU0bsVRSzsv4sAV4REIQeaAk9EIXe86axCL8Lcv
	 P49oQppEQE3W5ysKk35W1yekjIPJzFLIHvqS9YHqLVNNeeeAs1gWZnOJuQHTbQ76Mo
	 fn4ArOBoMvEaOR/5jHbzodnC5RnVkOGNRxUq58/UbFZ0QTUKrwlb9kjzN5QiQ3GPHQ
	 wuq7UQCA8GLiQ==
Date: Tue, 21 Apr 2026 16:33:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, ath11k@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-spi@vger.kernel.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rao Mandadapu <quic_srivasam@quicinc.com>, Mark Brown <broonie@kernel.org>, 
 linux-sound@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Alex Elder <elder@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Stephan Gerhold <stephan@gerhold.net>, 
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Bjorn Helgaas <bhelgaas@google.com>, Jeff Johnson <jjohnson@kernel.org>, 
 linux-mmc@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ath10k@lists.infradead.org, 
 netdev@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20260421195836.1547469-1-robh@kernel.org>
References: <20260421195836.1547469-1-robh@kernel.org>
Message-Id: <177680720998.183058.5012840252939438533.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix phandle-array constraints, again
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[46];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samsung.com,lists.infradead.org,vger.kernel.org,linaro.org,kernel.org,nxp.com,lunn.ch,foss.st.com,quicinc.com,linux.intel.com,gmail.com,suse.de,oss.qualcomm.com,sipsolutions.net,outlook.com,gerhold.net,google.com,redhat.com,davemloft.net,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-35187-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46F1A43FC2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 21 Apr 2026 14:55:25 -0500, Rob Herring (Arm) wrote:
> The unfortunately named 'phandle-array' property type is really a matrix
> with phandle and fixed arg cells entries. A matrix property should have 2
> levels of items constraints.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Can someone from QCom provide some descriptions for 'qcom,smem-states'
> properties.
> ---
>  .../display/rockchip/rockchip,rk3399-cdn-dp.yaml         | 2 ++
>  .../bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml      | 7 ++++---
>  Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml | 6 ++++++
>  Documentation/devicetree/bindings/net/qcom,ipa.yaml      | 6 ++++++
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 5 ++++-
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml    | 5 ++++-
>  .../bindings/net/wireless/qcom,ipq5332-wifi.yaml         | 9 +++++++++
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml          | 5 +++--
>  .../bindings/remoteproc/qcom,msm8916-mss-pil.yaml        | 3 +++
>  .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml        | 3 +++
>  .../devicetree/bindings/remoteproc/qcom,pas-common.yaml  | 4 ++++
>  .../bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml        | 4 ++++
>  .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml         | 3 +++
>  .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml        | 3 +++
>  .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml         | 3 +++
>  .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml        | 3 +++
>  .../bindings/remoteproc/qcom,sdm845-adsp-pil.yaml        | 3 +++
>  .../devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml   | 3 +++
>  Documentation/devicetree/bindings/sound/samsung,tm2.yaml | 2 ++
>  .../devicetree/bindings/spi/st,stm32mp25-ospi.yaml       | 5 +++--
>  .../devicetree/bindings/usb/chipidea,usb2-common.yaml    | 2 ++
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml  | 7 ++++---
>  22 files changed, 81 insertions(+), 12 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/remoteproc/qcom,qcs404-cdsp-pil.yaml:99:1: [warning] too many blank lines (2 > 1) (empty-lines)
./Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml:67:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.example.dtb: i2c-mux3 (i2c-demux-pinctrl): i2c-parent:0: [2, 3, 4] is too long
	from schema $id: http://devicetree.org/schemas/i2c/i2c-demux-pinctrl.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/samsung,tm2.example.dtb: sound (samsung,tm2-audio): i2s-controller: [[4294967295], [0], [4294967295], [0]] is too long
	from schema $id: http://devicetree.org/schemas/sound/samsung,tm2.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260421195836.1547469-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


