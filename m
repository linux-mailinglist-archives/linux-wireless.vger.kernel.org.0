Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA01EF5CF
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgFEKxa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgFEKxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 06:53:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06475C08C5C2
        for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2020 03:53:30 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jh9ya-0002Rg-5X; Fri, 05 Jun 2020 12:53:28 +0200
Date:   Fri, 5 Jun 2020 12:53:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        tehuang@realtek.com
Subject: Re: [PATCH v2 1/5] rtw88: 8821c: add cck pd settings
Message-ID: <20200605105328.2anlgi3tkclknj4y@linutronix.de>
References: <20200603094218.19942-1-yhchuang@realtek.com>
 <20200603094218.19942-2-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603094218.19942-2-yhchuang@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-03 17:42:14 [+0800], yhchuang@realtek.com wrote:
> @@ -596,6 +597,29 @@ static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
>  	rtw8821c_do_iqk(rtwdev);
>  }
>  
> +static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
> +{
> +	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
> +	u8 pd[CCK_PD_LV_MAX] = {3, 7, 13, 13, 13};
> +
> +	if (dm_info->min_rssi > 60) {
> +		new_lvl = 4;
> +		pd[4] = 0x1d;
replace 4 with CCK_PD_LV4 ?

> +		goto set_cck_pd;
> +	}

Sebastian
