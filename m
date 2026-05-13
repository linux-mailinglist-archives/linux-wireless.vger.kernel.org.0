Return-Path: <linux-wireless+bounces-36398-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEArMFT+BGpTRQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36398-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 00:42:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3453B920
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 00:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F97E3031138
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 22:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761E3AEB27;
	Wed, 13 May 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj+fBMGp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC24184;
	Wed, 13 May 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712140; cv=none; b=pvOVSJfqEfAJUF7rn9RtYdEnnKktbF6Kd+ldlRXHYk6x1mqByCCUHyALhPl7FC8LVrZrgakMG7J+hfYbeiwdoAs65THkzUjddU6WRt+VhNo03viG0vYwMyn0ue44Pd5uhqGRBMn13NYrakZ7moVcqhSIMaeyodFWobLlVXQu8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712140; c=relaxed/simple;
	bh=6NAHPyole2pQ/CHwKqRP4tLqoyofLvYLcq17xj38jf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYPY2YSw4Kf8rGg4AeGp7Uo+0YMVXr9JjQ2aVTLG1ovXrVitevHJ0RfhQIjWJWBRkjPsXSQo3mIipxFsHoARB/JvcTVQqE/wawV1joNGQuhdXSRWifjpawvEmjB8QnL6MdI83ac1WitkT2wo5fUsJJDvv8wmrrJiVeF2HoxmLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj+fBMGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3368C19425;
	Wed, 13 May 2026 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778712140;
	bh=6NAHPyole2pQ/CHwKqRP4tLqoyofLvYLcq17xj38jf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cj+fBMGppCybD/58WT/pMz7uSjenugSfEv6zeje2jwicAv8xdflI3FMozNWqJ3Mrd
	 S1y+MtXR/ZG6Ij8EEBKjrsmQWpD/dfdqEC7dggn3gt2RiBO8rYrPRu4npuKZ2xk8TZ
	 B/v9mMzQ1xL9M+9TNKkpwABmG7TVr8iK81ZQuwYdic5bKII+TXfFbyCSGxP5n6KIJZ
	 YuqZ3o65MTC2R4SsE/zCKg3vvmR6Lu5Oag5C7beePpd8y60zqSk5uBa1fwVcKD4NV5
	 /eP2O0KM/LKUTciFzpwn6Fcg0qjftObhxATy7fec/9/ajSn87NLyPf4/yV/fFXVQnC
	 IU7lUJbzS6SLw==
Date: Wed, 13 May 2026 17:42:17 -0500
From: Rob Herring <robh@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	daniel@makrotopia.org
Subject: Re: [PATCH v2 1/8] dt-bindings: mmc: Document support for
 nvmem-layout
Message-ID: <20260513224217.GA2190241-robh@kernel.org>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
 <20260507-block-as-nvmem-v2-1-bf17edd5134e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-block-as-nvmem-v2-1-bf17edd5134e@oss.qualcomm.com>
X-Rspamd-Queue-Id: 65C3453B920
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-36398-lists,linux-wireless=lfdr.de];
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
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 05:24:36PM +0200, Loic Poulain wrote:
> Add support for an nvmem-layout subnode under an eMMC hardware
> partition. This allows the partition to be exposed as an NVMEM
> provider and its internal layout to be described. For example,
> an eMMC boot partition can be used to store device-specific
> information such as a WiFi MAC address.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/mmc/mmc-card.yaml          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> index a61d6c96df759102f9c1fbfd548b026a77921cae..b21426a49cf1d9aae5b4e8e447b5be11b08c96bf 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -40,6 +40,9 @@ patternProperties:
>          contains:
>            const: fixed-partitions
>  
> +      nvmem-layout:
> +        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
> +
>  required:
>    - compatible
>    - reg
> @@ -86,6 +89,27 @@ examples:
>                      read-only;
>                  };
>              };
> +
> +            partitions-boot2 {

Shouldn't this have a 'fixed-partitions' compatible? I'm not sure if 
it's an oversight in the schema that 'compatible' is not required here. 
It would be odd that compatible is optional, but if it is present, it 
must contain 'fixed-partitions' compatible. A follow-up to fix that 
would be great.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob

