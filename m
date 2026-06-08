Return-Path: <linux-wireless+bounces-37512-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wtmbLF2lJmrnaQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37512-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 13:19:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B4D6559B5
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 13:19:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SA+ykTYg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37512-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37512-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28B95304643E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DF35A3B1;
	Mon,  8 Jun 2026 11:17:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA30356749
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 11:17:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917441; cv=none; b=lAPj2rNwn3eOPJUzNN+zHuXJcMyVM9r91MOezTIzsKeIlNXVJIzp8IXb6wTHE5qteb9EETGAivvhT8CQBzwDZsYKe1vjzF3Xyamw0dn0q1dAEAV4SvY/K+1P/lAa3jgis3YudUVe+hOdFAwHwQ6ssdwzqtwK3CkZyIPDszb0XLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917441; c=relaxed/simple;
	bh=COGUDabHVcqXHpcJkYlZm/XV5Ldx2uNyBygMmkWnTdE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZU9EaUP3gNmdGYTThf88bHYv4EusIvL+s6Vr5aIcmq2HDqJZSIR5ra5UK8sOnixwZ2VY0lK7o5pjVotA6oEctXQciPe/wNkinYVnkX3/ImbedV3ctbWbdKyJcRXCEVedFnC+r6Gt48EIOaD34tMqcP5PGaK20n3ZXd04taC/gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA+ykTYg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024F81F00898
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917440;
	bh=ad7d5mr4CwYQO8iltfUUgJ+AAb4ROP3d+z77mZ0aNzU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=SA+ykTYg2FGHFGXDTW96O+0oJN2T39LKOCvP/a9mVkcYo9EuhSugk8zd7wMz/KYIu
	 vRgRAgJ4mSmrU742iRt4tJQJXNOA3zJ6SIvAE27AeLEu1WgQNrqMfghsMvRCFeSkBC
	 HMXQ8l1LN5U1eGW0xfgqTg2a03Zno6ALDmjtIsEgb6gEsIC5yKYw3pf0UqcIqgcTB4
	 usBsWS6UgaFUr1KmQrE0uYcm0g2quObfR9Kn+SiJZmxY8bakLmCfAiCkNgrGmdbHIE
	 1+4LASfTOXhMG+Z8AwRk95hILKkQMjpSDVvHl0H/DzglyhaRUYco1OVFKiB3oIqdx7
	 IgRhW/g6BX2Dg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3965f215817so37470471fa.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 04:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8VmkcuiWKuYiYZCxW4TxJilKahFTFkBzGhZsSHGbaAShA61FBgyg1ZMpDdOWjwdRxNK6NqolNKoWhQhORhwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZKk+lXbJ2dga50FC3S4k1JS9NPTSqP9S5pdYy5lVNsfBlgXS
	3FKmAUjp1T7vFjO8j/D9mi73iFlWsQxo4ezfLFCbY5is8IcFc8qOmKciqLIPwBOWizYTjAq/tON
	9fhZM/vLdcu/FzvJPepLc2gyqKg72GFreAmiQ9gZwew==
X-Received: by 2002:a05:6512:6482:b0:5aa:7078:49ee with SMTP id
 2adb3069b0e04-5aa87bf444cmr3733378e87.43.1780917438653; Mon, 08 Jun 2026
 04:17:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:17:17 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:17:17 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com> <20260608-block-as-nvmem-v3-3-82681f50aa35@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 04:17:17 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc46R=VqCp-eQcy8DP1yvyco=E43eup6NpkZjAR+rY=OQ@mail.gmail.com>
X-Gm-Features: AVVi8CdkJtXpApBPRw2hv_xTVbemR0DzCSGvL77XwK4W0RDjW4XvcGcsiQ8sLHk
Message-ID: <CAMRc=Mc46R=VqCp-eQcy8DP1yvyco=E43eup6NpkZjAR+rY=OQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37512-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61B4D6559B5

On Mon, 8 Jun 2026 12:50:40 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Add support for an NVMEM cell provider for "local-bd-address",
> allowing the Bluetooth stack to retrieve controller's BD address
> from non-volatile storage such as an EEPROM or an eMMC partition.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
> @@ -22,4 +22,13 @@ properties:
>      description:
>        boot firmware is incorrectly passing the address in big-endian order
>
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Nvmem data cell that contains a 6 byte BD address with the most
> +      significant byte first (big-endian).
> +
> +  nvmem-cell-names:
> +    const: local-bd-address
> +
>  additionalProperties: true
>
> --
> 2.34.1
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

