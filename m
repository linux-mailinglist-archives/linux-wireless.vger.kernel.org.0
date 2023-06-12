Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D226372CDB7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjFLSS0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFLSSZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 14:18:25 -0400
Received: from vsp-unauthed02.binero.net (vsp-unauthed02.binero.net [195.74.38.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CE393
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 11:18:22 -0700 (PDT)
X-Halon-ID: 7ebc1a2f-094d-11ee-b7d6-cf458ee68324
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPSA
        id 7ebc1a2f-094d-11ee-b7d6-cf458ee68324;
        Mon, 12 Jun 2023 20:18:17 +0200 (CEST)
From:   petter@technux.se
To:     s.hauer@pengutronix.de
Cc:     Larry.Finger@lwfinger.net, andreas@fatal.se, iam@valdikss.org.ru,
        kernel@pengutronix.de, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux@ulli-kroll.de,
        petter.mabacker@esab.se, petter@technux.se, pkshih@realtek.com
Subject: Re: rtw8822cu (LM842) stalls when running HW offload scan
Date:   Mon, 12 Jun 2023 20:18:13 +0200
Message-Id: <20230612181813.323882-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612134655.GD18491@pengutronix.de>
References: <20230612134655.GD18491@pengutronix.de>
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

On Mon, Jun 12, 2023 at 03:30:23PM +0200, petter@technux.se wrote:
>> Some time ago https://bugzilla.kernel.org/show_bug.cgi?id=217034 was
>> created. From the beginning it was just about some error printouts.
>> Then Andreas (who created the bug report) mentioned that it seems to
>> work worse after bumping the firmware to > 9.9.10. After some fixes
>> from Sascha the error printouts dissappeared. But when I also started
>> to run this using firmware > 9.9.10 I also got problems. On my i.MX8
>> and RPi4 board it works fine, but on some of my less powerful boards
>> such as and older RPi and my i.MX6 SoloX board, it always fails using
>> 9.9.10 firmware. After some digging in the git log, I discovered
>> that HW scan offload was introduced in a later firmware. So when I
>> disable HW offload scan it seems to work again on all my boards. But
>> still I want to understand why the HW offload scan don't work for
>> me.

>Could it be that the number of CPU cores makes the difference? Can you
>try with maxcpus=1 on your boards with more than one CPU?
>
>I have a i.MX6s board here that I can use to try to reproduce your
>problem in the meantime.
>
>Sascha

I was also thinking about that first. But I cannot reproduce the issue
on my i.MX8 board even if I reduce the number of cpus to 1. Could it be
related to USB speed in some way? I have tried to exclude insufficient
USB power by using an usb hub with external power supply, but could
still see the issue on my i.MX6 their.. Will be very interesting to know
about your results on your board. Like stated earlier I can easily
reproduce this using all firmware versions with HW offload scan feature
included (> 9.9.10).

Running with 1 cpu on my i.MX8 board:

~# cat /proc/cpuinfo 
processor	: 0
BogoMIPS	: 16.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x0
CPU part	: 0xd03
CPU revision	: 4

~# fw_printenv | grep bootargs=
bootargs=console=ttymxc2,115200 earlycon=ec_imx6q,0x30880000,115200 net.ifnames=0 root=/dev/mmcblk2p1 rootwait ro fsck.repair=yes maxcpus=1
~# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=119 time=16.8 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=119 time=16.2 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 16.249/16.514/16.780/0.265 ms
~# nmcli device wifi rescan
~# 
~# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=119 time=14.6 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=119 time=13.2 ms
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 13.186/13.911/14.637/0.725 ms

Petter

>
>-- 
>Pengutronix e.K.                           |                             |
>Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

