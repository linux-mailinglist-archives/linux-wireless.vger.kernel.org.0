Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB086E8B97
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjDTHoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDTHog (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 03:44:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C02B40F6
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 00:44:34 -0700 (PDT)
Message-ID: <9d98055c-bcda-b0e7-e4b7-7a6ca2d9a6e0@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681976671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKbIdfVSSaR6nyJf2EZzYZSZDPQq3kCQdfQGlHq9dio=;
        b=UZdNTg6E9uPnqZdUQ8rTnCXqBpc6l8J+Jh2b6I64Qsad8l5sm28mmifWtSgMULaJsRMY+i
        rYCzLtlH48KH+H7WV3fVs7Mqf7JwOXJGjXRaYhpEDOC+OmaGXWidkvs5z1PCkPn+/s/W8E
        YL1YFmhWsOE0ATcR7n0vS1LgcHwBuAMiuKLCyXrUuA659apGC4+dVsqafA9CyJ1rkptG/X
        RnTIpsgQK7CsxruwnRx0CKRi64sjkd1spxF4+GRC9XCeWF78oN/EiUGBEdahN6RXL5OkC/
        wzcSVD18ajC8uB9W6f633herca9afkie1XeTnDbyT4zLGGIdRsnPX9U8CXsDFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681976671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKbIdfVSSaR6nyJf2EZzYZSZDPQq3kCQdfQGlHq9dio=;
        b=o8WlEZ44KDDBka0WJaOqqxYsIV3TbND0joP6xN4/jV8t9dVvcKo0UmPl6O43E20Rwd7MFq
        6gFve7673N9BwSBw==
Date:   Thu, 20 Apr 2023 09:44:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
Content-Language: de-DE
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230419100145.159191-1-martin.kaistra@linutronix.de>
 <002e3ba2-16c7-844c-14f4-d4c14dfedd34@gmail.com>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <002e3ba2-16c7-844c-14f4-d4c14dfedd34@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 19.04.23 um 22:35 schrieb Bitterblue Smith:
> On 19/04/2023 13:01, Martin Kaistra wrote:
>> This series intends to bring AP mode support to the rtl8xxxu driver,
>> more specifically for the 8188f, because this is the HW I have.
>> The work is based on the vendor driver as I do not have access to
>> datasheets.
>>
>> Also while doing some measurements with iperf3 to compare with the
>> vendor driver, I saw, that TCP traffic from AP to STA is slower than in
>> the vendor driver. For UDP it looks fine. I hope I can get some help to
>> fix this.
>>
>> * vendor driver:
>>
>>    without 802.11n:
>>      UDP (AP -> STA): 27 Mbits/sec
>>      UDP (STA -> AP): 33 Mbits/sec
>>      TCP (AP -> STA): 24 Mbits/sec
>>      TCP (STA -> AP): 26 Mbits/sec
>>
>>    with 802.11n:
>>      UDP (AP -> STA): 51 Mbits/sec
>>      UDP (STA -> AP): 35 Mbits/sec
>>      TCP (AP -> STA): 40 Mbits/sec
>>      TCP (STA -> AP): 36 Mbits/sec
>>
>> * rtl8xxxu:
>>
>>    without 802.11n:
>>      UDP (AP -> STA): 25 Mbits/sec
>>      UDP (STA -> AP): 31 Mbits/sec
>>      TCP (AP -> STA):  3 Mbits/sec !
>>      TCP (STA -> AP): 25 Mbits/sec
>>
>>    with 802.11n:
>>      UDP (AP -> STA): 41 Mbits/sec
>>      UDP (STA -> AP): 36 Mbits/sec
>>      TCP (AP -> STA):  3 Mbits/sec !
>>      TCP (STA -> AP): 32 Mbits/sec
>>
>> Thanks,
>>    Martin
>>
>> v2 changelog:
>> - dropped RFC prefix
>> - rebase patches to newest wireless-next
>> - add some R-bs
>> - new patch: "Add parameter force to rtl8xxxu_refresh_rate_mask"
>> - new patch: "Remove usage of ieee80211_get_tx_rate()"
>> - new patch: "Remove usage of tx_info->control.rates[0].flags"
>> - new patch: "Set maximum number of supported stations"
>> - add macro for broadcast/multicast frames macid
>> - add more explanation about beacon queue in commit message of patch 2
>> - add macros for bit definitions for beacon functions
>> - implement enable_beacon = false case
>> - fix beacon valid loop so that error condition is actually reached
>> - add more explanation about setting mac address register in add_interface
>>    in commit message of patch 6
>> - rename role macros for connect report h2c
>> - use bitmap for assigning macids
>> - add helper function for looking up assigned macids
>> - move patch 7 so we can use rtl8xxxu_get_macid helper
>> - add sta_remove callback
>> - do things in sta_add only in AP mode
>> - use IEEE80211_TX_CTL_ASSIGN_SEQ flag to determine when to use HW sequence
>>    numbers
>> - add priv->vif null pointer check in configure_filter, rework setting
>>    BSSID_BEACON/BSSID_MATCH in RCR
>>
>> v1: https://lore.kernel.org/linux-wireless/20230322171905.492855-1-martin.kaistra@linutronix.de/
>>
> 
> The system didn't freeze with v2!
> 
> Also the download speed I got on the phone at speedtest.net
> was around 35 megabits/second, which is normal. Did you test
> v2 with iperf3?

Yes, I can still see a difference between rtl8xxxu and the vendor driver for TCP:


vendor driver (8188fu):

» iperf3 -B 192.168.0.11 -c 192.168.0.35
Connecting to host 192.168.0.35, port 5201
[  5] local 192.168.0.11 port 52125 connected to 192.168.0.35 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  5.01 MBytes  42.0 Mbits/sec    0    174 KBytes
[  5]   1.00-2.00   sec  5.78 MBytes  48.5 Mbits/sec    0    185 KBytes
[  5]   2.00-3.00   sec  5.53 MBytes  46.4 Mbits/sec    0    197 KBytes
[  5]   3.00-4.00   sec  5.65 MBytes  47.4 Mbits/sec    0    208 KBytes
[  5]   4.00-5.00   sec  6.09 MBytes  51.1 Mbits/sec    0    219 KBytes
[  5]   5.00-6.00   sec  5.53 MBytes  46.4 Mbits/sec    0    219 KBytes
[  5]   6.00-7.00   sec  5.84 MBytes  49.0 Mbits/sec    0    219 KBytes
[  5]   7.00-8.00   sec  5.72 MBytes  48.0 Mbits/sec    0    291 KBytes
[  5]   8.00-9.00   sec  6.15 MBytes  51.6 Mbits/sec    0    291 KBytes
[  5]   9.00-10.00  sec  5.59 MBytes  46.9 Mbits/sec    0    291 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  56.9 MBytes  47.7 Mbits/sec    0             sender
[  5]   0.00-10.06  sec  55.6 MBytes  46.3 Mbits/sec                  receiver

iperf Done.

» iperf3 -u -B 192.168.0.11 -c 192.168.0.35 --bitrate 60M
Connecting to host 192.168.0.35, port 5201
[  5] local 192.168.0.11 port 38501 connected to 192.168.0.35 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  6.05 MBytes  50.7 Mbits/sec  4380
[  5]   1.00-2.00   sec  6.09 MBytes  51.0 Mbits/sec  4407
[  5]   2.00-3.00   sec  6.09 MBytes  51.1 Mbits/sec  4407
[  5]   3.00-4.00   sec  5.94 MBytes  49.8 Mbits/sec  4303
[  5]   4.00-5.00   sec  5.96 MBytes  50.0 Mbits/sec  4316
[  5]   5.00-6.00   sec  6.23 MBytes  52.3 Mbits/sec  4511
[  5]   6.00-7.00   sec  6.25 MBytes  52.4 Mbits/sec  4524
[  5]   7.00-8.00   sec  5.87 MBytes  49.2 Mbits/sec  4251
[  5]   8.00-9.00   sec  6.12 MBytes  51.4 Mbits/sec  4433
[  5]   9.00-10.00  sec  6.25 MBytes  52.4 Mbits/sec  4524
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  60.8 MBytes  51.0 Mbits/sec  0.000 ms  0/44056 (0%)  sender
[  5]   0.00-10.07  sec  60.8 MBytes  50.7 Mbits/sec  0.345 ms  0/44052 (0%)  receiver

iperf Done.


rtl8xxxu:

» iperf3 -B 192.168.0.11 -c 192.168.0.35
Connecting to host 192.168.0.35, port 5201
[  5] local 192.168.0.11 port 35887 connected to 192.168.0.35 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.77 MBytes  14.8 Mbits/sec    2   1.41 KBytes
[  5]   1.00-2.00   sec   509 KBytes  4.17 Mbits/sec    0    242 KBytes
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0    242 KBytes
[  5]   3.00-4.00   sec   509 KBytes  4.17 Mbits/sec    1    246 KBytes
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0    246 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0    246 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0    246 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0    246 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0    246 KBytes
[  5]   9.00-10.00  sec   509 KBytes  4.17 Mbits/sec    0    246 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  3.26 MBytes  2.73 Mbits/sec    3             sender
[  5]   0.00-10.04  sec  1.98 MBytes  1.65 Mbits/sec                  receiver

iperf Done.

» iperf3 -u -B 192.168.0.11 -c 192.168.0.35 --bitrate 60M
Connecting to host 192.168.0.35, port 5201
[  5] local 192.168.0.11 port 39467 connected to 192.168.0.35 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  5.77 MBytes  48.4 Mbits/sec  4178
[  5]   1.00-2.00   sec  5.62 MBytes  47.1 Mbits/sec  4067
[  5]   2.00-3.00   sec  5.51 MBytes  46.2 Mbits/sec  3991
[  5]   3.00-4.00   sec  5.38 MBytes  45.1 Mbits/sec  3895
[  5]   4.00-5.00   sec  5.51 MBytes  46.2 Mbits/sec  3990
[  5]   5.00-6.00   sec  5.51 MBytes  46.2 Mbits/sec  3990
[  5]   6.00-7.00   sec  5.67 MBytes  47.6 Mbits/sec  4108
[  5]   7.00-8.00   sec  5.68 MBytes  47.6 Mbits/sec  4112
[  5]   8.00-9.00   sec  5.63 MBytes  47.3 Mbits/sec  4080
[  5]   9.00-10.00  sec  5.61 MBytes  47.1 Mbits/sec  4064
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  55.9 MBytes  46.9 Mbits/sec  0.000 ms  0/40475 (0%)  sender
[  5]   0.00-11.94  sec  55.9 MBytes  39.3 Mbits/sec  0.493 ms  0/40466 (0%)  receiver

iperf Done.


> 
> I saw a few of these in the journal:
> 
> usb 1-2: rtl8xxxu_send_beacon_frame: Failed to read beacon valid bit
> 
> I'm not sure what caused that.

