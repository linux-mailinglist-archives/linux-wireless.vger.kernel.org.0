Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86457A0FB1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 23:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjINVTq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjINVTq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 17:19:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F059C26B2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 14:19:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500c7796d8eso2442042e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anddroptable-net.20230601.gappssmtp.com; s=20230601; t=1694726380; x=1695331180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GmeDygi6P+otcVeWJIKtkqvRgPk3UKmKclKJWw6A3lo=;
        b=CM7SJWNLmfAb0d3ApH9GEZFUnm0SjRosO83vXLIxjjQ+9KzAFjV/4L8unipTRDJDy/
         STp+dJwwTq1rp9HNeTSahGTtHyiirzGjt1fKzKnAF/MeBN3qscBSBhV1d/Wo9raBb5DN
         W6X/PJjH1b86/8VxHe6k5zJtLAHGLfgMVz5Lev76Tbbxf6PajptM28n8iWer0kgN5G3d
         WDj25quZUAU9F501P6oNMckTDkU9yun8chXAGXgwP1WPKS8cXLW4VRh3ctfHTHvxVVwR
         p+9/WakTeRnvRJpFGH9HuZcjIGfNQA0cP/+AX+Zd21DJs5bLXcjyXaphbcJLGTAeibkR
         c9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726380; x=1695331180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmeDygi6P+otcVeWJIKtkqvRgPk3UKmKclKJWw6A3lo=;
        b=bYUR15CPzipaEESF1naZySGvNWT0SQf+USBe4qa5QTOdOmiZPrMtQDa2K9WPzDZAIo
         QzdiHFuOPhk5ABZKZgxZL4V9QUT83YuPg4wbjBXqxW5LbcC6MLHe3mqNSZ1+UU0vjl/6
         q1A3w47le7B6bAeYogPChhopDOXtOU/+CtZeSxx61a1AuYJJcZXQdxiD/TSG7rM3FOAf
         aHLa7MqcA221Hqg+LYHD4TXcB22dXSz4fyzwxYeXjOEz+FbWB6ubaO9bGHvkhXGIMJFp
         3ya6BXYjhiMNLV5f/gpaSmgiOs4F1XChIS54gj/2hn4aKZyF40QukX0r0HbVz/WzxMll
         45xw==
X-Gm-Message-State: AOJu0YzYSHgEjxQHfs79JJZGEPNC06FK4CuMt9ETdCP1/eqDktn4YMsw
        JkFA6XcvNmDL4obYLxv6n1jiEVZ++Le97azVWFHeXg==
X-Google-Smtp-Source: AGHT+IGd+rT0vZ0PuLQcGzBposFdwjdH2lXiU3qV8DtvtskIOQANIy9Vn9sDC5gcCYO2dHnB9yzkfQ==
X-Received: by 2002:a05:6512:20c9:b0:4ff:7e80:4f1d with SMTP id u9-20020a05651220c900b004ff7e804f1dmr5025512lfr.57.1694726379762;
        Thu, 14 Sep 2023 14:19:39 -0700 (PDT)
Received: from congrafica.. ([2001:2003:f119:1700:43a7:7a73:ceab:9e00])
        by smtp.gmail.com with ESMTPSA id x2-20020ac259c2000000b004ffa0e5d805sm408264lfn.174.2023.09.14.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 14:19:39 -0700 (PDT)
From:   =?UTF-8?q?V=C3=ADctor=20Gonzalo?= <victor.gonzalo@anddroptable.net>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADctor=20Gonzalo?= <victor.gonzalo@anddroptable.net>
Subject: [PATCH] wifi: mwifiex: use MODULE_FIRMWARE to add firmware files metadata
Date:   Fri, 15 Sep 2023 00:19:38 +0300
Message-Id: <20230914211938.28395-1-victor.gonzalo@anddroptable.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The mwifiex_pcie driver is missing the MODULE_FIRMWARE macro to
add the firmware files needed to the module metadata.

Signed-off-by: Víctor Gonzalo <victor.gonzalo@anddroptable.net>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 6697132ecc97..cd464453d5db 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -3449,3 +3449,9 @@ MODULE_AUTHOR("Marvell International Ltd.");
 MODULE_DESCRIPTION("Marvell WiFi-Ex PCI-Express Driver version " PCIE_VERSION);
 MODULE_VERSION(PCIE_VERSION);
 MODULE_LICENSE("GPL v2");
+MODULE_FIRMWARE(PCIE8766_DEFAULT_FW_NAME);
+MODULE_FIRMWARE(PCIE8897_DEFAULT_FW_NAME);
+MODULE_FIRMWARE(PCIE8897_A0_FW_NAME);
+MODULE_FIRMWARE(PCIE8897_B0_FW_NAME);
+MODULE_FIRMWARE(PCIEUART8997_FW_NAME_V4);
+MODULE_FIRMWARE(PCIEUSB8997_FW_NAME_V4);
-- 
2.34.1

