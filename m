Return-Path: <linux-wireless+bounces-32498-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNgnA9o5qWnf3AAAu9opvQ
	(envelope-from <linux-wireless+bounces-32498-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 09:07:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD420D1F6
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 09:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 431AF300DDEE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425F366554;
	Thu,  5 Mar 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="or160yBH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E8331220;
	Thu,  5 Mar 2026 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697993; cv=none; b=kF+L3YsnDz3q21cskkv5uHuNn49U1f///8Uq7wD8MjeO47iUI8B6hKlcDTsYT9NeV3A/RUR6rs4Pc0ot7HcOGt/SYO56dMAEuF0PdX1/AVIdcYQuXK0PFIf+zK4RiHVV0Aapg4FBdeQrLeKrCNAQjJ88pfYtYevVfKUbtoS13SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697993; c=relaxed/simple;
	bh=U+JoX97JzOm2+Fg0hFQca/wViVUZpy1As6GCiZp+B1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhPLrHHmzBpBR68uZo8ceN8U1SU5TTI2z0+KBwo5YhXQk9sxfmLsttVeV6PYF1ZLvy6qhwIsD5nmhGrYN9QRxCdu71+qCN3QVRI8TWG4+kI59kRjip6yECBO4PQyWrQoavCrauw3VGNm+Snk+HcumTjbcpAnn/L0HBGjRqLrt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=or160yBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388B4C116C6;
	Thu,  5 Mar 2026 08:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772697992;
	bh=U+JoX97JzOm2+Fg0hFQca/wViVUZpy1As6GCiZp+B1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=or160yBHU4HqVpvzdzagPLm+NztpXeguGtYcLcvisnMSbpRmknrMEYYf24A/9X421
	 RbWDUuf69hrJxMZFSw+MfU53EIjdlRtSLE4vZY4dqLPSsCrEaVw+a1gkFT4wKPcUMt
	 l2PlQNIncRnsClroOgeYSh95mh/y1RGnUDkGmpf1k/sGU8ejJa2v1JNsqycLTf1O+H
	 xbr+V0oM2P9/xui3/1Buo8I/8jMr8/Sw8bdC+pbqw9svfJDbXc8sUuNpdfsQH8w+U7
	 fP3RaRRVuPoBM7R42p54YgS0ARhESWJ0rFJn5vVSonyJtZv35UZGSPPEE6FpyA2BK+
	 9YsX5Ddk55XDw==
Date: Thu, 5 Mar 2026 09:06:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kerigan Creighton <kerigancreighton@gmail.com>
Cc: linux-wireless@vger.kernel.org, loic.poulain@oss.qualcomm.com, 
	wcn36xx@lists.infradead.org, andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] remoteproc: qcom_wcnss_iris: add support for
 WCN3610
Message-ID: <20260305-crouching-sceptical-spoonbill-fe75fb@quoll>
References: <20260305003253.1022386-1-kerigancreighton@gmail.com>
 <20260305003253.1022386-3-kerigancreighton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305003253.1022386-3-kerigancreighton@gmail.com>
X-Rspamd-Queue-Id: 90BD420D1F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32498-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:32:52PM -0600, Kerigan Creighton wrote:
> Add a qcom,wcn3610 compatible string.
> The WCN3610 shares the same register configuration as the
> WCN3620, so its configuration is being reused.
> 
> Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
>  - Move remoteproc compatible string addition to the middle of 
>    the patch set.
>  - Add Reviewed-by Dmitry (thanks!)
> ---
>  drivers/remoteproc/qcom_wcnss_iris.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
> index 2b89b4db6c..e58b59355f 100644
> --- a/drivers/remoteproc/qcom_wcnss_iris.c
> +++ b/drivers/remoteproc/qcom_wcnss_iris.c
> @@ -95,6 +95,7 @@ void qcom_iris_disable(struct qcom_iris *iris)
>  }
>  
>  static const struct of_device_id iris_of_match[] = {
> +	{ .compatible = "qcom,wcn3610", .data = &wcn3620_data },

So compatible with wcn3620? Why are you adding it in such case? Drop the
change and express compatibility or explain lack of it in the bindings
patch.

Best regards,
Krzysztof


