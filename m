Return-Path: <linux-wireless+bounces-39139-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KHi0Cwt4V2rtOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-39139-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:07:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6F75DE86
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:07:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g8ts8fDP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39139-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39139-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE0AA300DDCA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9166544CAC2;
	Wed, 15 Jul 2026 12:07:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30F44838C
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 12:07:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117251; cv=none; b=iyudqPK8xAM1urdUpvF2rpDPA3PBszt4K3uTF8Y7w6hYTMhE5lMXCsA62gtA9Ge8shGjrnVWFJ0dfz4MmthEWLjqkV08ulQ1SRzXcjZL0eoo6yXvtc5Xsgyth8OqPES9Kth9G6f70hQJ96b/Sb55axKbnuXi969P9dvTVUu9N1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117251; c=relaxed/simple;
	bh=f2Zj74TZ4DoqiACSYtc5w8cY4fNh79DTd3mLuz53jr8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXk66a0hUSoq9pq0osro0o3RB7h5N9jmdapiF/9hSfws+8iLd78DceCEtzyXyPRIb8FRFCvbgSqPPMiwPcs5I5Beo++kmXK5gzwfEgVXobmaGYEN757zLMUPl154Y6A9dLzg/nnndB/bEsPr/Tc+LVIRlwoIvuUsv6mI1BhuSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8ts8fDP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1851F01558
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784117248;
	bh=WKCD7udqW/dT/0NFTWMaszCBVogtz2n64C25G28PPzI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=g8ts8fDPfeP4aPC4wcsC8csEYsmlfO9W55RW7E+28seh+twc4ka/lYw4hfsfDzqoL
	 KnPMsLyiPUWAthLbF28u3T77KAMt/7h2e1Bvpv3QQEbBlPMRH2IH08iYX+1TiNCb+N
	 xdP5RFHIXeNlvRieT6iU0iQqnyTmPR/58lgRXx/T3uef1Bro6FLeYnjt8WjpO8sjis
	 +tF/t/vRCi6qviGJ28NvyU+rkJ22Az3x4vRrT/WlPJMA+h+5Lp7UUH4FTnVP1/5Qhh
	 LZzDJ5Zis4XciF9fqLZzt16VKYXsdC961v/sL6O2nX1zQ6GsWW+BMSvV+p4AmpMYK4
	 0vnQP4LZmyrJw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b01cb18515so5013161e87.2
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 05:07:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpCbl6zyBdiZcyv+oi1Yh7IS6yNnR32RiWapGCC++tJwlLfThCVFLr3V2wgSf6/a5lj4i+rpGAkp1y59lpZng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDZ0z+xgQwVTxYGNb0RMlgDNlIzyqQGA6h8cKjCHu4k2akIZe
	bvZ6rP5B5PWaQ8zmGNqcmu+ft+OHW8bHgtRm8kiUKEYN6A9RXXbvslkVMl+scsHbZJ6gPhOBccV
	RZJmxYfWPrHahv8QMNWSSazpU6XJtQ3pfSY1clTpN4w==
X-Received: by 2002:a05:6512:3ca1:b0:5ae:bb4b:9357 with SMTP id
 2adb3069b0e04-5b159b76543mr1504606e87.27.1784117246567; Wed, 15 Jul 2026
 05:07:26 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:07:24 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:07:24 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260703-block-as-nvmem-v8-4-98ae32bfc49a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com> <20260703-block-as-nvmem-v8-4-98ae32bfc49a@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 05:07:24 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdNehSRQT3MUs+QtbZsHcUCS8YjyZchTgHCVv-HaLQkeA@mail.gmail.com>
X-Gm-Features: AUfX_mzq1KbXpXfl_bzC2i2_CZOvOZaRAVu5gjRfir9Gou3fViKyrxWRMFDDFs8
Message-ID: <CAMRc=MdNehSRQT3MUs+QtbZsHcUCS8YjyZchTgHCVv-HaLQkeA@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] nvmem: layouts: Support fixed-layout as the nvmem
 device node itself
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
	Saravana Kannan <saravanak@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39139-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,makrotopia.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92E6F75DE86

On Fri, 3 Jul 2026 15:45:17 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> of_nvmem_layout_get_container() only looks for a child node named
> "nvmem-layout" to locate the cell definitions. This does not cover
> providers whose device tree node is itself the fixed-layout container,
> such as an eMMC boot partition block device whose fwnode points directly
> at a "fixed-layout" compatible partitions node.
>
> When no "nvmem-layout" child is present, fall back to returning the nvmem
> device node itself if it is compatible with "fixed-layout", so that its
> cells are parsed by nvmem_add_cells_from_fixed_layout().
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/nvmem/layouts.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
> index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
> --- a/drivers/nvmem/layouts.c
> +++ b/drivers/nvmem/layouts.c
> @@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
>
>  struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
>  {
> -	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
> +	struct device_node *np;
> +
> +	/* Search for nvmem-layout child */
> +	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
> +	if (np)
> +		return np;
> +
> +	/* The nvmem of_node is itself a fixed-layout node */
> +	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
> +		return of_node_get(nvmem->dev.of_node);
> +
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
>
>
> --
> 2.34.1
>
>

I have it on my TODO list to convert nvmem layouts to be fwnode-agnostic. While
I'm not sure when I'll have the time to look into it, I think it makes sense
to not introduce any new OF-specific interfaces. Can you make it into:

  struct fwnode_handle *nvmem_layout_get_container_node(struct
nvmem_device *nvmem);

by replacing of_get_child_by_name() with fwnode_get_name_child_node() and
of_device_is_compatible() with device_is_compatible()? That would mean less
churn in the future.

Other than that, it looks good.

Bart

