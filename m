Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271F63307B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 00:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKUXH1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 18:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiKUXHQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 18:07:16 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54637D235D;
        Mon, 21 Nov 2022 15:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669072027; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references; bh=HCw+3BKoLlCU+ZYO+9WB8uZ2LKaY9ZGDRG7UnD6s7vI=;
        b=lLuxmFFFoOFNfQxzIWcJMOOL04nbbIB7LWT5WLF1ygTK1OIHVan2XKvZ/o/RA6rCcJDLZ6
        YSu+Pp5+bb6gDyvINWPSI8GZjvJUZNcLDkIaumnlbB5i7B74WndTmR8cjqa5VrRMWLzYFv
        r6+v0P3kzAd2OtChsQAQB510leyYKSM=
Date:   Mon, 21 Nov 2022 23:06:57 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Please bump brcm/bcm4330-sdio.bin firmware
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-mips@vger.kernel.org,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <L70QLR.XAGB8X2431341@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

As a week-end project I got the BCM4330 chip to work with the mainline 
Linux kernel on the MIPS CI20 board. One of the problems I was facing 
was the firmware crashing, resulting in timeout errors in the brcmfmac 
driver.

It turns out the bcm4330-sdio.bin firmware that's currently in 
linux-firmware is not the latest one. Running "strings" on the blob 
points out to a version 5.90.125.104 dated 2011-10-25. The firmware 
that originally came on the CI20 is version 5.90.195.26 dated 
2012-05-09, and the version found in Android [1] is 5.90.195.114 dated 
2013-01-23. Only the last two will work on the CI20 board.

My question then, could we bump the firmware available in 
linux-firmware to the latest version? Or is there a valid reason why an 
older firmware is kept in the tree?

Best regards,
-Paul Cercueil

[1] 
https://android.googlesource.com/platform/hardware/broadcom/wlan/+/refs/heads/master/bcmdhd/firmware/bcm4330/fw_bcm4330_bg.bin


