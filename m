Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655DE6E948D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjDTMgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDTMf6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A6D72BC
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DF6264929
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A4AC433D2;
        Thu, 20 Apr 2023 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681994151;
        bh=3GpX93Iz3XtHTHm2AsRZJsdq/vtguxZlsLqoel3bVtQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qGzfR4oFjpUyKDrDf5KLdbFPeNX3UvF1c4hExFaGBBfic8/E3Gh0AzSjtHr4mbS4O
         6N8R5qK4yneRpixkONI7cXiLVcK0r71Riln0iiDcJzmZhu/u9Af5cs+M1XZnDyw/h1
         eP7HRTh0kSnTk75gGcFmJvmMBefAKT86uCsu9xHoDDDQ+AJSn6GDsd+4CW44jBKfKY
         AWx7/eoGBb5cpjEGtZEqnHCsNb0mvLNUr/5URgCIzTuqTVXLGe4hLtlamWc3km1rE1
         T3rIZRdk2U9LxL0vPiW3eeKt6UsAFBObwZXG4gmIcRiaQ5eQSBdx/yryuFyMHWAmg+
         w2qBJL3Er+8nA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtl8xxxu: Don't print the vendor/product/serial
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
References: <a2a7d9df-0529-7890-3522-48dce613753f@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168199414822.31131.11910739234657361957.kvalo@kernel.org>
Date:   Thu, 20 Apr 2023 12:35:50 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Most devices have a vendor name, product name, and serial number in the
> efuse, but it's pretty useless. It duplicates the information already
> printed by the USB subsystem:
> 
>    usb 1-4: New USB device found, idVendor=0bda, idProduct=8178, bcdDevice= 2.00
>    usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>    usb 1-4: Product: 802.11n WLAN Adapter
>    usb 1-4: Manufacturer: Realtek
>    usb 1-4: SerialNumber: 00e04c000001
> -> usb 1-4: Vendor: Realtek
> -> usb 1-4: Product: 802.11n WLAN Adapter
> 
>    usb 1-4: New USB device found, idVendor=0bda, idProduct=818b, bcdDevice= 2.00
>    usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>    usb 1-4: Product: 802.11n NIC
>    usb 1-4: Manufacturer: Realtek
>    usb 1-4: SerialNumber: 00e04c000001
> -> usb 1-4: Vendor: Realtek
> -> usb 1-4: Product: 802.11n NIC
> -> usb 1-4: Serial not available.
> 
>    usb 1-4: New USB device found, idVendor=0bda, idProduct=f179, bcdDevice= 0.00
>    usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>    usb 1-4: Product: 802.11n
>    usb 1-4: Manufacturer: Realtek
>    usb 1-4: SerialNumber: 002E2DC0041F
> -> usb 1-4: Vendor: Realtek
> -> usb 1-4: Product: 802.11n
> 
>    usb 1-4: New USB device found, idVendor=0bda, idProduct=8179, bcdDevice= 0.00
>    usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>    usb 1-4: Product: 802.11n NIC
>    usb 1-4: Manufacturer: Realtek
>    usb 1-4: SerialNumber: 00E04C0001
> -> usb 1-4: Vendor: Realtek
> -> usb 1-4: Product: 802.11n NIC
> -> usb 1-4: Serial: 00E04C0001
> 
> Also, that data is not interpreted correctly in all cases:
> 
> usb 3-1.1.2: New USB device found, idVendor=0bda, idProduct=8179, bcdDevice= 0.00
> usb 3-1.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 3-1.1.2: Product: 802.11n NIC
> usb 3-1.1.2: Manufacturer: Realtek
> usb 3-1.1.2: Vendor: Realtek
> usb 3-1.1.2: Product: \x03802.11n NI
> usb 3-1.1.2: Serial: \xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217231
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

af8678e6c5bd wifi: rtl8xxxu: Don't print the vendor/product/serial
cd85c8b059c5 wifi: rtl8xxxu: Add rtl8xxxu_write{8,16,32}_{set,clear}
c8bc37602779 wifi: rtl8xxxu: Simplify setting the initial gain

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/a2a7d9df-0529-7890-3522-48dce613753f@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

