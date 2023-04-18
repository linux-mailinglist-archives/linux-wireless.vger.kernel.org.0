Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2BB6E68A5
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjDRPt6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDRPtg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 11:49:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31413FB2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 08:49:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id vc20so19459153ejc.10
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681832973; x=1684424973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dPiOQEGPGseh6NtQiTxmYtVruKxBvcWtpOgMB5Y00xo=;
        b=Gu5ePjK+CbkAiFx6GgxD8MmGJsN5xRRtXePGebHQdCfCDnL8cM9ShCZcukwjlx9Q+X
         XCPZQucF9vhcjkF2EHld0HiAUrNnU4Y5/mA3P3kUOH+ScIB5xR7fRlGyc6E0v1LLd9Uo
         nYFy/oCnGrzdzy/3dXenyL9p4WPZAWUHs2nqfeOGpwZg582vpbHzf6KOUwCBS397Jhw1
         6BZszePOKZbEsV0rdblUhr9Ydh3mZQvZofBjDte+bqzQ5ntf3EtYt64ZjaBApAfjdss3
         3mGo4jm9O2+3rekZvFkP3G7IzgMTv4kAaYK39PTnV6Ji3B0VoNrFqVtbH1fEZjk5vDU7
         47eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832973; x=1684424973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPiOQEGPGseh6NtQiTxmYtVruKxBvcWtpOgMB5Y00xo=;
        b=ABDjNGChNWyYneldJSTgohhOdSSKx0ErkH25hldF+vcHxcO68j5A5cN3ImDOqORTEU
         cMuEgXU0rL2j4yTEIeyQjM2zDGK/0xIYjV2xuidw/KSAL4vvLRoLtjw9hxC16TyAi81A
         RfbB7Qy65fqV8fCbuKwmZh12VmrfB6jwNMqG6x90oq/4qo1XUHcmsXJ8LVS8nYyowlsa
         jlbDJOz8vNrn2/C2YF0R5uTg9tByoUcsBMBNzBBFDXWtdH/j1coJ2hzgjT3zYz+sKn0V
         PknlPD1k9M1cinbA6Vm1ezNvDQ9Uc//LDKyDthYuD814nGCNqFKLlm2jDqcHNZbebIZE
         9S9A==
X-Gm-Message-State: AAQBX9e7xk5dEFN0dvQfk0pO6eenYcNfNzbvKLQXhhsxWzpzX8GVoSJk
        H4Qwqa12iNBD1npNMCp7rp8=
X-Google-Smtp-Source: AKy350ZsicO3DylBoDch/NzgQ9LHIIrMOIa6D+d27r4m0ehiTtuWZkIby34dznUgSgAPbrN4UrRzIA==
X-Received: by 2002:a17:906:7006:b0:94c:6762:e20d with SMTP id n6-20020a170906700600b0094c6762e20dmr12057807ejj.12.1681832972830;
        Tue, 18 Apr 2023 08:49:32 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id f4-20020a170906ef0400b0094f969e877bsm2418360ejs.43.2023.04.18.08.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:49:32 -0700 (PDT)
Message-ID: <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com>
Date:   Tue, 18 Apr 2023 18:49:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Artem Makhutov <artem.makhutov@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
 <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 18/04/2023 14:53, Artem Makhutov wrote:
