Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6478179006
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2020 13:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgCDMGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Mar 2020 07:06:14 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:59793 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDMGO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Mar 2020 07:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=9UfmJz4ZiWTwwh8MjiI3e0ObR3oS0Sk95P2qUxQhVtM=;
        b=f5PhckSr8Je20l7X1ihl5YKvONY3Pljbm9sb1F2NIl+mmrY+FlBPV8EfIIt/CC9Iyeakc7tEe7heeNdm8Y6d1rmd8lGHZGn8IOKik376sWsAchJ8ViOiYC4BP4xbc+KyMXXnnRlU8tOznTpM1FMm2qX8G1mc74rWm6P7cJD9fkM=;
Subject: Re: wds link and Radius authentication issue
To:     Cedric VONCKEN <cedric.voncken@acksys.fr>,
        Johannes Berg <johannes@sipsolutions.net>,
        Steve deRosier <derosier@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "hostap@lists.infradead.org" <hostap@lists.infradead.org>
References: <DB8PR01MB5529861838C88EB28011451490E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <248012fc-f646-09a9-6ad2-3fd098f8b8d7@dd-wrt.com>
Date:   Wed, 4 Mar 2020 13:06:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <DB8PR01MB5529861838C88EB28011451490E40@DB8PR01MB5529.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:4000:b4c5:a148:50ef:ac2a]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1j9SkG-0003xA-Cu; Wed, 04 Mar 2020 13:03:24 +0100
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

consider my answer to you
have you tried to revert the patches i mentioned?

Sebastian

Am 03.03.2020 um 16:28 schrieb Cedric VONCKEN:
> The origin of the issue is  in VLAN sta feature and  WDS sta feature management.
> These both features are managed with the same code.
>
> In case of we use a WDS sta and 802.1x authentication that don't work.
> When the AP side receive the null function frame in 4addr format from the sta, hostapd create the sta netdev and call the NL message NL80211_CMD_SET_STATION. In mac80211 the function ieee80211_change_station assign the pointer vlansdata->u.vlan.sta.
>
> During the 802.1x authentication hostapd send the NL80211_CMD_SET_STATION message for add vlan management. I didn't understand why hostapd require this call, because in the msg no vlan information is given. With this second call, ieee80211_change_station function, set the vlansdata->u.vlan.sta to NULL . After that no frames are sent through the wds sta netdev and all frame are sent with 3 addr.
> In the sta side all frames received with 3 addr is droped if the sta is configured to use 4 addr header format.
>
> So no IP communication is possible between the AP and the STA.
>
> I tried to fix this issue, but I'm not sure where I should fix the issue (hostapd or mac80211).
> Finally, I found a workaround, in hostapd if I disabled the VLAN feature the issue is fixed (because the second call is not present). For the moment I don't use this feature so I can disabled it.
>
> I hope an mac80211/hostapd expert will fix this issue in next version.
>
> Thinks for your help.
>> -----Message d'origine-----
>> De : Johannes Berg <johannes@sipsolutions.net>
>> Envoyé : mardi 3 mars 2020 10:31
>> À : Cedric VONCKEN <cedric.voncken@acksys.fr>; Steve deRosier
>> <derosier@gmail.com>
>> Cc : linux-wireless@vger.kernel.org
>> Objet : Re: [mac80211]: wds link and Radius authentication issue
>>
>> Hi Cedric,
>>
>> Umm, that was hard to read. You should quote my writing, not your own :)
>>
>>
>>>> The wlan0.sta1 net dev was created by hostapd to manage the wds sta.
>>>> This netdev type is AP VLAN. The function ieee80211_lookup_ra_sta
>>>> return -ENOLINK because the pointer sdata->u.vlan.sta was not
>>>> defined.
>> Right.
>>
>>>> In mac80211, where this rcu pointer is allocated? Which NL message the
>> user space use ?
>>
>> Look at ieee80211_change_station(), called from nl80211_set_station() with
>>
>> 	params.vlan = get_vlan(info, rdev);
>>
>> johannes
