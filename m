Return-Path: <linux-wireless+bounces-4308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63386EA17
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 21:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6CD1F23ABA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75897EC;
	Fri,  1 Mar 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="oyKR7Y5g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1363BBCF
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323955; cv=none; b=Lj3ebxrGkDFD5mu58VZlV4noKBl0bSuGYTgYyZGQqoE2pi7jJtfPxHadoug/bM2owXqdA+1HZDkV0cTqQlFzO3XAkovV1JzUSNXbRmu/coqpRSRZ3sq9dpybmqnaeVCMPxce0y2IWcZEjJQjCxnKFjKfzbecrBRwb7u2JStGnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323955; c=relaxed/simple;
	bh=dEGmIX7+F45zEXukvxpEm9wduTqTEmMcRTAtk1TaXFQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IgvsY3iqhbmDOsYi4lnH/gzWNFvrKPMsPKpCAA/0HvfXr/DnT92llORCR2FuXL6ajmmV9o5FU6UBnQW9UvE+eTLMFzJ4JkDBbVakKWufwRpZVE9cYorJX3SFG/5pg9YYJaSW+Z8aNfFuuF6w/rY+xUjS6onTTfd5W1U59zyPC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=oyKR7Y5g; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EBA7FAC006C;
	Fri,  1 Mar 2024 20:12:24 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 49B8913C2B0;
	Fri,  1 Mar 2024 12:12:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 49B8913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709323944;
	bh=dEGmIX7+F45zEXukvxpEm9wduTqTEmMcRTAtk1TaXFQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oyKR7Y5gIr+6WTY4TACrqFA0exCWALPtbBrcX9AhKeJeEJqHXyVCFcN+XPCETlz6H
	 RCNxRimNV9sFL4krAn7KzsRga5M0Z2JES53BnuBBre1FG2kJ0ugp+gpJ4yHRjY1w+s
	 XL8BGktcjqk8aaiPhP2DMS2ddXskcJQiDM5tun4I=
Message-ID: <64286e79-4612-9601-138d-e08aa8217857@candelatech.com>
Date: Fri, 1 Mar 2024 12:12:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ***Spam*** [PATCH 2/8] wifi: mt76: mt7996: add txpower setting
 support
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: shayne.chen@mediatek.com, "nbd@nbd.name" <nbd@nbd.name>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 =?UTF-8?B?QWxsZW4gWWUgKOiRieiKt+WLsyk=?= <Allen.Ye@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?RXZlbHluIFRzYWkgKOiUoeePiumIuik=?= <Evelyn.Tsai@mediatek.com>,
 "lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee
 <Ryder.Lee@mediatek.com>, =?UTF-8?B?U3RhbmxleVlQIFdhbmcgKOeOi+S+kemCpik=?=
 <StanleyYP.Wang@mediatek.com>
References: <20231102100302.22160-1-shayne.chen@mediatek.com>
 <20231102100302.22160-2-shayne.chen@mediatek.com>
 <bbf8fe7e-1098-5b33-8ed6-dee38329edf6@candelatech.com>
 <8c5fbe88bcc5b55e6d80247144e4f890fd68ef27.camel@mediatek.com>
 <487ef0bb-5930-e998-7daa-6f57d09d682c@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <487ef0bb-5930-e998-7daa-6f57d09d682c@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1709323946-CQm1pUjvZtyU
X-MDID-O:
 us5;ut7;1709323946;CQm1pUjvZtyU;<greearb@candelatech.com>;0a87ce8853dfc5be48bfe846d29ed5d9

On 12/7/23 13:01, Ben Greear wrote:
> On 12/7/23 09:15, shayne.chen@mediatek.com wrote:
>> On Fri, 2023-12-01 at 15:40 -0800, Ben Greear wrote:
>>>
>>> External email : Please do not click links or open attachments until
>>> you have verified the sender or the content.
>>>   On 11/2/23 03:02, Shayne Chen wrote:
>>>> Add support for setting txpower from upper layer and configuring
>>> per-rate
>>>> txpower limit table.
>>>
>>> Hello Shayne,
>>
>> Hi Ben,
>>>
>>>   From what I can tell, this patch causes STA vdevs to no longer send
>>> probe
>>> requests when trying to associate.  I bisected to this in Felix's
>>> tree that holds
>>> this patch.
>>>
>>> Tested on x86-64, mtk7996 radio.  Specifically
>>> debugged on 2.4Ghz radio, but I think it affects 5Ghz too.
>>>
>> I have done some tests but didn't face this issue. Could you also use
>> the newer firmware to test if it still happens?

