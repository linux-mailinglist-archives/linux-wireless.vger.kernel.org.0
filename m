Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881A46FC09D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 May 2023 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjEIHoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 May 2023 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjEIHoD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 May 2023 03:44:03 -0400
Received: from bin-mail-out-06.binero.net (bin-mail-out-06.binero.net [195.74.38.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D201AD0E
        for <linux-wireless@vger.kernel.org>; Tue,  9 May 2023 00:44:00 -0700 (PDT)
X-Halon-ID: 3d682f38-ee3d-11ed-b7d6-cf458ee68324
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPSA
        id 3d682f38-ee3d-11ed-b7d6-cf458ee68324;
        Tue, 09 May 2023 09:43:54 +0200 (CEST)
From:   Petter Mabacker <petter@technux.se>
To:     s.hauer@pengutronix.de
Cc:     linux-wireless@vger.kernel.org, petter@technux.se,
        pkshih@realtek.com, tony0620emma@gmail.com
Subject: Re: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
Date:   Tue,  9 May 2023 09:43:50 +0200
Message-Id: <20230509074350.2862571-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508134626.GZ29365@pengutronix.de>
References: <20230508134626.GZ29365@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> I'm working with a Linux 6.1 based track, but with all the mentioned bug fixes cherry-picked to that track. They have all made the LM842 a lot more stabile, but the issue I see with "tx report failed" is currently blocking me from using the LM842, since the mender upgrade is a crucial part for my use-case.
>> 
>> I have been trying to find a better way to reproduce the issue, without any success so far. For me it takes just 10-30 sec with above mention flooding using iperf to at least trigger a similar case.
>> 
>> ...
>> [  671.908527] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
>> [  671.914632] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
>> [  671.920750] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
>> [  671.926792] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow
>> [  671.932924] rtw_8822cu 1-1:1.2: failed to get rx_queue, overflow

>I am still not sure what to do about this. It happens with high RX load.
>One way would be to just drop the log level of this message.
>Otherwise this message should be harmless.

Like stated in earlier mails, the initial problem was found during a mender upgrade (streaming a ~200MB file). In that case the problem occurs without any high RX load warnings. So that is not really related (at least I don't think so).

The real problem is that the driver ends-up in a not working state after this. Not even hot-plugging the dongle will help. Instead a reboot or reset of the driver (rmmod/insmod etc) is required.

>> 
>> [  694.709045] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
>> 
>> [  710.169496] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
>> [  717.701235] rtw_8822cu 1-1:1.2: failed to send h2c command
>> 
>> I can also mention that I'm running this in a i.MX6 SoloX based board.
>> 
>> I will let you guys know if I find a better way to reproduce the
>> issue. But if you have any good ideas what above error (that brings
>> down the entire interface) really mean (for example does it indicate
>> kernel or firmware issue), please feel free to share some information
>> about it and it might help me in troubleshooting the issue further.

>Please try reproducing this with a recent mainline vanilla kernel. It
>shouldn't be too hard to bring up a i.MX6 board with a vanilla kernel.

Just to be sure, I have tried this using latest kernel tree as you suggested:

~# uname -r
6.4.0-rc1-g5ca44e46dff4

However I get the very same behavior (in this case it's from the failed mender upgrade):
[  724.788270] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
[  728.499480] rtw_8822cu 1-1:1.2: failed to send h2c command
[  758.558511] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
May 09 06:48:17 iotgw mender[643]: time="2023-05-09T06:48:17Z" level=error msg="Download connection broken: read tcp 192.168.68.113:54072->52.239.140.42:443: read: connection timed out"
[  796.975782] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[  835.251656] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[  843.586421] rtw_8822cu 1-1:1.2: failed to send h2c command

When I try to hotplug the dongle (that still don't solve the issue). I can see below printout, any ideas what it really mean? (I never see this before the problem occurs, only when hotplugging after the problem occurs):

[ 2298.729359] wlx34c9f08deb60: Limiting TX power to 23 (23 - 0) dBm as advertised by 1c:3b:f3:55:59:93

Since you cannot reproduce the similar (perhaps not even the same root issue) issue I saw using iperf, I will focus on trying to reproduce it using something similar as the streaming procedure done by mender. Any other suggestions from your side, or any logs etc that could be of interest?

BR Petter

>Regards,
> Sascha
