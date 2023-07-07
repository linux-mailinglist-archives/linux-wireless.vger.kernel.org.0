Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32674ABDC
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jul 2023 09:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGGHYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jul 2023 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjGGHYT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jul 2023 03:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D21FF7
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jul 2023 00:23:53 -0700 (PDT)
Message-ID: <997e1858-a499-2188-a6a1-f0c4f0c90079@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688714621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sD0eYya1puDiOxDv/Q6jSUuUhx3pAKF7T2FT/R6KYx4=;
        b=nsg6aFyZV5FLkPx1/q5JSk9ZGlo2/wqdYoaQaSp7vEQjWcogIZFhiqohCtsgX1+gGpxotn
        O4kd2prmAW4X4kNxv4q2I+RVsuwzoUzOod4H6W2dr1Ks8LZ6XfGQy0CL89Tz4Xw7XKyO7z
        Xv5GzSb3NjTml1RtFiI5BF0x7GWbQS2WcE9G7t6JF61oQSqPu6K+L2ObS0KCcjXxNs6uhJ
        /720liRMaQ4rQs4X+QNI3jQ9WDqYzLzRQJ6wecI2Zw4qVjzxSlIuHYKua9KaU6pXX5v4sM
        wSl5CkcTZ7NQTjpHEkFsfkPh4DZaJjjpk9Y8bf1VgEQwzMj0f3mSrPD2U8H7IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688714621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sD0eYya1puDiOxDv/Q6jSUuUhx3pAKF7T2FT/R6KYx4=;
        b=FtYEDpKVlt68uCdf8cFmjt/0nai9JoEAzMCeI8j4uwWPjTPZENu22PShqVBo6FyPofJl/+
        +wQHqf+J3Lgag2Cw==
Date:   Fri, 7 Jul 2023 09:23:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/18] wifi: rtl8xxxu: Add AP mode support for 8188f
Content-Language: de-DE, en-US
To:     =?UTF-8?Q?Georg_M=c3=bcller?= <georgmueller@gmx.net>,
        linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20230428150833.218605-1-martin.kaistra@linutronix.de>
 <c9e6a13b-e32d-f810-741c-33598956a55e@gmx.net>
From:   Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <c9e6a13b-e32d-f810-741c-33598956a55e@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Georg,

Am 05.07.23 um 11:00 schrieb Georg Müller:
> Hi Martin,
> 
> Am 28.04.23 um 17:08 schrieb Martin Kaistra:
>> This series intends to bring AP mode support to the rtl8xxxu driver,
>> more specifically for the 8188f, because this is the HW I have.
>> The work is based on the vendor driver as I do not have access to
>> datasheets.
> 
> I tried to enable AP mode for a 8188EU device (TP-Link TL-WN725N) with
> some mixed results.
> 
> I added .supports_ap = 1 and .max_macid_num = 16 to rtl8188eu_fops.

According to [1], you might be able to increase max_macid_num to 64.

> 
> The AP was visible and I once was able to connect to it. When connected,
> the link was stable, but I didn't do any benchmarks.
> 
> Most of my tries I was not able to establish a connection (looks like
> timeouts) and once I got this message:
> 
>      usb 1-4: rtl8xxxu_send_beacon_frame: Failed to read beacon valid bit
> 
> The driver I am using currently is the out-of-tree driver rtl8188eu [1],
> which has a stable AP mode, but has some stability issues in managed mode.
> 
> Please give me a hint if and how I may help tracking down the issue to
> enable AP mode for 8188EU as well.

I would suggest the following:
- in rtl8xxxu_fill_txdesc_v3, set macid, HW_SEQ like in the v2 function
- 8188e does decide on the tx rate in software, so 
rtl8188e_handle_ra_tx_report2() will probably need some adjustments to handle 
multiple macids (maybe ra_info in rtl8xxxu_priv should be an array of size 
RTL8XXXU_MAX_MAC_ID_NUM?)

For testing I use a separate machine (or at least separate wifi interface) in 
monitoring mode, which I can set to the correct channel and then see in 
wireshark, if all beacons, ACKs and other frames get sent correctly.

If you have a wireshark trace of a problematic behavior and need some help with 
determining the cause or have some further questions, let me know.

Thanks,
Martin

> 
> Best regards,
> Georg
> 
> [1]
> https://github.com/lwfinger/rtl8188eu/tree/v5.2.2.4


[1] 
https://lore.kernel.org/linux-wireless/27e83382-4c84-1841-c428-d1e5143ea20c@gmail.com/
