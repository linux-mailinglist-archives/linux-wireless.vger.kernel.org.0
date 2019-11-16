Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A42FEC3B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 13:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKPMNc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 07:13:32 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:59244 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfKPMNc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 07:13:32 -0500
Received: from [192.168.178.23] (unknown [87.147.48.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DFE3A58007B;
        Sat, 16 Nov 2019 13:13:27 +0100 (CET)
Subject: Re: [PATCH 4/4] mt76: mt76x02: add channel switch support for usb
 interfaces
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
 <20191116111709.4686-5-markus.theil@tu-ilmenau.de>
 <20191116114517.GD20820@localhost.localdomain>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <5dffcc2f-e722-395a-0077-1286f1c786b8@tu-ilmenau.de>
Date:   Sat, 16 Nov 2019 13:13:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191116114517.GD20820@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/16/19 12:45 PM, Lorenzo Bianconi wrote:
>> This patch enables channel switch support on mt76 usb interfaces.
>>
> Hi Markus,
>
> I was thinking about it, but since usb does not support DFS what is the purpose
> of CSA in this case?
>
> Regards,
> Lorenzo

Hi Lorenzo,

for research purposes I'm currently trying out some dynamic channel
allocation strategies with multiple indoor APs. I use a dedicated
interface to perform surveys and monitoring the environment. These
survey results are then correlated between different with traffic
patterns to find out interferers. Afterwards I let the AP interfaces
change their channel to a less congested one if necessary and notice the
STAs via CSAs.

I use mt76 based USB devices for my tests as they are quite versatile
and useful for debugging with a notebook (I can just attach multiple
ones). Therefore I thought, having the possibility to dynamically switch
channels on this devices would maybe useful to other researchers and
submitted my patches.

Regards,
Markus

>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 7 +++++++
>>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c     | 2 +-
>>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  | 5 +++++
>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
>> index aedab4cc8d40..32e6c37aa80d 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
>> @@ -179,6 +179,12 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
>>  
>>  	mt76x02_resync_beacon_timer(dev);
>>  
>> +	mt76_csa_check(&dev->mt76);
>> +	if (dev->mt76.csa_complete) {
>> +		mt76_csa_finish(&dev->mt76);
>> +		goto out;
>> +	}
>> +
>>  	mt76x02_mac_set_beacon_prepare(dev);
>>  
>>  	ieee80211_iterate_active_interfaces(mt76_hw(dev),
>> @@ -195,6 +201,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
>>  
>>  	mt76x02_mac_set_beacon_finish(dev);
>>  
>> +out:
>>  	mt76x02u_restart_pre_tbtt_timer(dev);
>>  }
>>  
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
>> index 414b22399d93..3f95e5b24e1d 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
>> @@ -174,7 +174,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
>>  		wiphy->reg_notifier = mt76x02_regd_notifier;
>>  		wiphy->iface_combinations = mt76x02_if_comb;
>>  		wiphy->n_iface_combinations = ARRAY_SIZE(mt76x02_if_comb);
>> -		wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
>>  
>>  		/* init led callbacks */
>>  		if (IS_ENABLED(CONFIG_MT76_LEDS)) {
>> @@ -184,6 +183,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
>>  		}
>>  	}
>>  
>> +	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
>>  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
>>  
>>  	hw->sta_data_size = sizeof(struct mt76x02_sta);
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
>> index eb73cb856c81..2f2c39a6a9e6 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
>> @@ -100,6 +100,10 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
>>  	return err;
>>  }
>>  
>> +void mt76x2u_channel_switch_beacon(struct ieee80211_hw *hw,
>> +				   struct ieee80211_vif *vif,
>> +				   struct cfg80211_chan_def *chandef) {}
>> +
>>  const struct ieee80211_ops mt76x2u_ops = {
>>  	.tx = mt76x02_tx,
>>  	.start = mt76x2u_start,
>> @@ -121,4 +125,5 @@ const struct ieee80211_ops mt76x2u_ops = {
>>  	.get_survey = mt76_get_survey,
>>  	.set_tim = mt76_set_tim,
>>  	.release_buffered_frames = mt76_release_buffered_frames,
>> +	.channel_switch_beacon = mt76x2u_channel_switch_beacon,
>>  };
>> -- 
>> 2.24.0
>>
-- 
Markus Theil

Technische Universität Ilmenau, Fachgebiet Telematik/Rechnernetze
Postfach 100565
98684 Ilmenau, Germany

Phone: +49 3677 69-4582
Email: markus[dot]theil[at]tu-ilmenau[dot]de
Web: http://www.tu-ilmenau.de/telematik


