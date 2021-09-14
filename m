Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE040A430
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhINDMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 23:12:48 -0400
Received: from smtp6.ctinetworks.com ([205.166.61.199]:38820 "EHLO
        smtp6.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbhINDMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 23:12:46 -0400
Received: from localhost (unknown [117.207.20.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp6.ctinetworks.com (Postfix) with ESMTPSA id 26AFB85D04
        for <linux-wireless@vger.kernel.org>; Mon, 13 Sep 2021 23:11:20 -0400 (EDT)
Date:   Tue, 14 Sep 2021 08:41:16 +0530 (IST)
Message-Id: <20210914.084116.1726846422542610443.enometh@meer.net>
To:     linux-wireless@vger.kernel.org
Subject:  Re: help troubleshooting failures connect to an access point with
 iw/iwd
From:   Madhu <enometh@meer.net>
References: <20210420.063244.1157699536418751229.enometh@meer.net>
        <9167fd6d-affa-21d5-bd8d-0fb3d49d38f0@justmail.de>
        <20210421.102130.167565230547376402.enometh@meer.net>
        <20210912.033932.2187976226343353888.enometh@meer.net>
X-Mailer: Mew version 6.8 on Emacs 28.0.50
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: 26AFB85D04.A8515
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1632453084.56048@skdk+a6O3UtsdcrVSuaZ9g
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


* I Wrote on Sun, 12 Sep 2021 03:39:32 +0530 (IST),
in <20210912.033932.2187976226343353888.enometh@meer.net> :

> I've been using wpa_supplicant with rtw88 and b43 cards to connect to
> a wpa-psk home router successfully for many years. This was with
> -Wext. However I'm not able to accomplish this with iw or iwd.

The iwd part of the story has a resolution:

> $/usr/libexec/iwd --version
> 1.17
> $/usr/libexec/iwd -d
> $ iwctl station wlan0 get-hidden-access-points
> $ iwctl --passphrase=XXX  station wlan0 connect SSID
>
> If this connects it always immediately disconnects
>
> kernel: [86195.924708] wlan0: authenticate with 58:xx:6e:xx:51:e4
> kernel: [86196.264641] wlan0: send auth to 58:xx:6e:xx:51:e4 (try 1/3)
> kernel: [86196.268477] wlan0: authenticated
> kernel: [86196.274379] wlan0: associate with 58:xx:6e:xx:51:e4 (try 1/3)
> kernel: [86196.281420] wlan0: RX AssocResp from 58:xx:6e:xx:51:e4
> (capab=0x411 status=0 aid=1)
> kernel: [86196.281491] rtw_8822ce 0000:xx:00.0: sta 58:xx:6e:xx:51:e4
> joined with macid 0
> kernel: [86196.282235] wlan0: associated
> kernel: [86238.445926] wlan0: deauthenticated from 58:xx:6e:xx:51:e4
> (Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA)
> kernel: [86238.594381] rtw_8822ce 0000:xx:00.0: sta 58:xx:6e:xx:51:e4 with macid 0 left
>
> - So an connection, after authentication immediately deauthenticates
>   with (Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA). The deauthentication
>   happens when any packet is to be sent on the interface

As was pointed out, this is avoided by a

[General]
ControlPortOverNL80211=False

item in /etc/iwd/main.conf

The other problems are outstanding.
