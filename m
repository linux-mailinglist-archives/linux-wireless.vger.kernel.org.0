Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5B379237
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbhEJPQ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbhEJPOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:14:35 -0400
X-Greylist: delayed 2626 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 May 2021 07:34:10 PDT
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch [IPv6:2a00:d70:0:e::312])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7CC056757
        for <linux-wireless@vger.kernel.org>; Mon, 10 May 2021 07:34:10 -0700 (PDT)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1lg6IQ-000MKY-5m; Mon, 10 May 2021 15:50:06 +0200
Received: from [2a02:168:6182:1:606a:a23b:6802:7f10]
        by asmtp014.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1lg6IP-0004Ia-2b; Mon, 10 May 2021 15:50:06 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        linux-wireless@vger.kernel.org
From:   Reto Schneider <code@reto-schneider.ch>
Cc:     =?UTF-8?B?6YKx5ZCN56KpIChDaHJpcyBDaGl1KQ==?= <ccchiu77@gmail.com>,
        yhchuang@realtek.com, pkshih@realtek.com, tehuang@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>, kuba@kernel.org,
        kvalo@codeaurora.org, davem@davemloft.net,
        Reto Schneider <reto.schneider@husqvarnagroup.com>
Subject: rtl8xxxu: Wi-Fi Alliance Certification on Realtek RTL8188CUS
Message-ID: <a31d9500-73a3-f890-bebd-d0a4014f87da@reto-schneider.ch>
Date:   Mon, 10 May 2021 15:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jes,
Hi all,

Chris (writing code, testing) and me (testing) are working [1] on 
re-newing the Wi-Fi Alliance certification of an IoT gateway (STA) which 
uses the Realtek RTL8188CUS chip, and is (now) running Linux 5.10+ with 
the rtl8xxxu driver, firmware version 88.2 [2]. The existing 
certification [3] has been done using the RealTek-provided 8192cu driver 
[4] and and Linux 3.19.

While the rtl8xxxu in upstream is *very* stable, it lacks some features 
which are needed for the certification. I tried to summarize this in the 
wiki [1].

The following has been implemented by Chris (on top of mainline):
  - STBC Receive
  - TX power configuration (using the iw command, not regdb)

Still missing:
  - WMM support
  - A-MSDU RX support
  - TX power by rate

WIP (See also Chris' mail from earlier today):
  - A-MPDU
  - Rate adaption
  - TX descriptors

The motivation for writing this mail is that we we are currently blocked 
by an issue which we can not resolve already for some months: The 
re-transmission percentage of the rtl8xxxu is too high (rtl8192cu is the 
same) - way higher than what 8192cu achieves. According to Wireshark, 
the retransmission rate is always between 15-65% for the rtl8xxxu, while 
the realtek-provided 8192cu stays below 5%, often averaging at less than 
1% in my setup.

Examples with an Linksys WRT3200ACM AP (RA/TA: 24:f5:a2:c0:4e:b1, DA/SA: 
00:60:6e:00:07:7d, SSID customer-testwifi) and the DUT 
(00:1d:43:c0:19:8a) running iperf3 (TCP, TX):

rtl8xxxu:
  - 65% retries, many addresses reported which do not actually exists
  - Code: [5]
  - Captures: [7]

891cu:
  - 0.9% retries, no ghost addresses captured
  - Code:  [6]
  - Captures: [8]

I'd be really grateful for any kind of ideas, pointers, help.

Kind regards,
Reto

[1] Wiki entry (slightly outdated): 
https://wireless.wiki.kernel.org/en/users/wi-fi-alliance-certification
[2] rtl8912cu firmware v88.2, part of linux-firmware 20201118: 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/rtlwifi/rtl8192cufw_TMSC.bin?id=2ea86675db1349235e9af0a9d0372b72da4db259
[3] Existing certification: 
https://api.cert.wi-fi.org/api/certificate/download/public?variantId=14856
[4] https://github.com/husqvarnagroup/smart-garden-gateway-seluxit-8192cu
[5] Most recent rtl8xxxu development: 
https://github.com/husqvarnagroup/linux/commit/909f13c8fd45260a622d148882030624d492c54f
[6] 8192cu for Linux 5.10+: 
https://github.com/husqvarnagroup/realtek-8192cu_rtl8188cus
[7] pcap: 
https://files.reto-schneider.ch/diesunddas/rtl8xxxu/2021-05-10/rtl8xxxu-65%25-retries.pcapng.gz
     shell: 
https://files.reto-schneider.ch/diesunddas/rtl8xxxu/2021-05-10/rtl8xxxu-65%25-retries-shell.log
[8] pcap: 
https://files.reto-schneider.ch/diesunddas/rtl8xxxu/2021-05-10/8192cu-0.9%25-retries.pcapng.gz
     shell: 
https://files.reto-schneider.ch/diesunddas/rtl8xxxu/2021-05-10/8192cu-0.9%25-retries-shell.log
