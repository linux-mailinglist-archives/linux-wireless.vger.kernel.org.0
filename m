Return-Path: <linux-wireless+bounces-38216-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FJ2LFEyQQGr8gAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38216-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 05:09:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D716D3017
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 05:08:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MOnRIRYa;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38216-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38216-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0A9B301700F
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 03:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F79025524C;
	Sun, 28 Jun 2026 03:08:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4D18B0A;
	Sun, 28 Jun 2026 03:08:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782616132; cv=none; b=MTpUry8fHBxXkJ2yQPAVwon/bT7YUpjOFHUvUM/Bb5TkYhTBDuCHufY2DwCqNfboW/78CCcGpXZ4l5NjBLw6a6gpditF2TSj4125KgP6GaGiYMUAE7omRaCQRHQMNSTgSFCv2XfzHpMZd93jxjKOf30xGkdtFpZjVBB/Vuh3cY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782616132; c=relaxed/simple;
	bh=F13cvcxhy3d55n7MjK8iW6eyN6upRu2rZr5RBuse3J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+yq8J8XCsacC3DSr2s4I544cB8U/bulCCpoACOHTxBnDtI1gtnXlZG/puoOvb8ChfVk6pDVHdpGrV9MuKiNd9Mgg0IK4veeGsXwZok3WK28qAWebRByG5IZNKzJtDCengYsvfEwnkPC5dHqhC3o1NrqKBKypDogjp+nNdP1Vt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOnRIRYa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3291F000E9;
	Sun, 28 Jun 2026 03:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782616131;
	bh=mB14dzokXviAWew5o/D1323LSbv37Vmdi+prndaBPPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MOnRIRYaRdO5vvVGeU7z0bd3sUm5jr4IF5E7H3Drrc/mhZ6J38Qgq2KfeWfZdyiZF
	 MyPP0RbCyJey4DDEUnHd/WLuffNAb8sTTBthLHXIGJyqrQSSPkIx6uWA/liBTX+5lW
	 MrlHQ5wgAlRACR0pP+fZlMCwm6ZXwW2hMDDiaTArIgZesUqxLqEhUgCYnpG+5qr0Hj
	 uKSDOrLyTeD9isVpYKdNW0tZpinsYRBlVXmHhM4YAegP3rdvy1dlnWzXSqBQtEmPm3
	 0+QfU26iTUBVvK4ZJZA1rRf5Di3ctOCXGbhevxIzBFqBQWEaeaX29sq0WMzJFx/G1K
	 t0d4zembWGl2A==
Date: Sat, 27 Jun 2026 22:08:46 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>, 
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Saravana Kannan <saravanak@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
Message-ID: <akCQA-bLpp31QVGV@baldur>
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
 <38aceb33-b28e-4994-b277-de070b6dae2b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38aceb33-b28e-4994-b277-de070b6dae2b@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38216-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:george.moussalem@outlook.com,m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.
 de];
	FORGED_SENDER(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andersson@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[outlook.com,kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 95D716D3017

On Fri, Jun 26, 2026 at 01:20:25PM +0200, Konrad Dybcio wrote:
> On 6/25/26 4:10 PM, George Moussalem via B4 Relay wrote:
> > From: George Moussalem <george.moussalem@outlook.com>
> > 
> > Add support to bring up the M0 core of the bluetooth subsystem found in
> > the IPQ5018 SoC.
> > 
> > The signed firmware loaded is authenticated by TrustZone. If successful,
> > the M0 core boots the firmware and the peripheral is taken out of reset
> > using a Secure Channel Manager call to TrustZone.
> > 
> > Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> > ---
> 
> Can this not fit inside the existing PAS driver?
> 

While the start/stop SCM calls look the same, this doesn't follow any of
the surrounding concepts. So I think this should follow the other
non-remoteproc uses of mdt_loader and scm directly instead.

Regards,
Bjorn

> Konrad

