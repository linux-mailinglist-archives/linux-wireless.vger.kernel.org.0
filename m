Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C9F626C9C
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Nov 2022 00:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiKLXRJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 18:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKLXRI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 18:17:08 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D891147C
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:17:07 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id b124so8178922oia.4
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdkcKh2vxluhClSgBsYtLcOl2k9+rreo6dHmIrjxJ4Y=;
        b=igNhNbJqrsz1YupS6mTLNK6xV5HpQ1pz99hLv8QQaHyqBwWgq3rX+XX8kiQbBo2MIK
         mgNDfA/vGzE9CO11FzhOThD5lUDBwehDSnmUJmNsKwR+mL9Sl4V8EyFrYD0g0L3tjJIv
         blUAUXJ4+mJ+1X+kxd6iGuCh8h8MNbrw1M2Wi4DnaV/Hu9ysmipoladK62Z3skh+gsou
         UUJ82KRdlnPcgwJb26iY2FY08EHH6PytutPdbSeoFlKGcZ8Mg9ARrjdUwawTHORRwnPu
         efO6C26w2FayAQONrxxca32J8+ix1ThnCyPZO8SVqPsaXb3WN1w6uB5HpR5dHQX5WC5p
         GhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DdkcKh2vxluhClSgBsYtLcOl2k9+rreo6dHmIrjxJ4Y=;
        b=FQX7HZhiYSFC1jHCSTsYmifH4rWezSOztc8FlxbeGhgAopnk+2mlADV/MnFoSg+TT9
         NcfnjHZvJdyc/JLh1f6kqJh/LjKJtB9+thxJTT7EY8s3wLQHfUw5QEWaVi3/arcibEwU
         z8hLBmYosOyc/hLJAqPGL2ziJ2BXLqiHsAf06rP4x2XuKqAhtgr6mzBIplA7aBxHa22J
         yaSO59mM/gtySZIPU6ej+GK04CT4V5EooZpo2gylJmGIp6gPVHioeRrxOVlIEy5fMRSc
         yMFtCwxBuBYKSdZ3r8vqGiqPT/ojyBmD9R0erEh9J9Z26wQOHKgXx8ElDf4oVDPQcYt6
         HLEw==
X-Gm-Message-State: ANoB5pnqy4Ki++27WNTWtkULNMWz/HvMX2R3OZfSgHSNHAdA3pQkkTBf
        NHeBPBpWk6V0j8+NaKWksyvcdZEaQRk=
X-Google-Smtp-Source: AA0mqf4SgmOQ4YtqAyKx+8mQ5vlE7FkbAJo2ISaCRUyoV8NbF/pCdt6Ht26/Waws4EcY9V6w3g8xVg==
X-Received: by 2002:a05:6808:11cd:b0:359:a7d2:63aa with SMTP id p13-20020a05680811cd00b00359a7d263aamr3283038oiv.73.1668295025913;
        Sat, 12 Nov 2022 15:17:05 -0800 (PST)
Received: from [192.168.1.27] (cpe-173-172-98-239.kc.res.rr.com. [173.172.98.239])
        by smtp.gmail.com with ESMTPSA id g26-20020a9d619a000000b0063696cbb6bdsm2451052otk.62.2022.11.12.15.17.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 15:17:05 -0800 (PST)
Message-ID: <ba072331-b7db-edc3-de77-4496d402f497@gmail.com>
Date:   Sat, 12 Nov 2022 17:17:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
From:   Ray Jantz <ray.jantz@gmail.com>
Subject: [BUG REPORT] mt76: LED not working on ASUS AC51 USB (mt7610U)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
Below is a bug I submitted on Suse bugzilla - they said I should it 
submit it to linux-wireless.

LED not working on ASUS AC51 wireless USB adapter (MT7610U chipset) 
using Mediatek driver

The activity LED on my ASUS AC51 wireless USB adapter does not flash when there is link activity. Everything else works - the adapter connects to wireless networks, but the LED never flashes.  The LED works fine in Windows 10.

Reproducible: Always

Steps to Reproduce:
1. Plug ASUS AC51 adapter into a USB port.
2. No need to install a driver (driver is in-kernel)
3.(Optional) reboot
4. Connect to wireless network.
5. Open a browser and bring up a web page.
Actual Results:
The activity LED on the AC51 never flashes even though there is network activity.

Expected Results:
The activity LED on the AC51 should flash when there is network activity.

The OS is Opensuse Tumbleweed 6.0.5-1-default.

The info from lsusb is:

ASUSTek Computer, Inc. AC51 802.11a/b/g/n/ac Wireless Adapter [Mediatek MT7610U]

Bus 001 Device 003: ID 0b05:17d1 ASUSTek Computer, Inc. AC51 802.11a/b/g/n/ac Wireless Adapter [Mediatek MT7610U]

I have checked the kernel config file and  CONFIG_MT76_LEDS=y is set.

