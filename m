Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F613FE191
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Sep 2021 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbhIAR4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Sep 2021 13:56:32 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:41964 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344878AbhIAR4b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Sep 2021 13:56:31 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.121])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 5BD4B20080;
        Wed,  1 Sep 2021 17:55:33 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BB77C4C0073;
        Wed,  1 Sep 2021 17:55:32 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 427A913C2B1;
        Wed,  1 Sep 2021 10:55:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 427A913C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1630518932;
        bh=rXtzppk88Wnm3uo/M6L8zsOdWGLsxQnIw4Z+wmXUGuM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hgGa7w7ZeY6odpEu2V7C/wYhx7Gx5N7KuApR2/uM/YPSwjaFXp/WjKHu0AAQvhxwQ
         wEKAff23ex3i6w7H1jsd4VVtiUC8Zk6Sg+gXTnzZhOGmEKBpym/EUYJA/KzTWJQcW0
         0B/At/dX6rkshUlLBjh8SDrEpQzZIUkRXrbJz60A=
Subject: Re: [PATCH v5 1/2] mt76: mt7915: fix hwmon temp sensor mem
 use-after-free
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <d72e872e7fdb5c04e890b978575f4d86bc61ad36.1630515789.git.ryder.lee@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <efe0cd18-b89a-0385-a271-d6c57fea08ca@candelatech.com>
Date:   Wed, 1 Sep 2021 10:55:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d72e872e7fdb5c04e890b978575f4d86bc61ad36.1630515789.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1630518933-01oFyndXDFRY
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/1/21 10:49 AM, Ryder Lee wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Without this change, garbage is seen in the hwmon name and sensors output
> for mt7915 is garbled. It appears that the hwmon logic does not make a
> copy of the incoming string, but instead just copies a char* and expects
> it to never go away.
> 
> Fixes: d6938251bb5b ("mt76: mt7915: add thermal sensor device support")
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> v5:  Use devm_kstrdup on the wiphy name as suggested.

I don't care a great deal either way, but phyname can change (which was original
way to reproduce this corruption bug), so with this v5 change, then the hwmon 'id' could confusingly
be 'phy0' while user has renamed the phy0 to wiphy0 or whatever.

It won't break my usage either way, so if you are happy with this, then good
enough for me.

But, see below, there is spurious change...


> v4:  Simplify flow.
> v3:  Add 'fixes' tag to aid backports.
> ---
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c | 8 ++++----
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index acc83e9f409b..78b9abbe63f3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -160,9 +160,10 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
>   	struct wiphy *wiphy = phy->mt76->hw->wiphy;
>   	struct thermal_cooling_device *cdev;
>   	struct device *hwmon;
> +	const char *name;
>   
> -	cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
> -					       &mt7915_thermal_ops);
> +	name = devm_kstrdup(&wiphy->dev, wiphy_name(wiphy), GFP_KERNEL);
> +	cdev = thermal_cooling_device_register(name, phy, &mt7915_thermal_ops);
>   	if (!IS_ERR(cdev)) {
>   		if (sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
>   				      "cooling_device") < 0)
> @@ -174,8 +175,7 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
>   	if (!IS_REACHABLE(CONFIG_HWMON))
>   		return 0;
>   
> -	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
> -						       wiphy_name(wiphy), phy,
> +	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev, name, phy,
>   						       mt7915_hwmon_groups);
>   	if (IS_ERR(hwmon))
>   		return PTR_ERR(hwmon);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 932cf5a629db..219bb353b56d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -1962,7 +1962,7 @@ mt7915_mcu_sta_bfer_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
>   	else
>   		return;
>   
> -	bf->bf_cap = BIT(!ebf && dev->ibf);
> +	bf->bf_cap = ebf ? ebf : dev->ibf << 1;

And this should not be in this patch.

Thanks,
Ben

>   	bf->bw = sta->bandwidth;
>   	bf->ibf_dbw = sta->bandwidth;
>   	bf->ibf_nrow = tx_ant;
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

