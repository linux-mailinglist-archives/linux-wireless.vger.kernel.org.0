Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19B221568B
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 13:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgGFLm1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 07:42:27 -0400
Received: from mail.as201155.net ([185.84.6.188]:24934 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgGFLm1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 07:42:27 -0400
X-Greylist: delayed 1651 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 07:42:26 EDT
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:38774 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jsP5H-0000sX-1Y; Mon, 06 Jul 2020 13:14:51 +0200
X-CTCH-RefID: str=0001.0A782F19.5F0307AB.0075,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=/tRKIrIXd5gepOkVUS+OcgxOulReGiWpEs/ZTFzQ6dA=;
        b=tyYUudS/cLztEgOiSLXzh1URoM06iA6tND9bPy9VWb7VC7ANSd4qiguczSuy5WLlcL7+W7IJaMeC/B9TBuhp28635wwssUvvDp6UP5qzA3aKMQjwmpbLDHvlUJujHKoenZQjx0bpGhQ21WJSdxjxzCBFNEIyBAZKCllKDESSvKk=;
Subject: Re: [PATCH 2/2] rt2x00: define RF5592 in init_eeprom routine
To:     Stanislaw Gruszka <sgruszka@redhat.com>,
        =?UTF-8?Q?Tomislav_Po=c5=beega?= <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        hauke@hauke-m.de, nbd@nbd.name, john@phrozen.org,
        daniel@makrotopia.org, John Crispin <blogic@openwrt.org>
References: <1545919526-4074-1-git-send-email-pozega.tomislav@gmail.com>
 <1545919526-4074-2-git-send-email-pozega.tomislav@gmail.com>
 <20190102083728.GB5300@redhat.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <ba58b183-782d-fe3d-a376-33034b46551d@dd-wrt.com>
Date:   Mon, 6 Jul 2020 13:14:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20190102083728.GB5300@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:4d00:b116:deaa:e0c9:647b]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1jsP5H-000NeS-07; Mon, 06 Jul 2020 13:14:51 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

you are wrong. this is not a workaround for the crash (this is just a 
nice side effect). i had the same issue. the problem is that without 
that patch the device RF is not properly detected.
since the device eeprom contains a rev 0. the same issue is present on 
the Buffalo WHR-600D device

<6>rt2800pci 0000:01:00.0: loaded eeprom from mtd device "factory" 
offset 8000
<6>ieee80211 phy1: rt2x00_set_rt: Info - RT chipset 5592, rev 0222 detected
<3>ieee80211 phy1: rt2800_init_eeprom: Error - Invalid RF chipset 0x0000 
detected
<3>ieee80211 phy1: rt2x00lib_probe_dev: Error - Failed to allocate device


so this patch fixes the missdetection of the RF


Sebastian

Am 02.01.2019 um 09:37 schrieb Stanislaw Gruszka:
> On Thu, Dec 27, 2018 at 03:05:26PM +0100, Tomislav Požega wrote:
>> This patch fixes following crash on Linksys EA2750 during 5GHz wifi
>> init:
>>
>> [    7.955153] rt2800pci 0000:01:00.0: card - bus=0x1, slot = 0x0 irq=4
>> [    7.962259] rt2800pci 0000:01:00.0: loaded eeprom from mtd device "Factory"
>> [    7.969435] ieee80211 phy0: rt2x00_set_rt: Info - RT chipset 5592, rev 0222 detected
>> [    7.977348] ieee80211 phy0: rt2800_init_eeprom: Error - Invalid RF chipset 0x0000 detected
>> [    7.985793] ieee80211 phy0: rt2x00lib_probe_dev: Error - Failed to allocate device
>> [    7.993569] CPU 0 Unable to handle kernel paging request at virtual address 00000024, epc == 800c8f54, ra == 80249ff8
>> [    8.004408] Oops[#1]:
>>
>> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
>> ---
>>   drivers/net/wireless/ralink/rt2x00/rt2800lib.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>> index 7f813f6..86770e8 100644
>> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
>> @@ -8839,6 +8839,8 @@ static int rt2800_init_eeprom(struct rt2x00_dev *rt2x00dev)
>>   		rf = RF3322;
>>   	else if (rt2x00_rt(rt2x00dev, RT5350))
>>   		rf = RF5350;
>> +	else if (rt2x00_rt(rt2x00dev, RT5592))
>> +		rf = RF5592;
> This looks like workaround for the crash and AFICT it is not needed
> on upstream code. This most likely is a issue with below openwrt patch:
>
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=package/kernel/mac80211/patches/rt2x00/604-rt2x00-load-eeprom-on-SoC-from-a-mtd-device-defines-.patch;h=a98b49c541f5f76e73751c2fd2e5b85559854b87;hb=HEAD
>
> which for some unknown reason set:
>
> rt2x00dev->eeprom_file = &mtd_fw;
>
> which then crash on rt2x00lib_free_eeprom_file() -> release_firmware();
>
> Regards
> Stanislaw
>   
>
