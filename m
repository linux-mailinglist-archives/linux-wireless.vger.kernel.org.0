Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83CC366941
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhDUKcy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhDUKcv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:32:51 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987B9C061342
        for <linux-wireless@vger.kernel.org>; Wed, 21 Apr 2021 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mapYpz4d6B2un+rQqE+/GsrGdYsL1RzUyIJiwD8K17I=; b=Qis7ukCntEWog18vRSVMyepPzN
        aaxMyq1XSdkt6P0FPGyVkk0lYaZvgmOJOnTaFCD3tiH5BuungameU89mMzPsdAB2HADCLm4OTjcOq
        3PfCyjAVIL0VpD6JDcms+nn+gqrM+vIp9B9M7ReqgacxQH19F9QUzoqwy9bnJPDkQtpk=;
Received: from p4ff13bc6.dip0.t-ipconnect.de ([79.241.59.198] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lZA9U-0002VE-AG; Wed, 21 Apr 2021 12:32:12 +0200
Subject: Re: [PATCH 2/2] mt76: mt7615: add thermal sensor device support
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <b51d79d257e150a09d51029e3465e2ce925d6cfe.1618691395.git.ryder.lee@mediatek.com>
 <d9d9214cbd4444b861cdc8b88f17e8580b1025f6.1618691395.git.ryder.lee@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <57888c9e-f66c-3922-9979-9d24e3e7d07f@nbd.name>
Date:   Wed, 21 Apr 2021 12:32:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <d9d9214cbd4444b861cdc8b88f17e8580b1025f6.1618691395.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2021-04-17 22:42, Ryder Lee wrote:
> Similar to mt7915, switching to use standard hwmon sysfs.
> For reading temperature, cat /sys/class/ieee80211/phy*/hwmon*/temp1_input
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt7615/debugfs.c   | 20 --------
>  .../net/wireless/mediatek/mt76/mt7615/init.c  | 50 +++++++++++++++++++
>  .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 +--
>  .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +-
>  .../wireless/mediatek/mt76/mt7615/pci_init.c  |  4 ++
>  5 files changed, 58 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> index d84662fb0304..22ccad43a13e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
> @@ -8,11 +8,61 @@
>   */
>  
>  #include <linux/etherdevice.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include "mt7615.h"
>  #include "mac.h"
>  #include "mcu.h"
>  #include "eeprom.h"
>  
> +static ssize_t mt7615_thermal_show_temp(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct mt7615_dev *mdev = dev_get_drvdata(dev);
> +	int temperature;
> +
> +	if (!mt7615_wait_for_mcu_init(mdev))
> +		return 0;
> +
> +	mt7615_mutex_acquire(mdev);
> +	temperature = mt7615_mcu_get_temperature(mdev);
> +	mt7615_mutex_release(mdev);
> +
> +	if (temperature < 0)
> +		return temperature;
> +
> +	/* display in millidegree celcius */
> +	return sprintf(buf, "%u\n", temperature * 1000);
> +}
> +
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, mt7615_thermal_show_temp,
> +			  NULL, 0);
> +
> +static struct attribute *mt7615_hwmon_attrs[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(mt7615_hwmon);
> +
> +int mt7615_thermal_init(struct mt7615_dev *dev)
> +{
> +	struct wiphy *wiphy = mt76_hw(dev)->wiphy;
> +	struct device *hwmon;
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return 0;
> +
> +	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
> +						       wiphy_name(wiphy), phy,
This does not compile (wrong variable name).

- Felix
