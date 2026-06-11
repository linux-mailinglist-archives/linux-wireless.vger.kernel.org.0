Return-Path: <linux-wireless+bounces-37651-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8SmSGN5RKmp5nQMAu9opvQ
	(envelope-from <linux-wireless+bounces-37651-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:12:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE5066EEE1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 08:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="DyQF+hs/";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37651-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37651-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C761430DA13B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400434EEEE;
	Thu, 11 Jun 2026 06:12:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41C35893;
	Thu, 11 Jun 2026 06:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158361; cv=none; b=SZdB961wuk5Ud+ZXMWoAnf4h/OhEvGgyC4FKSGN7Xtk8yFwMxIl7D6L880C/KTqZKm8VqJO1jkW1k8xL2+W5yi+6Rb+wAeGR/RYo/EsHOUZVrORbpEuEUW5Vqn6nO2aKETGfU4FA7SF33FNi2OPh8G13DpdtOPElZhCr0IcVvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158361; c=relaxed/simple;
	bh=DWQyiCFO1FABU7yAOsD/6HABw1tfpUVXIqUq8GqvtXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q70OZACx2UgcVr/m5bjeEkn70b+dqY5NJ108Mwhef9jjgxtQmZPwjl9zMVSu8APoRKufKuR3eZVvA9NmOzMGbG4nrcUIpRHN8Mom9oVQE6m5QH6lM/NQQiicXQxRi2zBsTS1PVQiZ3HAeD8JYU4IBoV4NBgy9xfM2keB3EHvmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyQF+hs/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C451F00893;
	Thu, 11 Jun 2026 06:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781158360;
	bh=DxYpf2U0C53sMLriRY3htfPkTiuUmNi3d2UuSNLLb1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DyQF+hs/aG2rKRYUzz85y5O3fU0Xse5+1w9iuDQQmnRQ+ehsgd9jJayZugQvqNZBC
	 IZ01El2IY07l9WqTKehUlYt+eq/3GzT8LRjdI2EZGQe8RLBr4FmWhR0ndQsH6m5vmi
	 a8A/TjwN67onTgt7GOU4Aj7GdJcxqZa6DJ6mLJT0yMQLCWBMvqKIJwjUud5LM0cCEB
	 g3WmOrfKDgGEsL3nbWKxelci3j5KEQQqGZ5MHuW7qERz8RU6ZjLrc8LKE0cOPYtcGZ
	 IeR4rF8FJXCidMidpVwr76lKev4yXLcggRbioAc8v8v7hH1+irYI8z8a0SETZ6fol9
	 LzXJd6ueiD3xQ==
Date: Thu, 11 Jun 2026 08:12:26 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/7] PCI: qcom: fix parsing of PERST# in the legacy
 case
Message-ID: <sqxjkxbw6k7dstj2wmcwwigjou3jpq3bk4xidkpupfdblocadc@rkts6nbun5ld>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
 <20260608-sm8350-wifi-v2-1-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608-sm8350-wifi-v2-1-efb68f1ff04c@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37651-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com,vger.kernel.org,lists.infradead.org,bgdev.pl];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,rkts6nbun5ld:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EEE5066EEE1

On Mon, Jun 08, 2026 at 09:59:19AM +0300, Dmitry Baryshkov wrote:
> Commit deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT
> configuration") fixed support for the "mixed" platforms which declare
> PERST# pin the RC node and the PHY in the RP node, however it also broke
> support for a majority of existing platforms, which declare both PERST#
> and PHY in the RC node, because now PERST# is first acquired in
> qcom_pcie_parse_ports(), which then returns -ENODEV (as there are no
> PHYs in the RP nodes). Later qcom_pcie_parse_legacy_binding() tries to
> acquire the PERST# GPIO again and fails with -EBUSY (as the GPIO has
> already been requested).
> 
> Move parsing of RC's perst-gpios to qcom_pcie_probe(), making it obvious
> that it's shared for both cases and skip parsing it in both functions.
> 
> Fixes: deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT configuration")
> Closes: https://lore.kernel.org/r/gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

This issue is fixed now. You can drop this patch in next revision.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 11fc60489892..7664c7c28c0e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1907,15 +1907,6 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
>  	struct device *dev = pcie->pci->dev;
>  	int ret = -ENODEV;
>  
> -	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
> -		pcie->reset = devm_gpiod_get_optional(dev, "perst",
> -						      GPIOD_OUT_HIGH);
> -		if (IS_ERR(pcie->reset))
> -			return PTR_ERR(pcie->reset);
> -
> -		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
> -	}
> -
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		if (!of_node_is_type(of_port, "pci"))
>  			continue;
> @@ -1942,7 +1933,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
>  	struct device *dev = pcie->pci->dev;
>  	struct qcom_pcie_perst *perst;
>  	struct qcom_pcie_port *port;
> -	struct gpio_desc *reset;
>  	struct phy *phy;
>  	int ret;
>  
> @@ -1950,10 +1940,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
>  	if (IS_ERR(phy))
>  		return PTR_ERR(phy);
>  
> -	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> -	if (IS_ERR(reset))
> -		return PTR_ERR(reset);
> -
>  	ret = phy_init(phy);
>  	if (ret)
>  		return ret;
> @@ -1970,7 +1956,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
>  	INIT_LIST_HEAD(&port->list);
>  	list_add_tail(&port->list, &pcie->ports);
>  
> -	perst->desc = reset;
> +	perst->desc = pcie->reset;
>  	INIT_LIST_HEAD(&port->perst);
>  	INIT_LIST_HEAD(&perst->list);
>  	list_add_tail(&perst->list, &port->perst);
> @@ -2107,6 +2093,15 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	pp->ops = &qcom_pcie_dw_ops;
>  
> +	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
> +		pcie->reset = devm_gpiod_get_optional(dev, "perst",
> +						      GPIOD_OUT_HIGH);
> +		if (IS_ERR(pcie->reset))
> +			return PTR_ERR(pcie->reset);
> +
> +		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be updated!\n");
> +	}
> +
>  	ret = qcom_pcie_parse_ports(pcie);
>  	if (ret) {
>  		if (ret != -ENODEV) {
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

