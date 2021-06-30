Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F3B3B7CD5
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jun 2021 06:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhF3Eyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Jun 2021 00:54:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54575 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhF3Eyl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Jun 2021 00:54:41 -0400
Received: from [222.129.34.206] (helo=[192.168.1.18])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <aaron.ma@canonical.com>)
        id 1lySCm-0007Xf-1q; Wed, 30 Jun 2021 04:52:08 +0000
To:     pkshih@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
References: <20210618064625.14131-1-pkshih@realtek.com>
 <20210623062909.24409-1-aaron.ma@canonical.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Subject: Re: [PATCH 00/24] rtw89: add Realtek 802.11ax driver
Message-ID: <f1caa1a2-55c7-a69f-070a-a49b345e4550@canonical.com>
Date:   Wed, 30 Jun 2021 12:52:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623062909.24409-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Previous result is from a single antenna PCI card of 8852AE.
After test on another Laptop with 8852AE, it works fine.
Result:
AP ASUS AX86u: TX 660M RX 880M

AP Netgear R7800: TX 500M RX 561M
Looks like the performance is affected by antenna.

The error log is not reproduced again.

Tested-by: Aaron Ma <aaron.ma@canonical.com>

Aaron

On 6/23/21 2:29 PM, Aaron Ma wrote:
> Hi Ping-Ke,
> 
> After applied your patches on 5.17-rc7, tested on pci device:
> 04:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. Device [10ec:8852]
> 
> I found the performance is a bit poor on TX especially.
> Tested on Intel AX210, it's result is TX 461Mb/s and RX 547Mb/s at the same position.
> 
> $ iperf3 -c 192.168.1.7
> Connecting to host 192.168.1.7, port 5201
> [  5] local 192.168.1.6 port 40942 connected to 192.168.1.7 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  26.2 MBytes   220 Mbits/sec    0   1.12 MBytes
> [  5]   1.00-2.00   sec  21.2 MBytes   178 Mbits/sec    0   1.76 MBytes
> [  5]   2.00-3.00   sec  33.8 MBytes   283 Mbits/sec    0   2.00 MBytes
> [  5]   3.00-4.00   sec  31.2 MBytes   262 Mbits/sec    0   2.12 MBytes
> [  5]   4.00-5.00   sec  30.0 MBytes   252 Mbits/sec    0   2.38 MBytes
> [  5]   5.00-6.00   sec  31.2 MBytes   262 Mbits/sec    0   2.56 MBytes
> [  5]   6.00-7.00   sec  31.2 MBytes   262 Mbits/sec    0   2.56 MBytes
> [  5]   7.00-8.00   sec  27.5 MBytes   231 Mbits/sec    0   2.56 MBytes
> [  5]   8.00-9.00   sec  35.0 MBytes   294 Mbits/sec    0   2.56 MBytes
> [  5]   9.00-10.00  sec  31.2 MBytes   262 Mbits/sec    0   2.69 MBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   299 MBytes   251 Mbits/sec    0             sender
> [  5]   0.00-10.01  sec   296 MBytes   248 Mbits/sec                  receiver
> 
> iperf Done.
> 
> $ iperf3 -c 192.168.1.7 -R
> Connecting to host 192.168.1.7, port 5201
> Reverse mode, remote host 192.168.1.7 is sending
> [  5] local 192.168.1.6 port 40946 connected to 192.168.1.7 port 5201
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  46.4 MBytes   389 Mbits/sec
> [  5]   1.00-2.00   sec  48.7 MBytes   408 Mbits/sec
> [  5]   2.00-3.00   sec  48.5 MBytes   407 Mbits/sec
> [  5]   3.00-4.00   sec  51.9 MBytes   435 Mbits/sec
> [  5]   4.00-5.00   sec  47.8 MBytes   401 Mbits/sec
> [  5]   5.00-6.00   sec  50.7 MBytes   426 Mbits/sec
> [  5]   6.00-7.00   sec  48.2 MBytes   404 Mbits/sec
> [  5]   7.00-8.00   sec  48.2 MBytes   405 Mbits/sec
> [  5]   8.00-9.00   sec  51.0 MBytes   428 Mbits/sec
> [  5]   9.00-10.00  sec  52.0 MBytes   436 Mbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec   497 MBytes   417 Mbits/sec  126             sender
> [  5]   0.00-10.00  sec   493 MBytes   414 Mbits/sec                  receiver
> 
> iperf Done.
> 
> 
> Also I found some errors when stress test, not sure how to reproduce yet, copy log here:
> 
> kernel: rtw89_pci 0000:04:00.0: Firmware version 0.13.24.0, cmd version 0, type 1
> kernel: rtw89_pci 0000:04:00.0: Firmware version 0.13.24.0, cmd version 0, type 3
> kernel: rtw89_pci 0000:04:00.0: chip rfe_type is 1
> kernel: initcall rtw89_pci_driver_init+0x0/0x1000 [rtw89_pci] returned 0 after 26621 usecs
> kernel: rtw89_pci 0000:04:00.0 wlp4s0: renamed from wlan0
> kernel: wlp4s0: authenticate with 9c:d3:6d:a3:b2:e7
> kernel: wlp4s0: send auth to 9c:d3:6d:a3:b2:e7 (try 1/3)
> kernel: wlp4s0: send auth to 9c:d3:6d:a3:b2:e7 (try 2/3)
> kernel: wlp4s0: send auth to 9c:d3:6d:a3:b2:e7 (try 3/3)
> kernel: wlp4s0: authentication with 9c:d3:6d:a3:b2:e7 timed out
> kernel: wlp4s0: authenticate with 9c:d3:6d:a3:b2:e7
> kernel: wlp4s0: send auth to 9c:d3:6d:a3:b2:e7 (try 1/3)
> kernel: wlp4s0: authenticated
> kernel: wlp4s0: associate with 9c:d3:6d:a3:b2:e7 (try 1/3)
> kernel: wlp4s0: RX AssocResp from 9c:d3:6d:a3:b2:e7 (capab=0x11 status=0 aid=9)
> kernel: wlp4s0: associated
> kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlp4s0: link becomes ready
> kernel: rtw89_pci 0000:04:00.0: FW status = 0xb9001100
> kernel: rtw89_pci 0000:04:00.0: FW BADADDR = 0x0
> kernel: rtw89_pci 0000:04:00.0: FW EPC/RA = 0x0
> kernel: rtw89_pci 0000:04:00.0: FW MISC = 0xb8990c7b
> kernel: rtw89_pci 0000:04:00.0: R_AX_HALT_C2H = 0x10
> kernel: rtw89_pci 0000:04:00.0: R_AX_SER_DBG_INFO = 0x41000001
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991bcb
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991bd5
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991acb
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xbfc00180
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991bf9
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991ba7
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991bd3
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991ae3
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991aad
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991ba7
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991bd1
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991ac5
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991ba7
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991ad1
> kernel: rtw89_pci 0000:04:00.0: [ERR]fw PC = 0xb8991bbb
> kernel: rtw89_pci 0000:04:00.0: --->
>          err=0x10
> 
