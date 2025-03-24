Return-Path: <linux-wireless+bounces-20736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27FA6D486
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 08:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611C51891246
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 07:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9199123F37E;
	Mon, 24 Mar 2025 07:02:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B623ED76
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799746; cv=none; b=tc9yfQgMiuAgQTYmb03FiK12Y4aembdZiQ2Oc8ygxSzfJrnWTMeLuklgSSHxo4KqeXmYxl4UjDiapzwInNsoMAsYvpV63m/OnsA8MGPnglgty91RtKVuOEZyHmNUfcKCteo9c2YFI3n3lnGS4NCdD7UfIot4oFsUMyOPhcX8WZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799746; c=relaxed/simple;
	bh=HJqDwxWZVfqlU6dfLTGTpVmjksKf0kH6KxaX8CWxnQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ4UhrYeZUML5vSiJeiDK7bjQYV0hK/a1dwJJRD0bzL9KLVt/jdPowDUSfBdwhf/6DbrD5Vb7jR0l/2vqWX8G5+slDwXKHaj14kPdFZKtJKkAG8pSkX4b1NaP2qvWqPGAub0uwuMx+OOwsOZns+Ucc/tPB7reqe6AilWgfREImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1twbp9-0007gH-IM; Mon, 24 Mar 2025 08:02:15 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1twbp8-001Miw-1t;
	Mon, 24 Mar 2025 08:02:15 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1twbp8-00DqVk-2w;
	Mon, 24 Mar 2025 08:02:14 +0100
Date: Mon, 24 Mar 2025 08:02:14 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, johannes@sipsolutions.net,
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v4 2/2] wifi: mwifiex: Fix RF calibration data download
 from file
Message-ID: <Z-EDdrA4s5GvHKvB@pengutronix.de>
References: <20250220061143.1417420-2-jeff.chen_1@nxp.com>
 <20250318050739.2239376-3-jeff.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318050739.2239376-3-jeff.chen_1@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Tue, Mar 18, 2025 at 01:07:39PM +0800, Jeff Chen wrote:
> This patch resolves an issue where RF calibration data from a
> file could not be downloaded to the firmware. The feature to
> download calibration data from a file was broken by the commit:
> d39fbc88956e.
> 
> The issue arose because the function `mwifiex_cmd_cfg_data()`
> was modified in a way that prevented proper handling of
> file-based calibration data. While this patch restores the ability
> to download RF calibration data from a file, it may inadvertently
> break the feature to download calibration data from the device
> tree. This is because the function `mwifiex_dnld_dt_cfgdata()`,
> which also relies on `mwifiex_cmd_cfg_data()`, is still used for
> device tree-based calibration data downloads.
> 
> Fixes: d39fbc88956e ("mwifiex: remove cfg_data construction")
> Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/fw.h      | 14 ++++++++++++++
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 11 +++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> index 4a96281792cc..91458f3bd14a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -454,6 +454,11 @@ enum mwifiex_channel_flags {
>  #define HostCmd_RET_BIT                       0x8000
>  #define HostCmd_ACT_GEN_GET                   0x0000
>  #define HostCmd_ACT_GEN_SET                   0x0001
> +#define HOST_CMD_ACT_GEN_SET                  0x0001
> +/* Add this non-CamelCase-style macro to comply with checkpatch requirements.
> + *  This macro will eventually replace all existing CamelCase-style macros in
> + *  the future for consistency.
> + */

Just ignore this checkpatch warning. We don't want to have duplicated
defines just for silencing checkpatch. If anything we could change all
the CamelCase defines throughout the driver in one go.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

