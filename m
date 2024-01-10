Return-Path: <linux-wireless+bounces-1503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4382452F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 16:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478951C222CA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1963B241F4;
	Thu,  4 Jan 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DAOUHpBP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407D2375B;
	Thu,  4 Jan 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A1FF60008;
	Thu,  4 Jan 2024 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704382902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FvXN4xvTiTgMyzMRSmABdNVZi9nrUpHczM3Ucu85Gk=;
	b=DAOUHpBPXnJDXdCxkA8g/d07BxjS9VXflLwgJD9e8K0ZfUUOPbdEAHjvzrQNfEuIxGr6iG
	kPVLXHuT83EmqiRxq81SgqKJYPkxd3+tI9TARZrf2AbrWRLYOp+FwrBhpjv/V0qFuaU6AV
	ylOQmD0q0x4jC3edy9+F6hAf91FYPv5kgZHzXQ0XIjO6NaeDfJXU1NkKsRzAtNr923hAJj
	cIQJSdUqfqiXBMXkCAiwAT+fOuDMj6Wc1w28nZknRrFvgi3XK+hb7lRlymENYYvVpnoWuC
	p4WGUsMmpiUdh9t/KabjnBWgFqgwmqiGZt53JSMIRE3tiee9EojlgiGxckMkDg==
Message-ID: <110ac63c-5d93-4f11-a064-b8b4a7994fec@bootlin.com>
Date: Thu, 4 Jan 2024 16:41:41 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: wilc1000: fix RCU usage in connect path
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev, kvalo@kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20240104143925.194295-1-alexis.lothore@bootlin.com>
 <20240104143925.194295-3-alexis.lothore@bootlin.com>
 <175febb5-f31a-4540-8b70-7206fef83760@wanadoo.fr>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <175febb5-f31a-4540-8b70-7206fef83760@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/4/24 16:30, Christophe JAILLET wrote:
