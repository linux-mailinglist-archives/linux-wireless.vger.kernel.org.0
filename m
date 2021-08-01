Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371983DCA86
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Aug 2021 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhHAHZg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Aug 2021 03:25:36 -0400
Received: from poohprod.ru ([185.146.156.86]:60954 "EHLO mail.poohprod.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230356AbhHAHZg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Aug 2021 03:25:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D407E0363
        for <linux-wireless@vger.kernel.org>; Sun,  1 Aug 2021 10:25:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poohprod.ru; s=dkim;
        t=1627802725; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:content-language;
        bh=nJnPp0/BmJ/W28q+9URdHGjVLXADIqBuLHY27gmblfI=;
        b=oGUfPRMwFbGlz/8jH1PVRlwRFVhzDVyz8NRyw7dEo4yOwd9Ys53fuYW0VNrgh784YgFOX5
        zLO4n0RRtlfixsIm8PPo56Cbe0HzBBfR0F7ke5SF8TpLqaBvYa/5FtbM/qmeRMJRdqABVZ
        jiWowuzaZjv5tvuhEDJkc82qwU3xX/EkCEPheDKrC1Gl+Va2Pw7J5s+Fr5mypCtvrLB/h4
        RgeW2sf9mlX2Csjii05lirqCMW/MHlX//TC4w+PWclqyi7kS+ygCO6sf1exjKeDoJIKgDB
        +6IC34wrj8iAjCUP/Iqch6S8uCwZvHN+zWHz/eYX6SGK5cGAFOi9J2+K4n2D8w==
To:     linux-wireless@vger.kernel.org
From:   Pooh <pooh@poohprod.ru>
Subject: (Arch Linux) rtw_8822ce WiFi driver for Linux
Message-ID: <720e699d-a062-28cd-6242-735282dc3e54@poohprod.ru>
Date:   Sun, 1 Aug 2021 10:25:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi! The following errors constantly appear in the log. The WiFi 
connection is stable at the same time.

июн 30 19:39:31 not-a-virus kernel: rtw_8822ce 0000:01:00.0: failed to 
send h2c command
июн 30 19:39:31 not-a-virus kernel: rtw_8822ce 0000:01:00.0: failed to 
send h2c command
июн 30 19:39:31 not-a-virus kernel: rtw_8822ce 0000:01:00.0: failed to 
send h2c command
июн 30 19:39:31 not-a-virus kernel: rtw_8822ce 0000:01:00.0: failed to 
send h2c command
июн 30 19:39:31 not-a-virus kernel: rtw_8822ce 0000:01:00.0: failed to 
send h2c command
июн 30 19:39:31 not-a-virus kernel: rtw_8822ce 0000:01:00.0: failed to 
send h2c command
июн 30 19:39:31 not-a-virus kernel: rtw_8822ce 0000:01:00.0: firmware 
failed to leave lps state

lspci -v

01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 
802.11ac PCIe Wireless Network Adapter
Subsystem: Electronics & Telecommunications RSH Device 1e25
Physical Slot: 0
Flags: bus master, fast devsel, latency 0, IRQ 75, IOMMU group 7
I/O ports at 2000 [size=256]
Memory at c0700000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [40] Power Management version 3
Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
Capabilities: [70] Express Endpoint, MSI 00
Capabilities: [100] Advanced Error Reporting
Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-c8-22-01
Capabilities: [158] Latency Tolerance Reporting
Capabilities: [160] L1 PM Substates
Kernel driver in use: rtw_8822ce
Kernel modules: rtw88_8822ce, rtw_8822ce

