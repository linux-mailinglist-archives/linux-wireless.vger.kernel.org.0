Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE7500E0E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 14:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiDNMxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbiDNMwo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 08:52:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D33BBDA
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 05:50:18 -0700 (PDT)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E2A83F320
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649940617;
        bh=bTCDWQhb/1DFg7xNAlf4FlZ/NVtJhvcaYxbzMFY3GtY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CO/kC47YOLdDklqbMjSKNSCnq5PxyPWxeYXJEu4oE+xRTvwTM+EY6irLi9wlCFJ8w
         iRT3h/nPub7R51bbBI8wqgIJiJuprOpn7HpPsI5oAymtyzEnv+9DUGQa1w9aclVMBE
         sPtM6lt/va3yxHeQYEzfrrnQd57kWIcP3u4HhlgUOGG3mWuehXVMjKROMpi//hyKZH
         ygeR886bZlgbZjRYCKP4g2xtZku0toQ+amZJirJVqNPoexwjOCXY/6LHzqav3EVd4P
         z1aUnAM9+is5Y8RXHOjvSnHYYWTHauKV0QlyEFbEthIG3V1X8agv0eTjWgSZArPAdd
         TXE4m3eF4EpOw==
Received: by mail-wm1-f70.google.com with SMTP id n37-20020a05600c502500b0038fdc1394c6so1765949wmr.6
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 05:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTCDWQhb/1DFg7xNAlf4FlZ/NVtJhvcaYxbzMFY3GtY=;
        b=AO47X/oKmXMeRE3CLTqwOlcDoeXmcpz7DYHle3A1S97s8UxvpYkaz2Xx36Qqg7K6ca
         1zSbMCMqZOhVx45TobGTyGCYjyU/J9QaOpA9Vw8JEw4O4QYcS3qYZRMK8uuo4Uo9PVQN
         h5VHxrRTOnIQh2Osq9aU1rYrRn6TEBdDCFe/tjqlJqbup/t+TMiOpV8cqFRL2XY2c4ns
         NgSjKiq0uZ1DR1mJhevqgO0wBRgt4b89LE7K9r+7RbZixBVtfDTjyZN7Q3CmY7yetynh
         r393N/gamBV9KloaR/DZ0eL3JOvUncq/KmUwi00R2HeEDxZ/boC6vwLtjAozsq9CCcoq
         uTdg==
X-Gm-Message-State: AOAM530RMY4C6SBf5ayDhyCLoAAGk6CjWF9qqT6i5yJVmTxYQdlENXS9
        ht6c4+mQOW6yuTIvCm2+f7qJnkUOaoOPSZ3dhgCwD0u9UglvVLwIV3bw1FTX0Kus2SkPXWpVxEZ
        e0k/aTR+/PrY/XWob9AQedI3C1kZKIqXBgEiPQqRaOrJX
X-Received: by 2002:a05:6000:1c3:b0:207:9dba:1e67 with SMTP id t3-20020a05600001c300b002079dba1e67mr2046601wrx.53.1649940616440;
        Thu, 14 Apr 2022 05:50:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBr7ainIS4hSDxZB3IehkNUt6QxAAGHI1dLSyiZ/1zGA/soh/hPDwFI4TjU4Y0E3Ki0LjRgg==
X-Received: by 2002:a05:6000:1c3:b0:207:9dba:1e67 with SMTP id t3-20020a05600001c300b002079dba1e67mr2046583wrx.53.1649940616219;
        Thu, 14 Apr 2022 05:50:16 -0700 (PDT)
Received: from localhost ([2001:67c:1562:8007::aac:415c])
        by smtp.gmail.com with ESMTPSA id w7-20020a1cf607000000b00389a5390180sm1974415wmc.25.2022.04.14.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:50:15 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cfg80211: declare MODULE_FIRMWARE for regulatory.db
Date:   Thu, 14 Apr 2022 13:50:03 +0100
Message-Id: <20220414125004.267819-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add MODULE_FIRMWARE declarations for regulatory.db and
regulatory.db.p7s such that userspace tooling can discover and include
these files.

Cc: stable@vger.kernel.org
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 net/wireless/reg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 795e86b371..54c13ea7d9 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -806,6 +806,8 @@ static int __init load_builtin_regdb_keys(void)
 	return 0;
 }
 
+MODULE_FIRMWARE("regulatory.db.p7s");
+
 static bool regdb_has_valid_signature(const u8 *data, unsigned int size)
 {
 	const struct firmware *sig;
@@ -1077,6 +1079,8 @@ static void regdb_fw_cb(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }
 
+MODULE_FIRMWARE("regulatory.db");
+
 static int query_regdb_file(const char *alpha2)
 {
 	ASSERT_RTNL();
-- 
2.32.0

