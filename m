Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7AF407AA5
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Sep 2021 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhIKWVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Sep 2021 18:21:48 -0400
Received: from smtp6.ctinetworks.com ([205.166.61.199]:60188 "EHLO
        smtp6.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKWVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Sep 2021 18:21:48 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Sep 2021 18:21:48 EDT
Received: from localhost (unknown [117.193.4.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp6.ctinetworks.com (Postfix) with ESMTPSA id 2E4BD85B00
        for <linux-wireless@vger.kernel.org>; Sat, 11 Sep 2021 18:11:34 -0400 (EDT)
Date:   Sun, 12 Sep 2021 03:39:32 +0530 (IST)
Message-Id: <20210912.033932.2187976226343353888.enometh@meer.net>
To:     linux-wireless@vger.kernel.org
Subject: help troubleshooting failures connect to an access point with
 iw/iwd
From:   Madhu <enometh@meer.net>
In-Reply-To: <20210421.102130.167565230547376402.enometh@meer.net>
References: <20210420.063244.1157699536418751229.enometh@meer.net>
        <9167fd6d-affa-21d5-bd8d-0fb3d49d38f0@justmail.de>
        <20210421.102130.167565230547376402.enometh@meer.net>
X-Mailer: Mew version 6.8 on Emacs 28.0.50
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: 2E4BD85B00.A91D1
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1632262301.20706@m9DEXiAm/ywwWfCSV0XDqw
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I've been using wpa_supplicant with rtw88 and b43 cards to connect to
a wpa-psk home router successfully for many years. This was with
-Wext. However I'm not able to accomplish this with iw or iwd.

$iw --version
iw version 5.9
$ iw dev wlan0 connect SSID key psk:<64bits> PSK CCMP CCMP
command failed: Invalid argument (-22)

- This always fails with this message. corresponding parameters work
  with wpa_supplicant.

$/usr/libexec/iwd --version
1.17
$/usr/libexec/iwd -d
$ iwctl station wlan0 get-hidden-access-points
$ iwctl --passphrase=XXX  station wlan0 connect SSID

If this connects it always immediately disconnects

kernel: [86195.924708] wlan0: authenticate with 58:xx:6e:xx:51:e4
kernel: [86196.264641] wlan0: send auth to 58:xx:6e:xx:51:e4 (try 1/3)
kernel: [86196.268477] wlan0: authenticated
kernel: [86196.274379] wlan0: associate with 58:xx:6e:xx:51:e4 (try 1/3)
kernel: [86196.281420] wlan0: RX AssocResp from 58:xx:6e:xx:51:e4 (capab=0x411 status=0 aid=1)
kernel: [86196.281491] rtw_8822ce 0000:xx:00.0: sta 58:xx:6e:xx:51:e4 joined with macid 0
kernel: [86196.282235] wlan0: associated
kernel: [86238.445926] wlan0: deauthenticated from 58:xx:6e:xx:51:e4 (Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA)
kernel: [86238.594381] rtw_8822ce 0000:xx:00.0: sta 58:xx:6e:xx:51:e4 with macid 0 left

- So an connection, after authentication immediately deauthenticates
  with (Reason: 6=CLASS2_FRAME_FROM_NONAUTH_STA). The deauthentication
  happens when any packet is to be sent on the interface

- In the case of b43 any authenticated connection also deauthenticates
  but with (Reason: 15=4WAY_HANDSHAKE_TIMEOUT)

- These are also the failure modes when iwd is used under
  NetworkManager-1.33.2

- I tried connman-1.40, but that didn't work at all It kept putting
  the device into ad-hoc mode before trying to connect, and the
  connection fails (even if i set the device in station mode via
  iwctl, connman sets it to ad-hoc mode)

I'm stumped on how to debug this - I'm seeking any suggestions on what
to look at the netlink layer to track down these problems.

I may be missing something basic, if you can spot it please let me
know.

[latest 5.10 kernel with both in-kernel rt88 drivers and lwfinger from
april 2021]
