Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D315B1DBD8D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETTF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 15:05:28 -0400
Received: from achernar.uberspace.de ([95.143.172.237]:45786 "EHLO
        achernar.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETTF2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 15:05:28 -0400
Received: (qmail 28566 invoked from network); 20 May 2020 19:05:24 -0000
Received: from localhost (HELO ?192.168.1.133?) (127.0.0.1)
  by achernar.uberspace.de with SMTP; 20 May 2020 19:05:24 -0000
Subject: Re: [OpenWrt-Devel] [PATCH v13] ath10k: add LED and GPIO controlling
 support for various chipsets
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Sven Eckelmann <sven@narfation.org>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        openwrt-devel@lists.openwrt.org
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
References: <1523027875-5143-1-git-send-email-kvalo@codeaurora.org>
 <2468724.JaAZLprVu6@bentobox>
 <b23e65cf-4be7-72db-7955-32eae196953e@dd-wrt.com>
 <90f5adcb-488e-96e2-001e-7bf8d175dec6@ironai.com>
 <4df82bd4-cab4-55e2-7885-df86d22aed63@dd-wrt.com>
From:   Vincent Wiemann <vincent.wiemann@ironai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vincent.wiemann@ironai.com; prefer-encrypt=mutual; keydata=
 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
 sFWRrW2QGIhjT+Y4XMq8yZQ=
Message-ID: <8038d6a0-fa60-3fe9-a2f3-721ec2e365e9@ironai.com>
Date:   Wed, 20 May 2020 21:05:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4df82bd4-cab4-55e2-7885-df86d22aed63@dd-wrt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sebastian,

On 20.05.20 15:00, Sebastian Gottschall wrote:
> 
> Am 20.05.2020 um 12:40 schrieb Vincent Wiemann:
>> Hi Sebastian,
>>
>> I don't know why it was dropped, but I can say that the LED control code was kind of
>> annoying me. Even when the LED was turned of, it "flickered" when it was set disabled.
>> Unfortunately I didn't have time to look into it, yet.

> the led code will just be used if you set a trigger. otherwise it doesnt touch the gpios.
> the code itself was written to make use of the led's builtin to several routers. if you dont set a led trigger, nothing will happen
> 

Thank you for your quick response... I'll try to reproduce the issue without your patch.
Maybe it's unrelated and a firmware-specific issue (official QCA9887).

One thing I've seen with your patch is that if I set the ath10k GPIO "steady on" it sometimes
(quite randomly) turns it off for a fraction of a second. It happens about 3 times a minute.
It's not a big deal. But maybe it's related to the flickering
I've observed and possibly also a firmware issue...

Best,

Vincent


>> Best,
>>
>> Vincent
>>
>> On 20.05.20 09:39, Sebastian Gottschall wrote:
>>> this code is not in use in its original form for ipq4019.
>>> i have seen that his patch is also dropped from ath.git but is still in use by openwrt.
>>> could somone clarify the state here and why it was dropped?
>>> the original patch i wrote does exclude the soc chipsets, but the patch was later reorganized and some part have been rewritten
>>> so i'm not sure if it covers the scenario mentioned here, which i did take care of
>>>
>>> Sebastian
>>>
>>> Am 26.02.2019 um 10:16 schrieb Sven Eckelmann:
>>>> On Friday, 6 April 2018 17:17:55 CET Kalle Valo wrote:
>>>>> From: Sebastian Gottschall <s.gottschall@newmedia-net.de>
>>>>>
>>>>> Adds LED and GPIO Control support for 988x, 9887, 9888, 99x0, 9984 based
>>>>> chipsets with on chipset connected led's using WMI Firmware API.  The LED
>>>>> device will get available named as "ath10k-phyX" at sysfs and can be controlled
>>>>> with various triggers.  adds also debugfs interface for gpio control.
>>>>>
>>>>> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>>>> Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
>>>>> [kvalo: major reorg and cleanup]
>>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>>> This patch was imported to OpenWrt in commit 61d57a2f88b9 ("mac80211: ath10k
>>>> add leds support") and broke the 11s support for IPQ4019 and QCA4019 (5GHz)
>>>> firmware versions 10.4-3.5.3-00053, 10.4-3.5.3-00057, 10.4-3.6-00140:
>>>>
>>>>       [  221.620803] ath10k_pci 0000:01:00.0: wmi command 36967 timeout, restarting hardware
>>>>       [  221.744056] ieee80211 phy0: Hardware restart was requested
>>>>       [  225.130829] ath10k_pci 0000:01:00.0: failed to receive control response completion, polling..
>>>>       [  226.170824] ath10k_pci 0000:01:00.0: Service connect timeout
>>>>       [  226.170871] ath10k_pci 0000:01:00.0: failed to connect htt (-110)
>>>>       [  226.252248] ath10k_pci 0000:01:00.0: Could not init core: -110
>>>>
>>>> This was tested on an A62 with following wireless config:
>>>>
>>>>       config wifi-device 'radio0'
>>>>               option type 'mac80211'
>>>>               option channel '36'
>>>>               option hwmode '11a'
>>>>               option path 'soc/40000000.pci/pci0000:00/0000:00:00.0/0000:01:00.0'
>>>>               option htmode 'VHT80'
>>>>               option disabled '0'
>>>>               option country US
>>>>            config wifi-device 'radio1'
>>>>               option type 'mac80211'
>>>>               option channel '11'
>>>>               option hwmode '11g'
>>>>               option path 'platform/soc/a000000.wifi'
>>>>               option htmode 'HT20'
>>>>               option disabled '0'
>>>>               option country US
>>>>            config wifi-device 'radio2'
>>>>               option type 'mac80211'
>>>>               option channel '149'
>>>>               option hwmode '11a'
>>>>               option path 'platform/soc/a800000.wifi'
>>>>               option htmode 'VHT80'
>>>>               option disabled '0'
>>>>               option country US
>>>>            config wifi-iface 'mesh0'
>>>>           option device 'radio0'
>>>>           option ifname 'mesh0'
>>>>           option network 'nwi_mesh0'
>>>>           option mode 'mesh'
>>>>           option mesh_id 'TestMesh'
>>>>           option mesh_fwding '1'
>>>>           option encryption 'none'
>>>>            config wifi-iface 'mesh1'
>>>>           option device 'radio1'
>>>>           option ifname 'mesh1'
>>>>           option network 'nwi_mesh1'
>>>>           option mode 'mesh'
>>>>           option mesh_id 'TestMesh'
>>>>           option encryption 'none'
>>>>                 config wifi-iface 'mesh2'
>>>>           option device 'radio2'
>>>>           option ifname 'mesh2'
>>>>           option network 'nwi_mesh2'
>>>>           option mode 'mesh'
>>>>           option mesh_id 'TestMesh'
>>>>           option mesh_fwding '1'
>>>>           option encryption 'none
>>>>
>>>> Kind regards,
>>>>      Sven
>>> _______________________________________________
>>> openwrt-devel mailing list
>>> openwrt-devel@lists.openwrt.org
>>> https://lists.openwrt.org/mailman/listinfo/openwrt-devel
>>>
> 
> _______________________________________________
> openwrt-devel mailing list
> openwrt-devel@lists.openwrt.org
> https://lists.openwrt.org/mailman/listinfo/openwrt-devel
