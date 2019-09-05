Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C4A9BFE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfIEHiH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 03:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbfIEHiH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 03:38:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E3002145D;
        Thu,  5 Sep 2019 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567669086;
        bh=ZjDzOuega+mZVAiWkRReiyj0ameJrbOP0VlkJ/bmbHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O8EEpYh9e5eOQ0wS8ipE22a+dMMtSpWPNldVVR276PKiAfZtE5krHTBVib/he7UGR
         8ZB5MmdGAKuDwNjKsZarYVv30EwTDE1QIsooaPofhpz5+29BD40+6q7eNplCHDyRE+
         GUlYOJT4hPOJpZdl+vRomxQ2256a0wbzTp7JFs0o=
Date:   Thu, 5 Sep 2019 09:38:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugen.Hristev@microchip.com
Cc:     Adham.Abozaeid@microchip.com, Ajay.Kathat@microchip.com,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: wilc1000: look for rtc_clk clock
Message-ID: <20190905073804.GA30881@kroah.com>
References: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
 <1567603548-13355-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567603548-13355-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 04, 2019 at 01:34:01PM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> If rtc_clk is provided from DT, use it and enable it.
> This is optional.
> The signal may be hardcoded and no need to be requested,
> but if DT provides it, use it.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Acked-by: Ajay Singh <ajay.kathat@microchip.com>
> ---
>  drivers/staging/wilc1000/wilc_sdio.c          | 14 ++++++++++++++
>  drivers/staging/wilc1000/wilc_wfi_netdevice.h |  1 +
>  2 files changed, 15 insertions(+)

This patch does not apply to my tree at all.

Please redo it against staging-next and resend the series, with Ajay's
ack added to it.

thanks,

greg k-h
