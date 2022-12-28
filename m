Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8DB65874D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Dec 2022 23:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiL1W3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Dec 2022 17:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiL1W3s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Dec 2022 17:29:48 -0500
X-Greylist: delayed 238 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Dec 2022 14:29:47 PST
Received: from mail.schwarz.eu (eight.schwarz.eu [IPv6:2a01:4f8:c17:2a56::8:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A6A13F02
        for <linux-wireless@vger.kernel.org>; Wed, 28 Dec 2022 14:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=oss.schwarz.eu; s=x; h=Content-Transfer-Encoding:Content-Type:To:Subject:
        From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zfInqa/LcSIYLOnJ4hIPzp0HdDV6yWxPnAMz0pm2x9Y=; b=pTJyFV/3sP8TWN5kA6CDIy05ut
        HcDIa4TjoC7D78Ri9nyi0C4Qo08gSwQyHI1Ir7Q6UNKuu5yH1fDFVk7qzlYon/pEaGKNqJ3pNjqTI
        LVE7ADXuJ7KO8IQTI6GzVwduMuDYcDVCv/X/1Kad4+/lekHZorxjULl1w0GMx9JSxFOQeqUQtzt8R
        5eD6r5rX6+K7kRUFyBhYPCRnHgrxg5g3NUwZRW5eQCZ5f+99d2fYRwHzBPMTYN55/hmKLZ5zc/HBF
        zltTTmDC0sixJLpdvtySdk04CyZDiQvzimVJMoaEoa50Zu9r3XrMCsn6wxd1Lvl5AqARpWq/pYHqg
        JT4IZF2A==;
Message-ID: <a949dfb1-51e9-8f91-bef1-674c78101cc3@oss.schwarz.eu>
Date:   Wed, 28 Dec 2022 23:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Felix Schwarz <felix.schwarz@oss.schwarz.eu>
Subject: rtw_8821cu: "rfe 38 isn't supported" with Linux 6.2rc1 (0bda:c811)
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received: by mail.schwarz.eu with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.96)
        (envelope-from <felix.schwarz@oss.schwarz.eu>)
        id 1pAers-0004O6-1R; Wed, 28 Dec 2022 23:29:45 +0100
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I noticed that support for Realtek's 8821cu devices was recently merged with 
commit aff5ffd7. I have a "Realtek Semiconductor Corp. 802.11ac NIC" (ID 
0bda:c811) so I decided to try 6.2rc1.

However I only get these messages (and no new wifi network interface) when 
trying to load the module:

rtw_8821cu 1-4:1.0: Firmware version 24.11.0, H2C version 12
rtw_8821cu 1-4:1.0: rfe 38 isn't supported
rtw_8821cu 1-4:1.0: failed to setup chip efuse info
rtw_8821cu 1-4:1.0: failed to setup chip information
usbcore: registered new interface driver rtw_8821cu

I read that the vendor-supplied GPL driver (which I don't use) requires 
"usb_modeswitch" so I ran that just to be sure but still no dice:

$ sudo usb_modeswitch --std-eject --verbose --default-vendor=0bda 
--default-product=c811
[...]
  * usb_modeswitch: handle USB devices with multiple modes
  * Version 2.6.1 (C) Josua Dietze 2017
  * Based on libusb1/libusbx

[...]

Look for default devices ...
   found USB ID 0bda:c811
    vendor ID matched
    product ID matched
[...]
  Found devices in default mode (1)
Access device 005 on bus 001
Get the current device configuration ...
Current configuration number is 1
Use interface number 0
  with class 255
Error: can't use storage command in MessageContent with interface 0; interface 
class is 255, expected 8. Abort


Is there a new branch I could try? Any idea what I am doing wrong?
Felix
