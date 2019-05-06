Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75857146A0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfEFIng (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 04:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfEFIng (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 04:43:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 319603087931;
        Mon,  6 May 2019 08:43:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCD2160A98;
        Mon,  6 May 2019 08:43:35 +0000 (UTC)
Date:   Mon, 6 May 2019 10:42:21 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: Re: [PATCH 5.1] rtw88: fix subscript above array bounds compiler
 warning
Message-ID: <20190506084221.GB2714@redhat.com>
References: <20190506073917.10106-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506073917.10106-1-sgruszka@redhat.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 06 May 2019 08:43:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is for 5.2 and v2 obviously.

Stanislaw

On Mon, May 06, 2019 at 09:39:17AM +0200, Stanislaw Gruszka wrote:
> My compiler complains about:
> 
> drivers/net/wireless/realtek/rtw88/phy.c: In function ???rtw_phy_rf_power_2_rssi???:
> drivers/net/wireless/realtek/rtw88/phy.c:430:26: warning: array subscript is above array bounds [-Warray-bounds]
>   linear = db_invert_table[i][j];
> 
> According to comment power_db should be in range 1 ~ 96 .
> To fix add check for boundaries before access the array.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> ---
> RFC -> v1
> - add check before accessing the array insted of
>   rtw_phy_power_2_db() change.
> v1 -> v2:
> - return 1 for power_db < 1
> 
>  drivers/net/wireless/realtek/rtw88/phy.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
> index 4381b360b5b5..9ca52a4d025a 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -423,6 +423,11 @@ static u64 rtw_phy_db_2_linear(u8 power_db)
>  	u8 i, j;
>  	u64 linear;
>  
> +	if (power_db > 96)
> +		power_db = 96;
> +	else if (power_db < 1)
> +		return 1;
> +
>  	/* 1dB ~ 96dB */
>  	i = (power_db - 1) >> 3;
>  	j = (power_db - 1) - (i << 3);
> -- 
> 2.20.1
> 
