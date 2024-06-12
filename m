Return-Path: <linux-wireless+bounces-8882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8A9905359
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379681F23DFE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946D179663;
	Wed, 12 Jun 2024 13:11:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96415178CE2
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197896; cv=none; b=kEgJiHEJECYa1RfloCZWEmeN2Uw98yX7Tj1yRby9DtPkvg0eDj19b5pDX3g5JuXlzmMcEGnPsMS1NK988p3L/b84wP7Ik1DSyvjwhbVuiogqFbu0kJt+4ooaf3ti1iGFaoVFe/DM3ugEZ5VQrdAFBbBheAcFtaX5AuS5HSRzHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197896; c=relaxed/simple;
	bh=czAqBHpoC4R18fkt9IcXsTUqM0PCW2MD+urROxhSelU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsiCACpmu8RtDl2LEyCn2aRTXnFMMQPJInWXgTk+BixDYOSpbLEPfBV/HA24LXN1AuTI2R36zgwNwwcznWJQ3eftjKsOQ6LsGSFvtJURDqAiXFnYJnO9H233Y4kZARyIgibSIv08wjAFMgGocdA4VLGwm1bNFHDrhr4SCUfj5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sHNlE-0000Qm-Qz; Wed, 12 Jun 2024 15:11:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sHNlD-001nKm-V2; Wed, 12 Jun 2024 15:11:31 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sHNlD-0084Du-2p;
	Wed, 12 Jun 2024 15:11:31 +0200
Date: Wed, 12 Jun 2024 15:11:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP mode
Message-ID: <Zmmeg15YQtiChZ70@pengutronix.de>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-3-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418060626.431202-3-yu-hao.lin@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi David,

On Thu, Apr 18, 2024 at 02:06:26PM +0800, David Lin wrote:
> Add host based MLME to enable WPA3 functionalities in AP mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> 

> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> index 491e36611909..073c665183b3 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> @@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
>  				bss_config->key_mgmt = KEY_MGMT_PSK;
>  			}
>  			break;
> +		case WLAN_AKM_SUITE_SAE:
> +			bss_config->protocol = PROTOCOL_WPA2;
> +			bss_config->key_mgmt = KEY_MGMT_SAE;
> +			break;

Shouldn't this be |= PROTOCOL_WPA2 and |= KEY_MGMT_SAE?
Clearing the other flags when SAE is enabled looks wrong to me.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

