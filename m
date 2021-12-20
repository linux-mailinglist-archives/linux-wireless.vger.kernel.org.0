Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3A947B314
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 19:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhLTSoS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 13:44:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52834 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhLTSoS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 13:44:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01C85B81084;
        Mon, 20 Dec 2021 18:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0B7C36AE7;
        Mon, 20 Dec 2021 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640025855;
        bh=UMPDFKVS0LM0oehPWCcne4pGYk2PvYD9Oz8t3gyLsCo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aEfECKyNPAlhNgEJ8X5/J8/+AMxyuJNGbCmUg4xjwBI83QAu1jHd985RokLXg3gvN
         jHm2YuNYKDdWCd8iV+oQ4UdYbsFPTQ2iULyuwZepYVG12T9e4G3zmf3IW0+MpCVzdC
         QtGsuvCi/9c7g2gvtCEJtjQ7mlSAFulCag1XAWBI5UtfBN5Hlnn/Se8kMhDmWGmgov
         nMwT9xeEINRmsUGS9KZvuwAuGIxR48GhTWk+bVn6mOenpEqPMxmOuFpDQ9YRec2s8G
         P+vXZrR9EDHiYEyV//3v5pJQiEH/9IOxsx4wiaf+d0gXCT7f6UjXwzvNfh1kqR9ynq
         t+AyUySNr2gIA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wilc1000: fix double free error in probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211217150311.GC16611@kili>
References: <20211217150311.GC16611@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164002585215.16553.7189611104055917408.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 18:44:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Smatch complains that there is a double free in probe:
> 
> drivers/net/wireless/microchip/wilc1000/spi.c:186 wilc_bus_probe() error: double free of 'spi_priv'
> drivers/net/wireless/microchip/wilc1000/sdio.c:163 wilc_sdio_probe() error: double free of 'sdio_priv'
> 
> The problem is that wilc_netdev_cleanup() function frees "wilc->bus_data".
> That's confusing and a layering violation.  Leave the frees in probe(),
> delete the free in wilc_netdev_cleanup(), and add some new frees to the
> remove() functions.
> 
> Fixes: dc8b338f3bcd ("wilc1000: use goto labels on error path")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Patch applied to wireless-drivers-next.git, thanks.

4894edacfa93 wilc1000: fix double free error in probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211217150311.GC16611@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

