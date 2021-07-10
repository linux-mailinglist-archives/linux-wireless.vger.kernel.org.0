Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D516A3C3315
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jul 2021 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhGJFan (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jul 2021 01:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhGJFam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jul 2021 01:30:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DEC0613DD
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jul 2021 22:27:58 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m25Wr-0001ko-P5; Sat, 10 Jul 2021 07:27:53 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1m25Wr-0001RK-4a; Sat, 10 Jul 2021 07:27:53 +0200
Date:   Sat, 10 Jul 2021 07:27:53 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 13/24] rtw89: 8852a: add 8852a specific files
Message-ID: <20210710052753.GA485@pengutronix.de>
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210618064625.14131-14-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210618064625.14131-14-pkshih@realtek.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:14:10 up 131 days, 14:49, 116 users,  load average: 0.36, 0.26,
 0.27
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 18, 2021 at 02:46:14PM +0800, Ping-Ke Shih wrote:
> +static struct rtw89_hfc_param_ini rtw8852a_hfc_param_ini_pcie[] = {
> +	[RTW89_QTA_SCC] = {rtw8852a_hfc_chcfg_pcie, &rtw8852a_hfc_pubcfg_pcie,
> +			   &rtw_hfc_preccfg_pcie, RTW89_HCIFC_POH},
> +	[RTW89_QTA_DBCC] = {rtw8852a_hfc_chcfg_pcie, &rtw8852a_hfc_pubcfg_pcie,
> +			    &rtw_hfc_preccfg_pcie, RTW89_HCIFC_POH},
> +	[RTW89_QTA_SCC_STF] = {rtw8852a_hfc_chcfg_pcie_stf,
> +			       &rtw8852a_hfc_pubcfg_pcie_stf,
> +			       &rtw_hfc_preccfg_pcie_stf, RTW89_HCIFC_STF},
> +	[RTW89_QTA_DBCC_STF] = {rtw8852a_hfc_chcfg_pcie_stf,
> +				&rtw8852a_hfc_pubcfg_pcie_stf,
> +				&rtw_hfc_preccfg_pcie_stf, RTW89_HCIFC_STF},
> +	[RTW89_QTA_SU_TP] = {rtw8852a_hfc_chcfg_pcie_sutp,
> +			     &rtw8852a_hfc_pubcfg_pcie_sutp,
> +			     &rtw_hfc_preccfg_pcie, RTW89_HCIFC_POH},
> +	[RTW89_QTA_DLFW] = {NULL, NULL, &rtw_hfc_preccfg_pcie, RTW89_HCIFC_POH},
> +	[RTW89_QTA_LAMODE] = {rtw8852a_hfc_chcfg_pcie_la,
> +			      &rtw8852a_hfc_pubcfg_pcie_la,
> +			      &rtw_hfc_preccfg_pcie, RTW89_HCIFC_POH},
> +	[RTW89_QTA_INVALID] = {NULL},
> +};
> +
> +static struct rtw89_dle_mem rtw8852a_dle_mem_pcie[] = {
> +	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &wde_size0, &ple_size0, &wde_qt0,
> +			    &wde_qt0, &ple_qt4, &ple_qt5},
> +	[RTW89_QTA_DBCC] = {RTW89_QTA_DBCC, &wde_size0, &ple_size0, &wde_qt0,
> +			    &wde_qt0, &ple_qt0, &ple_qt1},
> +	[RTW89_QTA_SCC_STF] = {RTW89_QTA_SCC_STF, &wde_size1, &ple_size2,
> +			       &wde_qt1, &wde_qt1, &ple_qt8, &ple_qt9},
> +	[RTW89_QTA_DBCC_STF] = {RTW89_QTA_DBCC_STF, &wde_size1, &ple_size2,
> +				&wde_qt1, &wde_qt1, &ple_qt10, &ple_qt11},
> +	[RTW89_QTA_SU_TP] = {RTW89_QTA_SU_TP, &wde_size3, &ple_size3,
> +			     &wde_qt3, &wde_qt3, &ple_qt12, &ple_qt12},
> +	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &wde_size4, &ple_size4,
> +			    &wde_qt4, &wde_qt4, &ple_qt13, &ple_qt13},
> +	[RTW89_QTA_LAMODE] = {RTW89_QTA_LAMODE, &wde_size10, &ple_size10,
> +			      &wde_qt9, &wde_qt9, &ple_qt23, &ple_qt24},
> +	[RTW89_QTA_INVALID] = {RTW89_QTA_INVALID, NULL, NULL, NULL, NULL, NULL,
> +			       NULL},
> +};

IF I see it correctly, only some of this RTW89_QTA_* modes are actually
used.
If this modes are not used by the current state of the driver, please
remove it.

RTW89_QTA_SCC, RTW89_QTA_DLFW and RTW89_QTA_INVALID - are requested
RTW89_QTA_DBCC, RTW89_QTA_SU_TP - not used. If so, please remove.
RTW89_QTA_SCC_STF, RTW89_QTA_DBCC_STF and RTW89_QTA_LAMODE - kind of used but
never set/requested? If so, please remove the modes and the code which
depends on it. For example dle_rsvd_size() is executed if RTW89_QTA_LAMODE is
set, but I can find any play where it is actually set.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
