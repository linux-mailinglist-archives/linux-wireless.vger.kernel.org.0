Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6B69C86C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 11:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBTKRr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 05:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBTKRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 05:17:46 -0500
Received: from pi.fatal.se (94-255-170-6.cust.bredband2.com [94.255.170.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D22D18AA3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Feb 2023 02:17:42 -0800 (PST)
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 6DCF829F28; Mon, 20 Feb 2023 11:17:40 +0100 (CET)
Date:   Mon, 20 Feb 2023 11:17:40 +0100
From:   Andreas Henriksson <andreas@fatal.se>
To:     linux-wireless@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Subject: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
Message-ID: <20230220101740.i7wxzzvte3xnwht4@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

After the rtw88 "stall" fixes[1], I'm now experiencing (yet) another big problem.
A normal wget download[2] seems to work reliably but when I download
~200MB of data using a particular application I'm able to trigger:

[   20.014243] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15
[   20.036973] rtw_8822cu 1-1:1.2: Firmware version 9.9.10, H2C version 15
...
[ 1348.527433] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
[ 1348.875727] rtw_8822cu 1-1:1.2: timed out to flush queue 3
[ 1349.215747] rtw_8822cu 1-1:1.2: timed out to flush queue 3
[ 1360.776594] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[ 1381.145113] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[ 1392.754384] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[ 1404.053595] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[ 1419.939781] rtw_8822cu 1-1:1.2: firmware failed to report density after scan


I've also reproduced the problem with newer firmware:

[   19.536307] rtw_8822cu 1-1:1.2: Firmware version 9.9.14, H2C version 15   
[   19.722697] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15
...
[ 5733.776397] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
[ 5734.157233] rtw_8822cu 1-1:1.2: timed out to flush queue 3
[ 5734.596899] rtw_8822cu 1-1:1.2: timed out to flush queue 3
[ 5770.988199] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[ 5812.408019] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[ 5853.716121] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
[ 5895.074960] rtw_8822cu 1-1:1.2: firmware failed to report density after scan


(The last message keeps repeating until LM842 dongle is removed.)


I can reproduce this problem and have personally only seen it yet on
2.4GHz but have heard from others who for some reason more easily
reproduce the problem that it has happened for them also on 5GHz. For me
I need multiple attempts, but I can reproduce the problem in the end.

I've also captured usbmon (both debugfs 1u and tcpdump/pcap usbmon1). If
anyone is interested in looking at them please contact me to arrange,
because the logs are way too big to attach here.


Hoping someone has an idea on how to avoid this problem or can fix it!

Regards,
Andreas Henriksson



[1]: https://lore.kernel.org/linux-wireless/20230210111632.1985205-1-s.hauer@pengutronix.de/
[2]: wget -O /dev/null http://speedtest.tele2.net/10GB.zip



PS. I've also reported a couple of rtw88 bugs to bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217033
https://bugzilla.kernel.org/show_bug.cgi?id=217034

