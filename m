Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80B3FBF08
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 00:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhH3WjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 18:39:21 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:51480 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhH3WjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 18:39:21 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.134])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E296720073;
        Mon, 30 Aug 2021 22:38:22 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A1095680073;
        Mon, 30 Aug 2021 22:38:22 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D187B13C2B1;
        Mon, 30 Aug 2021 15:38:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D187B13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1630363099;
        bh=gHsiHHShCL0hyNn3IC2fHk7RvVc4ve2wiKz4amKgfFM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nkm623cgIhqQCmCf8oQ1b3YcBfOMMRlUmi1VKWC5FK+Aou/ElrESux9GfNrC3an17
         YajuTj2q+fr8lQG85oQAsoZL62Owsw8Em6vAqZgKdu1yglukpQzCVcw59sF2OMFMyg
         0mDaW9k2iQ6Wqh/uH3MwaimRU5YiQ0dYaYjDJM4w=
Subject: Re: [PATCH v3 1/2] mt76: mt7915: fix STA mode connection on DFS
 channels
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Rubio Lu <Rubio-DW.Lu@mediatek.com>
References: <20210820203531.20706-1-greearb@candelatech.com>
 <CAFED-j=wek6cuX5wFeTKZFPJZ-hdQ+OoJsf-FKEwtpm49U30Qw@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <0d65d7e4-4b3d-d4da-28a9-dd73ebd9dfc9@candelatech.com>
Date:   Mon, 30 Aug 2021 15:38:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFED-j=wek6cuX5wFeTKZFPJZ-hdQ+OoJsf-FKEwtpm49U30Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1630363103-yJyus6ECc0zZ
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/21 11:17 AM, Janusz Dziedzic wrote:
> pt., 20 sie 2021 o 22:37 <greearb@candelatech.com> napisał(a):
>>
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Only AP, adhoc and mesh mode needs to check CAC.
>> Stations, in particular, do not need this check.
>>
>> Signed-off-by: Rubio Lu <Rubio-DW.Lu@mediatek.com>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>> v3:  Fix typo in SOB in 1/2, fix rebase typo in 2/2,
>>    split long line in 2/2
>>   .../net/wireless/mediatek/mt76/mt7915/mac.c   | 38 +++++++++++++++++--
>>   1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> index 8747e452e114..a6e142d27b60 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> @@ -2455,6 +2455,32 @@ static int mt7915_dfs_start_radar_detector(struct mt7915_phy *phy)
>>          return 0;
>>   }
>>
>> +struct mt7915_vif_counts {
>> +       u32 mesh;
>> +       u32 adhoc;
>> +       u32 ap;
>> +};
>> +
>> +static void
>> +mt7915_vif_counts(void *priv, u8 *mac, struct ieee80211_vif *vif)
>> +{
>> +       struct mt7915_vif_counts *counts = priv;
>> +
>> +       switch (vif->type) {
>> +       case NL80211_IFTYPE_ADHOC:
>> +               counts->adhoc++;
>> +               break;
>> +       case NL80211_IFTYPE_MESH_POINT:
>> +               counts->mesh++;
>> +               break;
>> +       case NL80211_IFTYPE_AP:
>> +               counts->ap++;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +}
>> +
>>   static int
>>   mt7915_dfs_init_radar_specs(struct mt7915_phy *phy)
>>   {
>> @@ -2495,6 +2521,7 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
>>          struct mt7915_dev *dev = phy->dev;
>>          bool ext_phy = phy != &dev->phy;
>>          int err;
>> +       struct mt7915_vif_counts counts = {0};
>>
>>          if (dev->mt76.region == NL80211_DFS_UNSET) {
>>                  phy->dfs_state = -1;
>> @@ -2519,9 +2546,14 @@ int mt7915_dfs_init_radar_detector(struct mt7915_phy *phy)
>>          phy->dfs_state = chandef->chan->dfs_state;
>>
>>          if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
>> -               if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
>> -                       return mt7915_dfs_start_radar_detector(phy);
>> -
>> +               if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE) {
>> +                       ieee80211_iterate_active_interfaces(phy->mt76->hw,
>> +                               IEEE80211_IFACE_ITER_RESUME_ALL,
>> +                               mt7915_vif_counts, &counts);
>> +                       if (counts.ap + counts.adhoc + counts.mesh)
>> +                               mt7915_dfs_start_radar_detector(phy);
>> +                       return 0;
>> +               }
>>                  return mt7915_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
>>                                            MT_RX_SEL0, 0);
>>          }
>> --
>> 2.20.1
>>
> 
> This depends on spec interpretation - when we have multiple ifaces on
> the same radio/channel (STA + APs).
> Maybe this is good time to start discussion about it - how we handle
> DFS and if we should improve.
> 
> Some vendors "derive" CAC from STA.
> So, while STA don't need to run CAC and first VIF sta will be
> connected on DFS channel, assume don't need to run CAC for second,
> third ... AP VIF. Still required ISM (In service monitoring, radar
> detection if AP ifaces) but simple skip CAC. This simplify
> implementation a lot for multi-vif (STA+APs) case.
> 
> So, maybe we should/could add kconfig for that - CONFIG_DFS_DERIVE_STA_CAC.
> When set, we could simple set NL80211_DFS_AVAILABLE when STA will
> connect on DFS channel - then any other APs we will add on the same
> channel will not require CAC, radar detection still required.

So this config option would mean 'I think CAC spec means I don't have to do
CAC if station is already on this channel', with the understanding that this
may actually be an incorrect interpretation?  That seems like something that
would not be acceptable upstream for good reasons.

Do you have any pointers to the specification(s) section(s) that apply to this?


> Regarding STA connection on DFS channel, I agree - today MT76x have a
> bug for that (eg. single VIF station).
> I have much older code and fix it simplest way I could.
> 
> --- a/mt7615/mac.c
> +++ b/mt7615/mac.c
> @@ -2034,6 +2034,11 @@ static int mt7615_dfs_start_radar_detect
>    phy->rdd_state |= BIT(1);
>    }
> 
> +   /* end CAC - upper layer will care about it, lock tx, beacon setup */
> +   err = mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy, MT_RX_SEL0, 0);
> +   if (err < 0)
> +       return err;
> +
>    return 0;
>   }
> 
> @@ -2104,11 +2109,7 @@ int mt7615_dfs_init_radar_detector(struc
>    phy->dfs_state = chandef->chan->dfs_state;
> 
>    if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
> -   if (chandef->chan->dfs_state != NL80211_DFS_AVAILABLE)
> -     return mt7615_dfs_start_radar_detector(phy);
> -
> -   return mt7615_mcu_rdd_cmd(dev, RDD_CAC_END, ext_phy,
> -   MT_RX_SEL0, 0);
> +   return mt7615_dfs_start_radar_detector(phy);
>    }
> 
>   stop:

It would certainly be nice to simplify the code, but I don't know
enough about the firmware/driver details to comment intelligently on this
part.

Thanks,
Ben

> 
> BR
> Janusz
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