> Hello,
> 
> Am So., 16. Apr. 2023 um 19:47 Uhr schrieb Bitterblue Smith
> <rtl8821cerfe2@gmail.com>:
>>
>> On 16/04/2023 16:45, Artem Makhutov wrote:
>>> Hello,
>>>
>>> I am not sure if it is ok to write to you directly but I could not find a place where to open a ticket about the rtl8xxxu driver.
>>>
>>> I am having issues with the RTL8188EU (LogiLink WL0151A) where I get truncated packets when sending large packets. It's easy to reproduce with ping:
>>> [...]
>> Hi!
>>
>> Adding linux-wireless because that's the place to report bugs.
>> Also bugzilla.kernel.org, but that's more dead.
>>
>> Unfortunately my TP-Link TL-WN725N is fine even with bigger packets:
>> [...]
> 
> Yes, I also have wifi networks where I have no issues at all. It seems
> to be only related to some wifi routers.
> With a Huawei AX3 router I have no issues. But with an Asus RT-AX53U i
> am getting corrupted data.
> 
>> What version of the kernel/driver are you running? On what kind
>> of computer?
> 
> It is an embedded device with a STM32MP157C processor. It runs an
> 5.15.67 kernel from ST (https://github.com/STMicroelectronics/linux/)
> I have backported the rtl8xxxu driver from
> https://github.com/torvalds/linux/ to that kernel by cherry-pick all
> the related commits.
> 
>> Did you use any module parameters?
> 
> No, I have not tried any parameters yet.
> 
>> Do you know if the other computer is receiving correct packets
>> from your RTL8188EU?
> 
> I have no ssh access to the router (it runs the stock firmware from
> Asus), but I can try to do some tests on another PC later.
> But I assume that it receives correct data as I can see a reply in tcpdump.
> 
>> What's the biggest packet size which still works correctly?
> 
> I think the magic number for ping is 1429. With ping -s 1428 I have no issues.
> 
>> Did you test any other driver, like this one:
>> https://github.com/lwfinger/rtl8188eu/tree/v5.2.2.4
> 
> Yes, I have tried this one. Here I had no issue with packet loss, but
> I was losing the wifi connection from time to time and the
> auto-reconnect also did not work.
> 
>> or this one:
>> https://github.com/aircrack-ng/rtl8188eus
> 
> I have not tried this one yet.
> 
> But I have also tried https://github.com/ivanovborislav/rtl8188eu
> 
> Here after some hours or days the wifi completely hangs up, loses the
> connection and does not see any wifi networks any more at all.
> 
>> If the other computer is receiving correct packets, try this untested
>> patch to see what rtl8xxxu is actually receiving:
>> [...]
> 
> I have applied the patch.
> 
> For a working ping with a packet size of 1428 I am getting:
> urb_len 1562
>   pkt_cnt 136 pkt_len 1506 drvinfo_sz 32 desc_shift 0
> [...]
> 
> For a broken ping with a packet size of 1430 I am getting the data below.
> The strange thing is that the urb_len 1560 for a 1430 bytes ping is
> smaller than a urb_len 1562 for a 1428 bytes large ping...
> 
> urb_len 1560
>   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
Can you also capture the wifi traffic using some device which is not
handled by rtl8xxxu? With airodump-ng, wireshark, etc. Then you can
compare the pkt_len with what the capture device sees.

It could also be useful to see what the v5.2.2.4 driver receives,
both with 1428 and with 1430:

diff --git a/rtl8188e_rxdesc.c b/rtl8188e_rxdesc.c
index e6b0f77..2c34a71 100644
--- a/rtl8188e_rxdesc.c
+++ b/rtl8188e_rxdesc.c
@@ -38,6 +38,8 @@ void rtl8188e_query_rx_desc_status(
 		pattrib->pkt_len = cpu_to_le16(le32_to_cpu(report.rxdw0) & 0x00003fff); /* (u16)prxreport->pktlen; */
 		pattrib->drvinfo_sz = (u8)((le32_to_cpu(report.rxdw0) >> 16) & 0xf) * 8;/* (u8)(prxreport->drvinfosize << 3); */
 
+		pr_warn("%s: pkt_len: %d\n", __func__, le16_to_cpu(pattrib->pkt_len));
+
 		pattrib->physt = (u8)((le32_to_cpu(report.rxdw0) >> 26) & 0x1); /* (u8)prxreport->physt;	 */
 
 		pattrib->bdecrypted = (le32_to_cpu(report.rxdw0) & BIT(27)) ? 0 : 1; /* (u8)(prxreport->swdec ? 0 : 1); */


Also, can you show the hex dump from a good ping?
