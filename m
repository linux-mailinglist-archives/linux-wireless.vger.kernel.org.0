Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261C1711F6C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 May 2023 07:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjEZF4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 May 2023 01:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEZF4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 May 2023 01:56:00 -0400
Received: from bin-mail-out-05.binero.net (bin-mail-out-05.binero.net [195.74.38.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE1BE7
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 22:55:58 -0700 (PDT)
X-Halon-ID: f8928910-fb89-11ed-b7d6-cf458ee68324
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPSA
        id f8928910-fb89-11ed-b7d6-cf458ee68324;
        Fri, 26 May 2023 07:55:54 +0200 (CEST)
From:   Petter Mabacker <petter@technux.se>
To:     s.hauer@pengutronix.de
Cc:     linux-wireless@vger.kernel.org, petter@technux.se,
        pkshih@realtek.com, tony0620emma@gmail.com
Subject: Re: rtw88: rtw8822cu (LM842) -> failed to get tx report from firmware
Date:   Fri, 26 May 2023 07:55:51 +0200
Message-Id: <20230526055551.1823094-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524104510.GV15436@pengutronix.de>
References: <20230524104510.GV15436@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>Hi Petter,

>On Thu, Apr 06, 2023 at 10:41:20AM +0000, petter@technux.se wrote:
>> Hi,
>> 
>> I have seen a very similar issue as Andreas. It was found when streaming a mender file (using mender install <url> from my arm device. But I have also managed to reproduce a similar issue by flooding the interface using iperf. 
>> 
>> on target:
>> $ sudo iperf -s -u
>> 
>> On host:
>> $ iperf -c <ip> -u -b 200M -t 300
>> 
>> Then it will almost instantly get problems causing the lm842 dongle to stop working.

>I could finally reproduce this problem by placing an access point close
>enough to my device. Only then the incoming packet rate is high enough
>that the "failed to get rx_queue, overflow" message triggers.

>In my case the time it takes to print this message many times is enough
>to confuse the device so that it finally responds with:

>[  126.449305] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
>[  142.081419] rtw_8822cu 1-1:1.2: firmware failed to report density after scan
>[  175.929407] rtw_8822cu 1-1:1.2: firmware failed to report density after scan

>I just sent a patch printing the message with dev_dbg_ratelimited
>instead which fixes that problem for me, you're on Cc.

>It likely won't fix Andreas' problem though, as I don't see this message
>in his bug report.

>Sascha

Nice work. I have tested your patch v1 for the flooding at it solves my
iperf issue. Also when you describe above, its the
very same situation for me, I have been using a board that is very close
to the access point, so this is likely why I could reproduce it quite
easy.

I have however finally manage to make some break-through about the
original issue Andreas described, that so far has only been seen when
running mender install. A similar behaviour is to download large amount
of data combined with writing to the disk. So for me I can reproduce the
issue on my i.MX6 SoloX (single cpu board) by doing.

$ sudo dd if=/dev/urandom of=/path/to/bigfile bs=4M count=500

and in parallell download a large file such as:

$ wget -O /dev/null http://speedtest.tele2.net/10GB.zip

This will trigger the problem quite fast (within 5-15 min at least):
[  374.763424] rtw_8822cu 1-1.2:1.2: failed to get tx report from firmware
[  377.771790] rtw_8822cu 1-1.2:1.2: failed to send h2c command
[  407.813460] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
[  414.965826] rtw_8822cu 1-1.2:1.2: failed to send h2c command
[  444.993462] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
[  452.144551] rtw_8822cu 1-1.2:1.2: failed to send h2c command
[  482.183445] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan

However one very interesting thing is that I can not reproduce this on a
more powerful device, such as i.MX8 or RPi4 etc.. But when I tried this
on another less powerful old single core device (BCM2835), I was able to
reproduce it quite easily again..

So from my understanding it seems to be a bit related to how the driver
behaves when the network queue/buffer etc are a bit stretch and the
system occupied with high I/O and/or system load. By increasing buffer sizes and
priorities for network queues, the system can handle it a bit better,
but still enough stress of the system seems to trigger the driver to
bail out completely..

Any suggestions or ideas around this is most welcome..

BR Petter

>-- 
>Pengutronix e.K.                           |                             |
>Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

