Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B940D4AD43E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 10:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352731AbiBHJBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 04:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiBHJBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 04:01:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063ABC03FEC0
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 01:01:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6323B81884
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 09:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B88C004E1;
        Tue,  8 Feb 2022 09:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644310896;
        bh=jLscdLcjMlkK+QLEwBpKzStF/9g0dReHw4FfwlufyWc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W8ovvAKDWW7xkOkWPTp5z6DNINBBNb6TU23vS7oYgNBMQavFKA6P5XQls2poX6N8+
         yhT8s9CgcCiotfD6KazqL3uwJak5humgfJEkaHaH59YcDVyKYdQgAYpp+gND3yiVuh
         Mt+b4M2orMzgU0gZXygo/x5oWRqqbKHxOwsuLhoAtgBOi7PdEHf7M6LSDW26WAyDYb
         jm4zkVVuclEeT/0qyxqA2QggSSgLV/CVPLNtLT34PjcqfjBGor5CfgcDwHshSTB6zo
         F11xPpY58lkGLN9riiy77wsXen1ndl6KYoYmjxrX3NmvVbC6anurOsXpVKnszpINMV
         /WBoIOKfDNxmg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Funny log entries for rtw88_8821ce
References: <c356d5ae-a7b3-3065-1121-64c446e70333@lwfinger.net>
        <32f2ece8acdb67f74757cb705e5467847d6bcae0.camel@realtek.com>
        <ef7361eb-17ce-5ecf-a46a-a9f0c5aab35b@lwfinger.net>
Date:   Tue, 08 Feb 2022 11:01:32 +0200
In-Reply-To: <ef7361eb-17ce-5ecf-a46a-a9f0c5aab35b@lwfinger.net> (Larry
        Finger's message of "Thu, 3 Feb 2022 14:06:08 -0600")
Message-ID: <87czjxbukz.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 2/1/22 00:26, Pkshih wrote:
>> On Mon, 2022-01-31 at 16:53 -0600, Larry Finger wrote:
>>> Ping-Ke and list,
>>>
>>> Within the last couple of days, I was testing rtw88 with an rtl8821ce card. I
>>> noticed that whenever the device is not connected to an AP, the log is flooded
>>> with messages like the following:
>>> [130462.603539] rtw_8821ce 0000:02:00.0: stop vif ee:a4:95:4e:53:8b on port 0
>>> [130463.116843] rtw_8821ce 0000:02:00.0: start vif aa:fc:19:66:5e:e2 on port 0
>>> [130874.613430] rtw_8821ce 0000:02:00.0: stop vif aa:fc:19:66:5e:e2 on port 0
>>> [130875.122641] rtw_8821ce 0000:02:00.0: start vif d2:e6:23:ba:98:76 on port 0
>>> [131286.677828] rtw_8821ce 0000:02:00.0: stop vif d2:e6:23:ba:98:76 on port 0
>>> [131287.192108] rtw_8821ce 0000:02:00.0: start vif 82:c4:33:96:2e:c6 on port 0\
>>
>> I turn off UI network-manager, and it can show the same messages if I use
>> 'ifconfig' to up and down the interfaces. I think add_interface()/remove_interface()
>> are called by ieee80211_do_open()/ieee80211_do_stop() in my test cases.
>>
>> Please check if your network-manager does the things. If so, check syslog to
>> know why it does.
>
> Utility journalctl show the following for a couple of cycles from
> start- to stop-vif:
>
> Feb 03 12:02:10 localhost.localdomain NetworkManager[608]: <info>
> [1643911330.5997] device (wls1): supplicant interface state:
> disconnected -> 
> interface_disabled
> Feb 03 12:02:10 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0:
> start vif 9a:cd:df:5f:24:13 on port 0
> Feb 03 12:02:10 localhost.localdomain NetworkManager[608]: <info>
> [1643911330.6179] device (wls1): supplicant interface state:
> interface_disabled -> disconnected
> Feb 03 12:09:02 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0:
> stop vif 9a:cd:df:5f:24:13 on port 0
> Feb 03 12:09:02 localhost.localdomain NetworkManager[608]: <info>
> [1643911742.0704] device (wls1): set-hw-addr: set MAC address to
> 1A:73:93:A8:7E:9C (scanning)
> Feb 03 12:09:02 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0:
> start vif 1a:73:93:a8:7e:9c on port 0
> Feb 03 12:09:02 localhost.localdomain NetworkManager[608]: <info>
> [1643911742.5891] device (wls1): supplicant interface state:
> disconnected -> 
> interface_disabled
> Feb 03 12:09:02 localhost.localdomain NetworkManager[608]: <info>
> [1643911742.5946] device (wls1): supplicant interface state:
> interface_disabled -> disconnected
> Feb 03 12:15:54 localhost.localdomain NetworkManager[608]: <info>
> [1643912154.0710] device (wls1): set-hw-addr: set MAC address to
> 42:CB:4C:C7:CB:00 (scanning)
> Feb 03 12:15:54 localhost.localdomain kernel: rtw_8821ce 0000:02:00.0:
> stop vif 1a:73:93:a8:7e:9c on port 0
>
> From these log entries, I see no reason why there should be a stop-vif
> 412 seconds after the interface is set from disabled to disconnected.
> This cycling does not cause any problems. Perhaps the statements that
> do the logging should be removed.

I did a quick check on how rtw88 uses rtw_info() and indeed that should
be cleaned up.

These should be warning or error messages:

rtw_info(rtwdev, "invalid H2C command format for debug\n");
rtw_info(rtwdev, "incorrect lna index (%d)\n", lna_idx);
rtw_info(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
rtw_info(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);
rtw_info(rtwdev, "unsupported tx path 0x%x\n", antenna_tx);
rtw_info(rtwdev, "unsupported rx path 0x%x\n", antenna_rx);

Not sure if warn or debug, most likely debug:

rtw_info(rtwdev, "HW scan aborted with code: %d\n", rc);

These should be debug messages to avoid spamming the logs:

rtw_info(rtwdev, "start vif %pM on port %d\n", vif->addr, rtwvif->port);
rtw_info(rtwdev, "stop vif %pM on port %d\n", vif->addr, rtwvif->port);
rtw_info(rtwdev, "change vif %pM (%d)->(%d), p2p (%d)->(%d)\n",
rtw_info(rtwdev, "sta %pM joined with macid %d\n",
rtw_info(rtwdev, "sta %pM with macid %d left\n",
rtw_info(rtwdev, "On freq %u to %u, set SAR %d in 1/%lu dBm\n"

This is ok:

rtw_info(rtwdev, "Firmware version %u.%u.%u, H2C version %u\n",

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
