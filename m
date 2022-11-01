Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E40614F96
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKAQnM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAQnK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 12:43:10 -0400
X-Greylist: delayed 3498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Nov 2022 09:43:08 PDT
Received: from titan5.planetwebservers.net (titan5.planetwebservers.net [51.222.33.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12563F4
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RwSojmF3Quh++5uqTmtyaQys27Hx7VuNq9glqwXeATk=; b=WuHv1es0Fznq+wAL4ERj3QOQsY
        eHb/clGbXrVRYVr9Xk71mM8e6SlqPJE6K6/urboMUkxBlIu1wWgs/c47nSeZSFjw7iU1lNnk1EYHw
        1TDQuyx5Leu/y+9e2wdqz1R6S2EVeFzjZvoYn6AQPZyTe3YZoT/y4OkQrOW8x7t8XlbJ1jxiyKgjA
        7lo3NgtqBUe8MTEJOZVeUT6a8QK69/Cosoud1il7jxdKR4yOIT7ODi/vFiKEgk4GrHv/oEgDl2raQ
        O++XswN/Kn8nsPbaBTH26VIDKjVGGJk6HvZwCGiIBMPtv17BVYlshp1bGgcps+IMXOZYY/iIz4Nb5
        TOiJzUAA==;
Received: from [76.75.122.26] (port=58574 helo=[192.168.68.73])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <bjlockie@lockie.ca>)
        id 1optRS-0007ok-0Q
        for linux-wireless@vger.kernel.org;
        Wed, 02 Nov 2022 02:44:48 +1100
Message-ID: <790f90c5-1127-53b0-3630-394dfcdd1470@lockie.ca>
Date:   Tue, 1 Nov 2022 11:44:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
Subject: [bug - mt7612u]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A system lock up occurs with kernel-6.1 and an mt7612 USB adapter.

This occurred on:

Distro: Mint 21 (based on Ubuntu 20.04)
Kernel 6.1 rc1-rc3
Intel i7

and was reproduced on:

Distro: lubuntu-22.10
Kernel 6.1 rc3
AMD A10
The 2nd time it locked up I was able to run dmesg first.
[  163.460833] usb 5-3: New USB device strings: Mfr=2, Product=3, 
SerialNumber=4
[  163.460838] usb 5-3: Product: Wireless
[  163.460843] usb 5-3: Manufacturer: MediaTek Inc.
[  163.460846] usb 5-3: SerialNumber: 000000000
[  163.742575] usb 5-3: reset SuperSpeed USB device number 2 using xhci_hcd
[  163.768317] mt76x2u 5-3:1.0: ASIC revision: 76120044
[  163.907991] mt76x2u 5-3:1.0: ROM patch build: 20141115060606a
[  164.135338] mt76x2u 5-3:1.0: Firmware Version: 0.0.00
[  164.135352] mt76x2u 5-3:1.0: Build: 1
[  164.135357] mt76x2u 5-3:1.0: Build Time: 201507311614____
[  165.636024] ieee80211 phy1: Selected rate control algorithm 'minstrel_ht'
[  165.640975] usbcore: registered new interface driver mt76x2u
[  165.681260] mt76x2u 5-3:1.0 wlx00c0caaa9c2b: renamed from wlan0
[  176.706160] wlx00c0caaa9c2b: authenticate with 40:3f:8c:79:44:ab
[  177.349870] wlx00c0caaa9c2b: send auth to 40:3f:8c:79:44:ab (try 1/3)
[  177.792441] wlx00c0caaa9c2b: send auth to 40:3f:8c:79:44:ab (try 2/3)
[  178.256595] wlx00c0caaa9c2b: send auth to 40:3f:8c:79:44:ab (try 3/3)
[  178.362060] wlx00c0caaa9c2b: authenticated
[  178.364563] wlx00c0caaa9c2b: associate with 40:3f:8c:79:44:ab (try 1/3)
[  178.404514] wlx00c0caaa9c2b: RX AssocResp from 40:3f:8c:79:44:ab 
(capab=0x1511 status=0 aid=6)
[  178.440284] wlx00c0caaa9c2b: associated
[  178.489183] IPv6: ADDRCONF(NETDEV_CHANGE): wlx00c0caaa9c2b: link 
becomes ready
[  178.525084] wlx00c0caaa9c2b: Limiting TX power to 27 (30 - 3) dBm as 
advertised by 40:3f:8c:79:44:ab
[  178.598730] 
================================================================================ 

[  178.598743] UBSAN: array-index-out-of-bounds in 
/home/kernel/COD/linux/net/mac80211/airtime.c:455:47
[  178.598747] index 15 is out of range for type 'u16 [12]'
[  178.598750] CPU: 2 PID: 217 Comm: kworker/u32:10 Not tainted 
6.1.0-060100rc3-generic #202210301931
[  178.598753] Hardware name: Acer Aspire TC-281/Aspire TC-281, BIOS 
R01-A2 07/18/2017
[  178.598757] Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
[  178.598770] Call Trace:
[  178.598773]  <TASK>
[  178.598777]  show_stack+0x4e/0x61
[  178.598783]  dump_stack_lvl+0x4a/0x6f
[  178.598791]  dump_stack+0x10/0x18
[  178.598793]  ubsan_epilogue+0x9/0x43
[  178.598796]  __ubsan_handle_out_of_bounds.cold+0x42/0x47
[  178.598799] ieee80211_get_rate_duration.constprop.0+0x22f/0x2a0 
[mac80211]
[  178.598888]  ? ieee80211_tx_status_ext+0x32e/0x640 [mac80211]
[  178.598922]  ieee80211_calc_rx_airtime+0xda/0x120 [mac80211]
[  178.598970]  ieee80211_calc_tx_airtime+0xb4/0x100 [mac80211]
[  178.599018]  mt76x02_send_tx_status+0x266/0x480 [mt76x02_lib]
[  178.599031]  mt76x02_tx_status_data+0x52/0x80 [mt76x02_lib]
[  178.599038]  mt76u_tx_status_data+0x67/0xd0 [mt76_usb]
[  178.599043]  process_one_work+0x225/0x400
[  178.599047]  worker_thread+0x50/0x3e0
[  178.599050]  ? process_one_work+0x400/0x400
[  178.599051]  kthread+0xe9/0x110
[  178.599054]  ? kthread_complete_and_exit+0x20/0x20
[  178.599056]  ret_from_fork+0x22/0x30
[  178.599060]  </TASK>
[  178.599062] 
================================================================================

It was first discussed in this thread:

https://github.com/morrownr/USB-WiFi/issues/142

