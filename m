Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89FB12234A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 05:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLQEyP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 23:54:15 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:56590 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLQEyP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 23:54:15 -0500
Received: from [192.168.1.47] (unknown [50.34.171.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E99CA13C283;
        Mon, 16 Dec 2019 20:54:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E99CA13C283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1576558454;
        bh=Vsnk7qVhFUAzutsUU0oiDTzdtSuGzETN4exarsx0xxg=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=qRe3obiOB91wZ8ZV1KrR/vxkQbsurDLlQ881Q+rBsmveYyEaMKoQFkxNz6vuqNmB4
         arRzGJ2WzYVKcVg3odTraTjj9Ze3x47Sg56IgZ993p84pH68joguwK1BbIvCdjJCEE
         ARJpxZpTChqsdQ1qmiY9wAwFzYJygbWcyTTprh5A=
Subject: Re: [RFC] mac80211: Fix setting txpower to zero.
To:     Justin Capella <justincapella@gmail.com>
References: <20191213230334.27631-1-greearb@candelatech.com>
 <e2c54ffb-d346-65b0-e4ab-1cd2f8ff2a27@candelatech.com>
 <CAMrEMU-Ei3Y9zT=td+amsM3-fi4WP2_ihX=Tjh0A=vPx08_Biw@mail.gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <45118bdb-7bbc-ac5d-e933-24762a48dc82@candelatech.com>
Date:   Mon, 16 Dec 2019 20:54:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMrEMU-Ei3Y9zT=td+amsM3-fi4WP2_ihX=Tjh0A=vPx08_Biw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 12/16/2019 08:44 PM, Justin Capella wrote:
> https://patchwork.kernel.org/patch/9465291/ looks like this older
> related patch was to work around p2p control vif being set to zero and
> never reconfigured, I'll try and test this patchset with various vif
> types. One thing I thought of, it might be cleaner to use int max,
> since code is already looking for a minimum, and ultimately would be
> limited by 2g/5g power limit,  perhaps initialize the txpower with
> those values? Then you avoid a magic value?

I think ath9k might check for a maximum, in which case the INT_MAX becomes
a magic value, but even so, your idea has merit.

>
> What does the hw do with a txpower of zero anyway?

It transmits with one dbm less of power than txpower 1.  0 dbm does not mean no energy at all.

Thanks,
Ben

>
> On Mon, Dec 16, 2019 at 2:56 PM Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 12/13/19 3:03 PM, greearb@candelatech.com wrote:
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> With multiple VIFS ath10k, and probably others, tries to find the
>>> minimum txpower for all vifs and uses that when setting txpower in
>>> the firmware.
>>
>> Johannes, sorry to be impatient, but I want to get some new ath10k-ct
>> changes into OpenWRT (to fix per-chain RSSI reporting), and if only my
>> driver change goes in, then ath10k-ct will have the old problem that Ryan Hsu
>> tried to fix.
>>
>> Are you OK with initializing the txpower to -1 to mean 'unset' in mac80211?  Or, do I need
>> to come up with some other way to indicate to the driver that the txpower should
>> be ignored?
>>
>> Thanks,
>> Ben
>>
>>>
>>> If a second vif is added and starts to scan, it's txpower is not initialized yet
>>> and it set to zero.
>>>
>>> ath10k had a patch to ignore zero values, but then it is impossible to actually set
>>> txpower to zero.
>>>
>>> So, instead initialize the txpower to -1 in mac80211, and let drivers know that
>>> means the power has not been set and so should be ignored.
>>>
>>> This should fix regression in:
>>>
>>> commit 88407beb1b1462f706a1950a355fd086e1c450b6
>>> Author: Ryan Hsu <ryanhsu@qca.qualcomm.com>
>>> Date:   Tue Dec 13 14:55:19 2016 -0800
>>>
>>>      ath10k: fix incorrect txpower set by P2P_DEVICE interface
>>>
>>> Tested on ath10k 9984 with ath10k-ct firmware.
>>>
>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>> ---
>>>   drivers/net/wireless/ath/ath10k/mac.c | 2 +-
>>>   drivers/net/wireless/ath/ath9k/main.c | 3 +++
>>>   drivers/net/wireless/ath/ath9k/xmit.c | 7 +++++--
>>>   include/net/mac80211.h                | 2 +-
>>>   net/mac80211/iface.c                  | 1 +
>>>   net/mac80211/main.c                   | 2 ++
>>>   6 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
>>> index 289d03da14b2..c846f232e930 100644
>>> --- a/drivers/net/wireless/ath/ath10k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath10k/mac.c
>>> @@ -5906,7 +5906,7 @@ static int ath10k_mac_txpower_recalc(struct ath10k *ar)
>>>       lockdep_assert_held(&ar->conf_mutex);
>>>
>>>       list_for_each_entry(arvif, &ar->arvifs, list) {
>>> -             if (arvif->txpower <= 0)
>>> +             if (arvif->txpower < 0) /* txpower not initialized yet? */
>>>                       continue;
>>>
>>>               if (txpower == -1)
>>> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
>>> index 14f253199909..2edf70cf7e7e 100644
>>> --- a/drivers/net/wireless/ath/ath9k/main.c
>>> +++ b/drivers/net/wireless/ath/ath9k/main.c
>>> @@ -1196,6 +1196,9 @@ static void ath9k_tpc_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
>>>   {
>>>       int *power = data;
>>>
>>> +     if (vif->bss_conf.txpower < 0)
>>> +             return;
>>> +
>>>       if (*power < vif->bss_conf.txpower)
>>>               *power = vif->bss_conf.txpower;
>>>   }
>>> diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
>>> index 751d0d0550b5..82c592ca2cd2 100644
>>> --- a/drivers/net/wireless/ath/ath9k/xmit.c
>>> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
>>> @@ -2114,10 +2114,13 @@ static void setup_frame_info(struct ieee80211_hw *hw,
>>>
>>>       if (tx_info->control.vif) {
>>>               struct ieee80211_vif *vif = tx_info->control.vif;
>>> -
>>> +             if (vif->bss_conf.txpower < 0)
>>> +                     goto nonvifpower;
>>>               txpower = 2 * vif->bss_conf.txpower;
>>>       } else {
>>> -             struct ath_softc *sc = hw->priv;
>>> +             struct ath_softc *sc;
>>> +     nonvifpower:
>>> +             sc = hw->priv;
>>>
>>>               txpower = sc->cur_chan->cur_txpower;
>>>       }
>>> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
>>> index 2b70b9268f76..db66520c5389 100644
>>> --- a/include/net/mac80211.h
>>> +++ b/include/net/mac80211.h
>>> @@ -569,7 +569,7 @@ struct ieee80211_ftm_responder_params {
>>>    * @ssid: The SSID of the current vif. Valid in AP and IBSS mode.
>>>    * @ssid_len: Length of SSID given in @ssid.
>>>    * @hidden_ssid: The SSID of the current vif is hidden. Only valid in AP-mode.
>>> - * @txpower: TX power in dBm
>>> + * @txpower: TX power in dBm.  -1 means not configured.
>>>    * @txpower_type: TX power adjustment used to control per packet Transmit
>>>    *  Power Control (TPC) in lower driver for the current vif. In particular
>>>    *  TPC is enabled if value passed in %txpower_type is
>>> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
>>> index b0c2df6e22c5..49fcf9d80f85 100644
>>> --- a/net/mac80211/iface.c
>>> +++ b/net/mac80211/iface.c
>>> @@ -1459,6 +1459,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
>>>       sdata->control_port_no_encrypt = false;
>>>       sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
>>>       sdata->vif.bss_conf.idle = true;
>>> +     sdata->vif.bss_conf.txpower = -1; /* unset */
>>>
>>>       sdata->noack_map = 0;
>>>
>>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>>> index a148509a88bc..2f53188851ee 100644
>>> --- a/net/mac80211/main.c
>>> +++ b/net/mac80211/main.c
>>> @@ -145,6 +145,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
>>>                       continue;
>>>               if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
>>>                       continue;
>>> +             if (sdata->vif.bss_conf.txpower < 0)
>>> +                     continue;
>>>               power = min(power, sdata->vif.bss_conf.txpower);
>>>       }
>>>       rcu_read_unlock();
>>>
>>
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
>>
>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
