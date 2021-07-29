Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F5E3DA149
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhG2Kkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 06:40:51 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:34534
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236224AbhG2Kkr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 06:40:47 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 5B0063F224
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 10:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627555243;
        bh=KXmULC4yNLbjXfZilnwZUymI+qeRnrLMQ/vMczDuSm8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FjHwBMnKcyKdPC27zPWz3DoMtR3VOrhaGR2XO58hHDUJeciLFNhdhj3Hnt6IrgWQ6
         vpSbslqTwxHjDmcQ3izfnhwWo1kEd+tGQp+TiK2PF5y5ZS5H2m/gWQ/FLmKGCZKXiL
         wZZsW5VdkBYycNd4JNwvdWfXV28wgkeU9y+w+4QyHnqZFSt8LVNIdpLqw9X7vR/+GQ
         QrsbRqjUnCsmZKipnWuM39cwmk+rzasEJ4IBAKeEhmcTWoT4O81/ctqUvBFCAwDOYw
         tFZmJKY3NVNGNmyhwYa6Dv4BUSj/H+oRF0F6hXVt9I1DKN0PqjRi7mBZ8v6cIpqMgx
         exYBmQLvbybYQ==
Received: by mail-ej1-f72.google.com with SMTP id a19-20020a1709063e93b0290551ea218ea2so1842575ejj.5
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jul 2021 03:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXmULC4yNLbjXfZilnwZUymI+qeRnrLMQ/vMczDuSm8=;
        b=eVXiStkiArbdEGiFEaUG9mMELaodGnsgDoLlnFr0lGakjnW7CRo7yRmGo9wzKMlGFv
         FSk9BovShhLTm4k4P6pKaTAIkHfUL9AtrS8Q11KUSzyawx3dhzy55BZIIpR1TgVNH+E1
         +MrlrMiefGokCbEgovSLKVP4ezbg4IgaJ4uMWhnmxCnoQy9FXNdRCyXGQh7aiPhnsSEp
         df+oBTJFufZOq5keCu8VXycfpuNvWjSDgv5nyt2uQJYhgJNVyRVJWvA61SuztmORanAL
         qrdY1797xhGlvkUSJGF7LGIGn7EMppbJgS/wHhYQfaPqthNQA+ac4ydvChuu6n9X31lf
         E90Q==
X-Gm-Message-State: AOAM5338wWGvH2nrkNMjLpsEg90ZbxgrcPzhttBLB/kwXwM+kVM51mbZ
        C3Zf1gQ2mYqu2njJvQZp7L/DH812BbGi4TGuHwID+920HmIVegDdDDBgPhUybesUDGSB31z4HGO
        JLVTr0nuTpx5aNFH8KauZDEHIfrTB/mvQvcyTrBRcqf8/
X-Received: by 2002:a05:6402:1cb6:: with SMTP id cz22mr5180754edb.148.1627555242546;
        Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjW5Qyti3uGsJQhjyg9e0Vg9hnF5ajD1dE9uX/LfyH7AIvIxTCmpWZpCLut6Hz/YpkiUBGxg==
X-Received: by 2002:a05:6402:1cb6:: with SMTP id cz22mr5180746edb.148.1627555242430;
        Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id c14sm824475ejb.78.2021.07.29.03.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:40:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 07/12] nfc: fdp: drop unneeded cast for printing firmware size in dev_dbg()
Date:   Thu, 29 Jul 2021 12:40:17 +0200
Message-Id: <20210729104022.47761-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
References: <20210729104022.47761-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Size of firmware is a type of size_t, so print it directly instead of
casting to int.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/fdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/fdp/fdp.c b/drivers/nfc/fdp/fdp.c
index 3e542b7389cb..650a140bea46 100644
--- a/drivers/nfc/fdp/fdp.c
+++ b/drivers/nfc/fdp/fdp.c
@@ -276,8 +276,8 @@ static int fdp_nci_request_firmware(struct nci_dev *ndev)
 		(data[FDP_FW_HEADER_SIZE + 2] << 16) |
 		(data[FDP_FW_HEADER_SIZE + 3] << 24);
 
-	dev_dbg(dev, "RAM patch version: %d, size: %d\n",
-		  info->ram_patch_version, (int) info->ram_patch->size);
+	dev_dbg(dev, "RAM patch version: %d, size: %zu\n",
+		  info->ram_patch_version, info->ram_patch->size);
 
 
 	r = request_firmware(&info->otp_patch, FDP_OTP_PATCH_NAME, dev);
@@ -293,8 +293,8 @@ static int fdp_nci_request_firmware(struct nci_dev *ndev)
 		(data[FDP_FW_HEADER_SIZE+2] << 16) |
 		(data[FDP_FW_HEADER_SIZE+3] << 24);
 
-	dev_dbg(dev, "OTP patch version: %d, size: %d\n",
-		 info->otp_patch_version, (int) info->otp_patch->size);
+	dev_dbg(dev, "OTP patch version: %d, size: %zu\n",
+		 info->otp_patch_version, info->otp_patch->size);
 	return 0;
 }
 
-- 
2.27.0

