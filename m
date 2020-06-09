Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD491F3F2D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgFIPYL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 11:24:11 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:37344 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgFIPYL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 11:24:11 -0400
Received: from [192.168.254.4] (unknown [50.34.197.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id C81C813C2B1;
        Tue,  9 Jun 2020 08:24:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C81C813C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1591716250;
        bh=2d7k1yl0VFZTgP4ppt4CWi/BOS9sY64dj84tCjTtAnw=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=WKDb5ssP+9r8iMpqeUHzJY3JE+dyGy1bxb/lmEB/xN3d1vS7e+/9c2/3zHi8NGIGN
         VB5rixiM4vsPYWECET4px0IjM4B4N8Ysz9yycIGIjqlsIvSfG2v0BqBYuctE4Gf/dD
         Kqr8aPOmPVcWTvbWsgrPfRy39k09XHuuiw/6EH6k=
Subject: Re: ax200 very poor performance in stock 5.7.0 and 53.c3 firmware.
To:     Tim Higgins <tim@timhiggins.com>
References: <c2898228-836e-549b-85ee-8c2d24051912@candelatech.com>
 <3B9D5022-D95A-4CC3-B8A0-1104358F241E@timhiggins.com>
 <8f1f9938-2fa6-38ca-b9e8-c792078ee3c1@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <d54f2506-36db-3888-9460-a1170d892104@candelatech.com>
Date:   Tue, 9 Jun 2020 08:24:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <8f1f9938-2fa6-38ca-b9e8-c792078ee3c1@candelatech.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/04/2020 07:38 AM, Ben Greear wrote:
>
>
> On 06/04/2020 04:35 AM, Tim Higgins wrote:
>>
>>
>>> On Jun 3, 2020, at 11:54 PM, Ben Greear <greearb@candelatech.com> wrote:
>>>
>>> I'm testing an un-modified kernel for a change, and latest firmware that I could find,
>>> but ax200 is still sucking.
>>>
>>> UDP upload of single ax200 station gets about 1Mbps, and station disconnects
>>> very often.  TCP download gets about 400Mbps on each of two radios.  UDP download stalls
>>> often and averages around 1Mbps throughput.  TCP upload also stalls out.
>>>
>>> Previous testing on other kernels has shown problems with other firmware as well.
>>>
>>> I'm requesting 500Mbps UDP speeds.    Requesting only 100Mbps does not help (tested with DL direction only).
>>>
>>> [root@ct523c-0b29 ~]# ethtool -i wlan2
>>> driver: iwlwifi
>>> version: 5.7.0
>>> firmware-version: 53.c31ac674.0 cc-a0-53.ucode
>>> expansion-rom-version:
>>> bus-info: 0000:12:00.0
>>> supports-statistics: yes
>>> supports-test: no
>>> supports-eeprom-access: no
>>> supports-register-dump: no
>>> supports-priv-flags: no
>>>
>>>
>>> Is there any way to disable OFDMA or /ax on the ax200 in case that helps somehow?
>>>
>>> Thanks,
>>> Ben
>> Hi Ben,
>> Try running with no encryption. I know that is not a solution. But it could point to a cause. I've seen disabling encryption make a big difference.
>
> I set to open auth (was using wpa3 PSK previously), and started TCP upload on two stations.  One is doing around 80Mbps, the other seems to have crashed the firmware
> and will not recover.

To follow up on this...

I tried the backports-iwlwifi project, and that driver is significantly more stable.  But, you cannot use any other
mac80211 driver (ie, ath10k) with the backport-iwlwifi modules loaded since the ath10k would have been compiled against a different
mac80211 and then ath10k crashes on startup.

So, I ported the backports-iwlwifi driver into my 5.4 kernel, and enough of the mac80211 changes as well so it could
compile.

This is working OK-ish, though FW still crashes and wlans don't always restart properly after crash.

Looks like I can work around this last part by bouncing things in user-space after detecting a crash...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
