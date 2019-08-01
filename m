Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFDF7E061
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfHAQl6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 12:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfHAQl6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 12:41:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 705DE20838;
        Thu,  1 Aug 2019 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564677717;
        bh=eknL7DZfqIIEbpkvgdNMFNcQaCK/jHKsF7wcP4BIOds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAIqnerPahMJKZjbSHzoUVBG2mp4T4FpNqDN0ezjnGErWygQo8dPbjCRcAXKM4liH
         60YSE+Kn2cL5A9wHGQ/DVP8nGycaujtGZ5NUWTSC0mgYUhrJ5i3ZMRXROjvXtuAbKF
         Gn001hEEfhrKfO4B31HxECK2GO0IS2otXEQGDAhs=
Date:   Thu, 1 Aug 2019 18:41:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adham.Abozaeid@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        johannes@sipsolutions.net, Ajay.Kathat@microchip.com
Subject: Re: [PATCH] staging: wilc1000: merge drv_handle and operation_mode
 wids
Message-ID: <20190801164155.GA14688@kroah.com>
References: <20190731205245.6590-1-adham.abozaeid@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731205245.6590-1-adham.abozaeid@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 31, 2019 at 08:58:19PM +0000, Adham.Abozaeid@microchip.com wrote:
> From: Adham Abozaeid <adham.abozaeid@microchip.com>
> 
> wilc_set_wfi_drv_handler and wilc_set_operation_mode sends the same
> parameters to the FW, so it's better to combine them together.
> 
> Kept wilc_set_wfi_drv_handler implementation since it sends all the
> required parameters, and renamed it to wilc_set_operation_mode to be
> more descriptive.
> 
> Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
> ---
>  drivers/staging/wilc1000/wilc_hif.c           | 29 ++-----------------
>  drivers/staging/wilc1000/wilc_hif.h           |  5 ++--
>  drivers/staging/wilc1000/wilc_netdev.c        |  6 ++--
>  .../staging/wilc1000/wilc_wfi_cfgoperations.c | 24 +++++++--------
>  drivers/staging/wilc1000/wilc_wlan_if.h       |  3 +-
>  5 files changed, 20 insertions(+), 47 deletions(-)

This patch causes the following build error:
drivers/staging/wilc1000/wilc_hif.c: In function wilc_deinit:
drivers/staging/wilc1000/wilc_hif.c:1610:2: error: implicit declaration of function wilc_set_wfi_drv_handler [-Werror=implicit-function-declaration]
 1610 |  wilc_set_wfi_drv_handler(vif, 0, 0, 0);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~

Always test build your patches...
