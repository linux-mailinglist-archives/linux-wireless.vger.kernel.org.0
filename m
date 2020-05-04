Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53B1C3351
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 09:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEDHJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 03:09:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49419 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgEDHJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 03:09:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200504070924euoutp024210189e70665e8f7cea426ff79b731e~LwZr3Kfwz2287822878euoutp027
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 07:09:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200504070924euoutp024210189e70665e8f7cea426ff79b731e~LwZr3Kfwz2287822878euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1588576164;
        bh=VtOpu5X3uB4NzT/4wolwk7hNOmggXQ7mv6Gswxpv0Mk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iBENbkJrmIxg+O2e8pxRHQOxqu3HQmW6MKEzijniOyZznkrWijxbdwSoK0wVCjaBx
         3LgqUK3OLREuaTUVzd8ME81E74r/gKYV5BxNxwI2SsDOwOeRgLZL6dIKavTxybhqwE
         EhiwrWxHMRMOzELap5AhgDTPkS+NOef1kF7dsmiM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200504070924eucas1p29205209e0bcde54dd0e099d11c045780~LwZrq_bm-0841308413eucas1p2F;
        Mon,  4 May 2020 07:09:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 09.AC.60679.4AFBFAE5; Mon,  4
        May 2020 08:09:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200504070924eucas1p15ab260a66dc51c3a2d4213af1045927c~LwZrNHsqW2246722467eucas1p1s;
        Mon,  4 May 2020 07:09:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200504070924eusmtrp19859cfee3cca65bc64094885861152f9~LwZrMalOP2122621226eusmtrp1a;
        Mon,  4 May 2020 07:09:24 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-98-5eafbfa40ab1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.62.07950.4AFBFAE5; Mon,  4
        May 2020 08:09:24 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200504070923eusmtip1e020cbf71e0205115ca1426a5793fb50~LwZqzux2f2235922359eusmtip1r;
        Mon,  4 May 2020 07:09:23 +0000 (GMT)
Subject: Re: [PATCH 5/6] thermal: core: introduce tz_disabled() helper
 function
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, andrzej.p@collabora.com, luca@coelho.fi
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4aa6fd7d-9e0c-614a-88e9-0e2637a114d4@samsung.com>
Date:   Mon, 4 May 2020 09:09:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200430063229.6182-6-rui.zhang@intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djP87pL9q+PM/h+Ucli2eN7LBbzPsta
        fO49wmjxZsUddosZ52exWzx52MfmwObxcNdsNo8dd5cweize85LJ4861PWwenzfJBbBGcdmk
        pOZklqUW6dslcGX07L7AVrBcuOLFf+0Gxn/8XYycHBICJhIdvyYydTFycQgJrGCUOP66jxXC
        +cIosbzxGBuE85lR4sH+ycwwLZ93NLJAJJYzShy9/RksISTwllHi+iKOLkYODmGBQInzSyVB
        wiICyhKLzm1lBLGZBZoYJb4fKwCx2QSsJCa2rwKL8wrYSRz5/ogdxGYRUJH4uOIkmC0qECHx
        6cFhVogaQYmTM5+wgNicAhYST78fhZopLnHryXwmCFteYvvbOcwgt0kIrGOX2PD3FDvE0S4S
        ncfnQtnCEq+Ob4GyZSROT+5hgWpglPjb8QKqezvQ/5P/sUFUWUvcOfeLDeQzZgFNifW79CHC
        jhJrW1Ywg4QlBPgkbrwVhDiCT2LStulQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSvzULy
        ziwk78xC2LuAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYNI5/e/4lx2Mu/4kHWIU
        4GBU4uF98HldnBBrYllxZe4hRgkOZiUR3h0t6+OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xov
        ehkrJJCeWJKanZpakFoEk2Xi4JRqYCzcd61qSUv2ysS70m/YEi+5ZrYuLZgv8inn7ZNnj/S1
        p5b5fSp8P3tTh5PBHU3VCRteXzs8ccr7D4+ME/6dm5i/PMx7/cMdpZfVb4aeP7lhtQjfBDnu
        a50lq3vtV7/4tkg37M8El9tcEyblLDD9JZf1x2nTJInfXz/oyG+Qmy3RGWe0bNF15f1WSizF
        GYmGWsxFxYkAaXjgFjYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7pL9q+PM/h3mdVi2eN7LBbzPsta
        fO49wmjxZsUddosZ52exWzx52MfmwObxcNdsNo8dd5cweize85LJ4861PWwenzfJBbBG6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GX07L7AVrBc
        uOLFf+0Gxn/8XYycHBICJhKfdzSydDFycQgJLGWU+Pb2PZDDAZSQkTi+vgyiRljiz7UuNoia
        14wStx8eZwSpERYIlDi/VBKkRkRAWWLRua2MIDXMAk2MEs+fn2SFaNjJKHFj5hI2kCo2ASuJ
        ie2rGEFsXgE7iSPfH7GD2CwCKhIfV5wEs0UFIiQO75gFVSMocXLmExYQm1PAQuLp96NgcWYB
        dYk/8y4xQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO9
        4sTc4tK8dL3k/NxNjMA423bs55YdjF3vgg8xCnAwKvHwPvi8Lk6INbGsuDL3EKMEB7OSCO+O
        lvVxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTAF5JfGGpobmFpaG5sbmxmYWSuK8HQIH
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoYj1wOn7E9J3N1iOvr4zfOXdZelaQ2Y+Uq89XJN56c0Tui
        euO6354+qdY9Xy/U/upJ2cK9WHZ20Aqf/twrgQelvs11v9VkzHr7bUxfU/v9DYJrVmjFlLTL
        erO8ktqs9bl1P/dkhhye77F5NXIBHG7xYc+dpgoaRSxb/q42gGfFEgWrbI49p6fJK7EUZyQa
        ajEXFScCAFz2Bn/JAgAA
