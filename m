Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F392B1C369B
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEDKSX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgEDKSW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 06:18:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F423BC061A0E;
        Mon,  4 May 2020 03:18:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 77A722A0E4B
Subject: Re: [PATCH 2/6] thermal: core: delete thermal_notify_framework()
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        b.zolnierkie@samsung.com, luca@coelho.fi
References: <20200430063229.6182-1-rui.zhang@intel.com>
 <20200430063229.6182-3-rui.zhang@intel.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <3553b981-3aa7-b45b-85f8-21bc97f14026@collabora.com>
Date:   Mon, 4 May 2020 12:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430063229.6182-3-rui.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Rui,

W dniu 30.04.2020 o 08:32, Zhang Rui pisze:
> Delete thermal_notify_framework() as there is no user of it.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Provided that PATCH 1/6 is applied:

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   drivers/thermal/thermal_core.c | 18 ------------------
>   include/linux/thermal.h        |  4 ----
>   2 files changed, 22 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 03c4d8d..ac70545 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -532,24 +532,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>   }
>   EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>   
> -/**
> - * thermal_notify_framework - Sensor drivers use this API to notify framework
> - * @tz:		thermal zone device
> - * @trip:	indicates which trip point has been crossed
> - *
> - * This function handles the trip events from sensor drivers. It starts
> - * throttling the cooling devices according to the policy configured.
> - * For CRITICAL and HOT trip points, this notifies the respective drivers,
> - * and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
> - * The throttling policy is based on the configured platform data; if no
> - * platform data is provided, this uses the step_wise throttling policy.
> - */
> -void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
> -{
> -	handle_thermal_trip(tz, trip);
> -}
> -EXPORT_SYMBOL_GPL(thermal_notify_framework);
> -
>   static void thermal_zone_device_check(struct work_struct *work)
>   {
>   	struct thermal_zone_device *tz = container_of(work, struct
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index c789d4f..a87fbaf 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -420,7 +420,6 @@ int thermal_zone_get_slope(struct thermal_zone_device *tz);
>   int thermal_zone_get_offset(struct thermal_zone_device *tz);
>   
>   void thermal_cdev_update(struct thermal_cooling_device *);
> -void thermal_notify_framework(struct thermal_zone_device *, int);
>   #else
>   static inline struct thermal_zone_device *thermal_zone_device_register(
>   	const char *type, int trips, int mask, void *devdata,
> @@ -468,9 +467,6 @@ static inline int thermal_zone_get_offset(
>   
>   static inline void thermal_cdev_update(struct thermal_cooling_device *cdev)
>   { }
> -static inline void thermal_notify_framework(struct thermal_zone_device *tz,
> -	int trip)
> -{ }
>   #endif /* CONFIG_THERMAL */
>   
>   static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
> 

