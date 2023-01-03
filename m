Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B110D65BF5D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 12:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbjACLvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 06:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjACLvX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 06:51:23 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 03:51:22 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0EF35
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 03:51:21 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVMqF-1pLITi3WnX-00SPAk; Tue, 03 Jan 2023 12:46:13 +0100
Message-ID: <bfc40f5a-3b36-0fb2-8db9-66b7c54fdac3@i2se.com>
Date:   Tue, 3 Jan 2023 12:46:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: brcmfmac: Unexpected cfg80211_set_channel: set chanspec ... fail,
 reason -52
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
 <1f428e2b-f73f-64ff-02d3-eefbcd11db89@broadcom.com>
 <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HtqqSzkLGXeqeqA4H2KAfYv6flXgOU1w8cpa8fcHTRRVQWVOOMZ
 M4ecDpmGLgHhh3LAeUgORJywe8dHtWpifmCYCxx2uEV3tvAjQvPVNRjDP+KWHrhow5N2nVU
 JG2P5l3AkLyF3f6LrtUYd/ElcWHKMdIptqoJHITgdYd7kXgXinXX5amXewKF7qJIUB3g3+Y
 n/j0ltNCkfNg5pNFj57nQ==
UI-OutboundReport: notjunk:1;M01:P0:MiMJMTVRqRQ=;ImBjK9tNOgXUnKYBHMmIj/j0gLp
 p+2VyTHXMhKrIve/2Kb1CAS1v4XRqm0+e0qZQx3+qzFUoBY+7oBA6ULDcSK1zZaO0DDQJn0ke
 x+JJKbFeEE9wrnOxGL5AFhkfPiHOE7V50s6nFyM+vAZHBf+cvsnAx5M2x/bIJU2O/98dy6n1I
 D7WuR+lDgAzrK6GLlVbg9dOWpmESjauvzlB2sgm2kf2vODpP5m+toHboZ03o65dAclaHdihEg
 ArcLWAG5ZyvFFAHaGwOhIg+iTn+kMXc4TlMauCj0jLKY7kDept6vZmdYBZhkognNj6y4zNipP
 qV81fftbPM23GRxMrD8nAihxHdQNkSfntdM48QenV0me082wJcgKJJDtSus3L3M56cEO4Qovi
 Xkiz2ixf8nT/yx2tAzV6aBK8YMT4dscP7jwxEDS4ByqxETNN09Rkk++mPom0orFdh6kWoOvSB
 36Ge1EytUPCd6W1xYUBfyzl4vZv3wTGHDBtc3ZvPDvcE1q6B8czK4VEVb7RF2ll7buYZIScRy
 fqIVobZgLexomNVkcEtHxp/YlhAnzz8LiltF6kcYGGFSLFJxcBwIhyqNjbWK9joraoxVjHYh0
 052VH0Pt5dvxsB8UCNjffdT87YtSeqp3/5FuOEsJ7HuuxqHSdxzT/6Dzqt0DNWY6qkkGjxjfd
 PPzC+k6imBhOTTBrwris1wykLE6/RVKXwm1Fc5T0xg==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Am 03.01.23 um 08:07 schrieb Johannes Berg:
> Hi,
>
>
>>> [  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail,
>>> reason -52
> [...]
>
>>> All of these 10 errors are repeated every 60 sec.
>> Catching up after the holidays ;-) Above chanspec values are invalid.
>> 0x100e = channel 14/bw 20MHz. The 'iw list' output shows all these
>> channels are disabled. So who/what is trying to set these channels.
>> Scanning sets the channel in firmware. Is this initiated from hostapd?
> Yeah, what userspace is running here?
i'm using Raspberry Pi OS. It's a debian based distribution optimized 
for Raspberry Pi. I suspect this comes from a lxpanel widget which 
allows to select a SSID from available wifi networks. ps commands also 
shows a running wpa_supplicant.
> Looks like cfg80211_set_channel()
> is only used for survey?
>
> Couple of observations on the side:
>   * might be nice to have some "brcm" indication in that name :P
>   * dump_survey should just dump data, not actually implement the data
>     collection, I think?
>
>
>> Maybe trying ACS?
>>
> Seems it must be something like that.
>
>> As these are marked as disabled user-space should not
>> use them. What I don't understand is why these pass the cfg80211 layer
>> so adding Johannes here.
>>
> Well that goes back to my earlier observation above: dump_survey()
> should just dump all *available* data, not actually try to *collect*
> data. So if userspace requests data for a channel that's disabled,
> that's actually OK, but you shouldn't _have_ any data for that channel
> since it's disabled. Also nl80211 won't send the data out if it exists,
> but there's no check to see if asking the driver makes sense since if
> it's a channel that exists, it should be valid to ask the driver if it
> has data - it just shouldn't have any.
>
> The way it works in mac80211 is that survey data is collected during
> scan, I think?
>
> johannes
