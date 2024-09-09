Return-Path: <linux-wireless+bounces-12710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0897242C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 23:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C1FB22606
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A199E18B481;
	Mon,  9 Sep 2024 21:05:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D202189BB6
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915938; cv=none; b=KAkO6V1BvUdpjxEMD/9Dw41lnYzI+9o0z1jcjI3Gb8AADYEZpY3L0tyFK8Qx1KhCBs7X2puOmaI+kEGsP6QZE95hHGHF1e2ypjDQxVukFWfSX2QLaVYT5FS6cWhJozgEAEDTHSZbgNI/8lRUIhuI7VY88n8DQptH8CEAman3tVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915938; c=relaxed/simple;
	bh=GWRWkD0vD0rEcpyDcklSB5fPJ3NDtRFkOg790q8QuJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/kAMjzB6msV/iPIeMOeEVGr8NSerlne/Qrg8VnkZ9qE6/72t94LxZdQxR0gBxMoVHadJC6Qw9qlEv0L9qxV/vAeiPDtMoAXJ2z6coI5usHR5pGmR4SEqGELdKqnxL10noW8GD1Ovwt4XZXa9BK1iEyqfcuIkICHUOjzYzsSRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1snlZf-0002Dt-Ks; Mon, 09 Sep 2024 23:05:27 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1snlZe-006jwG-Ff; Mon, 09 Sep 2024 23:05:26 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1snlZe-00FolA-1F;
	Mon, 09 Sep 2024 23:05:26 +0200
Date: Mon, 9 Sep 2024 23:05:26 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v2] wifi: mwifiex: avoid AP and STA running on different
 channel
Message-ID: <Zt9jFpyptX_ftH-p@pengutronix.de>
References: <20240902084311.2607-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902084311.2607-1-yu-hao.lin@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Mon, Sep 02, 2024 at 04:43:11PM +0800, David Lin wrote:
> Current firmware doesn't support AP and STA running on different
> channels simultaneously.
> FW crash would occur in such case.
> This patch avoids the issue by disabling AP and STA to run on
> different channels.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> ---
> 
> v2:
>    - clean up code.
> 
> ---
>  .../net/wireless/marvell/mwifiex/cfg80211.c   | 17 ++++---
>  drivers/net/wireless/marvell/mwifiex/util.c   | 44 +++++++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/util.h   | 13 ++++++
>  3 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index 722ead51e912..3dbcab463445 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -781,11 +781,9 @@ mwifiex_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
>  		break;
>  
>  	case MWIFIEX_BSS_ROLE_STA:
> -		if (priv->media_connected) {
> -			mwifiex_dbg(adapter, ERROR,
> -				    "cannot change wiphy params when connected");
> -			return -EINVAL;
> -		}
> +		if (priv->media_connected)
> +			break;

This hunk seems unrelated to this patch. If this is needed then it
deserves an extra patch along with an explanation why this is necessary.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

