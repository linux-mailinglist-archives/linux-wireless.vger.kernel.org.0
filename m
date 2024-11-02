Return-Path: <linux-wireless+bounces-14842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76459BA037
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 14:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B161F21683
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Nov 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D718A6B5;
	Sat,  2 Nov 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqOtSOhu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F79189F47;
	Sat,  2 Nov 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553128; cv=none; b=g56Z6E0Nv+pqSKoUvCNgxVRKZMc8mLr8i7IlUP0yg/yYwdP8HrwqUtB9aqgZqiYUlR7I2q6tyLdLxvg+mxLlpuhkLkWtS1J4mMKpP76jdqgADzj02ZwaeeC+HR1dx2sINNUjGUa4EuRThBKy94H/aq5zg8cabFIYseoR+gdvUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553128; c=relaxed/simple;
	bh=8zBgapSvy/X1XAXpF6HYYSEqMFfiSnitRwvaXv8+hgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dv3Y9PKuMI+IkNq5GMaBENeLj4R56DMPBj6+xKGAOPMglkb+xNT2WosQ86wm3P00j/uvroJP2OIfVbH/HpyklXs8YEtW4rH1C0fuMBO6TefjY5K3y9fQfrqkxzgltDvelafiLXSawYFLt/GjtX3TIBO34jllJTazJER8DzR5qRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqOtSOhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18EDC4CEC3;
	Sat,  2 Nov 2024 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730553128;
	bh=8zBgapSvy/X1XAXpF6HYYSEqMFfiSnitRwvaXv8+hgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqOtSOhuQxp/jwjDMOJpvrh7YN96sJRvdzz6OH9I5ZZGH+s3upObYqakNtUYj8pLB
	 chg4Mliu3sZ+oK2Yg1NeZrRRELCh9RfgiC7nfEcUrVBd1byxZrNFiPDAhufNr7cqGz
	 K1e7L+qvErkB89AFbLt9KYsNdYZD8zSO8Si6YuPBt82c6mAQevsa5bTx+xcfms28mV
	 bvPhZrpPeTwctUHykoKOzD3Uky7JCgCDUjSmvQpP+I0efYXK8AafJ4cYDjIEw3TOOl
	 1ev5QZZ8xQgOXDnAHNsUe/sqmf3c01pXaPgi2GsMjqCzLCE+LkUKpK36tf6Wlm2GnJ
	 xeHKwmdcniJgQ==
Date: Sat, 2 Nov 2024 13:12:01 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Nemanov <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH v4 07/17] wifi: cc33xx: Add event.c, event.h
Message-ID: <20241102131201.GI1838431@kernel.org>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
 <20241029172354.4027886-8-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029172354.4027886-8-michael.nemanov@ti.com>

On Tue, Oct 29, 2024 at 07:23:44PM +0200, Michael Nemanov wrote:
> Unlike in wlcore, events are queued on linked list
> (cc->event_list) and are handled outside the IRQ
> context. This will be more clear when looking at main.c
> 
> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
> ---
>  drivers/net/wireless/ti/cc33xx/event.c | 363 +++++++++++++++++++++++++
>  drivers/net/wireless/ti/cc33xx/event.h |  71 +++++
>  2 files changed, 434 insertions(+)
>  create mode 100644 drivers/net/wireless/ti/cc33xx/event.c
>  create mode 100644 drivers/net/wireless/ti/cc33xx/event.h
> 
> diff --git a/drivers/net/wireless/ti/cc33xx/event.c b/drivers/net/wireless/ti/cc33xx/event.c

...

> +struct event_node {
> +	struct llist_node node;
> +	struct cc33xx_event_mailbox event_data;
> +};
> +
> +void deffer_event(struct cc33xx *cc,
> +		  const void *event_payload, size_t event_length)
> +{
> +	struct event_node *event_node;
> +	bool ret;

Hi Michael,

A minor nit from my side: ret is set but otherwise unused in this function.
Probably it should be removed.

> +
> +	if (WARN_ON(event_length != sizeof(event_node->event_data)))
> +		return;
> +
> +	event_node = kzalloc(sizeof(*event_node), GFP_KERNEL);
> +	if (WARN_ON(!event_node))
> +		return;
> +
> +	memcpy(&event_node->event_data,
> +	       event_payload, sizeof(event_node->event_data));
> +
> +	llist_add(&event_node->node, &cc->event_list);
> +	ret = queue_work(cc->freezable_wq, &cc->irq_deferred_work);
> +}

...