X-CMS-MailID: 20200504070924eucas1p15ab260a66dc51c3a2d4213af1045927c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200430062922eucas1p288a6f222286b4293b32272a3da1166ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200430062922eucas1p288a6f222286b4293b32272a3da1166ab
References: <20200430063229.6182-1-rui.zhang@intel.com>
        <CGME20200430062922eucas1p288a6f222286b4293b32272a3da1166ab@eucas1p2.samsung.com>
        <20200430063229.6182-6-rui.zhang@intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 4/30/20 8:32 AM, Zhang Rui wrote:
> Rename should_stop_polling() to tz_disabled(), and make it global.
> Because there are platform thermal drivers which also need this.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 17 ++++++++---------
>  include/linux/thermal.h        |  2 ++
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 5f7a867..1cd5d5d0 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -305,16 +305,9 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>  		cancel_delayed_work(&tz->poll_queue);
>  }
>  
> -static inline bool should_stop_polling(struct thermal_zone_device *tz)
> -{
> -	return thermal_zone_device_get_mode(tz) == THERMAL_DEVICE_DISABLED;
> -}
> -
>  static void monitor_thermal_zone(struct thermal_zone_device *tz)
>  {
> -	bool stop;
> -
> -	stop = should_stop_polling(tz);
> +	bool stop = tz_disabled(tz);
>  
>  	mutex_lock(&tz->lock);
>  
> @@ -502,12 +495,18 @@ int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_set_mode);
>  
> +bool tz_disabled(struct thermal_zone_device *tz)
> +{
> +	return thermal_zone_device_get_mode(tz) == THERMAL_DEVICE_DISABLED;
> +}
> +EXPORT_SYMBOL(tz_disabled);

Is there actual reason to not make it _GPL?

[ all other thermal core functionality seems to be _GPL anyway ]

Otherwise the patch looks fine:

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> +
>  void thermal_zone_device_update(struct thermal_zone_device *tz,
>  				enum thermal_notify_event event)
>  {
>  	int count;
>  
> -	if (should_stop_polling(tz))
> +	if (tz_disabled(tz))
>  		goto update_polling;
>  
>  	if (atomic_read(&in_suspend))
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a87fbaf..0bc62ee 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -479,4 +479,6 @@ static inline int thermal_zone_device_disable(struct thermal_zone_device *tz)
>  	return thermal_zone_device_set_mode(tz, THERMAL_DEVICE_DISABLED);
>  }
>  
> +bool tz_disabled(struct thermal_zone_device *tz);
> +
>  #endif /* __THERMAL_H__ */
> 