Hello Shayne,

I rebased on 6.8, and started adding some debugging around this issue.

I am using the MTK 7996 developer radio board on this system, in an x86-64 pc.  It is not able
to find the 'node', so the per mode power tables are not populated and left at
0x0.  Then, when this 0x0 data is sent to the firmware, the firmware gives
back a failure response 0xc00000bb

[ 8658.340984] mt7996e 0000:03:00.0: get-rate-power-limits:  Could not find node.
[ 8658.340988] mt7996e 0000:03:00.0: set-txpower-sku, tx_power: 36
[ 8658.341127] mt7996e 0000:03:00.0: mcu-parse-response, firmware returned failure code: 0xc00000bb.

Do we need to add code to not even send the mcu command if the per-mode txpower tables
cannot be found?

Or can we calculate the values to some useful default in that case?

For reference, here is my debug patch:


diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 0c5c664de6b3..cf48073783b8 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -419,12 +422,16 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,

         memset(dest, target_power, sizeof(*dest));

-       if (!IS_ENABLED(CONFIG_OF))
+       if (!IS_ENABLED(CONFIG_OF)) {
+               mtk_dbg(dev, CFG, "get-rate-power-limits:  CONFIG_OF not enabled.\n");
                 return target_power;
+       }

         np = mt76_find_power_limits_node(dev);
-       if (!np)
+       if (!np) {
+               mtk_dbg(dev, CFG, "get-rate-power-limits:  Could not find node.\n");
                 return target_power;
+       }

         switch (chan->band) {
         case NL80211_BAND_2GHZ:
@@ -442,12 +449,17 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,

         snprintf(name, sizeof(name), "txpower-%cg", band);
         np = of_get_child_by_name(np, name);
-       if (!np)
+       if (!np) {
+               mtk_dbg(dev, CFG, "get-rate-power-limits:  Could not find band node: %s\n",
+                       name);
                 return target_power;
+       }

         np = mt76_find_channel_node(np, chan);
-       if (!np)
+       if (!np) {
+               mtk_dbg(dev, CFG, "get-rate-power-limits:  Could not find chan node\n");
                 return target_power;
+       }

         txs_delta = mt76_get_txs_delta(np, hweight16(phy->chainmask));

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2c19b537feec..8f4774c4b1d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1114,6 +1114,7 @@ enum MTK_DEUBG {
         MTK_DEBUG_FATAL         = 0x00000004,
         MTK_DEBUG_WRN           = 0x00000008,
         MTK_DEBUG_MSG           = 0x00000010, /* messages to/from firmware */
+       MTK_DEBUG_CFG           = 0x00000020, /* Configuration related */
         MTK_DEBUG_ANY           = 0xffffffff
  };

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index e89a06464651..c7042c3a905b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -422,8 +422,11 @@ static int mt7996_config(struct ieee80211_hw *hw, u32 changed)
         if (changed & (IEEE80211_CONF_CHANGE_POWER |
                        IEEE80211_CONF_CHANGE_CHANNEL)) {
                 ret = mt7996_mcu_set_txpower_sku(phy);
-               if (ret)
-                       return ret;
+               if (ret) {
+                       dev_err(dev->mt76.dev,
+                               "config:  Failed to set txpower: %d\n", ret);
+                       //return ret;
+               }
         }

         mutex_lock(&dev->mt76.mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index d709d26eacd1..9dc896cd04e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -281,6 +281,10 @@ mt7996_mcu_parse_response(struct mt76_dev *mdev, int cmd,
                 /* skip invalid event */
                 if (mcu_cmd != event->cid)
                         ret = -EAGAIN;
+               if (ret) {
+                       mtk_dbg(mdev, CFG, "mcu-parse-response, firmware returned failure code: 0x%x.\n",
+                               ret);
+               }
         } else {
                 skb_pull(skb, sizeof(struct mt7996_mcu_rxd));
         }
@@ -4571,6 +4575,7 @@ int mt7996_mcu_set_txpower_sku(struct mt7996_phy *phy)
         tx_power = mt76_get_rate_power_limits(mphy, mphy->chandef.chan,
                                               &la, tx_power);
         mphy->txpower_cur = tx_power;
+       mtk_dbg(&dev->mt76, CFG, "set-txpower-sku, tx_power: %d\n", tx_power);

         skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
                                  sizeof(req) + MT7996_SKU_RATE_NUM);

Thanks,
Ben