> Le 04/01/2024 à 15:39, Alexis Lothoré a écrit :
>> From: Alexis Lothoré <alexis.lothore-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>>
>> With lockdep enabled, calls to the connect function from cfg802.11 layer
>> lead to the following warning:
>>
>> =============================
>> WARNING: suspicious RCU usage
>> 6.7.0-rc1-wt+ #333 Not tainted
>> -----------------------------
>> drivers/net/wireless/microchip/wilc1000/hif.c:386
>> suspicious rcu_dereference_check() usage!
>> [...]
>> stack backtrace:
>> CPU: 0 PID: 100 Comm: wpa_supplicant Not tainted 6.7.0-rc1-wt+ #333
>> Hardware name: Atmel SAMA5
>>   unwind_backtrace from show_stack+0x18/0x1c
>>   show_stack from dump_stack_lvl+0x34/0x48
>>   dump_stack_lvl from wilc_parse_join_bss_param+0x7dc/0x7f4
>>   wilc_parse_join_bss_param from connect+0x2c4/0x648
>>   connect from cfg80211_connect+0x30c/0xb74
>>   cfg80211_connect from nl80211_connect+0x860/0xa94
>>   nl80211_connect from genl_rcv_msg+0x3fc/0x59c
>>   genl_rcv_msg from netlink_rcv_skb+0xd0/0x1f8
>>   netlink_rcv_skb from genl_rcv+0x2c/0x3c
>>   genl_rcv from netlink_unicast+0x3b0/0x550
>>   netlink_unicast from netlink_sendmsg+0x368/0x688
>>   netlink_sendmsg from ____sys_sendmsg+0x190/0x430
>>   ____sys_sendmsg from ___sys_sendmsg+0x110/0x158
>>   ___sys_sendmsg from sys_sendmsg+0xe8/0x150
>>   sys_sendmsg from ret_fast_syscall+0x0/0x1c
>>
>> This warning is emitted because in the connect path, when trying to parse
>> target BSS parameters, we dereference a RCU pointer whithout being in RCU
>> critical section.
>> Fix RCU dereference usage by moving it to a RCU read critical section. To
>> avoid wrapping the whole wilc_parse_join_bss_param under the critical
>> section, just use the critical section to copy ies data
>>
>> Fixes: c460495ee072 ("staging: wilc1000: fix incorrent type in initializer")
>> Signed-off-by: Alexis Lothoré
>> <alexis.lothore-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
>> ---
>>   drivers/net/wireless/microchip/wilc1000/hif.c | 35 ++++++++++++-------
>>   1 file changed, 23 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c
>> b/drivers/net/wireless/microchip/wilc1000/hif.c
>> index 6f1218a51061..806b7337b5ae 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/hif.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/hif.c
>> @@ -377,38 +377,48 @@ struct wilc_join_bss_param *
>>   wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>>                 struct cfg80211_crypto_settings *crypto)
>>   {
>> -    const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
>> -    const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
>> +    const u8 *ies_data, *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
>>       const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
>>       struct ieee80211_p2p_noa_attr noa_attr;
>> +    const struct cfg80211_bss_ies *ies;
>>       struct wilc_join_bss_param *param;
>> -    u8 rates_len = 0;
>> +    u8 rates_len = 0, ies_len;
>>       int ret;
>>         param = kzalloc(sizeof(*param), GFP_KERNEL);
>>       if (!param)
>>           return NULL;
>>   +    rcu_read_lock();
>> +    ies = rcu_dereference(bss->ies);
>> +    ies_data = kmemdup(ies->data, ies->len, GFP_ATOMIC);
> 
> Is it mandatory to have GFP_ATOMIC here?
> If yes, then some other drivers may need to be fixed (at least [1]).

From my understanding: yes, because if any sleep occurs in a section protected
by rcu_read_lock/rcu_read_unlock, it may mess with RCU grace period wait (and
so, rcu reclaim step may occur while this reader is still in the read section)

> 
>> +    if (!ies_data) {
>> +        rcu_read_unlock();
> 
> 'param' allocated just a few lines above is leaking now.

You are right, good catch, thanks. I will update accordingly.
> 
> CJ
> 
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pci/p2pdma.c#n660
> 
> 
>> +        return NULL;
>> +    }
>> +    ies_len = ies->len;
>> +    rcu_read_unlock();
>> +
>>       param->beacon_period = cpu_to_le16(bss->beacon_interval);
>>       param->cap_info = cpu_to_le16(bss->capability);
>>       param->bss_type = WILC_FW_BSS_TYPE_INFRA;
>>       param->ch = ieee80211_frequency_to_channel(bss->channel->center_freq);
>>       ether_addr_copy(param->bssid, bss->bssid);
>>   -    ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies->data, ies->len);
>> +    ssid_elm = cfg80211_find_ie(WLAN_EID_SSID, ies_data, ies_len);
>>       if (ssid_elm) {
>>           if (ssid_elm[1] <= IEEE80211_MAX_SSID_LEN)
>>               memcpy(param->ssid, ssid_elm + 2, ssid_elm[1]);
>>       }
>>   -    tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies->data, ies->len);
>> +    tim_elm = cfg80211_find_ie(WLAN_EID_TIM, ies_data, ies_len);
>>       if (tim_elm && tim_elm[1] >= 2)
>>           param->dtim_period = tim_elm[3];
>>         memset(param->p_suites, 0xFF, 3);
>>       memset(param->akm_suites, 0xFF, 3);
>>   -    rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies->data, ies->len);
>> +    rates_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies_data, ies_len);
>>       if (rates_ie) {
>>           rates_len = rates_ie[1];
>>           if (rates_len > WILC_MAX_RATES_SUPPORTED)
>> @@ -419,7 +429,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>>         if (rates_len < WILC_MAX_RATES_SUPPORTED) {
>>           supp_rates_ie = cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES,
>> -                         ies->data, ies->len);
>> +                         ies_data, ies_len);
>>           if (supp_rates_ie) {
>>               u8 ext_rates = supp_rates_ie[1];
>>   @@ -434,11 +444,11 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>>           }
>>       }
>>   -    ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies->data, ies->len);
>> +    ht_ie = cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies_data, ies_len);
>>       if (ht_ie)
>>           param->ht_capable = true;
>>   -    ret = cfg80211_get_p2p_attr(ies->data, ies->len,
>> +    ret = cfg80211_get_p2p_attr(ies_data, ies_len,
>>                       IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
>>                       (u8 *)&noa_attr, sizeof(noa_attr));
>>       if (ret > 0) {
>> @@ -462,7 +472,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>>       }
>>       wmm_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
>>                        WLAN_OUI_TYPE_MICROSOFT_WMM,
>> -                     ies->data, ies->len);
>> +                     ies_data, ies_len);
>>       if (wmm_ie) {
>>           struct ieee80211_wmm_param_ie *ie;
>>   @@ -477,13 +487,13 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>>         wpa_ie = cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
>>                        WLAN_OUI_TYPE_MICROSOFT_WPA,
>> -                     ies->data, ies->len);
>> +                     ies_data, ies_len);
>>       if (wpa_ie) {
>>           param->mode_802_11i = 1;
>>           param->rsn_found = true;
>>       }
>>   -    rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies->data, ies->len);
>> +    rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies_data, ies_len);
>>       if (rsn_ie) {
>>           int rsn_ie_len = sizeof(struct element) + rsn_ie[1];
>>           int offset = 8;
>> @@ -517,6 +527,7 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
>>               param->akm_suites[i] = crypto->akm_suites[i] & 0xFF;
>>       }
>>   +    kfree(ies_data);
>>       return (void *)param;
>>   }
>>   
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


