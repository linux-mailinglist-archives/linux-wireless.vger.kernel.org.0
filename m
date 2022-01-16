Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977AC48FBC8
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 09:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiAPIrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 03:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPIrd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 03:47:33 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF520C061574
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 00:47:32 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id k14so13732090ion.7
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oTGeSoes78zP7shp6LveGwbQrpDtC4g9grgpUeJMQFA=;
        b=LFCTxHHLWu8HbX1chrUiiGs1YwwsQndp8B4L8FUo390NXB1tp3YjiQtxOsjXD9TpzH
         CGBAra+D4UL7bildOWQi57/g05Tp3nMaJ9KGzD8QRecIqBhZK3C3HWHkWO854TcqmKU9
         CNgiTmDxJ0l/IElLPOQl+rWqnrG74D8IoaKF/acx/umZCEHJp7i7/9+zN3Ljf/9Pv7wC
         zeKi0F+a/Wsb+JRwqC5V8fl9x9DS+qWDdcRquAyE+W2dL6EdMueDIuJ8k2/eI9IBao2i
         RlxWZhL3Q/KrI/CAaDyHM6WPsoLUSS4xzGJz8sbZcP6IYA+WbXVevxTGAkB5a2h7Ks0a
         MHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oTGeSoes78zP7shp6LveGwbQrpDtC4g9grgpUeJMQFA=;
        b=DeX82w3O1uXGozMgzoyug9vpkEkZnD+lNMXSdqAKc+UWP42aJkKKqCWjTy882RW509
         iCD6QdYzmYafag4asQXq4QfM6Tu4cY3pEFaQ/3b/m1Bxn85NtZa4ckTWiw66TYL5FwLn
         p0z+VoXkxWtN4b4OibfM/q7AB2cuadzeN8Cl6E5R07EWG4wDm251R9p6u4QvC0FuR/vT
         +kE08XkoL+coNvo75ozI6rpCbHK77fVOnjFzJNecbgsx4La+Rx32dt7jOp6BGYBOfaag
         NHBzZd8n5Laz6yRmXvC9zj4xt/+yhmAlbYOJY6ghWcfL7Vw9rpNLyKdICkyp0hNZ0jgl
         /aaw==
X-Gm-Message-State: AOAM530Px4d6GKiq77ccOG4mx7/I8koR+g/W4MaYvDv/Zg1Ks/St2S0/
        HZ9o6VniUb2SXC1b2f6MwJF3IMdGDA8eCRCn4ydUal+EgRy4
X-Google-Smtp-Source: ABdhPJw6dQ/U92+CUXXys2gsIpF6CGkCvvBWKIU3IZKdCTq0nmPyQume5FI+ZC3xY0lt9bG7hDbG57fuPXcCZ8zrqTY=
X-Received: by 2002:a05:6638:72a:: with SMTP id j10mr6865209jad.187.1642322852137;
 Sun, 16 Jan 2022 00:47:32 -0800 (PST)
MIME-Version: 1.0
From:   Roman Evstifeev <someuniquename@gmail.com>
Date:   Sun, 16 Jan 2022 11:47:21 +0300
Message-ID: <CAMX-vmLhO950cqJ_QC2rREGbJojbFvYygrfo+8=O-2CMUuFquw@mail.gmail.com>
Subject: [BUG] Realtek dmesg flood: rtw_8822ce firmware failed to leave lps state
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reproducible by at least 2 people, as reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=215496 and here:
https://github.com/lwfinger/rtw88/issues/61

When laptop charger is not connected, dmesg is flooded with errors
from realtek driver

Dmesg log init:
[    3.516129] rtw_8822ce 0000:04:00.0: enabling device (0000 -> 0003)
[    3.523097] rtw_8822ce 0000:04:00.0: Firmware version 9.9.4, H2C version 15
[    3.530951] rtw_8822ce 0000:04:00.0: Firmware version 9.9.10, H2C version 15
[    3.999011] rtw_8822ce 0000:04:00.0 wlp4s0: renamed from wlan0
[    5.324088] rtw_8822ce 0000:04:00.0: start vif dc:e9:94:7e:5f:85 on port 0
[    5.325431] rtw_8822ce 0000:04:00.0: stop vif dc:e9:94:7e:5f:85 on port 0
[    5.561473] rtw_8822ce 0000:04:00.0: start vif ee:c7:7c:0e:6b:3c on port 0
[    9.847260] rtw_8822ce 0000:04:00.0: stop vif ee:c7:7c:0e:6b:3c on port 0
[   10.085443] rtw_8822ce 0000:04:00.0: start vif dc:e9:94:7e:5f:85 on port 0
[   14.738024] rtw_8822ce 0000:04:00.0: sta 10:fe:ed:51:2a:94 joined
with macid 0

Repeated messages are:
[   49.030634] rtw_8822ce 0000:04:00.0: firmware failed to leave lps state
[   49.033828] rtw_8822ce 0000:04:00.0: failed to send h2c command
[   49.036994] rtw_8822ce 0000:04:00.0: failed to send h2c command

1) I connected the charger. The "firmware failed to leave lps state"
message stopped to appear, but the "failed to send h2c command"
message still continuously flooded my dmesg
2) I put laptop to sleep, then wake up. Message flood stopped.
3) I disconnected the charger, and after a few minutes messages
started to come in again.


lspci:
04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE
802.11ac PCIe Wireless Network Adapter
        Subsystem: Lenovo Device c123
        Flags: bus master, fast devsel, latency 0, IRQ 79, IOMMU group 12
        I/O ports at 2000 [size=256]
        Memory at c3600000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-c8-22-01
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
        Kernel driver in use: rtw_8822ce
        Kernel modules: rtw88_8822ce
