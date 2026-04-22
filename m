Return-Path: <linux-wireless+bounces-35200-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KTELa5h6GlaJwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35200-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 07:50:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 597494422D8
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 07:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978EC30427D5
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17632C0307;
	Wed, 22 Apr 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CeguupGc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9566E63CB;
	Wed, 22 Apr 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836803; cv=none; b=RCaC/YOd9pJf/GUqgpNUA3KnTZ/ecycjiRVidDsfuBy2FcuUlaBAJCX1mPEU16bzHvZ7Cw7CV3usRg0EG6s0yOMKyKbJUZWiCZve9KJqAmpO3i4DMZR/Qqd79QfIW+eDeLvTggAyZF8/3RpQcMW6dYwJ2T1fgiiUH2aSqz3IY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836803; c=relaxed/simple;
	bh=iHTuLIFezrha1k24YoDSo0U0QgoHN5U9b98UCvK+v+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek3rf2rx73h3O8b/u+YMibJWcGSkXc+UYTjN33JHKKTj5PIdfNsU4BvvTcvX4qNDNGkL/4VbxpD41TtzxI51ylwNeUfgWgTsil5ELpoRc+WenV9zVa0SyPktD9FYT0Yn4ECK5+lhBn6nmGmBtE6Ax77IoL8anOjPG0ceR2prI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CeguupGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EF7C19425;
	Wed, 22 Apr 2026 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776836803;
	bh=iHTuLIFezrha1k24YoDSo0U0QgoHN5U9b98UCvK+v+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeguupGckqDP65N6NF+5nNirF0NNyfRUq2q5YVLXoZ+NJ8CHpzN1MtrNDFeiOXOMI
	 3IAP92r5zyTS/ZiNdu71HsVN4guqNuX5OnjQtKC82hXq6MmRAFVPTbyifXRNIzuJAR
	 ckL2rE5jWjyh1XNHoBUwdn5WTA5UFCdSUZP4TGLM=
Date: Wed, 22 Apr 2026 07:46:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Yang Xiwen <forbidden405@outlook.com>,
	Alex Elder <elder@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Rao Mandadapu <quic_srivasam@quicinc.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	ath11k@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix phandle-array constraints, again
Message-ID: <2026042233-barometer-backroom-d544@gregkh>
References: <20260421195836.1547469-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421195836.1547469-1-robh@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35200-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,linaro.org,gerhold.net,lunn.ch,davemloft.net,google.com,redhat.com,sipsolutions.net,samsung.com,gmail.com,outlook.com,oss.qualcomm.com,quicinc.com,foss.st.com,nxp.com,suse.de,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 597494422D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:55:25PM -0500, Rob Herring (Arm) wrote:
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

