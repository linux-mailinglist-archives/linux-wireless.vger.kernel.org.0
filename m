Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7F69C19F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Feb 2023 18:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjBSRHs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Feb 2023 12:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjBSRHq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Feb 2023 12:07:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E99212859
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 09:07:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l5-20020a05600c4f0500b003dc4050c94aso710962wmq.4
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KxNFzRgs/0vUNP2uZncHosd2KHSBPqfvZ7J555gKlI=;
        b=TqDmxeCqgjX/SCT0zS+PF6AfR/9dCo1FpS5mnG9j01BFC1+VD4Q7ubhlQfXhrmE083
         0WYN1f0bIbo21XRTWifbJwcYTr2X1HSPBzZM87/35szohbgwJWtwst3ZB/Uyku+BZ1GT
         fdjOk5jg86fdGhZQivHhMX1dUtyEtd0zEYACMvag1QVVQXdQ7R5c7aIxveMhWwkz75hR
         8chbsS6v67DndN4W12l84nsUdBhyOjwMW1hwOqBmE6eyqzuIM8WMLxP7V5DN4UAzCAZX
         vqLCw8gjWfj/gz3br1kNLOjZCJGA+sAEn8LyDTAn692JW1B2MJS3YSi60TU4KXtLsjqR
         Lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KxNFzRgs/0vUNP2uZncHosd2KHSBPqfvZ7J555gKlI=;
        b=0/2OAgb9zQlMRyExdHhjyL+HD0/i4iNGHGkGcgTSse8jwoLRFH56F21wC+4x/o4sMZ
         VomlOw01W8uKag5ljJrdtt8IVXeGUvnn1brriVVKw80mtBqUdhZSucriSqcgvtNCDIuP
         Zl+2Fvem+VwJK3h7VZCnM/HqgDrV5WmED5B26BLK3elLGhV6Hf5TWIzSalWoInLy+T/1
         dh2qaqPmGmdvQPCsxQnX1cODYd3gXzYZyRvBoMtomv5mlNayOxqX3m/V0QlDEZLG57py
         aNdAUJJ5QWM68/4SSrYMcupjLXle40rwAReGwFYZJpk4kyg/EdhnmbBgNTaycV4/vFfd
         e+Eg==
X-Gm-Message-State: AO0yUKWs/za4FwQIH1RKjIgpEaUEyiuB1/XHuj2RX+qV9bbVwjM/j7mv
        2evUc3zzBqLiRT5eHvvC28jXxg==
X-Google-Smtp-Source: AK7set83h6bWbda4YvPCa+ZBjfPRZ/9UdfQCE1sEN23gN10rONUKibwH121WMa44Jr/M6QZ46vWaSg==
X-Received: by 2002:a05:600c:198e:b0:3e2:1f00:bff7 with SMTP id t14-20020a05600c198e00b003e21f00bff7mr7646707wmq.12.1676826461464;
        Sun, 19 Feb 2023 09:07:41 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:6f43:b92:7670:463? ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.googlemail.com with ESMTPSA id n27-20020a05600c3b9b00b003e206cc7237sm15155832wms.24.2023.02.19.09.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 09:07:40 -0800 (PST)
Message-ID: <4d8f1e68-8d2c-b70f-69c7-a1137ac4b05f@linaro.org>
Date:   Sun, 19 Feb 2023 18:07:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 01/17] thermal/core: Add a thermal zone 'devdata'
 accessor
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <lenb@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Talel Shenhar <talel@amazon.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Tim Zimmermann <tim@linux4.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jiang Jian <jiangjian@cdjrlc.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:CXGB4 ETHERNET DRIVER (CXGB4)" <netdev@vger.kernel.org>,
        "open list:INTEL WIRELESS WIFI LINK (iwlwifi)" 
        <linux-wireless@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
 <20230219143657.241542-2-daniel.lezcano@linaro.org>
 <Y/I7KA2Uqqk7ib6L@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y/I7KA2Uqqk7ib6L@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/02/2023 16:07, Niklas Söderlund wrote:
> Hi Daniel,
> 
> Thanks for your work.
> 
> On 2023-02-19 15:36:41 +0100, Daniel Lezcano wrote:
>> The thermal zone device structure is exposed to the different drivers
>> and obviously they access the internals while that should be
>> restricted to the core thermal code.
>>
>> In order to self-encapsulate the thermal core code, we need to prevent
>> the drivers accessing directly the thermal zone structure and provide
>> accessor functions to deal with.
>>
>> Provide an accessor to the 'devdata' structure and make use of it in
>> the different drivers.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> 
> ...
> 
>>   drivers/thermal/rcar_gen3_thermal.c              |  4 ++--
>>   drivers/thermal/rcar_thermal.c                   |  3 +--
> 
> For R-Car,
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> 
> ...
> 
> 
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 2bb4bf33f4f3..724b95662da9 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -365,6 +365,8 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
>>   					void *, struct thermal_zone_device_ops *,
>>   					struct thermal_zone_params *, int, int);
>>   
>> +void *thermal_zone_device_get_data(struct thermal_zone_device *tzd);
>> +
> 
> bikeshedding:
> 
> Would it make sens to name this thermal_zone_device_get_priv_data(),
> thermal_zone_device_get_priv() or something like that? To make it more
> explicitly when reading the driver code this fetches the drivers private
> data, and not some data belonging to the zone itself.

In the headers files, there are more occurrences with _name_priv():

# _name_priv()
git grep priv include/linux/ | grep "priv(" | grep -v get | wc -l
52

# _name_private()
git grep priv include/linux/ | grep "private(" | grep -v get | wc -l
33

# _name_get_private()
git grep priv include/linux/ | grep "private(" | grep get | wc -l
12

# _name_get_priv()
git grep priv include/linux/ | grep "priv(" | grep get | wc -l
4


What about thermal_zone_device_priv() ?






-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

