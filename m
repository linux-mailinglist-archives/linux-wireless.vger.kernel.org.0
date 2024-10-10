Return-Path: <linux-wireless+bounces-13852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CBA998A54
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51D41C23EC5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421D41E1321;
	Thu, 10 Oct 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QUBgXRv6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC21E04BC
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570895; cv=none; b=q5gguWNKEQCIKD6TtVKKrxz9Xj93aL3WFYklmbdYlhSSZgtgCGfp2EQfVlDaO/W5lkLVC16Zfv4Ca+vCAst23E2RAe93DFBQ1NFJ+XneZB+cCmOHDc05cEZkI5DyKEoXLvgkkTPD8WhYOjLTxRr1TBrJtxU842mDQqjezZPsSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570895; c=relaxed/simple;
	bh=yHH3piVh+56+GsIRxj9SGhbjggLabs4JJ/qW5PUj/MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2j68IdTC8OAsyIqyeDvgVc8ZFtgI58PFrtWfh3II/XzzBW31ME+7vSu0uoSlYAGqwLysSLerSH5O0/YPfRplFC4s6Q6KNaIUVKbTLrmJp1imq9MO6x/qHmBdwDSM0TEEJI0DsXEc7IiXg4oP3/XthSolzX9wqU5JOQ4xtH7/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QUBgXRv6; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D243B280069;
	Thu, 10 Oct 2024 14:34:43 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id ECEB913C2B0;
	Thu, 10 Oct 2024 07:34:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ECEB913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728570883;
	bh=yHH3piVh+56+GsIRxj9SGhbjggLabs4JJ/qW5PUj/MQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QUBgXRv6o6zxg5Iy7mUgnVlL4jMWIqAmzt+qfpP15Hkl1qizIp0RVT8pCWsfMYvN/
	 jYiOiRlMqwKV1DaNUE6lpt/EEH3/1w5ouxFXeTk4q9d5++6EoqAzb5wphfFHlrEiD3
	 ia1RzQh0TLwLWn4v5cVXauq+tM9MT0YIh41iwLdM=
Message-ID: <b8c12251-7099-4aa1-9b8e-e709cc6eafac@candelatech.com>
Date: Thu, 10 Oct 2024 07:34:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: mt76: mt7915: add module param to select 5
 GHz or 6 GHz on MT7916
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, Steven Liu <steven.liu@mediatek.com>,
 Evelyn Tsai <Evelyn.Tsai@mediatek.com>, Paul <paul@asiarf.com>,
 Shayne Chen <Shayne.Chen@mediatek.com>
References: <20241010083816.51880-1-nbd@nbd.name>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20241010083816.51880-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1728570885-WGPlRuWPISu5
X-MDID-O:
 us5;ut7;1728570885;WGPlRuWPISu5;<greearb@candelatech.com>;5cd11ceaa947e1566cadf6dee08d9f7e
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/10/24 01:38, Felix Fietkau wrote:
> From: Shayne Chen <shayne.chen@mediatek.com>
> 
> Due to a limitation in available memory, the MT7916 firmware can only
> handle either 5 GHz or 6 GHz at a time. It does not support runtime
> switching without a full restart.

Can this also be implemented so that we can change the module parameter,
force the radio to do a hard reset, and change bands that way, without
having to do a reboot?

Thanks,
Ben

> 
> On older firmware, this accidentally worked to some degree due to missing
> checks, but couldn't be supported properly, because it left the 6 GHz
> channels uncalibrated.
> Newer firmware refuses to start on either band if the passed EEPROM
> data indicates support for both.
> 
> Deal with this limitation by using a module parameter to specify the
> preferred band in case both are supported.
> 
> Fixes: b4d093e321bd ("mt76: mt7915: add 6 GHz support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   .../wireless/mediatek/mt76/mt7915/eeprom.c    | 21 +++++++++++++++++--
>   .../net/wireless/mediatek/mt76/mt7915/init.c  |  4 ++--
>   2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> index bfdbc15abaa9..928e0b07a9bf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> @@ -2,9 +2,14 @@
>   /* Copyright (C) 2020 MediaTek Inc. */
>   
>   #include <linux/firmware.h>
> +#include <linux/moduleparam.h>
>   #include "mt7915.h"
>   #include "eeprom.h"
>   
> +static bool enable_6ghz;
> +module_param(enable_6ghz, bool, 0644);
> +MODULE_PARM_DESC(enable_6ghz, "Enable 6 GHz instead of 5 GHz on hardware that supports both");
> +
>   static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
>   {
>   	struct mt76_dev *mdev = &dev->mt76;
> @@ -170,8 +175,20 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
>   			phy->mt76->cap.has_6ghz = true;
>   			return;
>   		case MT_EE_V2_BAND_SEL_5GHZ_6GHZ:
> -			phy->mt76->cap.has_5ghz = true;
> -			phy->mt76->cap.has_6ghz = true;
> +			if (enable_6ghz) {
> +				phy->mt76->cap.has_6ghz = true;
> +				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + band],
> +						 MT_EE_V2_BAND_SEL_6GHZ,
> +						 MT_EE_WIFI_CONF0_BAND_SEL);
> +			} else {
> +				phy->mt76->cap.has_5ghz = true;
> +				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + band],
> +						 MT_EE_V2_BAND_SEL_5GHZ,
> +						 MT_EE_WIFI_CONF0_BAND_SEL);
> +			}
> +			/* force to buffer mode */
> +			dev->flash_mode = true;
> +
>   			return;
>   		default:
>   			phy->mt76->cap.has_2ghz = true;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> index 6bef96e3d2a3..f82216d1bda0 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
> @@ -1239,14 +1239,14 @@ int mt7915_register_device(struct mt7915_dev *dev)
>   	if (ret)
>   		goto unreg_dev;
>   
> -	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
> -
>   	if (phy2) {
>   		ret = mt7915_register_ext_phy(dev, phy2);
>   		if (ret)
>   			goto unreg_thermal;
>   	}
>   
> +	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
> +
>   	dev->recovery.hw_init_done = true;
>   
>   	ret = mt7915_init_debugfs(&dev->phy);

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


