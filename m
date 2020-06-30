Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B21D20F539
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgF3M6M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388062AbgF3M56 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 08:57:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8230AC03E97E
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 05:57:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so17020094wrw.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2020 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WwiCRMR/atAzHQdqmr8uQelMa6OcJuGWGuwIRfhRdfs=;
        b=PjtHdZDyhsfzOMknUBCzAw98LBJLOT+lMKu8FyLjhCUmY5zqFEKQjOpc0es34kiYw7
         TEnUSoSJ3f61hHZTPcBVtChXqTKUT14Z1ygKNwosPCBzB0Pm7msxtjo5fYPA+1w7D3U4
         JYy/2C4+NLEFNGgD3gyxAeXQqJVZpzuBvxQOI3xU1q0cTX7uddeB860HGcA+R9a2NxlU
         qOTSAPhfdHAEOvdlwOeQX21T5qSrN6jUZabswuo4hqHGPCBCpAOpGIbYLHfj2nkekTdR
         6EPB/JQvmiyH9Shvv0lfPtAWdeC/xfUmMiaNaQy2sSG+IcFqZJPB8yJf2CCLCRJbaFfP
         TXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WwiCRMR/atAzHQdqmr8uQelMa6OcJuGWGuwIRfhRdfs=;
        b=uPp06gtWT2xSpNQHvhTHIZnezaJfnAJ0zrsGhfav1rEtWBIexJyHUkzQVI/pJm4QaH
         CD6dVE5C2oxMegu9cwXJ1M6ozMtQlNFj9ieDmNznTPsP9deNYYs06FMYJML54D3sZv+A
         9bjUfo65gJMpYuTBCcN0hZR1NRwFaQ5XhNJ2YXAUOD5J+u21gxJ/fMce5JgZfD+5bxnm
         hFIjA2B8+Gvivw2Xp3WjDDfv39jV0T+4wGZc0QiIulUVLeMkgdmdZwi23PiTiZSFzdbe
         QkOSansBJJi5UGdypcHRkXKs6qC5B/fnJhlKZIxQbbmPgwxG/Ijw0NZtn+GLSVRZ52Wg
         uwmA==
X-Gm-Message-State: AOAM530wDK0FB/8it+my70lCx42oWZTr4MxSSu+ODv3QpMf0y8MZ6gcF
        3WF3vDZDNNKaMBRm5ZstLc77IA==
X-Google-Smtp-Source: ABdhPJwAuU8HZu7bzQUdUK7N+9kAxLdtAij91dHnV4cLlG9pUpOpa87mO5UpON9ihs0/vm3ANHX4DA==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr21971589wrn.269.1593521875852;
        Tue, 30 Jun 2020 05:57:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id 133sm3823861wme.5.2020.06.30.05.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 05:57:55 -0700 (PDT)
Subject: Re: [PATCH v7 00/11] Stop monitoring disabled devices
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Kulkarni <vishal@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Peter Kaestle <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kernel@collabora.com
References: <20200629122925.21729-1-andrzej.p@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aab40d90-3f72-657c-5e14-e53a34c4b420@linaro.org>
Date:   Tue, 30 Jun 2020 14:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629122925.21729-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Andrzej,

I've tested your series with kernelci and there are 3 regressions for
the imx6.

https://kernelci.org/test/job/thermal/branch/testing/kernel/v5.8-rc3-11-gf5e50bf4d3ef/plan/baseline/


On 29/06/2020 14:29, Andrzej Pietrasiewicz wrote:
> A respin of v6 with these changes:
> 
> v6..v7:
> - removed duplicate S-o-b line from patch 6/11
> 
> v5..v6:
> - staticized thermal_zone_device_set_mode() (kbuild test robot)
> 
> v4..v5:
> 
> - EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL (Daniel)
> - dropped unnecessary thermal_zone_device_enable() in int3400_thermal.c
> and in thermal_of.c (Bartlomiej)
> 
> Andrzej Pietrasiewicz (11):
>   acpi: thermal: Fix error handling in the register function
>   thermal: Store thermal mode in a dedicated enum
>   thermal: Add current mode to thermal zone device
>   thermal: Store device mode in struct thermal_zone_device
>   thermal: remove get_mode() operation of drivers
>   thermal: Add mode helpers
>   thermal: Use mode helpers in drivers
>   thermal: Explicitly enable non-changing thermal zone devices
>   thermal: core: Stop polling DISABLED thermal devices
>   thermal: Simplify or eliminate unnecessary set_mode() methods
>   thermal: Rename set_mode() to change_mode()
> 
>  drivers/acpi/thermal.c                        | 75 +++++----------
>  .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    |  8 ++
>  .../ethernet/mellanox/mlxsw/core_thermal.c    | 91 ++++---------------
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  9 +-
>  drivers/platform/x86/acerhdf.c                | 33 +++----
>  drivers/platform/x86/intel_mid_thermal.c      |  6 ++
>  drivers/power/supply/power_supply_core.c      |  9 +-
>  drivers/thermal/armada_thermal.c              |  6 ++
>  drivers/thermal/da9062-thermal.c              | 16 +---
>  drivers/thermal/dove_thermal.c                |  6 ++
>  drivers/thermal/hisi_thermal.c                |  6 +-
>  drivers/thermal/imx_thermal.c                 | 57 ++++--------
>  .../intel/int340x_thermal/int3400_thermal.c   | 38 ++------
>  .../int340x_thermal/int340x_thermal_zone.c    |  5 +
>  drivers/thermal/intel/intel_pch_thermal.c     |  5 +
>  .../thermal/intel/intel_quark_dts_thermal.c   | 34 ++-----
>  drivers/thermal/intel/intel_soc_dts_iosf.c    |  3 +
>  drivers/thermal/intel/x86_pkg_temp_thermal.c  |  6 ++
>  drivers/thermal/kirkwood_thermal.c            |  7 ++
>  drivers/thermal/rcar_thermal.c                |  9 +-
>  drivers/thermal/rockchip_thermal.c            |  6 +-
>  drivers/thermal/spear_thermal.c               |  7 ++
>  drivers/thermal/sprd_thermal.c                |  6 +-
>  drivers/thermal/st/st_thermal.c               |  5 +
>  drivers/thermal/thermal_core.c                | 76 ++++++++++++++--
>  drivers/thermal/thermal_of.c                  | 41 +--------
>  drivers/thermal/thermal_sysfs.c               | 37 +-------
>  include/linux/thermal.h                       | 19 +++-
>  28 files changed, 275 insertions(+), 351 deletions(-)
> 
> 
> base-commit: 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
