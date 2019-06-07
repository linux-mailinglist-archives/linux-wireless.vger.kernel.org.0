Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198EC38416
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 08:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfFGGEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 02:04:16 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:46165 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfFGGEQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 02:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=hbFWgnGZTUGaPNuuRP7tTcnFOL1g5weZZi+2V4ndpQE=;
        b=Tq8NwgqJrq2oLvvM1ouxMds4Cpixnez/8rfCQr6PeASo2fV/u13nA7EJ6AsZXYDVfm3ZZIUaNeXwCiXqb5RcmjGiRIl5Juq2YNVm+erZMlMQpiNtvNqOHzVbAH/ZJOrp4+FFfTQ4hWNwzLebIfnr+hIn/Aov9jCbPkPAmF2fFXA=;
Subject: Re: [PATCH v3 1/2] mt76: mt7615: enable support for mesh
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Chih-Min Chen <chih-min.Chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <a1ff446dfc06e2443552e7ec2d754099aacce7df.1559541944.git.ryder.lee@mediatek.com>
 <ade7ef01-8b06-ec7d-4caf-e581f4033819@newmedia-net.de>
 <CAJ0CqmVBogQrqf4Gckr5gQ6tCrdZG=p60ZiC+-WW-yxt93+40Q@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <a09e5c36-e610-e5eb-51c1-f1f634ee8591@newmedia-net.de>
Date:   Fri, 7 Jun 2019 08:03:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJ0CqmVBogQrqf4Gckr5gQ6tCrdZG=p60ZiC+-WW-yxt93+40Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2003:c9:3f05:3a00:1884:73db:702a:507]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1hZ7yk-0002vB-Kv; Fri, 07 Jun 2019 08:04:17 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 06.06.2019 um 18:19 schrieb Lorenzo Bianconi:
>> i tested your patch against a qca 9984 chipset using SAE and without
>> encryption. both did not work. the devices are connecting, but no data
>> connection is possible
> Hi Sebastian,
>
> I tested Ryder's patch using mt76x2 as mesh peer and it works fine for me.
> Could you please provide some more info?

the peer was a QCA9984 chipset running ath10k. the following wpa 
supplicant config was used
and encryption clearly cannot work since mt76_wcid_key_setup does 
trigger a bug  since ieeee_get_key_rx_seq does not accept tid as 
argument != 0 for aes_cmac (which is used for sae)
consider the same setup works with ath5k, 9k and 10k perfect with no 
issues. in my test setup i also connected now 3 devices. 2 9984 and 1 
mt7615 to ensure that all is working. the qca 9984 devices can ping each 
other, only the mt7615 does not work. the setups are all identical 
(except for ips)

fast_reauth=1
eapol_version=1
sae_groups=19 20 21
network={
         disable_ht40=1
         ssid="mt7615-24"
         mode=5
         frequency=2452
         htmode=HT20
         scan_ssid=1
         key_mgmt=SAE
         ieee80211w=2
         noscan=1
         pairwise=CCMP
         group=CCMP
         proto=RSN
         sae_password="12345678"
}

and the bug again

WARNING: CPU: 2 PID: 22086 at 
/home/seg/DEV/mt7621/src/router/private/compat-wireless-2017-09-03/net/mac80211/key.c:1096 
mt76_wcid_key_setup+0x58/0x9c [mt76]
Modules linked in: shortcut_fe gcm ghash_generic ctr gf128mul mt7615e 
mt76 mac80211 compat
CPU: 2 PID: 22086 Comm: wpa_supplicant Tainted: G        W 4.14.123 #106
Stack : 00000000 87c2d000 00000000 8007d8b4 80480000 80482b9c 80610000 
805a4390
         8057e2b4 87c4b99c 870a59dc 805e4767 80578288 00000001 87c4b940 
805e9f78
         00000000 00000000 80640000 00000000 81147bb8 000006ce 00000007 
00000000
         00000000 80650000 80650000 20202020 80000000 00000000 80610000 
872b9fe0
         872a2b14 00000448 00000000 87c2d000 00000010 8022d660 00000008 
80640008
         ...
Call Trace:
[<800153e0>] show_stack+0x58/0x100
[<8042e83c>] dump_stack+0x9c/0xe0
[<800349f0>] __warn+0xe4/0x144
[<8003468c>] warn_slowpath_null+0x1c/0x30
[<872b9fe0>] mt76_wcid_key_setup+0x58/0x9c [mt76]
[<87611690>] mt7615_eeprom_init+0x7b4/0xe9c [mt7615e]
---[ end trace e24aeb4b542e0df9 ]---


