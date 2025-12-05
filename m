Return-Path: <linux-wireless+bounces-29531-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE81CA6552
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 08:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E044C30600B1
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 07:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018482F7ADF;
	Fri,  5 Dec 2025 07:11:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E752F83AE
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 07:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918684; cv=none; b=BmqTdj1HCXJ0t3zsTCsYlpGxN3qT8Hn7yD8R7MccmIIqmjMI62YiosOaDiInBKWc4sL9SzrpjViIpYIXwCwjYAPnA0Bp3yjdlYBnR0JIEGyPeMQUXEXr0k3JWAyNxC7PAlvdvY0NRkVR9vDxhcbsqqz7NgBNi80TPuZkDl8g2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918684; c=relaxed/simple;
	bh=qhVZMj8dnVEdwEx29MoL5SXaQkamnCVcN+K3snNoWb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfUztGhsne4DhMXW74M2rudTPEOoxWTH3J+6MRqgulYHL3+EIDgZl57TCOygzRD5day+HPwJpzeLFjP8BKQ7QmsoSmPPnRM3kx0jkPR0X8gXIeDKX1nZuozTILZysmwKlC00RHTG5dPKhx8SVEsh9PGCdO/IviHGdtUFKIHMYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1vRPyE-0003nt-G8; Fri, 05 Dec 2025 08:11:14 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1vRPyC-0045J2-3D;
	Fri, 05 Dec 2025 08:11:13 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1vRPyC-007Ogf-2k;
	Fri, 05 Dec 2025 08:11:12 +0100
Date: Fri, 5 Dec 2025 08:11:12 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v8 12/22] wifi: nxpwifi: introduce command and event
 handling infrastructure
Message-ID: <aTKFkOPTgrbZEPRn@pengutronix.de>
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
 <20251205065545.3325032-13-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205065545.3325032-13-jeff.chen_1@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Jeff,

On Fri, Dec 05, 2025 at 02:55:35PM +0800, Jeff Chen wrote:
> +
> +	/* Check init command response */
> +	if (adapter->hw_status == NXPWIFI_HW_STATUS_INITIALIZING) {
> +		if (ret) {
> +			nxpwifi_dbg(adapter, ERROR,
> +				    "%s: cmd %#x failed during\t"
> +				    "initialization\n", __func__, cmdresp_no);
> +			nxpwifi_init_fw_complete(adapter);
> +			return ret;
> +		} else if (adapter->last_init_cmd == cmdresp_no) {
> +			adapter->hw_status = NXPWIFI_HW_STATUS_INIT_DONE;
> +		}
> +	}

As said before, please drop this asynchronous initialization stuff.

A patch doing this for the mxiwiex driver is here:

https://lore.kernel.org/all/20241202-mwifiex-cleanup-1-v3-12-317a6ce0dd5b@pengutronix.de/

It will apply nearly as-is to the nxpwifi driver and it's much easier to
do this before it hits mainline.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

