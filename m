Return-Path: <linux-wireless+bounces-38163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v85SBU9aPmqSEQkAu9opvQ
	(envelope-from <linux-wireless+bounces-38163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 12:54:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8F6CC328
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 12:54:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MyMyQ5k5;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38163-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38163-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8DB6306823D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4B3EFFCE;
	Fri, 26 Jun 2026 10:53:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DA3EFFC4;
	Fri, 26 Jun 2026 10:53:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471231; cv=none; b=jWsQH57JA5g/Uknm0+nLU5kRYaFHGjzpNtK8NJDxy7/xnpfaQWOSvQwuvnn/J4KMuLZCkhebp2MoEtd3yzUZ0CSF7gX6HwQhxjDt2bkQ0NMDFr0ElVuyEPHpYTqsrC2n2Yl34G5zHOKEfzyx9Gxi7hx4uZVneNTw5RN8pbb7ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471231; c=relaxed/simple;
	bh=buHFoFbfTBSfi9LRPdDkR5ZejiADqlu7Fa/JhVvyYGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kszCJCzOY4cktI76gFqjUVO1OvLbwADYYNaxZ5vZJmgbQuyuA7gko8KQaOVJjdIfGb+CJiFhwaoLIJULO18CYrLo4qSro8cReCBwto3bG828duDWgoPA9j7IO5kLXwbJevMQtDngsAJe3D7STi1GwvjiP98gYUBA1I9P9R3/ZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyMyQ5k5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7CA1F000E9;
	Fri, 26 Jun 2026 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782471230;
	bh=Xs6FIqn23+iaFq+b1/TbaOk/+AW8nbnoFpHSIh+iuY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MyMyQ5k5eC+YQNXJ3vov1PPg4H9nfA90hYwbEBY+Mt+75uH5zvIu0vDC1rzl7/UER
	 RWeQyzy3ARhZaEokyNgcPSQvlvaSbsQpGnjuDLIH0jkSVYE4uXNa/80WW/Rk7RE8V2
	 iZeiMC9PJ9nRkeA3lGSnaKlqCCSM/ZutmprVVXFLDhYF8YXuq45P1yLkW1HAS+uAcZ
	 IIna8k9uLW2XXPP8smZx9yfNcM7xTVqcKDwYr5J1gQsjWZHtI5W7T4TovIr1+nw1pW
	 as6PQ6QfwhFz+fkuqJrclbjRzywjzJ2lEwLl563AaALbDbEPt0gQ8xAkDGE3j9hMyD
	 puZGXD4AeFwHw==
Date: Fri, 26 Jun 2026 12:53:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Saravana Kannan <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
Message-ID: <20260626-discerning-light-swan-6b599c@quoll>
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-4-d999be0e04f7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625-ipq5018-bluetooth-v1-4-d999be0e04f7@outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:george.moussalem@outlook.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-38163-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quoll:mid,outlook.com:email,devicetree.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79A8F6CC328

On Thu, Jun 25, 2026 at 06:10:08PM +0400, George Moussalem wrote:
> Document the Qualcomm IPQ5018 Bluetooth controller.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../bindings/net/bluetooth/qcom,ipq5018-bt.yaml    | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
> new file mode 100644
> index 000000000000..afd33f851858
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/qcom,ipq5018-bt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm IPQ5018 Bluetooth
> +
> +maintainers:
> +  - George Moussalem <george.moussalem@outlook.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5018-bt
> +
> +  interrupts:
> +    items:
> +      - description:
> +          Interrupt line from the M0 Bluetooth Subsystem to the host processor

What is M0?

Anyway, this part feels completely redundant. Can "interrupts" property
be anything else than an interrupt line from the device to the host
processor?


> +          to notify it of events such as re

This feels useful, but cut/incomplete.

> +
> +  qcom,ipc:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to a syscon node representing the APCS registers
> +          - description: u32 representing offset to the register within the syscon
> +          - description: u32 representing the ipc bit within the register
> +    description: |
> +      These entries specify the outgoing IPC bit used for signaling the remote
> +      M0 BTSS core of a host event or for sending an ACK if the remote processor
> +      expects it.
> +
> +  qcom,rproc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the remote processor node representing the M0 BTSS core.
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - qcom,ipc
> +  - qcom,rproc
> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +  - $ref: qcom,bluetooth-common.yaml
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bluetooth: bluetooth {

Drop unused label

> +      compatible = "qcom,ipq5018-bt";
> +
> +      qcom,ipc = <&apcs_glb 8 23>;
> +      interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;

No firmware to load?

It feels like remoteproc node split is fake. The property qcom,rproc is
even more supporting that case. Shouldn't this be simply one device -
bluetooth? What sort of two devices do you have exactly? How can I
identify them in the hardware?

> +
> +      qcom,rproc = <&m0_btss>;

Best regards,
Krzysztof