>
> Regards,
> Lorenzo
>
>>
>> Sebastian
>>
>> Am 03.06.2019 um 08:08 schrieb Ryder Lee:
>>> Enable NL80211_IFTYPE_MESH_POINT and update its path.
>>>
>>> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>>> ---
>>> Changes since v3 - fix a wrong expression
>>> Changes since v2 - remove unused definitions
>>> ---
>>>    drivers/net/wireless/mediatek/mt76/mt7615/init.c | 6 ++++++
>>>    drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
>>>    drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 4 +++-
>>>    drivers/net/wireless/mediatek/mt76/mt7615/mcu.h  | 6 ------
>>>    4 files changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
>>> index 59f604f3161f..f860af6a42da 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
>>> @@ -133,6 +133,9 @@ static const struct ieee80211_iface_limit if_limits[] = {
>>>        {
>>>                .max = MT7615_MAX_INTERFACES,
>>>                .types = BIT(NL80211_IFTYPE_AP) |
>>> +#ifdef CONFIG_MAC80211_MESH
>>> +                      BIT(NL80211_IFTYPE_MESH_POINT) |
>>> +#endif
>>>                         BIT(NL80211_IFTYPE_STATION)
>>>        }
>>>    };
>>> @@ -195,6 +198,9 @@ int mt7615_register_device(struct mt7615_dev *dev)
>>>        dev->mt76.antenna_mask = 0xf;
>>>
>>>        wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
>>> +#ifdef CONFIG_MAC80211_MESH
>>> +                              BIT(NL80211_IFTYPE_MESH_POINT) |
>>> +#endif
>>>                                 BIT(NL80211_IFTYPE_AP);
>>>
>>>        ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
>>> index b0bb7cc12385..585e67fa2728 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
>>> @@ -37,6 +37,7 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
>>>
>>>        switch (type) {
>>>        case NL80211_IFTYPE_AP:
>>> +     case NL80211_IFTYPE_MESH_POINT:
>>>                /* ap use hw bssid 0 and ext bssid */
>>>                if (~mask & BIT(HW_BSSID_0))
>>>                        return HW_BSSID_0;
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
>>> index 43f70195244c..e82297048449 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
>>> @@ -754,6 +754,7 @@ int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
>>>
>>>        switch (vif->type) {
>>>        case NL80211_IFTYPE_AP:
>>> +     case NL80211_IFTYPE_MESH_POINT:
>>>                tx_wlan_idx = mvif->sta.wcid.idx;
>>>                conn_type = CONNECTION_INFRA_AP;
>>>                break;
>>> @@ -968,7 +969,7 @@ int mt7615_mcu_add_wtbl(struct mt7615_dev *dev, struct ieee80211_vif *vif,
>>>                .rx_wtbl = {
>>>                        .tag = cpu_to_le16(WTBL_RX),
>>>                        .len = cpu_to_le16(sizeof(struct wtbl_rx)),
>>> -                     .rca1 = vif->type != NL80211_IFTYPE_AP,
>>> +                     .rca1 = vif->type == NL80211_IFTYPE_STATION,
>>>                        .rca2 = 1,
>>>                        .rv = 1,
>>>                },
>>> @@ -1042,6 +1043,7 @@ static void sta_rec_convert_vif_type(enum nl80211_iftype type, u32 *conn_type)
>>>    {
>>>        switch (type) {
>>>        case NL80211_IFTYPE_AP:
>>> +     case NL80211_IFTYPE_MESH_POINT:
>>>                if (conn_type)
>>>                        *conn_type = CONNECTION_INFRA_STA;
>>>                break;
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
>>> index e96efb13fa4d..0915cb735699 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
>>> @@ -105,25 +105,19 @@ enum {
>>>    #define STA_TYPE_STA                BIT(0)
>>>    #define STA_TYPE_AP         BIT(1)
>>>    #define STA_TYPE_ADHOC              BIT(2)
>>> -#define STA_TYPE_TDLS                BIT(3)
>>>    #define STA_TYPE_WDS                BIT(4)
>>>    #define STA_TYPE_BC         BIT(5)
>>>
>>>    #define NETWORK_INFRA               BIT(16)
>>>    #define NETWORK_P2P         BIT(17)
>>>    #define NETWORK_IBSS                BIT(18)
>>> -#define NETWORK_MESH         BIT(19)
>>> -#define NETWORK_BOW          BIT(20)
>>>    #define NETWORK_WDS         BIT(21)
>>>
>>>    #define CONNECTION_INFRA_STA        (STA_TYPE_STA | NETWORK_INFRA)
>>>    #define CONNECTION_INFRA_AP (STA_TYPE_AP | NETWORK_INFRA)
>>>    #define CONNECTION_P2P_GC   (STA_TYPE_STA | NETWORK_P2P)
>>>    #define CONNECTION_P2P_GO   (STA_TYPE_AP | NETWORK_P2P)
>>> -#define CONNECTION_MESH_STA  (STA_TYPE_STA | NETWORK_MESH)
>>> -#define CONNECTION_MESH_AP   (STA_TYPE_AP | NETWORK_MESH)
>>>    #define CONNECTION_IBSS_ADHOC       (STA_TYPE_ADHOC | NETWORK_IBSS)
>>> -#define CONNECTION_TDLS              (STA_TYPE_STA | NETWORK_INFRA | STA_TYPE_TDLS)
>>>    #define CONNECTION_WDS              (STA_TYPE_WDS | NETWORK_WDS)
>>>    #define CONNECTION_INFRA_BC (STA_TYPE_BC | NETWORK_INFRA)
>>>
