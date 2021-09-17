Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8080240F4BC
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbhIQJ1T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 05:27:19 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53688
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245601AbhIQJXN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 05:23:13 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C801402D3
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 09:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631870511;
        bh=mGGw6ukZLKbpR3e1y0DLX2b6d1cC/BxJl+N/pFsGmUQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lA1Kf7BekoPiCsfzmI6JNbPfnX8XEK77KCgv9oVaTXV+MppMPV9ZMemI57S8/dvg/
         /wp117kawHE46MBeAQq4p5VVUcLL8gkgt4kY63Bfz1xWEdjRCjy9yfr23XrqUYcKha
         q33u5TOPlhpzTgXiIKMJk7Tv17ARynezz7PwYWKcdCOIgZNQ8Vkro3S2TbnMPMyM+Q
         dh/wUCFgDK+HBWbMGGeowPxnY+bnZzqn/ykAxlhKJBBgM6oNk6+n/+36DO/aZWkzMD
         l0QVsFn2R+scqVEonWy4eAThIrulqK6vewpETZE9/06bNHYNIG5Wu3PUdGn27WWnXr
         OUaGf9nms/jdw==
Received: by mail-wr1-f69.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so3479556wrp.16
        for <linux-wireless@vger.kernel.org>; Fri, 17 Sep 2021 02:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGGw6ukZLKbpR3e1y0DLX2b6d1cC/BxJl+N/pFsGmUQ=;
        b=1gFKw1v3oXX2Lwz6MgpyY3teLxp0QZzkWcIXWmEX+jBRQHm1x+Tt6GcjuRXrjxAuaa
         GhCvxELy4rckI6uZcJGQb+B+dbvBNhpAkJUTRPeyhzrhARtHB84JDuiupDuJo8jcOCAw
         G7K6TxtTV/DkEz+wpetkDCJ/Fbc9XI3y2ZsPpaFbwRmOYgd7Vpnge1hUQ8o5V4Ed39nb
         YaI40FR7GAnt/Rl2taTBnX3P3eGftap7mjgRuZFJN90nxI3f26JfAWdLKbCIFTWnSN83
         loJND3EgWhaWRFaMJtcIcNeRmCHulgnqVaDEcIuQGmbclTVX8okJn/9V4Trn8EuIdvTT
         9XQg==
X-Gm-Message-State: AOAM531+iWoRIYrxcPgs1OL1He1t7hQ32DyXmuMO7k7jnQ2Y4QWtw78W
        BDjQ5LpDvpV64MrV6eSFN2bH+kFoNWb1CntxZWthfodlW9Ipny6ebrWYUmgJS8vwseoT1m5y/z3
        I3y+J3teXSSqMgnkraFeIxyyWnOlxFWrk5UPvYtqDB8PB
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr14025623wmp.173.1631870510857;
        Fri, 17 Sep 2021 02:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+go4PURXiY98hZcAdGcFDaAMP3qrxF8nMddc1ErptNc7UR9/cvWrqhg4uJzww7EALX/IM/Q==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr14025604wmp.173.1631870510716;
        Fri, 17 Sep 2021 02:21:50 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n3sm5921163wmi.0.2021.09.17.02.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 02:21:50 -0700 (PDT)
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
Subject: [PATCH 3/3] rt2x00: remove duplicate USB device ID
Date:   Fri, 17 Sep 2021 11:21:08 +0200
Message-Id: <20210917092108.19497-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210917092108.19497-1-krzysztof.kozlowski@canonical.com>
References: <20210917092108.19497-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The device 0x043e,0x7a32 is already on the list under
CONFIG_RT2800USB_RT55XX.  Since it is the sole Arcadyan entry in RT55xx,
assume the proper chip is RT55xx, not RT53xx, although this was not
confirmed by testing or 3rd party sources.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
index b5c67f656cfd..a3ffd1b0c9bc 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800usb.c
@@ -1101,7 +1101,6 @@ static const struct usb_device_id rt2800usb_device_table[] = {
 #ifdef CONFIG_RT2800USB_RT53XX
 	/* Arcadyan */
 	{ USB_DEVICE(0x043e, 0x7a12) },
-	{ USB_DEVICE(0x043e, 0x7a32) },
 	/* ASUS */
 	{ USB_DEVICE(0x0b05, 0x17e8) },
 	/* Azurewave */
-- 
2.30.2

