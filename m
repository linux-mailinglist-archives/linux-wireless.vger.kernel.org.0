Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCDF3A666
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2019 16:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfFIOhF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jun 2019 10:37:05 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:38267 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfFIOhE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jun 2019 10:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=2B/RIjGHUT/vsYG/v5Zt/3JaknSAy9TmyLhmt7XtUBg=;
        b=A3KbMpqYfU3xcPjB0rJvhgtG6Cj9B2adg6gtwbH/1LQ/jWsNyAh3DaoJBEw6l+BPmfOCjr9eWLxXROyymbXFjPhW6FrD2rubaxFrn1BtgYP1WCOLmW4+NCaktC3H9P+VqXDnihypMN8hGJBZydjjVbNnJJEJ+ItA4Fgq2FX4FUY=;
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
Message-ID: <0eea6d21-1de2-abc3-93f4-70ed04dac3df@newmedia-net.de>
Date:   Sun, 9 Jun 2019 16:36:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJ0CqmVBogQrqf4Gckr5gQ6tCrdZG=p60ZiC+-WW-yxt93+40Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [2003:c9:3f05:3a00:f095:7be4:6d09:fd49]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1hZywV-0005Wr-8f; Sun, 09 Jun 2019 16:37:07 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

by the way. this big fat kernel warning exists in all operation modes 
unless anything else but aes-128 ccmp is used. since the chipset is 
capable of doing gcmp etc. as well
it would be nice if this issue can be fixed. otherwise encryption 
support can be defined as "broken" for mt7615

Am 06.06.2019 um 18:19 schrieb Lorenzo Bianconi:
>> i tested your patch against a qca 9984 chipset using SAE and without
>> encryption. both did not work. the devices are connecting, but no data
>> connection is possible
> Hi Sebastian,
>
> I tested Ryder's patch using mt76x2 as mesh peer and it works fine for me.
> Could you please provide some more info?
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
