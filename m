Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FD1DB477
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 15:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgETNBM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 09:01:12 -0400
Received: from mail.as201155.net ([185.84.6.188]:29774 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETNBE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 09:01:04 -0400
X-Greylist: delayed 19271 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 09:01:02 EDT
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:38178 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jbOLB-0002Fx-2u; Wed, 20 May 2020 15:00:58 +0200
X-CTCH-RefID: str=0001.0A782F21.5EC529AC.0013,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=WHN059KMMKqt55KiF38hof7CfVor09VP7Rsqx7uRGGc=;
        b=A7CWcs0iqdeo+EHGaG2mTEZTqIPpTID4+3QXPyItk7Ni6tsJGYqDc7QmTkhUgkOq3gMhr/OtrTu+WLEn2A3R02z9XkKk2ACKy+8PUy1Y4DS4bhg49eGOKelR0urZ2XBKdtWOPruQYjL/8D/S7Mw3EbAloGNWgcT46bByYz8sXTQ=;
Subject: Re: [OpenWrt-Devel] [PATCH v13] ath10k: add LED and GPIO controlling
 support for various chipsets
To:     Vincent Wiemann <vincent.wiemann@ironai.com>,
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
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <4df82bd4-cab4-55e2-7885-df86d22aed63@dd-wrt.com>
Date:   Wed, 20 May 2020 15:00:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <90f5adcb-488e-96e2-001e-7bf8d175dec6@ironai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:4000:f846:4861:fc39:f688]
        by webmail.newmedia-net.de with esmtpa (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jbOGw-0002Im-Q8; Wed, 20 May 2020 14:56:37 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 20.05.2020 um 12:40 schrieb Vincent Wiemann:
> Hi Sebastian,
>
> I don't know why it was dropped, but I can say that the LED control code was kind of
> annoying me. Even when the LED was turned of, it "flickered" when it was set disabled.
> Unfortunately I didn't have time to look into it, yet.
the led code will just be used if you set a trigger. otherwise it doesnt 
touch the gpios.
the code itself was written to make use of the led's builtin to several 
routers. if you dont set a led trigger, nothing will happen

> Best,
>
> Vincent
>
> On 20.05.20 09:39, Sebastian Gottschall wrote:
>> this code is not in use in its original form for ipq4019.
>> i have seen that his patch is also dropped from ath.git but is still in use by openwrt.
>> could somone clarify the state here and why it was dropped?
>> the original patch i wrote does exclude the soc chipsets, but the patch was later reorganized and some part have been rewritten
>> so i'm not sure if it covers the scenario mentioned here, which i did take care of
>>
>> Sebastian
>>
>> Am 26.02.2019 um 10:16 schrieb Sven Eckelmann:
>>> On Friday, 6 April 2018 17:17:55 CET Kalle Valo wrote:
>>>> From: Sebastian Gottschall <s.gottschall@newmedia-net.de>
>>>>
>>>> Adds LED and GPIO Control support for 988x, 9887, 9888, 99x0, 9984 based
>>>> chipsets with on chipset connected led's using WMI Firmware API.  The LED
>>>> device will get available named as "ath10k-phyX" at sysfs and can be controlled
>>>> with various triggers.  adds also debugfs interface for gpio control.
>>>>
>>>> Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
>>>> Reviewed-by: Steve deRosier <derosier@cal-sierra.com>
>>>> [kvalo: major reorg and cleanup]
>>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>> This patch was imported to OpenWrt in commit 61d57a2f88b9 ("mac80211: ath10k
>>> add leds support") and broke the 11s support for IPQ4019 and QCA4019 (5GHz)
>>> firmware versions 10.4-3.5.3-00053, 10.4-3.5.3-00057, 10.4-3.6-00140:
>>>
>>>       [  221.620803] ath10k_pci 0000:01:00.0: wmi command 36967 timeout, restarting hardware
>>>       [  221.744056] ieee80211 phy0: Hardware restart was requested
>>>       [  225.130829] ath10k_pci 0000:01:00.0: failed to receive control response completion, polling..
>>>       [  226.170824] ath10k_pci 0000:01:00.0: Service connect timeout
>>>       [  226.170871] ath10k_pci 0000:01:00.0: failed to connect htt (-110)
>>>       [  226.252248] ath10k_pci 0000:01:00.0: Could not init core: -110
>>>
>>> This was tested on an A62 with following wireless config:
>>>
>>>       config wifi-device 'radio0'
>>>               option type 'mac80211'
>>>               option channel '36'
>>>               option hwmode '11a'
>>>               option path 'soc/40000000.pci/pci0000:00/0000:00:00.0/0000:01:00.0'
>>>               option htmode 'VHT80'
>>>               option disabled '0'
>>>               option country US
>>>            config wifi-device 'radio1'
>>>               option type 'mac80211'
>>>               option channel '11'
>>>               option hwmode '11g'
>>>               option path 'platform/soc/a000000.wifi'
>>>               option htmode 'HT20'
>>>               option disabled '0'
>>>               option country US
>>>            config wifi-device 'radio2'
>>>               option type 'mac80211'
>>>               option channel '149'
>>>               option hwmode '11a'
>>>               option path 'platform/soc/a800000.wifi'
>>>               option htmode 'VHT80'
>>>               option disabled '0'
>>>               option country US
>>>            config wifi-iface 'mesh0'
>>>           option device 'radio0'
>>>           option ifname 'mesh0'
>>>           option network 'nwi_mesh0'
>>>           option mode 'mesh'
>>>           option mesh_id 'TestMesh'
>>>           option mesh_fwding '1'
>>>           option encryption 'none'
>>>            config wifi-iface 'mesh1'
>>>           option device 'radio1'
>>>           option ifname 'mesh1'
>>>           option network 'nwi_mesh1'
>>>           option mode 'mesh'
>>>           option mesh_id 'TestMesh'
>>>           option encryption 'none'
>>>                 config wifi-iface 'mesh2'
>>>           option device 'radio2'
>>>           option ifname 'mesh2'
>>>           option network 'nwi_mesh2'
>>>           option mode 'mesh'
>>>           option mesh_id 'TestMesh'
>>>           option mesh_fwding '1'
>>>           option encryption 'none
>>>
>>> Kind regards,
>>>      Sven
>> _______________________________________________
>> openwrt-devel mailing list
>> openwrt-devel@lists.openwrt.org
>> https://lists.openwrt.org/mailman/listinfo/openwrt-devel
>>
