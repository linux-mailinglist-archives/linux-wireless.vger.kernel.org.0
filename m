Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514BE1BF360
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 10:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD3Ir1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 04:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgD3Ir1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 04:47:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC7C035494;
        Thu, 30 Apr 2020 01:47:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 5D09E2A0A59
Subject: Re: [PATCH 2/6] thermal: core: delete thermal_notify_framework()
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, daniel.lezcano@linaro.org,
        b.zolnierkie@samsung.com, luca@coelho.fi
References: <20200430063229.6182-1-rui.zhang@intel.com>
 <20200430063229.6182-3-rui.zhang@intel.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <f6d7dcae-ccf1-eee1-2ac1-eaa8472e2f87@collabora.com>
Date:   Thu, 30 Apr 2020 10:47:22 +0200
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

Thanks for the series,

W dniu 30.04.2020 o 08:32, Zhang Rui pisze:
> Delete thermal_notify_framework() as there is no user of it.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>   drivers/thermal/thermal_core.c | 18 ------------------
>   include/linux/thermal.h        |  4 ----
>   2 files changed, 22 deletions(-)
> 

git grep thermal_notify_framework
Documentation/driver-api/thermal/sysfs-api.rst:4.3. thermal_notify_framework

Should the documentation be still documenting a non-existent function?

BTW, get_tz_trend() is only used in drivers/thermal/step_wise.c,
but is still exported with EXPORT_SYMBOL(). Probably does not need to
be exported anymore.

Andrzej
