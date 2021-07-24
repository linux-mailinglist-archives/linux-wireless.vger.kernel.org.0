Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FCE3D4A43
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 23:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGXVJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 17:09:08 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58590
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229756AbhGXVJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 17:09:07 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 4E97D3F34A
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163378;
        bh=lqncaONSiNw90ZsWSl9AH9IIEf03wH8Ti3Z9kPsi5zE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=HRA3Gnoa+RlPT5s4iYQ0//vnLXwsCMTAgsCwe0RJAtpRR3Kbeu32owHXgc+aEZfAA
         WWHBL8dUverPoyPV/3Ru/Ym0PIwH2byzNfSJYPEXdH2IcS16JmKflArQhYSWIEbjU9
         tRSYyvirb03zhiAGBruCJHi9ioPjnOKEUumEy67XuZhtEQRB1iBl8TPNLhM9TSpmq8
         li7tABDEEPPtSUBnGlVmO8SAc0P/WXLcbygnvZsXBSwDJWUurOSx9ofJBE0aGCswv9
         F0A2x8CMU0R/oD0vbc27/fsaxf0AAMVHYa1RXR6XGpUbsdm2tRGUOjeff9gNLg0hJD
         YnDePwXSSJNIQ==
Received: by mail-ed1-f70.google.com with SMTP id i89-20020a50b0620000b02903b8906e05b4so2753285edd.19
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 14:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqncaONSiNw90ZsWSl9AH9IIEf03wH8Ti3Z9kPsi5zE=;
        b=rBbk6yUTOg20Zsl9DpouViBrZWi1JW69wPy4fCKiGAH7P2CV+gOscU5r957Srt8cZa
         q2yhlX3HUlo5jLmGZ4aIgbjgM/Ayfa5/vdOh5Gg6TeLT4tuXotnYV/Z44tbUuH8FjhFs
         /a5YtIO/ZqKRGQkWyAoiM20BBPdMMTa7m8hYSkbRg19xqOVCvnqrRrqUhveDAV+c48j3
         u/AKDCIF1fYYc/Or0Y2AX8BY5CFQ1UJlSmFvyqp/+ucDo7dtf6SaUqoQVUOTlhD4ZkAl
         klM4Zxu3b68m2xUrSxvKrfREttjLVe7fgdTEFKMdd57qGuHt9GlNuvCu6CRFAQ0+a2Q1
         ReMA==
X-Gm-Message-State: AOAM533X56EL/vJHZkvlC6wrGZMQw9vco5S686q9m40CB/MCDLVYigO6
        e2nd+KIGDsUPU02MwPPc+039eyYlUwfL7GgYJO2OYCn/gCpemJMhMCf/PPXm5aXU6bqp7cAApO4
        kYBjaSnO3LFufevlZth0ODULKuBzKw89ZEZudajEUKR8E
X-Received: by 2002:a50:ce45:: with SMTP id k5mr12994085edj.168.1627163378107;
        Sat, 24 Jul 2021 14:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs2MCWxVY/iIgBmUT84/VHcn/wv31k1R7oXnENH/7sKHYpMW13rHzV1X6lKvVGgvVFlM+aqQ==
X-Received: by 2002:a50:ce45:: with SMTP id k5mr12994078edj.168.1627163378020;
        Sat, 24 Jul 2021 14:49:38 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id s10sm12821908ejc.39.2021.07.24.14.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:49:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 06/12] nfc: st21nfca: constify file-scope arrays
Date:   Sat, 24 Jul 2021 23:49:22 +0200
Message-Id: <20210724214928.122096-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver only reads len_seq and wait_tab variables.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/st21nfca/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 9dc9693a7356..1b44a37a71aa 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -76,8 +76,8 @@ struct st21nfca_i2c_phy {
 	struct mutex phy_lock;
 };
 
-static u8 len_seq[] = { 16, 24, 12, 29 };
-static u16 wait_tab[] = { 2, 3, 5, 15, 20, 40};
+static const u8 len_seq[] = { 16, 24, 12, 29 };
+static const u16 wait_tab[] = { 2, 3, 5, 15, 20, 40};
 
 #define I2C_DUMP_SKB(info, skb)					\
 do {								\
-- 
2.27.0

