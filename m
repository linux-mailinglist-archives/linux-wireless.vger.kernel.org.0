Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85740F4B7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 11:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbhIQJZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 05:25:41 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53634
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240833AbhIQJXL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 05:23:11 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7ACB0402D0
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870508;
        bh=o7vBhR0EpCJ0RBAVx7tRojMJZmGtoI7hI2etAgBdAnA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LzLZlHt+ACbfnQcE8DbTwo40+/rxRFJ250ENwtgsoMVY3IUpakGi2eMqBMP5Jvzp0
         /VuGB3SQAFoTxe9bjpMj93vZj0zetH49tfPuo7UVN1qVG7fTUm3+BiQF8nAA5Kqmix
         BGXI0S+/dRUXZBb0v1PBRYE2OdKD5HCHeV0tiyvbuyj/Ch+N1BCWkhTuKrK1ZLkBKa
         /mCgwEPoc8DW6pK6FDrpwre47EXZ3ubdmkSkHJU0DYVONu2YUZJ3aTq0YzWt9cqJQk
         NOuMRaQBMCAAmNQuEw5tPqCOe57/zopifYiw7tLepxTdahH9S1sp4aJRSFo/k3Rixp
         z2YEMg10KDNWA==
Received: by mail-wm1-f72.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so1606207wmj.6
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 02:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o7vBhR0EpCJ0RBAVx7tRojMJZmGtoI7hI2etAgBdAnA=;
        b=SZZs6nT3nAOy7ffE3cM0OIRRVMO9CS0+pXs9/xTw81nrlASmDUs7VfgfsOKaU0iqY2
         WoJ+nYlZHRWa8PRKBE4mlVCN3Tm7CF20yw8+kW+1xV4DxBb9X8Kb3okj9sxqCXh5oNnS
         k074D7VW25gI1Vv6C12P48m29TWqQd2sjPixBg8Ccp6/57onm7qSdesag17tG3V5K6pr
         gqdn1dB2RYEluirF8oot8lMysAzquDw+ICAAW/xa2ClYMm977U95q/2LeQgtUhEvU7xX
         DvfhdbQ6l2IJ0T0zSt1VgRUuL/w5KHAPoPG6KunNLBXa7dsnuSTnFynyGLqRs17nvDCB
         gKKQ==
X-Gm-Message-State: AOAM532ScnenNMQZVV8kStMzgq+TrxxcgUOSiM8+sqfvtc60v9u+dpNn
        1Fu3xruK1IP9cCPPZXamLIy2ErlQaOySGF1T9L3CLDuxm+BHuBkWCuzSav0zl4NFujOCmIQHJoS
        5U9Urloegx3jvOGkouEzRjygAbJ19Mn4dH1FitAX9f3T9
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr14328394wmc.3.1631870508059;
        Fri, 17 Sep 2021 02:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSh7nZCh0xloMemj03rh/x1IOY4KIeubxmM6VRIwneWeSzjscQX4mH7jZn/VoYdck4c9qCIw==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr14328373wmc.3.1631870507862;
        Fri, 17 Sep 2021 02:21:47 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm5921163wmi.0.2021.09.17.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:21:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Pontus Fuchs <pontus.fuchs@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zd1211-devs@lists.sourceforge.net
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/3] zd1211rw: remove duplicate USB device ID
Date:   Fri, 17 Sep 2021 11:21:06 +0200
Message-Id: <20210917092108.19497-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The device 0x07b8,0x6001 is already on the list as zd1211 chip. Wiki
https://wireless.wiki.kernel.org/en/users/Drivers/zd1211rw/devices
confirms it is also zd1211, not the zd1211b.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index a7ceef10bf6a..850c26bc9524 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -65,7 +65,6 @@ static const struct usb_device_id usb_ids[] = {
 	{ USB_DEVICE(0x0586, 0x3412), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x0586, 0x3413), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x079b, 0x0062), .driver_info = DEVICE_ZD1211B },
-	{ USB_DEVICE(0x07b8, 0x6001), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x07fa, 0x1196), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x083a, 0x4505), .driver_info = DEVICE_ZD1211B },
 	{ USB_DEVICE(0x083a, 0xe501), .driver_info = DEVICE_ZD1211B },
-- 
2.30.2

